//
//  AboutUsViewController.swift
//  JiaJu
//

import UIKit

class AboutUsViewController: UIViewController {

     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated:true)
      }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func contactUs(_ sender: Any) {
       
        // phoneStr: phone
        let phone = "telprompt://" + "4009620018"
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: phone)!, options: [:], completionHandler: nil)
            } else {
              UIApplication.shared.openURL(URL(string: phone)!)
            }
             
         }
        
        
    }
    @IBAction func joinInCooperation(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JoinCooperationViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
