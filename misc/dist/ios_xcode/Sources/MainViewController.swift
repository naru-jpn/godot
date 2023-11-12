import UIKit

final class MainViewController: UIViewController {

  lazy var messageLabel: UILabel = { label in
    label.font = .systemFont(ofSize: 24, weight: .black)
    label.textColor = UIColor(white: 0.33, alpha: 1)
    label.text = "Hello Godot as a Library!"
    label.frame = CGRect(x: 0, y: containerView.frame.minY - (label.font.lineHeight + 16), width: self.view.bounds.width, height: label.font.lineHeight)
    label.textAlignment = .center
    return label
  }(UILabel())

  lazy var containerView: UIView = { view in
    let bounds = self.view.bounds
    view.frame = CGRect(x: 0, y: (bounds.height - bounds.width) / 2, width: bounds.width, height: bounds.width)
    view.backgroundColor = .black
    view.clipsToBounds = true
    return view
  }(UIView())

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    view.addSubview(containerView)
    view.addSubview(messageLabel)
  }
}
