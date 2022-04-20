//
//  RecipeHighlightsView.swift
//  Recipe List App
//
//  Created by Robert Miller on 4/20/22.
//

import SwiftUI

struct RecipeHighlightsView: View {
    
    var allHighlights = ""
    
    init(highlights:[String]){
        
        //Loop through highlights array
        for index in 0..<highlights.count {
            
            //If element is last in array, dont inlcude ','
            if index == highlights.count - 1 {
                allHighlights += highlights[index]
            }
            //otherwise, do include ','
            else {
                allHighlights += highlights[index] + ", "
            }
        }
    }
    
    var body: some View {
        Text(allHighlights)
    }
}

struct RecipeHighlightsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeHighlightsView(highlights: ["test", "test2", "test 3"])
    }
}
