# coding: UTF-8

class Mozi < Sprite
	def initialize (x, y, image)
		@hold = false
		super
	end

	attr_accessor :z, :v, :a, :game, :hit_x, :hit_y, :not1_x, :not1_y, :not2_x, :not2_y, :hold
	def update
		return if @hold

		case @z
		when 0
			self.y += 100 if self.y != 400
			@z = 1 if self.y ==400
		when 1
			self.y -= 100 if self.y != 0
			@z = 0 if self.y == 0
		end
	end

	def rightleft
		return if @hold

		case @v
		when 0
			self.x += 100 if self.x != 700
			@v = 1 if self.x == 700
		when 1
			self.x -= 100 if self.x != 0
			@v = 0 if self.x == 0
		end
	end

	def hit(tama)
		#衝突した場合の挙動
		#a=0は縦方向　a=1は横方向を表す
		case @a
		when 0
			@a = 1
		when 1
			@a = 0
		end
		if @hold == false
			@game.update_mozi
		end
	end

	def hantei
		@hold = true if self.x == @hit_x && self.y == @hit_y
		Director.change_scene(:gameover) if (self.x == @not1_x && self.y == @not1_y) || (self.x == @not2_x && self.y == @not2_y)
	end
end