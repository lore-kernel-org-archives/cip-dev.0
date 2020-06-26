Return-Path: <SRS0=/qYe=AH=lists.cip-project.org=bounce+64572+4832+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552EEC433E0
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 06:44:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06982076E
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 06:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="u87MksUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06982076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4832+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id i7B7YY4521723xeyiwzpw40s; Thu, 25 Jun 2020 23:44:25 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web11.2378.1593153863517336676
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 23:44:24 -0700
IronPort-SDR: 4PDEdIZSi9W2tPocq29MGV3KoO2QdI3Pnx8YYvjHuT46OdE90L8a/qMIi9k8S4qT4dvl5xpsvA
 7vl67Hs6+GSg==
X-IronPort-AV: E=Sophos;i="5.75,282,1589221800"; 
   d="scan'208,217";a="4552709"
X-Received: from unknown (HELO TOSBLRMBX0219.TOSHIBA-TSIP.COM) ([172.28.80.119])
  by peak.toshiba-tesi.com with ESMTP; 26 Jun 2020 12:44:53 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 26 Jun 2020 12:14:16 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM ([::1]) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM ([fe80::8d35:f069:2af2:deff%9]) with mapi id
 15.01.1847.003; Fri, 26 Jun 2020 12:14:16 +0530
From: "venkata" <venkata.pyla@toshiba-tsip.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
Subject: [cip-dev][isar-cip-core PATCH 1/6] opt-security.yml: Sample settings to install security
Thread-Topic: [cip-dev][isar-cip-core PATCH 1/6] opt-security.yml: Sample
 settings to install security
Thread-Index: AdZLgw09VZScIMwHQ0+wrCRdhfQsyg==
Date: Fri, 26 Jun 2020 06:44:16 +0000
Message-ID: <3ec242c02a3948fe9194df2517cbe0ad@toshiba-tsip.com>
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
X-Gm-Message-State: aY6EjWwLZcXLm7H5Ft7PD7Gnx4520388AA=
Content-Type: multipart/mixed; boundary="JBXqhl3X41U1GG1xPIff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593153865;
 bh=sKaX3DtRT6I1IAZ2u3tc5L0XDrcZiL31081yZeWUmJY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=u87MksUYpeZjfplWfiB4maXMBNjMM9hcDv5+N3gMVT0UPl17fAwPSEFWQGCvVg5O/V2
 9JFkX9C/3PDKAcMgZoavUbJkudnPfdQeGzLjlSWDLkhm3AT7A2d6kREvkd+fIfTrvUdnP
 fp2jRbVUxBvSOKkMt5fSGbUt7nKkoeofc9Y=

--JBXqhl3X41U1GG1xPIff
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_3ec242c02a3948fe9194df2517cbe0adtoshibatsipcom_"

--_000_3ec242c02a3948fe9194df2517cbe0adtoshibatsipcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Kazuhiro Hayashi kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hay=
ashi@toshiba.co.jp>

opt-security.yml: Sample settings to install security
packages

Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
SECURITY.md      | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
opt-security.yml | 34 +++++++++++++++++++++++++++++++
2 files changed, 86 insertions(+)
create mode 100644 SECURITY.md
create mode 100644 opt-security.yml

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 0000000..a8bccc7
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,52 @@
+How to customize images for security features
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This is the "temporal" document about how to create and use
+the CIP Core generic profile images for security feature evaluation.
+
+Official manuals
+----------------
+
+* isar-cip-core: https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/R=
EADME.md
+* ISAR User Manual: https://github.com/ilbers/isar/blob/master/doc/user_ma=
nual.md
+
+Assumed environment
+-------------------
+
+* isar-cip-core: master branch
+* Host: Debian 10 buster amd64
+    * Installed packages: `docker-ce`, `qemu-system`
+    * Users who does the following actions must be in the groups `docker` =
and `kvm`
+
+Create kas file
+---------------
+
+Create a kas file named `opt-security.yml` to add security settings.
+
+Add security packages to rootfs
+-------------------------------
+
+Set `IMAGE_PREINSTALL` to the list of packages required to enable
+the security features. This variable can be set through the kas file.
+
+Example:
+
+```
+local_conf_header:
+  security: |
+    IMAGE_PREINSTALL =3D "openssl"
+```
+
+Build images
+------------
+
+Build images for QEMU x86 64bit machine:
+
+    $ ./kas-docker --isar build kas.yml:board-qemu-amd64.yml:opt-security.=
yml
+
+Run on QEMU
+-----------
+
+Run the generated images on QEMU (x86 64bit).
+
+    $ ./start-qemu.sh amd64
diff --git a/opt-security.yml b/opt-security.yml
new file mode 100644
index 0000000..7c6b39c
--- /dev/null
+++ b/opt-security.yml
@@ -0,0 +1,34 @@
+#
+# KAS configuration for CIP Core generic profile to enable security featur=
es
+#
+# Copyright (c) Toshiba Corporation, 2020
+#
+# Authors:
+#  Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+local_conf_header:
+  security: |
+    # TODO: Add sudo or sudo-ldap
+    IMAGE_PREINSTALL =3D "\
+      openssl libssl1.1 \
+      fail2ban \
+      openssh-server openssh-sftp-server openssh-client \
+      syslog-ng-core syslog-ng-mod-journal \
+      aide aide-common \
+      libnftables0 nftables \
+      libpam-pkcs11 \
+      chrony \
+      tpm2-tools \
+      tpm2-abrmd \
+      libtss2-esys0 libtss2-udev \
+      libpam-cracklib \
+      acl \
+      libauparse0 audispd-plugins auditd \
+      uuid-runtime \
+    "
\ No newline at end of file
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

