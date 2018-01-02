import UIKit
import SafariServices

class NavigationRouter {
    var window: UIWindow
    var searchEventNavController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
        let searchEventViewController = SearchEventViewController(router: self)
        self.searchEventNavController = UINavigationController(rootViewController: searchEventViewController)
        self.window.rootViewController = self.searchEventNavController
    }
    
    func displayEventDetailView(url: String) {
        let safariViewController = SFSafariViewController(url: URL(string: url)!)
        safariViewController.navigationController?.setNavigationBarHidden(true, animated: false)
        self.searchEventNavController.present(safariViewController, animated: true, completion: nil)
    }
}
