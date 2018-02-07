import Foundation
import UIKit

public class ChuckNorrisVC: UIViewController {

    var label: UILabel!

    public override func loadView() {
        let view = UIView()

        navigationItem.title = "Steps"
        view.backgroundColor = .white

        self.label = UILabel()
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.numberOfLines = 0
        self.label.text =
        """
        1. Make a generic Any<YourType> class
        2. Make it adhere to the protocol in question
        3. Inject the concrete type into the wrapper
        4. Trampoline calls from the wrapper to the concrete type
        """

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
            ])

        self.view = view
    }


    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

