//
//  ViewController.swift
//  Penn Interactive Coding Sample
//
//  Created by Mark Adler on 12/17/19.
//  Copyright © 2019 Mark Adler. All rights reserved.
//

import UIKit


class ViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var usersTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var Users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTable.dataSource = self
        usersTable.delegate = self
        
        // Do any additional setup after loading the view.
        //usersTable.isHidden = true

        let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = usersTable.center
            activityIndicator.isHidden = false
            self.view.addSubview(activityIndicator)
        
    
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            self.Users = User.getUsersFromStackOverflow() ?? [User]() // Load Users on background thread
            DispatchQueue.main.async {
                self.usersTable.isHidden = false
                activityIndicator.isHidden = true
                self.usersTable.reloadData()
                
            }
            

        }

            //downloadingProgressView.isHidden = false
        


    }

    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    // MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let reuseID = "UserCell"
        let cell : UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseID) as! UserTableViewCell
        cell.loadUser(user:Users[row])
        
        return cell
        
        
        
    }
}

