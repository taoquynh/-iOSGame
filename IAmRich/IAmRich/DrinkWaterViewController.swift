//
//  DrinkWaterViewController.swift
//  IAmRich
//
//  Created by Taof on 10/22/19.
//  Copyright © 2019 Taof. All rights reserved.
//

import UIKit

class DrinkWaterViewController: UIViewController {

    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    
    var timer: Timer! // khai báo biến timer
    var dem: Int = 0
    var count = 30
    var x: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        countLabel.text = String(count)
        dem = count
        x = (view.frame.size.height) / CGFloat(count)
        print(x)
        // khởi tạo biến timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runLoop), userInfo: nil, repeats: true)
    }

    // func kế thừa objc
    @objc func runLoop(){
        dem -= 1
        countLabel.text = String(dem)
        if dem < 1{
            // dừng thời gian
            timer.invalidate()
        }
        
        waterView.frame = CGRect(x: 0, y: waterView.frame.origin.y + x, width: waterView.frame.width, height: waterView.frame.height)
    }
}
