//
//  ZLSwitchView.swift
//  SwitchDemo
//
//  Created by snowlu on 2018/4/26.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

import UIKit

fileprivate let midSize:CGFloat  = 25.0 ;

fileprivate let SwitchMaxHeight:CGFloat  = 31.0;

fileprivate let SwitchMinHeight:CGFloat  = 31.0;

fileprivate let SwitchMinWidth:CGFloat  = 51.0;

class ZLSwitchView: UIControl {

    @objc  @IBInspectable  open var onTintColor:UIColor = UIColor.purple;
    
    @objc    @IBInspectable open var offTinColor:UIColor = UIColor.orange;
    
    @objc     @IBInspectable  open var midTintColor:UIColor = UIColor.yellow;
    
    @objc   @IBInspectable open var onTextColor:UIColor = UIColor.black;
    
    @objc    @IBInspectable  open var onTextFont:UIFont = UIFont.systemFont(ofSize: 10);
    
     @objc  @IBInspectable  open var offTextColor:UIColor = UIColor.black;
    
     @objc   @IBInspectable  open var offTextFont:UIFont = UIFont.systemFont(ofSize: 10);
    
     @objc    @IBInspectable open var  onText:String? = "ON"
    
     @objc    @IBInspectable open var  offText:String?  = "OFF"


    @objc   @IBInspectable   open var     isOn:Bool = false;
    
    
     fileprivate lazy var tapGesture:UITapGestureRecognizer = { [unowned self] in

        let  tapGesture  = UITapGestureRecognizer.init(target: self, action: #selector(handleTapTapGesture(_:)));
        
        return tapGesture;
        
    }()

    fileprivate lazy var panGesture:UIPanGestureRecognizer = { [unowned self] in
        
        let  tapGesture  = UIPanGestureRecognizer.init(target: self, action: #selector(handlePanTapGesture(_:)));
        
        return tapGesture;
        
        }()

    fileprivate lazy var contentView:UIView = { [unowned self] in
        let contentView = UIView.init();
        contentView.layer.masksToBounds  = true;
        contentView.layer.cornerRadius  = contentView.frame.size.width  * 0.5 ;
        
        return  contentView;
    }()
    
    fileprivate lazy var onContentView:UIView = { [unowned self] in
        
        let  onView = UIView.init()
        
        onView.backgroundColor = onTintColor;
        
        return onView;
    }()
    fileprivate lazy var onLabel:UILabel = { [unowned self] in
        let  onLabel = UILabel.init()
        onLabel.textAlignment = NSTextAlignment.center;
        onLabel.textColor = onTextColor;
        onLabel.font = onTextFont;
        onLabel.text = onText;
        onLabel.translatesAutoresizingMaskIntoConstraints = false;
        onContentView .addSubview(onLabel);
        return onLabel;
        }()
    
    fileprivate lazy var offContentView:UIView = { [unowned self] in
        let  offView = UIView.init()
        offView.backgroundColor = offTinColor;
     
        return offView;
        }()
    
    fileprivate lazy var offLabel:UILabel = { [unowned self] in
        let  offLabel = UILabel.init()
        offLabel.textAlignment = NSTextAlignment.center;
        offLabel.textColor = offTextColor;
        offLabel.font = offTextFont;
        offLabel.text = offText;
        offLabel.translatesAutoresizingMaskIntoConstraints = false;
        offContentView .addSubview(offLabel);
        return offLabel;
        }()
   
    fileprivate lazy var midView:UIView = { [unowned self] in
        let  midView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: midSize, height: midSize));
        midView.backgroundColor = midTintColor;
        midView.layer.cornerRadius  = midView.frame.size.width * 0.5;
        contentView .addSubview(midView);
        return midView;
        }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.setupUI();
    }

    override init(frame: CGRect) {
        super.init(frame:frame.roundRect());
        self.setupUI();
    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.setupUI();
    }
    override func layoutSubviews() {
        super.layoutSubviews();
        
        contentView.frame = self.bounds;
        
        contentView.layer.cornerRadius = contentView.frame.height * 0.5;
        
        contentView.layer.masksToBounds = true;
        
        let    margin  :CGFloat  = (self.bounds.height - midSize) * 0.5;
        
        let contentWidth = contentView.frame.width ;
        
        let contentHeight  = contentView.frame.height ;
        
    
        self.addConstraintOnText();
        
        self.addConstraintOffText();
        
        guard isOn else {
            onContentView.frame  = CGRect.init(x: -1 * contentWidth , y: 0, width: contentWidth, height: contentHeight);
            
            offContentView.frame  = CGRect.init(x: 0, y: 0, width: contentWidth, height: contentHeight);
            
            midView.frame   = CGRect.init(x: margin, y: margin, width: midSize, height: midSize);
            
            return;
        }
    
        onContentView.frame  = CGRect.init(x: 0 , y: 0, width: contentWidth, height: contentHeight);
        
        offContentView.frame  = CGRect.init(x: contentWidth, y: 0, width: contentWidth, height: contentHeight);
        
        midView.frame   = CGRect.init(x: contentWidth-margin - midSize, y: margin, width: midSize, height: midSize);
    }
}

//MARK:初始化
private extension ZLSwitchView {

    func setupUI() {
        
        self .addGestureRecognizer(tapGesture);
        
        self .addGestureRecognizer(panGesture);
        
        self .addSubview(contentView);
        
        contentView .addSubview(onContentView);
        
        contentView .addSubview(offContentView);
        
        
    }

