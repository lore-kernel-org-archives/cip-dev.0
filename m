Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15953.1794916015249575481
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 12AF74373F;
	Tue, 17 Nov 2026 11:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAFB1F000C4;
	Tue, 17 Nov 2026 11:46:53 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 36/69] pinctrl: renesas: rzg2l: Make QSPI register handling conditional
Date: Tue, 17 Nov 2026 13:45:20 +0200
Message-ID: <20261117114553.1484215-37-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24877
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
[claudiu.beznea:
- fixed conflict in defines area by keeping only ETH_MODE define
- fixed conflict in rzg2l_register_offsets by keeping only qspi member
- fixed conflict in rzg2l_pinctrl_suspend_noirq() by keeping qspi and
  eth_mode code
- fixed conflict in rzg2l_pinctrl_resume_noirq() by keeping qspi, eth_mod=
e,
  sd_ch[], eth_poc[] code
- fixed conflict in rzg2l_hwcfg by keeping only .qspi initialization
- updated rzg2l_caps_to_pwr_reg() to use regs->qspi]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 17cca917767a..d64ee291e0e4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -179,11 +179,13 @@
  * @pwpr: PWPR register offset
  * @sd_ch: SD_CH register offset
  * @eth_poc: ETH_POC register offset
+ * @qspi: QSPI register offset
  */
 struct rzg2l_register_offsets {
 	u16 pwpr;
 	u16 sd_ch;
 	u16 eth_poc;
+	u16 qspi;
 };
=20
 /**
@@ -844,7 +846,7 @@ static int rzg2l_caps_to_pwr_reg(const struct rzg2l_r=
egister_offsets *regs, u32
 	if (caps & PIN_CFG_IO_VMC_ETH1)
 		return ETH_POC(regs->eth_poc, 1);
 	if (caps & PIN_CFG_IO_VMC_QSPI)
-		return QSPI;
+		return regs->qspi;
=20
 	return -EINVAL;
 }
@@ -2692,7 +2694,8 @@ static int __maybe_unused rzg2l_pinctrl_suspend_noi=
rq(struct device *dev)
 		cache->eth_poc[i] =3D readb(pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
=20
-	cache->qspi =3D readb(pctrl->base + QSPI);
+	if (regs->qspi)
+		cache->qspi =3D readb(pctrl->base + regs->qspi);
 	cache->eth_mode =3D readb(pctrl->base + ETH_MODE);
=20
 	if (!atomic_read(&pctrl->wakeup_path))
@@ -2718,7 +2721,8 @@ static int __maybe_unused rzg2l_pinctrl_resume_noir=
q(struct device *dev)
 			return ret;
 	}
=20
-	writeb(cache->qspi, pctrl->base + QSPI);
+	if (regs->qspi)
+		writeb(cache->qspi, pctrl->base + regs->qspi);
 	writeb(cache->eth_mode, pctrl->base + ETH_MODE);
 	for (i =3D 0; i < 2; i++) {
 		writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
@@ -2738,6 +2742,7 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
 		.pwpr =3D 0x3014,
 		.sd_ch =3D 0x3000,
 		.eth_poc =3D 0x300c,
+		.qspi =3D QSPI,
 	},
 	.iolh_groupa_ua =3D {
 		/* 3v3 power source */
--=20
2.43.0

