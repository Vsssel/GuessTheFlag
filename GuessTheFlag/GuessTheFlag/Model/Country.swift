//
//  Country.swift
//  GuessTheFlag
//
//  Created by Assel Artykbay on 11.10.2024.
//

import Foundation
import UIKit

struct Country {
    let name: String;
    let flagImage: UIImage;
    let continent: String;
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name && lhs.continent == rhs.continent
    }
}
