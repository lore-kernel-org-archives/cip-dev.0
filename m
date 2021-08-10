Return-Path: <SRS0=1g6J=NB=lists.cip-project.org=bounce+64572+6667+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D91C4338F
	for <cip-dev@archiver.kernel.org>; Tue, 10 Aug 2021 07:21:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A42360ED8
	for <cip-dev@archiver.kernel.org>; Tue, 10 Aug 2021 07:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A42360ED8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vVxrYY4521723x8uBPgjZsjT; Tue, 10 Aug 2021 00:21:12 -0700
X-Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web10.4894.1628580071728855131
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Aug 2021 00:21:12 -0700
IronPort-SDR: JdDcEGk8yDaZaq8brxA+s9YADBtcmRC27X4QvYnNGz27uDrkmtzK+2MhLaoxLo6G6LL8iDf0XK
 +9ZfaEXXwdsoQ1UhhAQcRvA8GX/KKPGvvj0nCdEq1WTIAz4yTODk8NOw0aFVwUXEow6208D0L+
 VokbUHbIC1chzgj0/HXzz5AJd7ydWO49G92fTAkp1ETDaxRsn2ZeVrvzpot9GxrxPtRAw5Pjre
 s6Sjt77mAAfTHspHyrTcxlRSc7CjlopzllgLZQaDS5AUf8LJSwL3G8TZP6twCtBoifKLsrU+1+
 0BS65YAz8UGVfuRkfIKs9aX/
X-IronPort-AV: E=Sophos;i="5.84,309,1620720000"; 
   d="scan'208";a="64464832"
X-Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 09 Aug 2021 23:21:11 -0800
IronPort-SDR: oRNx0V86JaElH0DYbyw1n17/BVgxM9PWCZWD6oSlJ8sNP3WniJNUZ8C0h88fDGwlRPn/6tQePv
 x9sDfB1kBxWPuKPjhjWVKxNvScuzgqEP0hGIQlq/x3XoxibzN6iOCgy9ALScQwTZrKhz4rd9bf
 HHuNNY/KN9NwYQI8B5Xi09Y40y2jFBDOFZHnikL8x1626VNnpxcT3USDsF1wZThjvy83GfsX1q
 vxD84DLZ4jDfCP6Wmq9GMf7jXvKJiyu8Vf5zS0fG/5o4C7j7H2vUaq57ws6xsoFhpWnZ5suWr8
 ZRU=
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev] [isar-cip-dev][PATCH] Uprevision the cip-kernel-config to latest one
Date: Tue, 10 Aug 2021 12:50:40 +0530
Message-ID: <20210810072040.716025-1-Srinuvasan_A@mentor.com>
MIME-Version: 1.0
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SXcGZbOan4U33h9Zp1ITlAYsx4520388AA=
Content-Type: multipart/mixed; boundary="YMaWen9lzxfhR8QCbPjb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628580072;
 bh=i7AbY/MIk8AQCuBWCliwajsIHAi4hC3+Pvvx4snr2Xw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=W2lMdDceJ4NTXyWeI6ALh9xIdhl5AlRWt5fJG4ilFjk1RocmlzJ6e5O1npFsLHH9tTj
 Em299G5Fk9tq9kLoUCPjBuyIfO3vzTWDjO7p0tlouRbH6XgTk1h1d+9z3pLGf7oD48Hcy
 qT8ZlN22OgdhwZdLBdRH6FYQOfg1xKOnclQ=

--YMaWen9lzxfhR8QCbPjb
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Srinuvasan A <srinuvasan_a@mentor.com>

Uprevision the cip-kernel-config to latest one.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 6362408..1afec88 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
 
 SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 
-SRCREV_cip-kernel-config ?= "b72318b9346f7262f6dd7511384ca61bd8b545c8"
+SRCREV_cip-kernel-config ?= "cd5d43e99f4d5f20707d7ac1e721bb22d4c9e16e"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
-- 
2.25.1


--YMaWen9lzxfhR8QCbPjb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6667): https://lists.cip-project.org/g/cip-dev/message/=
6667
Mute This Topic: https://lists.cip-project.org/mt/84788389/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YMaWen9lzxfhR8QCbPjb--
