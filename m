Return-Path: <SRS0=qQt8=DH=lists.cip-project.org=bounce+64572+5480+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB142C4741F
	for <cip-dev@archiver.kernel.org>; Wed, 30 Sep 2020 02:10:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA642145D
	for <cip-dev@archiver.kernel.org>; Wed, 30 Sep 2020 02:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KehFqfuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA642145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5480+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BtdXYY4521723xl3Nok8FwIY; Tue, 29 Sep 2020 19:10:23 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.5951.1601431820935430122
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Sep 2020 19:10:22 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 08U2AIfA005127; Wed, 30 Sep 2020 11:10:18 +0900
X-Iguazu-Qid: 2wHHzZilbOxxUE4rWk
X-Iguazu-QSIG: v=2; s=0; t=1601431818; q=2wHHzZilbOxxUE4rWk; m=qizcbdv8O9bzT/IdLWSF3S+xtrQpGvhZv/n9I8bX/0o=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 08U2AHEG036109;
	Wed, 30 Sep 2020 11:10:17 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 08U2AHUN024777;
	Wed, 30 Sep 2020 11:10:17 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 08U2AGBH023644;
	Wed, 30 Sep 2020 11:10:17 +0900
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core] image: export dpkg status file for debsecan
Date: Wed, 30 Sep 2020 11:08:15 +0900
X-TSB-HOP: ON
Message-Id: <20200930020815.2474349-2-daniel.sangorrin@toshiba.co.jp>
In-Reply-To: <20200930020815.2474349-1-daniel.sangorrin@toshiba.co.jp>
References: <20200930020815.2474349-1-daniel.sangorrin@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rYOuPmlj4VJkDiUmXVKPymFrx4520388AA=
Content-Type: multipart/mixed; boundary="Dneir6GGs2pOB80kMm2B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601431823;
 bh=9Hc9Cb4rym9YlwH48v6FK6pAh8EhAo/PdM6chc7y0ig=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KehFqfuDMCZvOUCxCHnjQmw9ka9HlJU6gzbz2acBMV6/AdwxDFWiNEF59RiJt/AHy07
 gWdLbVWi8vd1uswecGTrvlzP/QLg1l7WC5oyDzQIj8JJ5ND1KVUTbriGhcg67Ky/48nHS
 P7R6jqKpcxK6mEcMViolaNt2ovAL7TXpBAA=

--Dneir6GGs2pOB80kMm2B
Content-Transfer-Encoding: 8bit

Although the currently exported manifest probably has
enough information, the tool debsecan and our wrapper
cip-core-sec depend on the dpkg status format.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 recipes-core/images/cip-core-image-security.bb | 8 ++++++++
 recipes-core/images/cip-core-image.bb          | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 61ddc39..928774c 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -34,3 +34,11 @@ IMAGE_PREINSTALL += " \
 	uuid-runtime \
 	sudo \
 "
+
+# for cip-core-sec/debsecan
+ROOTFS_POSTPROCESS_COMMAND += "export_dpkg_status"
+export_dpkg_status() {
+    sudo -E chroot --userspec=$(id -u):$(id -g) '${ROOTFSDIR}' \
+        cat /var/lib/dpkg/status > \
+        ${ROOTFS_MANIFEST_DEPLOY_DIR}/"${PF}".dpkg_status
+}
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 2cecde3..0139819 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -19,3 +19,11 @@ IMAGE_INSTALL += "customizations"
 # for swupdate
 SWU_DESCRIPTION ??= "swupdate"
 include ${SWU_DESCRIPTION}.inc
+
+# for cip-core-sec/debsecan
+ROOTFS_POSTPROCESS_COMMAND += "export_dpkg_status"
+export_dpkg_status() {
+    sudo -E chroot --userspec=$(id -u):$(id -g) '${ROOTFSDIR}' \
+        cat /var/lib/dpkg/status > \
+        ${ROOTFS_MANIFEST_DEPLOY_DIR}/"${PF}".dpkg_status
+}
-- 
2.25.1


--Dneir6GGs2pOB80kMm2B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5480): https://lists.cip-project.org/g/cip-dev/message=
/5480
Mute This Topic: https://lists.cip-project.org/mt/77210404/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Dneir6GGs2pOB80kMm2B--
