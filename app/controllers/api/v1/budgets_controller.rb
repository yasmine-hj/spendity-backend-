class Api::V1::BudgetsController < ApplicationController
   
    before_action :set_category

      # GET 
    def index
        if !!params[:category_id]
          @budgets = Budget.where(category_id: params[:category_id])
          render json: @budgets
        else
          @budgets = Budget.all
          render json: @budgets
      end
      end

    # GET 
      def show
        @budget = Budget.find(params[:id])
        render json: @budget
      end
    
    # POST
      def create
        @budget = @category.budgets.new(budget_params)
        if @budget.save
        render json: @category
        else
          render json: { errors: budget.errors.full_messages}
        end
      end
    
    # PATCH/PUT 
      def update
        @budget = Budget.find(params[:id])
        @budget.update(budget_params)
        render json: @budget
      end

    # DELETE 
      def destroy
        @budget = Budget.find(params["id"])
        category = Category.find(@budget.category_id)
        @budget.destroy
        render json: @category
      end
    
      private
      def set_category
        @category = Category.find(params[:category_id])
      end
    
      def budget_params
        params.require(:budget).permit(:amount, :category_id, :currency, :notes, :start_date, :end_date)
      end
    
end
