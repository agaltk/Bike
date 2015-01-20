class ChartsController < ApplicationController
  @type_of_chart

  def distance
  	  	session[:type_of_chart] = params[:type] if params[:type]!=nil
        
  end

  def duration
       session[:type_of_chart] = params[:type] if params[:type]!=nil 
  end

  def average
      session[:type_of_chart] = params[:type] if params[:type]!=nil  
  end

  def max
      session[:type_of_chart] = params[:type] if params[:type]!=nil  
  end

  
end
