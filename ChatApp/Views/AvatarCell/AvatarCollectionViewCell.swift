//
//  AvatarCollectionViewCell.swift
//  ChatApp
//
//  Created by Ngo Van Hai on 9/14/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(index: Int, selectedPos: Int) {
        avatarImageView.image = UIImage(named: String(index))
        if index == selectedPos {
            overView.isHidden = false
        } else {
            overView.isHidden = true
        }
    }

}
