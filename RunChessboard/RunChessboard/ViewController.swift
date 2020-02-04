//
//  ViewController.swift
//  RunChessboard
//
//  Created by Taof on 11/2/19.
//  Copyright © 2019 Taof. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var squareWidth: CGFloat = 0
    var squareHeight: CGFloat = 0
    var margin: CGFloat = 30.0
    var timer : Timer!
    let queen = UIImageView(image: UIImage(named: "queen"))
    var max = 7
    var i = 0
    var j = 0
    var arrow = "goToLeft"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpControl()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(gameLoop1), userInfo: nil, repeats: true)
    }
    
    func drawSquare(isWhite: Bool, width: CGFloat, row: Int, col: Int) {
        func computePositionOfSquare(row: Int, col: Int, squareWidth: CGFloat) -> CGRect {
            return CGRect(x: margin + CGFloat(col) * squareWidth, y: 100 + CGFloat(row) * squareWidth, width: squareWidth, height: squareWidth)
        }
        
        let square = UIView(frame: computePositionOfSquare(row: row, col: col, squareWidth: width))
        square.backgroundColor = isWhite ? UIColor.white : UIColor.black
        self.view.addSubview(square)
    }
    
    func setUpControl() {
        screenWidth = self.view.bounds.width
        screenHeight = self.view.bounds.height
        squareWidth = (self.view.bounds.width - margin * 2.0) / 8.0
        self.view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        
        for row in 0..<8 {
            for col in 0..<8 {
                let isWhiteSquare = (row + col) % 2 == 1 ? true: false
                drawSquare(isWhite: isWhiteSquare, width: squareWidth, row: row, col: col)
            }
        }
        
        placeQueen(isWhite: true, row: 0, col: 0)
    }
    
    func moveQueen(row: Int, col: Int) {
        queen.frame = CGRect(x: margin + CGFloat(col) * squareWidth, y: 100 + CGFloat(row) * squareWidth, width: squareWidth, height: squareWidth)
    }
    
    func placeQueen(isWhite: Bool, row: Int, col: Int) {
        queen.contentMode = .scaleAspectFit
        self.view.addSubview(queen)
        moveQueen(row: row, col: col)
    }
    
    @objc func gameLoop1(){
        highlight(row: i, col: j)
        if i == 0 && j < max{
            j += 1
            moveQueen(row: i, col: j)
        } else if i < max && j == max {
            i += 1
            moveQueen(row: i, col: j)
        } else if i == max && j > 0 {
            j -= 1
            moveQueen(row: i, col: j)
        } else if i > 0 && j == 0 {
            i -= 1
            moveQueen(row: i, col: j)
        }
    }
    
    @objc func gameLoop2(){
        if i == 0 && j < max{
            j += 1
            arrow = "goToRight"
        } else if j == max && i == 0 {
            i = 1
            arrow = "goToLeft"
        } else if j <= max && j > 0{
            if arrow == "goToRight" {
                j += 1
            }else if arrow == "goToLeft"{
                j -= 1
            }
        } else if j >= 0 && i == 1{
            i = 2
            arrow = "goToRight"
            print(i, j)
        } else if j == max && i == 2{
            i = 3
        }
        
        moveQueen(row: i, col: j)
    }
    
    @objc func gameLoop3(){
        
        highlight(row: i , col: j)
        if j < max && i == 0{
            j += 1
        }else if i < max && j == max {
            i += 1
        }else if i  == max && j > 0 {
            j -= 1
        }else if j == 0 && i > 1  {
            i -= 1
        }else if i == 1 && j < max - 1{
            j += 1
        }else if j == max - 1 && i < max - 1{
            i += 1
        }else if i == max - 1 && j > 1{
            j -= 1
        }else if j == 1 && i > 2 {
            i -= 1
        }else if i == 2 && j < max - 2{
            j += 1
        }else if j == max - 2 && i < max - 2{
            i += 1
        }else if i == max - 2 && j > 2{
            j -= 1
        }else if j == 2 && i > 3{
            i -= 1
        }else if i == 3 && j < max - 3{
            j += 1
        }else if j == max - 3 && i < max - 3{
            i += 1
        }else if i == max - 3 && j > max - 4{
            j -= 1
            timer.invalidate()
        }

        placeQueen(isWhite: true, row: i, col: j)
    }
    
    @objc func gameLoop4(){
        
        highlight(row: i , col: j)
        if i < max && j == 0{
            i += 1
        }else if i + j == max && i <= max && j < max {
            j += 1
            i -= 1
        }else if i < max && j == max{
            i += 1
        }else if i == j {
            i -= 1
            j -= 1
        }
        moveQueen(row: i, col: j)
        
    }
    
    func highlight(row: Int, col: Int) {
        let redView = UIImageView(frame: CGRect(x: margin + CGFloat(col) * squareWidth, y: 100 + CGFloat(row) * squareWidth, width: squareWidth, height: squareWidth))
        redView.image = UIImage(named: "queen")
        redView.contentMode = .scaleAspectFit
//         let redView = UIView(frame: CGRect(x: margin + CGFloat(col) * squareWidth, y: 100 + CGFloat(row) * squareWidth, width: squareWidth, height: squareWidth))
//        redView.backgroundColor = UIColor.red
        redView.alpha = 0.8
        view.addSubview(redView)
        UIView.animate(withDuration: 1, animations: {
            redView.alpha = 0.0
        }) { (_) in
            redView.removeFromSuperview()
        }
        
    }
}

