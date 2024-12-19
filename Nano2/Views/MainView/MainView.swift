//
//  ContentView.swift
//  Nano2
//
//  Created by Elvis Susanto on 25/05/23.
//

import SwiftUI
import CoreData
import CoreLocation
import CoreLocationUI
import MapKit
import PhotosUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var infoClicked: Bool = false
    
    @State var landmarkSearched: Bool = false
    
    @State var data: Data?
    
    @State var selectedItem: PhotosPickerItem?
    
    @ObservedObject var locationManager = LocationManager()
    
    @State private var firstTime: Bool = true
    
    @State private var description: String = ""
    
    @State private var landmarked: Bool = false
    
    @State private var landmarks: [Landmark] = [Landmark]()
    
    @State public var landmarkClicked : Bool = false
    
    @State private var deleting: Bool = false
    
    @State private var acceptance: Bool = false
    
    @State private var currentText: String = ""
    
    @State private var currentRegion = MKCoordinateRegion (
        center: CLLocationCoordinate2D (
            latitude: -6.302230,
            longitude: 106.652264
        ),
        latitudinalMeters: 350,
        longitudinalMeters: 350
    )
    
    private func changeRegion() {
        guard let tempLocation = locationManager.location?.coordinate else { return }
        let tempRegion = MKCoordinateRegion(center: tempLocation, latitudinalMeters: 550, longitudinalMeters: 550)
        currentRegion = tempRegion
    }
    
    private func setLandmark() {
        guard let tempLocation = locationManager.location?.coordinate else { return }
        let landmarkLocation = MKPlacemark(coordinate: tempLocation)
        self.landmarks.append(Landmark(placemark: landmarkLocation))
    }
    
    private func clearLandmark() {
        landmarks = [Landmark]()
        description = ""
        data = nil
    }
    
    var body: some View {
        
        ZStack {
            
            // Background Color
            Color.black.ignoresSafeArea()
            
            VStack {
                
                // App Title & Info
                VStack {
                    
                    HStack (spacing: -5) {
                        
                        // App Title
                        Text("Where Was It?")
                            .padding()
                            .font(Font.custom("SFPro-ExpandedBold", size: 24))
                            .foregroundColor(Color.white)
                        
                        // Info
                        Button {
                            infoClicked.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color.white)
                                .font(.title2)
                        }
                        
                    }
                    
                }
                .background(Color.black)
                
                
                // Map View && Button
                ZStack {
                    
                    MapView(landmark: landmarks, landmarkSearched: $landmarkSearched, landmarkClicked: $landmarkClicked, currentRegion: $currentRegion)
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        Spacer()
                        
                        if (!landmarks.isEmpty) {
                            Button {
                                landmarkSearched.toggle()
                            } label: {
                                Text("Center whereabouts")
                                    .underline()
                                    .padding()
                                    .foregroundColor(.black)
                            }
                        }
                        
                        if (landmarked) {
                            
                            Button {
                                deleting.toggle()
                            } label: {
                                Text("Clear whereabouts")
                                    .padding()
                            }
                            .buttonStyle(FillButton())
                            
                        }
                        
                        else {
                            
                            Button {
                                landmarked.toggle()
                                setLandmark()
                            } label: {
                                Text("Set whereabouts")
                                    .padding()
                            }
                            .buttonStyle(FillButton())
                            
                        }
                        
                    }
                    
                    if deleting == true {
                        Color.black.opacity(0.75)
                            .edgesIgnoringSafeArea(.all)
                        ConfirmationModal(deleting: $deleting, acceptance: $acceptance)
                            .zIndex(1)
                            .onDisappear {
                                if acceptance == true {
                                    clearLandmark()
                                    landmarked.toggle()
                                    acceptance = false
                                }
                            }
                    }
                    
                }
                .sheet(isPresented: $landmarkClicked) {
                    
                    VStack {
                        
                        ScrollView {
                            
                            Text("Pin Details")
                                .font(.title)
                                .bold()
                                .padding()
                            
                            Spacer()
                            
                            VStack (spacing: -5) {
                                
                                if (data != nil) {
                                    Text("Click the current image to change it.")
                                        .opacity(0.2)
                                }
                                
                                PhotosPicker(selection: $selectedItem,
                                             matching: .images) {
                                    if data == nil {
                                        VStack {
                                            Image(systemName: "plus.circle.fill")
                                                .resizable()
                                                .foregroundColor(Color(#colorLiteral(red: 0.944276148, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                                .frame(width: 100, height: 100)
                                                .padding()
                                            Text("Take a photo of your set location and check it through this app.")
                                                .foregroundColor(Color(#colorLiteral(red: 0.653623879, green: 0.653623879, blue: 0.653623879, alpha: 1)))
                                                .frame(width: 250)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                    else {
                                        if let data = data, let uiimage = UIImage(data: data) {
                                            Image(uiImage: uiimage)
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(10)
                                                .frame(width: 340)
                                        }
                                    }
                                }
                                             .onChange(of: selectedItem) { newValue in
                                                 guard let item = selectedItem else {
                                                     return
                                                 }
                                                 item.loadTransferable(type: Data.self) { result in
                                                     DispatchQueue.main.async { // Switch to the main thread
                                                         switch result {
                                                         case .success(let data):
                                                             if let data = data {
                                                                 self.data = data
                                                             } else {
                                                                 print("Data is nil")
                                                             }
                                                         case .failure(let failure):
                                                             print(failure)
                                                         }
                                                     }
                                                 }
                                             }
                                             .padding()
                                
                            }
                            
                            
                            Divider()
                                .padding()
                            
                            VStack (spacing: -5) {
                                
                                HStack {
                                    Text("Description :")
                                    Spacer()
                                }
                                .padding(.leading)
                                
                                if description.isEmpty {
                                    // Input Field
                                    HStack {
                                        
                                        TextField (
                                            text: $currentText,
                                            prompt: Text("Add descriptions")
                                                .foregroundColor(Color(#colorLiteral(red: 0.653623879, green: 0.653623879, blue: 0.653623879, alpha: 1)))
                                        ) {}
                                            .foregroundColor(Color.black)
                                            .padding(.leading)
                                            .padding(.trailing)
                                            .frame(height: 38)
                                            .font(Font.custom("SFPro-Light", size: 17))
                                            .background(Color(#colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)))
                                            .cornerRadius(17)
                                        
                                        if (!currentText.isEmpty) {
                                            Button {
                                                description = currentText
                                                currentText = ""
                                            } label: {
                                                Text("Add")
                                            }
                                        }
                                        
                                    }
                                    .padding()
                                }
                                
                                else {
                                    
                                    HStack {
                                        
                                        Text(description)
                                        
                                        Spacer()
                                        
                                    }
                                    .padding()
                                    .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                    
                                }
                                
                            }
                            .padding(.leading)
                            .padding(.trailing)
                            
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                }
                
            }
            
            if infoClicked == true {
                Color.black.opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                InfoModal(infoClicked: $infoClicked)
                    .zIndex(1)
            }
            
            if firstTime == true {
                Color.black.opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                MiddlePopupView(
                    shown: $firstTime,
                    buttonText: "Get Started"
                ) {
                    
                }
                .zIndex(1)
            }
            
        }
        
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

