//
//  ContentView.swift
//  PlayBook
//
//  Created by Jaime Tadeo Alfaro Rodríguez on 30/03/24.
//

import SwiftUI

struct ContentView: View { // Main
    var body: some View {
        NavigationStack{
            VStack {
                Header() //Header
                Divider().frame(height: 5)
                ZStack(alignment:.bottomTrailing){
                    ScrollView(.vertical){
                        Comisiones() // Recuadro comisiones
                        Divider().frame(height: 5)
                        HStack{
                            Text("Recuerda...")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                                .padding(.leading,10)
                            Spacer()
                        } // Recuerda
                        Preferencias() // Boton Preferencias
                        HStack{
                            Text("Encuentra tu partido perfecto")
                                .font(.title2)
                                .bold()
                                .padding(.leading,10)
                            Spacer()
                        } // Encuentra tu partido perfecto
                        RecuadrosOpc() // Recuadros opciones
                        HStack{
                            Text("Clubes")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                                .padding(.leading,10)
                            Spacer()
                        } // Clubes
                        ActivarUbicacion() // Activar Ubicación
                    }
                    BotonAdd() // Boton Suma
                }
                Spacer()
                BarraSelect() // Barra inferior seleccion
            }
            .padding()
        }
    }
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
        ["padel4","Padel Sport Network", "390"]
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

struct PartidoPublico: View {
    @Environment(\.dismiss) var dismiss
    @State private var deporte: String = "Pádel"
    @State private var date = Date()
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2024, month: 03, day: 31)
        let endComponents = DateComponents(year: 2024, month: 04, day: 08)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    let fecha1_padel = "2024-04-03"
    let fecha2_padel = "2024-04-06"
    let fecha1_tennis = "2024-04-02"
    let fecha2_tennis = "2024-04-05"
    let fecha1_basket = "2024-04-04"
    let fecha2_basket = "2024-04-06"
    let fecha1_fut = "2024-04-01"
    let fecha2_fut = "2024-04-07"
    let deportes = ["Pádel", "Tennis", "Fútbol", "Basquetbol"]
    
