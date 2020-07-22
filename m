Return-Path: <SRS0=oV3Z=BB=lists.cip-project.org=bounce+64572+4953+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78865C433E1
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 00:51:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41B420771
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 00:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="uLAdisjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41B420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4953+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hbnUYY4521723x0cg5zVGQXs; Tue, 21 Jul 2020 17:51:12 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.9336.1595379068710522283
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2020 17:51:10 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 06M0p4ha006743; Wed, 22 Jul 2020 09:51:05 +0900
X-Iguazu-Qid: 2wHHK1VZrujqeF5EAW
X-Iguazu-QSIG: v=2; s=0; t=1595379064; q=2wHHK1VZrujqeF5EAW; m=hTTTEhgJJES57SXJMQULueuff2+sUkCT/O0/Dqby680=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 06M0p3n9017000;
	Wed, 22 Jul 2020 09:51:04 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06M0p32F007704;
	Wed, 22 Jul 2020 09:51:03 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06M0p32s018240;
	Wed, 22 Jul 2020 09:51:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtHYPphAUPQD0QfWGBj4BxA+DNXz6Np7aK1EWjOnbVipE2em6+fj6Oqfp8MVccKe9YOPsKO7rzdx1myMzKJx7Q7qUPZetg2tlmqqGcus+hxW7od55PwFQfc0CZp+biVrbmK30YdLMQA01aRdUe9OyWiVmo/LQj18/TKiFaAlos1/Vpo6tTpkTCA+ADb96xnl0qRWsvLtkbex3I+VI9yvuUQa7YtuwyuX10kYcn1oT64kDMHm3bxuizTEtarkVblD2zh6ypn398ZcFIpJv5D1ojyD1f+Tm3gHeR+TWKFQcXq0yhja+/B3oa7IXdMqS7lTtunNe9cVDCEpp3+3dWvNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u720vdfGubmuh7qektdQgv7uktwHoyf2VK/58BkX358=;
 b=oVTHhnfClTZ/FsyAImftac/aOs6oJRwtXNQ6OouTHVTqtI+Pftxi+/N5Y67/e06LtNpfu9jSWzeVa4vmegliuIw8ggqhUMISzw1Y3WTOBwuBqUcG6AIxew3lkeH/UmOQPuYxgBhcquGFJnOvJYOLB4osWQn/KSj4evn3gDB++tpgCnXuZM1Bf9RcrSdZeHezeDMbvVgkwXWOHLncK85fo1MG3HM+m4z+IVtPGP0WKurQpuroXnhtNojMSDVi16jYA2wiwHTCxF5TPheQLYM5XBtfSN0uMBtimMTW4OgU9WczoD9kSWTsiRbLCExdehvjHOuxSKrmuomusT8f675trQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] Fw: [isar-cip-core] tests: put all tests into a opt layer
