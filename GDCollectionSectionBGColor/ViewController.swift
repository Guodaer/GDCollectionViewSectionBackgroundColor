//
//  ViewController.swift
//  GDCollectionSectionBGColor
//
//  Created by moqing on 2018/1/30.
//  Copyright © 2018年 guoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController,GDCollectionViewDelegateFlowLayout,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    fileprivate var gdcollection :UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        gdcollection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.view.addSubview(gdcollection)
        gdcollection.register(GDCollectionViewCell.self, forCellWithReuseIdentifier: gdcollectionCellId)
        gdcollection.delegate = self
        gdcollection.dataSource = self
        gdcollection.collectionViewLayout = GDCollectionViewFlowLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {//两边的item 距collectionView section 边距
        return UIEdgeInsetsMake(10, 10, 0, 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return GDCollectionViewCell.getSize()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gdcollectionCellId, for: indexPath) as! GDCollectionViewCell
        
        cell.gdlabel.text = "\(indexPath.section)-\(indexPath.row)"
        
        return cell
    }
    func gdbg_collectionView(_ collectionView: UICollectionView, At section: Int) -> CGRect {
        if section == 0{
            //给 x  和 width
            return CGRect(x: 20, y: 0, width: view.bounds.size.width-40, height: 0)
        }else if section == 1 {
            return CGRect(x: 40, y: 0, width: view.bounds.size.width-80, height: 0)
        }else if section == 2 {
            return CGRect(x: 10, y: 0, width: view.bounds.size.width-20, height: 0)
        }else {
            return CGRect(x: 20, y: 0, width: view.bounds.size.width-40, height: 0)
        }
    }
    func gdbg_collectionView(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        if section == 0 {
            return UIColor.blue
        }else if section == 1{
            return UIColor.purple
        }else if section == 2 {
            return UIColor.brown
        }else {
            return UIColor.yellow
        }
    }
}

