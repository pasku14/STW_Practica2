require 'rack'
require 'thin'

class HolaMundo
	def call env
		return [200,{'Content-Type' => 'text/html'},["Hola Mundo!"]]
	end
end

run HolaMundo.new