    func addConstraintOnText() {
        
        let topConstraint = NSLayoutConstraint.init(item: onLabel, attribute: NSLayoutAttribute.top, relatedBy:NSLayoutRelation.equal, toItem: onContentView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 5);
        
        let letfConstraint = NSLayoutConstraint.init(item: onLabel, attribute: NSLayoutAttribute.left, relatedBy:NSLayoutRelation.equal, toItem: onContentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 5)
    
        let rigithConstraint = NSLayoutConstraint.init(item: onLabel, attribute: NSLayoutAttribute.right, relatedBy:NSLayoutRelation.equal, toItem: onContentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -midSize)
        let bottomfConstraint = NSLayoutConstraint.init(item: onLabel, attribute: NSLayoutAttribute.bottom, relatedBy:NSLayoutRelation.equal, toItem: onContentView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -5)
        let constraints  = [topConstraint ,letfConstraint,rigithConstraint,bottomfConstraint];
        onContentView .addConstraints(constraints);
        
    }
    
    func addConstraintOffText() {
        
        let topConstraint = NSLayoutConstraint.init(item: offLabel, attribute: NSLayoutAttribute.top, relatedBy:NSLayoutRelation.equal, toItem: offContentView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 5);
        
        let letfConstraint = NSLayoutConstraint.init(item: offLabel, attribute: NSLayoutAttribute.left, relatedBy:NSLayoutRelation.equal, toItem: offContentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: midSize)
        
        let rigithConstraint = NSLayoutConstraint.init(item: offLabel, attribute: NSLayoutAttribute.right, relatedBy:NSLayoutRelation.equal, toItem: offContentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -5)
        let bottomfConstraint = NSLayoutConstraint.init(item: offLabel, attribute: NSLayoutAttribute.bottom, relatedBy:NSLayoutRelation.equal, toItem: offContentView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -5)
        let constraints  = [topConstraint ,letfConstraint,rigithConstraint,bottomfConstraint];
        offContentView .addConstraints(constraints);
        
    }
    
    
}

//MARK:UITapGestureRecognizer
fileprivate  extension ZLSwitchView{
    @objc  func handleTapTapGesture(_ recognizer:UITapGestureRecognizer){
        guard recognizer.state == UIGestureRecognizerState.ended else {
            return;
        }
        setisOnStatus(!isOn, animated: true);
        sendActions(for: UIControlEvents.valueChanged);
    }
    
    @objc  func handlePanTapGesture(_ recognizer:UIPanGestureRecognizer){
        
        switch recognizer.state {
        case .began:
            self .scaleMidAnimation(true);
        case .cancelled,.failed:
            self.scaleMidAnimation(false);
        case .ended:
           setisOnStatus(!isOn, animated: true);
            self.sendActions(for: UIControlEvents.valueChanged);
        default:
            print("\(recognizer.state)");
        }
        
    }
}
fileprivate extension ZLSwitchView{
    
    func scaleMidAnimation( _ scale:Bool) {
        
       let    margin  :CGFloat  = (self.bounds.height - midSize) * 0.5;
        
        let  offset:CGFloat  = scale ? 6.0 : 0.0 ;
        
        let tempMidFrame = midView.frame;
        
        if isOn {
            let x =    contentView.frame.width - midSize - margin  - offset;
            midView.frame = CGRect.init(x:x, y: 0, width: midSize  + offset, height: midSize)
            
        } else {
            midView.frame = CGRect.init(x:margin, y: margin, width: midSize  + offset, height: midSize);
            return ;
        }

        let animationBound = CABasicAnimation.init(keyPath:"bounds");
        animationBound.fromValue = NSValue.init(cgRect: CGRect.init(x: 0, y: 0, width: tempMidFrame.width, height: tempMidFrame.height));
        animationBound.toValue = NSValue.init(cgRect: CGRect.init(x: 0, y: 0, width: self.midView.frame.width, height: self.midView.frame.height));
        animationBound.duration  = 0.3;
        animationBound.timingFunction = CAMediaTimingFunction.init(name:kCAMediaTimingFunctionEaseInEaseOut);
        midView.layer .add(animationBound, forKey: nil);
        
        let animationPosit = CABasicAnimation.init(keyPath:"position");
        animationPosit.fromValue = NSValue.init(cgPoint: CGPoint.init(x: tempMidFrame.midX, y: tempMidFrame.midY));
        animationPosit.toValue = NSValue.init(cgPoint: CGPoint.init(x: self.midView.frame.midX, y: self.midView.frame.midY));

        animationPosit.duration  = 0.3;
        animationPosit.timingFunction = CAMediaTimingFunction.init(name:kCAMediaTimingFunctionEaseInEaseOut);
        midView.layer .add(animationPosit, forKey: nil);
    }
    

}
//MARK:setisOnStatus
extension ZLSwitchView {
    
    @objc open  func setisOnStatus ( _ on:Bool ,animated:Bool)  {
        guard on != isOn else {
            return;
        }
        isOn = on;
        self.setNeedsLayout();
        //TODO: 忙了，暂时写到这里
    }
    
}
fileprivate extension CGRect {
    
    //MARK:改变大小
    func roundRect() -> CGRect {
        
        var newRect: CGRect = self;
        
        if newRect.height > SwitchMaxHeight {
            newRect.size.height = SwitchMaxHeight;
        }
        if newRect.height < SwitchMinHeight {
            newRect.size.height = SwitchMinHeight;
        }
        
        if newRect.width < SwitchMinWidth {
            newRect.size.width = SwitchMinWidth
        }
        return newRect;
    }
    
    
}
