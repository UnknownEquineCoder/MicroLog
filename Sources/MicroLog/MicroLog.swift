import Foundation

@frozen public enum MicroLog {
    /**
     Case for logging general information, behaves like a function.
     
     **Parameters**
     
     `message`: Log message, include any relevant information about the program state here. __required__
     
     `verbose`: Signals whether the log should be displayed in full-length or only a brief should be logged instead. Pass `true` for the long version, `false` otherwise. Defaults to `true`.
     
     `file`: Name of the file to be logged, defaults to the callsite's file.
     
     `function`: Name of the function to be logged, defaults to the callsite's function.
     
     `line`: Number of the line to be logged, defaults to the callsite's line.
     
     **Sample usage:**
     ```
     MicroLog.info("This is an example info message")
     ```
     ```
     MicroLog.info("This is an example info message", verbose: false)
     ```
     */
    case info
    
    /**
     Case for logging warnings, behaves like a function.
     
     **Parameters**
     
     `message`: Log message, include any relevant information about the program state here. __required__
     
     `verbose`: Signals whether the log should be displayed in full-length or only a brief should be logged instead. Pass `true` for the long version, `false` otherwise. Defaults to `true`.
     
     `file`: Name of the file to be logged, defaults to the callsite's file.
     
     `function`: Name of the function to be logged, defaults to the callsite's function.
     
     `line`: Number of the line to be logged, defaults to the callsite's line.
     
     **Sample usage:**
     ```
     MicroLog.warning("This is an example warning message")
     ```
     ```
     MicroLog.warning("This is an example warning message", verbose: false)
     ```
     */
    case warning
    
    /**
     Case for logging errors, behaves like a function.
     
     **Parameters**
     
     `message`: Log message, include any relevant information about the program state here. __required__
     
     `verbose`: Signals whether the log should be displayed in full-length or only a brief should be logged instead. Pass `true` for the long version, `false` otherwise. Defaults to `true`.
     
     `file`: Name of the file to be logged, defaults to the callsite's file.
    
     `function`: Name of the function to be logged, defaults to the callsite's function.
     
     `line`: Number of the line to be logged, defaults to the callsite's line.
     
     **Sample usage:**
     ```
     MicroLog.error("This is an example error message")
     ```
     ```
     MicroLog.error("This is an example error message", verbose: false)
     ```
    */
    case error

    /**
     Log decorator to indicate which type of message is being logged.
     */
    fileprivate var prefix: String {
        switch self {
            case .info: return "INFO"
            case .warning: return "WARNING ⚠️"
            case .error: return "ALERT ❌"
        }
    }
    
    /**
     Convenience struct to describe log context.
     
     **[Future Features]**:
     - Add file saving capabilities.
     */
    fileprivate struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            return "\((file as NSString).lastPathComponent):\(line) \(function)"
        }
    }
    
    /**
     Convenience function for composing and logging complete log messages.
     
     - parameters:
        - message: Log message.
        - verbose: Flag signaling whether log should be full-length or a summary should be displayed instead.
        - context: Additional log context, only displayed when `verbose` is `true`.
     */
    fileprivate func compose(message: String, verbose: Bool, context: Context) {
        let logComponents = ["[\(prefix)]", message]
        
        var fullString = logComponents.joined(separator: " ")
        
        if verbose {
            fullString += " ➜ \(context.description)"
        }
        print(fullString)
    }
    
    /**
     Swift function that transforms all MicroLog cases into a function.
     
     - parameters:
        - message: Log message, include any relevant information about the program state here. __required__
        - verbose: Signals whether the log should be displayed in full-length or only a brief should be logged instead. Pass `true` for the long version, `false` otherwise. Defaults to `true`.
        - file: Name of the file to be logged, defaults to the callsite's file.
        - function: Name of the function to be logged, defaults to the callsite's function.
        - line: Number of the line to be logged, defaults to the callsite's line.
     */
    public func callAsFunction(_ message: StaticString,
                               verbose: Bool = true,
                               file: String = #file,
                               function: String = #function,
                               line: Int = #line) {
        #if DEBUG
        let context = Context(file: file, function: function, line: line)
        compose(message: message.description, verbose: verbose, context: context)
        #endif
    }
}
