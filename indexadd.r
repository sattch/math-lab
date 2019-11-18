# To add to index.html
#    20190618

Looprange<- function(a,b)
{
if(a<=b) return(a:b)
return(c())
}

thismainpath <- function(){
  path <- readline("Main Path ")
  if(nchar(path)>0){
    tmp=grep("index.html",path,fixed=TRUE)
    if(length(tmp)>0){
      for(J in rev(1:nchar(path))){  #190618from
        if(substring(path,J,J)=="/"){break}
      } #190618to
      path=substring(path,1,J)
    }
    setwd(path)
  }
}

thisfile <- function(){
  path <- readline("Main Path ")
  if((nchar(path)>0)&&(substring(path,nchar(path))!="/")){
    path=paste(path,"/",sep="")
    setwd(path)
  }
  str <- readline("File(html) ")
  if(nchar(str)>0){
    tmp=grep(".",str,fixed=T)
    if(length(tmp)==0){
      str=paste(str,".html",sep="")
      str=paste(path,str,sep="")
    }
  }else{
    str=""
  }
  cat("File=",str,"\n",sep="")
  str
}

thismaintitle <- function(){
  str <- readline("Main Title ")
  if(nchar(str)==0){
    str="Main Title"
  }
  cat("Main Title=",str,"\n",sep="")
  str
}

thistitle <- function(){
  str <- readline("Title ")
  if(nchar(str)==0){
    str="Title"
  }
  cat("Title=",str,"\n",sep="")
  str
}

thispath <- function(){
  str <- readline("Path ")
  if(nchar(str)>0){
    if(substring(str,nchar(str))!="/"){
      str=paste(str,"/",sep="")
    }
  }
  cat("Path=",str,"\n",sep="")
  str
}

thisimage <- function(){
  str=""
  while(nchar(str)==0){
    str=readline("Image ")
  }
  tmp=strsplit(str,".",fixed=T)
  tmp=tmp[[1]][2]
  name=toupper(tmp)
  cat("Image=",str,"\n",sep="")
  c(str,name)
}

thisitem <- function(){
  str=""
  while(nchar(str)==0){
    str=readline("Item File ")
  }
  tmp=strsplit(str,".",fixed=T)
  tmp=tmp[[1]]
  if(length(tmp)>1){
    name=tmp[2]
  }else{
    name=""
  }
  c(str,name)
}

thispathno <- function(N){
  str="" ; num=N+1;
  while((nchar(str)==0)||(num>N)){
    str=readline("No of Path ")
    num=as.numeric(str)
  }
  num
}

thisimageno <- function(N){
  str="" ; num=N+1;
  while((nchar(str)==0)||(num>N)){
    str=readline("No of Image ")
    num=as.numeric(str)
  }
  num
}

thisitemno <- function(N){
  str="" ; num=N+1;
  while((nchar(str)==0)||(num>N)){
    str=readline("No of Item ")
    tmp=toupper(substring(str,1,1))
    if(tmp=="N"){return("next")}
    if(tmp=="E"){return("end")}
    num=as.numeric(str)
  }
  num
}

####### main ###########3

wfile="index.html"
bkup="index.bkup"
thismainpath()

