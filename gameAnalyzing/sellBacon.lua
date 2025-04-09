local args = {
	{
		ItemName = "Bacon",
		Amount = 8417
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellItemRemote"):FireServer(unpack(args))
