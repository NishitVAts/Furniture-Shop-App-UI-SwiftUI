//
//  LikedItems.swift
//  Furniture_app
//
//  Created by Nishit Vats on 02/11/23.
//

import SwiftUI

struct LikedItems: View {
    var body: some View {
        ZStack{
            Color("Bg").ignoresSafeArea()
            VStack(alignment:.leading){
                topBarView()
                searchView()
                ScrollView{
                    VStack(){
                        favouriteTageLine()
                    }
               
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(demoData){ item in
                                ProductCard(currentProduct: item, size: 160)
                            }
                        }
                    }
                
                    
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(demoData){ item in
                                ProductCard(currentProduct: item, size: 160)
                            }
                        }
                    }
                    
                }
                CustomNavBar().frame(height: 50)
            }
            
        }
    }
}

struct favouriteTageLine: View {
    var body: some View {
        Text("We liked your\n")
            .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary"))
        + Text("Choice!") .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary")).bold()
    }
}

#Preview {
    LikedItems()
}
