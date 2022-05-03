//
//  SearchViewController.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 27.04.22.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    let cellID = "\(SearchCollectionViewCell.self)"
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        textField.becomeFirstResponder()
        
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
        
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewModel.items.removeAll()
        collectionView.reloadData()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if updatedText.count >= 3 {
                viewModel.getSearchItems(query: updatedText) {
                    self.collectionView.reloadData()
                }
            }
            if updatedText.count < 3 {
                viewModel.items.removeAll()
                collectionView.reloadData()
            }
            
//            if updatedText.isEmpty {
//                viewModel.items.removeAll()
//                collectionView.reloadData()
//            } else {
//                viewModel.getSearchItems(query: updatedText) {
//                    self.collectionView.reloadData()
//                }
//            }
        }
        return true
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in            
            self.collectionView.reloadData()
        })
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchCollectionViewCell
        cell.configure(data: viewModel.itemsAtCell(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.92, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsVC.viewModel = DetailsViewModel(item: viewModel.itemsAtCell(index: indexPath.item))
        navigationController?.show(detailsVC, sender: nil)
    }
}
