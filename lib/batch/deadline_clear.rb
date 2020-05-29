class Batch::DeadlineClear
  def self.deadline_clear
    outdated_posts = Post.where('deadline < ? ', DateTime.now).update_all(:status => 'closed')
  end
end
