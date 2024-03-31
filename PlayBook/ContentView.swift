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
            VStack {
                HStack{ //Header
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45)
                        .padding(-5)
                    Text("LAYBOOK")
                        .fontWeight(.heavy)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding(-1)
                        .underline()
                    Spacer()
                    Button(action: {}) //Dentro de action lo que sea
                    {Image(systemName: "bubble.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35)
                            .foregroundStyle(.black)
                            .padding(.trailing,10)
                        
                    }
                    Button(action: {}) //Dentro de action lo que sea
                    {Image(systemName: "bell")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(.black)
                            .padding(.leading,10)
                    }
                } //Fin del Header
                Divider().frame(height: 5)
                ZStack(alignment:.bottomTrailing){
                    ScrollView(.vertical){
                        Button(action:{}){
                            Rectangle() // Recuadro Comisiones
                                .opacity(0)
                                .frame(width: 350,height: 60)
                                .overlay{
                                    VStack{
                                        HStack{
                                            Image("logo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30)
                                                .padding(.leading,10)
                                            Text("EVITA COMISIONES")
                                                .bold()
                                                .foregroundStyle(.black)
                                            Spacer()
                                        }.padding(.top,5)
                                        HStack{
                                            Text("No pagues comisiones y ahorra dinero")
                                                .font(.footnote)
                                                .foregroundStyle(.gray)
                                                .padding(.leading,10)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    HStack{
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10)
                                            .foregroundStyle(.black)
                                            .padding(.trailing,10)
                                    }
                                }
                        } // Fin recuadro comisiones
                        Divider().frame(height: 5)
                        HStack{
                            Text("Recuerda...")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                                .padding(.leading,10)
                            Spacer()
                        } // Recuerda
                        Button(action:{}){ // Boton Preferencias
                            RoundedRectangle(cornerRadius: 10)
                                .shadow(radius: 5)
                                .foregroundStyle(.white)
                                .frame(width: 340,height: 60)
                                .overlay{
                                    HStack{
                                        VStack{
                                            RoundedRectangle(cornerRadius: 10)
                                                .scaledToFit()
                                                .foregroundStyle(.gray)
                                                .opacity(0.3)
                                                .frame(width: 50)
                                                .padding(.leading,10)
                                                .overlay{
                                                    Image(systemName: "sportscourt")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 40)
                                                        .padding(.leading,10)
                                                        .foregroundStyle(.black)
                                                }
                                        }
                                        Spacer()
                                        VStack{
                                            Text("Edita tus preferencias de juego")
                                                .font(.subheadline)
                                                .foregroundStyle(.black)
                                            Text("Mejor mano, lado en la cancha, tipo...")
                                                .font(.caption)
                                                .foregroundStyle(.gray)
                                        }
                                        Spacer()
                                        VStack{
                                            Image(systemName: "arrow.right")
                                                .padding(.trailing,10)
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
                        }.padding(.bottom,15) // Fin Boton Preferencias
                        HStack{
                            Text("Encuentra tu partido perfecto")
                                .font(.title2)
                                .bold()
                                .padding(.leading,10)
                            Spacer()
                        } // Encuentra tu partido perfecto
                        VStack{
                            HStack{
                                NavigationLink(destination: Reserva(), label: { // OJO, SOLO ESTE ES UN NAVIGATION LINK, LOS DEMÁS SON BOTONES.
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 170, height: 220)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    Image("1")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 160, height: 90)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                                        .padding(.top,5)
                                                        .overlay{
                                                            RoundedRectangle(cornerRadius: 10)
                                                                .foregroundColor(.black)
                                                                .frame(width: 50, height: 50)
                                                                .overlay{
                                                                    Image(systemName: "magnifyingglass")
                                                                        .foregroundStyle(.white)
                                                                }
                                                                .offset(x:-50,y:15)
                                                        }
                                                    Text("Reserva una cancha")
                                                        .bold()
                                                        .font(.title3)
                                                        .foregroundStyle(.black)
                                                    Text("Si ya sabes con quien vas a jugar")
                                                        .foregroundStyle(.black)
                                                        .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 5))
                                                    Spacer()
                                                }
                                            }
                                    }
                                })
                                Button(action:{}){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 170, height: 220)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    Image("2")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 160, height: 90)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                                        .padding(.top,5)
                                                        .overlay{
                                                            RoundedRectangle(cornerRadius: 10)
                                                                .foregroundColor(.black)
                                                                .frame(width: 50, height: 50)
                                                                .overlay{
                                                                    Image(systemName: "baseball")
                                                                        .foregroundStyle(.white)
                                                                }
                                                                .offset(x:-50,y:15)
                                                        }
                                                    Text("Unete a un partido abierto")
                                                        .bold()
                                                        .font(.title3)
                                                        .foregroundStyle(.black)
                                                    Text("Si buscas otros jugadores")
                                                        .foregroundStyle(.black)
                                                        .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 5))
                                                    Spacer()
                                                }
                                            }
                                    }
                                } //Boton Unirse
                            }
                            HStack{
                                Button(action:{}){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 170, height: 120)
                                            .foregroundColor(.white)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .foregroundColor(.black)
                                                        .frame(width: 50, height: 50)
                                                        .overlay{
                                                            Image(systemName: "figure.disc.sports")
                                                                .foregroundStyle(.white)
                                                        }
                                                    Text("Clases")
                                                        .bold()
                                                        .font(.title3)
                                                        .foregroundStyle(.black)
                                                    Spacer()
                                                }
                                                .padding(.top,20)
                                            }
                                        
                                    }
                                } //Boton Clases
                                Button(action:{}){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 170, height: 120)
                                            .foregroundColor(.white)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .foregroundColor(.black)
                                                        .frame(width: 50, height: 50)
                                                        .overlay{
                                                            Image(systemName: "shield")
                                                                .foregroundStyle(.white)
                                                        }
                                                    Text("Competencias")
                                                        .bold()
                                                        .font(.title3)
                                                        .foregroundStyle(.black)
                                                    Spacer()
                                                }
                                                .padding(.top,20)
                                            }
                                        
                                    }
                                } //Boton Competencias
                            }
                        } // Recuadros opciones
                        HStack{
                            Text("Clubes")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                                .padding(.leading,10)
                            Spacer()
                        } // Clubes
                        HStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                                .frame(width: 170, height: 230)
                                .overlay{
                                    VStack(alignment: .center){
                                        Circle()
                                            .scaledToFit()
                                            .frame(width: 70)
                                            .foregroundStyle(.gray)
                                            .opacity(0.3)
                                            .overlay{
                                                Image(systemName: "network")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50)
                                                    .foregroundStyle(.black)
                                            }
                                            .padding(.top,10)
                                        Text("Encuentra clubs cercanos")
                                            .bold()
                                            .padding(.top,5)
                                            .multilineTextAlignment(.center)
                                        Text("Activar localización")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                            .padding(.top,5)
                                        Button(action:{}){
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: 100,height: 25)
                                                .foregroundStyle(.gray)
                                                .opacity(0.3)
                                                .overlay{
                                                    Text("Activar")
                                                        .foregroundStyle(.black)
                                                }
                                                .padding(.top,5)
                                        }
                                        Spacer()
                                    }
                                }
                                .padding(.leading,5)
                            Spacer()
                        } // Activar Ubicación
                    }
                    Button(action:{}){ // Botón suma
                        Circle()
                            .scaledToFit()
                            .frame(width: 60)
                            .foregroundStyle(.black)
                            .overlay{
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundColor(.white)
                            }.padding(.bottom,10)
                    }
                }
                Spacer()
                HStack{
                    Button(action:{}){
                        Rectangle()
                            .frame(width: 65, height: 65)
                            .opacity(0)
                            .overlay{
                                VStack{
                                    Image(systemName: "basketball.fill")
                                        .resizable()
                                        .padding(.top,10)
                                        .frame(width: 30,height: 40)
                                        .foregroundColor(.black)
                                    Text("Jugar")
                                        .bold()
                                        .foregroundStyle(.black)
                                        .font(.footnote)
                                    Spacer()
                                }
                            }
                            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    } // Jugar
                    Button(action:{}){
                        Rectangle()
                            .frame(width: 65, height: 65)
                            .opacity(0)
                            .overlay{
                                VStack{
                                    Image(systemName: "dumbbell")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.top,10)
                                        .frame(width: 40,height: 40)
                                        .foregroundColor(.black)
                                    Text("Explorar")
                                        .font(.footnote)
                                        .bold()
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                            }
                            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    } // Explorar
                    Button(action:{}){
                        Rectangle()
                            .frame(width: 73, height: 65)
                            .opacity(0)
                            .overlay{
                                VStack{
                                    Image(systemName: "house")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.top,10)
                                        .frame(width: 40,height: 40)
                                        .foregroundColor(.black)
                                    Text("Comunidad")
                                        .font(.footnote)
                                        .bold()
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                            }
                            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    } // Comunidad
                    Button(action:{}){
                        Rectangle()
                            .frame(width: 65, height: 65)
                            .opacity(0)
                            .overlay{
                                VStack{
                                    Image(systemName: "person")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.top,10)
                                        .frame(width: 40,height: 40)
                                        .foregroundColor(.black)
                                    Text("Perfil")
                                        .font(.footnote)
                                        .bold()
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                            }
                            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    } // Perfil
                    
                } // Barra de secciones
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

