Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16059.1794916198888984017
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:49:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 52EB663325;
	Tue, 17 Nov 2026 11:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DA71F000C5;
	Tue, 17 Nov 2026 11:49:56 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 24/34] pinctrl: renesas: rzg2l: Make QSPI register handling conditional
Date: Tue, 17 Nov 2026 13:49:10 +0200
Message-ID: <20261117114921.1485204-25-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:50:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24935
Content-Type: text/plain; charset="utf-8"

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 55793d3ddf774e9bbeed3c940fb19d6c1124b6d3 upstream.

The QSPI register at offset 0x3008 is not present on all SoCs supported b=
y
the RZ/G2L pinctrl driver. Unconditionally reading and writing this
register during suspend/resume on hardware that lacks it can cause
undefined behaviour.

Add a qspi field to rzg2l_register_offsets to allow per-SoC declaration o=
f
the QSPI register offset, and guard the suspend/resume accesses with a
check on that field. Populate the offset only for the RZ/{G2L,G2LC,G2UL,
Five} hardware configuration, which is where the register is known to
exist.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430093422.74812-3-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 4bf3cd11f39a..855c8aa8225f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -144,7 +144,7 @@
 #define SMT(off)		(0x3400 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
-#define QSPI			(0x3008)
+#define QSPI			(0x3008) /* known on RZ/{G2L,G2LC,G2UL,Five} only */
=20
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
@@ -219,12 +219,14 @@ static const struct pin_config_item renesas_rzv2h_c=
onf_items[] =3D {
  * @sd_ch: SD_CH register offset
  * @eth_poc: ETH_POC register offset
  * @oen: OEN register offset
+ * @qspi: QSPI register offset
  */
 struct rzg2l_register_offsets {
 	u16 pwpr;
 	u16 sd_ch;
 	u16 eth_poc;
 	u16 oen;
+	u16 qspi;
 };
=20
 /**
@@ -3201,7 +3203,8 @@ static int rzg2l_pinctrl_suspend_noirq(struct devic=
e *dev)
 			cache->eth_poc[i] =3D readb(pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
=20
-	cache->qspi =3D readb(pctrl->base + QSPI);
+	if (regs->qspi)
+		cache->qspi =3D readb(pctrl->base + regs->qspi);
 	cache->oen =3D readb(pctrl->base + pctrl->data->hwcfg->regs.oen);
=20
 	if (!atomic_read(&pctrl->wakeup_path))
@@ -3227,7 +3230,8 @@ static int rzg2l_pinctrl_resume_noirq(struct device=
 *dev)
 			return ret;
 	}
=20
-	writeb(cache->qspi, pctrl->base + QSPI);
+	if (regs->qspi)
+		writeb(cache->qspi, pctrl->base + regs->qspi);
=20
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	rzg2l_oen_write_with_pwpr(pctrl, cache->oen);
@@ -3285,6 +3289,7 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
 		.sd_ch =3D 0x3000,
 		.eth_poc =3D 0x300c,
 		.oen =3D 0x3018,
+		.qspi =3D QSPI,
 	},
 	.iolh_groupa_ua =3D {
 		/* 3v3 power source */
--=20
2.43.0

