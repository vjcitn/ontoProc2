
library(shiny)
library(ontoProc2)
learn_uberon = function(regexp="anatom", exclude="^GO:") {
 ubref = retrieve_semsql_conn("uberon")
 uoi = semsql_to_oi(ubref)
 DBI::dbDisconnect(ubref)
 nms = grep(regexp, uoi$name, value=TRUE)
 if (!is.null(exclude)) {
   drop = grep(exclude, names(nms))
   if (length(drop)>0) nms = nms[-drop]
   }
 tmp = names(nms)
 val = tmp
 names(val) = as.character(nms)
 ubapp(val, uoi)
}

ubapp = function(nms, uoi) {
 ui = fluidPage(
  sidebarLayout(
   sidebarPanel(
    helpText("ubapp"),
    helpText("pick a term"),
    radioButtons("nms", "candidates", nms)
   ),
   mainPanel(
    tabsetPanel(
     tabPanel("children",
      dataTableOutput("children")
      ),
     tabPanel("sibs",
      dataTableOutput("sibs")
      ),
     tabPanel("ancestors",
      dataTableOutput("ancestors")
      ),
     tabPanel("plot", plotOutput("plot")),
     tabPanel("about",
      helpText("about ubapp")
      )
     )
    )
   )
  )
  server = function(input, output) {
   sibs = function(x) {
     px = uoi$parents[[x]]
     unlist(uoi$children[unlist(px)])
   }
   output$sibs = renderDataTable({
    ss = sibs(input$nms)
    txt = as.character(unlist(uoi$name[ss]))
    ot = order(txt)
    data.frame(text=txt[ot], tag=ss[ot])
    })
   output$children = renderDataTable({
    chil = uoi$children[[input$nms]]
    validate(need(length(chil)>0, "no children, pick another"))
    txt = as.character(unlist(uoi$name[chil]))
    ot = order(txt)
    data.frame(text=txt[ot], tag=as.character(chil[ot]))
    })   
   output$ancestors = renderDataTable({
    anc = uoi$ancestors[[input$nms]]
    txt = as.character(unlist(uoi$name[anc]))
    data.frame(text=txt, tag=as.character(anc))
    })
   output$plot = renderPlot({
    onto_plot2(uoi, sibs(input$nms))
   })
  }
  runApp(list(ui=ui, server=server))
}
     
    
