//
//  CameraView.swift
//  SlimUI2
//
//  Created by Emile Billeh on 08/05/2024.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @Binding var showCamera: Bool
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraView

        init(_ parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.showCamera = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.showCamera = false
        }
    }
}

enum ImageSourceType {
    case camera
    case photoLibrary
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var showPicker: Bool
    @Binding var image: UIImage?
    var sourceType: ImageSourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType == .camera ? .camera : .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.showPicker = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.showPicker = false
        }
    }
}

