//
//  CountryViewCell.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import Foundation
import UIKit

class CountryViewCell: UITableViewCell {
    static let identifier = "CountryViewCell"
    var message: String?
    var flagImage: UIImage?
    
    var messageView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var mainImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
//    private let myImageView: UIImageView = {
//        let myImageView = UIImageView()
//        myImageView.image = UIImage(named: "fff")
//        myImageView.contentMode = .scaleAspectFill
//        myImageView.clipsToBounds = true
//        return myImageView
//    }()
//
//    private let label: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = .systemFont(ofSize: 17, weight: .bold)
//        label.text = "Hello"
//        return label
//    }()
//
//    private let switcher: UISwitch = {
//        let switcher = UISwitch()
//        switcher.onTintColor = .blue
//        switcher.isOn = true
//        return switcher
//    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
        self.addSubview(mainImageView)
        self.addSubview(messageView)
        
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        messageView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        contentView.addSubview(switcher)
//        contentView.addSubview(label)
//        contentView.addSubview(myImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let message = message {
            messageView.text = message
        }
        if let image = flagImage {
            mainImageView.image = image
        }
//
//        let imageSize = contentView.frame.size.height-6

//        switcher.frame = CGRect(x: 5,
//                                y: 5,
//                                width: 100,
//                                height: contentView.frame.size.height-10)
//
//        label.frame = CGRect(x: 10 + switcher.frame.size.width,
//                             y: 0,
//                             width: contentView.frame.size.width - 10 - switcher.frame.size.width - imageSize,
//                             height: contentView.frame.size.height)
//
//        myImageView.frame = CGRect(x: contentView.frame.size.width-imageSize,
//                                 y: 3,
//                                 width: imageSize,
//                                 height: imageSize)
    }
}
