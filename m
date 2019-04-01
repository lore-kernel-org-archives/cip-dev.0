From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 10:58:02 +0100
Subject: [cip-dev] [PATCH 4.19.y 03/17] clocksource/drivers/sh_cmt: Fix
	clocksource width for 32-bit machines
In-Reply-To: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554112696-20706-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 37e7742c55ba856eaec7e35673ee370f36eb17f3 upstream.

The driver seems to abuse *unsigned long* not only for the (32-bit)
register values but also for the 'sh_cmt_channel::total_cycles' which
needs to always be 64-bit -- as a result, the clocksource's mask is
needlessly clamped down to 32-bits on the 32-bit machines...

Fixes: 19bdc9d061bc ("clocksource: sh_cmt clocksource support")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/clocksource/sh_cmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index efaf00d..0c74489 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -100,7 +100,7 @@ struct sh_cmt_channel {
 	raw_spinlock_t lock;
 	struct clock_event_device ced;
 	struct clocksource cs;
-	unsigned long total_cycles;
+	u64 total_cycles;
 	bool cs_enabled;
 };
 
@@ -605,8 +605,8 @@ static u64 sh_cmt_clocksource_read(struct clocksource *cs)
 {
 	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
 	unsigned long flags;
-	unsigned long value;
 	u32 has_wrapped;
+	u64 value;
 	u32 raw;
 
 	raw_spin_lock_irqsave(&ch->lock, flags);
@@ -680,7 +680,7 @@ static int sh_cmt_register_clocksource(struct sh_cmt_channel *ch,
 	cs->disable = sh_cmt_clocksource_disable;
 	cs->suspend = sh_cmt_clocksource_suspend;
 	cs->resume = sh_cmt_clocksource_resume;
-	cs->mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
+	cs->mask = CLOCKSOURCE_MASK(sizeof(u64) * 8);
 	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used as clock source\n",
-- 
2.7.4
