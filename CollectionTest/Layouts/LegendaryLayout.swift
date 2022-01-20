//
//  LegendaryLayout.swift
//  CollectionTest
//
//  Created by Marcean, Dragos on 1/20/22.
//

import Foundation
import UIKit

class LegendaryLayout: UICollectionViewLayout {

    // MARK: private attr

    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat = 0
    private var cellCache: [UICollectionViewLayoutAttributes] = []
    private var itemsOnFirstRow: Int = 0
    private var dataSource: [Legend] = []

    // MARK: private consts

    private let interItemPadding: CGFloat = 5

    // MARK: Override prop

    override public var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    // MARK: init

    public convenience init(itemsOnFirstRow: Int, dataSource: [Legend]) {
        self.init()
        self.itemsOnFirstRow = itemsOnFirstRow
        self.dataSource = dataSource
    }

    // MARK: Override methods

    override public func prepare() {
        setupAttributes()

        let lastItemFrame = cellCache.last?.frame ?? .zero
        contentHeight = lastItemFrame.maxY
        contentWidth = lastItemFrame.maxX
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: [UICollectionViewLayoutAttributes] = []

        for itemAttrs in cellCache where rect.intersects(itemAttrs.frame)  {
                layoutAttributes.append(itemAttrs)
        }

        return layoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellCache[indexPath.item]
    }

    // MARK: Privates

    func setupAttributes() {
        cellCache = []

        guard let collectionView = collectionView else { return }

        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0

        for row in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let itemSize = size(forIndex: row)
            let indexPath = IndexPath(item: row, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral

            xOffset += itemSize.width + interItemPadding
            yOffset = 0 // for the moment, all on one row

            cellCache.append(attributes)
        }
    }

    private func size(forIndex: Int) -> CGSize {
        let height: CGFloat = 10
        let bulletWidth: CGFloat = 10
        let padding: CGFloat = 3
        let textWidth: CGFloat = dataSource[forIndex].title.size(withAttributes:[.font: UIFont.systemFont(ofSize: 10.0)]).width

        return CGSize(width: bulletWidth + padding + textWidth, height: height)
    }
}
