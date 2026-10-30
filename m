Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5797.1793341083446528049
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 23:18:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Mp0Wbck8;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1793341071;x=1794550671;bh=zAQB5aYo0sFRYgzhl90d+YTT8VGAg0sQ2SAUq08DkFk=;b=Mp0
	Wbck84aa+53jsoInwB+/E7QyPCnOOMCKSkUw9rq8qZVkeQZdomtWSJMbf6ISj6GKL8tKSv1XxvbBF
	E5xhbRMJQa3Q2offB48H/RcWLTm1txLEzHxQzZY3jyJsHZ97ScxuPKF7wROA8StqlklaojoWrwlq8
	o097KbtBp+0s+XU8IhvrfTApg7WtKWi5Pz9KVYGvNoIUtR/AAT5kGvyEbn+QIFnzrD9Edrxif840I
	06KcCObNKCCDwiBV7dcohkinRcf8fsb2BMzaOX4WPJZuiy/37oxaqgnpvKSoC/ln5IkSa+ZdxZj59
	HBpXwywhCj+pWFc+F2mBqTvK1rnrJ+g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 69U6Ho9B923087; Fri, 30 Oct 2026 15:17:50 +0900
X-Iguazu-Qid: 2yAaPpRdHKYxX1i2F9
X-Iguazu-QSIG: v=2; s=1; t=1793341069; q=2yAaPpRdHKYxX1i2F9; m=SOLsQ22GYj98QGbnj67qUsdB/Gb5ka5YWlZlx8ZakWo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jG9rD50LDzyPg; Fri, 30 Oct 2026 15:17:48 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org, uli@fpond.eu, biju.das.jz@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.12.y-cip] irqchip/renesas-rzv2h: Restore function parameter for suspend/resume
Date: Fri, 30 Oct 2026 15:17:47 +0900
X-TSB-HOP2: ON
Message-Id: <1793341067-15723-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 06:18:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24582
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Commit 20a4a45ee35f ("syscore: Pass context data to callbacks") modified
the callback functionality in `syscore`. This commit also included updates
to the relevant drivers; however, irqchip/renesas-rzv2h was not included in
these changes and therefore requires its own fix.
This restore function parameter for rzv2h_irqc_irq_{suspend,resume}(), and
use register_syscore() instead of register_syscore_ops().

Fixes: f443abb80780 ("irqchip/renesas-rzv2h: Add suspend/resume support")
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

NOTE: This is an issue that occurs after merging v6.12.114.

 drivers/irqchip/irq-renesas-rzv2h.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index c12f7072f5cc..a5ef1b42380c 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -508,7 +508,7 @@ static int rzv2h_icu_swpe_set_irqchip_state(struct irq_data *d, enum irqchip_irq
 	return 0;
 }
 
-static int rzv2h_irqc_irq_suspend(void)
+static int rzv2h_irqc_irq_suspend(void *data)
 {
 	struct rzv2h_irqc_reg_cache *cache = &rzv2h_icu_data->cache;
 	void __iomem *base = rzv2h_icu_data->base;
@@ -521,7 +521,7 @@ static int rzv2h_irqc_irq_suspend(void)
 	return 0;
 }
 
-static void rzv2h_irqc_irq_resume(void)
+static void rzv2h_irqc_irq_resume(void *data)
 {
 	struct rzv2h_irqc_reg_cache *cache = &rzv2h_icu_data->cache;
 	void __iomem *base = rzv2h_icu_data->base;
@@ -537,11 +537,16 @@ static void rzv2h_irqc_irq_resume(void)
 	writel_relaxed(cache->nitsr, base + ICU_NITSR);
 }
 
-static struct syscore_ops rzv2h_irqc_syscore_ops = {
+static const struct syscore_ops rzv2h_irqc_syscore_ops = {
 	.suspend	= rzv2h_irqc_irq_suspend,
 	.resume		= rzv2h_irqc_irq_resume,
 };
 
+
+static struct syscore rzv2h_irqc_syscore = {
+	.ops = &rzv2h_irqc_syscore_ops,
+};
+
 static const struct irq_chip rzv2h_icu_tint_chip = {
 	.name			= "rzv2h-icu",
 	.irq_eoi		= rzv2h_icu_tint_eoi,
@@ -873,7 +878,7 @@ static int rzv2h_icu_init_common(struct device_node *node, struct device_node *p
 
 	rzv2h_icu_data->info = hw_info;
 
-	register_syscore_ops(&rzv2h_irqc_syscore_ops);
+	register_syscore(&rzv2h_irqc_syscore);
 
 	ret = rzv2h_icu_setup_irqs(pdev, irq_domain);
 	if (ret)
-- 
2.55.0


