//
//  MessageTableViewCell.swift
//  ChatApp
//
//  Created by Ngo Van Hai on 9/12/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var contentMsg: UILabel!
    @IBOutlet weak var myContenMsg: UILabel!
    @IBOutlet weak var superContentView: UIView!
    @IBOutlet weak var superMyContentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setView(msg: Message, myName: String) {
        
        if msg.name != myName {
            avatarImage.image = UIImage(named: msg.name!)
            avatarImage.isHidden = false
            /*if msg.isShowAvatar {
                //avatarImage.image = UIImage(named: msg.name!)
                avatarImage.isHidden = false
            } else {
                avatarImage.isHidden = true
            }*/
            superContentView.isHidden = false
            superMyContentView.isHidden = true
            contentMsg.text = msg.text
            myContenMsg.text = ""
        } else {
            avatarImage.isHidden = true
            superContentView.isHidden = true
            superMyContentView.isHidden = false
            contentMsg.text = ""
            myContenMsg.text = msg.text
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
