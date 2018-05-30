From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 May 2018 18:36:04 +0100
Subject: [cip-dev] [PATCH v2 08/11] clocksource: sh_cmt: Compute rate before
	registration again
In-Reply-To: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
References: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527701767-41785-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Nicolai Stange <nicstange@gmail.com>

With the upcoming NTP correction related rate adjustments to be implemented
in the clockevents core, the latter needs to get informed about every rate
change of a clockevent device made after its registration.

Currently, sh_cmt violates this requirement in that it registers its
clockevent device with a dummy rate and sets its final ->mult and ->shift
values from its ->set_state_oneshot() and ->set_state_periodic() functions
respectively.

This patch moves the setting of the clockevent device's ->mult and ->shift
values to before its registration.

Note that there has been some back and forth regarding this question with
respect to the clocksource also provided by this driver:
  commit f4d7c3565c16 ("clocksource: sh_cmt: compute mult and shift before
                        registration")
moves the rate determination from the clocksource's ->enable() function to
before its registration. OTOH, the later
  commit 3593f5fe40a1 ("clocksource: sh_cmt: __clocksource_updatefreq_hz()
                        update")
basically reverts this, saying
  "Without this patch the old code uses clocksource_register() together
   with a hack that assumes a never changing clock rate."

However, I checked all current sh_cmt users in arch/sh as well as in
arch/arm/mach-shmobile carefully and right now, none of them changes any
rate in any clock tree relevant to sh_cmt after their respective
time_init(). Since all sh_cmt instances are created after time_init(), none
of them should ever observe any clock rate changes.

What's more, both, a clocksource as well as a clockevent device, can
immediately get selected for use at their registration and thus, enabled
at this point already. So it's probably safer to assume a "never changing
clock rate" here.

- Move the struct sh_cmt_channel's ->rate member to struct sh_cmt_device:
  it's a property of the underlying clock which is in turn specific to
  the sh_cmt_device.
- Determine the ->rate value in sh_cmt_setup() at device probing rather
  than at first usage.
- Set the clockevent device's ->mult and ->shift values right before its
  registration.
- Although not strictly necessary for the upcoming clockevent core changes,
  set the clocksource's rate at its registration for consistency.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
(cherry picked from commit 890f423b266623e1cfb3a97b864f3e5039bdfbb9)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/clocksource/sh_cmt.c | 45 ++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 103c493..3038885 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -103,7 +103,6 @@ struct sh_cmt_channel {
 	unsigned long match_value;
 	unsigned long next_match_value;
 	unsigned long max_match_value;
-	unsigned long rate;
 	raw_spinlock_t lock;
 	struct clock_event_device ced;
 	struct clocksource cs;
@@ -118,6 +117,7 @@ struct sh_cmt_device {
 
 	void __iomem *mapbase;
 	struct clk *clk;
+	unsigned long rate;
 
 	raw_spinlock_t lock; /* Protect the shared start/stop register */
 
@@ -320,7 +320,7 @@ static void sh_cmt_start_stop_ch(struct sh_cmt_channel *ch, int start)
 	raw_spin_unlock_irqrestore(&ch->cmt->lock, flags);
 }
 
-static int sh_cmt_enable(struct sh_cmt_channel *ch, unsigned long *rate)
+static int sh_cmt_enable(struct sh_cmt_channel *ch)
 {
 	int k, ret;
 
@@ -340,11 +340,9 @@ static int sh_cmt_enable(struct sh_cmt_channel *ch, unsigned long *rate)
 
 	/* configure channel, periodic mode and maximum timeout */
 	if (ch->cmt->info->width == 16) {
-		*rate = clk_get_rate(ch->cmt->clk) / 512;
 		sh_cmt_write_cmcsr(ch, SH_CMT16_CMCSR_CMIE |
 				   SH_CMT16_CMCSR_CKS512);
 	} else {
-		*rate = clk_get_rate(ch->cmt->clk) / 8;
 		sh_cmt_write_cmcsr(ch, SH_CMT32_CMCSR_CMM |
 				   SH_CMT32_CMCSR_CMTOUT_IE |
 				   SH_CMT32_CMCSR_CMR_IRQ |
@@ -572,7 +570,7 @@ static int sh_cmt_start(struct sh_cmt_channel *ch, unsigned long flag)
 	raw_spin_lock_irqsave(&ch->lock, flags);
 
 	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
-		ret = sh_cmt_enable(ch, &ch->rate);
+		ret = sh_cmt_enable(ch);
 
 	if (ret)
 		goto out;
@@ -640,10 +638,9 @@ static int sh_cmt_clocksource_enable(struct clocksource *cs)
 	ch->total_cycles = 0;
 
 	ret = sh_cmt_start(ch, FLAG_CLOCKSOURCE);
-	if (!ret) {
-		__clocksource_update_freq_hz(cs, ch->rate);
+	if (!ret)
 		ch->cs_enabled = true;
-	}
+
 	return ret;
 }
 
@@ -697,8 +694,7 @@ static int sh_cmt_register_clocksource(struct sh_cmt_channel *ch,
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used as clock source\n",
 		 ch->index);
 
-	/* Register with dummy 1 Hz value, gets updated in ->enable() */
-	clocksource_register_hz(cs, 1);
+	clocksource_register_hz(cs, ch->cmt->rate);
 	return 0;
 }
 
@@ -709,19 +705,10 @@ static struct sh_cmt_channel *ced_to_sh_cmt(struct clock_event_device *ced)
 
 static void sh_cmt_clock_event_start(struct sh_cmt_channel *ch, int periodic)
 {
-	struct clock_event_device *ced = &ch->ced;
-
 	sh_cmt_start(ch, FLAG_CLOCKEVENT);
 
-	/* TODO: calculate good shift from rate and counter bit width */
-
-	ced->shift = 32;
-	ced->mult = div_sc(ch->rate, NSEC_PER_SEC, ced->shift);
-	ced->max_delta_ns = clockevent_delta2ns(ch->max_match_value, ced);
-	ced->min_delta_ns = clockevent_delta2ns(0x1f, ced);
-
 	if (periodic)
-		sh_cmt_set_next(ch, ((ch->rate + HZ/2) / HZ) - 1);
+		sh_cmt_set_next(ch, ((ch->cmt->rate + HZ/2) / HZ) - 1);
 	else
 		sh_cmt_set_next(ch, ch->max_match_value);
 }
@@ -824,6 +811,12 @@ static int sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 	ced->suspend = sh_cmt_clock_event_suspend;
 	ced->resume = sh_cmt_clock_event_resume;
 
+	/* TODO: calculate good shift from rate and counter bit width */
+	ced->shift = 32;
+	ced->mult = div_sc(ch->cmt->rate, NSEC_PER_SEC, ced->shift);
+	ced->max_delta_ns = clockevent_delta2ns(ch->max_match_value, ced);
+	ced->min_delta_ns = clockevent_delta2ns(0x1f, ced);
+
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used for clock events\n",
 		 ch->index);
 	clockevents_register_device(ced);
@@ -996,6 +989,18 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 	if (ret < 0)
 		goto err_clk_put;
 
+	/* Determine clock rate. */
+	ret = clk_enable(cmt->clk);
+	if (ret < 0)
+		goto err_clk_unprepare;
+
+	if (cmt->info->width == 16)
+		cmt->rate = clk_get_rate(cmt->clk) / 512;
+	else
+		cmt->rate = clk_get_rate(cmt->clk) / 8;
+
+	clk_disable(cmt->clk);
+
 	/* Map the memory resource(s). */
 	ret = sh_cmt_map_memory(cmt);
 	if (ret < 0)
-- 
2.7.4
