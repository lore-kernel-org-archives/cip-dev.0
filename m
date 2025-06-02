Return-Path: <a-gupta4@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72418C5AD49
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 18:03:47 +0000 (UTC)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 by mx.groups.io with SMTP id smtpd.web11.2077.1748887423445167812
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Jun 2025 11:03:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Ml+PZwcs;
 spf=pass (domain: ti.com, ip: 198.47.23.234, mailfrom: a-gupta4@ti.com)
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552I3g8A234652;
	Mon, 2 Jun 2025 13:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748887422;
	bh=NEkQtAE57rGSKrUL3h72qnSl7iX0T+rVxmGow0gZpHE=;
	h=From:To:CC:Subject:Date;
	b=Ml+PZwcsS6RNBLGarnjvPlAUrWglq3V1Qf2jdElykWrZkiAcbY5E5o2WGxx44/tzj
	 IBqRe/WFHAA60VMELMNYvBJ/NhhBpBezuLm0jtMXkq81OqALJRXUnJWxbWYlx+Xrdm
	 doy92vYR4FCWCaC+szZc3RLwxBG6kIHXn78/y6Xk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552I3gI62972979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 2 Jun 2025 13:03:42 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 13:03:42 -0500
Received: from DFLE112.ent.ti.com ([fe80::d4dd:a09e:396d:a895]) by
 DFLE112.ent.ti.com ([fe80::d4dd:a09e:396d:a895%17]) with mapi id
 15.01.2507.023; Mon, 2 Jun 2025 13:03:42 -0500
From: "Gupta, Ayush" <a-gupta4@ti.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "Adivi, Sai Sree Kartheek"
	<s-adivi@ti.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Secure Data Encryption on board without TPM support ( AM62P)
Thread-Topic: Secure Data Encryption on board without TPM support ( AM62P)
Thread-Index: AdvT6GldKr1rrCM8TXecTWxSCZ7GHQ==
Date: Mon, 2 Jun 2025 18:03:42 +0000
Message-ID: <82039e1a1c384350af46fe375650472c@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.135.104]
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: multipart/alternative;
	boundary="_000_82039e1a1c384350af46fe375650472cticom_"
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Jun 2025 18:03:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18961

--_000_82039e1a1c384350af46fe375650472cticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear CIP Development Team,

I am currently working on enabling encrypted storage for the TI's AM62P pla=
tform, which, as per current hardware capabilities, does not include TPM su=
pport.

To address this, I have implemented a working initramfs-crypt-hook-nontpm (=
link provided at the end)  solution that removes TPM dependencies. It utili=
zes a keyfile embedded directly into the initramfs for unlocking encrypted =
partitions during boot. The initramfs itself is considered secure as it is =
protected by verified boot (Secure Boot is enabled on the platform).

I would like to know if this is an acceptable and secure approach from the =
CIP security perspective for boards without TPM support. Additionally, are =
there any recommended alternatives or best practices for strengthening this=
 method in scenarios where TPM support is not available?

Looking forward to your guidance.



Patch for

initramfs-crypt-hook-nontpm

recipes-initramfs/initramfs-crypt-hook-nontpm * main * 22CSB0C01_AYUSH GUPT=
A / am62x-security-features * GitLab<https://gitlab.com/ag22csb0c01/am62x-s=
ecurity-features/-/tree/main/recipes-initramfs/initramfs-crypt-hook-nontpm?=
ref_type=3Dheads>


Best regards,
Ayush Gupta
Texas Instruments


--_000_82039e1a1c384350af46fe375650472cticom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
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
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:12.0=
pt;font-family:&quot;Segoe UI&quot;,sans-serif">Dear CIP Development Team,<=
br>
<br>
I am currently working on enabling encrypted storage for the TI&#8217;s AM6=
2P platform, which, as per current hardware capabilities, does not include =
TPM support.<br>
<br>
To address this, I have implemented a working initramfs-crypt-hook-nontpm (=
link provided at the end) &nbsp;solution that removes TPM dependencies. It =
utilizes a keyfile embedded directly into the initramfs for unlocking encry=
pted partitions during boot. The initramfs
 itself is considered secure as it is protected by verified boot (Secure Bo=
ot is enabled on the platform).<br>
<br>
I would like to know if this is an acceptable and secure approach from the =
CIP security perspective for boards without TPM support. Additionally, are =
there any recommended alternatives or best practices for strengthening this=
 method in scenarios where TPM support
 is not available?<br>
<br>
Looking forward to your guidance.<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:12.0=
pt;font-family:&quot;Segoe UI&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p=
>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:12.0=
pt;font-family:&quot;Segoe UI&quot;,sans-serif">Patch for
<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:12.0=
pt;font-family:&quot;Segoe UI&quot;,sans-serif">initramfs-crypt-hook-nontpm=
<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><a href=3D"https://gitlab.com=
/ag22csb0c01/am62x-security-features/-/tree/main/recipes-initramfs/initramf=
s-crypt-hook-nontpm?ref_type=3Dheads">recipes-initramfs/initramfs-crypt-hoo=
k-nontpm &middot; main &middot; 22CSB0C01_AYUSH GUPTA
 / am62x-security-features &middot; GitLab</a><span style=3D"font-size:12.0=
pt;font-family:&quot;Segoe UI&quot;,sans-serif"><o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:12.0=
pt;font-family:&quot;Segoe UI&quot;,sans-serif"><br>
<br>
Best regards,<br>
Ayush Gupta<br>
Texas Instruments<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_82039e1a1c384350af46fe375650472cticom_--

