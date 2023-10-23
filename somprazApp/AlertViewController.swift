import UIKit

class CustomTimeoutAlertViewController: UIViewController {
    
    var score: Int = 0 // You can set the score value when creating the alert
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
                view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

                // Create a content view for the alert
                let contentView = UIView()
                contentView.backgroundColor = .white
                contentView.layer.cornerRadius = 16
                contentView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(contentView)

                // Set leading and trailing constraints to 0
                contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
                contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true

                // Set a fixed height of 200
                contentView.heightAnchor.constraint(equalToConstant: 200).isActive = true

                // Center the contentView vertically
                contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true


        // Create and configure the image view
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timeout")
        imageView.translatesAutoresizingMaskIntoConstraints = false

//        // Create and configure the label for "You ran out of time!"
//        let label = UILabel()
//        label.text = "You ran out of time!"
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false

        // Create and configure the label to display the score
        let scoreLabel = UILabel()
        scoreLabel.text = "Your Score: \(score)"
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false

        // Create and configure the "Next" button
        let nextButton = UIButton()
        nextButton.setTitle("Go To Leaderboard", for: .normal)
        nextButton.backgroundColor = .blue
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews to the view controller's view
        view.addSubview(imageView)
//        view.addSubview(label)
        view.addSubview(scoreLabel)
        view.addSubview(nextButton)

        // Layout constraints for image view
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])

//        // Layout constraints for "You ran out of time!" label
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])

        // Layout constraints for score label
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // Layout constraints for "Next" button
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    @objc func nextButtonTapped() {
        // Handle the "Next" button action here (e.g., navigating to the next controller)
        // Dismiss the custom alert view controller
        dismiss(animated: true, completion: nil)
    }
}
