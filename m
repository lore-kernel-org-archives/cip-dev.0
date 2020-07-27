Return-Path: <SRS0=rLEv=BG=lists.cip-project.org=bounce+64572+5022+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED42EC433E3
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 11:40:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10A42074F
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sduHI625"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10A42074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5022+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jB2qYY4521723xGdUWzopopF; Mon, 27 Jul 2020 04:40:46 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [])
 by mx.groups.io with SMTP id smtpd.web11.53493.1595850044332209491
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2020 04:40:45 -0700
IronPort-SDR: nB901Wl/IJ8F53nhv3zyCxVEvwaL8qGMWCrU7oDXnGiH9gNcQfgxm4CUqTMpIoGxq6Js0GYxB5
 GpisdVPYevmQ==
X-IronPort-AV: E=Sophos;i="5.75,402,1589221800"; 
   d="scan'208";a="5175747"
X-Received: from unknown (HELO TOSBLRMBX0419.TOSHIBA-TSIP.COM) ([10.116.85.28])
  by peak.toshiba-tesi.com with ESMTP; 27 Jul 2020 17:45:15 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0419.TOSHIBA-TSIP.COM (10.116.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 27 Jul 2020 17:10:41 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Mon, 27 Jul 2020 17:10:41 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: Venkata Pyla <venkata.pyla@toshiba-tsip.com>,
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [isar-cip-core 2/3] start-qemu.sh: Use 'TARGET_IMAGE' to pick respective image file
Date: Mon, 27 Jul 2020 17:11:34 +0530
Message-ID: <20200727114135.368-3-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20200727114135.368-1-venkata.pyla@toshiba-tsip.com>
References: <20200727114135.368-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7gnhP3GqavX0MniTBA7VJd67x4520388AA=
Content-Type: multipart/mixed; boundary="481kuoPfzXkRTLkAIeyY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595850046;
 bh=Y78YmQ6Yq5ud8kN2oMKYm+sVPysmLCl4rsBG3WSESZI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=sduHI625xYeu00Uy9L1JSLoL0ln1CtzmNXulNPMKyzM2oRudTib/Oc3/0HTC1Ysazfi
 UkjoCFUHJy+WUHhZMpIn5r9D2MhZl1YSchDizrQMAJ7TSJy3XuLZ8iIXjxtoi9HHyhXWe
 tO6ogEzAvz2Yh6c+wchQWvCmK09pzP+/eX8=

--481kuoPfzXkRTLkAIeyY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Venkata Pyla <venkata.pyla@toshiba-tsip.com>

Use 'TARGET_IMAGE' to pick respective image file when starting qemu
by default 'TARGET_IMAGE' uses "cip-core-image".

to pick different target image set the 'TARGET_IMAGE' variable as below
e.g: $TARGET_IMAGE=cip-core-image-security ./start-qemu.sh amd64

Signed-off-by: Venkata Pyla <venkata.pyla@toshiba-tsip.com>
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
2.20.1

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


--481kuoPfzXkRTLkAIeyY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5022): https://lists.cip-project.org/g/cip-dev/message=
/5022
Mute This Topic: https://lists.cip-project.org/mt/75820362/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--481kuoPfzXkRTLkAIeyY--
