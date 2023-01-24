import Foundation

public enum HTTPMethod {
    case get([URLQueryItem])
    case put(Data?)
    case post(Data?)
    case delete
    case head

    var name: String {
        switch self {
           case .get: return "GET"
           case .put: return "PUT"
           case .post: return "POST"
           case .delete: return "DELETE"
           case .head: return "HEAD"
        }
    }
}
