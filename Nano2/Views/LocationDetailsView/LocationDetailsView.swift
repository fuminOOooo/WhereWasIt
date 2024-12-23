//
//  LocationDetailsView.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI
import CoreLocation

struct LocationDetailsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var vm : LocationDetailsViewModel = .init()
    
    @State private var locationDescription : String
    @State private var locationName : String
    @FocusState private var saveButtonVisible : Bool
    @State private var deleting : Bool = false
    
    private var locationItem : LocationItem
    
    @ViewBuilder private func identifiers() -> some View {
            
        Text(StringConstant.savedOn + StringConstant.space + vm.getItemTimestamp(locationItem))
        
        Text(locationName)
            .font(.largeTitle)
            .bold()
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
        
    }
    
    @ViewBuilder private func description() -> some View {
        
        TextField(
            StringConstant.enterLocationDescription,
            text: $locationDescription,
            axis: .vertical
        )
        .focused($saveButtonVisible)
        .lineLimit(nil)
        .fixedSize(horizontal: false, vertical: true)
        
        if saveButtonVisible {
            Button {
                saveButtonVisible = false
                saveCurrentLocationDescription()
            } label: {
                HStack {
                    Image(systemName: ImageNameConstant.noteImage)
                    Text(StringConstant.saveChanges)
                }
                .bold()
            }
            .withFillButtonStyle()
        }
        
    }
    
    @ViewBuilder private func details() -> some View {
        
        Text(StringConstant.latitudeDescription + StringConstant.space + String(locationItem.latitude))
        
        Text(StringConstant.longitudeDescription + StringConstant.space + String(locationItem.longitude))
        
    }
    
    @ViewBuilder private func others() -> some View {
        
        Button(role: .destructive) {
            deleting = true
        } label: {
            HStack {
                Image(systemName: ImageNameConstant.trashFillImage)
                Text(StringConstant.delete + StringConstant.space + (locationItem.name ?? String()))
            }
        }
        
    }
    
    @ViewBuilder private func alert() -> some View {
        
        InputAlertView(
            cancelAction: {
                deleting = false
            },
            buttonText: StringConstant.delete,
            buttonRole: .destructive,
            buttonAction: {
                deleteItem()
                dismiss()
            }
        )
        
    }
    
    public init(
        locationItem: LocationItem
    ) {
        self.locationItem = locationItem
        locationDescription = locationItem.textDescription ?? String()
        locationName = locationItem.name ?? String()
    }
    
    var body: some View {
        
        VStack {
            
            List {
                
                Section(StringConstant.identifiers, content: identifiers)
                
                Section(StringConstant.media) {
                    
                    PicturesView(
                        item: locationItem
                    )
                    .padding(.vertical)
                    
                }
                
                Section(StringConstant.description, content: description)
                
                Section(StringConstant.details, content: details)
                
                Section(StringConstant.others, content: others)
                
            }
            .navigationTitle($locationName)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: locationDescription) {
                saveButtonVisible = true
            }
            .alert(
                StringConstant.delete +
                StringConstant.space +
                (locationItem.name ?? String()) +
                StringConstant.questionMark,
                isPresented: $deleting,
                actions: alert
            )
            
        }
        
    }
    
}

private extension LocationDetailsView {
    
    private func saveChanges() {
        
        do {
            try viewContext.save()
        } catch {
            print(StringConstant.failedSave)
        }
        
    }
    
    private func saveCurrentLocationDescription() {
        
        locationItem.textDescription = locationDescription
        
        saveChanges()
        
    }
    
    private func saveCurrentLocationName() {
        
        locationItem.name = locationName
        
        saveChanges()
        
    }
    
    private func deleteItem() {
        
        viewContext.delete(locationItem)
        
        saveChanges()
        
    }
    
}
