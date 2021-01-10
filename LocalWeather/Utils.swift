//
//  Utils.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/10.
//

import UIKit

protocol BorderDelegate: class {
    func updatedBorder(with border: UIView, reusable: Bool)
}

weak var borderDelegate: BorderDelegate?
extension UIView {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat, reusable: Bool = true) {
        for edge in arr_edge {
            let border = UIView()
            border.translatesAutoresizingMaskIntoConstraints = false
            border.backgroundColor = color
            self.addSubview(border)
            switch edge {
            case .top, .bottom:
                border.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
                border.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
                border.heightAnchor.constraint(equalToConstant: width).isActive = true
                if edge == .top {
                    border.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
                } else {
                    border.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
                }
                break
            case .left, .right:
                border.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
                border.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
                border.widthAnchor.constraint(equalToConstant: width).isActive = true
                if edge == .left {
                    border.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
                } else {
                    border.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
                }
                break
            default:
                break
            }
            borderDelegate?.updatedBorder(with: border, reusable: reusable)
        }
    }
}
