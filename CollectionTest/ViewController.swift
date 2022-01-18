//
//  ViewController.swift
//  CollectionTest
//
//  Created by Marcean, Dragos on 1/14/22.
//

import UIKit

class ViewController: UIViewController {

    var collectionView: UICollectionView?

    let dataSource: [Legend] = [Legend(title: "Body Battery", circleColor: .blue),
                              Legend(title: "Estimated", circleColor: .red),
                                Legend(title: "Rest", circleColor: .yellow),
                                Legend(title: "Stress", circleColor: .green),
                                Legend(title: "Active", circleColor: .green),
                                Legend(title: "Unmeasurable", circleColor: .green)]
    let itemsPerRow: CGFloat = 4

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let frame: CGRect = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width - 20, height: 50)
        let flow = CenterAlignedCollectionViewFlowLayout()
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flow)
        self.view.addSubview(collectionView ?? UIView())
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: "bla")
        collectionView?.backgroundColor = .black
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.frame = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width - 20, height: 70)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView?.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bla", for: indexPath) as? CustomCell else { return UICollectionViewCell() }
        let item = dataSource[indexPath.row]
        cell.loadUIWith(text: item.title, color: item.circleColor)
        return cell
    }


}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = dataSource[indexPath.row]
        let textSize: CGFloat = item.title.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width
        let bulletSize: CGFloat = 6
        let cellContentSize = textSize + bulletSize + 10 //padding
        var maxCellSize = (collectionView.frame.size.width - cellContentSize) / itemsPerRow

        if maxCellSize < cellContentSize {
            maxCellSize = cellContentSize
        }
        return CGSize(width: cellContentSize, height: 30)
    }
    
}

struct Legend {
    var title: String
    var circleColor: UIColor
}

