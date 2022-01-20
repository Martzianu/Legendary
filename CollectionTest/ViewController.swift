//
//  ViewController.swift
//  CollectionTest
//
//  Created by Marcean, Dragos on 1/14/22.
//

import UIKit

struct Legend {
    var title: String
    var circleColor: UIColor
}



class ViewController: UIViewController {

    let dataSource: [Legend] = [Legend(title: "Body Battery", circleColor: .blue),
                              Legend(title: "Estimated", circleColor: .red),
                                Legend(title: "Rest", circleColor: .red),
                                Legend(title: "Stress", circleColor: .red),
                                Legend(title: "Active", circleColor: .red),
                                Legend(title: "Unmeasurable", circleColor: .red)]
    let itemsOnFirstRow: Int? = 2

    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width - 20, height: 30)
        let layout = LegendaryLayout(itemsOnFirstRow: itemsOnFirstRow, dataSource: dataSource)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "bla")
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)

    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bla", for: indexPath) as? CustomCell else { return UICollectionViewCell() }
        let item = dataSource[indexPath.row]
        cell.loadUIWith(text: item.title, color: item.circleColor)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}
