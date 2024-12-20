# library(tidyr)
# library(readr)
# library(dplyr)
# library(stringr)
# library(ggplot2)
# library(ggrepel)
# library(scales)
# library(purrr)
# library(zoo)
# library(lubridate)
# library(sf)
# library(png)
# library(grid)
# library(gridExtra)
# library(magick)
# library(cowplot)
# library(readxl)
# library(httr)
# library(xml2)
# library(tidycensus)
# library(RSocrata)
# library(ggtext)
# library(showtext)
# library(RSocrata)
# library(janitor)
### ^Are all of these necessary?

# font_add_google("Source Sans 3")
# logo_raw <- image_read("Investopedia and NY1 logo.png")
# showtext_auto()


### GROUPED BAR ###
# nyc_rent_leverage_df <- tibble(
#   measure = c("Percent Discounted", "Percent Discounted", 
#               "Percent With Concessions", "Percent With Concessions",
#               "Percent Vacant", "Percent Vacant"),
#   period = c("Pandemic Peak", "Oct. '24", 
#              "Pandemic Peak", "Oct. '24",
#              "Pandemic Peak", "Oct. '24"),
#   pct = c(0.293333333333333, 0.203333333333333, 
#           0.346666666666667, 0.17,
#           0.056949938, 0.033376102),
#   pct_label = map_chr(pct, ~paste0(round(.x * 100, 1), "%"))
# )
# 
# nyc_rent_leverage_plt <- ggplot(nyc_rent_leverage_df, aes(x = measure, y = pct, fill = period)) +
#   geom_col(position = "dodge") + 
#   expand_limits(y = c(0, .4)) +
#   scale_fill_manual(values = c("#2c40d0", "#ffb56b")) + 
#   geom_text(aes(label = pct_label), vjust = -.5, color = "black", size = 80,
#             fontface = "bold", family = "Source Sans 3", position = position_dodge(.9)) +
#   geom_hline(yintercept = 0, color = "black", linewidth = 3) + 
#   scale_y_continuous(labels = label_percent(scale = 100), expand = expansion(mult = c(0, .1))) +
#   labs(title = "Measure of Renter to Landlord Leverage in NYC",
#        subtitle = "Peak Pandemic & Oct. '24",
#        caption = "Source: Apartment List & StreetEasy.\nData are 3-month moving average.") +
#   theme_classic() +
#   theme(text = element_text(family = "Source Sans 3"),
#         legend.position = "top",
#         legend.title = element_blank(),
#         legend.text = element_text(size = 133, face = "bold"),
#         plot.title = element_text(face = "bold", size = 200),
#         plot.subtitle = element_text(size = 172, margin = margin(t = 10, b = 25)),
#         axis.text.x = element_text(size = 150, face = "bold", margin = margin(t = 10, b = 10)),
#         axis.text.y = element_text(size = 150, face = "bold"),
#         axis.title = element_blank(),
#         plot.caption = element_text(size = 90, lineheight = 0.3),
#         plot.margin = margin(t = 60, r = 105, b = 115, l = 60, unit = "pt"))
# 
# ggdraw() +
#   draw_plot(nyc_rent_leverage_plt, x = 0, y = 0.07, width = 1, height = 0.93) +
#   draw_image(logo_raw, x = .05, y = 0.08, width = .3, height = .13) -> nyc_rent_leverage_plt_gg_logo
# 
# ggsave(filename = "nyc_rent_leverage_plt_gg_logo.png",
#        plot = nyc_rent_leverage_plt_gg_logo, width = 8800, height = 6200, units = "px",
#        dpi = 300)

