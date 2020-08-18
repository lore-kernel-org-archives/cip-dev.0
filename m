Return-Path: <SRS0=H2RP=B4=lists.cip-project.org=bounce+64572+5133+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A38BC433E1
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 15:06:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA925207D3
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 15:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FzIHhp5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA925207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5133+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nMlxYY4521723xXYqXIAPHsE; Tue, 18 Aug 2020 08:06:38 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.68238.1597763196402184710
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2020 08:06:37 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07IF6YbR024825
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 18 Aug 2020 17:06:34 +0200
X-Received: from [167.87.130.66] ([167.87.130.66])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07IF6WFX028595
	for <cip-dev@lists.cip-project.org>; Tue, 18 Aug 2020 17:06:33 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [PATCH][isar-cip-core] linux-cip: Update kernel recipes to latest versions
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <5db309f8-15a3-d024-fcb3-ae0cad1c82a3@siemens.com>
Date: Tue, 18 Aug 2020 17:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: G1g2atjIv1pMdpUkZkMnKiu7x4520388AA=
Content-Type: multipart/mixed; boundary="UAhT20N9zgPmLQRQLa6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597763198;
 bh=ayZ2QaaMWwFt8t73sjHHLDtxcBHWUqkVILn/NAeWhjI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=FzIHhp5dNw2Imo4Th/ztIlGn73xdGM+KBkVtu2Fm6IpNs2rgfOZHR33ecFCpcaw1rxh
 1qGEYZeErONnipSqf0EC1rAqUXkdNfJIjmh4lhcv857EvOpWZEneUeUpQYpzYAjaSuzsI
 j8fEmhhbnod38TQLbMk52ZageTQEv/n534A=

--UAhT20N9zgPmLQRQLa6n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.19.72-cip10-rt3.bb => linux-cip-rt_4.19.135-cip31-rt13.bb} | 2 +-
 ...4.4.190-cip36-rt25.bb => linux-cip-rt_4.4.231-cip47-rt30.bb} | 2 +-
 .../{linux-cip_4.19.78-cip12.bb => linux-cip_4.19.138-cip32.bb} | 2 +-
 .../{linux-cip_4.4.196-cip38.bb => linux-cip_4.4.230-cip47.bb}  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.72-cip10-rt3.bb => linux-cip-rt_4.19.135-cip31-rt13.bb} (67%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.190-cip36-rt25.bb => linux-cip-rt_4.4.231-cip47-rt30.bb} (67%)
 rename recipes-kernel/linux/{linux-cip_4.19.78-cip12.bb => linux-cip_4.19.138-cip32.bb} (67%)
 rename recipes-kernel/linux/{linux-cip_4.4.196-cip38.bb => linux-cip_4.4.230-cip47.bb} (67%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.72-cip10-rt3.bb b/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
similarity index 67%
rename from recipes-kernel/linux/linux-cip-rt_4.19.72-cip10-rt3.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
index 423c0b5..7414f23 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.72-cip10-rt3.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "95d562cea75ca78858c22138a6fde5e70faa74778f6119f3e5d14cd1136fcba0"
+SRC_URI[sha256sum] = "3c3e49c4ad0dae3de409d51a5b8f6df163f7cc54350764d7c019741947a383db"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.190-cip36-rt25.bb b/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
similarity index 67%
rename from recipes-kernel/linux/linux-cip-rt_4.4.190-cip36-rt25.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
index fac0a17..8881071 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.190-cip36-rt25.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "7fe6c2bd0b61ac3a5b71f9078608afb4eef8a565f70cbb34fa9b35a3fa001177"
+SRC_URI[sha256sum] = "d1ff83665455830129f9a2197000abbe7440d30e29b37504c82324c777f0ebf5"
diff --git a/recipes-kernel/linux/linux-cip_4.19.78-cip12.bb b/recipes-kernel/linux/linux-cip_4.19.138-cip32.bb
similarity index 67%
rename from recipes-kernel/linux/linux-cip_4.19.78-cip12.bb
rename to recipes-kernel/linux/linux-cip_4.19.138-cip32.bb
index 7564492..59afd8e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.78-cip12.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.138-cip32.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "7825e6a879283effc05d1511b8220ab28f7d0191795567644889f9a30a449c44"
+SRC_URI[sha256sum] = "6b4dce2ff494b9a4cab212af855b78048756dc6ea3f136e25552b0e832e93eb6"
diff --git a/recipes-kernel/linux/linux-cip_4.4.196-cip38.bb b/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb
similarity index 67%
rename from recipes-kernel/linux/linux-cip_4.4.196-cip38.bb
rename to recipes-kernel/linux/linux-cip_4.4.230-cip47.bb
index 774f849..2303d49 100644
--- a/recipes-kernel/linux/linux-cip_4.4.196-cip38.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "883421193ff17bd0d66099a1bfa7ebd97a23b24f09ea13f0933037132563cd3a"
+SRC_URI[sha256sum] = "8e91374801da67bc240b08cd0d61a1b528c23c870cf73ba33cc8f02198f6c531"
-- 
2.26.2

--UAhT20N9zgPmLQRQLa6n
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5133): https://lists.cip-project.org/g/cip-dev/message=
/5133
Mute This Topic: https://lists.cip-project.org/mt/76266813/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--UAhT20N9zgPmLQRQLa6n--
