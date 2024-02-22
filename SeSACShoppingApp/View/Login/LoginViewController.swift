//
//  LoginViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2/22/24.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.textColor = .white
        
        codeTextField.addTarget(self, action: #selector(codeTextFieldChanged), for: .editingChanged)
        
        viewModel.code.bind { value in
            print(value)
            self.resultLabel.text = value
        }
    }
    
    @objc func codeTextFieldChanged() {
        viewModel.code.text = codeTextField.text ?? ""
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
    }
}
