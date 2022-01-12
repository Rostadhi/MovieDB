//
//  MovieView.swift
//  MovieDB
//
//  Created by Rostadhi Akbar, M.Pd on 12/01/22.
//

import Foundation
import SwiftUI
import SwiftUIX

struct MoviesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var genre:String?
    @State var movies:[GenreMovie]?
    @State var pages = 0
    @State var totalFound = 0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.vertical)
                .overlay(
                    VStack(alignment:.leading, spacing: 0){
                        Text("Found \(String(totalFound)) movies")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(Color.systemRed)
                            .padding()
                            .onAppear()
                        List {
                            
                            ForEach(0..<pages, id: \.hashValue) { index in
                                let movie = movies![index] as! GenreMovie
                                let detailVC:DetailView = DetailView(detailOverview: movie.overview!, detailPoster: movie.posterPath!, movieID: String(movie.id!), movieTitle:movie.title)
                                
                                NavigationLink(destination: detailVC){
                                    LazyHStack{
                                        if let imageName = movie.posterPath, let imageUrl = ApiCall.imageHost + imageName {
                                            AsyncImage(url: URL(string: imageUrl)!,
                                                       placeholder: { Text("Loading ...") },
                                                       image: { Image(uiImage: $0).resizable() })
                                                .frame(idealHeight: 120) // 2:3 aspect ratio
                                                .width(90)
                                        }
                                        LazyVStack(alignment:.leading, spacing: 0) {
                                            Text(movie.title!)
                                                .font(.system(.headline, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(10)
                                            LazyHStack(spacing: 0) {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.systemYellow)
                                                    .frame(idealHeight: 20)
                                                    .width(20)
                                                    .padding(2)
                                                Text(String(movie.voteAverage!))
                                                    .font(.system(.subheadline))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                            }.padding(5)
                                            Spacer()
                                        }.frame(width: UIScreen.main.bounds.width-120)
                                        Spacer()
                                        
                                    }
                                }
                            }
                            .listRowBackground(Color.black)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                )
            
        }
        .navigationTitle(genre!)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left")
            .foregroundColor(.white)
        }))
        .onAppear {
            if self.movies == nil {
                ApiCall().fetchMovie(genreID: GenreType.init(rawValue: genre!)!.getGenreID()) { (item) in
                    self.movies = (item as GenreServices).results
                    self.pages = movies!.count
                    self.totalFound = (item as GenreServices).totalResults!
                }
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView( genre: "")
    }
}
