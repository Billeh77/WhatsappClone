//
//  Extensions.swift
//  Whatsapp
//
//  Created by Emile Billeh on 27/05/2024.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
