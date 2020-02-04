//
//  ViewController.swift
//  ChessBoard
//
//  Created by Taof on 4/4/19.
//  Copyright © 2019 Taof. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var squareWidth: CGFloat = 0
    var squareHeight: CGFloat = 0
    var margin: CGFloat = 30.0
    
    var arrays = [0, 0, 0, 0, 0, 0, 0, 0,0]
    var queens = [[Object]]()
    
    var index = 0
    var total = 0
    
    var time: Timer!
    
    var images: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupControl()
        
        findQueen(i: 1, n: 8)
        total = queens.count

        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(swiped))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(swiped))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }

    @objc func swiped(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                swipeLeft()
            case UISwipeGestureRecognizer.Direction.left:
                swipeRight()
            default:
                break
            }
        }
    }
    
    func setupControl() {
        screenWidth = self.view.bounds.width
        screenHeight = self.view.bounds.height
        squareWidth = (self.view.bounds.width - margin*2) / 8.0
        self.view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        for row in 0..<8 {
            for col in 0..<8 {
                let isWhiteSquare = (row + col)%2 == 1 ? true: false
                drawSquare(isWhite: isWhiteSquare, width: squareWidth, row: row, col: col)
            }
        }
    }
    
    // vẽ ô bàn cờ
    func drawSquare(isWhite: Bool, width: CGFloat, row: Int, col: Int) {
        func computePositionOfSquare(row: Int, col: Int, squareWidth: CGFloat) -> CGRect {
            return CGRect(x: margin + CGFloat(col)*squareWidth, y: margin + CGFloat(row)*squareWidth, width: squareWidth, height: squareWidth)
        }
        
        let square = UIView(frame: computePositionOfSquare(row: row, col: col, squareWidth: width))
        square.backgroundColor = isWhite ? UIColor.white: UIColor.black
//        square.layer.borderWidth = 0.5
//        square.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(square)
    }
    
    // vị trí queen
    
    func placeQueen(isHas: Bool, row: Int, col: Int) {
        let queen = UIImageView(image: UIImage(named: "queen"))
        if isHas {
            queen.frame = CGRect(x: margin + CGFloat(col)*squareWidth, y: margin + CGFloat(row)*squareWidth, width: squareWidth, height: squareWidth)
            queen.contentMode = .scaleAspectFit
            images.append(queen)
            self.view.addSubview(queen)
        }
    }

    // tìm quân hậu từ hàng 1, bàn cờ nxn
    func findQueen(i: Int, n: Int){
        for j in 1...n{
            if isSafe(row: i, col: j){
                arrays[i] = j
                if i==n {
                    printResult(n: n)
                }
                
                findQueen(i: i+1, n: n)
            }
        }
    }

    // kiểm tra quân hậu
    func isSafe(row: Int, col: Int) -> Bool {
        for i in 1..<row {
            if arrays[i] == col || abs(i-row) == abs(arrays[i]-col) {
                return false
                
            }
        }
        return true
    }
    
    // in ra kết quả
    func printResult(n: Int){
        var objects = [Object]()
        var x = 1
        for i in 1...n{
            objects.append(Object(row: x, col: arrays[i]))
            x = x+1
        }
        
        queens.append(objects)
    }
    func swipeLeft() {
        for image in images{
            image.removeFromSuperview()
        }
        index = index - 1
        if index < 0 {
            index = 0
        }
        if index > 0 && index < total{
            for i in queens[index]{
                placeQueen(isHas: true, row: i.row-1, col: i.col-1)
            }
        }
    }
    
    func swipeRight() {
        for image in images{
            image.removeFromSuperview()
        }
        index = index + 1
        if index > total {
            index = total
        }
        if index > 0 && index < total{
            for i in queens[index]{
                placeQueen(isHas: true, row: i.row-1, col: i.col-1)
            }
        }
    }
}

