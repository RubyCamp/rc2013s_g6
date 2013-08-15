# coding: UTF-8

#ゲーム本体シーンの管理用クラス
class Game2

	#ゲームシーンの初期化
	def initialize
		@image = Image.load("images/field2.png")
		@player_img = Image.load("images/player.png")
		@r_img = Image.load("images/r_mozi.png")
		@u_img = Image.load("images/u_mozi.png")
		@b_img = Image.load("images/b_mozi.png")
		@y_img = Image.load("images/y_mozi.png")
		@tama_img = Image.load("images/tama.png")
	end

	def syokika
		@player = Player.new(400, 505, @player_img)
		@player.game = self

		@mozi_r = Mozi2.new(400, 0, @r_img)
		@mozi_r.z = 0
		@mozi_r.v = 0
		@mozi_r.a = 0
		@mozi_r.hit_x = 600
		@mozi_r.hit_y = 100
		@mozi_r.not1_x = 100
		@mozi_r.not1_y = 200
		@mozi_r.not2_x = 300
		@mozi_r.not2_y = 300
		@mozi_r.not3_x = 400
		@mozi_r.not3_y = 400

		@mozi_u = Mozi2.new(700, 300, @u_img)
		@mozi_u.z = 0
		@mozi_u.v = 1
		@mozi_u.a = 0
		@mozi_u.hit_x = 100
		@mozi_u.hit_y = 200
		@mozi_u.not1_x = 300
		@mozi_u.not1_y = 300
		@mozi_u.not2_x = 400
		@mozi_u.not2_y = 400
		@mozi_u.not3_x = 600
		@mozi_u.not3_y = 100


		@mozi_b = Mozi2.new(500, 300, @b_img)
		@mozi_b.z = 0
		@mozi_b.v = 0
		@mozi_b.a = 0
		@mozi_b.hit_x = 300
		@mozi_b.hit_y = 300
		@mozi_b.not1_x = 400
		@mozi_b.not1_y = 400
		@mozi_b.not2_x = 600
		@mozi_b.not2_y = 100
		@mozi_b.not3_x = 100
		@mozi_b.not3_y = 200

		@mozi_y = Mozi2.new(0, 200, @y_img)
		@mozi_y.z = 0
		@mozi_y.v = 0
		@mozi_y.a = 0
		@mozi_y.hit_x = 400
		@mozi_y.hit_y = 400
		@mozi_y.not1_x = 600
		@mozi_y.not1_y = 100
		@mozi_y.not2_x = 100
		@mozi_y.not2_y = 200
		@mozi_y.not3_x = 300
		@mozi_y.not3_y = 300

		@mozi_r.game = self
		@mozi_u.game = self
		@mozi_b.game = self
		@mozi_y.game = self

		@tama = Tama.new(-90, -20, @tama_img)
		@player.tama = @tama

		@font = Font.new(80, "MS　明朝")
		@owari = 50
	end

	#文字移動メソッド
	attr_accessor :mozi
	def update_mozi
		a = @mozi_r.a
		b = @mozi_u.a
		c = @mozi_b.a
		d = @mozi_y.a

		#上下左右移動制御
		@mozi_r.update if a == 0
		@mozi_r.rightleft if a == 1
		@mozi_u.update if b == 0
		@mozi_u.rightleft if b == 1
		@mozi_b.update if c == 0
		@mozi_b.rightleft if c == 1
		@mozi_y.update if d == 0
		@mozi_y.rightleft if d == 1

		#文字と穴のぶつかり判定
		@mozi_r.hantei
		@mozi_u.hantei
		@mozi_b.hantei
		@mozi_y.hantei

		#文字と文字のぶつかり判定
		check_colision(@mozi_r, @mozi_u)
		check_colision(@mozi_r,@mozi_b)
		check_colision(@mozi_r,@mozi_y)
		check_colision(@mozi_u, @mozi_b)
		check_colision(@mozi_u, @mozi_y)
		check_colision(@mozi_b, @mozi_y)

		#クリア判定
		if (@mozi_r.hold == true) && (@mozi_u.hold == true) && (@mozi_b.hold == true) && (@mozi_y.hold == true)
			Director.change_scene(:clear2)
		end

		@owari -= 1
	end

	#文字と文字のぶつかり判定メソッド
    def check_colision(mozia, mozib)
    	Director.change_scene(:gameover2) if mozia.x == mozib.x and mozia.y == mozib.y
    end

	#シーンの進行
	attr_accessor
	def play
		#シーン背景の描画
		Window.draw(0, 0, @image)

		#プレイヤーの描画
		@player.draw
		@player.update
		@player.shot

		#文字の挙動管理
		@mozi_r.draw
		@mozi_u.draw
		@mozi_b.draw
		@mozi_y.draw

		#文字と玉のぶつかり判定
		if @tama.y >80
			Sprite.check(@tama,@mozi_r)
			Sprite.check(@tama,@mozi_u)
			Sprite.check(@tama,@mozi_b)
			Sprite.check(@tama,@mozi_y)
		end

		#ターン制
		Director.change_scene(:gameover2) if @owari == 0
		owari_x = 710
		owari_x = 610 if @player.x > 600
		Window.drawFont(owari_x, 510, @owari.to_s, @font)

		#ゲーム中ボタンが押されたときの挙動
		syokika if Input.keyPush?(K_Z)
		Director.change_scene(:title) if Input.keyPush?(K_X)
		Director.change_scene(:clear2) if Input.keyPush?(K_C)
	end
end