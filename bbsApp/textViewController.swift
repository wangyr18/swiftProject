//
//  textViewController.swift
//  bbsApp
//
//  Created by Yanrui Wang on 12/9/17.
//  Copyright © 2017 Yanrui Wang. All rights reserved.
//

import UIKit
import Firebase

class textViewController: UIViewController {

    var ref: DatabaseReference!
    var myId:String?
    var myTitle:String?
    var myArticle:String?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    var segueFromController : String!
    
    @IBAction func unwind(_ sender: UIBarButtonItem) {
        if segueFromController == "MostRecentViewController"{
            self.performSegue(withIdentifier: "BackToMostRecent", sender: self)
        }
        else if segueFromController == "MyPostsViewController"{
            self.performSegue(withIdentifier: "BackToMyPosts", sender: self)
            
        }
        else if segueFromController == "MyLikesViewController"{
            self.performSegue(withIdentifier: "BackToMyLikes", sender: self)
        }
    }
    @IBAction func backToTextView(_sender: UIStoryboardSegue){
        print("back to TextView controller")
    }
    @IBAction func commentAction(_ sender: UIBarButtonItem) {
        let tem = uid!
        uid = tem
        performSegue(withIdentifier: "comment", sender: self)
    }
    @IBAction func deleteAction(_ sender: UIBarButtonItem) {
        ref = Database.database().reference()
        
        if authorLabel.text! == email{
            ref.child("users").child(uid!).removeValue()
            let controller = UIAlertController(title: "Delete!", message: "", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.performSegue(withIdentifier: "back", sender: self)})
            controller.addAction(yesAction)
            self.present(controller, animated: true, completion: nil)
        }else{
            let controller = UIAlertController(title: "You can only delete your own article!", message: "", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "OK", style: .default, handler: {action in print("yes")})
            controller.addAction(yesAction)
            self.present(controller, animated: true, completion: {print("Done")})
        }
    }
    
    @IBAction func likeAction(_ sender: UIBarButtonItem) {
        ref = Database.database().reference()
        let saveDate = ["user": email, "title": titleLabel.text!]
//        saveDate.updateValue(titleLabel.text!, forKey: email!)
        print(saveDate)
        self.ref.child("likes").childByAutoId().setValue(saveDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 210/255, green: 198/255, blue: 148/255, alpha: 1)
//        titleLabel.text = postTitles[myIndex]
//        myTextView.text = postArticles[myIndex]
////        authorLabel.text = Auth.auth().currentUser?.uid
//        authorLabel.text = author[myIndex]
        
        ref = Database.database().reference()
        
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapchat) in
            if let dict = snapchat.value as? [String: Any]{
                print(dict)
                self.authorLabel.text = dict["id"] as? String
                self.titleLabel.text = dict["title"] as? String
                self.myTextView.text = dict["article"] as? String
//                DispatchQueue.main.async {
//                    self.myTableView.reloadData()
//                }
                
            }
        })
        
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
