//
//  ContentView.swift
//  PlayBook
//
//  Created by Jaime Tadeo Alfaro Rodríguez on 30/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            NavigationLink(destination: Reserva(), label: {
                Text("Main Page")
            })
        }.tint(.black)
    }
}

#Preview {
    ContentView()
}

struct Reserva: View {
    @Environment(\.dismiss) var dismiss
    @State private var ubicacion: String = ""
    @State private var deporte: String = ""
    @State private var date = Date()
    
    let deportes = ["Pádel", "Tennis", "Fútbol", "Básquetbol"]
    
    let padel = [["puntaco","Puntaco", "550"], ["pickle","Padel & Pickle GM Bugambilias", "320"], ["factory","Padel Factory Sur", "380"]]
    
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 0){
                VStack{
                    ZStack{
                        HStack {
                            Button(action:{
                                dismiss()
                            }){
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:10)
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        Text("Buscar")
                            .bold()
                            .font(.title)
                    }
                }
                HStack{
                    Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
                    TextField("Cerca de mí", text: $ubicacion)
                        .padding(.leading, 15)
                    Spacer()
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 15)
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .padding()
                .background(content: {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.gray)
                        .opacity(0.2)
                })
                .padding()
                HStack(spacing: 20){
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Picker("Deporte", selection: $deporte){
                        ForEach(deportes, id:\.self){item in
                            Text("\(item)")
                        }
                    }
                    .frame(minWidth: 150)
                    .tint(.black)
                    .background(content:{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray.opacity(0.15))
                    })
                    DatePicker("",
                                      selection: $date,
                                      in: Date()...,
                                      displayedComponents: [.date]
                           )
                    .frame(maxHeight: .zero)
                    .labelsHidden()
                    .accentColor(.black)
                    Spacer()
                }
                .padding(.horizontal)
            }
            Spacer()
            ScrollView(.vertical){
                VStack(spacing: 20) {
                    ForEach(padel, id: \.self){item in
                        ExtractedView(item: item)
                    }
                }
                .padding(.top, 20)
            }
            .frame(minWidth: 400)
            .background(.gray.opacity(0.3))
        }
            .navigationBarBackButtonHidden(true)
    }
}

struct ExtractedView: View {
    
    var item:[String]
    
    let counter = 12...21
    @State var icon:String = "heart"
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack{
                Image(item[0])
                    .resizable()
                    .frame(width: 400, height: 250)
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black]), startPoint: .top, endPoint: .bottom))
                VStack{
                    HStack{
                        Spacer()
                        Button(action:{
                            if icon == "heart" {
                                icon = "heart.fill"
                            } else {
                                icon = "heart"
                            }
                            
                        }){
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .padding()
                                .padding(.top, 10)
                                .padding(.trailing, 10)
                                .foregroundStyle(.white)
                        }
                        
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Text("1h desde")
                    }
                    .padding(.horizontal)
                    .foregroundStyle(.white)
                    HStack(){
                        Text(item[1])
                        Spacer()
                        Text("MX$\(item[2])")
                    }
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom, 15)
                    
                }
            }
            .frame(minWidth: 400, minHeight: 250)
            ScrollView(.horizontal){
                HStack(spacing: 15){
                    ForEach(counter, id:\.self){item in
                        Text("\(item):00")
                            .padding()
                            .padding(.horizontal, 10)
                            .background(.white)
                            .border(.gray)
                        Text("\(item):30")
                            .padding()
                            .padding(.horizontal, 10)
                            .background(.white)
                            .border(.gray)
                    }
                }
                .padding()
            }
            .background(.white)
        }
    }
}
