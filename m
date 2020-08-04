Return-Path: <SRS0=Ypzu=BO=lists.cip-project.org=bounce+64572+5094+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10B4C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:47:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2662075D
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Il7AiHay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2662075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5094+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AgtKYY4521723xQu1OMkbTRk; Tue, 04 Aug 2020 06:47:44 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.5662.1596548863429841437
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2020 06:47:43 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 074Dle1s007612; Tue, 4 Aug 2020 22:47:40 +0900
X-Iguazu-Qid: 2wGqu78fiiC6G46dBg
X-Iguazu-QSIG: v=2; s=0; t=1596548860; q=2wGqu78fiiC6G46dBg; m=ptiH8GYLaec0+w5pmB8VQU38wNKIvCDLi6urp76vFn4=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 074Dlcn6026384;
	Tue, 4 Aug 2020 22:47:40 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 074Dlc5B026585
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 22:47:38 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 074Dlcfu006608
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 22:47:38 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [PATCH 2/3] customizations: Remove rt-tests and stress-ng from DEBIAN_DEPENDS
Date: Tue,  4 Aug 2020 22:47:27 +0900
X-TSB-HOP: ON
Message-Id: <20200804134728.445732-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20200804134728.445732-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200804134728.445732-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7DxoZ106uYjJ13mBgE7QbkN1x4520388AA=
Content-Type: multipart/mixed; boundary="VuFh3Pg1tCtZxkawdlgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596548864;
 bh=etOJ89wrr8N0QEDqgPOOFaWfhF+W8gk00kVjNdYbKnY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Il7AiHayfjk7Qvk84JOHIHd3muTljmf1h7xIMdx8idGX+w9NB0ZLxjYUGLy9PzHfTdj
 pImUwwodISB7hcvN82KUoyR37kSN5RRxipwHN6u9B5YCf7FyiXcrFo7drMs1oXxhiKWoK
 +3xnUF6bNPjpoT8idzMuFAaaDuYHvoQlLK8=

--VuFh3Pg1tCtZxkawdlgF
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


--VuFh3Pg1tCtZxkawdlgF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5094): https://lists.cip-project.org/g/cip-dev/message=
/5094
Mute This Topic: https://lists.cip-project.org/mt/75986991/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VuFh3Pg1tCtZxkawdlgF--
