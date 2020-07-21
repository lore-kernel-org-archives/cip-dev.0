Return-Path: <SRS0=7d77=BA=lists.cip-project.org=bounce+64572+4947+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1140C433E3
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 08:15:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F212080D
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 08:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="W6LbMQQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F212080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4947+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id oBNnYY4521723xKzGakI9kq7; Tue, 21 Jul 2020 01:15:59 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [])
 by mx.groups.io with SMTP id smtpd.web12.14665.1595319357454409839
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2020 01:15:58 -0700
IronPort-SDR: 2VF/FBjl8P1ayo8Prx3GxGaZPx8CCm0fZ0fXeBfx0YFfU3v/GfftJ1OursYN3o5+zglazzOkzy
 FHxbrgzj8pwg==
X-IronPort-AV: E=Sophos;i="5.75,378,1589221800"; 
   d="scan'208";a="5058946"
X-Received: from unknown (HELO TOSBLRMBX0119.TOSHIBA-TSIP.COM) ([172.28.80.118])
  by peak.toshiba-tesi.com with ESMTP; 21 Jul 2020 14:19:43 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0119.TOSHIBA-TSIP.COM (172.28.80.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 21 Jul 2020 13:45:55 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Tue, 21 Jul 2020 13:45:55 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: venkata <venkata.pyla@toshiba-tsip.com>
Subject: [cip-dev] [PATCH 2/3] start-qemu.sh: use TARGET_IMAGE to pick respective image file
Date: Tue, 21 Jul 2020 13:46:44 +0530
Message-ID: <20200721081645.1789-2-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20200721081645.1789-1-venkata.pyla@toshiba-tsip.com>
References: <20200721081645.1789-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Zteb4SsJK7WdFaEBoHLSimktx4520388AA=
Content-Type: multipart/mixed; boundary="w3lU0b7YnyjrjWSoNvhQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595319359;
 bh=wmB2tFliNxAwZJSccrZ28LWwv0WZMxVqq6jBgX04FHE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=W6LbMQQ3J/TNStic9UwnbP1NAWui2cH55kqrH+aX+hJ7S18QF3rAVjcbrPAsD3cK+9b
 4Y9ovmPML+QeCi1Zv2TYqzMUSdGnV/YpNGk4mjB+4lexd4q39TZZuP/gGRmYccOGI3Xgd
 TgTwis60M9L0FOlfW5GHUHiaZUreGRcLuTU=

--w3lU0b7YnyjrjWSoNvhQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: venkata <venkata.pyla@toshiba-tsip.com>

if 'TARGET_IMAGE' variable is not set then it pick "cip-core-image",
to pick different target image set the 'TARGET_IMAGE' variable as below
e.g: $TARGET_IMAGE=cip-core-image-security ./start-qemu.sh amd64

Signed-off-by: venkata <venkata.pyla@toshiba-tsip.com>
---
 start-qemu.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 49f0266..5c17d74 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -75,7 +75,11 @@ if [ -z "${DISTRO_RELEASE}" ]; then
 	DISTRO_RELEASE="buster"
 fi
 
-IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/cip-core-image-cip-core-${DISTRO_RELEASE}-qemu-${DISTRO_ARCH}"
+if [ -z "${TARGET_IMAGE}" ]; then
+	TARGET_IMAGE="cip-core-image"
+fi
+
+IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${DISTRO_ARCH}"
 IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
 
 if [ -z "${DISPLAY}" ]; then
-- 
2.27.0.windows.1

The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the 
recipient and may contain privileged information. 
If you are not the intended recipient, please notify the
sender and delete the message along with any 
attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail 
are those of the individual sender except where the sender 
specifically states them to be the views of 
Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer 
system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility 
is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.


--w3lU0b7YnyjrjWSoNvhQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4947): https://lists.cip-project.org/g/cip-dev/message=
/4947
Mute This Topic: https://lists.cip-project.org/mt/75699593/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--w3lU0b7YnyjrjWSoNvhQ--
