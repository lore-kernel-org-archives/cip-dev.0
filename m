Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15916.1794915966495403596
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4C1A4430A4;
	Tue, 17 Nov 2026 11:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204B81F000C4;
	Tue, 17 Nov 2026 11:46:04 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 06/69] i3c: master: Add i3c_master_do_daa_ext() for post-hibernation address recovery
Date: Tue, 17 Nov 2026 13:44:50 +0200
Message-ID: <20261117114553.1484215-7-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24847
Content-Type: text/plain; charset="utf-8"

From: Adrian Hunter <adrian.hunter@intel.com>

commit c481ef12e713fb7c292d04f53b3532ac0804ab3d upstream.

After system hibernation, I3C Dynamic Addresses may be reassigned at boot
and no longer match the values recorded before suspend. Introduce
i3c_master_do_daa_ext() to handle this situation.

The restore procedure is straightforward: issue a Reset Dynamic Address
Assignment (RSTDAA), then run the standard DAA sequence. The existing DAA
logic already supports detecting and updating devices whose dynamic
addresses differ from previously known values.

Refactor the DAA path by introducing a shared helper used by both the
normal i3c_master_do_daa() path and the new extended restore function,
and correct the kernel-doc in the process.

Export i3c_master_do_daa_ext() so that master drivers can invoke it from
their PM restore callbacks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260123063325.8210-2-adrian.hunter@intel.=
com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[claudiu.beznea:
- kept the i3c_master_do_daa() definition untouched
- dropped i3c_master_rpm_{get,put}() from i3c_master_do_daa_ext()
  implementation since there is no rpm code implemented in the bus code
  from v5.10 CIP
- fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master.c       | 44 ++++++++++++++++++++++++++++++++++++++
 include/linux/i3c/master.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index eaece9d4aa23..1ce7794bf29e 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1555,6 +1555,50 @@ i3c_master_register_new_i3c_devs(struct i3c_master=
_controller *master)
 	}
 }
=20
+/**
+ * i3c_master_do_daa_ext() - Dynamic Address Assignment (extended versio=
n)
+ * @master: controller
+ * @rstdaa: whether to first perform Reset of Dynamic Addresses (RSTDAA)
+ *
+ * Perform Dynamic Address Assignment with optional support for System
+ * Hibernation (@rstdaa is true).
+ *
+ * After System Hibernation, Dynamic Addresses can have been reassigned =
at boot
+ * time to different values. A simple strategy is followed to handle tha=
t.
+ * Perform a Reset of Dynamic Addresses (RSTDAA) followed by the normal =
DAA
+ * procedure which has provision for reassigning addresses that differ f=
rom the
+ * previously recorded addresses.
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+int i3c_master_do_daa_ext(struct i3c_master_controller *master, bool rst=
daa)
+{
+	int rstret =3D 0;
+	int ret;
+
+	i3c_bus_maintenance_lock(&master->bus);
+
+	if (rstdaa) {
+		rstret =3D i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
+		if (rstret =3D=3D I3C_ERROR_M2)
+			rstret =3D 0;
+	}
+
+	ret =3D master->ops->do_daa(master);
+
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	if (ret)
+		return ret;
+
+	i3c_bus_normaluse_lock(&master->bus);
+	i3c_master_register_new_i3c_devs(master);
+	i3c_bus_normaluse_unlock(&master->bus);
+
+	return rstret ?: ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_do_daa_ext);
+
 /**
  * i3c_master_do_daa() - do a DAA (Dynamic Address Assignment)
  * @master: master doing the DAA
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index a5a60977a4bd..bef887ef15e0 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -543,6 +543,7 @@ int i3c_master_get_free_addr(struct i3c_master_contro=
ller *master,
 int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 				  u8 addr);
 int i3c_master_do_daa(struct i3c_master_controller *master);
+int i3c_master_do_daa_ext(struct i3c_master_controller *master, bool rst=
daa);
=20
 int i3c_master_set_info(struct i3c_master_controller *master,
 			const struct i3c_device_info *info);
--=20
2.43.0

