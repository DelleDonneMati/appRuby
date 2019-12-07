class ApplicationController < ActionController::API

    def hello
        render text: "Hello, world!"
    end
end
