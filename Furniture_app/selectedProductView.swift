//
//  selectedProductView.swift
//  Furniture_app
//
//  Created by Nishit Vats on 01/11/23.
//

import SwiftUI

struct selectedProductView: View {
    @State var quantityIndex:Int = 0
    @State var currentItem:furniture
    var body: some View {
        ZStack{
            Color("Bg")
            ScrollView{
                NavigationLink(destination: imageView(imageName: currentItem.imageName)) {
                    Image(currentItem.imageName).resizable()
                            .aspectRatio(contentMode: .fit)
                            .edgesIgnoringSafeArea(.top)
                    }
                    VStack(alignment:.leading){
                        Text(currentItem.name).bold()
                            .font(.title)
                        HStack{
                            ForEach(0..<5){ _ in
                                Image("star")
                            }
                            Text("(4.9)")
                        }.padding(.bottom)
                        Text("Description").bold().padding(.bottom)
                        Text(currentItem.Description)
                            .opacity(0.5).lineSpacing(5)
                        
                        HStack(alignment:.top){
                            VStack(alignment:.leading){
                                Text("Size").fontWeight(.medium).padding(.bottom, 5).padding(.top,3)
                                VStack(alignment:.leading){
                                    Text("Height")
                                    Text("Width")
                                    Text("Diameter")
                                }.opacity(0.5)
                                
                            }
                            Spacer()
                            VStack(alignment:.leading){
                                Text("Treatment").fontWeight(.medium).padding(.bottom, 5).padding(.top,3)
                                VStack(alignment:.leading){
                                    Text("Jati Wood")
                                    Text("Canvas")
                                    Text("Amazing love")
                                }.opacity(0.5)
                                
                            }
                        }.padding(.bottom)
                        
                        HStack(alignment:.top){
                            VStack(alignment:.leading){
                                Text("Colors").fontWeight(.medium)
                                HStack{
                                    Circle().fill(.white)
                                        .frame(width: 24, height: 24)
                                        
                                    
                                    Circle().fill(.black)
                                        .frame(width: 24, height: 24)
                                    
                                    Circle().fill(.green)
                                        .frame(width: 24, height: 24)
                                        
                                }
                            }
                            Spacer()
                            VStack{
                                Text("Quantity").fontWeight(.medium)
                                
                                HStack(spacing:20){
                                    ButtonView(colorName: "white", iconName: "minus",iconColor: .black,strokeOrNot: true)
                                        .onTapGesture {
                                            if(quantityIndex>0){
                                                quantityIndex = quantityIndex-1
                                            }
                                        }
                                    
                                    Text("\(quantityIndex)").font(.title2)
                                    
                                    ButtonView(colorName: "Primary", iconName: "plus",iconColor: .white, strokeOrNot: false)
                                        .onTapGesture {
                                            quantityIndex = quantityIndex+1
                                    }
                                }
                                
                            }
                        }
                        Spacer()
                        
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(40)
                        .offset(y: -40)
                
            }
            HStack{
                Text("\(Image(systemName: "indianrupeesign"))\(currentItem.price)").font(.title)
                Spacer()
                Button(action: {
                    cartItems.append(currentItem)
                }, label: {
                    Text("Add to Cart").padding()
                        .padding(.horizontal)
                        .background(Color.white)
                        .foregroundColor(Color("Primary"))
                        .cornerRadius(30)
                })
                
            }.padding().background(Color("Primary"))
                .frame(maxHeight: .infinity, alignment: .bottom)
               
                
            
            
        }.ignoresSafeArea()
    }
}

#Preview {
    selectedProductView( currentItem: demoData[0])
}

struct ButtonView: View {
    let colorName:String
    let iconName:String
    let iconColor:Color
    let strokeOrNot:Bool
    var body: some View {
        if(strokeOrNot){
            Circle().stroke().frame(width: 35, height: 35)
                .shadow(radius: 10)
                .overlay(
                    Image(systemName: iconName).foregroundColor(iconColor)
                )
        }else{
            Circle().fill(Color(colorName)).frame(width: 35, height: 35)
                .shadow(radius: 10)
                .overlay(
                    Image(systemName: iconName).foregroundColor(iconColor)
                )
        }
    }
}
