Return-Path: <SRS0=0SpF=IC=lists.cip-project.org=bounce+64572+6212+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACE0C433DB
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 17:24:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEE164E89
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 17:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEE164E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6212+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WGUcYY4521723xflGtM6g1fs; Thu, 04 Mar 2021 09:24:39 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.2077.1614878678462039665
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Mar 2021 09:24:39 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 124HOah4022917
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 4 Mar 2021 18:24:36 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.94.54])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 124H9Y6l031858;
	Thu, 4 Mar 2021 18:09:35 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 2/2] linux-cip: Update cip-kernel-config
Date: Thu,  4 Mar 2021 18:09:34 +0100
Message-Id: <20210304170934.7424-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210304170934.7424-1-Quirin.Gylstorff@siemens.com>
References: <20210304170934.7424-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IyfDtmcem8D7be3OeaKh1Tltx4520388AA=
Content-Type: multipart/mixed; boundary="HsHJZTEKJbwwkUvzePbE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614878679;
 bh=/oA3wuovewPXH20hc24w7PYYLd6RWbbrFysso6hDN6Q=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qZTYoXrifqz7TcX3r2Y4/o18dlRb0k885xkrmW54hfxH7BOVcbwAFZ5V/QPuAQvwddY
 fvY+LEvLsAcGNWE5gseZfkMW+2OCkdekQ5HwmClk27rYlyIcaOvxhbjkD7YRKonYR04H/
 dx6WH5YAgiEPy/1XjrtTtLZJ55/TKoZvq7M=

--HsHJZTEKJbwwkUvzePbE
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Update the commmit to "22001e31c9ddf93b266b00c563e7b92f0ee21548".

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 6db1d1d..85696f8 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -26,6 +26,6 @@ SRC_URI += " \
 SRC_URI_append = " ${@conditional("USE_CIP_KERNEL_CONFIG", "1", \
     "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config", \
     "file://${KERNEL_DEFCONFIG}",d)}"
-SRCREV_cip-kernel-config ?= "7f2930b9667372f94f2edb42ca9cf6fc6c0aed50"
+SRCREV_cip-kernel-config ?= "22001e31c9ddf93b266b00c563e7b92f0ee21548"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
-- 
2.20.1


--HsHJZTEKJbwwkUvzePbE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6212): https://lists.cip-project.org/g/cip-dev/message=
/6212
Mute This Topic: https://lists.cip-project.org/mt/81082367/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HsHJZTEKJbwwkUvzePbE--
