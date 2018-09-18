//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Ngo Van Hai on 9/14/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let des = UIScreen.main.bounds
    
    @IBOutlet weak var okButtonView: UIButton!
    @IBOutlet weak var avatarCollectionView: UICollectionView!
    
    var indexSelected = 1
    var loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        _ = loginViewModel.isValid.asObservable().subscribe(onNext: { [weak self] isValid in
            self?.okButtonView.isEnabled = isValid
            self?.okButtonView.backgroundColor = isValid ? .cyan : .gray
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    func initViews() {
        avatarCollectionView.dataSource = self
        avatarCollectionView.delegate = self
        
        let cell = UINib(nibName: "AvatarCollectionViewCell", bundle: nil)
        avatarCollectionView.register(cell, forCellWithReuseIdentifier: "AvatarCollectionViewCell")
        loginViewModel.loginAnonymous()
    }
    
    @IBAction func goToChatRom(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let listViewController = storyBoard.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
        listViewController.name = String(indexSelected)
        self.present(listViewController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCollectionViewCell", for: indexPath) as! AvatarCollectionViewCell
        cell.setImage(index: indexPath.row + 1, selectedPos: indexSelected)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (des.width - 40)/4, height: des.width/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexSelected = indexPath.row + 1
        collectionView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
