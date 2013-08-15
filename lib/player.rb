 #coding : UTF-8

class Player < Sprite
	attr_accessor :game, :tama
	def update
		if (Input.keyPush?(K_RIGHT) and self.x < 700) or (Input.keyPush?(K_LEFT) and self.x > 0)  and tama.y < 0 
			self.x += (Input.x)*100
			@game.update_mozi
	    end

 	    self.x = 0 if self.x < 0
        self.x = 710 if self.x > 710
	end

	def shot
		if Input.keyPush?(K_UP) == true and @tama.y < 0
			@tama.x = self.x
			@tama.y = self.y
			@hit = 1

		end
		if @tama.y >= 0
			@tama.y = @tama.y - 10
			@tama.draw
		end
		if @tama.bomb
			@tama.bomb.draw
			@tama.bomb.ex += 1
			@tama.bomb = nil if @tama.bomb.ex == 15
		end
		if @hit == 1 and @tama.y == -5
			@hit = 0
			@game.update_mozi
		end
	end
end