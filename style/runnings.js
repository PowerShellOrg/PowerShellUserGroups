
/* this header doesn't do anything */

exports.header = {
    height: "1cm",
    contents: function() {
        return "<div style='padding = 20px 10px;text-align: right;'></div><br>"
       
    }
}

exports.footer = {
    height: "1cm",
    contents: function(pageNum, numPages) {
        return "<HR><div style= 'font-size: 18px; margin: 0 auto;text-align: center;'> page " + pageNum + " of " + numPages + "</div>" 
      /*return "<HR><div class='footer'>page " + pageNum + " of " + numPages + "</div>"*/

    }
}


/**
 * header and footer might be of format specified in http://phantomjs.org/api/webpage/property/paper-size.html
 *
 * Example:
 *  {
 *    height: "1cm",
 *    contents: function(pageNum, numPages) {
 *      return "<h1>Header <span style='float:right'>" + pageNum + " / " + numPages + "</span></h1>"
 *    }
 *  }
 */