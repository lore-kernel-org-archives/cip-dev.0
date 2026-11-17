Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15922.1794915973036826081
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:13 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D2E76458A2;
	Tue, 17 Nov 2026 11:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FAB1F000C6;
	Tue, 17 Nov 2026 11:46:11 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 10/69] clk: Provide devm_clk_bulk_get_all_enabled() helper
Date: Tue, 17 Nov 2026 13:44:54 +0200
Message-ID: <20261117114553.1484215-11-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24851
Content-Type: text/plain; charset="utf-8"

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

commit 51e32e897539663957f7a0950f66b48f8896efee upstream.

Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
clocks") added devm_clk_bulk_get_all_enable() function, but missed to
return the number of clocks stored in the clk_bulk_data table referenced
by the clks argument.  Without knowing the number, it's not possible to
iterate these clocks when needed, hence the argument is useless and
could have been simply removed.

Introduce devm_clk_bulk_get_all_enabled() variant, which is consistent
with devm_clk_bulk_get_all() in terms of the returned value:

 > 0 if one or more clocks have been stored
 =3D 0 if there are no clocks
 < 0 if an error occurred

Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
the past form of 'enable'.

To reduce code duplication and improve patch readability, make
devm_clk_bulk_get_all_enable() use the new helper, as suggested by
Stephen Boyd.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://lore.kernel.org/r/20241019-clk_bulk_ena_fix-v4-1-57f108f64e=
70@collabora.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk-devres.c |  9 +++++----
 include/linux/clk.h      | 21 ++++++++++++++++-----
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 90e6078fb6e1..c7f9a6d21f63 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -190,8 +190,8 @@ static void devm_clk_bulk_release_all_enable(struct d=
evice *dev, void *res)
 	clk_bulk_put_all(devres->num_clks, devres->clks);
 }
=20
-int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
-					      struct clk_bulk_data **clks)
+int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+					       struct clk_bulk_data **clks)
 {
 	struct clk_bulk_devres *devres;
 	int ret;
@@ -216,11 +216,12 @@ int __must_check devm_clk_bulk_get_all_enable(struc=
t device *dev,
 	} else {
 		clk_bulk_put_all(devres->num_clks, devres->clks);
 		devres_free(devres);
+		return ret;
 	}
=20
-	return ret;
+	return devres->num_clks;
 }
-EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);
=20
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 6d798a221525..5581a4291a79 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -463,11 +463,13 @@ int __must_check devm_clk_bulk_get_all(struct devic=
e *dev,
 				       struct clk_bulk_data **clks);
=20
 /**
- * devm_clk_bulk_get_all_enable - Get and enable all clocks of the consu=
mer (managed)
+ * devm_clk_bulk_get_all_enabled - Get and enable all clocks of the cons=
umer (managed)
  * @dev: device for clock "consumer"
  * @clks: pointer to the clk_bulk_data table of consumer
  *
- * Returns success (0) or negative errno.
+ * Returns a positive value for the number of clocks obtained while the
+ * clock references are stored in the clk_bulk_data table in @clks field=
.
+ * Returns 0 if there're none and a negative value if something failed.
  *
  * This helper function allows drivers to get all clocks of the
  * consumer and enables them in one operation with management.
@@ -475,8 +477,8 @@ int __must_check devm_clk_bulk_get_all(struct device =
*dev,
  * is unbound.
  */
=20
-int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
-					      struct clk_bulk_data **clks);
+int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+					       struct clk_bulk_data **clks);
=20
 /**
  * devm_clk_get - lookup and obtain a managed reference to a clock produ=
cer.
@@ -938,7 +940,7 @@ static inline int __must_check devm_clk_bulk_get_all(=
struct device *dev,
 	return 0;
 }
=20
-static inline int __must_check devm_clk_bulk_get_all_enable(struct devic=
e *dev,
+static inline int __must_check devm_clk_bulk_get_all_enabled(struct devi=
ce *dev,
 						struct clk_bulk_data **clks)
 {
 	return 0;
@@ -1033,6 +1035,15 @@ static inline struct clk *clk_get_sys(const char *=
dev_id, const char *con_id)
=20
 #endif
=20
+/* Deprecated. Use devm_clk_bulk_get_all_enabled() */
+static inline int __must_check
+devm_clk_bulk_get_all_enable(struct device *dev, struct clk_bulk_data **=
clks)
+{
+	int ret =3D devm_clk_bulk_get_all_enabled(dev, clks);
+
+	return ret > 0 ? 0 : ret;
+}
+
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context=
. */
 static inline int clk_prepare_enable(struct clk *clk)
 {
--=20
2.43.0

