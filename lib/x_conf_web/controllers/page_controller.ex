defmodule XConfWeb.PageController do
  use XConfWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
