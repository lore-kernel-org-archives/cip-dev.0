From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:22 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 53/83] mmc: host: tmio: drop superfluous
	exit path
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-54-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit ad7014b3949b6c2b6ce46a546d6d204b5643e621 upstream.

The probe exit path on error does nothing since commit 94b110aff8679b
("mmc: tmio: add tmio_mmc_host_alloc/free()"), so we can bail out
immediately.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 87f7aa7..4e38fcc 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1146,7 +1146,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
-		goto host_free;
+		return ret;
 
 	_host->pdata = pdata;
 	platform_set_drvdata(pdev, mmc);
@@ -1156,14 +1156,12 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	ret = tmio_mmc_init_ocr(_host);
 	if (ret < 0)
-		goto host_free;
+		return ret;
 
 	_host->ctl = devm_ioremap(&pdev->dev,
 				  res_ctl->start, resource_size(res_ctl));
-	if (!_host->ctl) {
-		ret = -ENOMEM;
-		goto host_free;
-	}
+	if (!_host->ctl)
+		return -ENOMEM;
 
 	tmio_mmc_ops.card_busy = _host->card_busy;
 	tmio_mmc_ops.start_signal_voltage_switch = _host->start_signal_voltage_switch;
@@ -1201,10 +1199,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
 	 * looping forever...
 	 */
-	if (mmc->f_min == 0) {
-		ret = -EINVAL;
-		goto host_free;
-	}
+	if (mmc->f_min == 0)
+		return -EINVAL;
 
 	/*
 	 * While using internal tmio hardware logic for card detection, we need
@@ -1269,10 +1265,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	}
 
 	return 0;
-
-host_free:
-
-	return ret;
 }
 EXPORT_SYMBOL(tmio_mmc_host_probe);
 
-- 
2.7.4
