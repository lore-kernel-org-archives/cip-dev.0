Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E0FCD5BA9
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 12:26:32 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web11.7150.1695126384220728768
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 05:26:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
X-CSE-ConnectionGUID: xVxx6gaHQlm++3A0BkpNQA==
X-CSE-MsgGUID: I0+9kzl1TGWs3Ck0nQcOCQ==
X-IronPort-AV: E=Sophos;i="6.02,159,1688457600"; 
   d="scan'208";a="17271267"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 19 Sep 2023 04:26:22 -0800
IronPort-SDR: hWu8dd+nqwTktbQu1ZnAfulnFZp2yriYgzdYXkECJFIpS2Go0f7MJU8DfKtDZ+7Vbd0wCHSpAw
 B86+akNSwmg/eM9YUxtiQFjdaLlNstHSwkFoc700O/d2ou6/u5fhHononyu9r3OI0AQQXphuQf
 lekulfxjV62cpBn/uCdVUE3icZA+chqC7/SjrM9w8WV8rQ/WAEAHzdnwS7ZimpMUo8G/4Xo4qm
 XNvd4FDAHZhxPxuv2dfFJNoamuY6I2ieFpK9/z1W0jvn/9aQOJxU0kQqAeizWJtn3iwjl/Su2E
 7Ko=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [PATCH][isar-cip-core] cip-kernel-config.inc: Bump the cip-kernel-config revision
Date: Tue, 19 Sep 2023 17:56:03 +0530
Message-ID: <20230919122603.68059-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 12:26:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13148

From: Srinuvasan A <srinuvasan.a@siemens.com>

One of our downstream target not booted with 6.1.x kernel, we found that
there is no dtb file generated for that target, hence enable the switch.

Ref: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/6bdb5d04

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 51b17c6..5013eb9 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "aca5978b5abf93b20df4efda067c3a3f461476e0"
+SRCREV_cip-kernel-config ?= "8133457d8e156c34eebe52d9affab9df3f7b597f"
-- 
2.34.1


