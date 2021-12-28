//
//  AnimeListVC.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

protocol IAnimeListVC: UIViewController
{
	func pushDetailPage(malID: Int)
}

final class AnimeListVC: UIViewController
{
	private let rootView: IAnimeListView
	private let presenter: IAnimeListPresenter
	
	init(presenter: IAnimeListPresenter) {
		self.presenter = presenter
		self.rootView = AnimeListView()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = self.rootView
		self.presenter.loadView(controller: self, view: self.rootView)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Top-50"
	}
}

extension AnimeListVC: IAnimeListVC
{
	func pushDetailPage(malID: Int) {
		let detailPageVC = DetailPageAssembly.build(malID: malID)
		self.navigationController?.pushViewController(detailPageVC,
													  animated: true)
	}
}
