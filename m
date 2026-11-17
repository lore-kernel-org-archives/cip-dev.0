Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15777.1794915971403934597
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 36E6D46A51;
	Tue, 17 Nov 2026 11:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021401F000C4;
	Tue, 17 Nov 2026 11:46:09 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 09/69] clk: Provide managed helper to get and enable bulk clocks
Date: Tue, 17 Nov 2026 13:44:53 +0200
Message-ID: <20261117114553.1484215-10-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24850
Content-Type: text/plain; charset="utf-8"

From: Shradha Todi <shradha.t@samsung.com>

commit 265b07df758a998f60cf5b5aec6bd72ca676655e upstream.

Provide a managed devm_clk_bulk* wrapper to get and enable all
bulk clocks in order to simplify drivers that keeps all clocks
enabled for the time of driver operation.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Link: https://lore.kernel.org/r/20240220084046.23786-2-shradha.t@samsung.=
com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk-devres.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h      | 22 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 737aa70e2cb3..90e6078fb6e1 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -182,6 +182,46 @@ int __must_check devm_clk_bulk_get_all(struct device=
 *dev,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
=20
+static void devm_clk_bulk_release_all_enable(struct device *dev, void *r=
es)
+{
+	struct clk_bulk_devres *devres =3D res;
+
+	clk_bulk_disable_unprepare(devres->num_clks, devres->clks);
+	clk_bulk_put_all(devres->num_clks, devres->clks);
+}
+
+int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
+					      struct clk_bulk_data **clks)
+{
+	struct clk_bulk_devres *devres;
+	int ret;
+
+	devres =3D devres_alloc(devm_clk_bulk_release_all_enable,
+			      sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret =3D clk_bulk_get_all(dev, &devres->clks);
+	if (ret > 0) {
+		*clks =3D devres->clks;
+		devres->num_clks =3D ret;
+	} else {
+		devres_free(devres);
+		return ret;
+	}
+
+	ret =3D clk_bulk_prepare_enable(devres->num_clks, *clks);
+	if (!ret) {
+		devres_add(dev, devres);
+	} else {
+		clk_bulk_put_all(devres->num_clks, devres->clks);
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
+
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
 	struct clk **c =3D res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index cfa53819276e..6d798a221525 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -462,6 +462,22 @@ int __must_check devm_clk_bulk_get_optional(struct d=
evice *dev, int num_clks,
 int __must_check devm_clk_bulk_get_all(struct device *dev,
 				       struct clk_bulk_data **clks);
=20
+/**
+ * devm_clk_bulk_get_all_enable - Get and enable all clocks of the consu=
mer (managed)
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Returns success (0) or negative errno.
+ *
+ * This helper function allows drivers to get all clocks of the
+ * consumer and enables them in one operation with management.
+ * The clks will automatically be disabled and freed when the device
+ * is unbound.
+ */
+
+int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
+					      struct clk_bulk_data **clks);
+
 /**
  * devm_clk_get - lookup and obtain a managed reference to a clock produ=
cer.
  * @dev: device for clock "consumer"
@@ -922,6 +938,12 @@ static inline int __must_check devm_clk_bulk_get_all=
(struct device *dev,
 	return 0;
 }
=20
+static inline int __must_check devm_clk_bulk_get_all_enable(struct devic=
e *dev,
+						struct clk_bulk_data **clks)
+{
+	return 0;
+}
+
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {
--=20
2.43.0

