
resource "aws_ecr_repository" "poll_api" {
  name = "poll-api"


  image_tag_mutability = "MUTABLE"


  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "InsightPoll-PollApiRepo"
  }
}