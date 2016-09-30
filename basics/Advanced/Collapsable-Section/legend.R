
some_svg <- HTML(paste0(
  '<svg width="100" height="100">',
    '<g transform="translate(40,40)">',
  '<circle r="20" stroke="black" fill="white"></circle> <text dx="-30" dy="40">333333333</text>',
  '</g>',
  '</svg>')
)






semi_circle_column <- function(width, colour){
  paste0(
    '<div class="col-md-',width,'">',
    '<center>',
    # '<svg height="50" width="100">
    # <circle cx="50" cy="50" r="40" stroke="black" stroke-width="3" fill=',colour,' />
    # </svg>',
    '<svg>
  <defs>
    <clipPath id="cut-off-bottom">
      <rect x="0" y="0" width="100" height="100" />
    </clipPath>
  </defs>
    <circle cx="50" cy="100" r="50" clip-path="url(#cut-off-bottom)" stroke="black" stroke-width="3" fill=',colour,'/>
      </svg>',
    
    '</center>',
    '</div>'
  )
}

semi_circle_label_column <- function(width, label){
  paste0(
    '<div class="col-md-',width,'">',
    '<center>',
    label,
    '</center>',
    '</div>'
  )
}

colour_legend <- HTML(
  paste0(
    '<div class="row">',
    # '<div class="col-md-2">',
    # '</div>',
    paste0(unlist(lapply(colour_list, function(colour) semi_circle_column(2, colour))),collapse = ''),
    # '<div class="col-md-1">',
    # '</div>',
    '</div>',
    '<div class="row">',
    # '<div class="col-md-2">',
    # '</div>',
    paste0(unlist(lapply(category_list, function(category) semi_circle_label_column(2, category))),collapse = ''),
    # '<div class="col-md-1">',
    # '</div>',
    '</div>'
  ))