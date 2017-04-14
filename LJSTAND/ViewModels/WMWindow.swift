//
//  WMWindow.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 5/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit
enum WMResizeAxis {
    case wmResizeNone, wmResizeLeft, wmResizeRight, wmResizeTop, wmResizeBottom
}

let kTitleBarHeight:CGFloat = 0.0
let kMoveGrabHeight:CGFloat = 44.0
let kWindowButtonFrameSize:CGFloat = 44.0
let kWindowButtonSize:CGFloat = 24.0
let kWindowResizeGutterSize:CGFloat = 8.0
let kWindowResizeGutterTargetSize:CGFloat = 24.0
let kWindowResizeGutterKnobSize:CGFloat = 48.0
let kWindowResizeGutterKnobWidth:CGFloat = 4.0
let kBorderWidth:CGFloat = 2.5


func CGRectMake(_ x:CGFloat , _ y:CGFloat , _ w:CGFloat , _ h:CGFloat ) -> CGRect {
    return CGRect(x: x, y: y, width: w, height: h)
}

func CGSizeMake(_ w:CGFloat , _ h:CGFloat ) -> CGSize {
    return CGSize(width: w, height: h)
}


class WMWindow : UIWindow, UIGestureRecognizerDelegate {
    var _savedFrame: CGRect = CGRect.zero
    var _inWindowMove: Bool = false
    var _inWindowResize: Bool = false
    var _originPoint: CGPoint = CGPoint.zero
    var resizeAxis: WMResizeAxis = WMResizeAxis.wmResizeNone
    var title: String?
    var windowButtons: Array<UIButton>?
    var resizeButtons: Array<UIButton>?
    var maximized: Bool = false
    var minSize: CGSize = CGSize(width: kWindowButtonFrameSize * 5 + kWindowResizeGutterSize * 2, height: kWindowResizeGutterKnobSize + kWindowResizeGutterSize * 2)
    