    private func datesAreEqual(dateString: String) -> Bool {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let fechaDate = dateFormatter.date(from: dateString) else {
                return false // La cadena de fecha no pudo ser convertida a Date
            }
            return Calendar.current.isDate(date, equalTo: fechaDate, toGranularity: .day)
        }
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
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
                        Text("Partidos")
                            .bold()
                            .font(.title)
                    }
                    Divider()
                        .frame(width: 600)
                }
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
                    DatePicker(
                            "Start Date",
                             selection: $date,
                             in: dateRange,
                             displayedComponents: [.date]
                        )
                    .frame(maxHeight: .zero)
                    .labelsHidden()
                    .accentColor(.black)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical)
                ScrollView(.vertical){
                    VStack{
                        Divider()
                            .frame(width:600)
                        if deporte == "Pádel" {
                            if datesAreEqual(dateString: fecha1_padel){
                                Text("Para tu nivel")
                                    .bold()
                                    .font(.system(size: 20))
                                    .frame(alignment: .leading)
                                Text("Estos partidos reflejan exactamente tu nivel")
                                    .foregroundColor(.gray)
                                Text("fecha y clubs buscados")
                                    .foregroundColor(.gray)
                                NavigationLink(destination: CheckOut(infoPlace: ["padel1","Puntaco", "550"], infoReservacion: ["3", "19:00", "2", "825", "90"], share: 125), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("miércoles 03 | 7:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("7km · Puntaco")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Jaime")
                                                                .foregroundColor(.black)
                                                            Text("2.00")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.76 - 2.76")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$125")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                                NavigationLink(destination:CheckOut(infoPlace: ["padel3","Padel Factory Sur", "380"], infoReservacion: ["3", "21:00", "2", "825", "90"], share: 125) , label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("miércoles 03 | 9:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("9km · Padel Factory Sur")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Arturo")
                                                                .foregroundColor(.black)
                                                            Text("2.20")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Max")
                                                                .foregroundColor(.black)
                                                            Text("2.50")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.76 - 2.76")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$125")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                            }else if datesAreEqual(dateString: fecha2_padel){
                                Text("Para tu nivel")
                                    .bold()
                                    .font(.system(size: 20))
                                    .frame(alignment: .leading)
                                Text("Estos partidos reflejan exactamente tu nivel")
                                    .foregroundColor(.gray)
                                Text("fecha y clubs buscados")
                                    .foregroundColor(.gray)
                                NavigationLink(destination: CheckOut(infoPlace: ["padel4","Padel Sport Network", "390"], infoReservacion: ["6", "19:00", "2", "825", "90"], share: 200), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("sabado 06 | 7:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("3km · Padel Sport Network")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Martin")
                                                                .foregroundColor(.black)
                                                            Text("1.50")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.26 - 2.26")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$200")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                                NavigationLink(destination:CheckOut(infoPlace: ["padel3","Padel Factory Sur", "380"], infoReservacion: ["6", "14:00", "2", "825", "90"], share: 200), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("sabado 06 | 2:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("9km · Padel Factory Sur")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Xavi")
                                                                .foregroundColor(.black)
                                                            Text("3.20")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Dennis")
                                                                .foregroundColor(.black)
                                                            Text("3.50")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 3.16 - 4.16")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$200")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                            }
                            else{
                                Text("Lo siento, no hemos encontrado ningun partido")
                                    .bold()
                                Text("con estos filtros, ¿por que no pruebas con otros?")
                                    .bold()
                            }
                        }
                        if deporte == "Tennis" {
                            if datesAreEqual(dateString: fecha1_tennis){
                                Text("Para tu nivel")
                                    .bold()
                                    .font(.system(size: 20))
                                    .frame(alignment: .leading)
                                Text("Estos partidos reflejan exactamente tu nivel")
                                    .foregroundColor(.gray)
                                Text("fecha y clubs buscados")
                                    .foregroundColor(.gray)
                                NavigationLink(destination: CheckOut(infoPlace: ["tennis1","Cancha 1", "120"], infoReservacion: ["2", "19:00", "2", "180", "90"], share: 45), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("martes 02 | 7:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("3km · CODE Metropolitano")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Jaime")
                                                                .foregroundColor(.black)
                                                            Text("1.50")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Cesar")
                                                                .foregroundColor(.black)
                                                            Text("2.00")
                                                                .foregroundColor(.black)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.40 - 2.40")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$45")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                                NavigationLink(destination:CheckOut(infoPlace: ["tennis4","Cancha 4", "180"], infoReservacion: ["2", "09:00", "2", "270", "90"], share: 67) , label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("martes 02 | 9:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("9km · Hacienda San Javier")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Arturo")
                                                                .foregroundColor(.black)
                                                            Text("2.20")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Max")
                                                                .foregroundColor(.black)
                                                            Text("2.50")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.76 - 2.76")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$67")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                            }else if datesAreEqual(dateString: fecha2_tennis){
                                Text("Para tu nivel")
                                    .bold()
                                    .font(.system(size: 20))
                                    .frame(alignment: .leading)
                                Text("Estos partidos reflejan exactamente tu nivel")
                                    .foregroundColor(.gray)
                                Text("fecha y clubs buscados")
                                    .foregroundColor(.gray)
                                NavigationLink(destination: CheckOut(infoPlace: ["tennis4","Cancha 4", "180"], infoReservacion: ["5", "09:00", "2", "270", "90"], share: 67), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("viernes 05 | 7:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("3km · Club de Golf Santa Anita")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Martin")
                                                                .foregroundColor(.black)
                                                            Text("1.50")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.26 - 2.26")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$67")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                                NavigationLink(destination:CheckOut(infoPlace: ["tennis1","Cancha 1", "120"], infoReservacion: ["5", "14:00", "2", "180", "90"], share: 45), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("viernes 05 | 2:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("9km · La Rioja")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Xavi")
                                                                .foregroundColor(.black)
                                                            Text("3.20")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Dennis")
                                                                .foregroundColor(.black)
                                                            Text("3.50")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 3.16 - 4.16")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$45")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                            }
                            else{
                                Text("Lo siento, no hemos encontrado ningun partido")
                                    .bold()
                                Text("con estos filtros, ¿por que no pruebas con otros?")
                                    .bold()
                            }
                        }
                        if deporte == "Basquetbol" {
                            if datesAreEqual(dateString: fecha1_basket){
                                Text("Para tu nivel")
                                    .bold()
                                    .font(.system(size: 20))
                                    .frame(alignment: .leading)
                                Text("Estos partidos reflejan exactamente tu nivel")
                                    .foregroundColor(.gray)
                                Text("fecha y clubs buscados")
                                    .foregroundColor(.gray)
                                NavigationLink(destination: CheckOut(infoPlace: ["basquet4","Cancha 4", "800"], infoReservacion: ["4", "14:00", "2", "1200", "90"], share: 300), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("jueves 04 | 7:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("7km · CODE Alcalde")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Jaime")
                                                                .foregroundColor(.black)
                                                            Text("2.00")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.76 - 2.76")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$300")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                            }else if datesAreEqual(dateString: fecha2_basket){
                                Text("Para tu nivel")
                                    .bold()
                                    .font(.system(size: 20))
                                    .frame(alignment: .leading)
                                Text("Estos partidos reflejan exactamente tu nivel")
                                    .foregroundColor(.gray)
                                Text("fecha y clubs buscados")
                                    .foregroundColor(.gray)
                                NavigationLink(destination: CheckOut(infoPlace: ["basquet2","Cancha 2", "920"], infoReservacion: ["6", "19:00", "2", "1380", "90"], share: 345), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("sabado 06 | 7:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("15km · CODE Paradero")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Martin")
                                                                .foregroundColor(.black)
                                                            Text("1.50")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Arturo")
                                                                .foregroundColor(.black)
                                                            Text("1.95")
                                                                .foregroundColor(.black)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.26 - 2.26")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$345")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                                NavigationLink(destination:CheckOut(infoPlace: ["basquet3","Cancha 3", "720"], infoReservacion: ["6", "14:00", "2", "1080", "90"], share: 270), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("sabado 06 | 2:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("7km · Club Bancario")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Xavi")
                                                                .foregroundColor(.black)
                                                            Text("3.20")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Dennis")
                                                                .foregroundColor(.black)
                                                            Text("3.50")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Diego")
                                                                .foregroundColor(.black)
                                                            Text("3.75")
                                                                .foregroundColor(.black)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 3.16 - 4.16")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$270")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                            }
                            else{
                                Text("Lo siento, no hemos encontrado ningun partido")
                                    .bold()
                                Text("con estos filtros, ¿por que no pruebas con otros?")
                                    .bold()
                            }
                        }
                        if deporte == "Fútbol" {
                            if datesAreEqual(dateString: fecha1_fut){
                                Text("Para tu nivel")
                                    .bold()
                                    .font(.system(size: 20))
                                    .frame(alignment: .leading)
                                Text("Estos partidos reflejan exactamente tu nivel")
                                    .foregroundColor(.gray)
                                Text("fecha y clubs buscados")
                                    .foregroundColor(.gray)
                                NavigationLink(destination: CheckOut(infoPlace: ["fut3","Cancha 3", "999"], infoReservacion: ["1", "19:00", "2", "1499", "90"], share: 375), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("lunes 01 | 7:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("3km · MetroGol")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Jaime")
                                                                .foregroundColor(.black)
                                                            Text("2.00")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.76 - 2.76")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$375")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                                NavigationLink(destination:CheckOut(infoPlace: ["fut1","Cancha 1", "1300"], infoReservacion: ["1", "21:00", "2", "1950", "90"], share: 488) , label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("lunes 01 | 9:00 pm")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("9km · Goal Factory Bugambilias")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Arturo")
                                                                .foregroundColor(.black)
                                                            Text("2.20")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Max")
                                                                .foregroundColor(.black)
                                                            Text("2.50")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.76 - 2.76")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$488")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                            }else if datesAreEqual(dateString: fecha2_fut){
                                Text("Para tu nivel")
                                    .bold()
                                    .font(.system(size: 20))
                                    .frame(alignment: .leading)
                                Text("Estos partidos reflejan exactamente tu nivel")
                                    .foregroundColor(.gray)
                                Text("fecha y clubs buscados")
                                    .foregroundColor(.gray)
                                NavigationLink(destination: CheckOut(infoPlace: ["fut3","Cancha 3", "999"], infoReservacion: ["7", "10:00", "2", "1499", "90"], share: 375), label: { //
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 360, height: 290)
                                            .foregroundColor(.white)
                                            .padding(1)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Text("domingo 07 | 10:00 am")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(.green)
                                                        Text("Cancha reservada")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: 15))
                                                    }
                                                    HStack{
                                                        Image("logo")
                                                            .resizable()
                                                            .frame(width:25,height: 25)
                                                        Text("3km · MetroGol")
                                                            .foregroundColor(.black)
                                                    }
                                                    HStack(spacing:25){
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Jaime")
                                                                .foregroundColor(.black)
                                                            Text("2.00")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                        Rectangle()
                                                            .fill(Color.gray)
                                                            .frame(width: 1,height: 100)
                                                        VStack{
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Juan")
                                                                .foregroundColor(.black)
                                                            Text("2.10")
                                                                .foregroundColor(.black)
                                                        }
                                                        VStack{
                                                            Image(systemName: "plus.circle")
                                                                .resizable()
                                                                .foregroundColor(.black)
                                                                .frame(width:50,height:50)
                                                            Text("Libre")
                                                                .foregroundColor(.black)
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    Divider()
                                                        .frame(width:360)
                                                        .padding(.bottom)
                                                    HStack{
                                                        Text("Competitivo")
                                                            .foregroundColor(.black)
                                                        Text("· Nivel 1.76 - 2.76")
                                                            .foregroundColor(.gray)
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .frame(width:100,height:60)
                                                            .overlay{
                                                                VStack{
                                                                    Text("$375")
                                                                        .foregroundColor(.white)
                                                                    Text("90min")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                    }
                                })
                            }
                            else{
                                Text("Lo siento, no hemos encontrado ningun partido")
                                    .bold()
                                Text("con estos filtros, ¿por que no pruebas con otros?")
                                    .bold()
                            }
                        }
                    }
                }
            }
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Spot: View {
    
    var item:[String]
    
    let counter = 12...23
    @State var icon:String = "heart"
    
    var body: some View {
        NavigationStack{
                VStack(spacing: 0) {
                    NavigationLink(destination: {SpotEspecifico(infoDeportes: item, horaSeleccionada: "12:00")}){
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
                                NavigationLink(destination: {SpotEspecifico(infoDeportes: self.item, horaSeleccionada: "\(item):00")}){
                                    Text("\(item):00")
                                        .padding()
                                        .padding(.horizontal, 10)
                                        .background(.white)
                                        .border(.gray)
                                }
                                NavigationLink(destination: {SpotEspecifico(infoDeportes: self.item, horaSeleccionada: "\(item):30")}){
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
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
   
    var multiPrecios = [1.0, 1.5, 2.0, 2.5]
    var canchas = 1...4
    var dias = ["LUN", "MAR", "MIE", "JUE", "VIE", "SAB", "DOM", "LUN", "MAR", "MIE", "JUE", "VIE", "SAB", "DOM"]
    var horas = ["12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00"]
    var nums = 0...12
    @State var selec = 0
    var infoDeportes: [String]
    @State var horaSeleccionada:String
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                ZStack{
                    Image(infoDeportes[0])
                        .resizable()
                        .frame(minWidth: 400)
                        .scaledToFit()
                        .overlay(content: {
                            VStack{
                                HStack{
                                    Button(action:{dismiss()}){
                                        Image(systemName: "arrow.backward")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20)
                                            .foregroundStyle(.black)
                                            .padding()
                                            .background(content:{
                                                Circle()
                                                    .fill(.white)
                                            })
                                        }
                                    Spacer()
                                    Button(action:{dismiss()}){
                                        Image(systemName: "square.and.arrow.up")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20)
                                            .foregroundStyle(.black)
                                            .padding()
                                            .background(content:{
                                                Circle()
                                                    .fill(.white)
                                            })
                                        }
                                }
                                .opacity(0.9)
                                .padding(.horizontal)
                                Spacer()
                            }
                            .padding(.top, 45)
                        })
                }
                .frame(width: 400, height: 180)
                .background(.red)
               Rectangle()
                    .fill(.white)
                    .overlay(content:{
                        VStack(spacing: 0){
                            HStack{
                                VStack(alignment: .leading){
                                    Text("\(infoDeportes[1])")
                                        .font(.title)
                                        .bold()
                                    Text("Dirección")
                                        
                                }
                                Spacer()
                                Image(systemName: "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                
                            }
                            .padding()
                            Text("Reservar")
                                .font(.title)
                                .bold()
                            Divider()
                                .frame(minHeight: 2)
                                .background(.black)
                                .padding(.top)
                            ScrollView(.vertical){
                                VStack(alignment:.leading, spacing: 0){
                                    Text("Fecha")
                                        .bold()
                                        .font(.title)
                                        .padding(.leading)
                                    Text("Selecciona la fecha de tu reserva")
                                        .padding(.leading)
                                        .foregroundStyle(.gray)
                                    ScrollView(.horizontal){
                                        HStack(spacing: 20){
                                            ForEach(nums, id:\.self){ cosa in
                                                Button(action:{
                                                    selec = cosa
                                                }){
                                                    VStack(spacing:0){
                                                        Text("\(dias[cosa])")
                                                            .font(.title)
                                                        Text(String(cosa + 1).count == 1 ? "0\(cosa + 1)" : "\(cosa + 1)")
                                                            .padding()
                                                            .bold()
                                                            .foregroundStyle(cosa == selec ? .white : .gray)
                                                            .background(content:{
                                                                Circle()
                                                                    .fill(cosa == selec ? .black : .clear)
                                                            })
                                                        Text("Abril")
                                                    }
                                                    .tint(cosa == selec ? .black : .gray)
                                                }
                                               
                                            }
                                        }
                                    }
                                    .padding()
                                    Text("Hora")
                                        .bold()
                                        .font(.title)
                                        .padding(.leading)
                                    Text("Selecciona la hora de tu reserva")
                                        .padding(.leading)
                                        .foregroundStyle(.gray)
                                    LazyVGrid(columns: columns, content: {
                                        ForEach(horas, id:\.self){hora in
                                            Button(action:{
                                                horaSeleccionada = hora
                                            }){
                                                Text("\(hora)")
                                                    .padding()
                                                    .bold()
                                                    .foregroundStyle(hora == horaSeleccionada ? .white : .black)
                                                    .background(hora == horaSeleccionada ? .black : .white)
                                                    .cornerRadius(7)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 7)
                                                            .stroke(.gray, lineWidth: 1)
                                                    )
                                            }
                                            .tint(.black)
                                        }
                                    })
                                    .padding(.vertical)
                                    Text("Cancha")
                                        .bold()
                                        .font(.title)
                                        .padding(.leading)
                                    Text("Selecciona tu cancha")
                                        .padding(.leading)
                                        .foregroundStyle(.gray)
                                    VStack{
                                        ForEach(canchas, id:\.self){cancha in
                                            VStack(alignment: .leading){
                                                Text("Cancha \(cancha)")
                                                    .bold()
                                                    .font(.system(size: 20))
                                                ScrollView(.horizontal){
                                                    HStack{
                                                        ForEach(multiPrecios, id:\.self){mult in
                                                            NavigationLink(destination:{
                                                                CheckOut(infoPlace: infoDeportes, infoReservacion: ["\(selec + 1)", "\(horaSeleccionada)", "\(cancha)", "\(Int(Double(infoDeportes[2])! * mult))", "\(Int(60 * mult))"], share: Int(Double(infoDeportes[2])! / 4)
                                                                         )}){
                                                                VStack{
                                                                    Text("MX$\(Int(Double(infoDeportes[2])! * mult))")
                                                                        .bold()
                                                                        .font(.system(size: 25))
                                                                    Text("\(Int(60 * mult)) min")
                                                                }
                                                                .foregroundStyle(.white)
                                                                .frame(minWidth: 100, minHeight: 50)
                                                                .padding()
                                                                .background(content:{
                                                                    RoundedRectangle(cornerRadius: 10)
                                                                        .fill(.cyan)
                                                                })
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            Divider()
                                                .padding(.vertical, 5)
                                        }
                                    }
                                    .padding()
                                }
                                .padding()
                            }
                            .background(.gray.opacity(0.15))
                        }
                    })
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        CheckOut(infoPlace: ["padel1","Puntaco", "550"], infoReservacion: ["3", "12:00", "2", "825", "90"], share: 125)
    }
}

struct CheckOut: View {
    @Environment(\.dismiss) var dismiss
    @State var pay1 = false
    @State var pay2 = true
    var dias = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"]
    var infoPlace:[String]
    var infoReservacion:[String]
    var share: Int
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Text("Checkout")
                        .bold()
                        .font(.title)
                    Spacer()
                    Button(action:{dismiss()}){
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                    .tint(.black)
                }
                .padding()
                .padding(.horizontal, 10)
                .padding(.top,50)
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .black.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
                    .overlay(content:{
                        VStack{
                            VStack(alignment:.leading){
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("\(dias[Int(infoReservacion[0])! - 1]) ") +
                                        Text(String(infoReservacion[0]).count == 1 ? "0\(infoReservacion[0])" : "\(infoReservacion[0])") +
                                        Text(" de Abril")
                                        Text("Cancha \(infoReservacion[2])")
                                            .padding(.top, 1)
                                        Text("\(infoPlace[1])")
                                    }
                                    .padding(.leading, 10)
                                    Spacer()
                                    Divider()
                                        .frame(maxWidth: 2)
                                        .background(.gray)
                                    Spacer()
                                    VStack{
                                        Image(systemName: "clock")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35)
                                        Text("\(infoReservacion[4]) min")
                                    }
                                    .padding(.trailing, 10)
                                }
                                Divider()
                                    .frame(maxHeight: 2)
                                    .background(.gray)
                                HStack{
                                    Toggle(isOn: $pay1) {
                                        HStack{
                                            ZStack(alignment: .bottomLeading){
                                                Image(systemName: "creditcard")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50)
                                                    .padding(.init(top: 0, leading: 5, bottom: 8, trailing: 0))
                                                Text("x1")
                                                    .font(.system(size:18))
                                                    .foregroundStyle(.white)
                                                    .padding(4)
                                                    .background(content:{
                                                        Circle()
                                                    })
                                            }
                                            Text("Paga tu parte")
                                                .bold()
                                            Spacer()
                                            Text("MX$\(share)")
                                                .bold()
                                        }
                                    }
                                    .toggleStyle(iOSCheckboxToggleStyle())
                                    .tint(.black)
                                }
                                .padding(.vertical)
                                .onChange(of: pay1) {
                                    if pay1 {
                                        pay2 = false
                                    }
                                }
                                HStack{
                                    Toggle(isOn: $pay2) {
                                        HStack{
                                            ZStack(alignment: .bottomLeading){
                                                Image(systemName: "creditcard")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50)
                                                    .padding(.init(top: 0, leading: 5, bottom: 8, trailing: 0))
                                                Text("x4")
                                                    .font(.system(size:16))
                                                    .foregroundStyle(.white)
                                                    .padding(4)
                                                    .background(content:{
                                                        Circle()
                                                    })
                                            }
                                            Text("Paga completo")
                                                .bold()
                                            Spacer()
                                            Text("MX$\(infoReservacion[3])")
                                                .bold()
                                        }
                                    }
                                    .toggleStyle(iOSCheckboxToggleStyle())
                                    .tint(.black)
                                    .onChange(of: pay2) {
                                        if pay2 {
                                            pay1 = false
                                        }
                                    }
                                }
                                .padding(.vertical)
                            }
                            .frame(maxWidth: 300, maxHeight: 350)
                            .padding()
                            .background(.white)
                            .cornerRadius(7)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(.gray, lineWidth: 2)
                            )
                            .padding()
                            HStack{
                                Text("Subtotal")
                                    .bold()
                                Spacer()
                                Text(pay1 ? "MX$\(share).00" : "MX$\(infoReservacion[3]).00")
                                    .foregroundStyle(.blue)
                            }
                            .font(.title)
                            .padding()
                            .padding(.top)
                        }
                    })
                
                Rectangle()
                    .fill(.white)
                    .frame(maxHeight: 100)
                    .overlay(content:{
                        NavigationLink(destination:{
                            ContentView()
                                .navigationBarBackButtonHidden(true)
                        }){
                            Text("Confirmar")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.white)
                                .padding()
                                .padding(.horizontal,80)
                                .background(content:{
                                    Capsule()
                                        .fill(.black)
                                })
                        }
                    })
                    
            }
            .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        }
    }
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
            Button(action: {
                configuration.isOn.toggle()
            }) {
                HStack() {
                Image(systemName: configuration.isOn ? "checkmark.circle" : "circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width:25)
                    configuration.label
            }
            
        }
    }
}

struct Header: View {
    var body: some View {
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
        }
    }
}

struct Comisiones: View {
    var body: some View {
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
        }
    }
}

struct Preferencias: View {
    var body: some View {
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
        }.padding(.bottom,15)
    }
}

struct RecuadrosOpc: View {
    var body: some View {
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
                NavigationLink(destination: PartidoPublico(), label:{
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
                }) //Boton Unirse
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
        }
    }
}

struct ActivarUbicacion: View {
    var body: some View {
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
        }
    }
}

struct BotonAdd: View {
    var body: some View {
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
}

struct BarraSelect: View {
    var body: some View {
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
            
        }
    }
}

#Preview {
    ContentView()
}
