//
//  Categroys.swift
//  STUIComponent
//
//  Created by XuAzen on 16/2/29.
//  Copyright © 2016年 st company. All rights reserved.
//

import Foundation

extension String
{
    var length: Int {
        get {
            return characters.count
        }
    }
}

extension UIColor {
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(Double(arc4random_uniform(100)) * 0.01), green: CGFloat(Double(arc4random_uniform(100)) * 0.01), blue: CGFloat(Double(arc4random_uniform(100)) * 0.01), alpha: 1)
    }
}