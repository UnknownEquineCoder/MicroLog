import Foundation

public extension Date {
    /**
     Returns the current date and time (with milliseconds) as a String.
     */
    static var currentTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        
        return formatter.string(from: .init())
    }
}
