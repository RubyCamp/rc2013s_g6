# coding: UTF-8

require_relative 'scene/title'
require_relative 'scene/game'
require_relative 'scene/game2'
require_relative 'scene/tutorial'
require_relative 'scene/clear'
require_relative 'scene/clear2'
require_relative 'scene/gameover'
require_relative 'scene/gameover2'
require_relative 'scene/screenshot'

require_relative 'lib/player'
require_relative 'lib/mozi'
require_relative 'lib/mozi2'
require_relative 'lib/bomb'
require_relative 'lib/tama'

#ゲーム進行
class Director
	#初期化処理
	def initialize
		#ゲームを構成する各シーンの管理オブジェクトを生成
		@@scenes = {}
		@@scenes[:title] = Title.new
		@@scenes[:game] = Game.new
		@@scenes[:game2] = Game2.new
		@@scenes[:tutorial] = Tutorial.new
		@@scenes[:clear] = Clear.new
		@@scenes[:clear2] = Clear2.new
		@@scenes[:gameover] = Gameover.new
		@@scenes[:gameover2] = Gameover2.new
		@@current_scene = :title
	end

	#ゲーム進行メソッド
	def play
		#現在設定されているシーン管理オブジェクトのplayメソッドへ
		#処理を移譲する
		@@scenes[@@current_scene].play
	end

	#シーン切り替え用メソッド
	def self.change_scene(scene)
		@@current_scene = scene
		@@scenes[:tutorial].syokika if scene == :tutorial
		@@scenes[:game].syokika if scene == :game
		@@scenes[:game2].syokika if scene == :game2
	end
end