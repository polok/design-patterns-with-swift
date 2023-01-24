import Foundation

// Solution 1

public final class HTTPMethodBuilder {
    var method: HTTPMethod
    
    var url: URL? = nil
    var headers: [String: String]? = nil
    var path: String? = nil
    
    public init(method: HTTPMethod) {
        self.method = method
    }
    
    @discardableResult
    public func with(url: URL) -> Self {
        self.url = url
        return self
    }
    
    @discardableResult
    public func with(headers: [String: String]) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult
    public func with(path: String) -> Self {
        self.path = path
        return self
    }
    
    public func build() -> HTTPRequest {
        return HTTPRequest(builder: self)
    }
}
