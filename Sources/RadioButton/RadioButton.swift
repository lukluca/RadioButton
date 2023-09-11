import SwiftUI

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 16.0, *)
public typealias RadioButtonRepresentable = CaseIterable & Hashable & Identifiable

@available(macOS 10.15, iOS 14.0, watchOS 6.0, tvOS 16.0, *)
public struct RadioButton<S, I, R>: View where S: StringProtocol,
                                        I: StringProtocol,
                                     R: RadioButtonRepresentable,
                                               R.AllCases: RandomAccessCollection  {
    
    let title: S
    let itemTitle: KeyPath<R, I>
  
    @Binding var isSelected: R
    
    public init(title: S,
                itemTitle: KeyPath<R, I>,
                isSelected: Binding<R>) {
        self.title = title
        self.itemTitle = itemTitle
        self._isSelected = isSelected
    }
    
    public var body: some View {
        ContentView(title: title, itemTitle: itemTitle, isSelected: $isSelected)
    }
}

#if os(macOS) || os(watchOS)

@available(macOS 10.15, watchOS 6.0, *)
struct ContentView<S, I, R>: View where S: StringProtocol,
                                        I: StringProtocol,
                                     R: RadioButtonRepresentable,
                                    R.AllCases: RandomAccessCollection  {
    
    let title: S
    let itemTitle: KeyPath<R, I>
  
    @Binding var isSelected: R
    
    var body: some View {
        Picker(title, selection: $isSelected) {
            ForEach(R.allCases) {
                Text($0[keyPath: itemTitle]).tag($0)
            }
        }
        .pickerStyle(.radioGroup)
    }
}
#elseif os(iOS) || os(tvOS)
@available(iOS 14.0, tvOS 16.0, *)
struct ContentView<S, I, R>: View where S: StringProtocol,
                                        I: StringProtocol,
                                     R: RadioButtonRepresentable,
                                    R.AllCases: RandomAccessCollection  {
    
    let title: S
    let itemTitle: KeyPath<R, I>
  
    @Binding var isSelected: R
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
            
            VStack(alignment: .leading) {
                ForEach(R.allCases) {
                    Item(item: $0,
                         title: itemTitle,
                         checked: $isSelected)
                    .tag($0)
                }
            }
           
        }
    }
}

@available(iOS 14.0, tvOS 16.0, *)
extension ContentView {
    struct Item<S, R>: View where S: StringProtocol, R: Hashable {
        
        @State private var isChecked = false
        
        let item: R
        let title: KeyPath<R, S>
        
        @Binding var checked: R
        
        var body: some View {
            HStack {
                if isChecked {
                    ZStack{
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 8, height: 8)
                    }
                } else {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .onTapGesture {
                            isChecked = true
                        }
                }
                
                Text(item[keyPath: title])
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
#endif
