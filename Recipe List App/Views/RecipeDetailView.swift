//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Robert Miller on 4/8/22.
//

import SwiftUI

struct RecipeDetailView: View {
    
    //Initialize variable of Recipe data type. We are not creating an instance since this view will rely on the user input from the RecipeListView
    var recipe:Recipe
    
    var body: some View {
        
        //ScrollView used so that any overflowing text can be scrolled through on the view
        ScrollView {
            
            //VStack used to align the entire ScrollView
            VStack(alignment: .leading){
                
                //MARK: Recipe Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                //MARK: Ingredients
                //VStack aligns "Ingredients" and ingredients property
                VStack(alignment: .leading){
                    Text("Ingredients")
                    .font(.headline)
                    .padding(.vertical, 5.0)
                    
                    //Use ForEach loop to generate the text elements for the ingredients property
                    //We are able to not include 'id: \.self' in the parameters for teh loop because 'ingredients' is Identifiable
                    ForEach(recipe.ingredients) { item in
                        Text("• " + item.name)
                    }
                }
                .padding(.horizontal)
                
                //MARK: Divider
                Divider()
                
                //MARK: Directions
                //VStack aligns "Directions" and directions array property
                VStack(alignment: .leading) {
                    Text("Directions")
                        .font(.headline)
                        .padding(.vertical, 5.0)
                    
                    //Use ForEach loop, interating using indexes, so we can use that index as the number in front of each direction
                    ForEach(0..<recipe.directions.count, id: \.self) { index in
                        Text(String(index+1) + ". " + recipe.directions[index])
                            .padding(.bottom, 5.0)
                    }
                    
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(recipe.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        //Create a dummy recipe and pass it into the detail view so that we can see a preview and not get an error
        
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
