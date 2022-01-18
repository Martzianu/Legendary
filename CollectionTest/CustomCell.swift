//
//  CustomCell.swift
//  CollectionTest
//
//  Created by Marcean, Dragos on 1/14/22.
//

import Foundation
import UIKit

class CustomCell: UICollectionViewCell {
    let textLabel: UILabel = UILabel()
    let circle: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupUI() {
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.textColor = .white
        textLabel.frame.origin = CGPoint(x: 10, y: 5)
        self.contentView.addSubview(textLabel)

        circle.frame = CGRect(x: 0, y: 10, width: 6, height: 6)
        circle.layer.cornerRadius = 3
        self.contentView.addSubview(circle)
    }

    func loadUIWith(text: String, color: UIColor) {
        textLabel.text = text
        circle.backgroundColor = color

        textLabel.sizeToFit()
        contentView.backgroundColor = .gray
    }


}
