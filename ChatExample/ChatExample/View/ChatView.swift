
import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    @State private var text = ""
    @State private var autoScrollEnabled = true
    @State private var scrollID: Int?
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { scrollView in
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(Array(viewModel.messages.enumerated()), id: \.element) { index, message in
                                MessageView(message: message)
                                    .id(index)
                            }
                        }
                        .scrollTargetLayout()
                        .onChange(of: viewModel.messages) {
                            if autoScrollEnabled {
                                withAnimation {
                                    scrollView.scrollTo(viewModel.messages.count - 1, anchor: .bottom)
                                }
                            }
                        }
                    }
                    .scrollPosition(id: $scrollID, anchor: .bottom)
                    .scrollIndicators(.hidden)
                    .gesture(
                        DragGesture().onChanged { _ in
                            autoScrollEnabled = false
                        }
                    )
                    .onChange(of: scrollID) { oldValue, newValue in
                        autoScrollEnabled = newValue == viewModel.messages.count - 1
                    }
                }
                
                HStack() {
                    TextField("Message", text: $text, axis: .vertical)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: sendMessage) {
                        Text("Send")
                    }
                    .padding()
                }
                .background(Color(uiColor: .systemGray5))
            }
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.endEditing(true)
            }
        }
    }
    
    func sendMessage() {
        let trimmedText = text.trimmWhitespaces
        if trimmedText.count >= 1 {
            viewModel.send(trimmedText)
            text = ""
            autoScrollEnabled = true
        }
    }
}

#Preview {
    ChatView()
}