### REGULAR BAR ###
# mlb_tix <- tibble(city = c(
#   "Boston Red Sox",
#   "New York Yankees",
#   "Philadelphia Phillies",
#   "New York Mets"
# ),
# cost = c(
#   396.16,
#   376.54,
#   279.87,
#   266.10
# )
# )
# 
# mlb_tix_plt <- ggplot(
#   mlb_tix, aes(x = reorder(city, -cost), y = cost)
# ) + 
#   geom_hline(yintercept = 266.58, color = "black", linetype = 2, linewidth = 2)  +
#   geom_col(fill = c("#2c40d0", "#2c40d0", "#2c40d0", "#ffb56b")) +
#   geom_text(aes(label = label_dollar()(cost), y = cost), vjust = -.9, color = "black", size = 60,
#             family = "Source Sans 3") +
#   scale_y_continuous(labels = label_dollar(scale = 1), expand = expansion(mult = c(0, .1))) +
#   labs(title = "Average Cost of a Day Out at the Park",
#        subtitle = "Includes 4 tickets, hot dogs, sodas, 2 beers & hats & parking",
#        caption = "Source: Team Marketing Report’s 2023 MLB Fan Cost Index") +
#   theme_classic() +
#   theme(text = element_text(family = "Source Sans 3"),
#         legend.position = "none",
#         plot.title = element_text(face = "bold", size = 200),
#         plot.subtitle = element_text(size = 172, margin = margin(t = 10, b = 100)),
#         axis.text.x = element_text(size = 105, face = "bold", margin = margin(t = 10, b = 30)),
#         axis.text.y = element_text(size = 133, face = "bold"),
#         axis.title = element_blank(),
#         plot.caption = element_text(size = 90, margin = margin(t = 20)),
#         plot.margin = margin(t = 60, r = 105, b = 115, l = 60, unit = "pt"))
# 
# ggdraw() +
#   draw_plot(mlb_tix_plt, x = 0, y = 0.07, width = 1, height = 0.93) +
#   draw_image(logo_raw, x = .125, y = 0.08, width = .3, height = .13) -> mlb_tix_plt_gg_logo
# 
# ggsave(filename = "mlb_tix_plt_gg_logo.png",
#        plot = mlb_tix_plt_gg_logo, width = 8000, height = 5800, units = "px",
#        dpi = 300)

### LINE GRAPH ###
# NYC MSA Wages: https://data.bls.gov/dataViewer/view/timeseries/SMU36356200500000003
# NYC Wages: https://fred.stlouisfed.org/series/SMU36935610500000003
# NYC MSA Inflation: https://data.bls.gov/dataViewer/view/timeseries/CUURS12ASA0

# nyc_ahe <- read_csv("SMU36935610500000003.csv",
#                     col_types = "Dd",
#                     col_names = T) %>% 
#   rename(avg_hrly_earn = SMU36935610500000003)
# 
# nyc_msa_cpi <- read_csv("CUURS12ASA0.csv",
#                         col_names = T,
#                         col_types = "ciccd") %>% 
#   mutate(DATE = ymd(paste(Label, "01"))) %>% 
#   select(DATE, Value)
# 
# nyc_ahe_cpi_072020_072024 <- nyc_ahe %>% 
#   inner_join(nyc_msa_cpi, by = "DATE") %>% 
#   filter(DATE >= base::as.Date("2020-07-01")) %>% 
#   mutate(across(-DATE, ~create_index_col(.x, index_type = 0)))
# 
# nyc_ahe_cpi_072020_072024_gg <- ggplot(nyc_ahe_cpi_072020_072024, aes(x = DATE)) +
#   geom_path(aes(y = avg_hrly_earn), linewidth = 8, lineend = "round", color = "#2c40d0") +
#   geom_path(aes(y = Value), linewidth = 8, lineend = "round", color = "#ffb56b") +
#   scale_x_date(date_breaks = "6 months", date_labels = "%b '%y") +
#   scale_y_continuous(labels = label_percent(scale = 1), expand = expansion(mult = c(0, .1))) +
#   labs(title = "NYC Wages Haven't Kept Up With Inflation",
#        subtitle = "Average Hourly Earnings & NYC MSA Inflation July '20 - '24",
#        caption = "Sources: BLS SAE & CPI") +
#   theme_classic() +
#   theme(text = element_text(family = "Source Sans 3"),
#         legend.position = "none",
#         plot.title = element_text(face = "bold", size = 200),
#         plot.subtitle = element_text(size = 172, margin = margin(t = 10, b = 100)),
#         axis.text.x = element_text(size = 133, face = "bold", margin = margin(t = 10, b = 30)),
#         axis.text.y = element_text(size = 133, face = "bold"),
#         axis.title = element_blank(),
#         plot.caption = element_text(size = 90, margin = margin(t = 9)),
#         plot.margin = margin(t = 60, r = 75, b = 115, l = 45, unit = "pt"))
# 
# ggdraw() +
#   draw_plot(nyc_ahe_cpi_072020_072024_gg, x = 0, y = 0.07, width = 1, height = 0.93) +
#   draw_image(logo_raw, x = .1, y = 0.11, width = .3, height = .13) -> nyc_ahe_cpi_072020_072024_gg_logo
# 
# ggsave(filename = "nyc_ahe_cpi_072020_072024_gg_logo.png",
#        plot = nyc_ahe_cpi_072020_072024_gg_logo, width = 8000, height = 5800, units = "px",
#        dpi = 300)


#### TODO:
#### Functionalize each visualization
#### Write CLI input functionality for each of the viz components (data, title, subhead, caption, y-axis data type)
