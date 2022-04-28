class AnadirPasswordDigestAUsuarios < ActiveRecord::Migration[6.1]
  def change
    add_column :usuarios, :password_digest, :string
  end
end
