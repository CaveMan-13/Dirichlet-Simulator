dirichlet <- function(a,n,r=1000,all=F){
  #verify 'all' is logical:
  if(class(all)!="logical"){
    print("ERROR: 'all' parameter must be logical. Choose TRUE to see all the possible configurations, FALSE to see only the most probable.")
  }else{
    
    start_time <- Sys.time() # Log in start time.
    l <- vector(mode = "list",length = r) # list holding ending configurations. 
    
    for(i in 1:r){ 
      c <- 1 # Vector recording the cluster into which 'individuals' are added. 
      for(j in 1:n){ 
        
        # Randomly assign the 'individual' to a cluster using a random number between 0 and 1: 
        if(runif(1)<a/(a+j-1)){ # Into a new cluster with probability a/(a+j-1).
          c <- c(c,j)
        }else{ # Into an existing cluster otherwise. 
          c <- c(c,sample(unique(c),1))
        }
      }
      l[[i]] <- as.data.frame(table(c)) # Save the configuration of each run into list l.
    }
    profiles <- unique(l) # Create an object containing every unique() configuration observed in the simulations. 
    prob <- c() # Vector to hold the probability of each configuration. 
    for(i in 1:length(profiles)){ 
      x <- c() 
      for(j in 1:r){ 
        # Did run j produce configuration i:  
        if(nrow(profiles[[i]])==nrow(l[[j]])){ # Test if they have similar number of clusters.
          grp <- as.character(profiles[[i]][,1])==as.character(l[[j]][,1]) # Test if they have the same cluster labels.
          dst <- profiles[[i]][,2]==l[[j]][,2] # Test if they have the same number of individuals per clusters.
          # If they are the same, y is TRUE:
          y <- sum(grp)==length(grp) & sum(dst)==length(dst) # Same configurations will have only TRUE and the sum will equal the length (logical TRUE/FALSE are the same as numeric 1/0). 
        }else{ 
          y <- FALSE  
        } 
        
        x <- c(x,y) # x becomes a vector of logical values of the comparison between each r simulated configuration to configuration i.
      }
      prob <- c(prob,sum(x)/r) # Probability of configuration i is number of runs that resulted in it divided by total number of runs. 
    }
    
    
# Adjustments for a clearer output:
    for(i in 1:length(profiles)){ # Go through all profiles.
      colnames(profiles[[i]]) <- c("Cluster","Size") # Change the column names.
      profiles[[i]] <- list(Configuration=profiles[[i]],probability=prob[[i]]) # Add the corresponding probability.
    }
    
    
    end_time <- Sys.time() # Time at the end of the program.
    run_time <- end_time - start_time # Time difference is the running time. 
    
    if(all==F){ # Output only the most likely configuration(s) if all==F.
      return(list("Most likely configuration(s):",profiles[prob==max(prob)],"Run Time:",run_time))
    }else{ # Output all configurations if all==T.
      return(list("All configuration(s):",profiles,"Run Time:",run_time))  
    }
  }
}

