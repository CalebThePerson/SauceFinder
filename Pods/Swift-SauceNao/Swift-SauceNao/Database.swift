//
//  Database.swift
//  Swift-SauceNao
//
//  Created by Jaquet Vincent on 14.02.19.
//  Copyright © 2019 Vinrobot. All rights reserved.
//

import Foundation

public struct Database: OptionSet {

	/* ##### https://saucenao.com/status.html #####
	nodes = document.querySelectorAll("body>p>span:first-child")
	indexes = []
	nodes.forEach(function(n){t=n.innerText.trim().split(":", 2);;t[1]=t[1].trim();indexes.push([t[0].split("#",2)[1], t[1], t[1].toUpperCase().replace(/ |\.|\-/g, "_").replace(/\)|\(/g, "")])})

	Output:
		indexes.map(function(t){return 'public static let '+t[2]+' = Database(id: '+t[0]+', name: "'+t[1]+'", bitmask: 1 << '+t[0]+')'}).join("\n")
		indexes.map(function(t){return 'tmp['+t[2]+'.id] = '+t[2]}).join("\n")
	*/

	public static let H_MAGAZINES = Database(id: 0, name: "H-Magazines", bitmask: 1 << 0)
	public static let H_GAME_CG = Database(id: 2, name: "H-Game CG", bitmask: 1 << 2)
	public static let DOUJINSHIDB = Database(id: 3, name: "DoujinshiDB", bitmask: 1 << 3)
	public static let PIXIV_IMAGES = Database(id: 5, name: "pixiv Images", bitmask: 1 << 5)
	public static let NICO_NICO_SEIGA = Database(id: 8, name: "Nico Nico Seiga", bitmask: 1 << 8)
	public static let DANBOORU = Database(id: 9, name: "Danbooru", bitmask: 1 << 9)
	public static let DRAWR_IMAGES = Database(id: 10, name: "drawr Images", bitmask: 1 << 10)
	public static let NIJIE_IMAGES = Database(id: 11, name: "Nijie Images", bitmask: 1 << 11)
	public static let YANDE_RE = Database(id: 12, name: "Yande.re", bitmask: 1 << 12)
	public static let OPENINGS_MOE = Database(id: 13, name: "Openings.moe", bitmask: 1 << 13) // Not in db list
	public static let SHUTTERSTOCK = Database(id: 15, name: "Shutterstock", bitmask: 1 << 15)
	public static let FAKKU = Database(id: 16, name: "FAKKU", bitmask: 1 << 16)
	public static let H_MISC = Database(id: 18, name: "H-Misc", bitmask: 1 << 18)
	public static let _2D_MARKET = Database(id: 19, name: "2D-Market", bitmask: 1 << 19)
	public static let MEDIBANG = Database(id: 20, name: "MediBang", bitmask: 1 << 20)
	public static let ANIME = Database(id: 21, name: "Anime", bitmask: 1 << 21)
	public static let H_ANIME = Database(id: 22, name: "H-Anime", bitmask: 1 << 22)
	public static let MOVIES = Database(id: 23, name: "Movies", bitmask: 1 << 23)
	public static let SHOWS = Database(id: 24, name: "Shows", bitmask: 1 << 24)
	public static let GELBOORU = Database(id: 25, name: "Gelbooru", bitmask: 1 << 25)
	public static let KONACHAN = Database(id: 26, name: "Konachan", bitmask: 1 << 26)
	public static let SANKAKU_CHANNEL = Database(id: 27, name: "Sankaku Channel", bitmask: 1 << 27)
	public static let ANIME_PICTURES_NET = Database(id: 28, name: "Anime-Pictures.net", bitmask: 1 << 28)
	public static let E621_NET = Database(id: 29, name: "e621.net", bitmask: 1 << 29)
	public static let IDOL_COMPLEX = Database(id: 30, name: "Idol Complex", bitmask: 1 << 30)
	public static let BCY_NET_ILLUST = Database(id: 31, name: "bcy.net Illust", bitmask: 1 << 31)
	public static let BCY_NET_COSPLAY = Database(id: 32, name: "bcy.net Cosplay", bitmask: 1 << 32)
	public static let PORTALGRAPHICS_NET = Database(id: 33, name: "PortalGraphics.net", bitmask: 1 << 33)
	public static let DEVIANTART = Database(id: 34, name: "deviantArt", bitmask: 1 << 34)
	public static let PAWOO_NET = Database(id: 35, name: "Pawoo.net", bitmask: 1 << 35)
	public static let MADOKAMI_MANGA = Database(id: 36, name: "Madokami (Manga)", bitmask: 1 << 36)
	public static let MANGADEX = Database(id: 37, name: "MangaDex", bitmask: 1 << 37)

	public static let ALL = Database(id: 999, name: "ALL", bitmask: 0)

	public static let DB_IDS: [UInt: Database] = {
		var tmp = [UInt: Database]()

		tmp[H_MAGAZINES.id] = H_MAGAZINES
		tmp[H_GAME_CG.id] = H_GAME_CG
		tmp[DOUJINSHIDB.id] = DOUJINSHIDB
		tmp[PIXIV_IMAGES.id] = PIXIV_IMAGES
		tmp[NICO_NICO_SEIGA.id] = NICO_NICO_SEIGA
		tmp[DANBOORU.id] = DANBOORU
		tmp[DRAWR_IMAGES.id] = DRAWR_IMAGES
		tmp[NIJIE_IMAGES.id] = NIJIE_IMAGES
		tmp[YANDE_RE.id] = YANDE_RE
		tmp[OPENINGS_MOE.id] = OPENINGS_MOE
		tmp[SHUTTERSTOCK.id] = SHUTTERSTOCK
		tmp[FAKKU.id] = FAKKU
		tmp[H_MISC.id] = H_MISC
		tmp[_2D_MARKET.id] = _2D_MARKET
		tmp[MEDIBANG.id] = MEDIBANG
		tmp[ANIME.id] = ANIME
		tmp[H_ANIME.id] = H_ANIME
		tmp[MOVIES.id] = MOVIES
		tmp[SHOWS.id] = SHOWS
		tmp[GELBOORU.id] = GELBOORU
		tmp[KONACHAN.id] = KONACHAN
		tmp[SANKAKU_CHANNEL.id] = SANKAKU_CHANNEL
		tmp[ANIME_PICTURES_NET.id] = ANIME_PICTURES_NET
		tmp[E621_NET.id] = E621_NET
		tmp[IDOL_COMPLEX.id] = IDOL_COMPLEX
		tmp[BCY_NET_ILLUST.id] = BCY_NET_ILLUST
		tmp[BCY_NET_COSPLAY.id] = BCY_NET_COSPLAY
		tmp[PORTALGRAPHICS_NET.id] = PORTALGRAPHICS_NET
		tmp[DEVIANTART.id] = DEVIANTART
		tmp[PAWOO_NET.id] = PAWOO_NET
		tmp[MADOKAMI_MANGA.id] = MADOKAMI_MANGA
		tmp[MANGADEX.id] = MANGADEX
		tmp[ALL.id] = ALL

		return tmp
	}()

	public let rawValue: UInt
	public let id: UInt
	public let name: String
	public let bitmask: UInt

	public init(rawValue: UInt) {
		let id = UInt(flsl(Int(rawValue)))
		self.init(id: id, name: "Database#\(id)", bitmask: rawValue)
	}

	public init(id: UInt, name: String, bitmask: UInt) {
		self.id = id
		self.name = name
		self.bitmask = bitmask
		self.rawValue = bitmask
	}
}
