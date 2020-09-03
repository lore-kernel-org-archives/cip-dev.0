Return-Path: <SRS0=MhAh=CM=lists.cip-project.org=bounce+64572+5394+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D1CC433E2
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:27:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49502072A
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ICne/xhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49502072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5394+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1MkMYY4521723xRwxPNrzqYo; Thu, 03 Sep 2020 07:27:27 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.15150.1599143242092612777
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:27:27 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56080650"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 23:27:26 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CCBA340062AB;
	Thu,  3 Sep 2020 23:27:25 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 4/4] serial: sh-sci: Don't check for mctrl_gpio_to_gpiod() returning error
Date: Thu,  3 Sep 2020 15:27:19 +0100
Message-Id: <20200903142719.13010-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tJNW4aSjy6gRWIZZDteeym7Nx4520388AA=
Content-Type: multipart/mixed; boundary="ZQOhKWlGi8SrxhBL4TY8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599143247;
 bh=uf1HOC0Nbb+2mYfZ7PAcqbz4k3dOfCwl+gFGkLbBLeY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ICne/xhGTYFQYE1ImGADzYNEstCHsmKu5nHbScDniXkaCzuZwZKZe9J+K3HfT6skFiK
 zRKWkhnRD5Q2Ic8C3FMzZ/U1mjQWFJfLsw1mfqQ2VwnAPJRVGDZKFc1SKBdajh0XBPVy7
 VPnZ+AsHo0hnaUWYk6l8Y7QMuAqGVFUfoOg=

--ZQOhKWlGi8SrxhBL4TY8

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit a16c4c5a9cb6368a08c457b6b2dc0be25958dfc0 upstream.

Since commit 1d267ea6539f2663 ("serial: mctrl-gpio: simplify init
routine"), mctrl_gpio_init() returns failure if the assignment to any
member of the gpio array results in an error pointer.
Since commit c359522194593815 ("serial: mctrl_gpio: Avoid probe failures
in case of missing gpiolib"), mctrl_gpio_to_gpiod() returns NULL in the
!CONFIG_GPIOLIB case.
Hence there is no longer a need to check for mctrl_gpio_to_gpiod()
returning an error value.  A simple NULL check is sufficient.

This follows the spirit of commit 445df7ff3fd1a0a9 ("serial: mctrl-gpio:
drop usages of IS_ERR_OR_NULL") in the mctrl-gpio core.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20190814092924.13857-4-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7d7008e4dc75..c40cf1cb45d2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1871,12 +1871,12 @@ static unsigned int sci_get_mctrl(struct uart_port *port)
 	if (s->autorts) {
 		if (sci_get_cts(port))
 			mctrl |= TIOCM_CTS;
-	} else if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS))) {
+	} else if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS)) {
 		mctrl |= TIOCM_CTS;
 	}
-	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DSR)))
+	if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_DSR))
 		mctrl |= TIOCM_DSR;
-	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DCD)))
+	if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_DCD))
 		mctrl |= TIOCM_CAR;
 
 	return mctrl;
@@ -2782,10 +2782,8 @@ static int sci_probe_single(struct platform_device *dev,
 		return PTR_ERR(sciport->gpios);
 
 	if (p->capabilities & SCIx_HAVE_RTSCTS) {
-		if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
-							UART_GPIO_CTS)) ||
-		    !IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
-							UART_GPIO_RTS))) {
+		if (mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_CTS) ||
+		    mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_RTS)) {
 			dev_err(&dev->dev, "Conflicting RTS/CTS config\n");
 			return -EINVAL;
 		}
-- 
2.17.1


--ZQOhKWlGi8SrxhBL4TY8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5394): https://lists.cip-project.org/g/cip-dev/message=
/5394
Mute This Topic: https://lists.cip-project.org/mt/76607965/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ZQOhKWlGi8SrxhBL4TY8--
