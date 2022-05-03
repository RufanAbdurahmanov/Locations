//
//  CategoriesViewController.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 25.04.22.
//

import UIKit

class CategoriesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = CategoryViewModel()
    let cellID = "\(CategoryCollectionViewCell.self)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor =  UIColor(displayP3Red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        view.backgroundColor = .white
        collectionView.backgroundColor = .clear
        viewModel.configureItems()
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        navigationController?.show(searchVC, sender: nil)
    }
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCollectionViewCell
        cell.configure(data: viewModel.itemAtCell(index: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.92, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listVC = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        
        let title = viewModel.itemAtCell(index: indexPath.item).title
        listVC.viewModel = ListViewModel(categoryName: title, categories: viewModel.getItems())
        navigationController?.show(listVC, sender: nil)
    }
    
}
