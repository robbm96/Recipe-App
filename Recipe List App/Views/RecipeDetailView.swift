//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Robert Miller on 4/8/22.
//

import SwiftUI

struct RecipeDetailView: View {
    
    //State property used for the selected serving size in the picker
    @State var selectedServingSize = 2
    
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
                
                //MARK: Recipe Title
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading)
                    
                
                //MARK: Serving Size Picker
                VStack(alignment: .leading) {
                    
                    //Text element
                    Text("Pick your serving size:")
                    
                    //Picker used for selection of serving sizes
                    Picker("", selection: $selectedServingSize ) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 160)
                }
                .padding([.leading, .bottom, .trailing])
                .padding(.top, 1)
                
                
                //MARK: Ingredients
                //VStack aligns "Ingredients" and ingredients property
                VStack(alignment: .leading){
                    Text("Ingredients")
                    .font(.headline)
                    .padding(.vertical, 5.0)
                    
                    //Use ForEach loop to generate the text elements for the ingredients property
                    //We are able to not include 'id: \.self' in the parameters for teh loop because 'ingredients' is Identifiable
                    ForEach(recipe.ingredients) { item in
                        Text("• " + RecipeModel.getPortion(ingredient: item, recipeServings: recipe.servings, targetServings: selectedServingSize) + " " + item.name.lowercased())
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
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        //Create a dummy recipe and pass it into the detail view so that we can see a preview and not get an error
        
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
