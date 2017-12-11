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
            signLabel.text = "Register"
        default:
            return
        }
    }
    
    @IBAction func submitButtonAction() {
        email = emailText.text
        if email != nil, let password = passwordText.text{
            
            switch (mySegmentControl.selectedSegmentIndex){
            case 0:
                Auth.auth().signIn(withEmail: email!, password: password, completion: { (user, error) in
                    if user != nil{
                        
                    }
                    else{
                        
                    }
                })
            case 1:
                Auth.auth().createUser(withEmail: email!, password: password, completion: { (user, error) in
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

