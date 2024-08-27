
import Foundation

enum MessageType: String, Decodable {
    case input
    case output
}

struct MessageModel: Decodable, Identifiable, Equatable, Hashable {
    var id: UUID = UUID()
    let text: String
    let type: MessageType
}
