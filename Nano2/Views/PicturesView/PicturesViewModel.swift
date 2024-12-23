//
//  PicturesViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import CoreData
import PhotosUI
import SwiftUI

@MainActor final class PicturesViewModel : ObservableObject {
    
    @MainActor final class ImageAttachment: ObservableObject, Identifiable {
        
        enum Status {
            case loading
            case finished(Image)
            case failed(Error)
            var isFailed: Bool {
                return switch self {
                case .failed: true
                default: false
                }
            }
        }
        
        enum LoadingError: Error {
            case contentTypeNotSupported
        }
        
        private let pickerItem: PhotosPickerItem
        
        @Published var imageStatus: Status?
        
        nonisolated var id: String {
            pickerItem.identifier
        }
        
        init(_ pickerItem: PhotosPickerItem) {
            self.pickerItem = pickerItem
        }
        
        func loadImage() async {
            guard imageStatus == nil || imageStatus?.isFailed == true else { return }
            imageStatus = .loading
            do {
                if let data = try await pickerItem.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    imageStatus = .finished(
                        Image(uiImage: uiImage)
                    )
                } else {
                    throw LoadingError.contentTypeNotSupported
                }
            } catch {
                imageStatus = .failed(error)
            }
        }
        
    }
    
    @Published var selection = [PhotosPickerItem]() {
        didSet {
            let newAttachments = selection.map { item in
                attachmentByIdentifier[item.identifier] ?? ImageAttachment(item)
            }
            let newAttachmentByIdentifier = newAttachments.reduce(into: [:]) { partialResult, attachment in
                partialResult[attachment.id] = attachment
            }
            attachments = newAttachments
            attachmentByIdentifier = newAttachmentByIdentifier
        }
    }
    
    @Published var attachments = [ImageAttachment]()
    
    private var attachmentByIdentifier = [String: ImageAttachment]()
    
}

private extension PhotosPickerItem {

    var identifier: String {
        guard let identifier = itemIdentifier else {
            fatalError(StringConstant.noLibrary)
        }
        return identifier
    }
    
}
