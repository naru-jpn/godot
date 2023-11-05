import CoreGraphics
import Foundation
import Godot

let godotApplicalitionDelegate = Godot.GodotApplicalitionDelegate()

final class ApplicationDelegate: UIResponder, UIApplicationDelegate {
  /// Godot Framework 内で動的に `window` プロパティへのアクセスが発生するらしく、この定義は必須。
  var window: UIWindow?

  var godotWindow: UIWindow? {
    GodotApplicalitionDelegate.services.compactMap({ $0 as? Godot.AppDelegate }).first?.window
  }

  var godotViewController: UIViewController {
    Godot.AppDelegate.viewController
  }

  var godotView: Godot.GodotView {
    Godot.AppDelegate.viewController.godotView
  }

  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    if let godotAppDelegate = GodotApplicalitionDelegate.services.compactMap({ $0 as? Godot.AppDelegate }).first {
      godotAppDelegate.setLaunchArguments(CommandLine.argc, argv: CommandLine.unsafeArgv)
    }
    godotApplicalitionDelegate.application(application, willFinishLaunchingWithOptions: launchOptions)
    return true
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    godotApplicalitionDelegate.application(application, didFinishLaunchingWithOptions: launchOptions)

    let screenBounds = UIScreen.main.bounds
    let viewController = MainViewController()
    window = UIWindow(frame: screenBounds)
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()

    viewController.loadViewIfNeeded()

    viewController.containerView.addSubview(godotViewController.view)
    godotViewController.view.frame = CGRect(
      x: 0,
      y: (viewController.containerView.bounds.height - godotViewController.view.bounds.height) / 2,
      width: viewController.containerView.bounds.width,
      height: screenBounds.height
    )

    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    godotApplicalitionDelegate.applicationWillResignActive(application)
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    godotApplicalitionDelegate.applicationDidBecomeActive(application)
  }
}
