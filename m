Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15911.1794915963316934389
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 236E043D3D;
	Tue, 17 Nov 2026 11:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05FA1F000C4;
	Tue, 17 Nov 2026 11:46:01 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 04/69] i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()
Date: Tue, 17 Nov 2026 13:44:48 +0200
Message-ID: <20261117114553.1484215-5-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24845
Content-Type: text/plain; charset="utf-8"

From: Jorge Marques <jorge.marques@analog.com>

commit 733b439375b494e8a6950ab47d18a4b615b73cb3 upstream.

The I3C abstraction expects u8 buffers, but some controllers operate with
a 32-bit bus width FIFO and cannot flag valid bytes individually. To avoi=
d
reading or writing outside the buffer bounds, use 32-bit accesses where
possible and apply memcpy for any remaining bytes

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250624-i3c-writesl-readsl-v3-1-63ccf087=
0f01@analog.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/internals.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 1906c711f38a..d16a79953709 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,4 +24,41 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev=
);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+
+/**
+ * i3c_writel_fifo - Write data buffer to 32bit FIFO
+ * @addr: FIFO Address to write to
+ * @buf: Pointer to the data bytes to write
+ * @nbytes: Number of bytes to write
+ */
+static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
+				   int nbytes)
+{
+	writesl(addr, buf, nbytes / 4);
+	if (nbytes & 3) {
+		u32 tmp =3D 0;
+
+		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
+		writel(tmp, addr);
+	}
+}
+
+/**
+ * i3c_readl_fifo - Read data buffer from 32bit FIFO
+ * @addr: FIFO Address to read from
+ * @buf: Pointer to the buffer to store read bytes
+ * @nbytes: Number of bytes to read
+ */
+static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
+				  int nbytes)
+{
+	readsl(addr, buf, nbytes / 4);
+	if (nbytes & 3) {
+		u32 tmp;
+
+		tmp =3D readl(addr);
+		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
+	}
+}
+
 #endif /* I3C_INTERNAL_H */
--=20
2.43.0

