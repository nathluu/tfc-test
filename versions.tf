terraform {
  cloud {
    organization = "natcom"

    workspaces {
      name = "tfc-test"
    }
  }
}
