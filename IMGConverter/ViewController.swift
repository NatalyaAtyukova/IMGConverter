//
//  ViewController.swift
//  IMGConverter
//
//  Created by Наталья Атюкова on 23.07.2023.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {



    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage: UIImage?

    override func viewDidLoad() {
        
        // Гардиент фона
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.96, green: 0.79, blue: 0.87, alpha: 1.0).cgColor, UIColor(red: 0.56, green: 0.93, blue: 0.82, alpha: 1.0).cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        //
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        selectedImage = image //сохраняем выбранное изображение
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    
    @IBAction func saveImageButtonTapped(_ sender: UIButton) {
            guard let imageToSave = imageView.image else {
                   return
               }

               if let jpegData = imageToSave.jpegData(compressionQuality: 0.8) {
                   UIImageWriteToSavedPhotosAlbum(UIImage(data: jpegData)!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
               } else {
                   // Обработка ошибки при преобразовании изображения
               }
           }

           @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
               if let error = error {
                   // Обработка ошибки сохранения
                   print("Ошибка первичного сохранения изображения: \(error.localizedDescription)")
               } else {
                   // Оповещение пользователя об успешном сохранении
                   let alertController = UIAlertController(title: "Изображение успешно сохранено", message: nil, preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alertController.addAction(okAction)
                   present(alertController, animated: true, completion: nil)
               }
            }
        }
