Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15826.1794916032448094241
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 401514135B;
	Tue, 17 Nov 2026 11:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167F11F000C4;
	Tue, 17 Nov 2026 11:47:10 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 47/69] regulator: Add devm helpers for get and enable
Date: Tue, 17 Nov 2026 13:45:31 +0200
Message-ID: <20261117114553.1484215-48-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24888
Content-Type: text/plain; charset="utf-8"

From: Matti Vaittinen <mazziesaccount@gmail.com>

commit da279e6965b3838e99e5c0ab8f76b87bf86b31a5 upstream.

A few regulator consumer drivers seem to be just getting a regulator,
enabling it and registering a devm-action to disable the regulator at
the driver detach and then forget about it.

We can simplify this a bit by adding a devm-helper for this pattern.
Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://lore.kernel.org/r/ed7b8841193bb9749d426f3cb3b199c9460794cd.=
1660292316.git.mazziesaccount@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/regulator/devres.c         | 164 +++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h |  27 +++++
 2 files changed, 191 insertions(+)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 3091210889e3..7d3b591fb180 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -70,6 +70,65 @@ struct regulator *devm_regulator_get_exclusive(struct =
device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_get_exclusive);
=20
+static void regulator_action_disable(void *d)
+{
+	struct regulator *r =3D (struct regulator *)d;
+
+	regulator_disable(r);
+}
+
+static int _devm_regulator_get_enable(struct device *dev, const char *id=
,
+				      int get_type)
+{
+	struct regulator *r;
+	int ret;
+
+	r =3D _devm_regulator_get(dev, id, get_type);
+	if (IS_ERR(r))
+		return PTR_ERR(r);
+
+	ret =3D regulator_enable(r);
+	if (!ret)
+		ret =3D devm_add_action_or_reset(dev, &regulator_action_disable, r);
+
+	if (ret)
+		devm_regulator_put(r);
+
+	return ret;
+}
+
+/**
+ * devm_regulator_get_enable_optional - Resource managed regulator get a=
nd enable
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
+ *
+ * Get and enable regulator for duration of the device life-time.
+ * regulator_disable() and regulator_put() are automatically called on d=
river
+ * detach. See regulator_get_optional() and regulator_enable() for more
+ * information.
+ */
+int devm_regulator_get_enable_optional(struct device *dev, const char *i=
d)
+{
+	return _devm_regulator_get_enable(dev, id, OPTIONAL_GET);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_get_enable_optional);
+
+/**
+ * devm_regulator_get_enable - Resource managed regulator get and enable
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
+ *
+ * Get and enable regulator for duration of the device life-time.
+ * regulator_disable() and regulator_put() are automatically called on d=
river
+ * detach. See regulator_get() and regulator_enable() for more
+ * information.
+ */
+int devm_regulator_get_enable(struct device *dev, const char *id)
+{
+	return _devm_regulator_get_enable(dev, id, NORMAL_GET);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_get_enable);
+
 /**
  * devm_regulator_get_optional - Resource managed regulator_get_optional=
()
  * @dev: device to supply
@@ -166,6 +225,111 @@ int devm_regulator_bulk_get(struct device *dev, int=
 num_consumers,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_bulk_get);
=20
+static int devm_regulator_bulk_match(struct device *dev, void *res,
+				     void *data)
+{
+	struct regulator_bulk_devres *match =3D res;
+	struct regulator_bulk_data *target =3D data;
+
+	/*
+	 * We check the put uses same consumer list as the get did.
+	 * We _could_ scan all entries in consumer array and check the
+	 * regulators match but ATM I don't see the need. We can change this
+	 * later if needed.
+	 */
+	return match->consumers =3D=3D target;
+}
+
+/**
+ * devm_regulator_bulk_put - Resource managed regulator_bulk_put()
+ * @consumers: consumers to free
+ *
+ * Deallocate regulators allocated with devm_regulator_bulk_get(). Norma=
lly
+ * this function will not need to be called and the resource management
+ * code will ensure that the resource is freed.
+ */
+void devm_regulator_bulk_put(struct regulator_bulk_data *consumers)
+{
+	int rc;
+	struct regulator *regulator =3D consumers[0].consumer;
+
+	rc =3D devres_release(regulator->dev, devm_regulator_bulk_release,
+			    devm_regulator_bulk_match, consumers);
+	if (rc !=3D 0)
+		WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_bulk_put);
+
+static void devm_regulator_bulk_disable(void *res)
+{
+	struct regulator_bulk_devres *devres =3D res;
+	int i;
+
+	for (i =3D 0; i < devres->num_consumers; i++)
+		regulator_disable(devres->consumers[i].consumer);
+}
+
+/**
+ * devm_regulator_bulk_get_enable - managed get'n enable multiple regula=
tors
+ *
+ * @dev:           device to supply
+ * @num_consumers: number of consumers to register
+ * @id:            list of supply names or regulator IDs
+ *
+ * @return 0 on success, an errno on failure.
+ *
+ * This helper function allows drivers to get several regulator
+ * consumers in one operation with management, the regulators will
+ * automatically be freed when the device is unbound.  If any of the
+ * regulators cannot be acquired then any regulators that were
+ * allocated will be freed before returning to the caller.
+ */
+int devm_regulator_bulk_get_enable(struct device *dev, int num_consumers=
,
+				   const char * const *id)
+{
+	struct regulator_bulk_devres *devres;
+	struct regulator_bulk_data *consumers;
+	int i, ret;
+
+	devres =3D devm_kmalloc(dev, sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	devres->consumers =3D devm_kcalloc(dev, num_consumers, sizeof(*consumer=
s),
+					 GFP_KERNEL);
+	consumers =3D devres->consumers;
+	if (!consumers)
+		return -ENOMEM;
+
+	devres->num_consumers =3D num_consumers;
+
+	for (i =3D 0; i < num_consumers; i++)
+		consumers[i].supply =3D id[i];
+
+	ret =3D devm_regulator_bulk_get(dev, num_consumers, consumers);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < num_consumers; i++) {
+		ret =3D regulator_enable(consumers[i].consumer);
+		if (ret)
+			goto unwind;
+	}
+
+	ret =3D devm_add_action(dev, devm_regulator_bulk_disable, devres);
+	if (!ret)
+		return 0;
+
+unwind:
+	while (--i >=3D 0)
+		regulator_disable(consumers[i].consumer);
+
+	devm_regulator_bulk_put(consumers);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_regulator_bulk_get_enable);
+
 static void devm_rdev_release(struct device *dev, void *res)
 {
 	regulator_unregister(*(struct regulator_dev **)res);
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator=
/consumer.h
index 42da800f86ff..510e48441e69 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -189,6 +189,8 @@ struct regulator *__must_check regulator_get_optional=
(struct device *dev,
 						      const char *id);
 struct regulator *__must_check devm_regulator_get_optional(struct device=
 *dev,
 							   const char *id);
+int devm_regulator_get_enable(struct device *dev, const char *id);
+int devm_regulator_get_enable_optional(struct device *dev, const char *i=
d);
 void regulator_put(struct regulator *regulator);
 void devm_regulator_put(struct regulator *regulator);
=20
@@ -231,8 +233,11 @@ int __must_check regulator_bulk_get(struct device *d=
ev, int num_consumers,
 				    struct regulator_bulk_data *consumers);
 int __must_check devm_regulator_bulk_get(struct device *dev, int num_con=
sumers,
 					 struct regulator_bulk_data *consumers);
+void devm_regulator_bulk_put(struct regulator_bulk_data *consumers);
 int __must_check regulator_bulk_enable(int num_consumers,
 				       struct regulator_bulk_data *consumers);
+int devm_regulator_bulk_get_enable(struct device *dev, int num_consumers=
,
+				   const char * const *id);
 int regulator_bulk_disable(int num_consumers,
 			   struct regulator_bulk_data *consumers);
 int regulator_bulk_force_disable(int num_consumers,
@@ -338,6 +343,17 @@ devm_regulator_get_exclusive(struct device *dev, con=
st char *id)
 	return ERR_PTR(-ENODEV);
 }
=20
+static inline int devm_regulator_get_enable(struct device *dev, const ch=
ar *id)
+{
+	return -ENODEV;
+}
+
+static inline int devm_regulator_get_enable_optional(struct device *dev,
+						     const char *id)
+{
+	return -ENODEV;
+}
+
 static inline struct regulator *__must_check
 regulator_get_optional(struct device *dev, const char *id)
 {
@@ -359,6 +375,10 @@ static inline void devm_regulator_put(struct regulat=
or *regulator)
 {
 }
=20
+static inline void devm_regulator_bulk_put(struct regulator_bulk_data *c=
onsumers)
+{
+}
+
 static inline int regulator_register_supply_alias(struct device *dev,
 						  const char *id,
 						  struct device *alias_dev,
@@ -459,6 +479,13 @@ static inline int regulator_bulk_enable(int num_cons=
umers,
 	return 0;
 }
=20
+static inline int devm_regulator_bulk_get_enable(struct device *dev,
+						 int num_consumers,
+						 const char * const *id)
+{
+	return 0;
+}
+
 static inline int regulator_bulk_disable(int num_consumers,
 					 struct regulator_bulk_data *consumers)
 {
--=20
2.43.0

