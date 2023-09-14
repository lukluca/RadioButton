import SwiftUI

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 14.0, *)
public typealias RadioButtonRepresentable = CaseIterable & Hashable & Identifiable

@available(macOS 10.15, iOS 14.0, watchOS 6.0, tvOS 14.0, *)
public struct RadioButton<S, Label, R>: View where S : StringProtocol,
                                                   Label : View,
                                                   R : RadioButtonRepresentable,
                                                   R.AllCases : RandomAccessCollection  {
    
    let title: S
    @ViewBuilder let label: (R) -> Label
    
    @Binding var isSelected: R
    
    public init(title: S,
                isSelected: Binding<R>,
                @ViewBuilder label: @escaping (R) -> Label) {
        self.title = title
        self.label = label
        self._isSelected = isSelected
    }

    public var body: some View {
        ContentView(title: title, label: label, isSelected: $isSelected)
    }
}

extension RadioButton where Label == Text {
    public init<I>(title: S,
                   itemTitle: KeyPath<R, I>,
                   isSelected: Binding<R>) where I : StringProtocol {
        self.title = title
        label = {
            Text($0[keyPath: itemTitle])
        }
        self._isSelected = isSelected
    }
}

#if os(macOS) || os(watchOS)

@available(macOS 10.15, watchOS 6.0, *)
struct ContentView<S, Label, R>: View where S : StringProtocol,
                                            Label : View,
                                            R : RadioButtonRepresentable,
                                            R.AllCases : RandomAccessCollection  {
    
    let title: S
    @ViewBuilder let label: (R) -> Label
    
    @Binding var isSelected: R
    
    var body: some View {
        Picker(title, selection: $isSelected) {
            ForEach(R.allCases) {
                label($0)
                    .tag($0)
            }
        }
        .pickerStyle(.radioGroup)
    }
}

#elseif os(iOS) || os(tvOS)

@available(iOS 14.0, tvOS 14.0, *)
struct ContentView<S, Label, R>: View where S : StringProtocol,
                                            Label : View,
                                            R : RadioButtonRepresentable,
                                            R.AllCases : RandomAccessCollection  {
    
    let title: S
    @ViewBuilder let label: (R) -> Label
    
    @Binding var isSelected: R
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
            
            VStack(alignment: .leading) {
                ForEach(R.allCases) {
                    ContentView.Item(item: $0,
                                     label: label)
                        .tag($0)
                }
            }
           
        }
    }
}

@available(iOS 14.0, tvOS 14.0, *)
extension ContentView {
    struct Item<S, Label>: View where S : StringProtocol,
                                      Label : View {
        
        @State private var isChecked = false
        
        let item: R
        @ViewBuilder let label: (R) -> Label
        
        @Binding var checked: R
        
        var body: some View {
            HStack {
                if isChecked {
                    Button {}
                        label: {
                            Checked()
                        }
                } else {
                    Button {
                        isChecked = true
                    } label: {
                       Unchecked()
                    }
                }
                
                label(item)
            }
            .onAppear {
                isChecked = checked == item
            }
            .onChange(of: isChecked) { newValue in
                if newValue {
                    checked = item
                }
            }
            .onChange(of: checked) { newValue in
                if checked != item {
                    isChecked = false
                }
            }
        }
    }
}

@available(iOS 14.0, tvOS 14.0, *)
extension ContentView.Item {
    struct Unchecked: View {
        var body: some View {
            Circle()
                .fill(Color.white)
                .frame(width: 20, height: 20)
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
        }
    }
    
    struct Checked: View {
        var body: some View {
            ZStack{
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                Circle()
                    .fill(Color.white)
                    .frame(width: 8, height: 8)
            }
        }
    }
}

#endif
