//
//  tableViewController.swift
//  bbsApp
//
//  Created by Yanrui Wang on 12/9/17.
//  Copyright © 2017 Yanrui Wang. All rights reserved.
//

import UIKit

let list = ["title1", "title2", "title3", "title3", "title4", "title5", "title6", "title7", "title8"]
let list1 = ["article1", "article2", "article3", "article3", "article4", "article5", "article6", "article7", "article8"]
var myIndex = 0

class tableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var userNameLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userNameLabel.text = email
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
