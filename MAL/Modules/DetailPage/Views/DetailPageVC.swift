//
//  DetailPageVC.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import UIKit

protocol IDetailPageVC: UIViewController {

}

final class DetailPageVC: UIViewController {
	private var rootView: IDetailPageView
	private var presenter: IDetailPagePresenter

	struct Dependecies {
		let presenter: IDetailPagePresenter
	}
	
	init(dependecies: Dependecies) {
		self.rootView = DetailPageView(frame: UIScreen.main.bounds)
		self.presenter = dependecies.presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		self.view = self.rootView
		self.presenter.loadView(controller: self, view: self.rootView)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.rootView.didLoad()
	}
}

extension DetailPageVC: IDetailPageVC {
	
}
