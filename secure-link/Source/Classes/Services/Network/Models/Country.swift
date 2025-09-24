import Foundation

class ServerCountry: Codable {
    var id: String
    var country: String
    var flag: String
}

class Country: Codable {
    var id: String
    var username: String
    var password: String
    var country: String
    var flag: String
}
