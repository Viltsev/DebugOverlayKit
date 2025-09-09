//
//  MovableLogController.swift
//  DebugOverlayKit
//
//  Created by viltsevdanila on 9/8/25.
//

import UIKit

@available(iOS 15, *)
public class MovableLogController: UIViewController {
    private let minWidth: CGFloat = 150
    private let minHeight: CGFloat = 100
    
    private var initialFrame: CGRect = .zero
    private var initialTouchPoint: CGPoint = .zero
    
    private let bottomRightHandle = ResizeHandleView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    private let logViewController = LogViewController()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
    }
}

@available(iOS 15, *)
extension MovableLogController {
    
    private func addSubviews() {
        addChild(logViewController)
        view.addSubview(logViewController.view)
        logViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        logViewController.didMove(toParent: self)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(pan)
        
        bottomRightHandle.backgroundColor = UIColor.black
        let handleSize: CGFloat = 24
        let inset: CGFloat = 8

        bottomRightHandle.frame = CGRect(
            x: view.bounds.width - handleSize - inset,
            y: view.bounds.height - handleSize - inset,
            width: handleSize,
            height: handleSize
        )
        bottomRightHandle.autoresizingMask = UIView.AutoresizingMask([.flexibleLeftMargin, .flexibleTopMargin])

        view.addSubview(bottomRightHandle)
        
        let resizePan = UIPanGestureRecognizer(target: self, action: #selector(handleResizePan))
        bottomRightHandle.addGestureRecognizer(resizePan)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            logViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            logViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        guard let window = view.window else { return }
        let translation = sender.translation(in: view)
        window.frame.origin.x += translation.x
        window.frame.origin.y += translation.y
        sender.setTranslation(.zero, in: view)
    }
    
    @objc private func handleResizePan(_ sender: UIPanGestureRecognizer) {
        guard let window = view.window else { return }
        
        let location = sender.location(in: window)
        
        switch sender.state {
        case .began:
            initialFrame = window.frame
            initialTouchPoint = location
            
        case .changed:
            let deltaX = location.x - initialTouchPoint.x
            let deltaY = location.y - initialTouchPoint.y
            
            var newWidth = initialFrame.width + deltaX
            var newHeight = initialFrame.height + deltaY
            
            newWidth = max(newWidth, minWidth)
            newHeight = max(newHeight, minHeight)
            
            window.frame.size = CGSize(width: newWidth, height: newHeight)
            
        default:
            break
        }
    }
}
