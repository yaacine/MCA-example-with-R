library("readxl")
library("FactoMineR")
library("factoextra")

my_data <- read_excel("dataset.xlsx", sheet = "RES1")

my_data[my_data=="++"]<- "TB"
my_data[my_data=="+"]<- "B"
#my_data[my_data=="--"]<- "TM"
my_data[my_data=="- -"]<- "TM"
my_data[my_data=="-"]<- "M"
clean_responses = my_data[1:47,c(2:11)]
clean_frequences= my_data[50:55,c(1:11)]


write.table(clean_responses, "clean-data.txt", append = FALSE, sep = " ", dec = ".",row.names = FALSE, col.names = FALSE)
write.table(clean_frequences, "clean-frequences.txt", append = FALSE, sep = " ", dec = ".",row.names = FALSE, col.names = FALSE)

summurisedData = read.table(file = "clean-frequences.txt" , header = TRUE)

"construction de la table disjonctive"
library(FactoMineR)
disjonctif = tab.disjonctif.prop(clean_responses,seed=NULL,row.w=NULL)


"starting the mca analysis"

res.mca <- MCA(clean_responses)
library("factoextra")

eig.val <- get_eigenvalue(res.mca)
View(eig.val)
fviz_screeplot(res.mca, addlabels = TRUE, ylim = c(0, 47))

fviz_mca_biplot(res.mca, 
                repel = TRUE, # Avoid text overlapping (slow if many point)
                ggtheme = theme_minimal())



"correlation entre les variables"
fviz_mca_var(res.mca, choice = "mca.cor", 
         repel = TRUE, # Avoid text overlapping (slow)
            ggtheme = theme_minimal())


"visualiser seulement les modalités (sans les individus)"
 fviz_mca_var(res.mca, 
              repel = TRUE, # Avoid text overlapping (slow)
              ggtheme = theme_minimal())

 
 
 # ******************** qualité de reprasentation des variables ***********************
 var <- get_mca_var(res.mca)
 var$cos2
 
 "visualiser les variables colorés selon les qualités de representations"
 fviz_mca_var(res.mca, col.var = "cos2",
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
              repel = TRUE, # Avoid text overlapping
              ggtheme = theme_minimal())
 
 # ******************** qualité de reprasentation des individus ***********************
 var1 <- get_mca_ind(res.mca)
 var1$cos2
 
 "visualiser les variables colorés selon les qualités de representations"
 fviz_mca_ind(res.mca, col.ind = "cos2",
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
              repel = TRUE, # Avoid text overlapping
              ggtheme = theme_minimal())
 
 
 # relation entre les modalités
 fviz_mca_var(res.mca, col.var="blue", shape.var = 15,
              repel = TRUE)
 
 library("corrplot")
 corrplot(var$cos2, is.corr=FALSE)
 
 # Cos2 of variable categories on Dim.1 and Dim.2
 fviz_cos2(res.mca, choice = "var", axes = 1:2)
 
 
 #************* contributions des variables *****************
 # Contributions of rows to dimension 1
 fviz_contrib(res.mca, choice = "var", axes = 1, top = 15)
 # Contributions of rows to dimension 2
 fviz_contrib(res.mca, choice = "var", axes = 2, top = 15)
 #contribution of rows to plot 1-2
 fviz_contrib(res.mca, choice = "var", axes = 1:2, top = 15)
 
 #************* contributions des individus *******************
 # Contributions of rows to dimension 1
 fviz_contrib(res.mca, choice = "ind", axes = 1, top = 15)
 # Contributions of rows to dimension 2
 fviz_contrib(res.mca, choice = "ind", axes = 2, top = 15)
 #contribution of rows to plot 1-2
 fviz_contrib(res.mca, choice = "ind", axes = 1:2, top = 15)
 
 
 
 # *************** representarions avec ellipse ********************
 #une seule variable
 fviz_mca_ind(res.mca, habillage = 4, addEllipses = TRUE)
 
 #deux variables
 fviz_ellipses(res.mca, c("prog", "bien_exposée"), geom = "point")
 
 
 
 #croiser deux questions 
 twoquestions <- table(clean_responses[,c(1,3)])
 View(twoquestions)
 
 
 
 
 # just for debug 
 X1 <- as.data.frame(X1)
 for(i in 1:dim(X1)[2]){
         X1[i]<-as.numeric(X1[i])
 }
 summary(a)
 