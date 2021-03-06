//
//  tableViewController.swift
//  bbsApp
//
//  Created by Yanrui Wang on 12/9/17.
//  Copyright © 2017 Yanrui Wang. All rights reserved.
//

import UIKit
import Firebase

var myIndex = 0
var postTitles = [String]()
var postArticles = [String]()
var userid = [String]()

class tableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var myTableView: UITableView!
    
    var ref: DatabaseReference!
    
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
//        ref.observe(DataEventType.value, with: { (snapshot) in
//
//            let data = snapshot.value as! NSDictionary
//
//            let data1 = data.allKeys as NSArray
//            print(data1.count)
//
//        })
        postTitles.removeAll()
        postArticles.removeAll()
        ref.child("users").observe(.childAdded) { (snapchat) in
            if let dict = snapchat.value as? [String: String]{
//                print(dict)
                postTitles.append(dict["title"]!)
                postArticles.append(dict["article"]!)
                userid.append(snapchat.key)
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
        }

//        while postTitles?.count == 0{
//            sleep(1)
//        }
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
