# GDCollectionViewSectionBackgroundColor
=======
设置collectionViewSection背景颜色 可以每个section的背景颜色都不同，可以分别设置每个section背景颜色区域大小

1.将CollectionViewFlowLayout.swift 拖入工程
2.在collectionViewVC 遵循GDCollectionViewDelegateFlowLayout代理
3.创建collectionView时 设置它的layout ： gdcollection.collectionViewLayout = GDCollectionViewFlowLayout()
4.写出的代理方法
func gdbg_collectionView(_ collectionView: UICollectionView, At section: Int) -> CGRect {
        if section == 0{
            //给 x  和  width
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
