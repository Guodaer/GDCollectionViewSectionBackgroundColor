# GDCollectionViewSectionBackgroundColor
##设置collectionViewSection背景颜色 可以每个section的背景颜色都不同，可以分别设置每个section背景颜色区域大小

1.将CollectionViewFlowLayout.swift 拖入工程 <br>
2.在collectionViewVC 遵循GDCollectionViewDelegateFlowLayout代理 <br>
3.创建collectionView时 设置它的layout ： gdcollection.collectionViewLayout = GDCollectionViewFlowLayout() <br>
4.写出的代理方法 <br>
func gdbg_collectionView(_ collectionView: UICollectionView, At section: Int) -> CGRect { <br>
        if section == 0{ <br>
            //给 x  和  width <br>
            return CGRect(x: 20, y: 0, width: view.bounds.size.width-40, height: 0)<br>
        }else if section == 1 {<br>
            return CGRect(x: 40, y: 0, width: view.bounds.size.width-80, height: 0)<br>
        }else if section == 2 {<br>
            return CGRect(x: 10, y: 0, width: view.bounds.size.width-20, height: 0)<br>
        }else {<br>
            return CGRect(x: 20, y: 0, width: view.bounds.size.width-40, height: 0)<br>
        }<br>
    } <br>
    func gdbg_collectionView(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {<br>
        if section == 0 {<br>
            return UIColor.blue<br>
        }else if section == 1{<br>
            return UIColor.purple<br>
        }else if section == 2 {<br>
            return UIColor.brown<br>
        }else {<br>
            return UIColor.yellow<br>
        }<br>
    }
