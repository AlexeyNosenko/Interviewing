//
//  LoginViewController.swift
//  Interviewing
//
//  Created by Алексей on 22.12.2017.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var touchIDButton: UIButton!
    // MARK: - Variables
    let loginButtonTag = 0
    let registrationButtonTag = 1
    let touchIDButtonTag = 2
    
    let loginKeyName = "keyLogin"
    let keychainLoginKeyName = "keychainKeyLogin"
    
    let touchID = TouchIDAuth()
    
    var passwordItems : [KeychainPasswordItem] = []
    
    override func viewDidLoad() {
        touchIDButton.isHidden = touchID.canTouchIDAuth()
    }
    
    func showMessage(title: String, message: String?){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let alertOkAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertOkAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func login(_ sender: UIButton) {
        guard let login = loginTextField.text,
            let password = passwordTextField.text,
            !login.isEmpty && !password.isEmpty else {
                showMessage(title: "Ошибка", message: "Не верно задан логин или пароль")
                return
        }
        
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if sender.tag == registrationButtonTag {
            //let existsLogin = UserDefaults.standard.bool(forKey: loginKeyName)
            
            do{
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: login, accessGroup: KeychainConfiguration.accessGroup)
                try passwordItem.savePassword(password)
            } catch {
                fatalError("=(")
            }
            showMessage(title: "Информация", message: "Регистрация успешно завершена")
        } else if sender.tag == loginButtonTag{
            if checkLogin(login: login, password: password){
                showMessage(title: "Информация", message:"Вход успешно произведен")
            } else{
                showMessage(title: "Ошибка", message: "Не верно задан логин или пароль")
            }
        } else if sender.tag == touchIDButtonTag {
            touchID.authenticateUser(completion: {[weak self] error in
                self?.showMessage(title: "Информация", message: error)
            })
        }
    }
    
    func checkLogin(login: String, password: String) -> Bool{
        do{
            let passwordItem = KeychainPasswordItem.init(service: KeychainConfiguration.serviceName, account: login, accessGroup: KeychainConfiguration.accessGroup)
            let keychainPass = try passwordItem.readPassword()
            return password == keychainPass
        } catch{
            return false
        }
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
