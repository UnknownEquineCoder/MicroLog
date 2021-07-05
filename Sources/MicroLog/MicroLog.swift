import Foundation

@frozen public enum MicroLog {
    case info
    case warning
    case error
    
    fileprivate var prefix: String {
        switch self {
            case .info: return "INFO"
            case .warning: return "WARNING ⚠️"
            case .error: return "ALERT ❌"
        }
    }
    
    fileprivate struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            return "\((file as NSString).lastPathComponent):\(line) \(function)"
        }
    }
    
    fileprivate func handleLog(str: String, shouldLogContext: Bool, context: Context) {
        let logComponents = ["[\(prefix)]", str]
        
        var fullString = logComponents.joined(separator: " ")
        if shouldLogContext {
            fullString += " ➜ \(context.description)"
        }
        print(fullString)
    }
    
    public func callAsFunction(_ str: StaticString,
                               shouldLogContext: Bool = true,
                               file: String = #file,
                               function: String = #function,
                               line: Int = #line) {
        #if DEBUG
        let context = Context(file: file, function: function, line: line)
        handleLog(str: str.description, shouldLogContext: shouldLogContext, context: context)
        #endif
    }
}
