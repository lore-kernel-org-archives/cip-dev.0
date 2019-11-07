From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:37 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 08/83] mmc: sdhi: error message on
	ENOMEM is superfluous
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2bf8ab6ba23483a49d29a726d047f3be81ccc952 upstream.

We will get a full dump anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index fd6a0e2..bf6c3ac 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -215,10 +215,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
-	if (priv == NULL) {
-		dev_err(&pdev->dev, "kzalloc failed\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	mmc_data = &priv->mmc_data;
 	dma_priv = &priv->dma_priv;
-- 
2.7.4
