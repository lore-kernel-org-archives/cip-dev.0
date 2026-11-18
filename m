Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.905.1795020111707457871
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:41:51 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 21EF962BF5;
	Wed, 18 Nov 2026 16:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9761F000C4;
	Wed, 18 Nov 2026 16:41:49 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 01/35] i3c: master: Add i3c_master_do_daa_ext() for post-hibernation address recovery
Date: Wed, 18 Nov 2026 18:41:12 +0200
Message-ID: <20261118164146.3040784-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:41:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24964
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
   from v6.12 CIP
 - drop i3c_bus_normaluse_lock()/i3c_bus_normaluse_unlock() around
   i3c_master_register_new_i3c_devs() since it take/release the lock by
   itself]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master.c       | 42 ++++++++++++++++++++++++++++++++++++++
 include/linux/i3c/master.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 049a141ad8cb..08c40dcfffc8 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1718,6 +1718,48 @@ i3c_master_register_new_i3c_devs(struct i3c_master=
_controller *master)
 	i3c_bus_maintenance_unlock(&master->bus);
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
+	i3c_master_register_new_i3c_devs(master);
+
+	return rstret ?: ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_do_daa_ext);
+
 /**
  * i3c_master_do_daa() - do a DAA (Dynamic Address Assignment)
  * @master: master doing the DAA
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index ed7959b0919f..f14bce56128c 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -602,6 +602,7 @@ int i3c_master_get_free_addr(struct i3c_master_contro=
ller *master,
 int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 				  u8 addr);
 int i3c_master_do_daa(struct i3c_master_controller *master);
+int i3c_master_do_daa_ext(struct i3c_master_controller *master, bool rst=
daa);
 struct i3c_dma *i3c_master_dma_map_single(struct device *dev, void *ptr,
 					  size_t len, bool force_bounce,
 					  enum dma_data_direction dir);
--=20
2.43.0

