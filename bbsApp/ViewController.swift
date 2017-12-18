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
        else if passwordText.text!.count < 4{
            createAlert("Password should have more than 3 characters!")
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(red: 196/255, green: 18/255, blue: 48/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

