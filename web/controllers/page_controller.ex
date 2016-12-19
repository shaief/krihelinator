defmodule Krihelinator.PageController do
  use Krihelinator.Web, :controller

  def repositories(conn, _params) do
    repos =
      GithubRepo
      |> order_by(desc: :krihelimeter)
      |> limit(50)
      |> Repo.all
    render conn, "repositories.html", repos: repos
  end

  def language(conn, %{"language" => language}) do
    repos =
      GithubRepo
      |> where(language: ^language)
      |> order_by(desc: :krihelimeter)
      |> limit(50)
      |> Repo.all
    conn
    |> put_flash(:info, "#{language} repositories")
    |> render("repositories.html", repos: repos)
  end

  def languages(conn, _params) do
    languages = Repo.all(GithubRepo.languages_query)
    render conn, "languages.html", languages: languages
  end

  def about(conn, _params) do
    render conn, "about.html"
  end
end
