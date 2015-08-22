---
---

document.addEventListener "DOMContentLoaded", ->
  addCommas = (n) ->
    n.toString().replace /(\d)(?=(\d{3})+($|,|\.))/g, "$1,"

  for btn in document.querySelectorAll("[data-github-btn]")
    repo = btn.getAttribute "data-github-btn"

    button = document.createElement "a"
    button.href = "https://github.com/#{repo}"
    button.target = "_blank"
    button.appendChild document.createElement("span")
    button.appendChild document.createTextNode("Star")

    btn.className += " github-btn"
    btn.appendChild button

    xhr = new XMLHttpRequest()
    xhr.addEventListener "load", ->
      json = JSON.parse this.responseText
      counter = document.createElement "a"
      counter.href = "https://github.com/#{repo}/stargazers"
      counter.target = "_blank"
      counter.appendChild document.createTextNode(addCommas(json.stargazers_count))
      btn.appendChild counter
    xhr.open("get", "https://api.github.com/repos/#{repo}", true)
    xhr.send()
