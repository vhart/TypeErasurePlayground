import Foundation
import UIKit

public class NavViewController: UIViewController {

    var b1: UIButton!
    var b2: UIButton!


    public init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Type Erasure"
        view.backgroundColor = .white
        let button1 = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button1.backgroundColor = .orange

        button1.setTitle("CHUCK NORRIS", for: .normal)

        let button2 = UIButton(frame: CGRect(x: 100, y: 170, width: 200, height: 50))

        button2.backgroundColor = .blue
        button2.setTitle("RANDOM STRING", for: .normal)

        button2.isUserInteractionEnabled = true
        button1.addTarget(self, action: #selector(pushChuckNorrisVC), for: .touchUpInside)
        button2.addTarget(self, action: #selector(pushRandomStringVC), for: .touchUpInside)

        self.b1 = button1
        self.b2 = button2
        self.view.addSubview(button1)
        self.view.addSubview(button2)
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    @objc func pushChuckNorrisVC() {
        print("PUSH NORRIS")
        let vc = ChuckNorrisVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushRandomStringVC() {
        print("PUSH RANDOM")
        let vc = RandomStringVC()
        vc.session = NetworkSession()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func handleSwipe(){}
}
