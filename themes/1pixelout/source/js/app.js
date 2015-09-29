(function () {
  "use strict";

  var commentBox = document.getElementById("js-comment-box");

  if (commentBox) {
    var loadScript = function(src) {
      var s = document.createElement("script");
      s.async = true;
      s.src = src;
      (document.getElementsByTagName("head")[0]).appendChild(s);
    }

    loadScript("//" + disqus_shortname + ".disqus.com/count.js");

    document.getElementById("js-toggle-comments").addEventListener("click", function (e) {
      e.preventDefault();
      commentBox.focus();
      commentBox.classList.add("o-comment-box--is-open");
      loadScript("//" + disqus_shortname + ".disqus.com/embed.js");
    }, false);
  }

})();
