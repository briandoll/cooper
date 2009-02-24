class Factories < Object

  Factory.define :category do |c|
    c.name "Meat"
    c.products {|p| [p.association(:product)] }
  end  
  
  Factory.define :product do |p|
    p.name "Tasty Meat"
    p.description "It is super, super tasty"
    p.unit_price 12.50
  end
  
end