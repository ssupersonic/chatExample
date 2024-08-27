
import Foundation
import Combine

class MessageGeneratorService {
    private var cancellable: AnyCancellable?
    private let messageSubject = PassthroughSubject<MessageModel, Never>()
    
    var messagePublisher: AnyPublisher<MessageModel, Never> {
        messageSubject.eraseToAnyPublisher()
    }
    
    func start() {
        cancellable = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.generateRandomMessage()
            }
    }
    
    func stop() {
        cancellable?.cancel()
        cancellable = nil
    }
    
    private func generateRandomMessage() {
        let randomIndex = Int.random(in: 0..<randomMessages.count)
        let randomMessage = randomMessages[randomIndex]
        
        let message = MessageModel(text: randomMessage, type: .input)
        messageSubject.send(message)
    }
}

extension MessageGeneratorService {
    
    var randomMessages: [String] {
        return ["Hey, how are you doing today? Hope everything is going well!",
        "Just finished reading a great book. Have you read anything interesting lately?",
        "What are your thoughts on the latest Swift update?",
        "It’s a beautiful day outside, perfect for a walk in the park!",
        "I'm learning SwiftUI and it’s been an interesting journey so far.",
        "Do you have any plans for the weekend?",
        "I’ve been thinking about starting a new project. Any suggestions?",
        "Coffee or tea? Which one do you prefer?",
        "The weather has been really unpredictable lately, hasn't it?",
        "Coding is like solving puzzles, and I love that!",
        "Sometimes, all you need is a break to refresh your mind.",
        "Swift’s Combine framework really changes how we handle asynchronous programming!",
        "Do you remember the last movie that really made you think?",
        "Have you heard about the new tech event happening next month?",
        "Hello!",
        "How are you?",
        "What's up?",
        "Have a great day!",
        "SwiftUI is awesome!",
        "Keep coding!",
        "Stay positive!",
        "Random message incoming!",
        "I’ve been experimenting with SwiftData and it’s quite powerful.",
        "What’s your favorite coding tip that you’ve learned recently?",
        "Stay curious, keep learning, and never stop exploring new ideas."]
    }
}
