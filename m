Return-Path: <SRS0=XHqw=KF=lists.cip-project.org=bounce+64572+6439+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25CFC433B4
	for <cip-dev@archiver.kernel.org>; Mon, 10 May 2021 01:34:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324F3613DB
	for <cip-dev@archiver.kernel.org>; Mon, 10 May 2021 01:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324F3613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6439+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BkIwYY4521723xaEWIzaicAH; Sun, 09 May 2021 18:34:37 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.26170.1620610475253231033
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 May 2021 18:34:36 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 14A1YWhd020857; Mon, 10 May 2021 10:34:33 +0900
X-Iguazu-Qid: 34triG5OneAqFj6l6W
X-Iguazu-QSIG: v=2; s=0; t=1620610472; q=34triG5OneAqFj6l6W; m=vn7pfFzazA1xNIgJpd5RFx5Jfxh8EsBGdiSRAjjoy2M=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1511) id 14A1YV5U039499
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 May 2021 10:34:32 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id DADDC100098;
	Mon, 10 May 2021 10:34:31 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 14A1YV9w002774;
	Mon, 10 May 2021 10:34:31 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [PATCH 2/4] scripts/deploy-cip-core.sh: Fix to correct filename with security extension
Date: Mon, 10 May 2021 10:34:21 +0900
X-TSB-HOP: ON
Message-Id: <20210510013423.65527-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20210510013423.65527-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210510013423.65527-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: k8YI94GoOHmqMvpLeJ6EkjrXx4520388AA=
Content-Type: multipart/mixed; boundary="dQYg4wg6y1VSr2VKQL91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620610477;
 bh=bzumLd2ti/ybn1qhUApwLxPKJqX/hiu/AKTi757IzHA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ry9N5ZpodwvqfoeIj71b0sdnvECyjRAVtmc1haZyVyyJiOH2w4qxIIgTT5L1nu1vbWg
 954IoH88M7+/86q5DPGWRVDpPew/IutoZ3BKWFGxV0Bl6nmMfhfzPhux5t9bLkSccbRvQ
 5Uk3cBWPTc02gugQqTwMOelS3geA9GvtqFw=

--dQYg4wg6y1VSr2VKQL91
Content-Transfer-Encoding: 8bit

Since security extension uses the bb file, not the extension using local.conf,
the generated filename is different.
This sets the correct filename for security extensions.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 scripts/deploy-cip-core.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 3593d51..0b8bbe6 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -19,13 +19,19 @@ TARGET=$2
 EXTENSION=$3
 DTB=$4
 
-BASE_PATH=build/tmp/deploy/images/$TARGET/cip-core-image-cip-core-$RELEASE-$TARGET
+BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
 if [ "${EXTENSION}" != "base" ] ; then
-	BASE_PATH=build/tmp/deploy/images/$TARGET/cip-core-image-cip-core-$RELEASE-$TARGET-$EXTENSION
+	if [ "${EXTENSION}" = "security" ] ; then
+		BASE_FILENAME=cip-core-image-$EXTENSION-cip-core-$RELEASE-$TARGET
+	else
+		BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET-$EXTENSION
+	fi
 fi
 
+BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
+
 if [ -f $BASE_PATH.wic.img ] ; then
-	echo "Compressing cip-core-image-cip-core-$RELEASE-$TARGET.wic.img..."
+	echo "Compressing $BASE_FILENAME.wic.img..."
 	xz -9 -k $BASE_PATH.wic.img
 
 	echo "Uploading artifacts..."
-- 
2.31.1


--dQYg4wg6y1VSr2VKQL91
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6439): https://lists.cip-project.org/g/cip-dev/message=
/6439
Mute This Topic: https://lists.cip-project.org/mt/82710739/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dQYg4wg6y1VSr2VKQL91--
