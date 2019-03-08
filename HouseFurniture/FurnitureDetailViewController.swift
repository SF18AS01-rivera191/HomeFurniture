
import UIKit;

class FurnitureDetailViewController: UIViewController,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {
    
    var furniture: Furniture?;
    
    @IBOutlet weak var choosePhotoButton: UIButton!;
    @IBOutlet weak var furnitureTitleLabel: UILabel!;
    @IBOutlet weak var furnitureDescriptionLabel: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        updateView();
    }
    
    func updateView() {
        guard let furniture: Furniture = furniture else {return;}
        if let imageData: Data = furniture.imageData,
            let image: UIImage = UIImage(data: imageData) {
            choosePhotoButton.setTitle("", for: .normal);
            choosePhotoButton.setImage(image, for: .normal);
        } else {
            choosePhotoButton.setTitle("Choose Image", for: .normal);
            choosePhotoButton.setImage(nil, for: .normal);
        }
        
        furnitureTitleLabel.text = furniture.name;
        furnitureDescriptionLabel.text = furniture.description;
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: UIButton) {
        let imagePicker: UIImagePickerController = UIImagePickerController();
        imagePicker.delegate = self;

        let alertController: UIAlertController = UIAlertController(
            title: "Choose Image Source",
            message: "Where do you want to get an image from?",
            preferredStyle: .actionSheet
        );
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //p. 682, step 1, bullet 4
            let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) {(action: UIAlertAction) in
                imagePicker.sourceType = .camera;
                self.present(imagePicker, animated: true);
            }
            alertController.addAction(cameraAction);
        }
        
        if UIImagePickerController.isSourceTypeAvailable (.photoLibrary) {
            //p. 682, step 1, bullet 4
            let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Photo Library", style: .default) {(action: UIAlertAction) in
                imagePicker.sourceType = .photoLibrary;
                self.present(imagePicker, animated: true);
            }
            alertController.addAction(photoLibraryAction);
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel);
        alertController.addAction(cancelAction);
        alertController.popoverPresentationController?.sourceView = sender;
        present(alertController, animated: true);
    }
    
    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
        var activityItems: [Any] = [Any]();
        
        guard let furniture: Furniture = furniture else {
            return;
        }
        
        if let data: Data = furniture.imageData,
            let image: UIImage = UIImage(data: data) {
            activityItems.append(image);
        }
        
        if !furniture.description.isEmpty {
            activityItems.append(description);
        }
        
        guard !activityItems.isEmpty else {
            return;
        }

        let activityController: UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil);
        
        
        present(activityController, animated: true);
    }
    
    // MARK: - UIImagePickerControllerDelegate
    // First column of dictionary should be of type UIImagePickerController.InfoKey
    // UIImagePickerControllerOriginalImage renamed UIImagePickerController.InfoKey.originalImage
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        //page 684, step 2, bullet 7
        guard let image: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("could not get original image");
        }
        
        guard let data: Data = UIImagePNGRepresentation(image) else {
            fatalError("UIImagePNGRepresentation() returned nil");
        }
        
        guard furniture != nil else {
            fatalError("furniture = nil");
        }
        furniture?.imageData = data;
        dismiss(animated: true, completion: {
            self.updateView();
        });
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true);
    }
    
}
