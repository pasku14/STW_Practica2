require 'rack'
require 'pry-debugger'

class HolaMundo
	def call env
		binding.pry
		return [200,{'Content-Type' => 'text/plain'},["Hola Mundo!"]]
	end
end
