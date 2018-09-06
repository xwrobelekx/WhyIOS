//
//  PostTableViewController.swift
//  WhyIOS
//
//  Created by Kamil Wrobel on 9/5/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {
    
    //send data over to cell
    //conncet refresh and add button
    //create alert view
    //
    
    
    //MARK: - LifeCycle Function
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    



    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostController.shared.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? CellTableViewCell else {return UITableViewCell()}
        let post = PostController.shared.posts[indexPath.row]
        
        cell.newData = post
        
     

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    

    
    //MARK: - Actions
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        
        PostController.shared.fetchPosts { (post) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
   
    @IBAction func addButtonPressed(_ sender: Any) {
        showAlert()
        
    }
    
    
    //MARK: - AlertController
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Create New Post", message: nil, preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Enter full name..."
        }
        alert.addTextField { (cohortTextField) in
            cohortTextField.placeholder = "Enter cohort #..."
        }
        alert.addTextField { (reasonTextField) in
            reasonTextField.placeholder = "Enter the reason why?..."
        }
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let name = alert.textFields?[0].text, !name.isEmpty,
            let cohort = alert.textFields?[1].text,
            let reason = alert.textFields?[2].text, !reason.isEmpty else {return}
            
            let newPost = Post(name: name, reason: reason, cohort: cohort)
            PostController.shared.postReason(name: name, reason: reason, cohort: cohort, completion: { (success) in
                   alert.dismiss(animated: true, completion: nil)
            })
            self.tableView.reloadData()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true)
    }
    



}













