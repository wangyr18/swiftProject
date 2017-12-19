//
//  MyPostsViewController.swift
//  bbsApp
//
//  Created by Yu Ma on 12/16/17.
//  Copyright © 2017 Yanrui Wang. All rights reserved.
//

import UIKit
import Firebase

class MyPostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref: DatabaseReference!
    var currentTitle = [String]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func backToMyPostsViewController(_sender: UIStoryboardSegue){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? textViewController{
            destination.segueFromController = "MyPostsViewController"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTitle.count
        //        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.backgroundColor = UIColor(red: 210/255, green: 198/255, blue: 148/255, alpha: 1)
        cell.textLabel?.text = currentTitle[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        uid = currentUserId[indexPath.row]
        performSegue(withIdentifier: "myPost", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 210/255, green: 198/255, blue: 148/255, alpha: 1)
        // Do any additional setup after loading the view.
        currentTitle.removeAll()
        
        for i in 0 ..< userid.count{
            if author[i] == email!{
                if currentUserId.count == 0{
                    currentUserId.append(userid[i])
                }
                else if userid[i] != currentUserId[currentUserId.count-1]{
                    currentUserId.append(userid[i])
                }
            }
        }
        print(currentUserId)
        ref = Database.database().reference()
        for i in 0 ..< currentUserId.count{
            let uid = currentUserId[i]
            ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapchat) in
                if let dict = snapchat.value as? [String: Any]{
                    let temTitle = dict["title"] as? NSString
                    self.currentTitle.append(temTitle! as String)
                    print(self.currentTitle)
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                }
            })
        }
//        print(currentTitle)
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
