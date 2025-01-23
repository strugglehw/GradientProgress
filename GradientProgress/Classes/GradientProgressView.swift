//
//  GradientProgressView.swift
//  GradientProgress
//
//  Created by Gong Xintao on 12/01/2025.
//

import UIKit
/**
 渐变的方向
 */
public enum GradientStart{
    case leftBottom
    case leftTop
    case rightTop
    case rightBottom
    case centerTop
    case centerBottom
}

public class GradientProgressView: UIView {

    
    /**
     线条的宽度
     */
    public var lineWidth:Double = 10.0;
    /**
    渐变的颜色组
     */
    public var gradientColors:[UIColor] = [UIColor.red,UIColor.yellow];
    
    /**
    渐变的方向
     */
    public var gradientStart:GradientStart = .leftBottom;
    
    
     fileprivate let _animationInterval:Double = 0.44;
     fileprivate var _dislink : CADisplayLink?;
     
     fileprivate var _degrees:Double = 0;
     fileprivate var _progress:Int = 0;
     fileprivate var _progressUnit = 0.0;
     fileprivate var _progressForAnamition = 0.0;
     fileprivate var _hasAniamtion = false;
     fileprivate var _start = CGPoint.zero;
     fileprivate var _end = CGPoint.zero;
    /**
     progress在0-100之间
     */
    public func setProgress(_ progress:Int,animation:Bool = false){
        assert(progress<=100&&progress>0,"参数异常");
        if(_hasAniamtion){
            print("动画执行完之前，不能再设置")
            return;
        }
        if(_dislink != nil){
            _dislink?.invalidate();
            _dislink = nil;
        }
        if(animation){
            _hasAniamtion = true;
            _progressForAnamition = 0;
            _progress = progress;
            _progressUnit = Double(progress)/26;
            _dislink = CADisplayLink(target: self, selector: #selector(_displayProgress))
            _dislink?.add(to: RunLoop.main, forMode: .default)
        }else{
            _progressForAnamition = Double(progress);
            _degrees = Double(_progressForAnamition)/100.0*360.0;
            setNeedsDisplay()
        }
 
    }
    
    // 将角度转换为弧度的函数
     fileprivate func _degreesToRadians(degrees: Double) -> Double {
        return degrees / 180 * Double.pi
    }
    @objc
     fileprivate func _displayProgress(){
        if(_progressForAnamition - Double(_progress) >= 0 ){
            _hasAniamtion = false;
            _progressUnit = 0;
            _dislink?.invalidate();
            _dislink = nil;
            return;
        }
        _progressForAnamition += _progressUnit;
        _degrees = Double(_progressForAnamition)/100.0*360.0;
        setNeedsDisplay()
    }
    
     fileprivate func _gradient() ->CGGradient {
        
        let myspace = CGColorSpaceCreateDeviceRGB();
        let colors = gradientColors.map { color in
            return color.cgColor;
        } as CFArray;
        let gradient = CGGradient(colorsSpace: myspace, colors:colors, locations: nil);
        return gradient!;
    }
    func _configDirection(){
        switch gradientStart {
        case .leftBottom:
            _start = CGPoint(x: bounds.minX, y: bounds.maxY);
            _end = CGPoint(x: bounds.maxX, y: bounds.minY);
        case .leftTop:
            _start = CGPoint(x: bounds.minX, y: bounds.minX);
            _end = CGPoint(x: bounds.maxX, y: bounds.maxY);
        case .rightTop:
            _start = CGPoint(x: bounds.maxX, y: bounds.minX);
            _end = CGPoint(x: bounds.minX, y: bounds.maxY);
        case .rightBottom:
            _start = CGPoint(x: bounds.maxX, y: bounds.maxY);
            _end = CGPoint(x: bounds.minX, y: bounds.minY);
            break
        case .centerTop:
            _start = CGPoint(x: bounds.midX, y: bounds.minY);
            _end = CGPoint(x: bounds.midX, y: bounds.maxY);
            break
        case .centerBottom:
            _start = CGPoint(x: bounds.midX, y: bounds.maxY);
            _end = CGPoint(x: bounds.midX, y: bounds.minY);
            break
        }
    }
    /**/
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    public override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect);
        let contenxt = UIGraphicsGetCurrentContext();
            
        _configDirection();
        
        let rwidth:Double = rect.width;
        let rlength = rwidth / 2.0;
        let pathCenter = CGPoint(x: rlength, y: rlength);
        let radius = rlength - lineWidth/2 ;
        let endAngle = _degreesToRadians(degrees:_degrees);
        
//
        contenxt?.saveGState()
        contenxt?.setLineWidth(lineWidth)
        contenxt?.setLineCap(.round)
        contenxt?.addArc(center: pathCenter, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: false)
        contenxt?.replacePathWithStrokedPath()
        contenxt?.clip()
        contenxt?.drawLinearGradient(_gradient(), start: _start, end: _end, options: [ .drawsBeforeStartLocation, .drawsAfterEndLocation]);
        contenxt?.restoreGState()
    }
    
    

}
