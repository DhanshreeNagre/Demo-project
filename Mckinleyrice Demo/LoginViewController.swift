import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginProcessInitiated(_ sender: Any) {
        // Check for the username and password fields
        guard let username = userNameField.text, let password = passwordField.text else {
            showErrorAlert()
            return
        }

        if username == "" || password == "" {
            showErrorAlert()
        } else {
            let userEntity = UserEntity(username: username.lowercased(), password: password)

            let loginRequest = LoginRequest()

            loginRequest.loginInitiated(user: userEntity, completion: { result in
                switch result {
                    case .success(let token):
                        // Local storage to maintain the user login
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.set(token, forKey: "token")
                        UserDefaults.standard.synchronize()
                        self.showWebViewController(token)
                    case .failure( _):
                        self.showLoginFailureErrorAlert()
                }
            })
        }
    }

    func showErrorAlert() {
        let alert = UIAlertController(title: "Invalid Credentials.", message: "Please enter the valid username and password to do login.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

    func showLoginFailureErrorAlert() {
        let alert = UIAlertController(title: "Login Failure.", message: "Unable to login please try again.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

    func showWebViewController(_ token: String) {
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WebViewControllerID") as! WebViewController
            self.present(newViewController, animated: true, completion: nil)
        }
    }
}

