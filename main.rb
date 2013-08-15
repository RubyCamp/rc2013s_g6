require 'dxruby'
require_relative 'director'

Window.width = 800
Window.height = 600

#ゲーム進行管理用オブジェクトの生成
director = Director.new

#メインループ開始
Window.loop do
	break if Input.keyPush?(K_ESCAPE)

	#ゲーム進行
	director.play
end