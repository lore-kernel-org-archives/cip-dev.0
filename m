Return-Path: <SRS0=LEbO=B7=lists.cip-project.org=bounce+64572+5177+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E391C433E5
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207C620FC3
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="O/fVvayd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207C620FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5177+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8oB2YY4521723xTYbErdnvh7; Fri, 21 Aug 2020 03:58:33 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.130425.1598002998984331784
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:33 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170304"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:32 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 49DB2423206E;
	Fri, 21 Aug 2020 18:43:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 09/36] clk: renesas: rcar-gen3: Add RPC clocks
Date: Fri, 21 Aug 2020 10:42:45 +0100
Message-Id: <20200821094312.3249-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pCn4XcSxORruIl6wxxVXtLfZx4520388AA=
Content-Type: multipart/mixed; boundary="BamRBWgrYFK12K7W5dep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007513;
 bh=sV8uwYIzY/joDcFAajUHIyGua8SSWZdkEbi0CKqmfYc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=O/fVvayd6z+EcENdCV807rA4DZk17DOmBEAYQkKGd2sHQGjLXxpMcO6JFvZcsxhEIvH
 hjWEomeZ8CUNU9E+HFH9dx4yTboA3xITkisiDoRazV/TweTQ/Zd/hMPYXIShBNWRxxhh5
 9hwNylyWEgA9gKqCSnyK0HaCSqemGQvA3jg=

--BamRBWgrYFK12K7W5dep

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit db4a0073cc82a95d8d1a9b05fde82355fcce77d8 upstream.

The RPCSRC internal clock is controlled by the RPCCKCR.DIV[4:3] on all
the R-Car gen3 SoCs except V3M (R8A77970) but the encoding of this field
is different between SoCs; it makes sense to support the most common case
of this encoding in the R-Car gen3 CPG driver...

After adding the RPCSRC clock, we can add the RPC[D2] clocks derived from
it and controlled by the RPCCKCR register on all the R-Car gen3 SoCs except
V3M (R8A77970); the composite clock driver seems handy for this task, using
the spinlock added in the previous patch...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 101 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rcar-gen3-cpg.h |   4 ++
 2 files changed, 105 insertions(+)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 0b96b4bc3997..e8fc3b8a875a 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -424,6 +424,92 @@ static struct clk * __init cpg_sd_clk_register(const char *name,
 	return clk;
 }
 
