//
//  SettingViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setBackGroundColor()
        settingtableView.backgroundColor = UIColor.black

    }
    
    func configureTableView() {
        
        settingtableView.delegate = self
        settingtableView.dataSource = self
        
        let xib1 = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        settingtableView.register(xib1, forCellReuseIdentifier: "SettingsTableViewCell")
        
        let xib2 = UINib(nibName: "SettingsProfileTableViewCell", bundle: nil)
        settingtableView.register(xib2, forCellReuseIdentifier: "SettingsProfileTableViewCell")
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = settingtableView.dequeueReusableCell(withIdentifier: "SettingsProfileTableViewCell", for: indexPath) as! SettingsProfileTableViewCell
            
            return cell
        } else {
            let cell = settingtableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
            
            cell.titleLabel.text = Settings[indexPath.row]
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else {
            return 44
        }
    }
}
