//
//  CommentViewController.swift
//  Swift6FireStore02
//
//  Created by Manabu Kuramochi on 2021/05/08.
//

import UIKit
import Firebase
import FirebaseFirestore

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    var idString = String()
    var kaitouString = String()
    var userName = String()
    var dataSets:[CommentModel] = []
    
    let db = Firestore.firestore()
    
    
    @IBOutlet weak var kaitouLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        loadData()
    }
    
    
    
    func loadData() {
        
        db.collection("Answers").document(idString).collection("comments").order(by: "postDate").addSnapshotListener { snapShot, error in
            
            self.dataSets = []
            if error != nil {
                
                return
            }
            
            if let snapShotDoc = snapShot?.documents {
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    if let userName = data["userName"] as? String, let comment = data["comment"] as? String, let postDate = data["postDate"] as? Double {
                        
                        
                        let commentModel = CommentModel(userName: userName, comment: comment, postData: postDate)
                        
                        self.dataSets.append(commentModel)
                        
                    }
                    
                }
                self.tableView.reloadData()
                
                
            }
            
            
        }
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        tableView.rowHeight = 200
        
        let commentLabel = cell.contentView.viewWithTag(1) as! UILabel
        commentLabel.numberOfLines = 0
        commentLabel.text = "\(self.dataSets[indexPath.row].userName)くん\n\(self.dataSets[indexPath.row].comment)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
        
    }
    
    
    
    @IBAction func sendAction(_ sender: Any) {
        
        db.collection("Answers").document(idString).collection("comments").document().setData(["userName":userName as Any, "comment":textfield.text! as Any, "postDate":Date().timeIntervalSince1970])
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
