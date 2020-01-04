import Foundation

struct LoginRequest {

    var path: String = "https://reqres.in/api/login/"

    var resourceURL: URL

    init() {
        guard let pathURL = URL(string: path) else {
            fatalError("Cannot create the URL.")
        }

        self.resourceURL = pathURL
    }

    func loginInitiated(user: UserEntity, completion: @escaping(Result<String, Error>) -> Void) {

            let headers = [
                "content-type": "application/json",
                "cache-control": "no-cache",
            ]

            let parameters = [
                "email": user.username,
                "password": user.password
                ] as [String : Any]

            do {
                let postData =  try JSONSerialization.data(withJSONObject: parameters, options: [])

                let request = NSMutableURLRequest(url: NSURL(string: "https://reqres.in/api/login/")! as URL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headers
                request.httpBody = postData as Data

                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    if (error != nil) {
                        completion(.failure(error!))
                    } else {
                        // Convert response sent from a server to a NSDictionary object:
                        do {
                            guard let jsonData = data else {
                                return
                            }

                            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary

                            if let parseJSON = jsonObject, let token = parseJSON["token"] as? String {
                                print("token: \(token)")
                                completion(.success(token))
                            }
                        } catch {
                            print(error)
                            completion(.failure(error))
                        }

                    }
                })
                dataTask.resume()
            } catch _ {
                print("error exeception")
            }
    }
}
