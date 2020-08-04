Return-Path: <SRS0=7C/8=BO=lists.cip-project.org=bounce+64572+5097+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61699C433E1
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:53:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3199021744
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="S31c7T+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3199021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5097+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wQwVYY4521723xM111qt2h9i; Tue, 04 Aug 2020 06:53:54 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.5722.1596549234151557575
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2020 06:53:54 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 074DrqTl019184; Tue, 4 Aug 2020 22:53:52 +0900
X-Iguazu-Qid: 34tIYF04MXIpWbVnLE
X-Iguazu-QSIG: v=2; s=0; t=1596549232; q=34tIYF04MXIpWbVnLE; m=Jb5sxxKpI3HbqC0EM8IbX3Es61Q20CNdkRc9QiQ5sME=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 074DrpkQ031820;
	Tue, 4 Aug 2020 22:53:51 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 074DrpDl019137
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 22:53:51 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 074Drp9S020807
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 22:53:51 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH 2/3] customizations: Remove rt-tests and stress-ng from DEBIAN_DEPENDS
Date: Tue,  4 Aug 2020 22:53:41 +0900
X-TSB-HOP: ON
Message-Id: <20200804135342.446609-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20200804135342.446609-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200804135342.446609-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NaAL2aEAyddp6PANCdvm9J2Qx4520388AA=
Content-Type: multipart/mixed; boundary="MDdLzrBkJ15B3bVVV0ll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596549234;
 bh=dkjxNNz3iP3HUZwLpVpQc6Twyn4L7IPzkI0cyvN7AOE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=S31c7T+HR1QjZS9b/vIA1Ws4hXE2/N8QvwhWhZAybvUmrcTVpOgfTYeJGFd68XoCSDZ
 /o7HRPFAeDVEKBxxKoTGw+mXbQLEi+5d9HkdJnGU7HJALJ5S0QBxS8Zvzmh87s3ukdkRr
 l4YVstQ0r/7ElikPZmqU0yVjlZYRwJlELZE=

--MDdLzrBkJ15B3bVVV0ll
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


--MDdLzrBkJ15B3bVVV0ll
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5097): https://lists.cip-project.org/g/cip-dev/message=
/5097
Mute This Topic: https://lists.cip-project.org/mt/75987092/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--MDdLzrBkJ15B3bVVV0ll--
