//provider info

provider "aws" {
  region = "ap-south-1"
 
 profile = "ujjwal61"   
}

// Creating the RDS database on AWS cloud

resource "aws_db_instance" "mysql" {
	  allocated_storage    = 20
	  storage_type         = "gp2"
	  engine               = "mysql"
	  engine_version       = "5.7.30"
	  identifier           =  "ud-database"
	  instance_class       = "db.t2.micro"
	  name                 = "ud61database"
	  username             = "admin"
	  password             = "ud61dixit"
	  parameter_group_name = "default.mysql5.7"
	  iam_database_authentication_enabled = true
	  publicly_accessible = true
	  skip_final_snapshot = true
	}


provider "kubernetes" {
	  config_context_cluster = "minikube"
	}
	

	resource "kubernetes_service" "service" {
	  metadata {
	    name = "wordpress"
	  }
	  spec {
	    selector = {
	      app = "wordpress"
	    }
	    session_affinity = "ClientIP"
	    port {
	      port        =    80
	      target_port = 80
	      node_port = 30100
	    }
	

	    type = "NodePort"
	  }
	}
	

	resource "kubernetes_deployment" "deployment" {
	  metadata {
	    name = "wordpress"
	    labels = {
	       app = "wordpress"
	    }
	  }
	

	  spec {
	    replicas = 3
	

	    selector {
	      match_labels = {
	         app = "wordpress"
	      }
	    }
	

	    template {
	      metadata {
	        labels = {
	          app = "wordpress"
	        }
	      }
	

	      spec {
	        container {
	          image = "wordpress"
	          name  = "wordpress"
	

	        }
	      }
	    }
	  }
	}