--_000_3ec242c02a3948fe9194df2517cbe0adtoshibatsipcom_
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
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
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
<p class=3D"MsoNormal">opt-security.yml: Sample settings to install securit=
y<o:p></o:p></p>
<p class=3D"MsoNormal">packages<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Kazuhiro Hayashi &lt;kazuhiro3.hayash=
i@toshiba.co.jp&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">SECURITY.md&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 52 &#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">opt-security.yml | 34 &#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 86 insertions(&#43;)<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 SECURITY.md<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 opt-security.yml<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/SECURITY.md b/SECURITY.md<o:p></o:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 0000000..a8bccc7<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/SECURITY.md<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -0,0 &#43;1,52 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;How to customize images for security features<o=
:p></o:p></p>
<p class=3D"MsoNormal">&#43;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;This is the &quot;temporal&quot; document about=
 how to create and use<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;the CIP Core generic profile images for securit=
y feature evaluation.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Official manuals<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;----------------<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;* isar-cip-core: https://gitlab.com/zuka0828/is=
ar-cip-core/-/blob/master/README.md<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;* ISAR User Manual: https://github.com/ilbers/i=
sar/blob/master/doc/user_manual.md<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Assumed environment<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;-------------------<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;* isar-cip-core: master branch<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;* Host: Debian 10 buster amd64<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; * Installed packages: `docke=
r-ce`, `qemu-system`<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; * Users who does the followi=
ng actions must be in the groups `docker` and `kvm`<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Create kas file<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;---------------<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Create a kas file named `opt-security.yml` to a=
dd security settings.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Add security packages to rootfs<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;-------------------------------<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Set `IMAGE_PREINSTALL` to the list of packages =
required to enable<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;the security features. This variable can be set=
 through the kas file.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Example:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;```<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;local_conf_header:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp; security: |<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; IMAGE_PREINSTALL =3D &quot;o=
penssl&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;```<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Build images<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;------------<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Build images for QEMU x86 64bit machine:<o:p></=
o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; $ ./kas-docker --isar build =
kas.yml:board-qemu-amd64.yml:opt-security.yml<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Run on QEMU<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;-----------<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Run the generated images on QEMU (x86 64bit).<o=
:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; $ ./start-qemu.sh amd64<o:p>=
</o:p></p>
<p class=3D"MsoNormal">diff --git a/opt-security.yml b/opt-security.yml<o:p=
></o:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 0000000..7c6b39c<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/opt-security.yml<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -0,0 &#43;1,34 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;# KAS configuration for CIP Core generic profil=
e to enable security features<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;# Copyright (c) Toshiba Corporation, 2020<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&#43;#<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;# Authors:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#&nbsp; Kazuhiro Hayashi &lt;kazuhiro3.hayashi@=
toshiba.co.jp&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;# SPDX-License-Identifier: MIT<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;header:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp; version: 8<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;local_conf_header:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp; security: |<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; # TODO: Add sudo or sudo-lda=
p<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; IMAGE_PREINSTALL =3D &quot;\=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openssl libssl1.=
1 \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fail2ban \<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openssh-server o=
penssh-sftp-server openssh-client \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; syslog-ng-core s=
yslog-ng-mod-journal \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;aide aide-common=
 \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnftables0 nft=
ables \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libpam-pkcs11 \<=
o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chrony \<o:p></o=
:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tpm2-tools \<o:p=
></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tpm2-abrmd \<o:p=
></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libtss2-esys0 li=
btss2-udev \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libpam-cracklib =
\<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acl \<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libauparse0 audi=
spd-plugins auditd \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-runtime \<o=
:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">\ No newline at end of file<o:p></o:p></p>
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

--_000_3ec242c02a3948fe9194df2517cbe0adtoshibatsipcom_--

--JBXqhl3X41U1GG1xPIff
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4832): https://lists.cip-project.org/g/cip-dev/message=
/4832
Mute This Topic: https://lists.cip-project.org/mt/75119562/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--JBXqhl3X41U1GG1xPIff--
