class DrinksController < ApplicationController

    def index
        @drinks = Drink.all
        if @drinks.count < 1
            redirect_to url_for(:controller => :drinks, :action => :new)
        end
    end
    
    def show
        @drink = Drink.find(params[:id])
    end

    def new #display form
        @drink = Drink.new
    end
    
    def create #save new record
        @drink = Drink.new(allowed_params)
        if @drink.save
            redirect_to drinks_path #index
        else
            redender 'new'
        end 
    end

    def edit
        @drink = Drink.find(params[:id])
        
        respond_to do |format|
            format.html # edit.html.erb
            format.json { render json: @drink }
        end
    end
    
    def update #save changes
        @drink = Drink.find(params[:id])
        if @drink.update_attributes(allowed_params)
            redirect_to drinks_path #index
        #else
            # redender 'edit' #new
        end 
    end
    
    def destroy
        @drink = Drink.find(params[:id])
        @drink.destroy
        redirect_to drinks_path
    end
    
    private
        def allowed_params
            params.require(:drink).permit(:name, :size)
        end
    
end
