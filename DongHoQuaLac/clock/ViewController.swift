//
//  ViewController.swift
//  clock
//
//  Created by Tuan LE on 9/16/17.
//  Copyright © 2017 Leo LE. All rights reserved.
//

import UIKit
var isSoundOn: Bool = true
var kimgiay_show: Bool = true

class ViewController: UIViewController {

    @IBOutlet weak var switchQuaLac: UISwitch!
    @IBOutlet weak var switchKimGiay: UISwitch!
    @IBOutlet weak var imgQualac: UIImageView!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var btnText: UIButton!
    @IBAction func btnSound(_ sender: Any) {
        isSoundOn = !isSoundOn
        if isSoundOn {
            btnText.setTitle("Tắt tiếng", for: .normal)
            //imgPhoto.alpha=0
            //slider.value=0
        } else {
            btnText.setTitle("Bật tiếng", for: .normal)
            //imgPhoto.alpha=0.9
            //slider.value=0.9
        }
    }
    
    @IBOutlet weak var clockContainer: UIView?
    fileprivate var clockView: ClockView?
    
    var timer: Timer!
    let Max_Radian: CGFloat = CGFloat(CGFloat.pi )
    let Min_Radian: CGFloat = CGFloat(CGFloat.pi )
    var alpha: CGFloat = 0.0 // Góc quay
    var omega: CGFloat = 0.0005 // Vận tốc gốc
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initClockView()
        clockView?.start()
        imgPhoto.alpha=CGFloat(slider.value)
        imgQualac?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        //imgQualac.center=view.center
        
        //tick()
        //timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.001,
                                     target: self,
                                     selector: #selector(tick),
                                     userInfo: nil,
                                     repeats: true)
        
    }

    fileprivate func initClockView() {
        if clockView == nil {
            let view = ClockView.createFromNib()
            view.frame = clockContainer?.bounds ?? .zero
            view.translatesAutoresizingMaskIntoConstraints = true
            clockContainer?.addSubview(view)
            clockView = view
            clockView?.scale = 0.7
        }
    }
    
    
    @objc fileprivate func tick() {
        alpha += omega
        if (alpha > 0.25) || (alpha < -0.25) {
            omega = -omega
        }
        //imgQualac.transform = CGAffineTransform.init(rotationAngle: alpha)
        imgQualac?.transform = CGAffineTransform(rotationAngle: alpha)
        
    }
    
    
    
    
    @IBAction func sliderValueChange(_ sender: Any) {
        imgPhoto.alpha=CGFloat(slider.value)
    }
    
    @IBAction func switchSound(_ sender: Any) {
        isSoundOn = !isSoundOn
    }
    
    @IBAction func switchKimGiayChange(_ sender: Any) {
            kimgiay_show = !kimgiay_show
        }
    
    @IBAction func switchQuaLacChange(_ sender: Any) {
        if switchQuaLac.isOn {
            imgQualac.alpha=1
        } else {
            imgQualac.alpha=0
        }
    }
    
}

