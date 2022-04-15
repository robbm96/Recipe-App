//
//  ContentView.swift
//  Recipe List App
//
//  Created by Robert Miller on 4/6/22.
//

import SwiftUI

struct RecipeListView: View {
    
    //Create a property that will use the instance created in the RecipeTabView
    @EnvironmentObject var model:RecipeModel
    
    var body: some View {
        
        //Create a list with the data from the recipes array
        NavigationView {
            
            VStack(alignment: .leading) {
                
                //Text on top of view
                Text("All Recipes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(model.recipes) { r in
                            
                            //Use NavigationLink to create the arrows for each item so we can go to different views for each recipe
                            NavigationLink(
                                //RecipeDetailView needs the property from RecipeListView (recipe:) and the iterator(r) using in the List above
                                destination: RecipeDetailView(recipe: r) ,
                                label: {
                                    HStack(spacing: 20){
                                        
                                        //Display the image from the assets folder
                                        Image(r.image)
                                            //Allow the image to be resizable
                                            .resizable()
                                            //Scale the image to fill the frame
                                            .scaledToFill()
                                            //Create a frame with a specified width and height
                                            .frame(width: 50, height: 50, alignment: .center
                                            )
                                            //Clip the overflowing portion of the image
                                            .clipped()
                                            //Round the corners of the image
                                            .cornerRadius(5)
                                        //Display the text of the food
                                        Text(r.name)
                                            .foregroundColor(.black)
                                }
                            })
                            //Create and HStack to display the data horizontally. "spacing" dictates the space between each piece of data. I.E. the image and the text
                        }
                    }
                }
            }
            //Remove the extra white space at the top of the view where the navigation title would normally be
            .navigationBarHidden(true)
            .padding(.leading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
