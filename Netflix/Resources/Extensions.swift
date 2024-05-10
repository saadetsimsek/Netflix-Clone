//
//  Extensions.swift
//  Netflix
//
//  Created by Saadet Şimşek on 10/05/2024.
//

import Foundation

extension String { // yazının ilk harfi büyük olması için
    func capitalizeFirstLetter()-> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
