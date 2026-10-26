Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34489.1792979251095668960
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 18:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=hzkXWYBI;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1792979244;x=1794188844;bh=OO
	Xf5QyAqSsxZCdvZBalOwRFwgCswMsLmKt92pXRCeo=;b=hzkXWYBI6B7xbnvBpeWNAdmavD4deVzB
	XsdXvhLadrFhHEmS9rP3ZQDotlTshk2ydvMljwd3AdD2hhMJQ6NG3QF1UwiwqmLqJ580DHFNDjwuD
	APmnwy/HQnOXXI3SVmwXURCvUnr2Hb6LxDogZqxAGYH0EcGWuL4KrWL4vc//VZm5XaZEoAEP7tkw7
	gBmh/SxKc8hy98y6+37UWcV6c9HUct5t2cvzPQ68gvgQ8t6sBRh1dsdcfQdQHUAdLjU9mKecDVj1K
	6m83vPe60118VFfA8fOAwUe404snlS+huCQmRBbK40rTdVVrs67jRTidJGZzPg6CiIwgrE9umJiq1
	rw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 69Q1lOTE128379; Mon, 26 Oct 2026 10:47:24 +0900
X-Iguazu-Qid: 2yAa9Lyb4UYjzlg1aA
X-Iguazu-QSIG: v=2; s=1; t=1792979244; q=2yAa9Lyb4UYjzlg1aA; m=KXDFKwydy0gjbEZYrpzH6RGr6nRhZceThfZYyZFaX1E=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jCc24217HzyPg; Mon, 26 Oct 2026 10:47:24 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
        fabrizio.castro.jz@renesas.com, claudiu.beznea.uj@bp.renesas.com,
        cosmin-gabriel.tanislav.xa@renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 3/5] iio: adc: rzg2l_adc: Set driver data before enabling runtime PM
Date: Mon, 26 Oct 2026 10:47:20 +0900
X-TSB-HOP2: ON
Message-Id: <1792979242-32127-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 01:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24528
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c69e13965f26b8058f538ea8bdbd2d7718cf1fbe upstream.

When stress-testing the system by repeatedly unbinding and binding the ADC
device in a loop, and the ADC is a supplier for another device (e.g., a
thermal hardware block that reads temperature through the ADC), it may
happen that the ADC device is runtime-resumed immediately after runtime PM
is enabled, triggered by its consumer. At this point, since drvdata is not
yet set and the driver's runtime PM callbacks rely on it, a crash can
occur. To avoid this, set drvdata just after it was allocated.

Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20250810123328.800104-3-claudiu.beznea.uj@bp.renesas.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/iio/adc/rzg2l_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index c19e3d29dbb861..e273785ba19d87 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -446,6 +446,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, indio_dev);
+
 	adc = iio_priv(indio_dev);
 
 	adc->hw_params = device_get_match_data(dev);
@@ -500,8 +502,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-- 
2.55.0


