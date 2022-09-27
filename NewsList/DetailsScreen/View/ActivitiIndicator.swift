//
//  ActivitiIndicator.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 28.09.2022.
//

import UIKit

func showLoader(loader: UIActivityIndicatorView, show: Bool) {
    DispatchQueue.main.async {
        if show {
            loader.startAnimating()
            loader.isHidden = false
        }
        else {
            loader.stopAnimating()
            loader.isHidden = true
        }
    }
}
