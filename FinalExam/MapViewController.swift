import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var gmsMapView: UIView!
    var lat = -33.868
    var long = 151.2086
    
    override func loadView() {
        print("load View")
        
        navigationItem.title = "Hello Map"
        
        let camera = GMSCameraPosition.camera(withLatitude: lat,
                                              longitude: long,
                                              zoom: 14)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        let marker = GMSMarker()
        marker.position = camera.target
        marker.snippet = "Hello World"
        marker.appearAnimation = .pop
        marker.map = mapView
        
        self.gmsMapView = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setLocation(lat: Double, long: Double) {
        print("show location \(lat) \(long)")
        self.long = long
        self.lat = lat
    }
}
