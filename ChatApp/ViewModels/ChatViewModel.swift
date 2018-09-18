//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Ngo Van Hai on 9/14/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseDatabase

class ChatViewModel {
    
    var database = DatabaseReference.init()
    var name = "1"
    var dataChat = Variable<[Message]>([])
    var isFirstLoadData = Variable<Bool>(true)
    
    init() {
        
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getCountMsg() -> Int{
        return dataChat.value.count
    }
    
    func getMsgForItem(index: Int) -> Message{
        if index >= dataChat.value.count {
            return Message.init(name: "", text: "", postDate: "")
        } else {
            return dataChat.value[index]
        }
        
    }
    
    func loadData() {
        database = Database.database().reference()
        
        database.child("chat").queryOrdered(byChild: "postDate").observe(.value, with: { snapshot in
            self.dataChat.value.removeAll()
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                var dataBuff = [Message]()
                for snapshot in snapshots {
                    if let dataChat = snapshot.value as? [String: AnyObject] {
                        let nameUser = dataChat["name"] as? String
                        let textChat = dataChat["text"] as? String
                        
                        var postDate: Int64?
                        if let postDateValue = dataChat["postDate"] as? Int64 {
                            postDate = postDateValue
                        }
                        dataBuff.append(Message.init(name: nameUser!, text: textChat!, postDate: String(postDate!)))
                    }
                }
                //self.setData(data: dataBuff)
                self.dataChat.value.append(contentsOf: dataBuff)
                if self.isFirstLoadData.value {
                    self.isFirstLoadData.value = false
                }
            }
        })
        
    }
    /*
    func setData(data : [Message]) {
        name = ""
        for msg in data {
            if msg.name != name {
                name = msg.name!
                msg.isShowAvatar = true
            } else {
                msg.isShowAvatar = false
            }
            
        }
        self.dataChat.value.append(contentsOf: data)
    }*/
    
    func sendMessage(msg: String) {
        if msg.isEmpty {
            return
        }
        let values = ["name": name,
                      "text": msg,
                      "postDate": ServerValue.timestamp()] as [String : Any]
        database.child("chat").childByAutoId().setValue(values)
        
    }
}
