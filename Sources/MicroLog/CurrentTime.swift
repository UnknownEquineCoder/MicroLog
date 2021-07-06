import Foundation

public extension Date {
    static var currentTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        
        return formatter.string(from: .init())
    }
}
