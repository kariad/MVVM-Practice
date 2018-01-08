import UIKit
import SafariServices

class NavigationRouter: Router {
    var window: UIWindow
    var searchEventNavController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
        self.searchEventNavController = UINavigationController()
        self.window.rootViewController = self.searchEventNavController
    }
    
    func displaySearchEventView() {
        let searchEventViewController = SearchEventViewController(router: self)
        self.searchEventNavController.pushViewController(searchEventViewController, animated: false)
    }
    
    func displayEventDetailView(url: String) {
        let safariViewController = SFSafariViewController(url: URL(string: url)!)
        safariViewController.navigationController?.setNavigationBarHidden(true, animated: false)
        self.searchEventNavController.present(safariViewController, animated: true, completion: nil)
    }
}
