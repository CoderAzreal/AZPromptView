//
//  AZPromptView.swift
//
//  Created by tianfengyu on 2016/11/7.
//  Copyright © 2016年 tianfengyu. All rights reserved.
//  Toast提示框模块

import UIKit

// MARK: >> 外部调用函数
class AZPromptView: UIView {
    
    
    /// 显示提示文字
    ///
    /// - Parameter text: 显示的文字
    public class func show(text: String) {
        AZPromptView.share.textDidSet(text: text)
    }
    
    /// 显示提示文字并收起键盘
    ///
    /// - Parameters:
    ///   - text: 显示的文字
    ///   - hideKeyboardView: 需要收起键盘的view
    public class func show(text: String, hideKeyboardView: UIView) {
        hideKeyboardView.endEditing(true)
        AZPromptView.share.textDidSet(text: text)
    }
    
    private override init(frame: CGRect) {
        if frame.isEmpty {
            fatalError("请直接使用AZPromptView.show(text:)进行初始化")
        }
        super.init(frame: frame)
        loadView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: >> 属性定义
    private static let share = AZPromptView(frame: CGRect(x: -1, y: -1, width: 1, height: 1))
    fileprivate var promptView = UIView()
    fileprivate var promptLabel = UILabel()
    fileprivate var timer: DispatchSourceTimer?
    
    // MARK: >> 常量定义
    fileprivate let padding: CGFloat = 80
    fileprivate let screenPadding: CGFloat = 80
    fileprivate let height: CGFloat = 40
    fileprivate let fontsize: CGFloat = 15
    fileprivate let backAlpha: CGFloat = 0.7
}

// MARK: >> 初始化
fileprivate extension AZPromptView {
    
    fileprivate func loadView() {
        
        loadSelf()
        loadPrompt()
    }
    
    private func loadSelf() {
        
        layer.cornerRadius = 5
        clipsToBounds = true
        isUserInteractionEnabled = false
        alpha = 0
    }
    
    private func loadPrompt() {
        promptView.alpha = backAlpha
        promptView.backgroundColor = .black
        promptLabel.textAlignment = .center
        promptLabel.font = UIFont.systemFont(ofSize: fontsize)
        promptLabel.textColor = .white
        
        addSubview(promptView)
        addSubview(promptLabel)
        UIApplication.shared.keyWindow?.addSubview(self)
    }
}

// MARK: >> 刷新控件
fileprivate extension AZPromptView {
    
    fileprivate func textDidSet(text: String) {
        reloadView(text: text)
        refreshTimer()
    }
    
    // MARK: >> 更新view
    private func reloadView(text: String) {
        promptLabel.text = text
        let sz = text.rect(fontsize: fontsize, size: CGSize(width: AZ_SCREENWIDTH - screenPadding, height: 100))
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
        frame = CGRect(x: 0, y: AZ_SCREENHEIGHT-140, width: sz.width + padding, height: height)
        center = CGPoint(x: AZ_SCREENWIDTH/2, y: center.y)
        promptLabel.frame = CGRect(x: 0, y: 0, width: sz.width + padding, height: height)
        promptView.frame = promptLabel.bounds
        UIApplication.shared.keyWindow?.bringSubview(toFront: self)
    }
    
    // MARK: >> 刷新timer
    private func refreshTimer() {
        timer?.cancel()
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer?.scheduleRepeating(wallDeadline: .now(), interval: .seconds(1))
        var timerTime = 3
        timer?.setEventHandler {
            if timerTime<=0 {
                UIView.animate(withDuration: 0.2) {
                    self.alpha = 0
                }
                self.timer?.cancel()
            }
            timerTime-=1
        }
        timer?.resume()
    }
    
}

fileprivate let AZ_SCREENWIDTH = UIScreen.main.bounds.size.width
fileprivate let AZ_SCREENHEIGHT = UIScreen.main.bounds.size.height
private extension String {
    func rect(fontsize:CGFloat, size: CGSize) -> CGSize {
        let string = self as NSString
        return string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontsize)], context: nil).size
    }
}
