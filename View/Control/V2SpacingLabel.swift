//
//  V2SpacingLabel.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class V2SpacingLabel: UILabel {
    var spacing : CGFloat = 3.0
    override var text: String?{
        set {
            if let len = newValue?.Lenght, len > 0 {
                let attributedString = NSMutableAttributedString(string: newValue!)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingHead
                paragraphStyle.lineSpacing=self.spacing
                paragraphStyle.alignment=self.textAlignment
                attributedString.addAttributes([
                    NSAttributedStringKey.paragraphStyle:paragraphStyle
                    ], range: NSMakeRange(0, newValue!.Lenght))
                super.attributedText = attributedString
            }
        }
        get {
            return super.text
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
