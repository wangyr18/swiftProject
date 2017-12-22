//
//  MostRecentViewController.swift
//  bbsApp
//
//  Created by Yu Ma on 12/14/17.
//  Copyright © 2017 Yanrui Wang. All rights reserved.
//

import UIKit
import Firebase

var myIndex = 0
var postTitles = [String]()
var postArticles = [String]()
var allTitles = [String]()
var userid = [String]()
var author = [String]()
var clickRate = [Int]()
var currentUserId = [String]()
var uid: String?


class MostRecentViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var ref: DatabaseReference!
    
    
    @IBAction func backToMostRecentViewController(_sender: UIStoryboardSegue){
        print("Back to Home")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? textViewController{
            destination.segueFromController = "MostRecentViewController";
        }
    }
    

    @IBAction func signOutAction(_ sender: UIBarButtonItem) {
        do{
            try? Auth.auth().signOut()
            if Auth.auth().currentUser == nil{
                let logout = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
                self.present(logout, animated: true, completion: nil)
            }
        }
//        catch let error as NSError{
//            print(error.localizedDescription)
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postTitles.count
        //        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.backgroundColor = UIColor(red: 210/255, green: 198/255, blue: 148/255, alpha: 1)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.text = postTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        uid = userid[indexPath.row]
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("i am in")
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        view.backgroundColor = UIColor(red: 210/255, green: 198/255, blue: 148/255, alpha: 1)
        
        postTitles.removeAll()
        postArticles.removeAll()
        userid.removeAll()
        author.removeAll()
        currentUserId.removeAll()
        
        ref.child("users").observe(.childAdded) { (snapchat) in
            let userdict = snapchat.key as NSString
                userid.append(userdict as String)
//                print(userid)
            
            if let dict = snapchat.value as? NSDictionary{
                let temTitle = dict["title"] as? NSString
                let temT = temTitle! as String
                
//                let temArticle = dict["article"] as? NSString
//                postArticles.append(temArticle! as String)
                let temAuther = dict["id"] as? NSString
                let temA = temAuther! as String
                author.append(temA)
                allTitles.append(temT)
                postTitles.append("\(temT)\n    Author: \(temA)")
                
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
//            save the id of current user for ME
//            for i in 0 ..< userid.count{
//                if author[i] == email!{
//                    if currentUserId.count == 0{
//                        currentUserId.append(userid[i])
//                    }
//                    else if userid[i] != currentUserId[currentUserId.count-1]{
//                        currentUserId.append(userid[i])
//                    }
//                }
//            }
//            print(currentUserId)
        }
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
