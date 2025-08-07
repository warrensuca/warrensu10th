//
//  Order.swift
//  Cupcake Corners
//
//  Created by Warren Su on 7/16/25.
//

import SwiftUI


@Observable
class Order: Codable {

    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    

    var extraFrosting = false
    var addSprinkles = false
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    private var letters = ["a","b","c","d","e","f","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    private var digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    var hasValidAddress: Bool {
        
        var nameValid = false
        var addressValid = false
        var cityValid = false

        
        for letter in letters {
            if name.contains(letter) || name.contains(letter.uppercased()){
                nameValid = true
                break
            }
        }
        
        for letter in letters {
            if streetAddress.contains(letter) || streetAddress.contains(letter.uppercased()){
                addressValid = true
                break
            }
        }
        
        for letter in letters {
            if city.contains(letter) || city.contains(letter.uppercased()){
                cityValid = true
                break
            }
        }
        
        for digit in digits {
            if name.contains(digit){
                nameValid = true
                break
            }
        }
        for digit in digits {
            if streetAddress.contains(digit){
                addressValid = true
                break
            }
        }
        for digit in digits {
            if city.contains(digit){
                cityValid = true
                break
            }
        }
        return nameValid && addressValid && cityValid
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity)*2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(type) / 2
        }
        
        return cost
    }
    
}
