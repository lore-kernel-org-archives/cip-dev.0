Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34488.1792979251095481265
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 18:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=HVvDlZF7;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1792979245;x=1794188845;bh=4K
	YJPOzxIRoHDUcL60w9Lg2THUn6gLRkdu2r2M3NSNw=;b=HVvDlZF7UFAfPkxnDijlkBmbBXV5I6s4
	ajYkSzcQoRHu8hej0W9WXrYDTu1b6uJsNsz0AL9UowPcHiGDFrti0iz485gu8PyJnneyoSrb5xjDn
	d10VDpMdBu1UHNjmLV3GMvPI4fGFiEd09BzdrXOkgC+/UlzYDYDv7UWt2VJC0XRR9PXaUjN6gsHZF
	DFcmc8Or6+AHv18dpmHtIuPXF9Um3PuwvW0mJBdzLxXDv91jK+nWekM0g+uoicXYV6tLxYg38xSFj
	yKH/gZFFHLOhTikLLkna0uw+hBJ97fT0EZ3kKmXrAOpgyQd50ygt1BtphoiK526Med7WoeCkGnqCS
	3A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69Q1lPLa347838; Mon, 26 Oct 2026 10:47:25 +0900
X-Iguazu-Qid: 2yAakicNqwVmvq6V8j
X-Iguazu-QSIG: v=2; s=1; t=1792979244; q=2yAakicNqwVmvq6V8j; m=Lp7NtMyb5kaqh1/zmYlXHBgOK0NYEYMHHsUkEdGZnGE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jCc242fcFz1xnh; Mon, 26 Oct 2026 10:47:24 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
        fabrizio.castro.jz@renesas.com, claudiu.beznea.uj@bp.renesas.com,
        cosmin-gabriel.tanislav.xa@renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 4/5] counter: rz-mtu3-cnt: prevent counter from being toggled multiple times
Date: Mon, 26 Oct 2026 10:47:21 +0900
X-TSB-HOP2: ON
Message-Id: <1792979242-32127-5-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 01:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24529
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 67c3f99bed6f422ba343d2b70a2eeeccdfd91bef upstream.

Runtime PM counter is incremented / decremented each time the sysfs
enable file is written to.

If user writes 0 to the sysfs enable file multiple times, runtime PM
usage count underflows, generating the following message.

rz-mtu3-counter rz-mtu3-counter.0: Runtime PM usage count underflow!

At the same time, hardware registers end up being accessed with clocks
off in rz_mtu3_terminate_counter() to disable an already disabled
channel.

If user writes 1 to the sysfs enable file multiple times, runtime PM
usage count will be incremented each time, requiring the same number of
0 writes to get it back to 0.

If user writes 0 to the sysfs enable file while PWM is in progress, PWM
is stopped without counter being the owner of the underlying MTU3
channel.

Check against the cached count_is_enabled value and exit if the user
is trying to set the same enable value.

Cc: stable@vger.kernel.org
Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://lore.kernel.org/r/20260130122353.2263273-5-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/counter/rz-mtu3-cnt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index d761e74d6aa309..c30e4a368cb657 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -495,21 +495,25 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	int ret = 0;
 
+	mutex_lock(&priv->lock);
+
+	if (priv->count_is_enabled[count->id] == enable)
+		goto exit;
+
 	if (enable) {
-		mutex_lock(&priv->lock);
 		pm_runtime_get_sync(ch->dev);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret == 0)
 			priv->count_is_enabled[count->id] = true;
-		mutex_unlock(&priv->lock);
 	} else {
-		mutex_lock(&priv->lock);
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
 		pm_runtime_put(ch->dev);
-		mutex_unlock(&priv->lock);
 	}
 
+exit:
+	mutex_unlock(&priv->lock);
+
 	return ret;
 }
 
-- 
2.55.0