tmp=system("date", intern=TRUE)
tmp=gsub(" ","0",substring(tmp,1,11),fixed=T)
tmp=gsub("年","/",tmp,fixed=T)
tmp=gsub("月","/",tmp,fixed=T)
date=gsub("日","",tmp,fixed=T)
datehead='<font size="5">&emsp;&emsp;'
Lines=c()
Tails=c()
fileflg=0
if(file.exists(wfile)){
  file.rename(wfile,bkup)
  Lines=readLines(bkup)
  numberv=1:length(Lines)
  tmp=numberv[Lines[numberv]=="</table></br>"]
  nn=max(tmp) #190702
  if(nn<length(Lines)){
    Tails=Lines[(nn+1):length(Lines)]
    Lines=Lines[1:nn]
    while(nn>0){  #190702from
      if(nchar(Lines[nn])==0){
        nn=nn-1
      }else{
        Lines=Lines[1:nn]
        Lines[nn+1]=""
        break
      }
    }
    nn=1
    while(nn<100){
      if(nchar(Tails[nn])==0){
        nn=nn+1
      }else{
        Tails=Tails[nn:(length(Tails))]
        break
      }
    }
    nn=length(Tails)
    while(nn>0){
      if(nchar(Tails[nn])==0){
        nn=nn-1
      }else{
        Tails=Tails[1:nn]
        break
      }
    }  #190702to
  }
  for(nn in 1:length(Lines)){
    if(substring(Lines[nn],1,nchar(datehead))==datehead){
      Lines[nn]=paste(datehead,date,"</font></p>",sep="")
      break
    }
  }
  fileflg=1
}else{
  maintitle=thismaintitle()
  Lines=c("<html>","<head>",paste("<title>",maintitle,"</title>",sep=""))
  Lines=c(Lines,"</head>","<body>",paste('<p><font size="10">&emsp;',maintitle,'</font>',sep=""))
  Lines=c(Lines,paste(datehead,date,"</font></p>",sep=""))
}
cat(Lines[1],"\n",file=wfile,sep="",append=F)
for(nn in 2:length(Lines)){
  cat(Lines[nn],"\n",file=wfile,sep="",append=T)
}
cat("Input info/data of each item\n")
cmdL=c()
for(Pno in 1:100){ #190618
  Plist=dir()
  for(J in 1:length(Plist)){
    cat(J,Plist[J],"\n")
  }
  tmp=thispathno(length(Plist))
  if(tmp==0){
    break
  }
  path=Plist[tmp]
  Flist=dir(path)
  if(length(Flist)==0){
    cat("There is no item\n")
    next
  }
  for(J in 1:length(Flist)){
    cat(J,Flist[J],"\n")
  }
  title=path
  cmdL=c(cmdL, paste("<!-- ",title," -->",sep="")) #190618
  cmdL=c(cmdL,'<table border="1" height="30">')
  tmp='    <tr><th colspan="2" align="left"><font size="5">&emsp;'
  tmp=paste(tmp,title,'</font></th></tr>',sep="")
  cmdL=c(cmdL,tmp)
  image=Flist[thisimageno(length(Flist))]
  tmp=strsplit(image,".",fixed=T)
  tmp=tmp[[1]]
  name=toupper(tmp[2])
  tmp='    <tr><td rowspan="20"><a href="'
  tmp=paste(tmp,path,"/",image,'"><img src="',sep="")
#  tmp='    <tr><td rowspan="20"><img src="'
  tmp=paste(tmp,path,"/",image,'" alt=',name,' width="240"></a></td></tr>',sep="")
  cmdL=c(cmdL,tmp)
  head='    <tr><td align="center" width="80"><a href="'
  tail='</a></td></tr>'
  for(Ino in 1:20){
    str=thisitemno(length(Flist))
    if((str=="end")||(str=="next")){break}
    if(is.numeric(str)){
      str=Flist[str]
      tmp=strsplit(str,".",fixed=T)
      tmp=tmp[[1]]
      if(length(tmp)>1){
        name=tmp[2]
      }else{
        name=""
      }
      cat("File=",str,",Name=",name,"\n",sep="")
      if(nchar(name)>0){
        tmp=paste(head,path,"/",str,'">',name,tail,sep="")
        cmdL=c(cmdL,tmp)
      }
    }
  }
  tmp=paste('    <tr><td align="center" width="80"></td></tr>',sep="")
  cmdL=c(cmdL,tmp)
  tmp=paste("</table></br>",sep="")
  cmdL=c(cmdL,tmp)
  if(str=="end"){break} #190618
  if(str=="next"){str=""} #190618
}

for(cmd in cmdL){
  cat(cmd,file=wfile,append=T)
  cat('\n',file=wfile,append=T)
}
cat("\n",file=wfile,append=T)
if(fileflg==1){
  for(nn in Looprange(1,length(Tails))){
    cat(Tails[nn],"\n",file=wfile,sep="",append=T)
  }
}else{
  cat("</body>\n",file=wfile,append=T)
  cat("</html>\n",file=wfile,append=T)
}
