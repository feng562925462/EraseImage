//
//  ViewController.swift
//  YJEraseImage
//
//  Created by cool on 2018/4/24.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGestureRecognizer(_:)))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(pan)
        
    }

    @objc func panGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        //获得当前触摸点
        let curPoint = sender.location(in: sender.view)
        
        //确定擦除区域
        let w : CGFloat = 50
        let h : CGFloat = 50
        
        let clearRect = CGRect(x: curPoint.x - w / 2, y: curPoint.y - h / 2, width: w, height: h)
        
        //开启位图上下文
        UIGraphicsBeginImageContextWithOptions(sender.view!.frame.size, false, 0)
        //获取当前上下文
        let ctx = UIGraphicsGetCurrentContext()
        //渲染控件
        sender.view?.layer.render(in: ctx!)
        
        //清除上下文某一部分
        ctx?.clear(clearRect)
        
        //从上下文中生成一张图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭上下文
        UIGraphicsEndImageContext()
        
        self.imageView.image = image
    }
    
    
}

