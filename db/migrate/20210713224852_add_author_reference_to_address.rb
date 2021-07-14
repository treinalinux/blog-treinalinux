class AddAuthorReferenceToAddress < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :author, null: false, foreign_key: true
  end
end
