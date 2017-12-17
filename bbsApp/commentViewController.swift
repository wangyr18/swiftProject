//
//  commentViewController.swift
//  bbsApp
//
//  Created by Yanrui Wang on 12/11/17.
//  Copyright © 2017 Yanrui Wang. All rights reserved.
//

import UIKit
import Firebase

class commentViewController: UIViewController, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var myTableView: UITableView!
    var ref: DatabaseReference!
    
    var uid: String?
    var myId: String?
    var myClass:String?
    var myTitle: String?
    var myArticle: String?
    var myComments: Array<String>?
    var showComments = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.backgroundColor = UIColor(red: 210/255, green: 198/255, blue: 148/255, alpha: 1)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.text = showComments[indexPath.row]
        return cell
    }

    @IBAction func commentDoneAction(_ sender: UIBarButtonItem) {
        ref = Database.database().reference()
        if commentText.text! == ""{
            let controller = UIAlertController(title: "comment cannot be empty!", message: "", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "OK", style: .default, handler: {action in print("yes")})
            controller.addAction(yesAction)
            self.present(controller, animated: true, completion: {print("Done")})
        }
        else{
            self.commentText.resignFirstResponder()
            myComments?.append(email!)
            myComments?.append(commentText.text!)
            print(myComments)
            let saveDate = ["article": myArticle!, "title": myTitle!, "class": myClass!, "id": myId!,"comments": myComments!] as [String : Any]
            self.ref.child("users").child(uid!).setValue(saveDate)
            showComments.append("\(email!):\n\(commentText.text!)")
            self.myTableView.reloadData()
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
        view.backgroundColor = UIColor(red: 210/255, green: 198/255, blue: 148/255, alpha: 1)
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        ref = Database.database().reference()
//        uid = userid[myIndex]
        self.showComments.removeAll()
        print(uid)
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapchat) in
            if let dict = snapchat.value as? [String: Any]{
                print(dict)
                self.myId = dict["id"] as? String
                self.myClass = dict["class"] as? String
                self.myTitle = dict["title"] as? String
                self.myArticle = dict["article"] as? String
                self.myComments = dict["comments"] as? [String]
                if self.myComments == nil{
                    self.myComments = [String]()
                }
                else{
                    for i in 0 ..< self.myComments!.count/2{
                        self.showComments.append("\(self.myComments![i*2]):\n\(self.myComments![i*2+1])")
                    }
                }
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
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
