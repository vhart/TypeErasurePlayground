import Foundation

public protocol DataRetrievable {
    func get(onComplete: @escaping (RandomString?) -> Void)
}

public struct NetworkSession: DataRetrievable {

    public init() {}

    public func get(onComplete: @escaping (RandomString?) -> Void) {
        URLSession.shared.dataTask(with: URL.init(string: "http://api.chew.pro/trbmb")!) { (data, _, _) in
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) {
                onComplete(RandomString.init(json: json))
            }
        }.resume()
    }
}
