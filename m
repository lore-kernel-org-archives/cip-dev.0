Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34111.1792979250688658277
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 18:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=FTLFJ5tE;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1792979245;x=1794188845;bh=xC
	resCAYW2Q905GhDpVgIb8KcQQcZ9owvJXiPsXdmYs=;b=FTLFJ5tERxinU/xR2eQNprhSj4NUzpmK
	Q4vP+VkxOZxgydxmWdrMGSlBKRdXBua1Us4qF5FjWHQOjplXUGkpxVEkGk15//Vz6Q6+7XG1UrGVJ
	dWyFut8lm5ZpKfn+SFZr+mn5Si2WK6dziJAoo6jYwavHkpSmPT0uySXe5YOPcer5rbyfW7rq6oZQf
	QJvMhqw6yEe/+oDC7hVmNKhxUp3TAKEBcoAghIFT/k3j8Sw4QfrJddr++1TOuAr8AMXUoOXmXR4je
	U4ctQKrVaU1MNkZU+39IRz37C1LEZmRMs9LrFEGP2dxu2pSkem5xycIUlSwv+8Ef1P4YHHQCBbcCT
	jQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 69Q1lPpp128459; Mon, 26 Oct 2026 10:47:25 +0900
X-Iguazu-Qid: 2yAaCwNmAebnqppVqM
X-Iguazu-QSIG: v=2; s=1; t=1792979245; q=2yAaCwNmAebnqppVqM; m=FGqSG1bMie5UqjbNYMxhI0iFnzV4JWlnh976UUpQiPk=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jCc250WdczyPg; Mon, 26 Oct 2026 10:47:25 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
        fabrizio.castro.jz@renesas.com, claudiu.beznea.uj@bp.renesas.com,
        cosmin-gabriel.tanislav.xa@renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 5/5] counter: rz-mtu3-cnt: do not use struct rz_mtu3_channel's dev member
Date: Mon, 26 Oct 2026 10:47:22 +0900
X-TSB-HOP2: ON
Message-Id: <1792979242-32127-6-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 01:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24526
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 2932095c114b98cbb40ccf34fc00d613cb17cead upstream.

The counter driver can use HW channels 1 and 2, while the PWM driver can
use HW channels 0, 1, 2, 3, 4, 6, 7.

The dev member is assigned both by the counter driver and the PWM driver
for channels 1 and 2, to their own struct device instance, overwriting
the previous value.

The sub-drivers race to assign their own struct device pointer to the
same struct rz_mtu3_channel's dev member.

The dev member of struct rz_mtu3_channel is used by the counter
sub-driver for runtime PM.

Depending on the probe order of the counter and PWM sub-drivers, the
dev member may point to the wrong struct device instance, causing the
counter sub-driver to do runtime PM actions on the wrong device.

To fix this, use the parent pointer of the counter, which is assigned
during probe to the correct struct device, not the struct device pointer
inside the shared struct rz_mtu3_channel.

Cc: stable@vger.kernel.org
Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://lore.kernel.org/r/20260130122353.2263273-6-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/counter/rz-mtu3-cnt.c | 55 +++++++++++++++++------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index c30e4a368cb657..5c3d7f990291e2 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -107,9 +107,9 @@ static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, int id)
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	unsigned long tmdr;
 
-	pm_runtime_get_sync(priv->ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-	pm_runtime_put(priv->ch->dev);
+	pm_runtime_put(counter->parent);
 
 	if (id == RZ_MTU3_32_BIT_CH && test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
 		return false;
@@ -165,12 +165,12 @@ static int rz_mtu3_count_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		*val = rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
 	else
 		*val = rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TCNT);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -187,26 +187,26 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, val);
 	else
 		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, val);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
 }
 
 static int rz_mtu3_count_function_read_helper(struct rz_mtu3_channel *const ch,
-					      struct rz_mtu3_cnt *const priv,
+					      struct counter_device *const counter,
 					      enum counter_function *function)
 {
 	u8 timer_mode;
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	timer_mode = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TMDR1);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 
 	switch (timer_mode & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
 	case RZ_MTU3_TMDR1_PH_CNT_MODE_1:
@@ -240,7 +240,7 @@ static int rz_mtu3_count_function_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	ret = rz_mtu3_count_function_read_helper(ch, priv, function);
+	ret = rz_mtu3_count_function_read_helper(ch, counter, function);
 	mutex_unlock(&priv->lock);
 
 	return ret;
@@ -279,9 +279,9 @@ static int rz_mtu3_count_function_write(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -300,9 +300,9 @@ static int rz_mtu3_count_direction_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	tsr = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 
 	*direction = (tsr & RZ_MTU3_TSR_TCFD) ?
 		COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD;
@@ -373,14 +373,14 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TGRALW, ceiling);
 	else
 		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, ceiling);
 
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -491,7 +491,6 @@ static int rz_mtu3_count_enable_read(struct counter_device *counter,
 static int rz_mtu3_count_enable_write(struct counter_device *counter,
 				      struct counter_count *count, u8 enable)
 {
-	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	int ret = 0;
 
@@ -501,14 +500,14 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		goto exit;
 
 	if (enable) {
-		pm_runtime_get_sync(ch->dev);
+		pm_runtime_get_sync(counter->parent);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret == 0)
 			priv->count_is_enabled[count->id] = true;
 	} else {
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
-		pm_runtime_put(ch->dev);
+		pm_runtime_put(counter->parent);
 	}
 
 exit:
@@ -540,9 +539,9 @@ static int rz_mtu3_cascade_counts_enable_get(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(priv->ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-	pm_runtime_put(priv->ch->dev);
+	pm_runtime_put(counter->parent);
 	*cascade_enable = test_bit(RZ_MTU3_TMDR3_LWA, &tmdr);
 	mutex_unlock(&priv->lock);
 
@@ -559,10 +558,10 @@ static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(priv->ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
 				      RZ_MTU3_TMDR3_LWA, cascade_enable);
-	pm_runtime_put(priv->ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -579,9 +578,9 @@ static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_device *count
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(priv->ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-	pm_runtime_put(priv->ch->dev);
+	pm_runtime_put(counter->parent);
 	*ext_input_phase_clock_select = test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
 	mutex_unlock(&priv->lock);
 
@@ -598,11 +597,11 @@ static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device *count
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(priv->ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
 				      RZ_MTU3_TMDR3_PHCKSEL,
 				      ext_input_phase_clock_select);
-	pm_runtime_put(priv->ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -640,7 +639,7 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	ret = rz_mtu3_count_function_read_helper(ch, priv, &function);
+	ret = rz_mtu3_count_function_read_helper(ch, counter, &function);
 	if (ret) {
 		mutex_unlock(&priv->lock);
 		return ret;
-- 
2.55.0


