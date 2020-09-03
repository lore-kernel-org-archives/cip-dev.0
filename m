Return-Path: <SRS0=k3M6=CM=lists.cip-project.org=bounce+64572+5392+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D0C43461
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:27:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A91420758
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LKTmFfto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A91420758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5392+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IKdBYY4521723x8sTTgrbQ9v; Thu, 03 Sep 2020 07:27:25 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.15229.1599143244490577166
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:27:24 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56296901"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2020 23:27:22 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E59AC40062AB;
	Thu,  3 Sep 2020 23:27:21 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 1/4] serial: mctrl_gpio: Check if GPIO property exisits before requesting it
Date: Thu,  3 Sep 2020 15:27:16 +0100
Message-Id: <20200903142719.13010-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wg0OWkUd4djhLf159R7Ho6vNx4520388AA=
Content-Type: multipart/mixed; boundary="Y2w0ioVmGUxEqofugjxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599143245;
 bh=mvLhSjOiftRAuTkQ2Dd8iQ+SDIjx+qaHq0OU5yuCFFA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LKTmFftoZW6gIneLujVhEzidqA2N6QbhV6W6KO8iI6uBfspWPtxk8cJ7klwjCAiUfAD
 q8eMYRnlFm9vp7xqslP5PWHzZAh7ItnhGdNvDgBQTlW2eIy373IO03Ze6zxzlbAi5Hr13
 N19gTmPNH7smgFrwiSVAnlnuNZ6br2U9zZ8=

--Y2w0ioVmGUxEqofugjxj

From: Stefan Roese <sr@denx.de>

commit d99482673f950817b30caf3fcdfb31179b050ce1 upstream.

This patch adds a check for the GPIOs property existence, before the
GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
support is added (2nd patch in this patch series) on x86 platforms using
ACPI.

Here Mika's comments from 2016-08-09:

"
I noticed that with v4.8-rc1 serial console of some of our Broxton
systems does not work properly anymore. I'm able to see output but input
does not work.

I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
("tty/serial/8250: use mctrl_gpio helpers").

The reason why it fails is that in ACPI we do not have names for GPIOs
(except when _DSD is used) so we use the "idx" to index into _CRS GPIO
resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
UART device in Broxton has following (simplified) ACPI description:

    Device (URT4)
    {
        ...
        Name (_CRS, ResourceTemplate () {
            GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPO0", 0x00, ResourceConsumer)
            {
                0x003A
            }
            GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPO0", 0x00, ResourceConsumer)
            {
                0x003D
            }
        })

In this case it finds the first GPIO (0x003A which happens to be RX pin
for that UART), turns it into GPIO which then breaks input for the UART
device. This also breaks systems with bluetooth connected to UART (those
typically have some GPIOs in their _CRS).

Any ideas how to fix this?

We cannot just drop the _CRS index lookup fallback because that would
break many existing machines out there so maybe we can limit this to
only DT enabled machines. Or alternatively probe if the property first
exists before trying to acquire the GPIOs (using
device_property_present()).
"

This patch implements the fix suggested by Mika in his statement above.

Signed-off-by: Stefan Roese <sr@denx.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[PL: Included slab.h for build error]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 2b5329a3d716..18dfba725239 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -20,7 +20,9 @@
 #include <linux/gpio/consumer.h>
 #include <linux/termios.h>
 #include <linux/serial_core.h>
+#include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/property.h>
 
 #include "serial_mctrl_gpio.h"
 
@@ -102,6 +104,19 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
 		enum gpiod_flags flags;
+		char *gpio_str;
+		bool present;
+
+		/* Check if GPIO property exists and continue if not */
+		gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
+				     mctrl_gpios_desc[i].name);
+		if (!gpio_str)
+			continue;
+
+		present = device_property_present(dev, gpio_str);
+		kfree(gpio_str);
+		if (!present)
+			continue;
 
 		if (mctrl_gpios_desc[i].dir_out)
 			flags = GPIOD_OUT_LOW;
-- 
2.17.1


--Y2w0ioVmGUxEqofugjxj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5392): https://lists.cip-project.org/g/cip-dev/message=
/5392
Mute This Topic: https://lists.cip-project.org/mt/76607963/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Y2w0ioVmGUxEqofugjxj--
