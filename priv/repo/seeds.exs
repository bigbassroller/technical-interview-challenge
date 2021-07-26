# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     VetspireApp.Repo.insert!(%VetspireApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias VetspireApp.BlockTypes

File.ls("images")
|> case do
	{:ok, files} -> 
		files
		|> Enum.map(fn file -> file
			name = file
			|> String.replace(".jpg", "")
			|> String.replace("_", " ")
			|> String.split(" ")
			|> Enum.map(&String.capitalize(&1))
			|> Enum.join(" ")

      dest = Path.join("priv/static/uploads", "#{file}")
      File.cp!("images/#{file}", dest)

			%{
				"name" => name,
				"image" => "/uploads/#{file}",
				"block_type" => %{
					"name" => "Dog Breeds"
				}
			} 
			|> BlockTypes.create_block()
		end)

	{:error, error} -> IO.puts("error: #{error}")
end