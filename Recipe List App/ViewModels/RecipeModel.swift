//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Robert Miller on 4/6/22.
//

import Foundation

//Make RecipeModel conform to the @ObservableObject protocol so that changed made to this class will be relayed to the RecipeListView
class RecipeModel: ObservableObject {
    
    //Create an empty array of Recipe objects
    //Use the @Published wrapped so that changed will be published to the View
    @Published var recipes = [Recipe]()
    
    //Create initializer method
    init() {
        
        //Get the data and store it into the recipes array
        self.recipes = DataService.getLocalData()
        
    }
}
