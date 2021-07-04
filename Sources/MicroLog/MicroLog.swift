import Foundation

@frozen public enum MicroLog: String {
    case info = "INFO"
    case warning = "WARNING ⚠️"
    case error = "ALERT ❌"
    
    @frozen public struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            return "\((file as NSString).lastPathComponent):\(line) \(function)"
        }
        
        fileprivate init(file: String, function: String, line: Int) {
            self.file = file
            self.function = function
            self.line = line
        }
    }
    
    fileprivate func handleLog(str: String, shouldLogContext: Bool, context: Context) {
        let logComponents = ["[\(rawValue)]", str]
        
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
    
    
    
    @available(*, deprecated, message: "initialiser will always return nil, use MicroLog.info, MicroLog.warning or MicroLog.error instead")
    @discardableResult public init?(rawValue: String) {
        return nil
    }
}
