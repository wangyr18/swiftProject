//
//  MyLikesViewController.swift
//  bbsApp
//
//  Created by Yu Ma on 12/16/17.
//  Copyright © 2017 Yanrui Wang. All rights reserved.
//

import UIKit
import Firebase

class MyLikesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    var users = [String]()
    var titles = [String]()
    var likeId = [String]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
        //        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.backgroundColor = UIColor(red: 210/255, green: 198/255, blue: 148/255, alpha: 1)
        cell.textLabel?.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0 ..< allTitles.count{
            if titles[indexPath.row] == allTitles[i]{
                uid = userid[i]
                break
            }
        }
        performSegue(withIdentifier: "myLike", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 210/255, green: 198/255, blue: 148/255, alpha: 1)
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        ref.child("likes").observe(.childAdded) { (snapchat) in
            if let dict = snapchat.value as? NSDictionary{
                let temTitle = dict["title"] as? NSString
                let temT = temTitle! as String
//                self.titles.append(temT)
                let temUser = dict["user"] as? NSString
                let temU = temUser! as String
                if temU == email!{
                    self.titles.append(temT)
                }
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
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
