//
//  LoginViewController.swift
//  LessonOne
//
//  Created by Nulrybek Karshyga on 7/7/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTetField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTetField.text ?? ""
        print("Username: " + username + "\nPassword: " + password)
        if username.count == 0 && password.count == 0 { return }
        
        
        
    }
    @IBAction func loginButton(_ sender: UIButton) {
        //reference login module storyboard
        //get the scene/object by id
        //perform present/push
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ViewController")
        navigationController?.pushViewController(vc, animated: true)
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
