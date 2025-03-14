import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let countriesVC = CountriesViewController()
        let navigationController = UINavigationController(rootViewController: countriesVC)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // For iPad, use a split view controller
            let detailVC = UIViewController() // Placeholder detail view controller
            detailVC.view.backgroundColor = .systemBackground
            
            let splitViewController = UISplitViewController()
            splitViewController.viewControllers = [navigationController, UINavigationController(rootViewController: detailVC)]
            splitViewController.preferredDisplayMode = .allVisible
            
            window?.rootViewController = splitViewController
        } else {
            // For iPhone, use a navigation controller
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
    }
}