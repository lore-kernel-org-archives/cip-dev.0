From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 May 2018 18:36:05 +0100
Subject: [cip-dev] [PATCH v2 09/11] clockevents/drivers/sh_cmt: Set
	->min_delta_ticks and ->max_delta_ticks
In-Reply-To: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
References: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527701767-41785-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Nicolai Stange <nicstange@gmail.com>

In preparation for making the clockevents core NTP correction aware,
all clockevent device drivers must set ->min_delta_ticks and
->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
clockevent device's rate is going to change dynamically and thus, the
ratio of ns to ticks ceases to stay invariant.

Make the sh_cmt clockevent driver initialize these fields properly.

This patch alone doesn't introduce any change in functionality as the
clockevents core still looks exclusively at the (untouched) ->min_delta_ns
and ->max_delta_ns. As soon as this has changed, a followup patch will
purge the initialization of ->min_delta_ns and ->max_delta_ns from this
driver.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
(cherry picked from commit bb2e94ac0cf4628f5e5f778c8de4a376dac43558)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/clocksource/sh_cmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 3038885..97ce6bf 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -815,7 +815,9 @@ static int sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 	ced->shift = 32;
 	ced->mult = div_sc(ch->cmt->rate, NSEC_PER_SEC, ced->shift);
 	ced->max_delta_ns = clockevent_delta2ns(ch->max_match_value, ced);
+	ced->max_delta_ticks = ch->max_match_value;
 	ced->min_delta_ns = clockevent_delta2ns(0x1f, ced);
+	ced->min_delta_ticks = 0x1f;
 
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used for clock events\n",
 		 ch->index);
-- 
2.7.4
