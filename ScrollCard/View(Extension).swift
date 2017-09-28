//
//  View(Extension).swift
//  HuiKaoBa
//
//  Created by Tony on 16/11/17.
//  Copyright © 2016年 Tony. All rights reserved.
//

import UIKit

/** 屏幕尺寸 */
// 屏幕宽度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
// 屏幕高度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
// 自适应屏幕宽度
func FIT_SCREEN_WIDTH(_ size: CGFloat) -> CGFloat {
    return size * SCREEN_WIDTH / 375.0
}
// 自适应屏幕高度
func FIT_SCREEN_HEIGHT(_ size: CGFloat) -> CGFloat {
    return size * SCREEN_HEIGHT / 667.0
}

extension UIView {
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    public var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    /** 宽 */
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    /** 高 */
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    /** 下 */
    public var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.origin.y = newValue - self.frame.size.height
            self.frame = frame
        }
    }
    
    /** 右 */
    public var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        
        set {
            var frame = self.frame
            frame.origin.x = newValue - self.frame.size.width
            self.frame = frame
        }
    }
    
    /** 尺寸 */
    public var size: CGSize {
        get {
            return self.frame.size
        }
        
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }

    /** 竖直中心对齐 */
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    /** 水平中心对齐 */
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
}

