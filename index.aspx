<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Mail" %>
<script language="c#" runat="server">
    private void btnSend_Click(object sender, System.EventArgs e)
    {
        Response.Write("<br/>");

        // check fields
        bool check = false;
        try {
            if(String.IsNullOrEmpty(txtMailServer.Text)) {
                throw new System.Exception("Mail server is not set");
            }
            if (String.IsNullOrEmpty(txtMailServerPort.Text)) {
                throw new System.Exception("Server Port is not set");
            }
            if (String.IsNullOrEmpty(txtPass.Text)) {
                throw new System.Exception("Password is not set");
            }
            if (String.IsNullOrEmpty(txtFrom.Text)) {
                throw new System.Exception("Mail from field is not set");
            }
            if (String.IsNullOrEmpty(txtTo.Text)) {
                throw new System.Exception("Mail to field is not set");
            }

            check = true;
        }
        catch (Exception ex)
        {
            Response.Write("<h2 class='t-center error-color'>Error! Check your data and retry</h2>");
            Response.Write("<h3 class='t-center error-color'>" + ex.Message + "</h3>");
            check = false;
            //Response.End();
            //throw ex;
        }


        if (check) {
            try {
                MailMessage m = new MailMessage();
                SmtpClient sc = new SmtpClient();
                m.From = new MailAddress(txtFrom.Text);
                m.To.Add(txtTo.Text);
                m.Subject = "This is a test | World is Awesome .fun";
                m.IsBodyHtml = true;
                m.Body = "This is a sample message using SMTP authentication.";
                m.Body += "<br/><br/> <em>By World is Awesome .fun</em>";
                sc.Host = txtMailServer.Text;
                string str1 = "gmail.com";
                string str2 = txtFrom.Text.ToLower();

                if (txtMailServerPort.Text != null && txtMailServerPort.Text != "") {
                    sc.Port = int.Parse(txtMailServerPort.Text);
                } else {
                    if (str2.Contains(str1)) {
                        sc.Port = 587;
                        sc.EnableSsl = true;
                    }
                    else {
                        sc.Port = 25;
                        sc.EnableSsl = false;
                    }
                }

                sc.Credentials = new System.Net.NetworkCredential(txtFrom.Text, txtPass.Text);
                sc.Send(m);
                Response.Write("<h1 class='t-center success-color'>Email Send successfully</h1>");
            }
            catch (Exception ex)
            {
                Response.Write("<h2 class='t-center error-color'>Something went wrong! Check your data and retry</h2>");
                Response.Write("<h3 class='t-center error-color'>If you are using gmail smtp to send email for the first time, please refer to this KB to setup your gmail account.</h3>");
                Response.Write("<p class='t-center error-color'>" + ex.Message + "</p>");
                //Response.End();
                //throw ex;
            }
        }

        Response.Write("<br/><br/>");
    }
</script>

<html lang="EN">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="theme-color" content="#6cb958">

    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="mask-icon" href="http://smtptester.worldisawesome.fun/images/logo_icon.svg" color="#6cb958">
    <link rel="icon" type="image/svg+xml" href="http://smtptester.worldisawesome.fun/images/logo_icon.svg">
    <link rel="alternate icon" type="image/png" href="http://smtptester.worldisawesome.fun/images/logo_icon.png">
    
    <title>SMTPTester | World is Awesome .fun</title>
    <meta name="description"
        content="Tester SMTP of World is Awesome .fun online! Check if your SMTP can send mails!" />
    <meta name="keywords"
        content="SMTP, Mail, mail tester, test mail, World is Awesome, World is Awesome .fun, World, Awesome, fun, wia, wia.fun, wia fun">
    <meta name="author" content="World is Awesome .fun">
    <meta name="language" content="ES">

    <link rel="manifest" href="/site.webmanifest">
    <link href="/lib/font_nunito/Nunito.css" rel="stylesheet">

    <link rel="stylesheet" href="/css/style_material.css">
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>

    <header>
        <h4 class="mb-0">Powered by</h4>
        <a href="https://www.worldisawesome.fun/" title="World is Awesome .fun" id="home-logo">
            <img src="/images/wia_logo_icon_text.svg" alt="logo" title="World is Awesome .fun" class="icon theme-light" />
            <img src="/images/wia_logo_icon_text_light.svg" alt="logo" title="World is Awesome .fun" class="icon theme-dark" />
        </a>
    </header>

    <div class="article-container" id="smtp-form-popup">
        <form class="article" id="MailForm" method="post" runat="server">
            <div class="article-header d-flex align-items">
                <img src="/images/logo_icon.svg" title="Smtp Tester logo" class="article-icon" alt="logo">
                <h2 class="flex-auto article-title">SMTP Tester!</h2>
            </div>
            <div class="article-body">
                <small class="article-description">Check here if your SMTP Works!</small>

                <small id="smtp-error" class="d-block error-color"></small>

                <div class="input-container">
                    <div class="d-flex align-items">
                        <div class="flex-auto">
                            <label ID="EmailServer" class="label" for="txtMailServer" runat="server">Email Server:
                            </label>
                            <asp:TextBox ID="txtMailServer" class="input" placeholder="mail.yourDomain.com" runat="server">
                            </asp:TextBox>
                        </div>
                        <span class="m-05"></span>
                        <div class="w-auto">
                            <label ID="EmailServerPort" class="label" for="txtMailServerPort" runat="server">Port:
                            </label>
                            <asp:TextBox ID="txtMailServerPort" class="input" placeholder="25" type="number" Text="25" min="0" max="65535" onfocus="this.select()" runat="server">
                            </asp:TextBox>
                        </div>
                    </div>
                    <small class="hint">Make sure your domain resolves to our mail server. The default port is 25, but some smtp servers use a custom port (example: 587)</small>
                </div>
                
                <div class="input-container">
                    <label ID="lblPass" class="label" for="txtPass" runat="server">Email Password:
                    </label>
                    <asp:TextBox ID="txtPass" class="input" placeholder="password" runat="server" TextMode="Password">
                    </asp:TextBox>
                </div>
                <div class="input-container">
                    <label ID="Label1" class="label" for="txtFrom" runat="server">From Email Address:
                    </label>
                    <asp:TextBox ID="txtFrom" class="input" placeholder="admin@yourDomain.com" runat="server">
                    </asp:TextBox>
                </div>
                <div class="input-container">
                    <label ID="Label2" class="label" for="txtTo" runat="server">Recipient Email Address:
                    </label>
                    <asp:TextBox ID="txtTo" class="input" placeholder="mail@mail.it" runat="server"></asp:TextBox>
                    <small class="hint">Make sure this mail is correct. It doesn t throw error if doesn t exist</small>
                </div>
            </div>
            <div class="article-footer">
                <asp:Button type="submit" ID="btnSend" class="button success" runat="server" Text="Submit" OnClick="btnSend_Click">
                </asp:Button>
                <Button type="reset" ID="btnReset" class="button" OnClick="this.form.reset(); return false;">Reset</Button>
            </div>
        </form>
    </div>

    <footer>
        <div>v. <b id="app-version">1.0.2</b></div>
    </footer>
</body>

</html>