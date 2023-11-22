Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB9C61D9B
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 14:32:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20864.1700663522347675239
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 06:32:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="183887514"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Nov 2023 23:32:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 89CA5400720A;
	Wed, 22 Nov 2023 23:32:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/10] clk: Add trace events for rate requests
Date: Wed, 22 Nov 2023 14:31:49 +0000
Message-Id: <20231122143156.204055-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 14:32:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13627

From: Maxime Ripard <maxime@cerno.tech>

commit 49e62e0d96baf7236615e4ec2878d8db229de9c2 upstream.

It is currently fairly difficult to follow what clk_rate_request are
issued, and how they have been modified once done.

Indeed, there's multiple paths that can be taken, some functions are
recursive and will just forward the request to its parent, etc.

Adding a lot of debug prints is just not very convenient, so let's add
trace events for the clock requests, one before they are submitted and
one after they are returned.

That way we can simply toggle the tracing on without modifying the
kernel code and without affecting performances or the kernel logs too
much.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://lore.kernel.org/r/20221018-clk-rate-request-tracing-v2-2-5170b363c413@cerno.tech
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk.c          | 31 +++++++++++++++++++++++++++
 include/trace/events/clk.h | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 33fedbd096f3..755df2133800 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -603,10 +603,15 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 			}
 
 			clk_core_forward_rate_req(core, req, parent, &parent_req, req->rate);
+
+			trace_clk_rate_request_start(&parent_req);
+
 			ret = clk_core_round_rate_nolock(parent, &parent_req);
 			if (ret)
 				return ret;
 
+			trace_clk_rate_request_done(&parent_req);
+
 			best = parent_req.rate;
 		} else if (parent) {
 			best = clk_core_get_rate_nolock(parent);
@@ -630,10 +635,15 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 			struct clk_rate_request parent_req;
 
 			clk_core_forward_rate_req(core, req, parent, &parent_req, req->rate);
+
+			trace_clk_rate_request_start(&parent_req);
+
 			ret = clk_core_round_rate_nolock(parent, &parent_req);
 			if (ret)
 				continue;
 
+			trace_clk_rate_request_done(&parent_req);
+
 			parent_rate = parent_req.rate;
 		} else {
 			parent_rate = clk_core_get_rate_nolock(parent);
@@ -1551,10 +1561,15 @@ static int clk_core_round_rate_nolock(struct clk_core *core,
 		struct clk_rate_request parent_req;
 
 		clk_core_forward_rate_req(core, req, core->parent, &parent_req, req->rate);
+
+		trace_clk_rate_request_start(&parent_req);
+
 		ret = clk_core_round_rate_nolock(core->parent, &parent_req);
 		if (ret)
 			return ret;
 
+		trace_clk_rate_request_done(&parent_req);
+
 		req->best_parent_rate = parent_req.rate;
 		req->rate = parent_req.rate;
 
@@ -1605,10 +1620,14 @@ unsigned long clk_hw_round_rate(struct clk_hw *hw, unsigned long rate)
 
 	clk_core_init_rate_req(hw->core, &req, rate);
 
+	trace_clk_rate_request_start(&req);
+
 	ret = clk_core_round_rate_nolock(hw->core, &req);
 	if (ret)
 		return 0;
 
+	trace_clk_rate_request_done(&req);
+
 	return req.rate;
 }
 EXPORT_SYMBOL_GPL(clk_hw_round_rate);
@@ -1637,8 +1656,12 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 
 	clk_core_init_rate_req(clk->core, &req, rate);
 
+	trace_clk_rate_request_start(&req);
+
 	ret = clk_core_round_rate_nolock(clk->core, &req);
 
+	trace_clk_rate_request_done(&req);
+
 	if (clk->exclusive_count)
 		clk_core_rate_protect(clk->core);
 
@@ -2130,10 +2153,14 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 
 		clk_core_init_rate_req(core, &req, rate);
 
+		trace_clk_rate_request_start(&req);
+
 		ret = clk_core_determine_round_nolock(core, &req);
 		if (ret < 0)
 			return NULL;
 
+		trace_clk_rate_request_done(&req);
+
 		best_parent_rate = req.best_parent_rate;
 		new_rate = req.rate;
 		parent = req.best_parent_hw ? req.best_parent_hw->core : NULL;
@@ -2329,8 +2356,12 @@ static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
 
 	clk_core_init_rate_req(core, &req, req_rate);
 
+	trace_clk_rate_request_start(&req);
+
 	ret = clk_core_round_rate_nolock(core, &req);
 
+	trace_clk_rate_request_done(&req);
+
 	/* restore the protection */
 	clk_core_rate_restore_protect(core, cnt);
 
diff --git a/include/trace/events/clk.h b/include/trace/events/clk.h
index e19edc63ee95..daed3c7a48c1 100644
--- a/include/trace/events/clk.h
+++ b/include/trace/events/clk.h
@@ -264,6 +264,49 @@ DEFINE_EVENT(clk_duty_cycle, clk_set_duty_cycle_complete,
 	TP_ARGS(core, duty)
 );
 
+DECLARE_EVENT_CLASS(clk_rate_request,
+
+	TP_PROTO(struct clk_rate_request *req),
+
+	TP_ARGS(req),
+
+	TP_STRUCT__entry(
+		__string(        name, req->core ? req->core->name : "none")
+		__string(       pname, req->best_parent_hw ? clk_hw_get_name(req->best_parent_hw) : "none" )
+		__field(unsigned long,           min                       )
+		__field(unsigned long,           max                       )
+		__field(unsigned long,           prate                     )
+	),
+
+	TP_fast_assign(
+		__assign_str(name, req->core ? req->core->name : "none");
+		__assign_str(pname, req->best_parent_hw ? clk_hw_get_name(req->best_parent_hw) : "none");
+		__entry->min = req->min_rate;
+		__entry->max = req->max_rate;
+		__entry->prate = req->best_parent_rate;
+	),
+
+	TP_printk("%s min %lu max %lu, parent %s (%lu)", __get_str(name),
+		  (unsigned long)__entry->min,
+		  (unsigned long)__entry->max,
+		  __get_str(pname),
+		  (unsigned long)__entry->prate)
+);
+
+DEFINE_EVENT(clk_rate_request, clk_rate_request_start,
+
+	TP_PROTO(struct clk_rate_request *req),
+
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(clk_rate_request, clk_rate_request_done,
+
+	TP_PROTO(struct clk_rate_request *req),
+
+	TP_ARGS(req)
+);
+
 #endif /* _TRACE_CLK_H */
 
 /* This part must be outside protection */
-- 
2.25.1


