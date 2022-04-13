//
//  DataService.swift
//  Recipe List App
//
//  Created by Robert Miller on 4/6/22.
//

import Foundation

class DataService {
    
    //Set as a static method (or type method) so it can be called without other files having to create an instance of this class
    //We can use static methods when the class only used for calling methods
    static func getLocalData() -> [Recipe] {
        
        //Get a url path to the json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        //Use the guard statement to check if the pathString has a value. If nil, then return an empty array
        guard pathString != nil else {
            return [Recipe]()
        }
        
        //Create a url object
        //Since we validated that pathString is no nil, we can safely unwrap it
        let url = URL(fileURLWithPath: pathString!)
        
        //Use do-try-catch to handle any errors that the Data class could throw
        do{
            
            //Create a data object
            let data = try Data(contentsOf: url)
            
            //Decode the data with a JSON decoder
            let decoder = JSONDecoder()
            
            do{
             
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                //Add the unique IDs
                for r in recipeData {
                    r.id = UUID()
                }
                
                //Return the recipes
                return recipeData
                
            }
            catch{
                //error with parsing JSON
                print(error)
            }
        }
        catch{
            //error with getting data
            print(error)
        }
        
        //If errors occur and we jumpt to this point in the block of code, we need to return an empty array
        return [Recipe]()


    }
    
}
