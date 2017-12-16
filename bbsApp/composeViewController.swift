//
//  composeViewController.swift
//  bbsApp
//
//  Created by Yanrui Wang on 12/10/17.
//  Copyright © 2017 Yanrui Wang. All rights reserved.
//

import UIKit
import Firebase

class composeViewController: UIViewController {
    
    @IBOutlet weak var categoryText: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var titleText: UITextField!
    
    var ref: DatabaseReference!
    

    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
        ref = Database.database().reference()
        
        if categoryText.text! == ""{
            createAlert("Topic catogory is required.")
            return
        }
        else if titleText.text! == ""{
            createAlert("Title is required")
            return
        }
        else if myTextView.text! == ""{
            createAlert("Post cannot be empty")
            return
        }
        else{
            let saveDate = ["id": email, "title": titleText.text!, "article": myTextView.text!, "class": categoryText.text!]
            self.ref.child("users").childByAutoId().setValue(saveDate)
            let controller = UIAlertController(title: "Successfully upload", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: {action in
                self.performSegue(withIdentifier: "Back", sender: self)})
            controller.addAction(action)
            self.present(controller, animated: true, completion:nil)
        }

    }
    
    
    func createAlert(_ warning: String) -> Void{
        let controller = UIAlertController(title: warning, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in
            print("Post done!")})
        controller.addAction(action)
        self.present(controller, animated: true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
