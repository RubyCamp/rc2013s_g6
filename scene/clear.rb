class Clear
    def initialize
        @image = Image.load("images/clear.png") #松江城の画像
        @position = 1
        @line1 = Image.load("images/line1.png")
        @line2 = Image.load("images/line3.png")
    end

    def play
        if Input.keyPush?(K_SPACE)
            if @position == 1
                Director.change_scene(:game2) 
            elsif @position == 2
                Director.change_scene(:game)
            elsif @position == 3
            	exit
            end
	    end

        if Input.keyPush?(K_UP)
            if @position == 2 || @position == 3
                @position -= 1
            elsif @position == 1
                @position = 3
            end
        end

        if Input.keyPush?(K_DOWN)
            if @position == 1 || @position == 2
                @position += 1
            elsif @position == 3
                @position = 1
            end
        end

        y = 300 + 100 * (@position -1)

        Window.draw(0, 0, @image)
        Window.draw(300, y, @line1) if @position == 1
        Window.draw(300, y, @line1) if @position == 2
        Window.draw(340, y, @line2) if @position == 3
    end
end