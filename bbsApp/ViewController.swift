//
//  ViewController.swift
//  bbsApp
//
//  Created by Yanrui Wang on 12/9/17.
//  Copyright © 2017 Yanrui Wang. All rights reserved.
//

import UIKit
import Firebase

var email:String?

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpBottomCons: NSLayoutConstraint!
    @IBOutlet weak var myImage: UIImageView!
    
    @IBAction func signupFunc() {
        self.emailText.resignFirstResponder()
        self.passwordText.resignFirstResponder()
        email = emailText.text!
        if email == ""{
            createAlert("Please enter your email address!")
            return
        }
        else if passwordText.text! == ""{
            createAlert("Please enter your password")
            return
        }
        else if passwordText.text!.count < 4{
            createAlert("Password should have more than 3 characters!")
            return
        }
        else{
            Auth.auth().createUser(withEmail: email!, password: passwordText.text!, completion: { (user, error) in
                if let Error = error{
                    print(Error.localizedDescription)
                    self.createAlert(Error.localizedDescription)
                }
                else{
                    self.performSegue(withIdentifier: "login", sender: self)
                }
            })
        }
//        performSegue(withIdentifier: "sign up", sender: self)
    }
    
    @IBAction func loginAction() {
        self.emailText.resignFirstResponder()
        self.passwordText.resignFirstResponder()
        email = emailText.text!
        
        if email == ""{
            createAlert("Please enter your email address!")
            return
            }
        else if passwordText.text! == ""{
            createAlert("Please enter your password")
            return
            }
        else if passwordText.text!.count < 6{
            createAlert("Password should have more than 6 characters!")
            return
            }
        else{
            Auth.auth().signIn(withEmail: email!, password: passwordText.text!, completion: { (user, error) in
                if let Error = error{
                    print(Error.localizedDescription)
                    self.createAlert(Error.localizedDescription)
                }
                else{
                    self.performSegue(withIdentifier: "login", sender: self)
                }
            })
        }
    }

    
    
    func createAlert(_ warning: String) -> Void{
        let controller = UIAlertController(title: warning, message: "", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK", style: .default, handler: {action in print("yes")})
        controller.addAction(yesAction)
        self.present(controller, animated: true, completion: {print("Done")})
        emailText.text = ""
        passwordText.text = ""
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
            self.signUpBottomCons.constant = 186 //-rect.height
            self.myImage.frame = CGRect(x: 54, y: 82, width: 267, height: 182)
        })
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if notification.userInfo != nil{
            
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
                self.signUpBottomCons.constant = 256 //-rect.height
                self.myImage.frame = CGRect(x: 54, y: 82, width: 267, height: 112)
            })
        }
    }
    
    // if i touched any place except the textFileds, the keyboard will be hiden.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
            self.signUpBottomCons.constant = 186 //-rect.height
            self.myImage.frame = CGRect(x: 54, y: 82, width: 267, height: 182)
        })
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(red: 196/255, green: 18/255, blue: 48/255, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

