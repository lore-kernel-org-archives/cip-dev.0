Return-Path: <SRS0=Znbv=AH=lists.cip-project.org=bounce+64572+4833+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C52DC433DF
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 06:44:27 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD712076E
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 06:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ceISZ466"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD712076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4833+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7vS4YY4521723xBotDJ9io9u; Thu, 25 Jun 2020 23:44:27 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [])
 by mx.groups.io with SMTP id smtpd.web11.2378.1593153863517336676
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 23:44:26 -0700
IronPort-SDR: e2EKIuupGQ130f+W9xaBSL4BtCv+4d53lpUcTDXliatOW/b9E4InwK/c1NzTWrp50bJpe7i5Y+
 +HOzenvqv38g==
X-IronPort-AV: E=Sophos;i="5.75,282,1589221800"; 
   d="scan'208,217";a="4552710"
X-Received: from unknown (HELO TOSBLRMBX0219.TOSHIBA-TSIP.COM) ([172.28.80.119])
  by peak.toshiba-tesi.com with ESMTP; 26 Jun 2020 12:44:55 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 26 Jun 2020 12:14:18 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM ([::1]) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM ([fe80::8d35:f069:2af2:deff%9]) with mapi id
 15.01.1847.003; Fri, 26 Jun 2020 12:14:18 +0530
From: "venkata" <venkata.pyla@toshiba-tsip.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
Subject: [cip-dev][isar-cip-core PATCH 2/6] Disable GitLab CI
Thread-Topic: [cip-dev][isar-cip-core PATCH 2/6] Disable GitLab CI
Thread-Index: AdZLhR9N3HRF1IsjTvOpPSfI6NF1jA==
Date: Fri, 26 Jun 2020 06:44:17 +0000
Message-ID: <fd8d5d11822a48c9ad54f39d27f2d91d@toshiba-tsip.com>
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
X-Gm-Message-State: 92yi1dHjef8uk6zyZEMB4ehBx4520388AA=
Content-Type: multipart/mixed; boundary="lRyb9LIrXRJL22XWQMa8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593153867;
 bh=eX5/CJ9VLgHTrR1Y0cX/yKY7zYEBNQ4S1ifkEDKy0gE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ceISZ466AAAbSoJMaWE/X/+a3THvGMCGVY24Y3R43yiW0AdUFdEkuxooJuw4sFWXv20
 3xlP6+VADFkEFW8PaBO4D+f4xm1fW2Xgwm8TCZJfktq0wnEW0qtFYJMOE9X1wMXI0W5N7
 4wJkZflLcy58ekw8imG1BIQ3FBjiOhVVtmE=

--lRyb9LIrXRJL22XWQMa8
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_fd8d5d11822a48c9ad54f39d27f2d91dtoshibatsipcom_"

--_000_fd8d5d11822a48c9ad54f39d27f2d91dtoshibatsipcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Kazuhiro Hayashi kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hay=
ashi@toshiba.co.jp>

This experimental branch is assumed not to be associated with CIP GitLab

Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
.gitlab-ci.yml | 29 -----------------------------
1 file changed, 29 deletions(-)
delete mode 100644 .gitlab-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
deleted file mode 100644
index 523e759..0000000
--- a/.gitlab-ci.yml
+++ /dev/null
@@ -1,29 +0,0 @@
-image: kasproject/kas-isar:1.1
-
-variables:
-  GIT_STRATEGY: clone
-
-all:
-  stage: build
-  script:
-    - export http_proxy=3D$HTTP_PROXY
-    - export https_proxy=3D$HTTPS_PROXY
-    - export ftp_proxy=3D$FTP_PROXY
-    - export no_proxy=3D$NO_PROXY
-    - export AWS_ACCESS_KEY_ID=3D$AWS_ACCESS_KEY_ID
-    - export AWS_SECRET_ACCESS_KEY=3D$AWS_SECRET_ACCESS_KEY
-
-    - kas build kas.yml:board-simatic-ipc227e.yml:opt-rt.yml:opt-targz-img=
.yml
-    - scripts/deploy-cip-core.sh buster simatic-ipc227e
-
-    - sudo rm -rf build/tmp
-    - kas build kas.yml:board-bbb.yml:opt-rt.yml:opt-targz-img.yml
-    - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb
-
-    - sudo rm -rf build/tmp
-    - kas build kas.yml:board-iwg20m.yml:opt-rt.yml:opt-targz-img.yml
-    - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.d=
tb
-
-    - sudo rm -rf build/tmp
-    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml:opt-targz-img.yml
-    - scripts/deploy-cip-core.sh buster hihope-rz2gm r8a774a1-hihope-rzg2m=
-ex.dtb
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

--_000_fd8d5d11822a48c9ad54f39d27f2d91dtoshibatsipcom_
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
<p class=3D"MsoNormal">From: Kazuhiro Hayashi <a href=3D"mailto:kazuhiro3.h=
ayashi@toshiba.co.jp">
kazuhiro3.hayashi@toshiba.co.jp</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This experimental branch is assumed not to be associ=
ated with CIP GitLab<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Kazuhiro Hayashi &lt;kazuhiro3.hayash=
i@toshiba.co.jp&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">.gitlab-ci.yml | 29 -----------------------------<o:=
p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 29 deletions(-)<o:p></o:p></p>
<p class=3D"MsoNormal">delete mode 100644 .gitlab-ci.yml<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<o:p></o=
:p></p>
<p class=3D"MsoNormal">deleted file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 523e759..0000000<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/.gitlab-ci.yml<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1,29 &#43;0,0 @@<o:p></o:p></p>
<p class=3D"MsoNormal">-image: kasproject/kas-isar:1.1<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-variables:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; GIT_STRATEGY: clone<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-all:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; stage: build<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; script:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - export http_proxy=3D$HTTP_PROX=
Y<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - export https_proxy=3D$HTTPS_PR=
OXY<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - export ftp_proxy=3D$FTP_PROXY<=
o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - export no_proxy=3D$NO_PROXY<o:=
p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - export AWS_ACCESS_KEY_ID=3D$AW=
S_ACCESS_KEY_ID<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - export AWS_SECRET_ACCESS_KEY=
=3D$AWS_SECRET_ACCESS_KEY<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - kas build kas.yml:board-simati=
c-ipc227e.yml:opt-rt.yml:opt-targz-img.yml<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - scripts/deploy-cip-core.sh bus=
ter simatic-ipc227e<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - sudo rm -rf build/tmp<o:p></o:=
p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - kas build kas.yml:board-bbb.ym=
l:opt-rt.yml:opt-targz-img.yml<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - scripts/deploy-cip-core.sh bus=
ter bbb am335x-boneblack.dtb<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - sudo rm -rf build/tmp<o:p></o:=
p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - kas build kas.yml:board-iwg20m=
.yml:opt-rt.yml:opt-targz-img.yml<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - scripts/deploy-cip-core.sh bus=
ter iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - sudo rm -rf build/tmp<o:p></o:=
p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - kas build kas.yml:board-rzg2m.=
yml:opt-rt.yml:opt-targz-img.yml<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; - scripts/deploy-cip-core.sh bus=
ter hihope-rz2gm r8a774a1-hihope-rzg2m-ex.dtb<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.20.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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

--_000_fd8d5d11822a48c9ad54f39d27f2d91dtoshibatsipcom_--

--lRyb9LIrXRJL22XWQMa8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4833): https://lists.cip-project.org/g/cip-dev/message=
/4833
Mute This Topic: https://lists.cip-project.org/mt/75119564/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--lRyb9LIrXRJL22XWQMa8--
