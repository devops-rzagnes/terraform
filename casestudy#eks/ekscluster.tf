

resource "aws_eks_cluster" "aws_eks" {
  name     = "eks_cluster_terraform"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = module.terraform-vpc.public_subnets
  }

  # Attaching policies we created in iam.
  # Dont start creation of EKS cluster until these policies are attached to the EKS node
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,  
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
  ]

  tags = {
    Name = "EKS_Cluster_Terraform-${timestamp()}"
  }
}

# Define the node group
resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = "node_terraform"
  instance_types = ["t2.micro"]
  node_role_arn   = aws_iam_role.eks_nodes.arn        # created node role in iam file
  subnet_ids      = module.terraform-vpc.public_subnets # created from vpc file

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
# Policies assigned to the node role in iam file
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}