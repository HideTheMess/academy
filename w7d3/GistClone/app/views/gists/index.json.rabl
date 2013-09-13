object @gists
attribute :id, :owner_id, :title
child :favorites do
  attribute :id, :user_id, :gist_id
end
