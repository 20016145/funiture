//
//  ProductDetailViewController.swift
//  JiaJu
//


import UIKit

class ProductDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

 
    var detailModel:PrudctModel!
    @IBOutlet weak var _tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         title = "Metista"
        
        _tableView.separatorStyle = .none
         let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
        hub.hide(animated: true, afterDelay: 2)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 300
        }else if indexPath.row == 1{
            return  getTextHeight("\(detailModel.titleName)\n\(detailModel.currentPrice)", font: UIFont.init(name: "PingFang SC", size: 14)!, width: SCREEN_WIDTH - 30)+50
        }else{
            return getTextHeight(detailModel.detail.decription, font: UIFont.init(name: "PingFang SC", size: 12)!, width: SCREEN_WIDTH - 30) + 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if indexPath.row == 0{
            let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 300))
            imageV.kf.setImage(with: URL(string: detailModel.detail.headImg)!)
            imageV.contentMode = .scaleAspectFit
            cell.contentView.addSubview(imageV)
        }else if indexPath.row == 1{
              let height =  getTextHeight("\(detailModel.titleName)\n\(detailModel.currentPrice)", font: UIFont.init(name: "PingFang SC", size: 14)!, width: SCREEN_WIDTH - 30)+50
           let priceLabel = UILabel(frame: CGRect(x: 15, y: 0, width: SCREEN_WIDTH-30, height: height))
            priceLabel.numberOfLines = 0
            print("===== \(detailModel.titleName)\n \(detailModel.currentPrice)")
            priceLabel.attributedText = getAttributyString([(detailModel.titleName,UIColor.darkGray,14),("\nUSD $\(detailModel.currentPrice)",UIColor.darkText,16)])
          
            cell.contentView.addSubview(priceLabel)
        }else{
            let height =  getTextHeight(detailModel.detail.decription, font: UIFont.init(name: "PingFang SC", size: 12)!, width: SCREEN_WIDTH - 30) + 50
            let descriptionLabel = UILabel(frame: CGRect(x: 15, y: 0, width: SCREEN_WIDTH-30, height: height))
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = .darkGray
            descriptionLabel.font = UIFont.init(name: "PingFang SC", size: 12)!
            descriptionLabel.text = " \( detailModel.detail.decription))"
            cell.contentView.addSubview(descriptionLabel)
        }
        return cell
    }
    

    @IBAction func addToCartButtonClick(_ sender: Any) {
        
                   let sql = "SELECT goodsNum FROM \(DBTableName) WHERE goodsId LIKE '%\(detailModel.productId)%';"
                 let td =   DBManager.shareInstence().getAllData(usingQuery: sql)
                  print("td----\(td)")
                   if td.count <= 0{
                       //
                    let totalPrice = Double(detailModel.currentPrice)!  * Double(detailModel.goodsNum)!
                    let sql =  "insert into \(DBTableName)(goodsName,currentPrice,imageUrl,goodsId,goodsNum,totalPrice)values('\(detailModel.titleName)','\(detailModel.currentPrice)','\(detailModel.img)','\(detailModel.productId)','\(detailModel.goodsNum)','\(totalPrice)')"
                    if DBManager.shareInstence().queryValue(sql) == true{
                          showAlert()
                    }else{
                        print(" DB filed")
                    }
                                   
                   }else{
                      let num = Int("\(td[0]["goodsNum"]!)")! + 1
                       print(num)
                       //
                       let sql = "UPDATE \(DBTableName) SET 'goodsNum' = '\(num)','totalPrice' = '\(Double(detailModel.currentPrice)!  * Double(num))' WHERE goodsId = '\(detailModel.productId)'"
                    if DBManager.shareInstence().queryValue(sql) == true{
                        showAlert()
                    }else{
                         print(" DB filed")
                    }
    }
       

}
func showAlert(){
           let alert = UIAlertController(title: "Thanks,add to cart success!", message: "", preferredStyle: .alert)
           let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
           alert.addAction(cancelAction)
           self.present(alert, animated: true, completion: nil)
       }
}
