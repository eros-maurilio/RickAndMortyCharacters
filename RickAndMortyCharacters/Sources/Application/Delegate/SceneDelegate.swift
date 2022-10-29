import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        UINavigationBarAppearance().customAppearance()
        let navigationController = UINavigationController()

        let coordinator = MainCoordinator()
        coordinator.navigationController = navigationController

        let window = UIWindow(windowScene: windowScene)
        navigationController.navigationBar.applyShadow()
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        coordinator.start()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) { CoreDataStack.sharedInstance.saveContext() }
    
}

