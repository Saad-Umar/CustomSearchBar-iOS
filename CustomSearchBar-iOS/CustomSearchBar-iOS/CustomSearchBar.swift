//
//  CustomSearchBar.swift
//  AmbitBox
//
//  Created by Saad Umar on 19/09/2020.
//  Copyright © 2020 AvanzaSolutions. All rights reserved.
//

import UIKit

class ObservableString:NSObject {
    @objc dynamic var observedText: String?
}

class CustomSearchBar: UISearchBar, UISearchBarDelegate {
    
    weak var customSearchBarDelegate: CustomSearchBarDelegate?
    
    private var token: NSKeyValueObservation?
    let customSearchbarTextField = UITextField()
    let textFieldObserver: ObservableString = ObservableString()
    
    override func draw(_ rect: CGRect) {
        textFieldObserver.observedText = ""
        self.delegate = self
        if #available(iOS 13.0, *) {
            self.searchTextField.isHidden = true
        } else {
            // Fallback on earlier versions
            for view : UIView in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    textField.isHidden = true
                    
                }
            }
        }
        customSearchbarTextField.frame = self.frame
        customSearchbarTextField.placeholder = ""
        customSearchbarTextField.isUserInteractionEnabled = false
        let underline = UIView(frame: CGRect(x: 0, y: 0, width: customSearchbarTextField.frame.width, height: 2))
        underline.backgroundColor = UIColor.lightGray
        customSearchbarTextField.addSubview(underline)
        self.superview?.addSubview(customSearchbarTextField)
        
        token = textFieldObserver.observe(\.observedText) { [weak self] object, change in  // the `[weak self]` is to avoid strong reference cycle; obviously, if you don't reference `self` in the closure, then `[weak self]` is not needed
            print("bar property is now \(object.observedText)")
            self?.customSearchbarTextField.text = self?.textFieldObserver.observedText
            
        }
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textFieldObserver.observedText = searchText
        customSearchBarDelegate?.searchBar(searchBar, textDidChange: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        customSearchBarDelegate?.searchBarSearchButtonClicked(searchBar)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customSearchBarDelegate?.searchBarCancelButtonClicked(searchBar)
    }
    
}

protocol  CustomSearchBarDelegate: class {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
}
