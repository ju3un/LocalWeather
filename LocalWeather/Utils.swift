//
//  Utils.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/10.
//

import UIKit

extension UIView {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) -> [UIView] {
        var borders: [UIView] = []
        for edge in arr_edge {
            let border = UIView()
            border.translatesAutoresizingMaskIntoConstraints = false
            border.backgroundColor = color
            self.addSubview(border)
            switch edge {
            case UIRectEdge.top:
                border.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
                border.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
                border.heightAnchor.constraint(equalToConstant: width).isActive = true
                border.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
                break
            case UIRectEdge.bottom:
                border.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
                border.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
                border.heightAnchor.constraint(equalToConstant: width).isActive = true
                border.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
                break
            case UIRectEdge.left:
                border.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
                border.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
                border.widthAnchor.constraint(equalToConstant: width).isActive = true
                border.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
                break
            case UIRectEdge.right:
                border.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
                border.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
                border.widthAnchor.constraint(equalToConstant: width).isActive = true
                border.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
                break
            default:
                break
            }
            borders.append(border)
        }
        return borders
    }
}

/*extension UIStackView {
    func addBorder(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let subview = UIView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.backgroundColor = color
        self.addSubview(subview)
        switch edge {
        case .top, .bottom:
            subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            subview.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            if edge == .top {
                subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            } else {
                subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            }
        case .left, .right:
            subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            subview.widthAnchor.constraint(equalToConstant: thickness).isActive = true
            if edge == .left {
                subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            } else {
                subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            }
        default:
            break
        }
    }
}
*/
