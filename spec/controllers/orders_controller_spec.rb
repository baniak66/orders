require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  let(:order) { create :order }

  context 'anonymous user' do

    context 'retrives list' do
      let!(:orders) { create_list :order, 10 }
      it 'of orders' do
        get :index
        expect(response).to be_success
        expect(Order.all.length).to eq(10)
      end
    end

    it "can't add order" do
      post :create
      expect(JSON.parse(response.body)["error"]).to eq("Please login...")
      expect(response).to have_http_status(401)
    end

    it "can't delete order" do
      delete :destroy, params: { id: order.id }
      expect(JSON.parse(response.body)["error"]).to eq("Please login...")
      expect(response).to have_http_status(401)
    end

    it "can't update order" do
      put :update, params: { id: order.id }
      expect(JSON.parse(response.body)["error"]).to eq("Please login...")
      expect(response).to have_http_status(401)
    end
  end

  context 'logged user' do

    let!(:user) { create :user }
    let!(:my_order) { create :order, user: user}
    let!(:my_order_with_meal) { create :order, user: user}
    let!(:meal) { create :meal, order: my_order_with_meal}
    let!(:other_order) { create :order}
    let!(:meal2) { create :meal, order: other_order}

    before :each do
      session[:user_id] = user.id
    end

    let(:params) do
      {params: { order: { restaurant: "Restaurant" } }}
    end

    describe "#create" do
      it "can add order" do
        expect { post :create, params }.to change(Order, :count).by(1)
        post :create, params
        expect(JSON.parse(response.body)["restaurant"]).to eq("Restaurant")
        expect(response).to have_http_status(200)
      end
    end

    context "#destroy" do

      context "own order" do
        describe "can delete order" do
          it "without meals" do
            expect { delete :destroy, params: { id: my_order.id } }.to change(Order, :count).by(-1)
            expect(response).to have_http_status(200)
          end
        end

        describe "can't delete order" do
          it "with meals" do
            expect { delete :destroy, params: { id: my_order_with_meal.id } }.to_not change(Order, :count)
            expect(JSON.parse(response.body)["error"]).to eq("You can't delete order with meals")
            expect(response).to have_http_status(403)
          end
        end
      end

      describe "can't delete" do
        it "not own order" do
          expect { delete :destroy, params: { id: other_order.id } }.to_not change(Order, :count)
          expect(JSON.parse(response.body)["error"]).to eq("This is not your order")
          expect(response).to have_http_status(401)
        end
      end
    end

    context "#update" do

      describe "own order" do
        describe "can update order status" do
          it "with meals" do
            put :update, params: { id: my_order_with_meal.id, order: { status: "finalized" } }
            expect(JSON.parse(response.body)["status"]).to eq("finalized")
            expect(response).to have_http_status(200)
          end
        end

        describe "can't update order status" do
          it "without meals" do
            put :update, params: { id: my_order.id, order: { status: "finalized" } }
            expect(JSON.parse(response.body)["error"]).to eq("You can't chenge status of empty order")
            expect(response).to have_http_status(403)
          end
        end
      end

      describe "can't update" do
        it "not own order status" do
          put :update, params: { id: other_order.id, order: { status: "finalized" } }
          expect(JSON.parse(response.body)["error"]).to eq("This is not your order")
          expect(response).to have_http_status(401)
        end
      end

    end
  end
end