    func _commonInit() {
        self.windowButtons = Array()
        var windowButton: UIButton = UIButton(type: .custom)
        
        windowButton.frame = CGRectMake(self.bounds.width - kWindowResizeGutterSize - kWindowButtonFrameSize, kWindowResizeGutterSize, kWindowButtonFrameSize, kWindowButtonFrameSize)
        windowButton.contentMode = .center
        windowButton.adjustsImageWhenHighlighted = true
        windowButton.addTarget(self, action: #selector(WMWindow.close(_:)), for: .touchUpInside)
        var fillColor: UIColor = UIColor.white//UIColor(red: 0.953, green: 0.278, blue: 0.275, alpha: 1.000)
        var strokeColor: UIColor = UIColor.white//UIColor(red: 0.839, green: 0.188, blue: 0.192, alpha: 1.000)
        var inactiveFillColor: UIColor = UIColor(white: 0.765, alpha: 1.000)
        var inactiveStrokeColor: UIColor = UIColor(white: 0.608, alpha: 1.000)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(kWindowButtonSize, kWindowButtonSize), false, UIScreen.main.scale)
        fillColor.setFill()
        strokeColor.setStroke()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 1, y: 1))
        path.addLine(to: CGPoint(x: kWindowButtonSize-1, y: kWindowButtonSize-1))
        path.move(to: CGPoint(x: 1, y: kWindowButtonSize-1))
        path.addLine(to: CGPoint(x: kWindowButtonSize-1, y: 1))
        path.stroke()
        var img = UIGraphicsGetImageFromCurrentImageContext()
        windowButton.setImage(img, for: .normal)
        UIGraphicsEndImageContext()
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(kWindowButtonSize, kWindowButtonSize), false, UIScreen.main.scale)
        inactiveFillColor.setFill()
        inactiveStrokeColor.setStroke()
        path.stroke()
        img = UIGraphicsGetImageFromCurrentImageContext()
        windowButton.setImage(img, for: .disabled)
        UIGraphicsEndImageContext()
        self.addSubview(windowButton)
        self.windowButtons?.append(windowButton)
        
        let panRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action:#selector(WMWindow.didPan(_:)))
        panRecognizer.delegate = self
        self.addGestureRecognizer(panRecognizer)
        let focusRecognizers: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(WMWindow.didTap(_:)))
        self.addGestureRecognizer(focusRecognizers)
        self.layer.shadowRadius = 30.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
    }
    
    override func layoutSubviews() {
        
        if (self.rootViewController != nil)
        {
            let rootView: UIView = (self.rootViewController?.view)!
            
            let contentRect: CGRect = CGRectMake(kWindowResizeGutterSize, kWindowResizeGutterSize+kTitleBarHeight, self.bounds.size.width-(kWindowResizeGutterSize*2), self.bounds.size.height-kTitleBarHeight-(kWindowResizeGutterSize*2))
            rootView.frame = contentRect
            self.adjustMask()
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._commonInit()
    }
    
    func maximize(_ sender: AnyObject) {
        self.maximized = !self.maximized
        let rootWindow: UIWindow = self.window!
        UIView.beginAnimations(nil, context: nil)
        if self.maximized {
            _savedFrame = self.frame
            self.frame = CGRectMake(-kWindowResizeGutterSize,  -kWindowResizeGutterSize, rootWindow.bounds.size.width+(kWindowResizeGutterSize*2), rootWindow.bounds.size.height+(kWindowResizeGutterSize*2))
        } else {
            self.frame = _savedFrame
        }
        
        if let navVC = self.rootViewController as? UINavigationController {
            if let viewController = navVC.visibleViewController as? ResizableViewController {
                viewController.windowWasResized?()
            }
        }
        
        UIView.commitAnimations()
    }
    
    func disableClose() {
        windowButtons?[0].isUserInteractionEnabled = false
    }
    
    
    func close(_ sender: AnyObject) {
        self.isHidden = true
        NotificationCenter.default.post(name: NotificationKeys.closedWindow, object: self.title)
    }
    
    override func becomeKey() {
        self.window?.addSubview(self)
        self.setNeedsDisplay()
        
        self.layer.shadowRadius = 30.0
        for btn in self.windowButtons! {
            btn.isEnabled = true
        }
    }
    
    override func resignKey() {
        self.setNeedsDisplay()
        
        for btn in self.windowButtons! {
            btn.isEnabled = false
        }
    }
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        for btn in self.windowButtons! {
            self.insertSubview(btn, at: Int.max)
        }
    }
    
    @objc func didTap(_ rec: UIGestureRecognizer) {
        let wasKey = self.isKeyWindow
        self.makeKeyAndVisible()
        
        if let navVC = self.rootViewController as? UINavigationController {
            if let viewController = navVC.visibleViewController as? SerialViewController {
                if !wasKey {
                    viewController.resignFirstResponder()
                }
                
                viewController.showHideKeyboard(rec)
            }
        }
    }
    
    func setFrame(frame: CGRect) {
        super.frame = frame
        self.setNeedsDisplay()
    }
    
    @objc func didPan(_ recognizer: UIPanGestureRecognizer) {
        let titleBarRect: CGRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, kMoveGrabHeight)
        let gp: CGPoint = recognizer.location(in: self.window)
        let lp: CGPoint = recognizer.location(in: self.rootViewController!.view)
        
        var leftResizeRect: CGRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, kWindowResizeGutterTargetSize, self.bounds.size.height)
        var rightResizeRect: CGRect = CGRectMake(self.bounds.origin.x+self.bounds.size.width-kWindowResizeGutterTargetSize, self.bounds.origin.y, kWindowResizeGutterTargetSize, self.bounds.size.height)
        let topResizeRect: CGRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, kWindowResizeGutterTargetSize)
        var bottomResizeRect: CGRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y+self.bounds.size.height-kWindowResizeGutterTargetSize, self.bounds.size.width, kWindowResizeGutterTargetSize)
        leftResizeRect = leftResizeRect.insetBy(dx: -kWindowResizeGutterTargetSize, dy: -kWindowResizeGutterTargetSize)
        rightResizeRect = rightResizeRect.insetBy(dx: -kWindowResizeGutterTargetSize, dy: -kWindowResizeGutterTargetSize)
        bottomResizeRect = bottomResizeRect.insetBy(dx: -kWindowResizeGutterTargetSize, dy: -kWindowResizeGutterTargetSize)
        if self.maximized {
            return
        }
        if recognizer.state == .began {
            _originPoint = lp
            if titleBarRect.contains(lp) {
                _inWindowMove = true
                _inWindowResize = false
                
                if !self.isKeyWindow {
                    self.makeKey()
                }
                
                return
            }
            if !self.isKeyWindow {
                return
            }
            if leftResizeRect.contains(lp) {
                _inWindowResize = true
                _inWindowMove = false
                resizeAxis = WMResizeAxis.wmResizeLeft
            }
            if rightResizeRect.contains(lp) {
                _inWindowResize = true
                _inWindowMove = false
                resizeAxis = WMResizeAxis.wmResizeRight
            }
            if topResizeRect.contains(lp) {
                _inWindowResize = true
                _inWindowMove = false
                resizeAxis = WMResizeAxis.wmResizeTop
            }
            if bottomResizeRect.contains(lp) {
                _inWindowResize = true
                _inWindowMove = false
                resizeAxis = WMResizeAxis.wmResizeBottom
            }
        } else if recognizer.state == .changed {
            if _inWindowMove {
                let minY = CGFloat(0)
                
                self.frame = CGRectMake(gp.x-_originPoint.x, min(max(gp.y-_originPoint.y, minY), UIScreen.main.bounds.height - (kWindowButtonFrameSize + kWindowResizeGutterSize)), self.frame.size.width, self.frame.size.height)
               
                if let navVC = self.rootViewController as? UINavigationController {
                    if let viewController = navVC.visibleViewController as? ResizableViewController {
                        viewController.windowWasMoved?()
                    }
                }
            }
            if _inWindowResize {
                if resizeAxis == WMResizeAxis.wmResizeRight {
                    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, max(gp.x-self.frame.origin.x, minSize.width), self.frame.size.height)
                }
                if resizeAxis == WMResizeAxis.wmResizeLeft {
                    self.frame = CGRectMake(gp.x, self.frame.origin.y, max((-gp.x+self.frame.origin.x)+self.frame.size.width, minSize.width), self.frame.size.height)
                }
                if resizeAxis == WMResizeAxis.wmResizeBottom {
                    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, max(gp.y-self.frame.origin.y, minSize.height))
                }
                
                if let navVC = self.rootViewController as? UINavigationController {
                    if let viewController = navVC.visibleViewController as? ResizableViewController {
                        viewController.windowWasResized?()
                    }
                }
            }
            self.setNeedsDisplay()
        } else if recognizer.state == .ended {
            _inWindowMove = false
            _inWindowResize = false
            self.setNeedsDisplay()
        }
    }
    
    func adjustMask() {
        let contentBounds: CGRect = self.rootViewController!.view.bounds
        let contentFrame: CGRect = CGRectMake(self.bounds.origin.x+kWindowResizeGutterSize, self.bounds.origin.y+kWindowResizeGutterSize, self.bounds.size.width-(kWindowResizeGutterSize*2), self.bounds.size.height-(kWindowResizeGutterSize*2))
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(rect: contentBounds).cgPath//, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSizeMake(8.0, 8.0)).cgPath
        maskLayer.frame = contentBounds
        self.rootViewController?.view.layer.mask = maskLayer
        self.layer.shadowPath = UIBezierPath(roundedRect: contentFrame, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSizeMake(8.0, 8.0)).cgPath
        self.layer.shadowRadius = 30.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func draw(_ rect: CGRect) {
        windowButtons?[0].frame = CGRectMake(self.bounds.width - kWindowResizeGutterSize - kWindowButtonFrameSize, kWindowResizeGutterSize, kWindowButtonFrameSize, kWindowButtonFrameSize)
        
        UIColor.white.setStroke()
        
        if self.isKeyWindow && !self.maximized {
            if _inWindowResize {
                let leftResizeRect: CGRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y+kWindowResizeGutterSize, kWindowResizeGutterSize, self.bounds.size.height-(kWindowResizeGutterSize*2))
                let rightResizeRect: CGRect = CGRectMake(self.bounds.origin.x+self.bounds.size.width-kWindowResizeGutterSize, self.bounds.origin.y+kWindowResizeGutterSize, kWindowResizeGutterSize, self.bounds.size.height-(kWindowResizeGutterSize*2))
                let bottomResizeRect: CGRect = CGRectMake(self.bounds.origin.x+kWindowResizeGutterSize, self.bounds.origin.y+self.bounds.size.height-kWindowResizeGutterSize, self.bounds.size.width-(kWindowResizeGutterSize*2), kWindowResizeGutterSize)
                UIColor(white: 0.0, alpha: 0.3).setFill()
                
                if resizeAxis == WMResizeAxis.wmResizeRight {
                    UIBezierPath(roundedRect: rightResizeRect, cornerRadius: 3.0).fill()
                }
                if resizeAxis == WMResizeAxis.wmResizeLeft {
                    UIBezierPath(roundedRect: leftResizeRect, cornerRadius: 3.0).fill()
                }
                if resizeAxis == WMResizeAxis.wmResizeBottom {
                    UIBezierPath(roundedRect: bottomResizeRect, cornerRadius: 3.0).fill()
                }
            }
            
            let contentFrame: CGRect = CGRectMake(self.bounds.origin.x+kWindowResizeGutterSize, self.bounds.origin.y+kWindowResizeGutterSize, self.bounds.size.width-(kWindowResizeGutterSize*2), self.bounds.size.height-(kWindowResizeGutterSize*2))
            let borderPath = UIBezierPath(rect: contentFrame)
            borderPath.lineWidth = kBorderWidth
            borderPath.stroke()
            
            let bottomPath = UIBezierPath(rect: CGRectMake(self.bounds.midX-kWindowResizeGutterKnobSize/2, self.bounds.maxY-kWindowResizeGutterKnobWidth-(kWindowResizeGutterSize-kWindowResizeGutterKnobWidth)/2 - (kBorderWidth), kWindowResizeGutterKnobSize, kWindowResizeGutterKnobWidth + kBorderWidth))
            bottomPath.lineWidth = kBorderWidth
            bottomPath.stroke()
            
            let leftPath = UIBezierPath(rect: CGRectMake((kWindowResizeGutterSize-kWindowResizeGutterKnobWidth)/2, self.bounds.midY-kWindowResizeGutterKnobSize/2, kWindowResizeGutterKnobWidth + kBorderWidth, kWindowResizeGutterKnobSize))
            leftPath.lineWidth = kBorderWidth
            leftPath.stroke()
            
            let rightPath = UIBezierPath(rect: CGRectMake(self.bounds.maxX-kWindowResizeGutterKnobWidth-(kWindowResizeGutterSize-kWindowResizeGutterKnobWidth)/2 - (kBorderWidth), self.bounds.midY-kWindowResizeGutterKnobSize/2, kWindowResizeGutterKnobWidth + (kBorderWidth), kWindowResizeGutterKnobSize))
            rightPath.lineWidth = kBorderWidth
            rightPath.stroke()
        } else {
            let contentFrame: CGRect = CGRectMake(self.bounds.origin.x+kWindowResizeGutterSize, self.bounds.origin.y+kWindowResizeGutterSize, self.bounds.size.width-(kWindowResizeGutterSize*2), self.bounds.size.height-(kWindowResizeGutterSize*2))
            let borderPath = UIBezierPath(rect: contentFrame)
            borderPath.lineWidth = kBorderWidth
            borderPath.stroke()
        }
    }
    
    func wm_isOpaque() -> Bool {
        return false
    }
}

func swizzleUIWindow() {
    let origMethod = class_getInstanceMethod(WMWindow.self, NSSelectorFromString("isOpaque"))
    let newMethod = class_getInstanceMethod(WMWindow.self,NSSelectorFromString("wm_isOpaque"))
    
    method_exchangeImplementations(origMethod, newMethod)
}
