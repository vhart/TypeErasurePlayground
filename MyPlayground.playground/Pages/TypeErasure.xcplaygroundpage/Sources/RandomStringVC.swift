import Foundation
import UIKit

public class RandomStringVC: UIViewController {

    var label: UILabel!
    var session: NetworkSession!

    public override func loadView() {
        let view = UIView()

        navigationItem.title = "Random String"
        view.backgroundColor = .white

        self.label = UILabel()
        self.label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ])

        self.view = view
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        session.get { randomString in
            DispatchQueue.main.async { [weak self] in
                self?.label.text = randomString?.value
            }
        }
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
