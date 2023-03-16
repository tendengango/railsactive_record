class ExercisesController < ApplicationController
  def exercise1
    # Retourner tous les aliments non commandés.
    #   * Utilisation de left_outer_joins.
    @foods = Food
    .left_outer_joins(:order_foods)
    .distinct.where(order_foods: {id: nil})
  end

  def exercise2
    # 【要件】注文されていない料理を提供しているすべてのお店を返すこと
    #   * left_outer_joinsを使うこと
    @shops = Shop
    .left_outer_joins(foods: :order_foods)
    .distinct.where(foods:{order_foods:{id: nil}})
  end

  def exercise3 
    # [Exigence] Retourner tous les magasins qui servent de la nourriture qui n'a pas été commandée.
    #   * L'utilisation des jointures.
    #   * Renvoyer le nombre de commandes en appelant orders_count sur l'instance d'adresse récupérée.
    @address = Address
    .joins(:orders)
    .select("address.*, COUNT(orders.*).orders_count")
    .group("address.id") 
    .order("orders_count DESC")
    .first
  end

  def exercise4 
    # [Exigence] Retourner les clients qui dépensent le plus d'argent.
    #   * Utilisation des jointures.
    #   * L'appel de foods_price_sum sur l'instance de client récupérée renvoie le montant total.
    @customer = Customer
    .joins(orders: :foods)
    .select("customers.*, SUM(foods.price) AS foods_price_sum")
    .group("customers.id")
    .order("foods_price_sum DESC")
    .first
  end
end
