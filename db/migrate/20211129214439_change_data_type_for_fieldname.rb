class ChangeDataTypeForFieldname < ActiveRecord::Migration[6.1]
  def change
    rename_column :article_categories, :articles_id, :article_id
  end
end
