//
//  LineSpacingLabel.swift
//  STUIComponent
//
//  Created by XuAzen on 16/2/29.
//  Copyright © 2016年 st company. All rights reserved.
//

import UIKit

public class LineSpacingLabel: UILabel {
    
    public var lineSpacing : CGFloat! = 5 //  默认为5 
    {
        didSet{
            layoutSubviews()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        //  设定行距
        if let oldText = text {
            let spacingText = NSMutableAttributedString(string: oldText)
            let paragraphStyle = NSMutableParagraphStyle()
            if let notNilLineSpacing = lineSpacing {
                paragraphStyle.lineSpacing = notNilLineSpacing
                spacingText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, oldText.characters.count))
                attributedText = spacingText
            }
        }
    }
}
