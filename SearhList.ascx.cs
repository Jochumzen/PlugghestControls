using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Plugghest.Modules.PlugghestControls
{
    public partial class SearhList : System.Web.UI.UserControl
    {
        private string[] _keyword;
        public string[] searchInfo
        {
            get
            {
                if (null != Request.Cookies["searchinfo"])
                {
                    _keyword = Convert.ToString(Request.Cookies["searchinfo"].Value).Split('|');
                    return _keyword;
                }
                else
                    return new[] { "", "" };
            }
            set
            {
                _keyword = value;
                if (null == _keyword && null != Request.Cookies["searchinfo"])
                    Request.Cookies["searchinfo"].Expires = DateTime.Now.AddDays(-1);
            }
        }

        private string CurrentLanguage
        {
            get
            {
                return (Page as DotNetNuke.Framework.PageBase).PageCulture.Name;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            populateTableResult();
        }

        private void populateTableResult()
        {
            var _Table = "<table >";
            if (!string.IsNullOrEmpty(this.searchInfo[0]))
                foreach (var temp in new Plugghest.Base2.BaseHandler().Get_SearchResult(this.searchInfo[0]))                
                {
                    var RnC = string.Format("<div class='dcc_rnc_CLSelector' co_type='Q' apppath='' ratingmode='ratings' moduleid='1136' " +
                                            "co_val='qsp:tabid' co_val2='{0}'>" +
                                            "<!-- User customizable content starts -->" +
                                            "<ul>"+
                                            "<li>"+
                                            "<img src='[PRC_AVERAGERATINGIMAGE]' alt='Avg. Rating [PRC_AVERAGERATINGVALUE]' title= 'Avg. Rating [PRC_AVERAGERATINGVALUE]'>" +
                                            "<span style='font-family:Tahoma; font-size:10px; font-weight:bold; color:#000000; white-space:nowrap;'>" +
                                            "[PRC_TOTALRATINGS] Rating(s)" +
                                            "</span>" +
                                            "</li>" +
                                            "</ul>" +
                                            "<!-- User customizable content ends -->" +
                                            "</div>", temp.TabID);
                    _Table += string.Format("<tr class='item'><td>" +
                                            "<div class='media product '>" +
                                                "<div class='price-container right'>" +
                                                    "<div class='left inner-right'>" +
                                                        "<span class='price bold'>$220</span>" +
                                                    "</div>" +
                                                    "<a class='button red large js-present-modal' data-type='purchase' data-arg='9781446209424' href='#purchase,9781446209424'>Purchase</a>" +
                                                "</div>" +
                                                "<figure class='img'>" +
                                                    "<a href='/e-bok/9781446209424/good-essay-writing'>" +
                                                        "<img width='66px' height='97px' src='https://image.bokus.com/images2/9781446209424_small' alt='Good Essay Writing'>" +
                                                    "</a>" +
                                                "</figure>" +
                                                "<div class='bd'>" +
                                                    "<ul class='verticalList no-margin'>" +
                                                        "<li>" +
                                                            "<ul class='booklist-rating'>" +
                                                                "<li class='booklist-top'>" +
                                                                    "<span class='js-ebook-label ebook-label medium'>E-bok</span>" +
                                                                "</li>" +
                                                                "<li class='booklist-top'>" +
                                                                    RnC +
                        //"<p class='rating-text'>Betyg</p>" +
                        //"<ul class='average-star-rating' title='0.0'>" +
                        //    "<li id='average-current-rating' class='average-current-rating' style='width: 0.0px'></li>" +
                        //"</ul>" +
                                                                "</li>" +
                                                                "<li>" +
                                                                    "<p style='padding-top: 4px;'></p>" +
                                                                "</li>" +
                                                            "</ul>" +
                                                            "</br>"+
                                                        "</li>" +
                                                        "<li>" +
                                                            "<h3 class='booklist-title'>" +
                                                                "<a href='{3}'> {0} </a>" +
                                                            "</h3>" +
                                                        "</li>" +
                                                        "<li>" +
                                                            "<h4 class='booklist-author'>Author : " +
                                                                "<a href='/e-bok/författare/Peter Redman, Wendy Maples'>{1}</a>" +
                                                            "</h4>" +
                                                        "</li>" +
                                                        "<li class='description'>" +
                                                            "<div class='expandable js-expandable js-auto-expand'>" +
                                                                "<div class='expandable-content'>{2}</div>" +
                                                                "<div class='expandable-trigger-container'>" +
                                                                    "<div class='expandable-fade'></div>" +
                                                                    "<a class='blue expandable-trigger js-expandable-trigger' href='#toggle'>" +
                                                                        "<span class='expanded-text'>+ View More</span>" +
                                                                        "<span class='collapsed-text'>- View Less</span>" +
                                                                    "</a>" +
                                                                "</div>" +
                                                            "</div>" +
                                                        "</li>" +
                                                    "</ul>" +
                                                "</div>" +
                                            "</div>" +
                                        "</td></tr>",
                                        temp.Title,
                                        temp.Author,
                                        temp.Discription,
                                        DotNetNuke.Common.Globals.NavigateURL(temp.TabID, "", new string[] { "language=" + this.CurrentLanguage }));
                }
            pnlTable.Controls.Add(new LiteralControl(_Table + "</table >"));
            this.searchInfo = null;
        }
    }
}