struct Reserva: View {
    @Environment(\.dismiss) var dismiss
    @State private var ubicacion: String = ""
    @State private var deporte: String = "Pádel"
    @State private var date = Date()
    
    let deportes = ["Pádel", "Tennis", "Fútbol", "Basquetbol"]
    
    @State var todo =
    ["Pádel" : [
        ["padel1","Puntaco", "550"],
        ["padel2","Padel & Pickle GM Bugambilias", "320"],
        ["padel3","Padel Factory Sur", "380"],
        ["padel4","Padel Spot Network", "390"]
               ],
     "Tennis" :[
        ["tennis1","Cancha 1", "120"],
        ["tennis2","Cancha 2", "150"],
        ["tennis3","Cancha 3", "130"],
        ["tennis4","Cancha 4", "180"]
               ],
     "Basquetbol" :[
        ["basquet1","Cancha 1", "800"],
        ["basquet2","Cancha 2", "920"],
        ["basquet3","Cancha 3", "720"],
        ["basquet4","Cancha 4", "800"]
                   ],
     "Fútbol" :[
        ["fut1","Cancha 1", "1300"],
        ["fut2","Cancha 2", "1290"],
        ["fut3","Cancha 3", "999"],
        ["fut4","Cancha 4", "1520"]
               ]
    ]
    
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
                                    .tint(.black)
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
            
