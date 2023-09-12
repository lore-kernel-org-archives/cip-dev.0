Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5F8EE3F1C
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 19:59:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.450.1694548765259810954
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 12:59:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,141,1688396400"; 
   d="scan'208";a="179568796"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Sep 2023 04:59:30 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BDA2840A489B;
	Wed, 13 Sep 2023 04:59:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 05/15] mfd: rz-mtu3: Link time dependencies
Date: Tue, 12 Sep 2023 20:59:05 +0100
Message-Id: <20230912195915.607664-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
References: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 19:59:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13079

From: Arnd Bergmann <arnd@arndb.de>

commit 10d3340441bd0db857fc7fcb1733a800acf47a3d upstream.

The new set of drivers for RZ/G2L MTU3a tries to enable compile-testing the
individual client drivers even when the MFD portion is disabled but gets it
wrong, causing a link failure when the core is in a loadable module but the
other drivers are built-in:

x86_64-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function `rz_mtu3_pwm_apply':
pwm-rz-mtu3.c:(.text+0x4bf): undefined reference to `rz_mtu3_8bit_ch_write'
x86_64-linux-ld: pwm-rz-mtu3.c:(.text+0x509): undefined reference to `rz_mtu3_disable'

arm-linux-gnueabi-ld: drivers/counter/rz-mtu3-cnt.o: in function `rz_mtu3_cascade_counts_enable_get':
rz-mtu3-cnt.c:(.text+0xbec): undefined reference to `rz_mtu3_shared_reg_read'

It seems better not to add the extra complexity here but instead just use
a normal hard dependency, so remove the #else portion in the header along
with the "|| COMPILE_TEST". This could also be fixed by having slightly more
elaborate Kconfig dependencies or using the cursed 'IS_REACHABLE()' helper,
but in practice it's already possible to compile-test all these drivers
by enabling the mtd portion.

Fixes: 254d3a727421c ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
Fixes: 0be8907359df4 ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Fixes: 654c293e1687b ("mfd: Add Renesas RZ/G2L MTU3a core driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230719090430.1925182-1-arnd@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/Kconfig         |  2 +-
 include/linux/mfd/rz-mtu3.h | 66 -------------------------------------
 2 files changed, 1 insertion(+), 67 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 18a7cc6a7fc9..0351956aaf49 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -483,7 +483,7 @@ config PWM_ROCKCHIP
 
 config PWM_RZ_MTU3
 	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
-	depends on RZ_MTU3 || COMPILE_TEST
+	depends on RZ_MTU3
 	depends on HAS_IOMEM
 	help
 	  This driver exposes the MTU3a PWM Timer controller found in Renesas
diff --git a/include/linux/mfd/rz-mtu3.h b/include/linux/mfd/rz-mtu3.h
index c5173bc06270..8421d49500bf 100644
--- a/include/linux/mfd/rz-mtu3.h
+++ b/include/linux/mfd/rz-mtu3.h
@@ -151,7 +151,6 @@ struct rz_mtu3 {
 	void *priv_data;
 };
 
-#if IS_ENABLED(CONFIG_RZ_MTU3)
 static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
 {
 	mutex_lock(&ch->lock);
@@ -188,70 +187,5 @@ void rz_mtu3_32bit_ch_write(struct rz_mtu3_channel *ch, u16 off, u32 val);
 void rz_mtu3_shared_reg_write(struct rz_mtu3_channel *ch, u16 off, u16 val);
 void rz_mtu3_shared_reg_update_bit(struct rz_mtu3_channel *ch, u16 off,
 				   u16 pos, u8 val);
-#else
-static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
-{
-	return false;
-}
-
-static inline void rz_mtu3_release_channel(struct rz_mtu3_channel *ch)
-{
-}
-
-static inline bool rz_mtu3_is_enabled(struct rz_mtu3_channel *ch)
-{
-	return false;
-}
-
-static inline void rz_mtu3_disable(struct rz_mtu3_channel *ch)
-{
-}
-
-static inline int rz_mtu3_enable(struct rz_mtu3_channel *ch)
-{
-	return 0;
-}
-
-static inline u8 rz_mtu3_8bit_ch_read(struct rz_mtu3_channel *ch, u16 off)
-{
-	return 0;
-}
-
-static inline u16 rz_mtu3_16bit_ch_read(struct rz_mtu3_channel *ch, u16 off)
-{
-	return 0;
-}
-
-static inline u32 rz_mtu3_32bit_ch_read(struct rz_mtu3_channel *ch, u16 off)
-{
-	return 0;
-}
-
-static inline u16 rz_mtu3_shared_reg_read(struct rz_mtu3_channel *ch, u16 off)
-{
-	return 0;
-}
-
-static inline void rz_mtu3_8bit_ch_write(struct rz_mtu3_channel *ch, u16 off, u8 val)
-{
-}
-
-static inline void rz_mtu3_16bit_ch_write(struct rz_mtu3_channel *ch, u16 off, u16 val)
-{
-}
-
-static inline void rz_mtu3_32bit_ch_write(struct rz_mtu3_channel *ch, u16 off, u32 val)
-{
-}
-
-static inline void rz_mtu3_shared_reg_write(struct rz_mtu3_channel *ch, u16 off, u16 val)
-{
-}
-
-static inline void rz_mtu3_shared_reg_update_bit(struct rz_mtu3_channel *ch,
-						 u16 off, u16 pos, u8 val)
-{
-}
-#endif
 
 #endif /* __MFD_RZ_MTU3_H__ */
-- 
2.25.1


