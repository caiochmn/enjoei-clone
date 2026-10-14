# Dados de exemplo. Pode rodar quantas vezes quiser: `bin/rails db:seed`.

# Departamentos > categorias > subcategorias
CATALOG = {
  "Feminino" => {
    "Roupas" => [ "Vestidos", "Blusas", "Calças", "Saias", "Casacos" ],
    "Calçados" => [ "Tênis", "Sandálias", "Botas", "Sapatilhas" ],
    "Bolsas" => [ "Bolsas de mão", "Mochilas", "Carteiras" ],
    "Acessórios" => [ "Bijuterias", "Óculos", "Cintos" ]
  },
  "Masculino" => {
    "Roupas" => [ "Camisetas", "Camisas", "Calças", "Bermudas", "Jaquetas" ],
    "Calçados" => [ "Tênis", "Sapatos", "Chinelos" ],
    "Acessórios" => [ "Relógios", "Bonés", "Mochilas" ]
  },
  "Infantil" => {
    "Roupas" => [ "Bebê", "Menina", "Menino" ],
    "Brinquedos" => [ "Educativos", "Bonecos", "Jogos" ],
    "Passeio" => [ "Carrinhos", "Cadeirinhas" ]
  },
  "Casa & Decor" => {
    "Móveis" => [ "Cadeiras", "Mesas", "Estantes" ],
    "Decoração" => [ "Quadros", "Vasos", "Luminárias" ],
    "Cozinha" => [ "Louças", "Utensílios" ]
  },
  "Eletrônicos" => {
    "Celulares" => [ "Smartphones", "Capas e películas" ],
    "Informática" => [ "Notebooks", "Periféricos" ],
    "Áudio" => [ "Fones de ouvido", "Caixas de som" ],
    "Games" => [ "Consoles", "Jogos" ]
  },
  "Eletrodomésticos" => {
    "Cozinha" => [ "Liquidificadores", "Cafeteiras", "Air fryers" ],
    "Casa" => [ "Aspiradores", "Ventiladores" ]
  },
  "Antiguidades" => {
    "Objetos" => [ "Relógios antigos", "Câmeras antigas" ],
    "Discos e livros" => [ "Discos de vinil", "Livros raros" ]
  },
  "Pets" => {
    "Cachorros" => [ "Camas", "Coleiras", "Roupinhas" ],
    "Gatos" => [ "Arranhadores", "Caixas de transporte" ]
  }
}.freeze

CATALOG.each_with_index do |(department_name, categories), department_position|
  department = Category.find_or_create_by!(name: department_name, parent: nil) do |c|
    c.position = department_position
  end

  categories.each_with_index do |(category_name, subcategories), category_position|
    category = Category.find_or_create_by!(name: category_name, parent: department) do |c|
      c.position = category_position
    end

    subcategories.each_with_index do |subcategory_name, subcategory_position|
      Category.find_or_create_by!(name: subcategory_name, parent: category) do |c|
        c.position = subcategory_position
      end
    end
  end
end

BRANDS = [
  "Adidas", "Arezzo", "Apple", "Asics", "Brastemp", "C&A", "Calvin Klein", "Converse",
  "Electrolux", "Farm", "Havaianas", "Hering", "Levi's", "Lacoste", "Mizuno", "Nike",
  "Philips", "Puma", "Renner", "Riachuelo", "Samsung", "Schutz", "Sony", "Tok&Stok",
  "Tramontina", "Vans", "Zara"
].freeze

BRANDS.each { |name| Brand.find_or_create_by!(name: name) }

# Pessoas de exemplo, todas com a senha "senha1234".
DEMO_USERS = [
  { name: "Ana Souza",     email: "ana@example.com",    store: "brechó da ana",     bio: "Roupas femininas em ótimo estado, a maioria usada poucas vezes." },
  { name: "Bruno Lima",    email: "bruno@example.com",  store: "garagem do bruno",  bio: "Eletrônicos e games revisados. Envio em até 2 dias úteis." },
  { name: "Carla Mendes",  email: "carla@example.com",  store: "casa da carla",     bio: "Móveis e decoração para quem gosta de peças com história." },
  { name: "Diego Rocha",   email: "diego@example.com",  store: "diego vintage",     bio: "Discos, câmeras e outras antiguidades garimpadas." }
].freeze

DEMO_USERS.each do |attrs|
  user = User.find_or_create_by!(email_address: attrs[:email]) do |u|
    u.name = attrs[:name]
    u.password = "senha1234"
  end
  user.store.update!(name: attrs[:store], slug: attrs[:store].parameterize, bio: attrs[:bio])
end

puts "Seeds: #{Category.departments.count} departamentos, #{Category.count} categorias, " \
     "#{Brand.count} marcas, #{User.count} usuários, #{Store.count} lojinhas."
