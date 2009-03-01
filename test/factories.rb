class Factories < Object

  Factory.define :vendor do |v|
    v.name "Bucks"
    v.description "Local and lovely"
    v.contact_info "Over yonder"
  end
  
  Factory.define :product do |p|
    p.name "Tasty Meat"
    p.description "It is super, super tasty"
    p.unit_price 12.50
    p.status Product::STATUS_AVAILABLE
    p.association :category
    p.association :vendor    
  end
  
  Factory.define :category do |c|
    c.name "Meat"    
  end
  
  Factory.define :user do |u|
    u.login "Brian"
    u.email {|a| "#{a.login}@example.com".downcase }    
    u.salt 'dae8282b41df90f132a918b97a9e62027ecd381b'
    u.crypted_password '5e85577db6bd0e9dd88f7196e4cec7e5e24e3cd0'
    u.created_at 5.days.ago.to_s
    u.remember_token_expires_at 1.days.from_now.to_s
    u.activated_at 5.days.ago.to_s    
  end
  
end