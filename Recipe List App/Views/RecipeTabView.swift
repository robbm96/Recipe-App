//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Robert Miller on 4/12/22.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        
        //Container to create tabs
        TabView{
            
            //First tab item
            Text("Featured View")
                .tabItem{
                    VStack{
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
            
            //Second tab item
            //Create an instance of RecipeListView() to use as the tab item
            RecipeListView()
                .tabItem{
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("Recipe List")
                    }
                }
        }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
