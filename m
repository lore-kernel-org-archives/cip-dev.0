Return-Path: <SRS0=ALKQ=FS=lists.cip-project.org=bounce+64572+5961+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE17CC4361B
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:24:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223E720771
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223E720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5961+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rxQFYY4521723xODlSuIQOYZ; Mon, 14 Dec 2020 01:24:10 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.32060.1607937845096117121
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Dec 2020 01:24:05 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0BE9O2So018041
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 14 Dec 2020 10:24:02 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.32.81])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0BE9O1K1027191;
	Mon, 14 Dec 2020 10:24:02 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH] Update version of cip-kernel-config
Date: Mon, 14 Dec 2020 10:24:01 +0100
Message-Id: <20201214092401.537-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JzydsZE1vGxhER3Wj9DnHcz1x4520388AA=
Content-Type: multipart/mixed; boundary="PpPuKsNQzVsSgcPETKma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607937850;
 bh=VGr00kGP/1lTS8ngtAymBX254DHzmNuZCm4gBIn8QXw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jMbILPGcMXnhdoujF+yNgdSPidUIbuH/Kyr7shJVLFjItKdaepnW1xjuGxSyUzVggdU
 T5y4DmWPFjhL/WHlkPDtzS72ykG+iaUGB1o/S/XZlSmxWBDtZBME5TM/KZdYU9BUnK+wg
 hDQMTFZOrADQVyChp3rydPNTCedv8Q17cdI=

--PpPuKsNQzVsSgcPETKma
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 7e09090..6db1d1d 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -26,6 +26,6 @@ SRC_URI += " \
 SRC_URI_append = " ${@conditional("USE_CIP_KERNEL_CONFIG", "1", \
     "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config", \
     "file://${KERNEL_DEFCONFIG}",d)}"
-SRCREV_cip-kernel-config ?= "ca24d965adf77730caf1cd32bdfcffd69e369502"
+SRCREV_cip-kernel-config ?= "7f2930b9667372f94f2edb42ca9cf6fc6c0aed50"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
-- 
2.20.1


--PpPuKsNQzVsSgcPETKma
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5961): https://lists.cip-project.org/g/cip-dev/message=
/5961
Mute This Topic: https://lists.cip-project.org/mt/78947115/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PpPuKsNQzVsSgcPETKma--
