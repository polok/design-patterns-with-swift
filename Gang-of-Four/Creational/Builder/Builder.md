# 👷 Builder

Builder is a creational design pattern that lets you construct complex objects step by step. The pattern allows you to produce different types and representations of an object using the same construction code.

Let's say that we have below class which holdes a few fields which can be set under `init` method:


``` swift
public class HTTPResponse {
    
    public let urlRequest: URLRequest
    public let data: Data?
    public let httpURLResponse: HTTPURLResponse?
    public let error: Swift.Error?
    
    public init(
        urlRequest: URLRequest,
        data: Data?,
        httpURLResponse: HTTPURLResponse?,
        error: Swift.Error?) {
        self.urlRequest = urlRequest
        self.data = data
        self.httpURLResponse = httpURLResponse
        self.error = error
    }
}
```

## Solution 1: `HTTPResponseBuilder`
'Old' fashioned way :)

``` swift
class HTTPResponseBuilder {

    let urlRequest: URLRequest
    var data: Data? = nil
    var httpURLResponse: HTTPURLResponse? = nil
    var error: Swift.Error? = nil

    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }

    func with(data: Data?) -> Self {
        self.data = data
        return self
    }

    func with(httpURLResponse: HTTPURLResponse?) -> Self {
        self.httpURLResponse = httpURLResponse
        return self
    }

    func with(error: Swift.Error?) -> Self {
        self.error = error
        return self
    }

    func build() -> HTTPResponse {
        return HTTPResponse(builder: self)
    }
}
```

Usage may look as follow:

``` swift
let httpResponse = HTTPResponseBuilder(urlRequest: urlRequest)
						.with(data: data)
                        .with(httpURLResponse: urlResponse as? HTTPURLResponse)
                        .with(error: error)
                        .build()
```

## Solution 2: Injectable closure
Less code but it doesn't mean that it's better. Here, this approach has a couple of issues. First, we need to update our model as one of our parameters is marked with `let`. Another, which is not a case for this example but to declare the injectable closure that will be capable of initializers all the properties outside of the target's object, we actually break the encapsulation. Also, in order to be able to set new values, all properties may be required to be public.
	
``` swift
public class HTTPResponse {
    
    public let urlRequest: URLRequest
    public let data: Data?
    public let httpURLResponse: HTTPURLResponse?
    public let error: Swift.Error?

    typealias HTTPResponseBuilderClosure = (HTTPResponse) -> Void

    init(builderClosure: HTTPResponseBuilderClosure) {
        builderClosure(self)
    }
}
```

And the usage may look as follow:

``` swift
let httpBuilderClosure: HTTPResponse.HTTPResponseBuilderClosure = { (httpResponse: HTTPResponse) in
	httpResponse.urlRequest = urlRequest
	httpResponse.httpURLResponse = urlResponse as? HTTPURLResponse
	httpResponse.data = data
	httpResponse.error = error
}

let httpResponse = HTTPResponse(builderClosure: httpBuilderClosure)
```

## Solution 3: Keypath Builder
Available since the introduction of Swift's Key Path addition with Swift 4.0 release. May be quite generic one, but also may be quite dangerous since we can easily misspell a keypath name and get hated run-time error! Be careful, as usual ;)

``` swift
protocol Builder {
    /* empty by purpose as implementation is added under extension */
}

extension Builder where Self: AnyObject {

    @discardableResult
    func set<T>(_ property: ReferenceWritableKeyPath<Self, T>, with value: T) -> Self {
        self[keyPath: property] = value
        return self
    }
}
```

Next, to use such as builder we need to add a conformance to `Builder` protocol to the type that needs to get this functionality, in our example for `HTTPResponse`

``` swift
extension HTTPResponse: Builder {}
```

Let's say that only one parameter is marked as `let` and others as `var`. Then, we could use it as follow:

``` swift
let httpResponse = HTTPResponse(urlRequest: urlRequest)
	.set(\.httpURLResponse, with: urlResponse as? HTTPURLResponse)
	.set(\.data, with: data)
	.set(\.error, with: error)
```

## Solution 4:
No surprise, that there is no one proper solution when it comes to writing code. Also here, there are more variations of implementing of builder pattern.

## Conclusion
Remember, it's always up to you (well, sometimes maybe from architect or some senior guru in your project ;)) to decide which approach suits best for your particular case and context.


