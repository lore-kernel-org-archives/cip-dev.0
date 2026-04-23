Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59271F589A0
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 12:06:44 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17968.1776945994667154618
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2026 05:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: GoSg5TddTomyRbwXBxSAyQ==
X-CSE-MsgGUID: rnPNVyq2R8eUocaswxEf6A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Apr 2026 21:06:39 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C8820419B45D;
	Thu, 23 Apr 2026 21:06:38 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 5.10.y-cip v2 05/10] clk: renesas: Use IS_ERR() for pointers that cannot be NULL
Date: Thu, 23 Apr 2026 08:06:25 -0400
Message-ID: <20260423120630.1487798-6-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423120630.1487798-1-chris.brandt@renesas.com>
References: <20260423120630.1487798-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2026 12:06:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22798

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 6a636d203cc8d29ae73116bbca8b0ea2c7a90d7f upstream.

The use of IS_ERR_OR_NULL() suggests that "clk" can be a NULL pointer.
Hence smatch assumes so, and issues a "passing zero to 'PTR_ERR'"
warning.

At these checkpoints, "clk" always contains either a valid pointer, or
an error pointer (none of the functions called return NULL pointers).
Hence replace IS_ERR_OR_NULL() by IS_ERR().

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202408032025.ve2JMaoV-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/81260328acb5c78e915ab04afad3901a31c16128.1758793709.git.geert+renesas@glider.be
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 drivers/clk/renesas/rzg2l-cpg.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index a5a68e1e7549..e373ae4360a2 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -388,7 +388,7 @@ static void __init cpg_mssr_register_core_clk(const struct cpg_core_clk *core,
 		break;
 	}
 
-	if (IS_ERR_OR_NULL(clk))
+	if (IS_ERR(clk))
 		goto fail;
 
 	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index a237150e5932..0c0d9d76c4d6 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1183,7 +1183,7 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 		goto fail;
 	}
 
-	if (IS_ERR_OR_NULL(clk))
+	if (IS_ERR(clk))
 		goto fail;
 
 	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
-- 
2.52.0


