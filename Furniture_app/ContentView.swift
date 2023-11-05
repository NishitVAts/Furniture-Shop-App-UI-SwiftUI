//
//  ContentView.swift
//  Furniture_app
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    var body: some View {
        TabView {
            homeView()
                .tabItem {
                    Label(
                        title: { Text("Home") },
                        icon: { /*@START_MENU_TOKEN@*/Image(systemName: "42.circle")/*@END_MENU_TOKEN@*/ }
                    )
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct topBarView: View {
    var body: some View {
        HStack{
            Button(action: {}, label: {
                Image("menu").padding().background(Color.white)
                    .cornerRadius(10)
            })
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image("Profile").resizable().frame(width: 42, height: 42)
                    .cornerRadius(10)
            })
        }.padding()
    }
}

struct tagLineView: View {
    var body: some View {
        Text("Find The\nbest ")
            .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary"))
        + Text("Furniture!") .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary")).bold()
    }
}

struct searchView: View {
    @State private var isShowingScanner:Bool = false
    @State private var SearchString:String = ""
    var body: some View {
        HStack{
            HStack{
                Image("Search").padding(.trailing , 5)
                TextField("Search Furniture",text: $SearchString)
            }.padding().background(Color.white)
                .cornerRadius(10)
            
            
            Button(action: {
                isShowingScanner = true
            }, label: {
                Image(systemName:"camera").foregroundColor(.white)
                    .padding()
                    .background(Color("Primary"))
                    .cornerRadius(10)
                
            })
            .sheet(isPresented: $isShowingScanner , content: {
                CodeScannerView(codeTypes: [.qr], simulatedData: "hello World", completion: handleScanner)
            })
            
        }.padding(.horizontal)
    }
    func handleScanner(result: Result<ScanResult, ScanError>){
        isShowingScanner = false
        switch result{
        case .success(let result):
            let details = result.string.components(separatedBy: "\n" )
            guard details.count == 2 else{ return }
            
        case .failure(_): break
            
        }
    }
}

struct CategoryView: View {
    let isActive:Bool
    let textString:String
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            Text(textString)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(Color("Primary"))
            if(isActive){
                Color("Primary").frame(width: 25,height: 2)
                    .clipShape(Capsule())
            }
          
        }.padding()
    }
}

struct ProductCard: View {
    @State var currentProduct:furniture
    let size:CGFloat
    var body: some View {
        VStack{
            ZStack(alignment:.topTrailing){
                Image(currentProduct.imageName).resizable()
                    .frame(width: size, height: 200*(size/210))
                    .cornerRadius(20)
                likeButtonView(currentProduct:$currentProduct ,isLikedorNot: currentProduct.isLiked)
            }
            Text(currentProduct.name)
                .font(.title3).bold()
            HStack{
                ForEach(0..<5){_ in
                    Image("star")
                }
                Spacer()
                Image(systemName: "indianrupeesign")
                Text("\(currentProduct.price)").font(.title3)
               
            }
        }.frame(width: size)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
    }
}

struct NavigationBarView: View {
    let image: Image
    let action: ()-> Void
    var body: some View {
        Button(action: action, label: {
           image
                .frame(maxWidth: .infinity)
        })
    }
}

struct likeButtonView:View {
    @Binding var currentProduct:furniture
    @State var isLikedorNot:Bool
    var body: some View {
        Button(action: {
            isLikedorNot.toggle()
            if(isLikedorNot){
                addingItems(itemLiked: currentProduct)
            }else{
                
            }
            
        }, label: {
            if(isLikedorNot){
                Image(systemName:"heart.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 20,height: 20).padding().foregroundColor(.red).background(Color.white).cornerRadius(100).padding(.trailing,5).padding(.top,5)
                //adding currentProdcut to the likedItem Data
                    
            }else{
                Image(systemName:"heart").resizable().aspectRatio(contentMode: .fit).frame(width: 20,height: 20).padding().foregroundColor(.black).background(Color.white).cornerRadius(100).padding(.trailing,5).padding(.top,5)
            }
        })
    }
    
    func addingItems(itemLiked:furniture){
        likedFurniture.append(itemLiked)
    }
    
    func removingItems(itemLiked:furniture){
        likedFurniture.removeLast()
    }
   
}



struct imageView:View {
    let imageName:String
    var body: some View {
        Image("imageName").resizable().aspectRatio(contentMode: .fit)
    }
}

struct CustomNavBar: View {
    var body: some View {
        HStack {
            HStack{
                NavigationBarView(image: Image("Home")) {
                }
                NavigationBarView(image: Image(systemName:"heart")) {
                }.foregroundColor(Color.black)
                NavigationBarView(image: Image(systemName:"cart")) {
                }.foregroundColor(Color.black)
                NavigationBarView(image: Image("User")) {
                }
            }.padding()
                .background(Color.white)
                .clipShape(Capsule())
                .padding(.horizontal)
                .shadow(radius: 10)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

struct homeView: View {
    @State private var selectedIndex:Int = 0
    private let categories: [String] = ["All", "Chair","Sofa", "lamp", "Kitchen", "Table"]
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack{
            VStack{
                NavigationView {
                    ZStack{
                        Color("Bg").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        ScrollView {
                            VStack(alignment:.leading){
                                topBarView()
                                tagLineView().padding()
                                searchView()
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack{
                                        ForEach(0..<categories.count){ item in
                                            CategoryView(isActive: item == selectedIndex , textString: categories[item])
                                                .onTapGesture {
                                                    selectedIndex = item
                                                }
                                        }
                                    }.padding()
                                }
                                
                                Text("Popular").font(.custom("PlayFairDisplay-Bold", size:24))
                                    .padding(.leading)
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        ForEach(demoData){ index in
                                            NavigationLink(destination: selectedProductView(currentItem: index)) {
                                                ProductCard(currentProduct: index, size: 210)
                                            }.navigationBarHidden(true)
                                                .foregroundColor(.black)
                                        }
                                    }.padding(.trailing)
                                    
                                }.padding(.horizontal)
                                
                                Text("Best").font(.custom("PlayFairDisplay-Bold", size:24))
                                    .padding(.leading)
                                    .padding(.top)
                                
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        ForEach(demoData){ index in
                                            NavigationLink(destination: selectedProductView( currentItem: index)) {
                                                ProductCard(currentProduct: index, size: 180)
                                            }.navigationBarHidden(true)
                                                .foregroundColor(.black)
                                        }
                                    }.padding(.trailing)
                                    
                                }.padding(.horizontal)
                                
                            }
                        }
                        
                        
                    }
                }
            }
        }
    }
}
