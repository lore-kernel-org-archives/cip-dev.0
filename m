X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.2184.1648666500371105066
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200"; 
   d="scan'208";a="115208950"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:32 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 990AB40D5446;
	Thu, 31 Mar 2022 03:55:31 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 27/39] clk: renesas: rzg2l: Add missing kerneldoc for resets
Date: Wed, 30 Mar 2022 19:54:42 +0100
Message-Id: <20220330185454.10887-28-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: <cip-dev.lists.cip-project.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 099ee03271208c880aa33b8833edfacd5010a89a upstream.

make W=3D1:

    drivers/clk/renesas/rzg2l-cpg.c:95: warning: Function parameter or memb=
er 'num_resets' not described in 'rzg2l_cpg_priv'

Add the missing kerneldoc for fields in struct rzg2l_cpg_priv and struct
rzg2l_cpg_info related to Module Resets.

Fixes: c3e67ad6f5a2c698 ("dt-bindings: clock: r9a07g044-cpg: Update clock/r=
eset definitions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/39c2c5fd4232b6620a4a56dba4e2b0d61476ee36.16=
34646869.git.geert+renesas@glider.be
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 1 +
 drivers/clk/renesas/rzg2l-cpg.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cp=
g.c
index 4021f6cabda4..a77cb47b75e7 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -74,6 +74,7 @@ struct sd_hw_data {
  * @clks: Array containing all Core and Module Clocks
  * @num_core_clks: Number of Core Clocks in clks[]
  * @num_mod_clks: Number of Module Clocks in clks[]
+ * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
  * @notifiers: Notifier chain to save/restore clock state for system resume
  * @info: Pointer to platform data
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cp=
g.h
index 952fca98ba71..da41bd2a7e74 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -164,6 +164,9 @@ struct rzg2l_reset {
  * @num_mod_clks: Number of entries in mod_clks[]
  * @num_hw_mod_clks: Number of Module Clocks supported by the hardware
  *
+ * @resets: Array of Module Reset definitions
+ * @num_resets: Number of entries in resets[]
+ *
  * @crit_mod_clks: Array with Module Clock IDs of critical clocks that
  *                 should not be disabled without a knowledgeable driver
  * @num_crit_mod_clks: Number of entries in crit_mod_clks[]
--=20
2.17.1


