import UIKit

class CountryCell: UITableViewCell {
    private let nameRegionLabel = UILabel()
    private let codeLabel = UILabel()
    private let capitalLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configure labels
        nameRegionLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameRegionLabel.adjustsFontForContentSizeCategory = true
        nameRegionLabel.numberOfLines = 0
        
        codeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        codeLabel.adjustsFontForContentSizeCategory = true
        codeLabel.textAlignment = .right
        
        capitalLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        capitalLabel.adjustsFontForContentSizeCategory = true
        capitalLabel.textColor = .gray
        capitalLabel.numberOfLines = 0
        
        // Add subviews
        contentView.addSubview(nameRegionLabel)
        contentView.addSubview(codeLabel)
        contentView.addSubview(capitalLabel)
        
        // Setup constraints
        nameRegionLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameRegionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameRegionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameRegionLabel.trailingAnchor.constraint(equalTo: codeLabel.leadingAnchor, constant: -8),
            
            codeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            codeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            codeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            capitalLabel.topAnchor.constraint(equalTo: nameRegionLabel.bottomAnchor, constant: 4),
            capitalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            capitalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            capitalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with country: Country) {
        nameRegionLabel.text = "\(country.name), \(country.region)"
        codeLabel.text = country.code
        capitalLabel.text = country.capital
    }
}