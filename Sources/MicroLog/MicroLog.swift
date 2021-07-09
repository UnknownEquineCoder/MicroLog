import Foundation

/**
 Small class to make logging easier and more convenient.
 Refer to `MicroLog.info`, `MicroLog.warning` and `MicroLog.error` for documentation on usage.
 */
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
            case .info:     return "ℹ️ [INFO]"
            case .warning:  return "⚠️ [WARNING]"
            case .error:    return "❌ [ERROR]"
        }
    }
    
    /**
     Convenience struct to describe log context.
     
     **[Future Features]**:
     - Add file saving capabilities.
     */
    fileprivate struct Context {
        let file: StaticString
        let function: StaticString
        let line: UInt
        var description: String {
            return "\((file.description as NSString).lastPathComponent):\(line) \(function)"
        }
    }
    
    /**
     Convenience function for composing and logging complete log messages.
     
     - parameters:
        - message: Log message.
        - verbose: Flag signaling whether the log should be full-length or a summary should be displayed instead.
        - context: Additional log context, only displayed when `verbose` is `true`.
     */
    fileprivate func compose(message: String, verbose: Bool, context: Context) {
        var logMessage = "\(Date.currentTime) | \(prefix) | \(message)"
        
        if verbose {
            logMessage += " ➜ \(context.description)"
        }
        print(logMessage)
    }
    
    /**
     Logs a message to the console. More context is included when in verbose mode.
     
     - parameters:
        - message: Log message, include any relevant information about the program state here. __required__
        - verbose: Signals whether the log should be displayed in full-length or only a brief should be logged instead. Pass `true` for the long version, `false` otherwise. Defaults to `true`.
        - file: Name of the file to be logged, defaults to the callsite's file.
        - function: Name of the function to be logged, defaults to the callsite's function.
        - line: Number of the line to be logged, defaults to the callsite's line.
     */
    public func callAsFunction(_ message: StaticString,
                               verbose: Bool = true,
                               file: StaticString = #file,
                               function: StaticString = #function,
                               line: UInt = #line) {
        #if DEBUG
        let context = Context(file: file, function: function, line: line)
        compose(message: message.description, verbose: verbose, context: context)
        #endif
    }
}
