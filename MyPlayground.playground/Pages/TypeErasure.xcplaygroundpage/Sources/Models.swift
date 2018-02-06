import Foundation

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
        guard let values = json as? [String: String],
            let value = values["value"]
            else { return nil }
        self.value = value
    }
}

