import Tagify from "@yaireo/tagify"

['turbo:load', 'turbo:render'].forEach((eventType) => {
  document.addEventListener(eventType, () => {
    let input = document.querySelector('#post_tag_list')
    let tagify = new Tagify(input, { whitelist:[],
                                     delimiters: " ",
                                     originalInputValueFormat: valuesArr => valuesArr.map(item => item.value).join(' ') })
    let controller;

    tagify.on('input', onInput)

    function onInput(e){
      let value = e.detail.value
      tagify.whitelist = null
      controller && controller.abort()
      controller = new AbortController()
      tagify.loading(true)
      fetch('/search_tags' + `?q=${value}`, {signal:controller.signal})
        .then(res => res.json())
        .then(function(newWhitelist){
          tagify.whitelist = newWhitelist
          tagify.loading(false).dropdown.show(value)
        }
      )
    }
  })
})