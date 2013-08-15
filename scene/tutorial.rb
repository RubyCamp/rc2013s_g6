# coding: UTF-8

require_relative "screenshot"

class Tutorial
  def initialize
    @screen_shot_paths = [
      ["images/tutorial/00.png",K_RIGHT],
      ["images/tutorial/01.png",K_RIGHT],
      ["images/tutorial/02.png",K_RIGHT],
      ["images/tutorial/03.png",K_RIGHT],
      ["images/tutorial/04.png",K_RIGHT],
      ["images/tutorial/05.png",K_RIGHT],
      ["images/tutorial/06.png",K_RIGHT],
      ["images/tutorial/07.png",K_UP],
      ["images/tutorial/08.png",K_RIGHT],
      ["images/tutorial/09.png",K_RIGHT],
      ["images/tutorial/10.png",K_RIGHT],
      ["images/tutorial/11.png",K_RIGHT],
      ["images/tutorial/11-5.png",K_LEFT],
      ["images/tutorial/12.png",K_LEFT],
      ["images/tutorial/13.png",K_RIGHT],
      ["images/tutorial/14.png",K_RIGHT],
      ["images/tutorial/14-5.png",K_UP],
      ["images/tutorial/15.png",K_RIGHT],
      ["images/tutorial/16.png",K_RIGHT],
      ["images/tutorial/17.png",K_RIGHT],
      ["images/tutorial/18.png",K_RIGHT],
      ["images/tutorial/19.png",K_RIGHT],
      ["images/tutorial/20.png",K_RIGHT],
    ]

    @screenshots = []

  end

  def syokika
    @screen_shot_paths.each do |screen_shot_path,next_key|
      @screenshots << ScreenShot.new(screen_shot_path,next_key)
    end
    @carent_screen_shot = @screenshots[0]
  end

  def play
    Window.draw(0,0,@carent_screen_shot.image)
    if Input.keyPush?(@carent_screen_shot.next_key)
      index = @screenshots.index(@carent_screen_shot)
      Director.change_scene(:title) if index == 22
      @carent_screen_shot = @screenshots[index + 1]
    end
    Director.change_scene(:title) if Input.keyPush?(K_SPACE)
  end
end