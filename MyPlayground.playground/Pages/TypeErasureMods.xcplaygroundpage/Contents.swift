//: [Previous](@previous)

import Foundation
import PlaygroundSupport

public protocol Requestable {
    static var url: URL { get }
    init?(json: Any)
}

public struct RandomString {
    let value: String
}

extension RandomString: Requestable {
    public static let url: URL = URL.init(string: "http://api.chew.pro/trbmb")!

    public init?(json: Any) {
        guard let array = json as? [String], let first = array.first else { return nil }
        self.value = first
    }
}

public struct ChuckNorrisJoke {
    let value: String
}
extension ChuckNorrisJoke: Requestable {
    public static let url: URL = URL.init(string: "https://api.chucknorris.io/jokes/random")!

    public init?(json: Any) {
        guard let values = json as? [String: Any],
            let value = values["value"] as? String
            else { return nil }
        self.value = value
    }
}

public protocol DataRetrievable {
    func get(onComplete: @escaping (RandomString?) -> Void)
}

public struct NetworkSession: DataRetrievable {

    public init() {}

    public func get(onComplete: @escaping (RandomString?) -> Void) {
        URLSession.shared.dataTask(with: URL.init(string: "http://api.chew.pro/trbmb")!) { (data, _, _) in
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) {
                onComplete(RandomString(json: json))
            }
        }.resume()
    }
}

//var dataRetrievable: DataRetrievable = NetworkSession()

//: [Next](@next)