Thread-Topic: [isar-cip-core] tests: put all tests into a opt layer
Thread-Index: AQHWX04ClCUHA3hxv0Syz8BWlTK0ZakSxQ1p
Date: Wed, 22 Jul 2020 00:50:59 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB205337CFE31191CD399C711CD0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200721105928.1309238-1-daniel.sangorrin@toshiba.co.jp>
In-Reply-To: <20200721105928.1309238-1-daniel.sangorrin@toshiba.co.jp>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6222aab9-7cb5-4891-3c84-08d82dd94d39
x-ms-traffictypediagnostic: OSBPR01MB3814:
x-microsoft-antispam-prvs: <OSBPR01MB3814186C5D8242371980B161D0790@OSBPR01MB3814.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GdHK5NGowqFRS1RFdLx/zfsp8M6UzayrNFgBBTnkXbD4fPhVujYNvebM/1WE7H0r2q6eGz7XDgS5PUOBpn7MRrq6BmWis/AXTqLmUOtYj/zyY7mujb/67tFG30JAGsMgz5oyrDcdWQ2F2O7/tIViMgLgw9rl7zI7AXWg4+s4xzk5failv92nK4x9tx6Ndsr2h2/cgYb9tTh4VH3l1CTXskFK16gGT+k42ebNcGkzeFo8cb9SLrHcJrN+J1Gn1NRWrzxh+NS0y5M3mzmYE8TsH6pOqcq+YU06DHkB/hh/C0o15jE6dF5E4e/GZufreQ7chL4yofNe7W0yiAS+EliFPyCabGAh85G/r5xzkbPxaZUGkD2wrSVP3RL4gUKfjwjE
x-ms-exchange-antispam-messagedata: dxymtqsLsYw9DPrqqmOOHBHkqDGMnIe1VrK9LMb8ghQs37DJJg3cVcfWqyJHtFbGSXPKMZVHE5Ei0bN4o3dMdl10hjXUTP9NghE33irV+yv4JHmxb7RQouxUWmlApPLvhYXWnlGnq/WPuGfnqdbiMtA6fJyOy/1dIUJxqy1eolDXg6gC/ylsttypaK6vIB9326UcFL+4DP/kkZJVS0nP2dgVXp/SvxKRUldVr2wfkFKosfmilgnNaCmk9ZxxDjBF3V+ytIToVUQK03+94nWdQryDp1lTXcDD9iRln1KUfopQtFzc3TDpS+HeSflTzycIfn9R/rqPoohcoJVSEL8VHWiDJwQ8DFU4ua54rnTomWDdu+qwWaI6qZ5YXBFPNK/3P1j9PRn7us4yIpEQTGUOvxcwESuL8ZjbRVdvc33I5yDjy1J5bJSj9ptiLXaAs6sJ1G16l5Vgf2LvBa8kI/53ffh5t+uE4ZMvoeIbdzLaDoI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6222aab9-7cb5-4891-3c84-08d82dd94d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 00:50:59.8705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpOU0K5MMI1rmON4Z8vrv0g2fC9tHho1lonRdsjL2xmqmXZ1AhR9NZ+s49RpqDePeHeMwSPke8+Yny3/kTO47t0PUTB5Xyd1IFp7X11RXMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3814
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ckBC5bRhnIEnrFVKQ0r6tKgfx4520388AA=
Content-Type: multipart/mixed; boundary="DG9HygNuVYlV7CPiBjOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595379072;
 bh=My39o5RZK/onq7REdA/3O6ar+rfVYnbtx3X+BNo4MTY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=uLAdisjm5KiW6dq7yBNHSIBMRVmLlgOtg3ATPuDU/Wq2c7gweraYo9IoewBArEdtOSC
 WgvNCtxYvcbELJHD/NudbYiINjDy13FiIBCff5riFgSdJJqNinuEfkSYLk8+cI/IjLpob
 Lsw9+0b+HR/RxeTZ4ILLyWmRGzbtugbgFGs=

--DG9HygNuVYlV7CPiBjOL
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,=0A=
=0A=
Sorry, I failed to put you in the Cc when I sent this patch.=0A=
There are also 3 patches from Venkata-san on the cip-dev mailing list (sent=
 yesterday)=0A=
