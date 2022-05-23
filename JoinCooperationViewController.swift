//
//  JoinCooperationViewController.swift
//  JiaJu
//


import UIKit

class JoinCooperationViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var tf_phone: UITextField!
    @IBOutlet weak var tv_message: UITextView!
    @IBOutlet weak var label_showCharcter: UILabel!
    @IBOutlet weak var tf_address: UITextField!
    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var tf_name: UITextField!
    override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(false, animated:true)
         }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "JOIN IN COOPERATION"
        
        
    }
    

    @IBAction func submitButtonClick(_ sender: Any) {
        guard tf_name.text?.isEmpty == false else {
            showAlert(message: "enter your name/company please!")
            return
        }
        guard tf_email.text?.isEmpty == false else {
            showAlert(message: "enter your email please!")
            return
        }
        guard tf_address.text?.isEmpty == false else {
            showAlert(message: "enter your address please!")
            return
        }
        guard tf_phone.text?.isEmpty == false else {
            showAlert(message: "enter your phone please!")
            return
        }
        guard tv_message.text?.isEmpty == false else {
            showAlert(message: "enter your message please!")
            return
        }
        NotificationCenter.default.post(name:Notification.Name(rawValue: "DeleteProduct"), object: nil)
        let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            hub.hide(animated: true)
            self.navigationController?.popViewController(animated: true)
            self.showAlert(message: "submit success!")
        })
       
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           let maxLength = 200
           let currentString = textView.text as NSString?
           let newString = currentString?.replacingCharacters(in: range, with: text) as NSString?
           return newString!.length <= maxLength
       }
       
       func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text.count > 0{
               label_showCharcter.isHidden = true
           }else{
               label_showCharcter.isHidden = false
           }
       }
       
       func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
           label_showCharcter.isHidden = true
           return true
       }
    
    func showAlert(message:String){
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
        //self.present(alert, animated: true, completion: nil)
    }

}
