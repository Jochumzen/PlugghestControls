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
        private string _keyword;
        public string searchInfo
        {
            get
            {
                if (null != Request.QueryString["search_keyword"])
                {
                    _keyword = Request.QueryString["search_keyword"];
                    return _keyword;
                }
                else
                    return string.Empty;
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
            populateresult();
        }

        private void populateresult()
        {
            if (string.IsNullOrEmpty(this.searchInfo))
                return;

            rptSearchResult.DataSource = new Plugghest.Base2.BaseHandler().Get_SearchResult(this.searchInfo);
            rptSearchResult.DataBind();
        }

        public string evaluateRedirectURL(int tabid)
        {
            return DotNetNuke.Common.Globals.NavigateURL(tabid, "", new string[] { "language=" + this.CurrentLanguage });
        }
    }
}