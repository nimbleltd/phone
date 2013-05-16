#date_create_projects

Class createProjects < ActiveRecord::Migration
  def change
  create_table :projects do |t|
    t.string :name
  end
end