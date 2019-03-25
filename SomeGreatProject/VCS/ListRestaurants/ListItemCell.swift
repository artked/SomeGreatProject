//
//  ListItemCell.swift
//  SomeGreatProject
//
//  Created by Developer007  on 25.03.2019.
//  Copyright © 2019 alexey. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

struct ListItemCellUX{
    static let backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
    static let buttonBackgroundColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
    static let buttonTitleColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let buttonTitle = "See detail"
    static let pictureBackgroundColor = UIColor.black
    static let nameTextColor = UIColor.white
    static let priceTextColor = UIColor.black
    static let foodNameTextColor = UIColor.black
}

class ListItemCell: UICollectionViewCell {
    
    lazy var button: UIButton = {
        let buttonTemp = UIButton(type: UIButton.ButtonType.custom)
        buttonTemp.translatesAutoresizingMaskIntoConstraints = false
        buttonTemp.backgroundColor = ListItemCellUX.buttonBackgroundColor
        buttonTemp.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14.0)
        buttonTemp.setTitleColor(ListItemCellUX.buttonTitleColor, for: .normal)
        buttonTemp.setTitle(ListItemCellUX.buttonTitle, for: .normal)
        buttonTemp.isUserInteractionEnabled = false
        return buttonTemp
    }()
    
    lazy var picture: UIImageView = {
        let imageViewTemp = UIImageView(frame: CGRect.zero)
        imageViewTemp.backgroundColor = ListItemCellUX.pictureBackgroundColor
        imageViewTemp.translatesAutoresizingMaskIntoConstraints = false
        imageViewTemp.clipsToBounds = true
        imageViewTemp.contentMode = UIView.ContentMode.center
        return imageViewTemp
    }()
    
    lazy var name: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.numberOfLines = 0
        label.textColor = ListItemCellUX.nameTextColor
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 16.0)
        label.numberOfLines = 0
        label.textColor = ListItemCellUX.priceTextColor
        
        label.sizeToFit()
        return label
    }()
    
    lazy var food_name: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 16.0)
        label.numberOfLines = 0
        label.textColor = ListItemCellUX.foodNameTextColor
        
        label.sizeToFit()
        return label
    }()
    
    
    lazy var detailContent: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    static func reuseIdentifier() -> String {
        return "RestarauntCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.contentView.backgroundColor = ListItemCellUX.backgroundColor
        
        self.contentView.addSubview(button)
        self.contentView.addSubview(picture)
        picture.addSubview(name)
        self.contentView.addSubview(detailContent)
        detailContent.addSubview(price)
        detailContent.addSubview(food_name)
    }
    
    func updateName(name: String){
        DispatchQueue.main.async { [weak self] in
            self?.name.text = name
        }
    }
    
    func updatePrice(price: String){
        DispatchQueue.main.async { [weak self] in
            self?.price.text = price
        }
    }
    
    func updateFoodName(name: String){
        DispatchQueue.main.async { [weak self] in
            self?.food_name.text = name
        }
    }
    
    func updateImage(mainUrl: String){
        
        picture.sd_setImage(with: URL(string: mainUrl)) { [weak self] (image, _, _, url) in
            
            if (image != nil && mainUrl.caseInsensitiveCompare((url?.absoluteString)!) == ComparisonResult.orderedSame){
                
                DispatchQueue.main.async { [weak self] in
                    self?.picture.image = image?.crop(to: CGSize(width: self!.picture.frame.width, height: self!.picture.frame.height))
                }
                
            }
        }
        
        
    }
    
    private func makeConstraints() {
        
        self.contentView.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 36.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.button, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.button, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.button, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: picture, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 95.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.picture, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 10.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.picture, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 10.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.picture, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: -10.0))
        
        picture.addConstraint(NSLayoutConstraint(item: name, attribute: .centerX, relatedBy: .equal, toItem: picture, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        picture.addConstraint(NSLayoutConstraint(item: name, attribute: .centerY, relatedBy: .equal, toItem: picture, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        picture.addConstraint(NSLayoutConstraint(item: name, attribute: .leading, relatedBy: .equal, toItem: picture, attribute: .leading, multiplier: 1.0, constant: 10))
        picture.addConstraint(NSLayoutConstraint(item: name, attribute: .trailing, relatedBy: .equal, toItem: picture, attribute: .trailing, multiplier: 1.0, constant: -10))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.detailContent, attribute: .top, relatedBy: .equal, toItem: self.picture, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.detailContent, attribute: .bottom, relatedBy: .equal, toItem: self.button, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.detailContent, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.detailContent, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        
        detailContent.addConstraint(NSLayoutConstraint(item: self.price, attribute: .trailing, relatedBy: .equal, toItem: detailContent, attribute: .trailing, multiplier: 1.0, constant: -10.0))
        detailContent.addConstraint(NSLayoutConstraint(item: self.price, attribute: .centerY, relatedBy: .equal, toItem: detailContent, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        detailContent.addConstraint(NSLayoutConstraint(item: self.food_name, attribute: .leading, relatedBy: .equal, toItem: detailContent, attribute: .leading, multiplier: 1.0, constant: 10.0))
        detailContent.addConstraint(NSLayoutConstraint(item: self.food_name, attribute: .centerY, relatedBy: .equal, toItem: detailContent, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
}

extension UIImage {
    
    func crop(to:CGSize) -> UIImage {
        guard let cgimage = self.cgImage else { return self }
        
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        
        guard let newCgImage = contextImage.cgImage else { return self }
        
        let contextSize: CGSize = contextImage.size
        
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height
        
        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height
        
        if to.width > to.height {
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if to.width < to.height {
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else {
            if contextSize.width >= contextSize.height {
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ 
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)
        
        
        guard let imageRef: CGImage = newCgImage.cropping(to: rect) else { return self}
        
        
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        UIGraphicsBeginImageContextWithOptions(to, false, self.scale)
        cropped.draw(in: CGRect(x: 0, y: 0, width: to.width, height: to.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resized ?? self
    }
}
