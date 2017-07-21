helpers do
  def render_view(path, options = {})
    haml(path.to_sym, options)
  end

  def public_path
    "hello"
  end
end
