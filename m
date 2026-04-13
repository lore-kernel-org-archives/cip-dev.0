Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55989F34C6F
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 17:17:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.277700.1776100659634165962
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 10:17:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: xJjN2N47S7i3TzJ6L9DvIg==
X-CSE-MsgGUID: iKCwmQksQsmLha7AVgWWgA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Apr 2026 02:17:41 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E63D74036C46;
	Tue, 14 Apr 2026 02:17:40 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 6.12.y-cip 5/7] clk: renesas: Use IS_ERR() for pointers that cannot be NULL
Date: Mon, 13 Apr 2026 13:17:31 -0400
Message-ID: <20260413171733.3088070-5-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171733.3088070-1-chris.brandt@renesas.com>
References: <20260413171733.3088070-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 17:17:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22686

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
 drivers/clk/renesas/rzv2h-cpg.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index eb469a06e690..92f76b937e83 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -485,7 +485,7 @@ static void __init cpg_mssr_register_core_clk(const struct cpg_core_clk *core,
 		break;
 	}

-	if (IS_ERR_OR_NULL(clk))
+	if (IS_ERR(clk))
 		goto fail;

 	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index a1a781fbeaef..6abf3f6000bd 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1183,7 +1183,7 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 		goto fail;
 	}

-	if (IS_ERR_OR_NULL(clk))
+	if (IS_ERR(clk))
 		goto fail;

 	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 3eedd173ab1c..2f54458778b8 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -1099,7 +1099,7 @@ rzv2h_cpg_register_core_clk(const struct cpg_core_clk *core,
 		goto fail;
 	}

-	if (IS_ERR_OR_NULL(clk))
+	if (IS_ERR(clk))
 		goto fail;

 	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
--
2.52.0


