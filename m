Return-Path: <SRS0=A8/L=LJ=lists.cip-project.org=bounce+64572+6522+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C89C48BE5
	for <cip-dev@archiver.kernel.org>; Tue, 15 Jun 2021 05:20:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95B861413
	for <cip-dev@archiver.kernel.org>; Tue, 15 Jun 2021 05:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95B861413
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6522+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id b5MZYY4521723xyY1Ros6rGT; Mon, 14 Jun 2021 22:20:30 -0700
X-Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web09.5308.1623734429563540011
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jun 2021 22:20:29 -0700
IronPort-SDR: 2DAiz7uTXjruaUtE6nSBF8FvAFHIUMck82nKGNRtng70UGv84Bx2nGKyaA5Sb5mCIsbSisUyZU
 TVUIwK36IrC3aIod2QkmDO3Vj7kuZNk5kPVLXKsdDgBLBDKT3TOIx5LdBrX22NjKx5jj9PDYVz
 Seb+UEmYsn50Puv4CqAXLJ0mZdyZxY+KZHQj2h1EYuqZkMVKi6+AkXdypqhDT+NJSQlJhprZGW
 89G3IjL9cq0WXXtprJwJu2b4GkUHf6oqfAO1HWY2cvXiRX5eQqSxlPinN4QW/Th5+zoDctiZx4
 7kw=
X-IronPort-AV: E=Sophos;i="5.83,275,1616486400"; 
   d="scan'208";a="62552891"
X-Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 14 Jun 2021 21:20:28 -0800
IronPort-SDR: YaOIBc9NFSRSaIS26JUAsecRKLN0rKqSXJiAQcRRKdj9Y/vtD7C1oLqkmBqOFrEFmqsZb1jP0r
 erWU14b0/Ukw4YQxIkY1KSYzle8lVEsr6KSnakmRlw2Bl2x0YnA1vZLJgkW4HZxRIfhKHzujq/
 E2MVsncdZDcT+WtOetviV6sTpXBdMM/ltxBy90bw/ZWm7b0uKe198RszBdcB8Bnnq/fOrtVKDX
 VPC11lim9oNmaJoHXf5PI5eN1kNaHNYSnCtC6HifSgbTocAU8zNmj6cBxD/M3oiZ5sxjxppk30
 hDQ=
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <Srinuvasan_A@mentor.com>
Subject: [cip-dev] [isar-cip-dev][PATCH] linux-cip-common.inc: Uprev the cip-kernel-config
Date: Tue, 15 Jun 2021 10:50:06 +0530
Message-ID: <20210615052006.1198664-1-Srinuvasan_A@mentor.com>
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
X-Gm-Message-State: 0oaf6JH55QwmHlLdbojNedTbx4520388AA=
Content-Type: multipart/mixed; boundary="S8sTiRpiySwXmZJATDtN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623734430;
 bh=snjv9VhXp4jfF98NLwmZY4cpedTay4ckJR/cw0pxH3U=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=DPX3bMnCprYpePN94HSjptR2ls5PJu6SvkT69PbbSbgmU7RDJHYVZHXqcLbUWF5h1TK
 urn2lg1cZQZtTYwAsNHHdcPMkOPj8O9A0ZA847vC+uXIIXvAypwpN8Yq7q4/q5Uzdq2wX
 rBcyVp9wDACAj+gZh18YBE87azMEasA3xyg=

--S8sTiRpiySwXmZJATDtN
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Bump the cip-kernel-config revision for brings the User and Sync
kselftest.

Signed-off-by: Srinuvasan A <Srinuvasan_A@mentor.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 021efcd..6362408 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
 
 SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 
-SRCREV_cip-kernel-config ?= "9fa9154c77ee8eeca534aa436c23582c0c59c39f"
+SRCREV_cip-kernel-config ?= "b72318b9346f7262f6dd7511384ca61bd8b545c8"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
-- 
2.25.1


--S8sTiRpiySwXmZJATDtN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6522): https://lists.cip-project.org/g/cip-dev/message=
/6522
Mute This Topic: https://lists.cip-project.org/mt/83525386/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--S8sTiRpiySwXmZJATDtN--
