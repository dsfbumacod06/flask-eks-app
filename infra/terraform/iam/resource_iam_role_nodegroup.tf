# # IAM Role for EKS Node Group 

# // to be removed, for ebs csi use case
# # resource "aws_iam_role_policy" "ng_inline_policy" {
# #   name = "EBS_access"
# #   role = aws_iam_role.eks_nodegroup_role.id

# #   policy = jsonencode({
# #     Version = "2012-10-17"
# #     Statement = [
# #           {
# #       "Effect": "Allow",
# #       "Action": [
# #         "ec2:AttachVolume",
# #         "ec2:CreateSnapshot",
# #         "ec2:CreateTags",
# #         "ec2:CreateVolume",
# #         "ec2:DeleteSnapshot",
# #         "ec2:DeleteTags",
# #         "ec2:DeleteVolume",
# #         "ec2:DescribeInstances",
# #         "ec2:DescribeSnapshots",
# #         "ec2:DescribeTags",
# #         "ec2:DescribeVolumes",
# #         "ec2:DetachVolume"
# #       ],
# #       "Resource": "*"
# #     }
# #     ]
# #   })
# # }

# resource "aws_iam_role" "eks_nodegroup_role" {
#   name = var.iam_ng_role_name
#   assume_role_policy = jsonencode({
#     Statement = [
#     {
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }
#   ]
#     Version = "2012-10-17"
#   })

# }

# resource "aws_iam_role_policy_attachment" "eks-AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.eks_nodegroup_role.name
# }

# resource "aws_iam_role_policy_attachment" "eks-AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.eks_nodegroup_role.name
# }

# resource "aws_iam_role_policy_attachment" "eks-AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.eks_nodegroup_role.name
# }



