//
//  commentViewController.swift
//  bbsApp
//
//  Created by Yanrui Wang on 12/11/17.
//  Copyright © 2017 Yanrui Wang. All rights reserved.
//

import UIKit
import Firebase

class commentViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var ref: DatabaseReference!
    
    @IBAction func commentDoneAction(_ sender: UIBarButtonItem) {
        ref = Database.database().reference()
        if commentText.text! == ""{
            let controller = UIAlertController(title: "comment cannot be empty!", message: "", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "OK", style: .default, handler: {action in print("yes")})
            controller.addAction(yesAction)
            self.present(controller, animated: true, completion: {print("Done")})
        }
        else{
            let saveDate = ["comment": commentText.text!]
            let uid = userid[myIndex]
            self.ref.child("users").child(uid).setValue(saveDate)
        }
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let info = notification.userInfo {
            
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
//            print("start+", bottomConstraint.constant)
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
                self.bottomConstraint.constant = -rect.height
//                print("later:" , self.bottomConstraint.constant)
                })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
