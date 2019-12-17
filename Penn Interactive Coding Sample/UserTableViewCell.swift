//
//  UserTableViewCell.swift
//  Penn Interactive Coding Sample
//
//  Created by Mark Adler on 12/17/19.
//  Copyright © 2019 Mark Adler. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    var user: User?
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var avatarImage:UIImageView!
    @IBOutlet weak var badgeCountGoldLabel:UILabel!
    @IBOutlet weak var badgeCountSilverLabel:UILabel!
    @IBOutlet weak var badgeCountBronze:UILabel!
    @IBOutlet weak var downloadingProgressView:UIActivityIndicatorView!
    
    func loadUser(user:User) {
        
        self.user = user
        nameLabel.text = user.name
        badgeCountBronze.text = String(user.badgeCountBronze)
        badgeCountSilverLabel.text = String(user.badgeCountSilver)
        badgeCountGoldLabel.text = String(user.badgeCountGold)
        
        if let avatar = user.avatar {
            // Already have a saved avatar
            avatarImage.image = avatar
            downloadingProgressView.isHidden = true
        } else {
            
            DispatchQueue.global(qos: .userInitiated).async {
                user.downloadAvatarImageFromWeb() // Download in background thread
                // Update UI on main thread
                DispatchQueue.main.async {
                    self.avatarImage.image = user.avatar
                    self.downloadingProgressView.isHidden = true
                }
            }

            // Handle downloading the image
            downloadingProgressView.isHidden = false
            if user.avatar != nil {
            }
        }
        
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
