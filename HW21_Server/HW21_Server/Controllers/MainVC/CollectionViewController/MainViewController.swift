//
//  MainViewController.swift
//  HW21_Server
//
//  Created by Nata on 24.07.2021.
//

import UIKit

// MARK: - UserActions

enum UserActions: String, CaseIterable /* позволяет из перечисления сделать массив */ {
    case downloadImage = "Image of the Day"
    case users = "Users"
}

// MARK: - MainViewController

class MainViewController: UICollectionViewController {
    
    // MARK: Private

    // массив наших Actions
    private let userActions = UserActions.allCases

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserActionCell", for: indexPath) as! UserActionCell
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        return cell
    }

    // MARK: - UICollectionViewDelegate

   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]

        switch userAction {
        case .downloadImage:
            performSegue(withIdentifier: "goToImage", sender: self)
        case .users:
            performSegue(withIdentifier: "Users", sender: self)
        }
    }
    
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Users" {
            let coursesVC = segue.destination as! UsersVC
            coursesVC.fetchData()
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (UIScreen.main.bounds.width - 20), height: 80)
    }
}
