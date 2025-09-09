//
//  LogWindow.swift
//  DebugOverlayKit
//
//  Created by viltsevdanila on 9/8/25.
//

import UIKit

@available(iOS 15.0, *)
public class LogWindow: UIWindow {

    public override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        frame = CGRect(x: 50, y: 100, width: 300, height: 200)
        windowLevel = .alert + 1
        backgroundColor = .clear
        rootViewController = MovableLogController()
        rootViewController?.view.layer.cornerRadius = 16
        rootViewController?.view.layer.masksToBounds = true
        isHidden = true
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
