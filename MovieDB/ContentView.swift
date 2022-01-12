//
//  ContentView.swift
//  MovieDB
//
//  Created by Rostadhi Akbar, M.Pd on 12/01/22.
//

import SwiftUI
import SwiftUIX
import Combine

struct ContentView: View {
    @State var showDetail = false
    @State var isEditing: Bool = false
    @State var searchText: String = ""
    let genres:[String] = GenreType.allValues
    
    var publisher: AnyPublisher<Void, Never>
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        let publisher = PassthroughSubject<Void, Never>()
        self.publisher = publisher.eraseToAnyPublisher()
        
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.systemGray5]), startPoint: .top, endPoint: .bottom)
                                .edgesIgnoringSafeArea(.vertical)
                                .overlay(
                                    VStack(alignment:.center){
                                        Text("Movie App")
                                            .font(.system(.largeTitle, design: .rounded))
                                        SearchBar("Search...", text: $searchText, isEditing: $isEditing)
                                            .showsCancelButton(isEditing)
                                            .onCancel { print("Canceled!") }
                                        List {
                                            ForEach(genres.filter({ (genre: String) -> Bool in
                                                return genre.hasPrefix(searchText) || searchText == ""
                                            }), id: \.self) { genre in
                                                NavigationLink(destination: MoviesView( genre: genre)) {
                                                    Text(genre)
                                                }
                                            }
                                        }.padding(5)
                                    }
                                )
                
                
            }
            .accentColor(.white)
            .navigationBarHidden(true)
            .onReceive(publisher, perform: { _ in
                self.showDetail = false
            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
