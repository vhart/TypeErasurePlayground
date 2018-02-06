//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

enum Mode {
    case normal
    case editing
}

class CustomCell: UICollectionViewCell {

    var onLongPress: (() -> Void)?

    var longPress: UILongPressGestureRecognizer?
    var mode: Mode = .normal

    func addLongPress() {
        let longPress = UILongPressGestureRecognizer(target: self, action:#selector(didLongPress))
        longPress.minimumPressDuration = 2.0
        self.addGestureRecognizer(longPress)
        self.longPress = longPress
    }

    @objc func didLongPress() {
        set(mode: .editing)
        onLongPress?()
    }

    func set(mode newMode: Mode) {
        guard mode != newMode else { return }
        mode = newMode
        switch newMode {
        case .normal:
            removeAnimation()
        case .editing:
            addJiggle()
        }
    }

    func removeAnimation() {
        self.layer.removeAnimation(forKey: "jiggle")
    }

    func addJiggle() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = (-Double.pi/60)
        animation.toValue = (Double.pi/60)
        animation.autoreverses = true
        animation.duration = 0.5
        animation.repeatCount = Float.infinity

        self.layer.add(animation, forKey: "jiggle")
    }

    override func prepareForReuse() {
        removeAnimation()
        if let lp = longPress {
            self.removeGestureRecognizer(lp)
        }
        longPress = nil
        mode = .normal
    }
}

class SomeCollectionView: UICollectionViewController {

    var mode: Mode = .normal

    var colors: [UIColor] = [.red, .blue, .green, .yellow, .purple]

    override func loadView() {
        let view = UIView(frame: .init(x: 0, y: 0, width: 200, height: 300))
        view.backgroundColor = .white
        self.view = view
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 50)
        layout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView?.contentSize = view.frame.size
        self.collectionView?.backgroundColor = .white

        self.collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: "reuseId")

        view.addSubview(collectionView!)

    }

    override func numberOfSections(in collectionView:
        UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("here")
        print("also here")
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "reuseId", for: indexPath) as! CustomCell
        cell.prepareForReuse()
        switch mode {
        case .normal:
            cell.addLongPress()
            cell.onLongPress = { [weak self] in
                self?.beginEditing()
            }
        case .editing:
            cell.set(mode: .editing)
        }
        cell.backgroundColor = colors[indexPath.row]

        return cell
    }

    func beginEditing() {
        mode = .editing
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.endEditing()
        }
        collectionView?.reloadData()
    }

    func endEditing() {
        mode = .normal
        colors.append(.orange)
        collectionView?.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard mode == .editing else { return }

        colors.remove(at: indexPath.row)
        collectionView.reloadData()
    }
}


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = SomeCollectionView()
PlaygroundPage.current.needsIndefiniteExecution = true
