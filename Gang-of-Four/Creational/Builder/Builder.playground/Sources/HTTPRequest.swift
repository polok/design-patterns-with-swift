import Foundation

public class HTTPRequest {
    public var url: URL?
    public var headers: [String: String]?
    public var method: HTTPMethod?
    public var path: String?
    
    public init() {}
}

// Solution 1

public extension HTTPRequest {
    
    convenience init(builder: HTTPMethodBuilder) {
        self.init()
        url = builder.url
        headers = builder.headers
        method = builder.method
        path = builder.path
    }
}

// Solution 2

public extension HTTPRequest {
    
    typealias HTTPRequestBuilderClosure = (HTTPRequest) -> Void
    
    convenience init(builderClousre: HTTPRequestBuilderClosure) {
        self.init()
        builderClousre(self)
    }
}

// Solution 3

extension HTTPRequest: Builder {}
