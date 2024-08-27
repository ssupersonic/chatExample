
import SwiftUI

struct MessageView: View {
    var message: MessageModel
    
    var body: some View {
        if message.type == .input {
            HStack {
                HStack {
                    Text(message.text)
                        .padding()
                        .background(Color(uiColor: .systemGray5))
                        .cornerRadius(20)
                }
                .frame(maxWidth: 260, alignment: .leading)
            }
            .frame(maxWidth: 360, alignment: .leading)
        } else {
            HStack {
                HStack {
                    Text(message.text)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(20)
                }
                .frame(maxWidth: 250, alignment: .trailing)
            }
            .frame(maxWidth: 360, alignment: .trailing)
        }
        
    }
}

#Preview {
    MessageView(message: MessageModel(text: "Hello! This is my message", type: .output))
}
