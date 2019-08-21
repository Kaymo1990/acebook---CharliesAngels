class AddCachedLikesToPosts < ActiveRecord::Migration[5.2]
  def self.up
    add_column :posts, :cached_likes_total, :integer, :default => 0
    add_column :posts, :cached_likes_score, :integer, :default => 0
    add_column :posts, :cached_likes_up, :integer, :default => 0
    add_column :posts, :cached_likes_down, :integer, :default => 0
    add_column :posts, :cached_weighted_score, :integer, :default => 0
    add_column :posts, :cached_weighted_total, :integer, :default => 0
    add_column :posts, :cached_weighted_average, :float, :default => 0.0
    add_index  :posts, :cached_likes_total
    add_index  :posts, :cached_likes_score
    add_index  :posts, :cached_likes_up
    add_index  :posts, :cached_likes_down
    add_index  :posts, :cached_weighted_score
    add_index  :posts, :cached_weighted_total
    add_index  :posts, :cached_weighted_average

    # Uncomment this line to force caching of existing likes
    # Post.find_each(&:update_cached_likes)
  end

  def self.down
    remove_column :posts, :cached_likes_total
    remove_column :posts, :cached_likes_score
    remove_column :posts, :cached_likes_up
    remove_column :posts, :cached_likes_down
    remove_column :posts, :cached_weighted_score
    remove_column :posts, :cached_weighted_total
    remove_column :posts, :cached_weighted_average
  end
end
