Return-Path: <SRS0=Y7qk=AH=lists.cip-project.org=bounce+64572+4834+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8E9C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 06:44:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019D0207E8
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 06:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DFuN5Qhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019D0207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4834+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7RLOYY4521723xP0O2np6dgm; Thu, 25 Jun 2020 23:44:27 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web12.2466.1593153866203042705
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 23:44:27 -0700
IronPort-SDR: rGhq8TnJUoRNLHUgY+mqmN7szQ7F+7XnsnTJif0CLJP82XceA1nFLApcIU9S9TzNs8CZ1GMnDR
 PU5fWxFUyC+g==
X-IronPort-AV: E=Sophos;i="5.75,282,1589221800"; 
   d="scan'208,217";a="4552711"
X-Received: from unknown (HELO TOSBLRMBX0319.TOSHIBA-TSIP.COM) ([172.28.80.120])
  by peak.toshiba-tesi.com with ESMTP; 26 Jun 2020 12:44:56 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 26 Jun 2020 12:14:19 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM ([::1]) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM ([fe80::8d35:f069:2af2:deff%9]) with mapi id
 15.01.1847.003; Fri, 26 Jun 2020 12:14:19 +0530
From: "venkata" <venkata.pyla@toshiba-tsip.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
Subject: [cip-dev][isar-cip-core PATCH 3/6] Revert "Disable GitLab CI"
Thread-Topic: [cip-dev][isar-cip-core PATCH 3/6] Revert "Disable GitLab CI"
Thread-Index: AdZLhUgPIeHokcbGQD+OZCk9QrrNgg==
Date: Fri, 26 Jun 2020 06:44:19 +0000
Message-ID: <715201b6cae14119960d8c3091fdd419@toshiba-tsip.com>
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
X-Gm-Message-State: u50F50cW0dznIzfjv03cyKNFx4520388AA=
Content-Type: multipart/mixed; boundary="Y40iAj6k5TvkCRvhAO8j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593153867;
 bh=Zmr3UA2TDxZvA7aKsZCnNAwNHTKfx33FfWtLTAQOhos=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=DFuN5QhvavAjahWrO4h8I3MEHdq88C2/WZjAdkcTKYusCmaU6aqTugZe/EdBoIFqmaI
 UeaY6k2s1alI/NzPapAdrJf2pgb1ibx15CnA8xp/36MVyzA4zffp/ul6QHsKJLGAFRjJZ
 jf/H4gh86kZacJamtYRyWHd012X060BC/AQ=

--Y40iAj6k5TvkCRvhAO8j
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_715201b6cae14119960d8c3091fdd419toshibatsipcom_"

--_000_715201b6cae14119960d8c3091fdd419toshibatsipcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Kazuhiro Hayashi kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hay=
ashi@toshiba.co.jp>

This reverts commit 7a8153fe4ba8127a7d86b6db90f1bbcb0dd73fd7.
---
.gitlab-ci.yml | 29 +++++++++++++++++++++++++++++
1 file changed, 29 insertions(+)
create mode 100644 .gitlab-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 0000000..523e759
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,29 @@
+image: kasproject/kas-isar:1.1
+
+variables:
+  GIT_STRATEGY: clone
+
+all:
+  stage: build
+  script:
+    - export http_proxy=3D$HTTP_PROXY
+    - export https_proxy=3D$HTTPS_PROXY
+    - export ftp_proxy=3D$FTP_PROXY
+    - export no_proxy=3D$NO_PROXY
+    - export AWS_ACCESS_KEY_ID=3D$AWS_ACCESS_KEY_ID
+    - export AWS_SECRET_ACCESS_KEY=3D$AWS_SECRET_ACCESS_KEY
+
+    - kas build kas.yml:board-simatic-ipc227e.yml:opt-rt.yml:opt-targz-img=
.yml
+    - scripts/deploy-cip-core.sh buster simatic-ipc227e
+
+    - sudo rm -rf build/tmp
+    - kas build kas.yml:board-bbb.yml:opt-rt.yml:opt-targz-img.yml
+    - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb
+
+    - sudo rm -rf build/tmp
+    - kas build kas.yml:board-iwg20m.yml:opt-rt.yml:opt-targz-img.yml
+    - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.d=
tb
+
+    - sudo rm -rf build/tmp
+    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml:opt-targz-img.yml
+    - scripts/deploy-cip-core.sh buster hihope-rz2gm r8a774a1-hihope-rzg2m=
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

--_000_715201b6cae14119960d8c3091fdd419toshibatsipcom_
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
<p class=3D"MsoNormal">This reverts commit 7a8153fe4ba8127a7d86b6db90f1bbcb=
0dd73fd7.<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">.gitlab-ci.yml | 29 &#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 29 insertions(&#43;)<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 .gitlab-ci.yml<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<o:p></o=
:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 0000000..523e759<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/.gitlab-ci.yml<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -0,0 &#43;1,29 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;image: kasproject/kas-isar:1.1<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;variables:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp; GIT_STRATEGY: clone<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;all:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp; stage: build<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp; script:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - export http_proxy=3D$HTTP_=
PROXY<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - export https_proxy=3D$HTTP=
S_PROXY<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp; &nbsp;- export ftp_proxy=3D$FTP_PR=
OXY<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - export no_proxy=3D$NO_PROX=
Y<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - export AWS_ACCESS_KEY_ID=
=3D$AWS_ACCESS_KEY_ID<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - export AWS_SECRET_ACCESS_K=
EY=3D$AWS_SECRET_ACCESS_KEY<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - kas build kas.yml:board-si=
matic-ipc227e.yml:opt-rt.yml:opt-targz-img.yml<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - scripts/deploy-cip-core.sh=
 buster simatic-ipc227e<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - sudo rm -rf build/tmp<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - kas build kas.yml:board-bb=
b.yml:opt-rt.yml:opt-targz-img.yml<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - scripts/deploy-cip-core.sh=
 buster bbb am335x-boneblack.dtb<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - sudo rm -rf build/tmp<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp; &nbsp;&nbsp;- kas build kas.yml:board-iw=
g20m.yml:opt-rt.yml:opt-targz-img.yml<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - scripts/deploy-cip-core.sh=
 buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - sudo rm -rf build/tmp<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - kas build kas.yml:board-rz=
g2m.yml:opt-rt.yml:opt-targz-img.yml<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; - scripts/deploy-cip-core.sh=
 buster hihope-rz2gm r8a774a1-hihope-rzg2m-ex.dtb<o:p></o:p></p>
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

--_000_715201b6cae14119960d8c3091fdd419toshibatsipcom_--

--Y40iAj6k5TvkCRvhAO8j
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4834): https://lists.cip-project.org/g/cip-dev/message=
/4834
Mute This Topic: https://lists.cip-project.org/mt/75119566/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Y40iAj6k5TvkCRvhAO8j--
