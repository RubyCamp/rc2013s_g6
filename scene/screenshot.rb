class ScreenShot
	attr_reader :image, :next_key

	def initialize(image_path,next_key)
		@image = Image.load(image_path)
		@next_key = next_key
	end
end