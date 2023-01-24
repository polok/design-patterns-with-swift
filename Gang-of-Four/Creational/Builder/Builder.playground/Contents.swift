import Foundation

// Solution 1
let httpRequestSolution1: HTTPRequest = HTTPMethodBuilder(method: .head)
    .with(url: URL(string: "https://aweseome.builder.example.io")!)
    .with(headers: [
        "Content-Type": "application/json"
    ])
    .with(path: "/all")
    .build()

// Solution 2
var httpRequestSolution2: HTTPRequest = HTTPRequest() { (httpRequest: HTTPRequest) in
    httpRequest.method = .head
    httpRequest.url = URL(string: "https://aweseome.builder.example.io")
    httpRequest.path = "/all"
    httpRequest.headers = [
        "Content-Type": "application/json"
    ]
}

// Solution 3
let httpRequestSolution3 = HTTPRequest()
    .set(\.url, with: URL(string: "https://aweseome.builder.example.io"))
    .set(\.path, with: "/all")
    .set(\.headers, with: ["Content-Type": "application/json"])