Apart from that there are some merge requests on gitlab.=0A=
=0A=
Thanks,=0A=
Daniel=0A=
=0A=
=0A=
________________________________________=0A=
From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>=0A=
Sent: Tuesday, July 21, 2020 7:59 PM=0A=
To: sangorrin daniel(=1B$B%5%s%4%j%s=1B(B =1B$B%@%K%(%k=1B(B =1B$B""#S#W#C"=
~#A#C#T=1B(B)=0A=
Subject: [isar-cip-core] tests: put all tests into a opt layer=0A=
=0A=
having an opt-tests layer makes it easier to see what=0A=
tests are installed, and allows creating images without=0A=
them as well=0A=
=0A=
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>=0A=
---=0A=
 .gitlab-ci.yml                                |  8 ++++----=0A=
 README.md                                     |  4 ++++=0A=
 opt-tests.yml                                 | 19 +++++++++++++++++++=0A=
 recipes-core/customizations/customizations.bb |  5 ++---=0A=
 recipes-core/images/cip-core-image.bb         |  3 +--=0A=
 5 files changed, 30 insertions(+), 9 deletions(-)=0A=
 create mode 100644 opt-tests.yml=0A=
=0A=
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml=0A=
index 6f1dc91..90eec1f 100644=0A=
--- a/.gitlab-ci.yml=0A=
+++ b/.gitlab-ci.yml=0A=
@@ -13,17 +13,17 @@ all:=0A=
     - export AWS_ACCESS_KEY_ID=3D$AWS_ACCESS_KEY_ID=0A=
     - export AWS_SECRET_ACCESS_KEY=3D$AWS_SECRET_ACCESS_KEY=0A=
=0A=
-    - kas build kas.yml:board-simatic-ipc227e.yml:opt-rt.yml:opt-targz-img=
.yml=0A=
+    - kas build kas.yml:board-simatic-ipc227e.yml:opt-tests.yml:opt-rt.yml=
:opt-targz-img.yml=0A=
     - scripts/deploy-cip-core.sh buster simatic-ipc227e=0A=
=0A=
     - sudo rm -rf build/tmp=0A=
-    - kas build kas.yml:board-bbb.yml:opt-rt.yml:opt-targz-img.yml=0A=
+    - kas build kas.yml:board-bbb.yml:opt-tests.yml:opt-rt.yml:opt-targz-i=
mg.yml=0A=
     - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb=0A=
=0A=
     - sudo rm -rf build/tmp=0A=
-    - kas build kas.yml:board-iwg20m.yml:opt-rt.yml:opt-targz-img.yml=0A=
+    - kas build kas.yml:board-iwg20m.yml:opt-tests.yml:opt-rt.yml:opt-targ=
z-img.yml=0A=
     - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.d=
tb=0A=
=0A=
     - sudo rm -rf build/tmp=0A=
-    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml:opt-targz-img.yml=0A=
+    - kas build kas.yml:board-rzg2m.yml:opt-tests.yml:opt-rt.yml:opt-targz=
-img.yml=0A=
     - scripts/deploy-cip-core.sh buster hihope-rzg2m renesas/r8a774a1-hiho=
pe-rzg2m-ex.dtb=0A=
diff --git a/README.md b/README.md=0A=
index bbad1a0..7339396 100644=0A=
--- a/README.md=0A=
+++ b/README.md=0A=
@@ -25,6 +25,10 @@ this:=0A=
=0A=
 This image can be run using `start-qemu.sh x86`.=0A=
=0A=
+If you want to include the testing layer add ':opt-tests.yml' like this=0A=
+=0A=
+    ./kas-docker --isar build kas.yml:board-qemu-amd64.yml:opt-tests.yml=
=0A=
+=0A=
 The BeagleBone Black target is selected by `... kas.yml:board-bbb.yml`. In=
=0A=
 order to build the image with the PREEMPT-RT kernel, append `:opt-rt.yml` =
to=0A=
 the above. Append ':opt-4.4.yml' to use the kernel version 4.4 instead of =
4.19.=0A=
diff --git a/opt-tests.yml b/opt-tests.yml=0A=
new file mode 100644=0A=
index 0000000..a1f431d=0A=
--- /dev/null=0A=
+++ b/opt-tests.yml=0A=
@@ -0,0 +1,19 @@=0A=
+#=0A=
+# CIP Core, generic profile=0A=
+#=0A=
+# Copyright (c) Toshiba corp., 2020=0A=
+#=0A=
+# Authors:=0A=
+#  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>=0A=
+#=0A=
+# SPDX-License-Identifier: MIT=0A=
+#=0A=
+=0A=
+header:=0A=
+  version: 8=0A=
+=0A=
+local_conf_header:=0A=
+  tests: |=0A=
+    IMAGE_INSTALL +=3D "ltp-full"=0A=
+    IMAGE_PREINSTALL +=3D "rt-tests stress-ng"=0A=
+=0A=
diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/c=
ustomizations/customizations.bb=0A=
index 38881fb..cbd6daf 100644=0A=
--- a/recipes-core/customizations/customizations.bb=0A=
+++ b/recipes-core/customizations/customizations.bb=0A=
@@ -11,7 +11,7 @@=0A=
=0A=
 inherit dpkg-raw=0A=
=0A=
-DESCRIPTION =3D "CIP Core image demo & test customizations"=0A=
+DESCRIPTION =3D "CIP Core image demo customizations"=0A=
=0A=
 SRC_URI =3D " \=0A=
     file://postinst \=0A=
@@ -21,8 +21,7 @@ SRC_URI =3D " \=0A=
 DEPENDS +=3D "sshd-regen-keys"=0A=
=0A=
 DEBIAN_DEPENDS =3D " \=0A=
-    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-ke=
ys, \=0A=
-    rt-tests, stress-ng"=0A=
+    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-ke=
ys"=0A=
=0A=
 do_install() {=0A=
        install -v -d ${D}/etc/network/interfaces.d=0A=
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/ci=
p-core-image.bb=0A=
index 9ee4b25..188c714 100644=0A=
--- a/recipes-core/images/cip-core-image.bb=0A=
+++ b/recipes-core/images/cip-core-image.bb=0A=
@@ -15,5 +15,4 @@ ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describ=
e --tags --dirty --always=0A=
 DESCRIPTION =3D "CIP Core image"=0A=
=0A=
 IMAGE_INSTALL +=3D "customizations"=0A=
-# for cip-testing=0A=
-IMAGE_INSTALL +=3D "ltp-full"=0A=
+=0A=
--=0A=
2.25.1=0A=
=0A=

--DG9HygNuVYlV7CPiBjOL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4953): https://lists.cip-project.org/g/cip-dev/message=
/4953
Mute This Topic: https://lists.cip-project.org/mt/75716276/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--DG9HygNuVYlV7CPiBjOL--
