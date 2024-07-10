//
//  BaseViewController.swift
//  ToDo
//
//  Created by Vishnu on 09/07/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var activityContainerView: UIView?
        
    func showActivityIndicator(withText text: String? = "Loading", style: UIActivityIndicatorView.Style = .medium, color: UIColor = Colors.theme.secondaryTextColor) {
        if activityContainerView == nil {
            let containerView = UIView(frame: view.bounds)
            containerView.backgroundColor = Colors.theme.primaryColor.withAlphaComponent(0.5)
            
            let activityIndicator = UIActivityIndicatorView(style: style)
            activityIndicator.color = color
            activityIndicator.startAnimating()
            
            let label = UILabel()
            label.text = text
            label.textColor = Colors.theme.secondaryTextColor
            label.font = Fonts.regularCaption
            label.textAlignment = .center
            label.numberOfLines = 0
            
            let stackView = UIStackView(arrangedSubviews: [activityIndicator, label])
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.spacing = 10
            stackView.layer.cornerRadius = 10
            
            containerView.addSubview(stackView)
            view.addSubview(containerView)
            
            stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.backgroundColor = Colors.theme.secondaryBgColor
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                containerView.topAnchor.constraint(equalTo: view.topAnchor),
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])
            
            activityContainerView = containerView
        }
    }
    
    func hideActivityIndicator() {
        activityContainerView?.removeFromSuperview()
        activityContainerView = nil
    }


}
