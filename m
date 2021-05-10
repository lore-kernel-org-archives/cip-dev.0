Return-Path: <SRS0=Sxky=KF=lists.cip-project.org=bounce+64572+6446+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A4C43462
	for <cip-dev@archiver.kernel.org>; Mon, 10 May 2021 01:40:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E713613DE
	for <cip-dev@archiver.kernel.org>; Mon, 10 May 2021 01:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E713613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6446+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sPa8YY4521723x8YkXmsAZyu; Sun, 09 May 2021 18:40:21 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.26283.1620610819255944697
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 May 2021 18:40:20 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 14A1eHQL023423; Mon, 10 May 2021 10:40:17 +0900
X-Iguazu-Qid: 2wHH6QSES6Uyejgw2Y
X-Iguazu-QSIG: v=2; s=0; t=1620610816; q=2wHH6QSES6Uyejgw2Y; m=G8ymIqhsfV6pK7bXXadiQMJc54qCcbS8PhRvpoumyKE=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1113) id 14A1eF7i016933
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 May 2021 10:40:16 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 8AFC41000BE;
	Mon, 10 May 2021 10:40:15 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 14A1eFkW008335;
	Mon, 10 May 2021 10:40:15 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][Resend PATCH 1/4] scripts/deploy-cip-core.sh: Fix uploading tar.gz image
Date: Mon, 10 May 2021 10:40:08 +0900
X-TSB-HOP: ON
Message-Id: <20210510014011.66494-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Ga6V51h7S4jHMCMAMxVx3fQ1x4520388AA=
Content-Type: multipart/mixed; boundary="ivsm5nm9V0nU9civw3io"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620610821;
 bh=mqYT8FRHu5aFv7JeLvhhq+qqqX7u1YH8QZR5iJapueI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=GBtGLQD5sjjzfyKmi+cKjSTPZeozRhAV63Gclu4Qh5Lx3UsV8uK1X9c85luE4gSEi2c
 kxdmJnc2/xzIzAZ5L1Vd6jXkckZc9I45qSiTuEbFc/tB2mMnW7W6zAC3QKMpaDm5L8Cny
 03pp48R6O+bsnylBLJ1t3VFPgB/II73ygFE=

--ivsm5nm9V0nU9civw3io
Content-Transfer-Encoding: 8bit

Since *.wic.img is always compressed, if this file does not exist (for
example, the extension is tar.gz), the image file upload will fail.
This will check for the extension of the file.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 scripts/deploy-cip-core.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 5b7eab9..3593d51 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -24,14 +24,17 @@ if [ "${EXTENSION}" != "base" ] ; then
 	BASE_PATH=build/tmp/deploy/images/$TARGET/cip-core-image-cip-core-$RELEASE-$TARGET-$EXTENSION
 fi
 
-echo "Compressing cip-core-image-cip-core-$RELEASE-$TARGET.wic.img..."
-xz -9 -k $BASE_PATH.wic.img
+if [ -f $BASE_PATH.wic.img ] ; then
+	echo "Compressing cip-core-image-cip-core-$RELEASE-$TARGET.wic.img..."
+	xz -9 -k $BASE_PATH.wic.img
 
-echo "Uploading artifacts..."
-aws s3 cp --no-progress $BASE_PATH.wic.img.xz s3://download.cip-project.org/cip-core/$TARGET/
+	echo "Uploading artifacts..."
+	aws s3 cp --no-progress $BASE_PATH.wic.img.xz s3://download.cip-project.org/cip-core/$TARGET/
+fi
 
 if [ -f $BASE_PATH.tar.gz ]; then
-    aws s3 cp --no-progress $BASE_PATH.tar.gz s3://download.cip-project.org/cip-core/$TARGET/
+	echo "Uploading artifacts..."
+	aws s3 cp --no-progress $BASE_PATH.tar.gz s3://download.cip-project.org/cip-core/$TARGET/
 fi
 
 KERNEL_IMAGE=$BASE_PATH-vmlinuz
-- 
2.31.1


--ivsm5nm9V0nU9civw3io
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6446): https://lists.cip-project.org/g/cip-dev/message=
/6446
Mute This Topic: https://lists.cip-project.org/mt/82710800/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ivsm5nm9V0nU9civw3io--
