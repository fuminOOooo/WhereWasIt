//
//  PicturesViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import CoreData
import PhotosUI
import SwiftUI

public final class PicturesViewModel : ObservableObject {
    
    public init() {
        
    }
    
    @Published var imagesDatas : [Data] = .init()
    
    func loadTransferable(from imagePicked: PhotosPickerItem, item: LocationItem, context: NSManagedObjectContext) {
        imagePicked.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data?):
                    self.imagesDatas.append(data)
                    self.saveImageDataForItem(
                        context: context,
                        imageData: data,
                        item: item
                    )
                case .success(.none):
                    print(StringConstant.failedLoadingData)
                case .failure(_):
                    print(StringConstant.failedLoadingData)
                }
            }
        }
    }
    
    func getMediaData(_ item: LocationItem) {
        
        guard let media = item.media as? NSArray else { return }
        
        var mediaInData : [Data] = []
        
        for oneMedia in media {
            
            guard let oneMedia = oneMedia as? String else { continue }
            
            mediaInData.append(oneMedia.data(using: .utf8) ?? Data())
            
        }
        
        imagesDatas = mediaInData
        
    }
    
    func saveImageDataForItem(context: NSManagedObjectContext, imageData: Data, item: LocationItem) {
        
        guard let media = item.media as? NSArray else { return }
        
        let stringData = String(data: imageData, encoding: .utf8)
        
        media.adding(stringData ?? CoreDataKeyConstant.corruptedMedia)
        
        do {
            
            try context.save()
            
        } catch {
            
            print(StringConstant.persistentStoreLoadingFailure)
            
        }
        
    }
    
}
