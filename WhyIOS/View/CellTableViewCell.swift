//
//  CellTableViewCell.swift
//  WhyIOS
//
//  Created by Kamil Wrobel on 9/5/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    //MARK: - Properties
    var newData : Post? {
        didSet{
            updateViews()
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cohortLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    
    
    
    
    //MARK: - Helper Methods
    func updateViews(){
        //check threads
        guard let post = newData else {return}
        DispatchQueue.main.async {
            self.nameLabel.text = post.name
            self.cohortLabel.text = post.cohort
            self.reasonLabel.text = post.reason
        }
    
        
        
    }
    

}
