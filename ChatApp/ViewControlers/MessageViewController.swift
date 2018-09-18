//
//  ViewController.swift
//  ChatApp
//
//  Created by Ngo Van Hai on 9/12/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import RxSwift

class MessageViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputMessageView: UITextField!
    
    @IBOutlet weak var progressSuperView: UIView!
    var chatViewModel = ChatViewModel()
    var name: String = "1"
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
        _ = chatViewModel.dataChat
            .asObservable()
            .observeOn(MainScheduler.instance)
            .filter({$0.count > 0})
            .subscribe(onNext: {[weak self] newData in
                self?.tableView.reloadData()
                let index = IndexPath(row: newData.count == 0 ? 0 : newData.count - 1, section: 0)
                self?.tableView.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: false)
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        _ = chatViewModel.isFirstLoadData.asObservable().subscribe(onNext: { [weak self] isFirst in
            if !isFirst {
                self?.hideProgress()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        chatViewModel.setName(name: name)
        chatViewModel.loadData()
        
    }
    
    func hideProgress() {
        UIView.animate(withDuration: 0.3, animations: {
            self.progressSuperView.alpha = 0
        }) { (finished) in
            self.progressSuperView.isHidden = finished
        }
    }
    
    func initViews() {
        
        tableView.dataSource = self
        let cell = UINib(nibName: "MessageTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "MessageTableViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(setKeyboard(notification:)), name: .UIKeyboardWillShow, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
        progressView.startAnimating()
    }
    
    @IBAction func actionSend(_ sender: Any) {
        chatViewModel.sendMessage(msg: inputMessageView.text!)
        inputMessageView.text = ""
    }
    
    
    @objc func setKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            textFieldBottomConstraint.constant = keyboardFrame.height
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as! MessageTableViewCell
        cell.setView(msg: chatViewModel.getMsgForItem(index: indexPath.row), myName: name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatViewModel.getCountMsg()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func dismissKeyboard() {
        super.dismissKeyboard()
        textFieldBottomConstraint.constant = 0
    }
    
}

