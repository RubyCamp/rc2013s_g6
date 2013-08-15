# coding: UTF-8

#ゲーム本体シーンの管理用クラス
class Game

	#読込
	def initialize
		@image = Image.load("images/field.png")
		@player_img = Image.load("images/player.png")
		@ma_img = Image.load("images/ma_mozi.png")
		@tsu_img = Image.load("images/tsu_mozi.png")
		@e_img = Image.load("images/e_mozi.png")
		@tama_img = Image.load("images/tama.png")
		
	end

	#初期化
	def syokika
		@player = Player.new(400, 505, @player_img)
		@player.game = self

		@mozi_ma = Mozi.new(200, 300, @ma_img)
		@mozi_ma.z = 0
		@mozi_ma.v = 0
		@mozi_ma.a = 0
		@mozi_ma.hit_x = 700
		@mozi_ma.hit_y = 0
		@mozi_ma.not1_x = 0
		@mozi_ma.not1_y = 200
		@mozi_ma.not2_x = 500
		@mozi_ma.not2_y = 400

		@mozi_tsu = Mozi.new(300, 100, @tsu_img)
		@mozi_tsu.z = 0
		@mozi_tsu.v = 0
		@mozi_tsu.a = 0
		@mozi_tsu.hit_x = 0
		@mozi_tsu.hit_y = 200
		@mozi_tsu.not1_x = 500
		@mozi_tsu.not1_y = 400
		@mozi_tsu.not2_x = 700
		@mozi_tsu.not2_y = 0

		@mozi_e = Mozi.new(600, 0, @e_img)
		@mozi_e.z = 0
		@mozi_e.v = 0
		@mozi_e.a = 0
		@mozi_e.hit_x = 500
		@mozi_e.hit_y = 400
		@mozi_e.not1_x = 700
		@mozi_e.not1_y = 0
		@mozi_e.not2_x = 0
		@mozi_e.not2_y =200

		@mozi_ma.game = self
		@mozi_tsu.game = self
		@mozi_e.game = self

		@tama = Tama.new(-90, -20, @tama_img)
		@player.tama = @tama

		@font = Font.new(80, "MS　明朝")

		#ターン数設定
		@owari = 30
	end

	#文字移動メソッド
	attr_accessor :mozi
	def update_mozi
		#上下左右移動制御
		@mozi_ma.update if @mozi_ma.a == 0
		@mozi_ma.rightleft if @mozi_ma.a == 1
		@mozi_tsu.update if @mozi_tsu.a == 0
		@mozi_tsu.rightleft if @mozi_tsu.a == 1
		@mozi_e.update if @mozi_e.a == 0
		@mozi_e.rightleft if @mozi_e.a == 1

		#文字と穴のぶつかり判定
		@mozi_ma.hantei
		@mozi_tsu.hantei
		@mozi_e.hantei

		#文字と文字のぶつかり判定
		check_colision(@mozi_ma, @mozi_tsu)
		check_colision(@mozi_tsu, @mozi_e)
		check_colision(@mozi_e, @mozi_ma)

		#クリア判定
		if (@mozi_ma.hold == true) && (@mozi_tsu.hold == true) && (@mozi_e.hold == true)
			Director.change_scene(:clear)
		end

		@owari -= 1
	end

	#文字と文字のぶつかり判定メソッド
    def check_colision(mozia, mozib)
    	Director.change_scene(:gameover) if mozia.x == mozib.x and mozia.y == mozib.y
    end

	#シーンの進行
	attr_accessor :tama
	def play
		#シーン背景の描画
		Window.draw(0, 0, @image)

		#プレイヤーの描画
		@player.draw
		@player.update
		@player.shot

		#文字の挙動管理
		@mozi_ma.draw
		@mozi_tsu.draw
		@mozi_e.draw

		#文字と玉のぶつかり判定
		if @tama.y >90
			Sprite.check(@tama,@mozi_ma)
			Sprite.check(@tama,@mozi_tsu)
			Sprite.check(@tama,@mozi_e)
		end

		#ターン制
		Director.change_scene(:gameover) if @owari == 0
		owari_x = 710
		owari_x = 610 if @player.x > 600
		Window.drawFont(owari_x, 510, @owari.to_s, @font)

		#ゲーム中ボタンが押されたときの挙動
		syokika if Input.keyPush?(K_Z)
		Director.change_scene(:title) if Input.keyPush?(K_X)
		Director.change_scene(:clear) if Input.keyPush?(K_C)
	end

end