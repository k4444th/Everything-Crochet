import SwiftUI

struct WrittenPatternView: View {
    
    @State var newText: String = ""
    @Binding var text: String
    
    @FocusState var textFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Pattern:").font(.title2).padding(.vertical, 8)
                
                Spacer()
                
                if textFocused {
                    if text == newText {
                        Button{
                            textFocused = false
                            text = newText
                        } label: {
                            Text("Save") .padding(12) .tint(Color.accent) .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.lighter)
                            )
                        }
                    }
                    else {
                        Button{
                            textFocused = false
                            text = newText
                        } label: {
                            Text("Save") .padding(12) .tint(Color.lighter) .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.appSecondary)
                            )
                        }
                    }
                }
            }
            TextField("Start creating your new pattern here...", text: $newText,  axis: .vertical)
                .lineLimit(10...50) .focused($textFocused)
            
            Spacer()
        } .onAppear { newText = text }
    }
}

#Preview {
    WrittenPatternView(text: .constant(""))
}
