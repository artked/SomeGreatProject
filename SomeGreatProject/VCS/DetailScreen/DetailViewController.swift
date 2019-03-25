//
//  DetailViewController.swift
//  SomeGreatProject
//
//  Created by Developer007  on 25.03.2019.
//  Copyright © 2019 alexey. All rights reserved.
//

import Foundation
import UIKit

struct DetailViewControllerUX {
    static let backgroundColor = UIColor.white
    static let navigationBarBackgroundColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1.0)
    static let closeButtonTextColor = UIColor(red: 41/255.0, green: 41/255.0, blue: 41/255.0, alpha: 1.0)
}

class DetailViewController: UIViewController {
    
    private let name: String
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 16.0)
        label.numberOfLines = 0
        label.textColor = ListItemCellUX.priceTextColor
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        return label
    }()
    
    lazy var doneBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(close))
        
        button.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 16.0)!,
            NSAttributedString.Key.foregroundColor: DetailViewControllerUX.closeButtonTextColor],
                                          for: .normal)
        
        return button
    }()
    
    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func commonInit() {
        self.view.backgroundColor = DetailViewControllerUX.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = DetailViewControllerUX.navigationBarBackgroundColor
        self.title = "Detail screen"
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 18.0)!,
            NSAttributedString.Key.foregroundColor: DetailViewControllerUX.closeButtonTextColor
        ]
        
        self.navigationItem.rightBarButtonItem = doneBtn

        
        view.addSubview(nameLabel)
        
        nameLabel.text = name
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 29.0))
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -10))
        
    }
}
