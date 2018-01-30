//
//  GDCollectionViewFlowLayout.swift
//  GDCollectionSectionBGColor
//
//  Created by moqing on 2018/1/30.
//  Copyright © 2018年 guoda. All rights reserved.
//

import UIKit

private let sectionBackgroundID = "sectionBackgroundID"

protocol GDCollectionViewDelegateFlowLayout:UICollectionViewDelegateFlowLayout {
    func gdbg_collectionView(_ collectionView:UICollectionView , collectionViewLayout:UICollectionViewLayout, backgroundColorForSectionAt section:Int) -> UIColor
    func gdbg_collectionView(_ collectionView:UICollectionView, At section:Int) -> CGRect
}
extension GDCollectionViewDelegateFlowLayout {
    func gdbg_collectionView(_ collectionView:UICollectionView , collectionViewLayout:UICollectionViewLayout, backgroundColorForSectionAt section:Int) -> UIColor {
        return UIColor.clear
    }
    func gdbg_collectionView(_ collectionView:UICollectionView, At section:Int) -> CGRect {
        return CGRect.zero
    }
}
private class GDCollectionViewLayoutAttributes:UICollectionViewLayoutAttributes {
    var backgroundColor = UIColor.white
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! GDCollectionViewLayoutAttributes
        copy.backgroundColor = self.backgroundColor
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? GDCollectionViewLayoutAttributes else {
            return false
        }
        
        if !self.backgroundColor.isEqual(rhs.backgroundColor) {
            return false
        }
        return super.isEqual(object)
    }
}

private class GDCollectionReusableView:UICollectionReusableView {
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let attrs = layoutAttributes as? GDCollectionViewLayoutAttributes  else {
            return
        }
        self.backgroundColor = attrs.backgroundColor
    }
}
//让你的.collectionViewlayout = 这个CollectionViewFlowLayout()
class GDCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private var decorationViewAttrs: [UICollectionViewLayoutAttributes] = []

    override init() {
        super.init()
        setUpViewFL()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViewFL()
    }
    
    func setUpViewFL() {
        //注册section
        self.register(GDCollectionReusableView.classForCoder(), forDecorationViewOfKind: sectionBackgroundID)
    }
    override func prepare() {
        super.prepare()
        //有section 遵守了代理
        guard let numberOfSections = self.collectionView?.numberOfSections,let delegate = self.collectionView?.delegate as? GDCollectionViewDelegateFlowLayout else {
            return
        }
        self.decorationViewAttrs.removeAll()
        for section in 0..<numberOfSections {
            guard let numberOfItems = self.collectionView?.numberOfItems(inSection: section),
                numberOfItems > 0,
                let firstItem = self.layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
                let lastItem = self.layoutAttributesForItem(at: IndexPath(item:numberOfItems-1,section:section)) else {
                    continue
            }
            var sectionInset = self.sectionInset
            //设置边界，看collection代理
            if let inset = delegate.collectionView?(self.collectionView!, layout: self, insetForSectionAt: section) {
                sectionInset = inset
            }
            var sectionFrame = firstItem.frame.union(lastItem.frame)
            sectionFrame.origin.x = delegate.gdbg_collectionView(self.collectionView!, At: section).origin.x
            //y 把边距减去  从section最顶端开始 因为是整个section的 top+bottom+intem.height
            sectionFrame.origin.y -= sectionInset.top
            
            if self.scrollDirection == .horizontal {
                sectionFrame.size.width += sectionInset.left + sectionInset.right
                sectionFrame.size.height = self.collectionView!.frame.height
            }else {
                let needWidth = delegate.gdbg_collectionView(self.collectionView!, At: section).size.width
                if needWidth > 0 {
                    sectionFrame.size.width = needWidth
                }else {
                    sectionFrame.size.width = self.collectionView!.frame.width
                }
                sectionFrame.size.height += sectionInset.top + sectionInset.bottom
                
            }
            //配置attributes
            let attr = GDCollectionViewLayoutAttributes(forDecorationViewOfKind: sectionBackgroundID, with: IndexPath(item:0,section:section))
            attr.frame = sectionFrame
            attr.zIndex = -1
            attr.backgroundColor = delegate.gdbg_collectionView(self.collectionView!, collectionViewLayout: self, backgroundColorForSectionAt: section)
            self.decorationViewAttrs.append(attr)
        }
        
    }
    //gd 1.返回rect中的所有的元素的布局属性
    //2. 返回的是包含UICollectionViewLayoutAttributes 的 array
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElements(in: rect)
        attrs?.append(contentsOf: self.decorationViewAttrs.filter {
            return rect.intersects($0.frame)
        })
        return attrs // 3、返回
    }
    //gd 返回对应于indexPath的位置的装饰视图的布局属性，如果没有装饰视图可不重载
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == sectionBackgroundID {
            return self.decorationViewAttrs[indexPath.section]
        }
        return super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
    }
}








