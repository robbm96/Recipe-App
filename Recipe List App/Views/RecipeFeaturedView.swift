//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Robert Miller on 4/13/22.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    //Create a property that will use the instance created in the RecipeTabView
    @EnvironmentObject var model:RecipeModel
    
    //Create state property that will be used to show the recipe sheet in the button
    //Default set to false
    @State var isDetailViewShowing = false
    
    var body: some View {
       
        VStack(alignment: .leading, spacing: 0.0){
            
            Text("Featured Recipes")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top, 40)
            
            GeometryReader{ geo in
                
                //TabView used to show card stack of featured recipes
                TabView{
                    
                    //Loop through recipes array
                    ForEach(0..<model.recipes.count, id:\.self) { index in
                        
                        //Check if recipe is a featured recipe
                        if model.recipes[index].featured  == true {
                            
                            //Button to pull up recipe sheet when featured recipe is clicked on
                            Button(action: {
                                
                                //Set isDetailView to true to show DetailView sheet when button is clicked
                                isDetailViewShowing = true
                                
                            }, label: {
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.white)
                                    VStack(spacing:0){
                                        Image(model.recipes[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        Text(model.recipes[index].name)
                                            .padding(5)
                                    }
                                }
                            })
                            //Sheet modifier used to show DetailView sheet for featured recipes
                            .sheet(isPresented: $isDetailViewShowing, content: {
                                //Call RecipeDetailView and passing in recipe to dispaly sheet
                                RecipeDetailView(recipe: model.recipes[index])
                            })
                            .buttonStyle(PlainButtonStyle())
                                .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                                .cornerRadius(15)
                                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                            
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
            }
            
            VStack(alignment: .leading, spacing: 10.0){
                Text("Preperation time:")
                    .font(.headline)
                
                Text("1 Hour")
                
                Text("Highlights:")
                    .font(.headline)
                
                Text("Thicc, Juicy")
            }
            .padding([.top, .leading, .bottom])
            
            
        }
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}
