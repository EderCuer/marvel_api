describe 'Validar a api characters' do

	# tokens utilizados para as requests
	query = {
		"apikey" => "9a1ae86a24c96d85364aa8350385e3fc",
		"ts" => "1",
		"hash" => "b95162b6f559b8561faf91b19f514df2"
	}

	it 'deve retornar status code 200 para a request válida' do
		response = HttParty.get('/v1/public/characters', :query => query)
		expect(response.code).to eql(200)
	end

	it 'deve retornar status code 404 para a request inválida' do
		response = HttParty.get('/v1/public/character', :query => query)
		expect(response.code).to eql(404)
	end

	it 'deve retornar status code 200 para a request válida passando ID de character' do
		id = '1011334'
		response = HttParty.get('/v1/public/characters/'+id, :query => query)
		expect(response.code).to eql(200)
	end

	it 'deve retornar status code 404 para a request passando ID de character inválido' do
		id = '1'
		response = HttParty.get('/v1/public/characters/'+id, :query => query)
		expect(response.code).to eql(404)
	end

	it 'validar character com nome "3-D Man"' do
		id = '1011334'
		# O 'format: :plain' e o 'symbolize_names: true' foram utilizados para conseguirmos utilizar o retorno JSON como uma chave de hash de símbolos
		response = HttParty.get('/v1/public/characters/'+id, :query => query, format: :plain)
		body = JSON.parse(response, symbolize_names: true)
		expect(response.code).to eql(200)
		# Como mencionado acima, aqui utilizados hash de símbolos (para facilitar) e percorremos os resultados em busca do nome 3-D Man
		body[:data][:results].each do |character|
			expect(character[:name]).to eql('3-D Man')
		end
	end
end