
import Foundation

extension String {
    
    var trimmWhitespaces: String {
        return self.components(separatedBy: .whitespacesAndNewlines).joined()
    }
}
