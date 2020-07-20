Return-Path: <SRS0=52UN=A7=lists.cip-project.org=bounce+64572+4938+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F197C433E3
	for <cip-dev@archiver.kernel.org>; Mon, 20 Jul 2020 18:04:20 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA2322B51
	for <cip-dev@archiver.kernel.org>; Mon, 20 Jul 2020 18:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vFRs6gle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA2322B51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4938+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0kBGYY4521723xzXbSoVM44f; Mon, 20 Jul 2020 11:04:19 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.1001.1595267770884499038
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2020 10:56:11 -0700
X-IronPort-AV: E=Sophos;i="5.75,375,1589209200"; 
   d="scan'208";a="52619177"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jul 2020 02:56:08 +0900
X-Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4996440031D7;
	Tue, 21 Jul 2020 02:56:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 1/2] ASoC: rsnd: fixup SSI clock during suspend/resume modes
Date: Mon, 20 Jul 2020 18:52:22 +0100
Message-Id: <1595267543-32854-1-git-send-email-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WPAyHqNqkMoKGlBeGilJNvNYx4520388AA=
Content-Type: multipart/mixed; boundary="RqrZMxhJpDHdqNzIk03O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595268259;
 bh=km/1olbwf+gu9k4sX/kIJa70f2xVYi5v28yerm+IPJM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vFRs6gleKTt/+0Cs7e3L8H9HbH9f7DleI7/2JCl/0ZLyeG3qzOAdTbSsgZgEKvJfrWP
 44gpkDiHINReVIQ9+zOeph2T3fgMpnHszm03J6xPdtthicrNUBy3+GeYA0U+Go2+HIFCq
 gy8T50zGOIw2sApMpPParQOeNdBZ5mZEL5g=

--RqrZMxhJpDHdqNzIk03O

From: Dmytro Prokopchuk <dmytro.prokopchuk@globallogic.com>

commit 624d1a7cd8991e33dad96ab4629a52c412540e65 upstream.

Prepare <-> Cleanup functions pair has balanced calls.
But in case of suspend mode no call to rsnd_soc_dai_shutdown()
function, so cleanup isn't called. OTOH during resume mode
function rsnd_soc_dai_prepare() is called, but calling
rsnd_ssi_prepare() is skipped (rsnd_status_update() returns zero,
bacause was not cleanup before).
We need to call rsnd_ssi_prepare(), because it enables SSI clocks
by calling rsnd_ssi_master_clk_start().

This patch allows to call prepare/cleanup functions always.

Signed-off-by: Dmytro Prokopchuk <dmytro.prokopchuk@globallogic.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
[kuninori: adjusted to upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/dma.c  |  7 +++----
 sound/soc/sh/rcar/rsnd.h | 14 +++++++-------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 83bf0f6..58da57e 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -134,10 +134,9 @@ static int rsnd_dmaen_prepare(struct rsnd_mod *mod,
 	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
 	struct device *dev = rsnd_priv_to_dev(priv);
 
-	if (dmaen->chan) {
-		dev_err(dev, "it already has dma channel\n");
-		return -EIO;
-	}
+	/* maybe suspended */
+	if (dmaen->chan)
+		return 0;
 
 	/*
 	 * DMAEngine request uses mutex lock.
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index c449d9f..31bf791 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -320,9 +320,8 @@ struct rsnd_mod {
 /*
  * status
  *
- * 0xH0000CBA
+ * 0xH0000CB0
  *
- * A	0: prepare	1: cleanup
  * B	0: init		1: quit
  * C	0: start	1: stop
  *
@@ -333,9 +332,8 @@ struct rsnd_mod {
  * H	0: hw_params
  * H	0: pointer
  * H	0: prepare
+ * H	0: cleanup
  */
-#define __rsnd_mod_shift_prepare	0
-#define __rsnd_mod_shift_cleanup	0
 #define __rsnd_mod_shift_init		4
 #define __rsnd_mod_shift_quit		4
 #define __rsnd_mod_shift_start		8
@@ -347,11 +345,13 @@ struct rsnd_mod {
 #define __rsnd_mod_shift_fallback	28 /* always called */
 #define __rsnd_mod_shift_hw_params	28 /* always called */
 #define __rsnd_mod_shift_pointer	28 /* always called */
+#define __rsnd_mod_shift_prepare	28 /* always called */
+#define __rsnd_mod_shift_cleanup	28 /* always called */
 
 #define __rsnd_mod_add_probe		0
 #define __rsnd_mod_add_remove		0
-#define __rsnd_mod_add_prepare		 1
-#define __rsnd_mod_add_cleanup		-1
+#define __rsnd_mod_add_prepare		0
+#define __rsnd_mod_add_cleanup		0
 #define __rsnd_mod_add_init		 1
 #define __rsnd_mod_add_quit		-1
 #define __rsnd_mod_add_start		 1
@@ -365,7 +365,7 @@ struct rsnd_mod {
 #define __rsnd_mod_call_probe		0
 #define __rsnd_mod_call_remove		0
 #define __rsnd_mod_call_prepare		0
-#define __rsnd_mod_call_cleanup		1
+#define __rsnd_mod_call_cleanup		0
 #define __rsnd_mod_call_init		0
 #define __rsnd_mod_call_quit		1
 #define __rsnd_mod_call_start		0
-- 
2.7.4


--RqrZMxhJpDHdqNzIk03O
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4938): https://lists.cip-project.org/g/cip-dev/message=
/4938
Mute This Topic: https://lists.cip-project.org/mt/75687530/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--RqrZMxhJpDHdqNzIk03O--
