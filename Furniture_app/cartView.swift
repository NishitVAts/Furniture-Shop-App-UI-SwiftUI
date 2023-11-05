//
//  cartView.swift
//  Furniture_app
//
//  Created by Nishit Vats on 03/11/23.



import SwiftUI

struct cartView: View {
    var body: some View {
        ZStack{
            Color("Bg").ignoresSafeArea()
                VStack(alignment:.leading){
                    topBarView()
                    searchView()
            ScrollView{
                    HStack{
                            CartTagLine()
                            Spacer()
                        }.padding(.leading)
                VStack{
                        ForEach(cartItems){ currentProduct in
                            CartProductCardView(currentProduct: currentProduct)
                        }.cornerRadius(30)
                    
                    }
                    billView()
                }
                    continueToCheckOutButtonView().padding()
                    
            }
            
            
        }
    }
}

struct continueToCheckOutButtonView:View {
    var body: some View {
        ZStack{
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                RoundedRectangle(cornerRadius: 10).fill(Color("Primary"))
                    .frame(height: 60)
                    .overlay(
                        Text("Continue to Checkout")
                        
                    ).foregroundColor(.white)
            })
        }
    }
}

struct CartTagLine: View {
    var body: some View {
        Text("Bring us\n")
            .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary"))
        + Text("Home!") .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary")).bold()
    }
}

struct billView:View {
    var discountCode:Int = 0
    var totalMrp:Int = 0
    var discountMrp:Int = 0
    var convenienceFee:Int = 0
    var body: some View {
        let totalAmount = gettingTotalAmount()
        VStack(alignment:.leading,spacing: 20){
            HStack{
                Text("Price Details")
                Spacer()
                Text("\(totalAmount)")
            }
            HStack {
                Text("Total MRP")
                Spacer()
                Text("\(totalMrp)")
            }
            HStack {
                Text("Discount on MRP")
                Spacer()
                Text("\(discountMrp)")
            }
            HStack {
                Text("Coupon Discount")
                Spacer()
                Text("\(discountCode)")
            }
            HStack {
                Text("Convenience Fee")
                Spacer()
                Text("\(convenienceFee)")
            }
            HStack {
                Text("Total Amount").bold()
                Spacer()
                Text("\(totalAmount - (discountMrp + discountCode) + convenienceFee)").bold()
            }
        } .padding().background(Color.white)
           
    }
    
    func gettingTotalAmount() -> Int {
        var amount: Int = 0
        for item in cartItems {
            amount = amount + item.price
        }
        return amount
    }
}

struct CartProductCardView:View {
    @State var currentProduct:furniture
    @State var quantityIndex:Int = 1
    @State private var selection:String?
    var body: some View {
        ZStack{
            Color.white
            HStack{
                Image(currentProduct.imageName).resizable()
                    .aspectRatio(contentMode: .fit).cornerRadius(20)
                VStack(spacing:5){
                    Text(currentProduct.name).fontWeight(.medium).font(.title3)
                    Text(currentProduct.Description).font(.footnote).padding(.leading,30)
                    HStack{
                        ForEach(0..<5){_ in
                            Image("star")
                        }
                        Text("(4.9)")
                    }.padding(.leading,20)
                    VStack{
                        HStack(spacing:10){
                            Text("\(Image(systemName: "indianrupeesign"))\(currentProduct.price*quantityIndex)").padding(.leading)
                            ButtonView2(colorName: "white", iconName: "minus", iconColor: .black, strokeOrNot: true, width: 20, height: 20).onTapGesture {
                                if quantityIndex>0{
                                    quantityIndex-=1
                                }
                            }
                            Text("\(quantityIndex)")
                            ButtonView2(colorName: "Primary", iconName: "plus", iconColor: .white, strokeOrNot: false, width: 20, height: 20).onTapGesture {
                                quantityIndex+=1
                            }
                        }
                    }
                    
                }
            }.padding()
            
        }
    }
}

struct ButtonView2: View {
    let colorName:String
    let iconName:String
    let iconColor:Color
    let strokeOrNot:Bool
    let width:CGFloat
    let height:CGFloat
    var body: some View {
        if(strokeOrNot){
            Circle().stroke().frame(width: width, height: height)
                .shadow(radius: 10)
                .overlay(
                    Image(systemName: iconName).foregroundColor(iconColor)
                )
        }else{
            Circle().fill(Color(colorName)).frame(width: width, height: height)
                .shadow(radius: 10)
                .overlay(
                    Image(systemName: iconName).foregroundColor(iconColor)
                )
        }
    }
}


#Preview {
    cartView()
}

