Return-Path: <SRS0=22FN=B5=lists.cip-project.org=bounce+64572+5135+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652A8C433E3
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 04:42:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC31720855
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 04:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UB/YJ8EJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC31720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5135+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cm1lYY4521723xsTSqQTRQ2j; Tue, 18 Aug 2020 21:42:24 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.82889.1597812141138336453
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2020 21:42:23 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 07J4gHTM026159; Wed, 19 Aug 2020 13:42:17 +0900
X-Iguazu-Qid: 2wGrV5ExkRwUAD1NyM
X-Iguazu-QSIG: v=2; s=0; t=1597812137; q=2wGrV5ExkRwUAD1NyM; m=559kkkGoiShA0Ir5LpuxQ8fLgcPGWtDDRbyFMFU1w04=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 07J4gGhF002315;
	Wed, 19 Aug 2020 13:42:17 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 07J4gGH2026314;
	Wed, 19 Aug 2020 13:42:16 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 07J4gGLm008471;
	Wed, 19 Aug 2020 13:42:16 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH v2 2/3] customizations: Remove rt-tests and stress-ng from DEBIAN_DEPENDS
Date: Wed, 19 Aug 2020 13:42:00 +0900
X-TSB-HOP: ON
Message-Id: <20200819044201.1255803-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20200819044201.1255803-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200819044201.1255803-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7Y7UjaI3XilKYJvTu9yDVMvxx4520388AA=
Content-Type: multipart/mixed; boundary="keImxAE9K1F7ZsapbJAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597812144;
 bh=eFlpB8D8li7uXConjm/+TYxtd0Hp+4F4qZrU2ca9LRs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UB/YJ8EJTEj3mE+MBwWwjAOB5I9WxPwPEf3OtbRHXIuesCT5qQwbl4OJtpE8f4qHQlT
 lQwBgC2tOqYH0KHcyb+GE6+PXyXXckQsgQYRMMu7j6Xc+pDxJpnu0N3jKJofk/ggaOIcs
 i7gpRFnbdMtw+oZQEhdyjYtSrjqlUuOd4Ac=

--keImxAE9K1F7ZsapbJAn
Content-Transfer-Encoding: 8bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 recipes-core/customizations/customizations.bb | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index 38881fb..932b11c 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -11,7 +11,7 @@
 
 inherit dpkg-raw
 
-DESCRIPTION = "CIP Core image demo & test customizations"
+DESCRIPTION = "CIP Core image demo & customizations"
 
 SRC_URI = " \
     file://postinst \
@@ -21,8 +21,7 @@ SRC_URI = " \
 DEPENDS += "sshd-regen-keys"
 
 DEBIAN_DEPENDS = " \
-    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
-    rt-tests, stress-ng"
+    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
 
 do_install() {
 	install -v -d ${D}/etc/network/interfaces.d
-- 
2.27.0


--keImxAE9K1F7ZsapbJAn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5135): https://lists.cip-project.org/g/cip-dev/message=
/5135
Mute This Topic: https://lists.cip-project.org/mt/76280650/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--keImxAE9K1F7ZsapbJAn--
