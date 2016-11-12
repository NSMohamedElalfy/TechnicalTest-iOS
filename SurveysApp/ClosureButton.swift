//
//  ClosureButton.swift
//  SurveysApp
//
//  Created by NSMohamedElalfy on 11/12/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import Foundation


import UIKit

class UIClosureButton: UIButton {
    
    typealias DidTapButton = (UIClosureButton) -> ()
    
    var didTouchUpInside: DidTapButton? {
        didSet {
            if didTouchUpInside != nil {
                addTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
            }
        }
    }
    
    // MARK: - Actions
    func didTouchUpInside(_ sender: UIButton) {
        if let handler = didTouchUpInside {
            handler(self)
        }
    }
    
}
