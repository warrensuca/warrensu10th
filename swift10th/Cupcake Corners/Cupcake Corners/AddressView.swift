//
//  AddressView.swift
//  Cupcake Corners
//
//  Created by Warren Su on 7/17/25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section{
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section{
                
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }.disabled(order.hasValidAddress == false)
        }
    }
}

#Preview {
    AddressView(order: Order())
}
