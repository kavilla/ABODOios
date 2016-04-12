//
//  apartment.swift
//  ABODOios
//
//  Created by Kawika Avilla on 4/12/16.
//  Copyright © 2016 kawikaavilla. All rights reserved.
//

import Foundation
import UIKit

class apartment {
    var imageUrlString: String
    var bedRange: String
    var priceRange: String
    var propertyName: String
    
    init(propertyName: String, bedRange: String, priceRange: String, imageUrlString: String){
        self.bedRange = bedRange
        self.priceRange = priceRange
        self.imageUrlString = imageUrlString
        self.propertyName = propertyName
    }
    
    func getBedRange() -> String {
        return bedRange
    }
    
    func getPriceRange() -> String {
        return priceRange
    }
    
    func getImageUrlString() -> String {
        return imageUrlString
    }
    
    func getPropertyName() -> String {
        return propertyName
    }
}