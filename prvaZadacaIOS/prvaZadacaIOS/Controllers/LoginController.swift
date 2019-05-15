//
//  LoginController.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 12/05/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func signInButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        let loginService = LoginService()
        if let username = username.text,
            let password = password.text{
            if let value = userDefaults.string(forKey: username){
                let loggedValue = "logged"
                if (value == loggedValue){
                    //prebaciti na novi view controller
                    let secondViewController = FirstViewController(nibName: "FirstViewController", bundle: nil)
                    self.present(secondViewController, animated: true, completion: nil)
                }
            }else{
                loginService.loginFunction(urlString: "https://iosquiz.herokuapp.com/api/session",username: username, password: password) { (e) in
                    DispatchQueue.main.async {
                        if let podaci = e as? [String:Any] {
                            if let message = podaci["token"]{
                                userDefaults.set("logged", forKey: username)
                                let secondViewController = FirstViewController(nibName: "FirstViewController", bundle: nil)
                                self.present(secondViewController, animated: true, completion: nil)
                            }else{
                                print("error")
                            }
                            
                            //print(podaci["token"])
                            //print("POKUSAJ")
                        }
                    }
                }
                //dohvatiti ispravnost lozinke i usernamea
                //ako je dobro prebaciti na novi controler
            }
           
            
            
            
        }
        
//        let userDefaults = UserDefaults.standard userDefaults.set(“Some string”, forKey: “key”)
//
//        let userDefaults = UserDefaults.standard
//        let value = userDefaults.string(forKey: )
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
