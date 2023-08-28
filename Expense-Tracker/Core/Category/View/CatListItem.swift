//
//  ListItem.swift
//  ExpenseTrackerApp
//
//  Created by user235012 on 8/21/23.
//

import SwiftUI

struct CatListItem: View {
    var catImage: String
    var catName:String
    
    
    var body: some View {
        HStack(spacing:10){        
            Image(systemName: catImage)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            
            Text(catName)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)     
        }
     
    }
}



