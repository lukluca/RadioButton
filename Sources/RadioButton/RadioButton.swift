import SwiftUI

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 14.0, *)
public typealias RadioButtonRepresentable = CaseIterable & Hashable & Identifiable

@available(macOS 10.15, iOS 14.0, watchOS 6.0, tvOS 14.0, *)
public struct RadioButton<S, Label, R>: View where S : StringProtocol,
                                                   Label : View,
                                                   R : RadioButtonRepresentable,
                                                   R.AllCases : RandomAccessCollection  {
    
    let alignment: Alignment
    let title: S
    @ViewBuilder let label: (R) -> Label
    
    @Binding var isSelected: R
    
    public init(alignment: Alignment = .vertical,
                title: S,
                isSelected: Binding<R>,
                @ViewBuilder label: @escaping (R) -> Label) {
        self.alignment = alignment
        self.title = title
        self.label = label
        self._isSelected = isSelected
    }

    public var body: some View {
        ContentView(alignment: alignment,
                    title: title,
                    label: label,
                    isSelected: $isSelected)
    }
}

@available(macOS 10.15, iOS 14.0, watchOS 6.0, tvOS 14.0, *)
extension RadioButton where Label == Text {
    public init<I>(alignment: Alignment = .vertical,
                   title: S,
                   itemTitle: KeyPath<R, I>,
                   isSelected: Binding<R>) where I : StringProtocol {
        self.alignment = alignment
        self.title = title
        label = {
            Text($0[keyPath: itemTitle])
        }
        self._isSelected = isSelected
    }
}

@available(macOS 10.15, iOS 14.0, watchOS 6.0, tvOS 14.0, *)
extension RadioButton {
    public typealias Alignment = RadioButtonAlignment
}

@available(macOS 10.15, iOS 14.0, watchOS 6.0, tvOS 14.0, *)
public enum RadioButtonAlignment {
    case vertical
    case horizontal
}

#if os(macOS)

@available(macOS 10.15, *)
struct ContentView<S, Label, R>: View where S : StringProtocol,
                                            Label : View,
                                            R : RadioButtonRepresentable,
                                            R.AllCases : RandomAccessCollection  {
    
    let alignment: Alignment
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
        .radioButtonAlignment(alignment)
    }
}

#elseif os(iOS) || os(tvOS) || os(watchOS)

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
struct ContentView<S, Label, R>: View where S : StringProtocol,
                                            Label : View,
                                            R : RadioButtonRepresentable,
                                            R.AllCases : RandomAccessCollection  {
    
    let title: S
    let alignment: Alignment
    @ViewBuilder let label: (R) -> Label
    
    @Binding var isSelected: R
    
    var body: some View {
        HStack(alignment: .top) {
            
            Text(title)
            
            switch alignment {
            case .vertical:
                VStack(alignment: .leading) {
                    ContentView.Items(label: label,
                                      checked: $isSelected)
                }
            case .horizontal:
                HStack {
                    ContentView.Items(label: label,
                                      checked: $isSelected)
                }
            }
        }
    }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension ContentView {
    struct Items<Label, R>: View where Label : View,
                                       R : RadioButtonRepresentable,
                                       R.AllCases : RandomAccessCollection {
        
        @ViewBuilder let label: (R) -> Label
        
        @Binding var isSelected: R
        
        var body: some View {
            ForEach(R.allCases) {
                ContentView.Items.Item(item: $0,
                                       label: label,
                                       checked: $isSelected)
                    .tag($0)
            }
        }
    }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension ContentView.Items {
    struct Item<Label>: View where Label : View {
        
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

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
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

@available(macOS 10.15, iOS 14.0, watchOS 6.0, tvOS 14.0, *)
extension ContentView {
    typealias Alignment = RadioButtonAlignment
}

#if os(macOS)

@available(macOS 10.15, *)
extension View {
    func radioButtonAlignment(_ alignment: RadioButtonAlignment) -> some View {
        modifier(RadioButtonAlignmentModifier(alignment: alignment))
    }
}

@available(macOS 10.15, *)
struct RadioButtonAlignmentModifier: ViewModifier {
    
    let alignment: RadioButtonAlignment
    
    func body(content: Content) -> some View {
        switch alignment {
        case .vertical:
            content
        case .horizontal:
            content.horizontalRadioGroupLayout()
        }
    }
}

#elseif os(iOS) || os(tvOS) || os(watchOS)

#endif
