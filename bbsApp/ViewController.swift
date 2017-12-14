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

    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    
    @IBAction func signInSemgent(_ sender: UISegmentedControl) {
        switch (mySegmentControl.selectedSegmentIndex){
        case 0:
            signLabel.text = "Sign in"
        case 1:
            signLabel.text = "Sign up"
        default:
            return
        }
    }
    
    @IBAction func submitButtonAction() {
        email = emailText.text
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
            switch (mySegmentControl.selectedSegmentIndex){
            case 0:
                Auth.auth().signIn(withEmail: email!, password: passwordText.text!, completion: { (user, error) in
                    if user != nil{
                        
                    }
                    else{
                        
                    }
                })
            case 1:
                Auth.auth().createUser(withEmail: email!, password: passwordText.text!, completion: { (user, error) in
                    if user != nil{
                        
                    }
                    else{
                    }
                })
            default:
                return
            }
        }
    }
    
    @IBAction func guestButtonAction() {
        email = "Guest"
    }
    
    func createAlert(_ warning: String) -> Void{
        let controller = UIAlertController(title: warning, message: "", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK", style: .default, handler: {action in print("yes")})
        controller.addAction(yesAction)
        self.present(controller, animated: true, completion: {print("Done")})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

