Return-Path: <SRS0=4GL5=AH=lists.cip-project.org=bounce+64572+4836+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0FCC433E0
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 06:44:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB7D207E8
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 06:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fb8eEgOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB7D207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4836+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0aMqYY4521723xcesNT7o5cI; Thu, 25 Jun 2020 23:44:57 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web11.2386.1593153895310791692
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 23:44:56 -0700
IronPort-SDR: agyFpT8uTNK+I6N8ciFrpgKrrubunNYI1KfSinCOe50ti6/b55DDHJajdE16fyZEJo9JtqE1ip
 1WHYAcPrW0QA==
X-IronPort-AV: E=Sophos;i="5.75,282,1589221800"; 
   d="scan'208,217";a="4552753"
X-Received: from unknown (HELO TOSBLRMBX0219.TOSHIBA-TSIP.COM) ([172.28.80.119])
  by peak.toshiba-tesi.com with ESMTP; 26 Jun 2020 12:45:31 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 26 Jun 2020 12:14:53 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM ([::1]) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM ([fe80::8d35:f069:2af2:deff%9]) with mapi id
 15.01.1847.003; Fri, 26 Jun 2020 12:14:53 +0530
From: "venkata" <venkata.pyla@toshiba-tsip.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
Subject: [cip-dev][isar-cip-core PATCH 5/6] cip-core-image-security.bb: append security packages to existing 'IMAGE_PREINSTALL'
Thread-Topic: [cip-dev][isar-cip-core PATCH 5/6] cip-core-image-security.bb:
 append security packages to existing 'IMAGE_PREINSTALL'
Thread-Index: AdZLhVk9kGb4Ln1sSqKXGAK78d6ABQ==
Date: Fri, 26 Jun 2020 06:44:53 +0000
Message-ID: <ef0350ec7440482f934dd3d815795096@toshiba-tsip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.80.121]
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: n5X6i5Ahb3RSTlcfLNYD5aOmx4520388AA=
Content-Type: multipart/mixed; boundary="xg6dTqPa7Lw9t6F1aOhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593153897;
 bh=JibcTzo70r95chYKDkijtI0LWV852thRxNnlycwMAS4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=fb8eEgOwMA/frwsXde8s1MmMxQ2u+ELgV1c/pM3vWeLPbS7qauVAwjJP+I1dRLxv2SV
 kZ7oW8lycGaaNjejLrc49H5o086kazOXI/C7DqFS1ql1nopU8Q5Dw2GjFOTEI9u7Y35h1
 fZmk9omacBoT8ehjECAIUcVaC/A0MRQ/4rc=

--xg6dTqPa7Lw9t6F1aOhG
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_ef0350ec7440482f934dd3d815795096toshibatsipcom_"

--_000_ef0350ec7440482f934dd3d815795096toshibatsipcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: venkata pyla venkata.pyla@toshiba-tsip.com<mailto:venkata.pyla@toshib=
a-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
recipes-core/images/cip-core-image-security.bb | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/=
images/cip-core-image-security.bb
index 70571f8..b883414 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -18,7 +18,7 @@ IMAGE_INSTALL +=3D "customizations"
 # Debian packages that provide security features
# TODO: Add sudo or sudo-ldap which conflict each other
-IMAGE_PREINSTALL =3D " \
+IMAGE_PREINSTALL +=3D " \
               openssl libssl1.1 \
               fail2ban \
               openssh-server openssh-sftp-server openssh-client \
--
2.20.1
The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the =

recipient and may contain privileged information. =

If you are not the intended recipient, please notify the
sender and delete the message along with any =

attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail =

are those of the individual sender except where the sender =

specifically states them to be the views of =

Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer =

system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility =

is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.

--_000_ef0350ec7440482f934dd3d815795096toshibatsipcom_
Content-Type: text/html; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">From: venkata pyla <a href=3D"mailto:venkata.pyla@to=
shiba-tsip.com">
venkata.pyla@toshiba-tsip.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: venkata pyla &lt;venkata.pyla@toshiba=
-tsip.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">recipes-core/images/cip-core-image-security.bb | 2 &=
#43;-<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 1 insertion(&#43;), 1 deletion(-)<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/recipes-core/images/cip-core-image-secu=
rity.bb b/recipes-core/images/cip-core-image-security.bb<o:p></o:p></p>
<p class=3D"MsoNormal">index 70571f8..b883414 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/recipes-core/images/cip-core-image-security.bb=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/recipes-core/images/cip-core-image=
-security.bb<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -18,7 &#43;18,7 @@ IMAGE_INSTALL &#43;=3D &quot;c=
ustomizations&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;# Debian packages that provide security featur=
es<o:p></o:p></p>
<p class=3D"MsoNormal"># TODO: Add sudo or sudo-ldap which conflict each ot=
her<o:p></o:p></p>
<p class=3D"MsoNormal">-IMAGE_PREINSTALL =3D &quot; \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;IMAGE_PREINSTALL &#43;=3D &quot; \<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openssl libssl1.1 \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fail2ban \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openssh-server openssh-sftp-server openssh=
-client \<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.20.1<o:p></o:p></p>
</div>
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:107%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{font-family:"Calibri",sans-serif;}
.MsoPapDefault
	{margin-bottom:8.0pt;
	line-height:107%;}
 /* Page Definitions */
 @page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
 /* List Definitions */
 ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>





<div class=3D"WordSection1 ">

<p class=3D"MsoNormal" style=3D"margin-top:2.0pt;margin-right:0in;margin-bo=
ttom:2.0pt;
margin-left:0in;line-height:normal;text-autospace:none"><span  style=3D"fon=
t-family: Times New Roman, serif;"><span style=3D"font-size: 16px;">.</span=
></span></p></body>
</html>

--_000_ef0350ec7440482f934dd3d815795096toshibatsipcom_--

--xg6dTqPa7Lw9t6F1aOhG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4836): https://lists.cip-project.org/g/cip-dev/message=
/4836
Mute This Topic: https://lists.cip-project.org/mt/75119573/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xg6dTqPa7Lw9t6F1aOhG--
