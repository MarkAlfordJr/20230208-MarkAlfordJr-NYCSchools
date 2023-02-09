//
//  SATScoreViewController.swift
//  20230208-MarkAlfordJr-NYCSchools
//
//  Created by Mark Alford on 2/8/23.
//

import UIKit

class SATScoreViewController: UIViewController {

    // array for JSON request, used for giving the UI components values
    var apiResultObjectArray: SATScoreResponseModelArray = []
    var schoolname: String = ""
    
    //MARK: - UI Components
    var schoolNameText: UILabel = {
        let text = UILabel()
        text.text = "School Name High"
        text.textAlignment = .center
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.numberOfLines = 0
        return text
    }()
    
    var mathScoreText: UILabel = {
        let text = UILabel()
        text.text = "111"
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.medium)
        text.numberOfLines = 0
        return text
    }()
    var writingScoreText: UILabel = {
        let text = UILabel()
        text.text = "222"
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.medium)
        text.numberOfLines = 0
        return text
    }()
    var readingScoreText: UILabel = {
        let text = UILabel()
        text.text = "333"
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.medium)
        text.numberOfLines = 0
        return text
    }()
    
    //MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(schoolNameText)
        view.addSubview(schoolNameText)
        view.addSubview(mathScoreText)
        view.addSubview(writingScoreText)
        view.addSubview(readingScoreText)
        
        subViewContraints()
    }
    
    //MARK: - Navigation Prep and API Call
    // whichever VC calls this init, can initalize this SAT Score VC with values
    /*
     dbnName - the JSON value of the schools API. determines the API call for scores
     school - used for filling the schoolName UI value, regardless if the JSON is nil or not
     */
    init(dbnName: String, school: String) {
        super.init(nibName: nil, bundle: nil)
        
        schoolname = school
        // api call
        let scoreEndpoint = SATScoresAPI.getSatScore(dbn: dbnName)
        NetworkManager.request(endpoint: scoreEndpoint) { [weak self] (result: Result<SATScoreResponseModelArray, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    // load up UI properties with data
                    self?.apiResultObjectArray = response
                    self?.configureUI(school: school, math: self?.apiResultObjectArray.first?.satMathAvgScore ?? "no Score", writing: self?.apiResultObjectArray.first?.satWritingAvgScore ?? "no Score", reading: self?.apiResultObjectArray.first?.satCriticalReadingAvgScore ?? "no Score")
                }
            case .failure(let error):
                print("sat score failed \(error)")
                print("no scores, b/c error")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     My initial attempt was to make a control to determine when the JSON comes back as nil, but
     as the deadline increased, i was left with a static design
     */
    func subViewContraints() {
        schoolNameText.translatesAutoresizingMaskIntoConstraints = false
        mathScoreText.translatesAutoresizingMaskIntoConstraints = false
        writingScoreText.translatesAutoresizingMaskIntoConstraints = false
        readingScoreText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            schoolNameText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            schoolNameText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32),
            schoolNameText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 24),
            
            mathScoreText.topAnchor.constraint(equalTo: schoolNameText.bottomAnchor, constant: 16),
            mathScoreText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            writingScoreText.topAnchor.constraint(equalTo: mathScoreText.bottomAnchor, constant: 8),
            writingScoreText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            readingScoreText.topAnchor.constraint(equalTo: writingScoreText.bottomAnchor, constant: 8),
            readingScoreText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // Allows the ViewController to load the UI with values
    func configureUI(school: String, math: String, writing: String, reading: String) {
        schoolNameText.text = school
        mathScoreText.text = math
        writingScoreText.text = writing
        readingScoreText.text = reading
    }
}
