locals {
  vpc_cidr = "10.0.0.0/20"
  public_subnets = [{
    cidr : "10.0.0.0/27"
    az : "us-east-1a"
    }, {
    cidr : "10.0.0.32/27"
    az : "us-east-1b"
  }]
  private_subnets = [{
    cidr : "10.0.4.0/22"
    az : "us-east-1a"
    }, {
    cidr : "10.0.8.0/22"
    az : "us-east-1b"
  }]
  cluster_name = "Flaming"
}
