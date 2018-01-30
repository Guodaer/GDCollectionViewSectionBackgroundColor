//
//  GDCollectionViewCell.swift
//  GDCollectionSectionBGColor
//
//  Created by moqing on 2018/1/30.
//  Copyright © 2018年 guoda. All rights reserved.
//

import UIKit
let gdcollectionCellId = "gdcollectionCellId"
class GDCollectionViewCell: UICollectionViewCell {
    
    var gdlabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setUp() {
        self.backgroundColor = UIColor.lightGray
        gdlabel = UILabel(frame: CGRect.zero)
        gdlabel.textColor = UIColor.red
        gdlabel.textAlignment = .center
        contentView.addSubview(gdlabel)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gdlabel.frame = self.bounds
    }
    class func getSize()->CGSize {
        
        return CGSize(width: 100, height: 100)
    }
}
