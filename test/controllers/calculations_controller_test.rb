require 'test_helper'

class CalculationsControllerTest < ActionController::TestCase
  setup do
    @calculation = calculations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calculations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calculation" do
    assert_difference('Calculation.count') do
      post :create, calculation: { age: @calculation.age, education_level: @calculation.education_level, email_address: @calculation.email_address, gross_salary: @calculation.gross_salary, working_years: @calculation.working_years, working_years_total: @calculation.working_years_total }
    end

    assert_redirected_to calculation_path(assigns(:calculation))
  end

  test "should show calculation" do
    get :show, id: @calculation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @calculation
    assert_response :success
  end

  test "should update calculation" do
    patch :update, id: @calculation, calculation: { age: @calculation.age, education_level: @calculation.education_level, email_address: @calculation.email_address, gross_salary: @calculation.gross_salary, working_years: @calculation.working_years, working_years_total: @calculation.working_years_total }
    assert_redirected_to calculation_path(assigns(:calculation))
  end

  test "should destroy calculation" do
    assert_difference('Calculation.count', -1) do
      delete :destroy, id: @calculation
    end

    assert_redirected_to calculations_path
  end
end
