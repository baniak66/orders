require 'rails_helper'

RSpec.describe MealsController, type: :controller do


  context 'anonymous user' do
    let!(:meal) { create :meal }

    it "can't add meal" do
      post :create, params: { order_id: meal.order_id }
      expect(JSON.parse(response.body)["error"]).to eq("Please login...")
      expect(response).to have_http_status(401)
    end

    it "can't delete order" do
      delete :destroy, params: { order_id: meal.order_id, id: meal.id }
      expect(JSON.parse(response.body)["error"]).to eq("Please login...")
      expect(response).to have_http_status(401)
    end

  end

  context 'logged user' do
    let!(:user) { create :user }
    let!(:order) { create :order}

    before :each do
      session[:user_id] = user.id
    end

    let(:params) do
      {params: { order_id: order.id, meal: { name: "Pizza", price: "25.00" } }}
    end

    describe "#create" do
      context "user has no meal in order" do
        it "can add meal" do
          expect { post :create, params }.to change(Meal, :count).by(1)
        end
        it "has proper response" do
          post :create, params
          expect(JSON.parse(response.body)["name"]).to eq("Pizza")
          expect(response).to have_http_status(200)
        end
      end

      context "user has meal in order" do
        let!(:meal){create :meal, order: order, user: user}

        let(:params) do
          {params: { order_id: order.id, meal: { name: "Pizza", price: "25.00" } }}
        end

        it "can't add second meal" do
          expect { post :create, params }.to_not change(Meal, :count)
        end
        it "has proper response" do
          post :create, params
          expect(JSON.parse(response.body)["error"]).to eq("You can add only one meal")
          expect(response).to have_http_status(403)
        end
      end
    end

    context "#destroy" do
      context "own meal" do
        let!(:meal){ create :meal, order: order, user: user }
        let!(:closed_order){ create :order, status: "finalized" }
        let!(:meal_in_closed){ create :meal, order: closed_order, user: user }

        describe "can delete meal" do
          it "in active order" do
            expect { delete :destroy, params: { order_id: meal.order_id, id: meal.id } }.to change(Meal, :count).by(-1)
            expect(response).to have_http_status(200)
          end
        end

        describe "can't delete meal" do
          it "in closed order" do
            expect { delete :destroy, params: { order_id: meal_in_closed.order_id, id: meal_in_closed.id } }.to_not change(Order, :count)
            expect(JSON.parse(response.body)["error"]).to eq("Order is closed")
            expect(response).to have_http_status(403)
          end
        end
      end

      context "can't delete" do
        let!(:meal_other_user){ create :meal, order: order }

        it "not own meal" do
          expect { delete :destroy, params:{ order_id: meal_other_user.order_id, id: meal_other_user.id } }.to_not change(Order, :count)
          expect(JSON.parse(response.body)["error"]).to eq("This is not your meal")
          expect(response).to have_http_status(401)
        end
      end

    end
  end
end
