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
    
    //Create static fucntion that will return a string of the target serving size
    //Is static so we dont have to create an instance of the RecipeModel class to call the function
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        //Variable will hold the string that will be returned by this function
        var portion = ""
        
        //Numerator variable. Will default to assigning value of 1 to variable if ingredient.num is nil
        //This is called nil coalescing
        var numerator = ingredient.num ?? 1
        
        //Denominator variable. Will either be assgined value from ingredient.denom or default value 1 if nil
        var denominator = ingredient.denom ?? 1
        
        var wholePortions = 0
        
        //Validate that ingredient.num is not nil
        if ingredient.num != nil {
            
            //Get a single serving size by multiplying denominator by the recipe servings
            denominator *= recipeServings
            
            //Get target portion my multiplying numerator by target servings
            numerator *= targetServings
            
            //Reduce fraction by greatest common divisor
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            
            //Get the whole portion if numerator > denominator
            if numerator >= denominator {
                
                //Calculate whole portions
                wholePortions = numerator / denominator
                
                //Calculate the remainder
                numerator = numerator % denominator
                
                //Assign to portion string
                portion += String(wholePortions)
            }
            
            //Express the remainder as a fraction
            if numerator > 0 {
                
                //Assign remaidner as fraction to the portion string
                portion += wholePortions > 0 ? " " : ""
                portion += "\(numerator)/\(denominator)"
            }
        }
        
        if var unit = ingredient.unit {
            
            //If we need to pluralize
            if wholePortions > 1 {
                //Calculate appropriate suffix
                
                //Change "bunch" to "bunches"
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                //Change "leaf" to "leaves"
                else if unit.suffix(1) == "f" {
                    //drop the last character in the string
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                //Add "s" to make a word plural, such as "cups"
                else {
                    unit += "s"
                }
            }
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            return portion + unit
        }
                
        return portion
    }
}
