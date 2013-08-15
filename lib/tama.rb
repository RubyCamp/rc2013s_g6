class Tama <Sprite
	attr_accessor :bomb
	@@bomb_img = Image.load("Images/bomb.png")

	def shot(mozi)
		#ここに衝突した場合の挙動
		#自分自身を消す
		if mozi.hold == false
			b = Bomb.new(self.x-50, self.y-100, @@bomb_img)
			@bomb = b
			@bomb.ex = 0
			self.x = 800
			self.y = -1
		end
  	end
end