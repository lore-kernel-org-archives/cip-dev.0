Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34128.1792979294973440591
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 18:48:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=OXPQ5KDQ;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1792979289;x=1794188889;bh=dh
	fwZCjzU4smZZVuDt5IPtoNlCIqm0tWrWLfqSn00pI=;b=OXPQ5KDQ9tT1VQPOgsZ9dFRnaeO7fz7B
	ruOcd2Lz7fviJDPoPabEPIxkCB/z4C7tFIjJkFGIRzALcidvhaDm6Z3D4efYyk/Eu5IymGBvVo76S
	eRDUIkyeiD5nygj15Z7UkmApxTWTjeTQhn8PZAK12533cfmbE5Meg5aBe+KAM6GoHGr+QiNjVgSfD
	kNUWof3QUVIk841NI8S3uUVEZHDgM4mrk6xnaH7W5q9/t5Sa26ZLsKvVIrgUAvxPDrb1PVyNISXyr
	I/AgwpHi25HHzkoSrUVNISjxq97WTmFU7xjPjtXo8CJKSIxgszzTV6YvXK4Y0uunFmzHjnkoi6Zl4
	Cg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 69Q1m9Po3877404; Mon, 26 Oct 2026 10:48:09 +0900
X-Iguazu-Qid: 2yAaKKNbLebbYVsNWd
X-Iguazu-QSIG: v=2; s=1; t=1792979288; q=2yAaKKNbLebbYVsNWd; m=BscDdVg3nw+SGvY9CXJceHZm0g1F6f6+qtikpbyjkBo=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jCc2v6JXvz1xnZ; Mon, 26 Oct 2026 10:48:07 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
        claudiu.beznea.uj@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.12.y-cip 2/2] iio: adc: rzg2l_adc: Set driver data before enabling runtime PM
Date: Mon, 26 Oct 2026 10:48:06 +0900
X-TSB-HOP2: ON
Message-Id: <1792979286-32200-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1792979286-32200-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1792979286-32200-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 01:48:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24532
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
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/iio/adc/rzg2l_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 6dc97fac0e7f6a..8f9534c1c9a715 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -441,6 +441,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, indio_dev);
+
 	adc = iio_priv(indio_dev);
 
 	adc->hw_params = device_get_match_data(dev);
@@ -495,8 +497,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-- 
2.55.0


