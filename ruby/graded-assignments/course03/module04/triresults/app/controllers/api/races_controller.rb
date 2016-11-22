module Api
  class RacesController < ApplicationController
    before_action :set_race, only: [:update, :destroy] #[:show, :update, :destroy, :results, :results_detail]
    before_action :set_entrant, only: [:results_detail_update]

    protect_from_forgery with: :null_session

	  #rescue_from ActionController::UnknownFormat do |exception|
    rescue_from ActionView::MissingTemplate do |exception|
      Rails.logger.debug("Accept:#{request.accept}")
      render plain: "woops: we do not support that content-type[#{request.accept}]", status: :unsupported_media_type
    end

    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      #render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
      @msg = "woops: cannot find race[#{params[:id]}]"
      if !request.accept || request.accept == "*/*"
        render plain: @msg, status: :not_found
      else
        #render action: :error, status: :not_found, content_type: "#{request.accept}"
        respond_to do |format|
          format.json { render "error_msg", status: :not_found, content_type: "#{request.accept}" }
          format.xml  { render "error_msg", status: :not_found, content_type: "#{request.accept}" }
        end
      end
    end

    #rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    #  @msg = "woops: cannot find race[#{params[:id]}]"
    #  if !request.accept || request.accept == "*/*"
    #    render plain: @msg, status: :not_found
    #  else
    #    respond_to do |format|
    #      format.json { render "error_msg", status: :not_found, content_type: "#{request.accept}" }
    #      #format.xml  { render "error_msg", status: :not_found, content_type: "#{request.accept}" }
    #    end
    #  end
    #end

    #rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    #  @msg = "woops: cannot find race[#{params[:id]}]"
    #  if !request.accept || request.accept == "*/*"
    #    render plain: @msg, status: :not_found
    #  else
    #    case request.accept
    #    when "application/json" then render json: {"msg" => @msg}, status: :not_found, template: "api/error_msg"
    #    when "application/xml" then render @msg, status: :not_found, template: "api/error_msg"
    #    else
    #      render status: :not_found, template: "api/error_msg"
    #    end        
    #    Rails.logger.debug("Accept:#{request.accept}")
    #  end
    #end

  	def index
  	  #if !request.accept || request.accept == "*/*"
      #  render plain: "/api/races"
      #else
      #  @races = Race.all.order_by(date: :desc)
      #  render json: @races, status:200
      #  #render plain: api_races_path
      #end
      
      if !request.accept || request.accept == "*/*"
        if !params[:offset].nil? and !params[:limit].nil?
          render plain: "#{api_races_path}, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
        else
          render plain: "#{api_races_path}"
        end
      else
        @races = Race.all.order_by(date: :desc)
        if !params[:offset].nil? and !params[:limit].nil?        
          case request.accept
          when "application/json" then render json: @races, status: 200 #, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
          when "application/xml" then render xml: @races, status: 200 #, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
          else render @races, status: 200
          end
        else
          case request.accept
          when "application/json" then render json: @races, status: 200 #, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
          when "application/xml" then render xml: @races, status: 200          
          else render @races, status: 200          
          end
        end
      end

  	  #if !request.accept || request.accept == "*/*"
      #  render plain: "#{api_races_path}, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
      #end
  	end

  	def show
	    #if !request.accept || request.accept == "*/*"
      #  #render plain: api_race_path(params[:id])
      #  render plain: "/api/races/#{params[:id]}", status: :ok
      #else
      #  #render "show", status: :ok
      #  #render "race", status: :ok, content_type: "#{request.accept}"
      #  respond_to do |format|
      #    format.json { render "race", status: :ok, content_type: "#{request.accept}" }
      #    format.xml  { render "race", status: :ok, content_type: "#{request.accept}" }
      #  end
      #end
      
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}"
      else
        set_race
        render "race", content_type: "#{request.accept}"
      end
  	end

  	def create
      if !request.accept || request.accept == "*/*"
        #render plain: :nothing, status: :ok
        msg = ""
        if params[:race]
          if params[:race][:name]
            msg = params[:race][:name]
          end
        end
        render plain: msg, status: :ok 
      else
        race = Race.create(race_params)
        render plain: race.name, status: :created
      end

      #Rails.logger.debug("Accept:#{request.accept}")
      #if !request.accept || request.accept == "*/*"
      #  if params && params[:race] && params[:race][:name]
      #    render plain: "#{params[:race][:name]}", status: :ok
      #  else        
      #    render plain: :nothing, status: :ok
      #  end
      #elsif !request.accept || request.accept != "*/*"
      #  race = Race.new(race_params)
      #  if race.save
      #    render plain: "#{params[:race][:name]}", status: :created
      #  else
      #    render plain: "#{params[:race][:name]}", status: :error
      #  end
      #else
      #  render plain: ""
      #end
    end

    def update
      #race = Race.find(params[:id])
      #race.update(race_params)
      #render json: race
      
      @race.update_attributes(race_params)
      render json: @race
      #if !request.accept || request.accept == "*/*"
      #  render plain: :nothing, status: :ok
      #else
      #  set_race
      #  Rails.logger.debug("method=#{request.method}")
      #  if @race.update(race_params)
      #    render json: @race, status: :ok
      #  else
      #    render json: @race, status: :error
      #  end
      #end
    end

    def destroy
      @race.destroy
      render :nothing=>true, :status => :no_content

      #set_race
      #if @race.destroy
      #  render nothing: true, status: :no_content
      #else
      #  render nothing: true, status: :error
      #end
    end

    def results
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}/results"
      else
        set_race
        max_last_modified = @race.entrants.max(:updated_at)
        if_modified_since = request.headers['If-Modified-Since']
        puts "****#{if_modified_since}****"
        if stale?(last_modified: max_last_modified)
          @entrants=@race.entrants  
        end
        #fresh_when last_modified: @race.entrants.max(:updated_at)
      end       
    end

    def results_detail
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
      else
        set_entrant
        render :partial=>"result", :object=>@result
      end 
    end

    def results_detail_update
      #puts "*****#{result_params}****"
      if result_params
        if result_params[:swim]
          @result.swim=@result.race.race.swim
          @result.swim_secs = result_params[:swim].to_f
        end
        if result_params[:t1]
          @result.t1=@result.race.race.t1
          @result.t1_secs = result_params[:t1].to_f
        end
        if result_params[:bike]
          @result.bike=@result.race.race.bike
          @result.bike_secs = result_params[:bike].to_f
        end
        if result_params[:t2]
          @result.t2=@result.race.race.t2
          @result.t2_secs = result_params[:t2].to_f
        end
        if result_params[:run]
          @result.run=@result.race.race.run
          @result.run_secs = result_params[:run].to_f
        end        
        @result.save
      end
      render json: @result
    end

    private

      def set_race
        @race = Race.find(params[:id])
      end

      def race_params
        params.require(:race).permit(:name, :date)
      end

      def result_params
        params.require(:result).permit(:swim, :t1, :bike, :t2, :run)
      end
    
      def set_entrant
        @race = Race.find(params[:race_id])
        @result=@race.entrants.where(:_id=>params[:id]).first
      end
  end
end
