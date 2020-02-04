//
//  ViewController.swift
//  Zigzag
//
//  Created by Tào Quỳnh on 3/30/19.
//  Copyright © 2019 Tào Quỳnh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ballImage: UIImageView!
    
    enum Direction {
        case right
        case down
        case left
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupBall()
        zigzag(direction: .right)
    }
    
    func setupBall() {
        ballImage.frame = CGRect(x: 0, y: 20, width: 30, height: 30)
    }

    func zigzag(direction: Direction) {
        switch direction {
        case .right:
            // kiểm tra: nếu toạ độ y của quả bóng lớn hơn chiều cao của view (thiết bị) thì gọi đến transform identity, CGAffineTransform.indentity sẽ xoá mọi ràng buộc thay đổi của quả bóng và đặt về mặc định
            if self.ballImage.frame.origin.y > self.view.frame.size.height {
                self.ballImage.transform = CGAffineTransform.identity
            }
            
            // dịch chuyển từ điểm bắt đầu sang phải,
            UIView.animate(withDuration: 2, animations: {
                self.ballImage.transform = CGAffineTransform(translationX: self.view.frame.size.width - self.ballImage.frame.width, y: self.ballImage.frame.origin.y - 20)
            }) { (_) in
                self.zigzag(direction: .down)
            }
            break
        case .down:
            // nếu quả bóng đang đứng bên phải thì dịch bóng từ trên xuống và giữ toạ độ x ở mép bên phải ( = self.view.frame.size.width - self.ballImage.frame.width)
            // nếu quả bóng đang đứng bên trái thì dịch bóng từ trên xuống và giữ toạ độ x ở mép trái ( =0)            
            UIView.animate(withDuration: 2, animations: {
                if self.ballImage.frame.origin.x != 0.0 {
                    self.ballImage.transform = CGAffineTransform(translationX: self.view.frame.size.width - self.ballImage.frame.width, y: self.ballImage.frame.origin.y + self.view.frame.height/5)
                } else {
                    self.ballImage.transform = CGAffineTransform(translationX: 0, y: self.ballImage.frame.origin.y + self.view.frame.height/5)
                }
            }) { (_) in
                // nếu quả bóng đang đứng bên trái thì dịch nó sang phải và ngược lại
                if self.ballImage.frame.origin.x == 0.0 {
                    self.zigzag(direction: .right)
                } else {
                    self.zigzag(direction: .left)
                }
            }
            break
        case .left:
            // dịch chuyển từ phải sang trái
            UIView.animate(withDuration: 2, animations: {
                self.ballImage.transform = CGAffineTransform(translationX: 0, y: self.ballImage.frame.origin.y - 20)
            }) { (_) in
                self.zigzag(direction: .down)
            }
            break
        }
    }

}

