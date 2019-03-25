//
//  ListRestarauntsCollectionViewController.swift
//  SomeGreatProject
//
//  Created by Developer007  on 25.03.2019.
//  Copyright © 2019 alexey. All rights reserved.
//

import Foundation
import UIKit

struct ListRestarauntsUX{
    static let backgroundColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1.0)
}

class ListRestarauntsCollectionViewController: UIViewController {
    
    private let viewModel: ListRestarauntsViewModel
    
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(viewModel: ListRestarauntsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
     
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.register(ListItemCell.self, forCellWithReuseIdentifier: ListItemCell.reuseIdentifier())
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func initViewModel() {
        
        viewModel.isLoading = { loading in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = loading
            }
        }
        
        viewModel.didUpdateItems = { [weak self] items in

            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ListRestarauntsUX.backgroundColor
    
        commonInit()
        initViewModel()
        
        viewModel.fetchItems()
        
    }
    
    func configureCell(cell: ListItemCell, indexPath: IndexPath){
        cell.updateName(name: viewModel.getName(row: indexPath.row))
        cell.updatePrice(price: viewModel.getPrice(row: indexPath.row))
        cell.updateFoodName(name: viewModel.getFoodName(row: indexPath.row))
        cell.updateImage(mainUrl: viewModel.getImageURL(row: indexPath.row))
    }
    
}

extension ListRestarauntsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 189.0)
    }
}

extension ListRestarauntsCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailViewController(name: self.viewModel.getName(row: indexPath.row))
        let navigationController = UINavigationController(rootViewController: vc)
        
        self.present(navigationController, animated: true, completion: nil)
        
    }
}

extension ListRestarauntsCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListItemCell.reuseIdentifier(), for: indexPath as IndexPath) as! ListItemCell
        
        configureCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    
}
