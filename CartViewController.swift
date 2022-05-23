//
//  CartViewController.swift
//  JiaJu


import UIKit

class CartViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CartDelegete {

    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var view_backgroundView: UIView!
    var totalPrice:Decimal = 0
    var datasource = [CartModel]()
    @IBOutlet weak var label_totalPrice: UILabel!
    @IBOutlet weak var _tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        totalPrice = 0
        for item in datasource{
            totalPrice +=   Decimal(string: item.currentPrice)!  * Decimal(string: item.goodsNum)!
        }
        label_totalPrice.text = "USD $\(totalPrice)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        addCartButton.layer.borderColor = UIColor.lightGray.cgColor
        addCartButton.layer.borderWidth = 1/UIScreen.main.scale
        
         title = "CART"
          NotificationCenter.default.addObserver(self, selector: #selector(DBDataChanged), name: Notification.Name(rawValue: "DBDataChanged"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(deleteProducts), name: Notification.Name(rawValue: "DeleteProduct"), object: nil)
        _tableView.register(UINib(nibName: "CartCell", bundle: Bundle.main), forCellReuseIdentifier: "CartCell")
        _tableView.tableFooterView = UIView()
        _tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
                   DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self._tableView.mj_header?.endRefreshing()
                   }
               })
    }
    @objc func deleteProducts(){
          datasource.removeAll()
        if DBManager.shareInstence().deleteAllRecords(fromTable:DBTableName ) == true{
            print("DB success")
        }else{
            print("DB  filed")
        }
        _tableView.reloadData()
        view_backgroundView.isHidden = datasource.count <= 0 ? false : true
    }
    
      @objc func DBDataChanged(){
         getData()
      }
      
      deinit {
          NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "DBDataChanged"), object: nil)
         NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "DeleteProduct"), object: nil)
      }
    func getData(){
            let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
           let query = "Select * from \(DBTableName)"
               let  cartDB = DBManager.shareInstence().getAllData(usingQuery: query)
           datasource = JSONArryModel(cartDB)
        view_backgroundView.isHidden = datasource.count <= 0 ? false : true
       hub.hide(animated: true, afterDelay: 1)
            _tableView.reloadData()

       }
    @IBAction func addToCartButtonClick(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.showData(model: datasource[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    @IBAction func chekOutButtonClick(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JoinCooperationViewController") as! JoinCooperationViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
      func cartCell(cell: CartCell, addChangeNumberOfShop change: CartChange) {
          
          switch change {
          case .CartChangeAdd://
            totalPrice += Decimal.init(string: cell.model.currentPrice)!
            label_totalPrice.text = "$\(totalPrice)"
            
          case .CartChangeMin://
            totalPrice -= Decimal.init(string: cell.model.currentPrice)!
            label_totalPrice.text = "$\(totalPrice)"
             
          case .CartChangeDelete://
              print("delete------cell.model=\(cell.model!)")
              if datasource.contains(cell.model){
                  let index = datasource.firstIndex(of: cell.model)
                  if index != nil{
                    totalPrice -= Decimal.init(string: cell.model.totalPrice)!
                    label_totalPrice.text = "$\(totalPrice)"
                    
                      datasource.remove(at: index!)
                      _tableView.reloadData()
                    view_backgroundView.isHidden = datasource.count <= 0 ? false : true
                      let deleSql = "DELETE FROM \(DBTableName) WHERE goodsId = '\(cell.model.goodsId)';"
                      if DBManager.shareInstence().deleteValue(query: deleSql) == true{
                          print("DB goodsId ==\(cell.model.goodsId) success")
                      }else{
                          print("DB goodsId ==\(cell.model.goodsId) filed")
                      }
                  }
              }
            
          default:
            break
          }
      }
}
