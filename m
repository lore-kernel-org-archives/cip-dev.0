Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34080.1792979116153729704
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 18:45:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=fPfMbu6y;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1792979108;x=1794188708;bh=Db
	kLtzVnFvHEkxWB2WcOA7g3xO1kMT8VcxVz/LbyyNU=;b=fPfMbu6yAhMGq4Sq9ccnAAab8rWzj+64
	vptcHbhmDELSQpbJPsSPZ9NI+ic8kkXkWhauZQl5WAn6b3J1kk2AxN6Zel8+QBi4xsW2k1QpmOpwb
	VjgaQLueIQPylkUMyEFs8nxfffOOZpK7Wz6lr6XsZzQvh+djvYWOM2f8n1Nz9w5o4M/GufnUskR9z
	/iKW45iuZP/mQ/RlPPfKbVY96RgEDECMLdArYHqOZMKlj/lr23qZi4jfIXxqLemEhwQ/7p5DaA905
	OOwCiZRNUNYvhzlqu6e7UGguTjypA0B3T6/oLOQ5yG8vJIVKc9KNLn4jYjRadcOR04KWtrkft1pRo
	Zg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 69Q1j70u3864285; Mon, 26 Oct 2026 10:45:07 +0900
X-Iguazu-Qid: 2yAaPpRdHDRVfCyYQo
X-Iguazu-QSIG: v=2; s=1; t=1792979107; q=2yAaPpRdHDRVfCyYQo; m=av4+OvF9zvh8l0jIyC1Ea+oGFYvzYAXHVjoYcdu52uE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jCbzQ4LQPz1xnZ; Mon, 26 Oct 2026 10:45:06 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, claudiu.beznea.uj@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 5.10.y-cip 1/1] iio: adc: rzg2l_adc: Set driver data before enabling runtime PM
Date: Mon, 26 Oct 2026 10:45:04 +0900
X-TSB-HOP2: ON
Message-Id: <1792979104-32023-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1792979104-32023-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1792979104-32023-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 01:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24524
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
index d48aec92add9ac..418211c06f1fe2 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -436,6 +436,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, indio_dev);
+
 	adc = iio_priv(indio_dev);
 
 	adc->hw_params = device_get_match_data(dev);
@@ -490,8 +492,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-- 
2.55.0


