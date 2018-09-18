//
//  Message.swift
//  ChatApp
//
//  Created by Ngo Van Hai on 9/14/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation

class Message {
    var name: String?
    var text: String?
    var postDate: String?
    var isShowAvatar: Bool = true
    
    init(name: String, text: String, postDate: String) {
        self.name = name
        self.text = text
        self.postDate = postDate
        self.isShowAvatar = true
    }
}
