
import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages = [MessageModel]()
    private var messageGenerator: MessageGeneratorService?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        messageGenerator = MessageGeneratorService()
        messageGenerator?.messagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newMessage in
                self?.messages.append(newMessage)
            }
            .store(in: &cancellables)
        
            messageGenerator?.start()
    }
    
    func send(_ message: String) {
        messages.append(MessageModel(text: message, type: .output))
    }
    
    deinit {
        messageGenerator?.stop()
    }
}
