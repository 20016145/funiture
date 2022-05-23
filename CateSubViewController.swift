//
//  CateSubViewController.swift
//  JiaJu
//


import UIKit


class CateSubViewController: VTMagicController {

     override func loadView() {
            super.loadView()
            title = "PRODUCTS"
            setupViews()
        }
        
        
        func setupViews() {
            magicView.backgroundColor = .white
            magicView.layoutStyle = .divide
            magicView.navigationHeight = 44
            magicView.navigationColor = .white
            magicView.isSliderHidden = true
            magicView.separatorColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            magicView.isMenuScrollEnabled = false
            magicView.isScrollEnabled = true
            magicView.isSwitchAnimated = false
            magicView.reloadData()
        }


}
extension CateSubViewController {
    
    override func menuTitles(for magicView: VTMagicView) -> [String] {

       return  ["Sofa","Dining&Kichen","Chairs"]
    }
    
    override func magicView(_ magicView: VTMagicView, menuItemAt itemIndex: UInt) -> UIButton {
        
        var button: UIButton! = magicView.dequeueReusableItem(withIdentifier: "button")
        
        if button == nil {
            button = UIButton(type: .custom)
            button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8), for: .selected)
            button.setTitleColor(#colorLiteral(red: 0.1529411765, green: 0.1568627451, blue: 0.1764705882, alpha: 0.4), for: .normal)
            button.titleLabel?.font = UIFont.init(name: "PingFang SC", size: 12)
            button.contentVerticalAlignment = .bottom
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        }
      //  menuItem.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:13.f];
        
        return button
    }
    
    override func magicView(_ magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController {
       
        print("pageIndex---\(pageIndex)")
        
        let vc = ProductsViewController(index: Int(pageIndex+1))
            
            return vc
        
    }
}

