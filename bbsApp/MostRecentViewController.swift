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
//var postTitles: NSString?
var postArticles = [String]()
var userid = [String]()


class MostRecentViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var myTableView: UITableView!
    
    var ref: DatabaseReference!
    
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
        cell.textLabel?.text = postTitles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        print("i am back")
//        postTitles.removeAll()
//        postArticles.removeAll()
        
//        let test = ref.child("users").observe(DataEventType.value) { (snapchat) in
////            print(snapchat.value)
//            if let userdic = snapchat.value as? NSDictionary{
////                print(userdic.allKeys)
//                userid = userdic.allKeys as! [String]
//                print(userid)
//                if let datadic = userdic.allValues as? NSDictionary{
//                    print(datadic)
//                }
//            }
        
            
            
//            if let dict = snapchat.value as? [String: String]{
//                //                postTitles.removeAll()
//                //                postArticles.removeAll()
//
//                postTitles.append(dict["title"]!)
//                postArticles.append(dict["article"]!)
//                userid.append(snapchat.key)
//                print("i am in")
//                DispatchQueue.main.async {
//                    self.myTableView.reloadData()
//                }
//            }
//        }
//        print(test)
        
        
        
        ref.child("users").observe(.childAdded) { (snapchat) in
            if let dict = snapchat.value as? NSDictionary{
//                print(dict["title"])
                let temTitles = dict["title"] as? NSString
                postTitles.append(temTitles! as String)
                print(postTitles)
            }
            
//            if let dict = snapchat.value as? [String: String]{
////                postTitles.removeAll()
////                postArticles.removeAll()
//                print(dict)
//                postTitles.append(dict["title"]!)
//                postArticles.append(dict["article"]!)
////                userid.append(snapchat.key)
//                print("i am in")
//                print(postTitles)
//                DispatchQueue.main.async {
//                    self.myTableView.reloadData()
//                }
//            }
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
