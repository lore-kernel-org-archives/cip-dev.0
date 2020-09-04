Return-Path: <SRS0=E+x2=CN=lists.cip-project.org=bounce+64572+5415+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BFBC43461
	for <cip-dev@archiver.kernel.org>; Fri,  4 Sep 2020 07:41:05 +0000 (UTC)
Received: from web01.groups.io (unknown [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC5C2074D
	for <cip-dev@archiver.kernel.org>; Fri,  4 Sep 2020 07:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fFwy2l6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC5C2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5415+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DSNFYY4521723xC9R7lRk9Yq; Fri, 04 Sep 2020 00:41:02 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.33362.1599205260815055849
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Sep 2020 00:41:01 -0700
X-IronPort-AV: E=Sophos;i="5.76,388,1592838000"; 
   d="scan'208";a="56369402"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Sep 2020 16:40:59 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 77F974009673;
	Fri,  4 Sep 2020 16:40:58 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip] gpio: rcar: Avoid NULL pointer access in gpio_rcar_set_multiple()
Date: Fri,  4 Sep 2020 08:40:57 +0100
Message-Id: <20200904074057.27932-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DrkWcJ9WWyXAh34xnOXkA1gux4520388AA=
Content-Type: multipart/mixed; boundary="84mvLOGhKwJ0eJ9RnrJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599205262;
 bh=p4nDD0zon47SzZu3gUB0jHJrvQM6mWKFWmfkJ5RYyVA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=fFwy2l6gkIYV1pCXlYM1rQ/AH2S/nNODkfPa386Xy8BLlLHR6NqyX2LE+PLBHNHl1i6
 R+PJB3pja+NqvMl39JdPeg9v0igr7mbaMqp9OBm7n7FeSeRYJjL4/kT2LBK2GDBKWxCvP
 K3Q0fWdg35nP6FRLCee/pVM4bd9Ub3jzneQ=

--84mvLOGhKwJ0eJ9RnrJm

gpiochip_get_data() expects the controller probe to call
gpiochip_add_data() before using it, where as the rcar-gpio
driver probe has gpiochip_add() call thus resulting in NULL
pointer access.

Avoid this case by using gpio_to_priv() call.

Fixes: 6e52cced1aa58 ("gpio: rcar: Implement gpiochip.set_multiple()")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpio/gpio-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index e829f11aca8f..2778dcd96ae7 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -352,7 +352,7 @@ static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int value)
 static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 				   unsigned long *bits)
 {
-	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
+	struct gpio_rcar_priv *p = gpio_to_priv(chip);
 	unsigned long flags;
 	u32 val, bankmask;
 
-- 
2.17.1


--84mvLOGhKwJ0eJ9RnrJm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5415): https://lists.cip-project.org/g/cip-dev/message=
/5415
Mute This Topic: https://lists.cip-project.org/mt/76625137/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--84mvLOGhKwJ0eJ9RnrJm--