+struct rpc_clock {
+	struct clk_divider div;
+	struct clk_gate gate;
+	/*
+	 * One notifier covers both RPC and RPCD2 clocks as they are both
+	 * controlled by the same RPCCKCR register...
+	 */
+	struct cpg_simple_notifier csn;
+};
+
+static const struct clk_div_table cpg_rpcsrc_div_table[] = {
+	{ 2, 5 }, { 3, 6 }, { 0, 0 },
+};
+
+static const struct clk_div_table cpg_rpc_div_table[] = {
+	{ 1, 2 }, { 3, 4 }, { 5, 6 }, { 7, 8 }, { 0, 0 },
+};
+
+static struct clk * __init cpg_rpc_clk_register(const char *name,
+	void __iomem *base, const char *parent_name,
+	struct raw_notifier_head *notifiers)
+{
+	struct rpc_clock *rpc;
+	struct clk *clk;
+
+	rpc = kzalloc(sizeof(*rpc), GFP_KERNEL);
+	if (!rpc)
+		return ERR_PTR(-ENOMEM);
+
+	rpc->div.reg = base + CPG_RPCCKCR;
+	rpc->div.width = 3;
+	rpc->div.table = cpg_rpc_div_table;
+	rpc->div.lock = &cpg_lock;
+
+	rpc->gate.reg = base + CPG_RPCCKCR;
+	rpc->gate.bit_idx = 8;
+	rpc->gate.flags = CLK_GATE_SET_TO_DISABLE;
+	rpc->gate.lock = &cpg_lock;
+
+	rpc->csn.reg = base + CPG_RPCCKCR;
+
+	clk = clk_register_composite(NULL, name, &parent_name, 1, NULL, NULL,
+				     &rpc->div.hw,  &clk_divider_ops,
+				     &rpc->gate.hw, &clk_gate_ops, 0);
+	if (IS_ERR(clk)) {
+		kfree(rpc);
+		return clk;
+	}
+
+	cpg_simple_notifier_register(notifiers, &rpc->csn);
+	return clk;
+}
+
+struct rpcd2_clock {
+	struct clk_fixed_factor fixed;
+	struct clk_gate gate;
+};
+
+static struct clk * __init cpg_rpcd2_clk_register(const char *name,
+						  void __iomem *base,
+						  const char *parent_name)
+{
+	struct rpcd2_clock *rpcd2;
+	struct clk *clk;
+
+	rpcd2 = kzalloc(sizeof(*rpcd2), GFP_KERNEL);
+	if (!rpcd2)
+		return ERR_PTR(-ENOMEM);
+
+	rpcd2->fixed.mult = 1;
+	rpcd2->fixed.div = 2;
+
+	rpcd2->gate.reg = base + CPG_RPCCKCR;
+	rpcd2->gate.bit_idx = 9;
+	rpcd2->gate.flags = CLK_GATE_SET_TO_DISABLE;
+	rpcd2->gate.lock = &cpg_lock;
+
+	clk = clk_register_composite(NULL, name, &parent_name, 1, NULL, NULL,
+				     &rpcd2->fixed.hw, &clk_fixed_factor_ops,
+				     &rpcd2->gate.hw, &clk_gate_ops, 0);
+	if (IS_ERR(clk))
+		kfree(rpcd2);
+
+	return clk;
+}
+
 
 static const struct rcar_gen3_cpg_pll_config *cpg_pll_config __initdata;
 static unsigned int cpg_clk_extalr __initdata;
@@ -598,6 +684,21 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 		}
 		break;
 
+	case CLK_TYPE_GEN3_RPCSRC:
+		return clk_register_divider_table(NULL, core->name,
+						  __clk_get_name(parent), 0,
+						  base + CPG_RPCCKCR, 3, 2, 0,
+						  cpg_rpcsrc_div_table,
+						  &cpg_lock);
+
+	case CLK_TYPE_GEN3_RPC:
+		return cpg_rpc_clk_register(core->name, base,
+					    __clk_get_name(parent), notifiers);
+
+	case CLK_TYPE_GEN3_RPCD2:
+		return cpg_rpcd2_clk_register(core->name, base,
+					      __clk_get_name(parent));
+
 	default:
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index 131ede2fd8ca..2b39499c855c 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -25,6 +25,9 @@ enum rcar_gen3_clk_types {
 	CLK_TYPE_GEN3_Z,
 	CLK_TYPE_GEN3_OSC,	/* OSC EXTAL predivider and fixed divider */
 	CLK_TYPE_GEN3_RCKSEL,	/* Select parent/divider using RCKCR.CKSEL */
+	CLK_TYPE_GEN3_RPCSRC,
+	CLK_TYPE_GEN3_RPC,
+	CLK_TYPE_GEN3_RPCD2,
 };
 
 #define DEF_GEN3_SD(_name, _id, _parent, _offset)	\
@@ -59,6 +62,7 @@ struct rcar_gen3_cpg_pll_config {
 	u8 osc_prediv;
 };
 
+#define CPG_RPCCKCR	0x238
 #define CPG_RCKCR	0x240
 
 struct clk *rcar_gen3_cpg_clk_register(struct device *dev,
-- 
2.17.1


--BamRBWgrYFK12K7W5dep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5177): https://lists.cip-project.org/g/cip-dev/message=
/5177
Mute This Topic: https://lists.cip-project.org/mt/76326716/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BamRBWgrYFK12K7W5dep--
