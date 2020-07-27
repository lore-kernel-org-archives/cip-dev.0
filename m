Return-Path: <SRS0=NrbV=BG=lists.cip-project.org=bounce+64572+5023+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21A2C433E4
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 11:40:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CF32075A
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hmhVIwwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CF32075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5023+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qHuMYY4521723xltP8zgiUEv; Mon, 27 Jul 2020 04:40:46 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [])
 by mx.groups.io with SMTP id smtpd.web11.53494.1595850044463669930
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2020 04:40:46 -0700
IronPort-SDR: hB0G3/UDGaMBruzLFmgb4rmgF02nTOvsNqufiOlTB73DukTJG6j0ACyLriWLC3C5I0O8sHccUn
 ZRK6jl3q/0uA==
X-IronPort-AV: E=Sophos;i="5.75,402,1589221800"; 
   d="scan'208";a="5175749"
X-Received: from unknown (HELO TOSBLRMBX0419.TOSHIBA-TSIP.COM) ([10.116.85.28])
  by peak.toshiba-tesi.com with ESMTP; 27 Jul 2020 17:45:16 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0419.TOSHIBA-TSIP.COM (10.116.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 27 Jul 2020 17:10:42 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Mon, 27 Jul 2020 17:10:42 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: Venkata Pyla <venkata.pyla@toshiba-tsip.com>,
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [isar-cip-core 3/3] README: Add steps to build cip-security image
Date: Mon, 27 Jul 2020 17:11:35 +0530
Message-ID: <20200727114135.368-4-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20200727114135.368-1-venkata.pyla@toshiba-tsip.com>
References: <20200727114135.368-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VeTfIrxyw6LSPMLLxApnOMxTx4520388AA=
Content-Type: multipart/mixed; boundary="fzfM6rzyiGRE3uH3HOCR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595850046;
 bh=+OY5G0oMkHp2nppG30wjiANr2FO7BbenkW+5bpGJRqo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=hmhVIwwmE/tcw7CESerlJaRoeyn+GYoeEv7AjbF2dXzP2Lx9ru8ECs85bBfYkh85MeC
 SR00//5bF90ODzC2HX8mvDRv221UdJTaaeEoKBQlyrX1n7q+6sMVIOvwMe3Jit0Oj+a6e
 scIU1H7lxtWjiG7zmbshD+DgBqFLzCHLY2I=

--fzfM6rzyiGRE3uH3HOCR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Venkata Pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: Venkata Pyla <venkata.pyla@toshiba-tsip.com>
---
 README.md | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/README.md b/README.md
index 59a014b..26fbbef 100644
--- a/README.md
+++ b/README.md
@@ -36,6 +36,16 @@ card, run
     dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic.img \
        of=/dev/<medium-device> bs=1M status=progress
 
+## Building Security target images
+Building images for QEMU x86-64bit machine
+
+    ./kas-docker --isar build --target cip-core-image-security kas.yml:board-qemu-amd64.yml
+
+Run the generated securiy images on QEMU (x86-64bit)
+
+    TARGET_IMAGE=cip-core-image-security ./start-qemu.sh amd64
+
+
 ## Community Resources
 
 TBD
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


--fzfM6rzyiGRE3uH3HOCR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5023): https://lists.cip-project.org/g/cip-dev/message=
/5023
Mute This Topic: https://lists.cip-project.org/mt/75820363/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fzfM6rzyiGRE3uH3HOCR--
