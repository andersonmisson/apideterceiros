# encoding: utf-8

require 'net/http'
require 'json'

url = URI("https://x-games-api.herokuapp.com/api/v1/games")

options = [ "somar", "subtrair", "listar jogos" ]

options.unshift "sair" # inicio do array (unshift), opção sair

continue = true

def somar
	puts "Entre com o Primeiro Número"
	x = gets.chomp.to_i
	puts "Entre com o Segundo Número"
	y = gets.chomp.to_i
	puts
	puts "#{ x } + #{ y } = #{ x + y }"
	sleep 3
end

def subtrair
	puts "Entre com o Primeiro Número"
	x = gets.chomp.to_i
	puts "Entre com o Segundo Número"
	y = gets.chomp.to_i
	puts
	puts "#{ x } - #{ y } = #{ x - y }"
	sleep 3
end

def listarJogos(url)
	puts "listando..."
	response = Net::HTTP.get(url)
	
	json_response = JSON.parse( response, symbolize_names: true ) # symbolize_names vira uma HASH
	
	data = json_response[ :data ] # Desempacotando
	
	games = data[ :games ] # Desempacotando
	
	games.each.with_index do |game,index| # para cada laço, eu verei um jogo
		puts "#{index + 1} - #{game[:name]}, #{game[:genre]}"
	end
	
	sleep 3
end

while continue
	system('cls')
	
	puts "Escolha um número: "
	
	options.each.with_index do |option, index|
		puts "#{index} - #{option}" # cada indice do contador
	end
	
	option = gets.chomp.to_i # chomps retira o \n, to_i transforma string em integer
	
	somar if option == options.index("somar")
	
	subtrair if option == options.index("subtrair")
	
	listarJogos(url) if option == options.index("listar jogos")
	
	continue = false if option.zero? # Se for zero
	
end

