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

    public convenience init(itemsOnFirstRow: Int?, dataSource: [Legend]) {
        self.init()
        self.itemsOnFirstRow = itemsOnFirstRow ?? dataSource.count
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
        guard let collectionView = collectionView else { return }

        cellCache = []
        verifyIfItemsCanFit()

        var xOffset: CGFloat = computeStartingOffsetFor(elemetsIndexes: [Int](0..<itemsOnFirstRow))
        var yOffset: CGFloat = 0

        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let itemSize = size(forIndex: item)
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            print("\n before new line item=\(dataSource[item].title) == x:\(xOffset) == y:\(yOffset)")

            if item == itemsOnFirstRow || xOffset + itemSize.width > collectionView.frame.maxX {
                triggerNewLine(lastIndex: item, currentXOffset: &xOffset, currentYOffset: &yOffset)
                print("\n after new line item=\(dataSource[item].title) == x:\(xOffset) == y:\(yOffset)")
            }

            attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral

            xOffset += itemSize.width + interItemPadding
            cellCache.append(attributes)
        }
    }

    private func verifyIfItemsCanFit() {
        guard let collectionView = collectionView else { return }
        var totalSize: CGFloat = 0
        for index in 0 ..< itemsOnFirstRow {
            totalSize += size(forIndex: index).width + interItemPadding
            if totalSize > collectionView.frame.maxX - 10 {
                itemsOnFirstRow = index
                return
            }
        }
    }

    private func triggerNewLine(lastIndex: Int, currentXOffset: inout CGFloat, currentYOffset: inout CGFloat) {
        print("\n triggering new line index:\(lastIndex) === x:\(currentXOffset) === y:\(currentYOffset)")
        currentXOffset = computeStartingOffsetFor(elemetsIndexes: [Int](lastIndex..<dataSource.count))
        currentYOffset += 16
        print("\n NEWx:\(currentXOffset) === y:\(currentYOffset)")
    }

    private func size(forIndex: Int) -> CGSize {
        let height: CGFloat = 10
        let bulletWidth: CGFloat = 10
        let padding: CGFloat = 8
        let textWidth: CGFloat = dataSource[forIndex].title.size(withAttributes:[.font: UIFont.systemFont(ofSize: 10.0)]).width

        return CGSize(width: bulletWidth + padding + textWidth, height: height)
    }

    /// computes the offset of the first elements to be placed on a row so that all the required number of elements of that row would fit
    private func computeStartingOffsetFor(elemetsIndexes: [Int]) -> CGFloat {
        guard let collectionView = collectionView else { return 0 }
        var totalElementsWidth: CGFloat = 0
        for index in elemetsIndexes {
            totalElementsWidth += size(forIndex: index).width + interItemPadding
        }



        return collectionView.frame.size.width / 2 - totalElementsWidth / 2
    }
}
