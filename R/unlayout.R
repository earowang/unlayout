#' Make HTML widgets draggable
#'
#' @param ... HTML widgets.
#'
#' @importFrom htmltools tags tagList browsable
#'
#' @export
#' @examples
#' library(plotly)
#' p1 <- plot_ly(economics, x = ~ pop, width = 350)
#' p2 <- plot_ly(economics, x = ~ date, y = ~ pop, height = 240, width = 600)
#' p3 <- plot_ly(z = ~ volcano)
#' unlayout(p1, p2, p3)
unlayout <- function(...) {
  lst <- list(...)
  prefix <- "interact-"
  id <- paste(format(as.hexmode(sample(256, 4, replace = TRUE) - 1), width = 2),
    collapse = "")
  div_lst <- tags$div(
    id = paste0(prefix, id),
    lapply(lst, function(x) tags$div(class = "interactable-item", x))
  )
  out <- tagList(
    interact_js(),
    div_lst
  )
  browsable(out)
}

interact_js <- function(width = 0, height = 0, elementId = NULL) {
  # create widget
  htmlwidgets::createWidget(
    name = 'interact',
    x = NULL,
    width = width,
    height = height,
    package = 'unlayout',
    elementId = elementId
  )
}
