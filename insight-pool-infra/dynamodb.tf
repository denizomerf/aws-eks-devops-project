resource "aws_dynamodb_table" "votes" {
  name           = "InsightPoll-Votes"
  billing_mode   = "PAY_PER_REQUEST" 
  hash_key       = "vote_id"         

  attribute {
    name = "vote_id"
    type = "S" # String (Metin)
  }

  tags = {
    Name = "InsightPoll-VotesTable"
  }
}