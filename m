Return-Path: <SRS0=CBLW=CM=lists.cip-project.org=bounce+64572+5393+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7460C433E9
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:27:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85436206EB
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Tkatux2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85436206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5393+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id l3xhYY4521723x8biRENRImN; Thu, 03 Sep 2020 07:27:26 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.15229.1599143244490577166
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:27:25 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56296904"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2020 23:27:25 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 853A040062CD;
	Thu,  3 Sep 2020 23:27:24 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 3/4] serial: sh-sci: Don't check for mctrl_gpio_init() returning -ENOSYS
Date: Thu,  3 Sep 2020 15:27:18 +0100
Message-Id: <20200903142719.13010-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wlZOzd37fY9CwxwrZa91cpj4x4520388AA=
Content-Type: multipart/mixed; boundary="8a7BFXxeGzmQla4jCAS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599143246;
 bh=/dVpdd+kCYglmIjMXrUTDNM2wU4v+89wHxv7dkBkgbA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Tkatux2e9gAzmpPOnA68oJ0EaL5K9T1Ei+HBR9g9qsfKKILe0UDDDwAcI/lnYaN5vSZ
 AoU0kxP4qgqI2i8ePNr/h9WdZ0rwNi2QYZPgM6h5hGz4qz/w0dawfndOFbvdV36kzimQt
 6zD6sNqTU9vTmxKgfgFuGNoYecEOezlotX0=

--8a7BFXxeGzmQla4jCAS2

From: Frieder Schrempf <frieder.schrempf@kontron.de>

commit e55a09732be9b4e13cf3b5d2b9bb41b3e60e5ea6 upstream.

Now that the mctrl_gpio code returns NULL instead of ERR_PTR(-ENOSYS)
if CONFIG_GPIOLIB is disabled, we can safely remove this check.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Uwe Kleine-Knig <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20190802100349.8659-3-frieder.schrempf@kontron.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 166ca04aad4e..7d7008e4dc75 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2778,7 +2778,7 @@ static int sci_probe_single(struct platform_device *dev,
 		return ret;
 
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
-	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
+	if (IS_ERR(sciport->gpios))
 		return PTR_ERR(sciport->gpios);
 
 	if (p->capabilities & SCIx_HAVE_RTSCTS) {
-- 
2.17.1


--8a7BFXxeGzmQla4jCAS2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5393): https://lists.cip-project.org/g/cip-dev/message=
/5393
Mute This Topic: https://lists.cip-project.org/mt/76607964/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8a7BFXxeGzmQla4jCAS2--
