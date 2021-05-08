//
//  LoginViewController.swift
//  Swift6FireStore02
//
//  Created by Manabu Kuramochi on 2021/05/04.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var textfield: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    func login() {
        
        Auth.auth().signInAnonymously { (result, error) in
            
            let user = result?.user
            print(user)
            
            UserDefaults.standard.set(self.textfield.text, forKey: "userName")
            
            let viewVC = self.storyboard?.instantiateViewController(identifier: "viewVC") as! ViewController
            self.navigationController?.pushViewController(viewVC, animated: true)
            
        }
        
    }
    
    
    
    @IBAction func done(_ sender: Any) {
        
        login()
        
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
