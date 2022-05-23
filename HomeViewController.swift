//
//  HomeViewController.swift
//  JiaJu
//


import UIKit


class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

     var _collectionView: UICollectionView!
    var imageArra = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "HOME"
         let layout = UICollectionViewFlowLayout()
        _collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64), collectionViewLayout: layout)
        _collectionView.backgroundColor = .groupTableViewBackground
        _collectionView.delegate =  self
        _collectionView.dataSource = self
        _collectionView.register(UINib.init(nibName: "HomeItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HomeItemCell")
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
       imageArra =   [["salepic","offcount1","footstool"],["sofa","salepic2"]]
        self._collectionView.reloadData()

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return imageArra.count
    }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageArra[section].count
    
       
    }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
       }
    
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeItemCell", for: indexPath) as! HomeItemCell
        cell.image_pic.image = UIImage(named: imageArra[indexPath.section][indexPath.row])
        cell.image_pic.contentMode = .scaleAspectFill
           
           return cell
       }
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           collectionView.deselectItem(at: indexPath, animated: true)
        self.tabBarController?.selectedIndex = 1
       }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: SCREEN_WIDTH, height: 180)
        }else{
            return CGSize(width: (SCREEN_WIDTH-30)/2, height: 180)
        }
    }
    


}
