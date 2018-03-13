//
//  LeaderboardsViewController.swift
//  AnimalCollector
//
//  Created by Quang Nguyen on 3/12/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LeaderboardsViewController: UITableViewController {

    private let reuseIdentifier = "leaderboardsUserCell"
    
    var curUserUID: String?
    var users: [User]?
    var sv: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        checkIfUserIsLoggedIn()
        initView()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        sv = UIViewController.displaySpinner(onView: self.view)
        fetchUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (users?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let user = users![indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = "Score: \(user.score ?? 0)"
        
        return cell
    }
    
    func initView() {
        users = [User]()
    }
    
    func fetchUsers() {
        let ref: DatabaseReference = Database.database().reference()
        let usersRef = ref.child("users")
        
        usersRef.observe(DataEventType .childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                user.name = dictionary["email"] as? String
                user.score = dictionary["score"] as? Int
                
                self.users?.append(user)
                self.users?.sort {
                    $0.score! > $1.score!
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            UIViewController.removeSpinner(spinner: self.sv!)
        }
    }
    
    func checkIfUserIsLoggedIn() {
        if let currentUser = Auth.auth().currentUser {
            self.curUserUID = currentUser.uid
        } else {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true, completion: nil)
    }
}

class UserCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}