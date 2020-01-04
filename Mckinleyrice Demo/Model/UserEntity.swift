import Foundation

/// A user which is going to login.
///
final class UserEntity: Codable {

    /// The unique Identifier
    var id: Int?

    /// The username
    let username: String

    /// The password
    let password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
