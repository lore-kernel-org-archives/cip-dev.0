Return-Path: <SRS0=QE+I=B5=lists.cip-project.org=bounce+64572+5137+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57F2C433E4
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 04:42:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C5E207BB
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 04:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jtEX9sdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C5E207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5137+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2ZSVYY4521723xogq7F7ccoz; Tue, 18 Aug 2020 21:42:25 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.82188.1597812143761188893
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2020 21:42:24 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 07J4gLce013689; Wed, 19 Aug 2020 13:42:21 +0900
X-Iguazu-Qid: 34tKBCMUDE45qIfkuX
X-Iguazu-QSIG: v=2; s=0; t=1597812141; q=34tKBCMUDE45qIfkuX; m=TOrh6e4NkzeC61eQ50tCNU1+HvIqlKrNaG9yhSUgyN8=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 07J4gK61002281;
	Wed, 19 Aug 2020 13:42:20 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx12.toshiba.co.jp  with ESMTP id 07J4gK04017561;
	Wed, 19 Aug 2020 13:42:20 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc03.toshiba.co.jp  with ESMTP id 07J4gJwn013409;
	Wed, 19 Aug 2020 13:42:20 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH v2 1/3] cip-core-image: Remove ltp-full from IMAGE_INSTALL
Date: Wed, 19 Aug 2020 13:41:59 +0900
X-TSB-HOP: ON
Message-Id: <20200819044201.1255803-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GxeeT8eXTEH5pyKsxT7xvaN2x4520388AA=
Content-Type: multipart/mixed; boundary="jxqOKvwE2luqy6xfNVob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597812145;
 bh=0MrJlSdloR+npkfWTOP8i6uKpbhewDjiNz6b29kaH2w=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jtEX9sdnlI8yVNGdwcHvSNQ5w37n2r8wKrhkhpAlSJhTcB9CeT1v7Myd5mIsyxLJvRs
 KIADXho473YcqwFZ5t3626WSKSb2+8GAZSzAuMyxMonp4GzdsigpYkmIcSU+Htt8Qw9nY
 pfaD6qpA2dxzfRlVfzMtcwf5pptZwjz/zlU=

--jxqOKvwE2luqy6xfNVob
Content-Transfer-Encoding: 8bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 recipes-core/images/cip-core-image.bb | 2 --
 1 file changed, 2 deletions(-)

diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 4dfc983..fd2fd83 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -15,8 +15,6 @@ ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always
 DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
-# for cip-testing
-IMAGE_INSTALL += "ltp-full"
 
 # for swupdate
 EXTRACT_PARTITIONS = "img4"
-- 
2.27.0


--jxqOKvwE2luqy6xfNVob
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5137): https://lists.cip-project.org/g/cip-dev/message=
/5137
Mute This Topic: https://lists.cip-project.org/mt/76280652/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--jxqOKvwE2luqy6xfNVob--
