# coding: UTF-8

class Title
    #初期化
    def initialize
        @image = Image.load("images/title.png")
        @position = 1
        @line1 = Image.load("images/line1.png")
        @line2 = Image.load("images/line2.png")
        @line3 = Image.load("images/line3.png")
        @sound_bgm = Sound.new("sound/bgm.mid")
        sound
    end

    #音楽再生
    def sound
        @sound_bgm.play
    end

    def play
        #選択ボタン
        if Input.keyPush?(K_SPACE)
            if @position == 1
            	Director.change_scene(:game)
            elsif @position == 2
            	Director.change_scene(:tutorial)
            elsif @position == 3
                exit
            end
        end

        #上が押されたとき
        if Input.keyPush?(K_UP)
            if @position == 2 || @position == 3
                @position -= 1
            elsif @position == 1
                @position = 3
            end
        end

        #下が押されたとき
        if Input.keyPush?(K_DOWN)
            if @position == 1 || @position == 2
                @position += 1
            elsif @position == 3
                @position = 1
            end
        end

        y = 300 + 100 * (@position -1)

        Window.draw(0, 0, @image)

        #アンダーライン描画
        Window.draw(300, y, @line1) if @position == 1
        Window.draw(220, y, @line2) if @position == 2
        Window.draw(340, y, @line3) if @position == 3
    end
end
