//
//  MainViewController.swift
//  JiaJu
//


import UIKit

class MainViewController: UITabBarController {
    
    var tabbarTittle = ["HOME","PRODUCTS","CART","ABOUT US"]
    var nomalImage   = ["home_n","product_n","cart_n","me_n"]
    var selectImage  = ["home_s","product_s","cart_s","me_s"]
    
    var viewcontrollers = [UIViewController]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        let sql = "CREATE TABLE IF NOT EXISTS '\(DBTableName)' ('id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,'goodsName' text,'currentPrice' text,'imageUrl' text,'goodsId' text,'goodsNum' text,'totalPrice' text);"
              
              DBManager.shareInstence().createTable(sql)
        let aboutUs =   UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        
         let cart =   UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartViewController")
        
    viewcontrollers =  [BaseNavigationController(rootViewController:HomeViewController()),BaseNavigationController(rootViewController:CateSubViewController()) ,BaseNavigationController(rootViewController:cart), BaseNavigationController(rootViewController:aboutUs)]
        for i in 0..<viewcontrollers.count{
            addChild(viewcontrollers[i])
            viewcontrollers[i].tabBarItem.title = tabbarTittle[i]
            viewcontrollers[i].tabBarItem.image = UIImage(named: nomalImage[i])
            viewcontrollers[i].tabBarItem.selectedImage = UIImage(named: selectImage[i])
            addChild(viewcontrollers[i])
        }
        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
