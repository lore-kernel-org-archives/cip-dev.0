Return-Path: <SRS0=s263=AH=lists.cip-project.org=bounce+64572+4835+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C28AC433E0
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 06:44:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1515E2076E
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 06:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="k8tGziFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1515E2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4835+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id s6HMYY4521723xLgmPRnq0Qg; Thu, 25 Jun 2020 23:44:41 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web11.2382.1593153880067566133
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 23:44:41 -0700
IronPort-SDR: opu8vlUgneBp5Mnq6Ebn1nVHc/H8qrK298HZaULVw+GcSmPZvEPcamj0olvN8vmaU7Ht0fXuB+
 82ThG0UgUKhA==
X-IronPort-AV: E=Sophos;i="5.75,282,1589221800"; 
   d="scan'208,217";a="4552737"
X-Received: from unknown (HELO TOSBLRMBX0419.TOSHIBA-TSIP.COM) ([10.116.85.28])
  by peak.toshiba-tesi.com with ESMTP; 26 Jun 2020 12:45:16 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0419.TOSHIBA-TSIP.COM (10.116.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 26 Jun 2020 12:14:38 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM ([::1]) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM ([fe80::8d35:f069:2af2:deff%9]) with mapi id
 15.01.1847.003; Fri, 26 Jun 2020 12:14:38 +0530
From: "venkata" <venkata.pyla@toshiba-tsip.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
Subject: [cip-dev][isar-cip-core PATCH 4/6] Use an image recipe to define installed packages instead of kas option
Thread-Topic: [cip-dev][isar-cip-core PATCH 4/6] Use an image recipe to define
 installed packages instead of kas option
Thread-Index: AdZLhVcNSinQl5PfRTyoazF0atL3EA==
Date: Fri, 26 Jun 2020 06:44:38 +0000
Message-ID: <a6a80ffc9357463fb213e8d65a90916e@toshiba-tsip.com>
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
X-Gm-Message-State: HEYWVdMyRLPDgTqSoV3Dvprtx4520388AA=
Content-Type: multipart/mixed; boundary="f4TzODS4258oyDXSiy8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593153881;
 bh=AlTiXYmU0M7b37vuPBXMS9cx4/uGBwCqtPqdq9zhwkA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=k8tGziFWQmpltUMhlYpvTeROAFr67GjEgWvRdXvN8ES5hFm5h3rrQJ5K8zNjA76etO/
 jEVPERVFVIkRwqPTEn49z5QETv8PL8hYxzZka4R6V0MF0uyZoV+mgwvxf+rRhLWD1y7qI
 /+qQsyT5r4eLcQ6oSxtAE3jt7SRMahUzSvA=

--f4TzODS4258oyDXSiy8N
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_a6a80ffc9357463fb213e8d65a90916etoshibatsipcom_"

--_000_a6a80ffc9357463fb213e8d65a90916etoshibatsipcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Kazuhiro Hayashi kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hay=
ashi@toshiba.co.jp>

Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
SECURITY.md                                   | 23 ++++--------
opt-security.yml                              | 34 -----------------
.../images/cip-core-image-security.bb         | 37 +++++++++++++++++++
3 files changed, 45 insertions(+), 49 deletions(-)
delete mode 100644 opt-security.yml
create mode 100644 recipes-core/images/cip-core-image-security.bb

diff --git a/SECURITY.md b/SECURITY.md
index a8bccc7..ddceee5 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -18,31 +18,24 @@ Assumed environment
     * Installed packages: `docker-ce`, `qemu-system`
     * Users who does the following actions must be in the groups `docker` =
and `kvm`
-Create kas file
----------------
-
-Create a kas file named `opt-security.yml` to add security settings.
-
-Add security packages to rootfs
--------------------------------
+Create image recipe
+-------------------
-Set `IMAGE_PREINSTALL` to the list of packages required to enable
-the security features. This variable can be set through the kas file.
+Create the recipe `recipes-core/images/cip-core-image-security.bb`
+to generate a image including required packages.
+We can install existing Debian packages by setting
+`IMAGE_PREINSTALL` in the image recipe.
 Example:
-```
-local_conf_header:
-  security: |
     IMAGE_PREINSTALL =3D "openssl"
-```
 Build images
------------
-Build images for QEMU x86 64bit machine:
+Build images for QEMU x86 64bit machine.
-    $ ./kas-docker --isar build kas.yml:board-qemu-amd64.yml:opt-security.=
yml
+    $ ./kas-docker --isar build --target cip-core-image-security kas.yml:b=
oard-qemu-amd64.yml
 Run on QEMU
-----------
diff --git a/opt-security.yml b/opt-security.yml
deleted file mode 100644
index 7c6b39c..0000000
--- a/opt-security.yml
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# KAS configuration for CIP Core generic profile to enable security featur=
es
-#
-# Copyright (c) Toshiba Corporation, 2020
-#
-# Authors:
-#  Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 8
-
-local_conf_header:
-  security: |
-    # TODO: Add sudo or sudo-ldap
-    IMAGE_PREINSTALL =3D "\
-      openssl libssl1.1 \
-      fail2ban \
-      openssh-server openssh-sftp-server openssh-client \
-      syslog-ng-core syslog-ng-mod-journal \
-      aide aide-common \
-      libnftables0 nftables \
-      libpam-pkcs11 \
-      chrony \
-      tpm2-tools \
-      tpm2-abrmd \
-      libtss2-esys0 libtss2-udev \
-      libpam-cracklib \
-      acl \
-      libauparse0 audispd-plugins auditd \
-      uuid-runtime \
-    "
\ No newline at end of file
diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/=
images/cip-core-image-security.bb
new file mode 100644
index 0000000..70571f8
--- /dev/null
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -0,0 +1,37 @@
+#
+# A reference image which includes security packages
+#
+# Copyright (c) Toshiba Corporation, 2020
+#
+# Authors:
+#  Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit image
+
+DESCRIPTION =3D "CIP Core image including security packages"
+
+# Use the same customizations as cip-core-image
+IMAGE_INSTALL +=3D "customizations"
+
+# Debian packages that provide security features
+# TODO: Add sudo or sudo-ldap which conflict each other
+IMAGE_PREINSTALL =3D " \
+             openssl libssl1.1 \
+             fail2ban \
+             openssh-server openssh-sftp-server openssh-client \
+             syslog-ng-core syslog-ng-mod-journal \
+             aide aide-common \
+             libnftables0 nftables \
+             libpam-pkcs11 \
+             chrony \
+             tpm2-tools \
+             tpm2-abrmd \
+             libtss2-esys0 libtss2-udev \
+             libpam-cracklib \
+             acl \
+             libauparse0 audispd-plugins auditd \
+             uuid-runtime \
+"
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

--_000_a6a80ffc9357463fb213e8d65a90916etoshibatsipcom_
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
<p class=3D"MsoNormal">Signed-off-by: Kazuhiro Hayashi &lt;kazuhiro3.hayash=
i@toshiba.co.jp&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">SECURITY.md&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; | 23 &#43;&#43;&#43;&#43;--------<o:p></o:p></p>
<p class=3D"MsoNormal">opt-security.yml&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 34 ------=
-----------<o:p></o:p></p>
<p class=3D"MsoNormal">.../images/cip-core-image-security.bb&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 37 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 45 insertions(&#43;), 49 deletions(=
-)<o:p></o:p></p>
<p class=3D"MsoNormal">delete mode 100644 opt-security.yml<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 recipes-core/images/cip-core-imag=
e-security.bb<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/SECURITY.md b/SECURITY.md<o:p></o:p></p>
<p class=3D"MsoNormal">index a8bccc7..ddceee5 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/SECURITY.md<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/SECURITY.md<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -18,31 &#43;18,24 @@ Assumed environment<o:p></o:=
p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; * Installed packages: `dock=
er-ce`, `qemu-system`<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; * Users who does the follow=
ing actions must be in the groups `docker` and `kvm`<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-Create kas file<o:p></o:p></p>
<p class=3D"MsoNormal">----------------<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-Create a kas file named `opt-security.yml` to add s=
ecurity settings.<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-Add security packages to rootfs<o:p></o:p></p>
<p class=3D"MsoNormal">--------------------------------<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Create image recipe<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;-------------------<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-Set `IMAGE_PREINSTALL` to the list of packages requ=
ired to enable<o:p></o:p></p>
<p class=3D"MsoNormal">-the security features. This variable can be set thr=
ough the kas file.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;Create the recipe `recipes-core/images/cip-core=
-image-security.bb`<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;to generate a image including required packages=
.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;We can install existing Debian packages by sett=
ing<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;`IMAGE_PREINSTALL` in the image recipe.<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;Example:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-```<o:p></o:p></p>
<p class=3D"MsoNormal">-local_conf_header:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; security: |<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; IMAGE_PREINSTALL =3D &quot;=
openssl&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">-```<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;Build images<o:p></o:p></p>
<p class=3D"MsoNormal">------------<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-Build images for QEMU x86 64bit machine:<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&#43;Build images for QEMU x86 64bit machine.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; $ ./kas-docker --isar build kas.=
yml:board-qemu-amd64.yml:opt-security.yml<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; $ ./kas-docker --isar build =
--target cip-core-image-security kas.yml:board-qemu-amd64.yml<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;Run on QEMU<o:p></o:p></p>
<p class=3D"MsoNormal">-----------<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/opt-security.yml b/opt-security.yml<o:p=
></o:p></p>
<p class=3D"MsoNormal">deleted file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 7c6b39c..0000000<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/opt-security.yml<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1,34 &#43;0,0 @@<o:p></o:p></p>
<p class=3D"MsoNormal">-#<o:p></o:p></p>
<p class=3D"MsoNormal">-# KAS configuration for CIP Core generic profile to=
 enable security features<o:p></o:p></p>
<p class=3D"MsoNormal">-#<o:p></o:p></p>
<p class=3D"MsoNormal">-# Copyright (c) Toshiba Corporation, 2020<o:p></o:p=
></p>
<p class=3D"MsoNormal">-#<o:p></o:p></p>
<p class=3D"MsoNormal">-# Authors:<o:p></o:p></p>
<p class=3D"MsoNormal">-#&nbsp; Kazuhiro Hayashi &lt;kazuhiro3.hayashi@tosh=
iba.co.jp&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-#<o:p></o:p></p>
<p class=3D"MsoNormal">-# SPDX-License-Identifier: MIT<o:p></o:p></p>
<p class=3D"MsoNormal">-#<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-header:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; version: 8<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-local_conf_header:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; security: |<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; # TODO: Add sudo or sudo-ldap<o:=
p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; IMAGE_PREINSTALL =3D &quot;\<o:p=
></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openssl libssl1.1 \<=
o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fail2ban \<o:p></o:p=
></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openssh-server opens=
sh-sftp-server openssh-client \<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; syslog-ng-core syslo=
g-ng-mod-journal \<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aide aide-common \<o=
:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnftables0 nftable=
s \<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libpam-pkcs11 \<o:p>=
</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chrony \<o:p></o:p><=
/p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tpm2-tools \<o:p></o=
:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tpm2-abrmd \<o:p></o=
:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libtss2-esys0 libtss=
2-udev \<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libpam-cracklib \<o:=
p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acl \<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libauparse0 audispd-=
plugins auditd \<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-runtime \<o:p><=
/o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">\ No newline at end of file<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/recipes-core/images/cip-core-image-secu=
rity.bb b/recipes-core/images/cip-core-image-security.bb<o:p></o:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 0000000..70571f8<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/recipes-core/images/cip-core-image=
-security.bb<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -0,0 &#43;1,37 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;# A reference image which includes security pac=
kages<o:p></o:p></p>
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
<p class=3D"MsoNormal">&#43;inherit image<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;DESCRIPTION =3D &quot;CIP Core image including =
security packages&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;# Use the same customizations as cip-core-image=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;IMAGE_INSTALL &#43;=3D &quot;customizations&quo=
t;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;# Debian packages that provide security feature=
s<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;# TODO: Add sudo or sudo-ldap which conflict ea=
ch other<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;IMAGE_PREINSTALL =3D &quot; \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; openssl libssl1.1 \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; fail2ban \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; openssh-server openssh-sftp-server openssh-client=
 \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; syslog-ng-core syslog-ng-mod-journal \<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; aide aide-common \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; libnftables0 nftables \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; libpam-pkcs11 \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; chrony \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; tpm2-tools \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; tpm2-abrmd \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; libtss2-esys0 libtss2-udev \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; libpam-cracklib \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; acl \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; libauparse0 audispd-plugins auditd \<o:p></o:p></=
p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uuid-runtime \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&quot;<o:p></o:p></p>
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

--_000_a6a80ffc9357463fb213e8d65a90916etoshibatsipcom_--

--f4TzODS4258oyDXSiy8N
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4835): https://lists.cip-project.org/g/cip-dev/message=
/4835
Mute This Topic: https://lists.cip-project.org/mt/75119568/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--f4TzODS4258oyDXSiy8N--
