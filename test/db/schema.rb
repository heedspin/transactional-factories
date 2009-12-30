ActiveRecord::Schema.define do
  create_table "blog_posts", :force => true do |t|
    t.column "title", :string
  end
end
