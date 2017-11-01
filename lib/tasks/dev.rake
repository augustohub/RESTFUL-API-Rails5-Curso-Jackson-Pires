namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    puts 'Resetando o BD...'
    #{}%x(rails db:drop db:create db:migrate)

    puts 'Cadastrando os tipos de contato...'
    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts 'Tipos de contato cadastrados com sucesso!'

    puts 'Cadastrando os contatos...'
    100.times do |i|
      Contact.create!(
        name:      Faker::Name.name,
        email:     Faker::Internet.email,
        birthdate: Faker::Date.between(35.years.ago, 18.years.ago),
        kind:      Kind.all.sample
      )
    end
    puts 'Contatos cadastrados com sucesso!'

    puts 'Cadastrando os Telefones...'
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        Phone.create!(number:  Faker::PhoneNumber.cell_phone,
                      contact: contact)
      end
    end
    puts 'Telefones cadastrados com sucesso!'

    puts 'Cadastrando os Endereços...'
    Contact.all.each do |contact|
      Address.create!(street:  Faker::Address.street_address,
                      city:    Faker::Address.city,
                      contact: contact)
    end
    puts 'Endereços cadastrados com sucesso!'
  end
end
