"use strict"

function pagination_link(page_num) {
  var url = this.page.base
  if (page_num > 1) {
    url += (this.config.pagination_dir + "/%d/").replace("%d", page_num)
  }
  return this.url_for(url)
}

hexo.extend.helper.register("prev_page_link", function () {
  return pagination_link.call(this, this.page.current - 1)
})

hexo.extend.helper.register("next_page_link", function () {
  return pagination_link.call(this, this.page.current + 1)
})

hexo.extend.helper.register("page_title", function (options) {
  options = options || {}
  var title = this.page.title

  if (this.is_archive()) {
    title = "Archives"

    if (this.is_month()) {
      title += ": " + this.page.year + "/" + this.page.month
    } else if (this.is_year()) {
      title += ": " + this.page.year
    }
  } else if (this.is_category()) {
    title = "Category: " + this.page.category
  } else if (this.is_tag()) {
    title = "Tag: " + this.page.tag
  }

  if (options.include_site_title) {
    if (title) {
      title += " | " + this.config.title
    } else {
      title = this.config.title
    }
  }

  return title
})
