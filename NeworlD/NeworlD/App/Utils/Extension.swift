//
//  Extension.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 9.12.2022.
//

import UIKit

//MARK: Fetch Image from URL.
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

//MARK: Date Format
extension String {
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-dd-mm" //"MM-dd-yyyy" 

        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
}

//MARK: TextField - Placeholder Color & String
extension UITextField {
    func changeColorPlaceholder(tf myTextField: UITextField, string: String, color: UIColor) {
        myTextField.attributedPlaceholder = NSAttributedString(
            string: string,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }
}
