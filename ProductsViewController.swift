//
//  ProductsViewController.swift
//  JiaJu
//

import UIKit

class ProductsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

     var _collectionView: UICollectionView!
    var datasource = [PrudctModel]()
    var index:Int = 1
    init(index:Int){
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
               layout.itemSize = CGSize.init(width: (SCREEN_WIDTH-30)/2, height: 265)
              
        _collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-160), collectionViewLayout: layout)
        _collectionView.backgroundColor = .groupTableViewBackground
        _collectionView.delegate =  self
        _collectionView.dataSource = self
         _collectionView.register(UINib.init(nibName: "ProductCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ProductCell")
        _collectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
                   DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.getData()
                        self._collectionView.mj_header?.endRefreshing()
                   }
               })
        _collectionView.mj_header?.beginRefreshing()
        view.addSubview(_collectionView)
    }
    
    func getData(){
        let productArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "Products", ofType:"plist")!)
        let arry:[PrudctModel] =  JSONArryModel(productArray as! [[String : Any]])
        datasource = arry.filter{$0.productType == index}
        _collectionView.reloadData()
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
           let model = datasource[indexPath.row]
           cell.showData(model: model)
           
           return cell
       }
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           collectionView.deselectItem(at: indexPath, animated: true)
          let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
           let model = datasource[indexPath.row]
        vc.detailModel = model
       navigationController?.pushViewController(vc, animated: true)
       }



}
