Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins 'http://rainbowprinters.co.in:80'
        resource '/lead_generation', headers: :any, methods: [:post]
    end
end