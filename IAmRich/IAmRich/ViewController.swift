//
//  ViewController.swift
//  IAmRich
//
//  Created by Taof on 10/22/19.
//  Copyright © 2019 Taof. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rubyImageView: UIImageView!
    
    @IBOutlet weak var amRichLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rubyImageView.alpha = 0
        amRichLabel.alpha = 0
        amRichLabel.center = CGPoint(x: view.center.x, y: view.center.y + 500 )
        print(view.frame)
    
        UIView.animate(withDuration: 3) {
            self.rubyImageView.alpha = 1
            self.amRichLabel.alpha = 1
            self.amRichLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 100)
        }
    }


}

