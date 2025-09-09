//
//  ResizeHandleView.swift
//  DebugOverlayKit
//
//  Created by viltsevdanila on 9/8/25.
//

import UIKit

@available(iOS 13.0, *)
public class ResizeHandleView: UIView {
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

@available(iOS 13.0, *)
extension ResizeHandleView {
    private func addSubviews() {
        let image = UIImage(systemName: "rectangle.and.arrow.up.right.and.arrow.down.left")?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        isUserInteractionEnabled = true
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
