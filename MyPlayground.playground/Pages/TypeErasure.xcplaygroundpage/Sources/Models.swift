import Foundation

public struct RandomString {
    let value: String
}

extension RandomString {
    public init?(json: Any) {
        guard let array = json as? [String], let first = array.first else { return nil }
        self.value = first
    }
}

