//
//  IconDetailViewController.swift
//  CollectionViewDemo
//
//  Created by wyn on 2020/5/13.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

class IconDetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.text = icon?.name
        }
    }
    
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = icon?.description
            descriptionLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet{
            iconImageView.image = UIImage(named: icon?.imageName ?? "")
        }
    }
    
    @IBOutlet var priceLabel: UILabel! {
        didSet {
            if let icon = icon {
                priceLabel.text = "$\(icon.price)"
            }
        }
    }
    
    var icon: Icon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
