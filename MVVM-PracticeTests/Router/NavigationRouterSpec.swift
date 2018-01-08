import Quick
import Nimble
import SafariServices
@testable import MVVM_Practice

class NavigationRouterSpec: QuickSpec {
    override func spec() {
        var subject: NavigationRouter!
        let window = UIWindow(frame: .zero)
        
        beforeEach {
            subject = NavigationRouter(window: window)
            window.makeKeyAndVisible()
        }
        
        describe("calls displaysSearchEventView", closure: {
            it("SearchEventViewController is displayed", closure: {
                subject.displaySearchEventView()
               
                
                let navController = window.rootViewController as! UINavigationController
                expect(navController.viewControllers.first).to(beAKindOf(SearchEventViewController.self))
            })
        })
        
        describe("calls displaysEventDetailView" , closure: {
            it("SFSafariViewController is displayed", closure: {
                subject.displayEventDetailView(url: "https://expect.ex")
                
                
                let navController = window.rootViewController as! UINavigationController
                expect(navController.presentedViewController).toEventually(beAKindOf(SFSafariViewController.self))
            })
        })
    }
}
