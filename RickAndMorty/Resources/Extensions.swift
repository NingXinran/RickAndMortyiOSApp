//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