            AllSpots(infoDeportes: todo[deporte]!)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Spot: View {
    
    var item:[String]
    
    let counter = 12...21
    @State var icon:String = "heart"
    
    var body: some View {
        NavigationStack{
                VStack(spacing: 0) {
                    NavigationLink(destination: {SpotEspecifico(infoDeportes: item)}){
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
                                .padding(.horizontal)
                                .foregroundStyle(.white)
                                HStack(){
                                    Text(item[1])
                                    Spacer()
                                    VStack{
                                        Text("1h desde")
                                            .font(.caption)
                                        Text("MX$\(item[2])")
                                    }
                                }
                                .font(.title)
                                .foregroundStyle(.white)
                                .bold()
                                .padding(.horizontal)
                                .padding(.bottom, 15)
                                
                            }
                        }
                        .frame(minWidth: 400, minHeight: 250)
                    }
                    ScrollView(.horizontal){
                        HStack(spacing: 15){
                            ForEach(counter, id:\.self){item in
                                NavigationLink(destination: {SpotEspecifico(infoDeportes: self.item)}){
                                    Text("\(item):00")
                                        .padding()
                                        .padding(.horizontal, 10)
                                        .background(.white)
                                        .border(.gray)
                                }
                                NavigationLink(destination: {SpotEspecifico(infoDeportes: self.item)}){
                                    Text("\(item):30")
                                        .padding()
                                        .padding(.horizontal, 10)
                                        .background(.white)
                                        .border(.gray)
                                        
                                }
                            }
                            .tint(.black)
                        }
                        .padding()
                    }
                    .background(.white)
            }
        }
    }
}

struct AllSpots: View {
    var infoDeportes: [[String]]
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 20) {
                ForEach(infoDeportes, id: \.self){item in
                    Spot(item: item)
                }
            }
            .padding(.top, 20)
        }
        .frame(minWidth: 400)
        .background(.gray.opacity(0.3))
    }
}

struct SpotEspecifico: View {
    @Environment(\.dismiss) var dismiss
    var infoDeportes: [String]
    var body: some View {
        ZStack{
         Image(systemName: "arrow.backward")
                .resizable()
                .scaledToFit()
                .frame(width: 20)
                .foregroundStyle(.red)
                .padding()
                .background(content:{
                    Circle()
                        .fill(.white)
                })
                .opacity(0.8)
        }
        .navigationBarBackButtonHidden(true)
        .background(.blue)
        Text("Cosa")
    }
}

