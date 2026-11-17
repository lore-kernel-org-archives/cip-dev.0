Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15913.1794915965720246538
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E9D0B63404;
	Tue, 17 Nov 2026 11:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3771F000C4;
	Tue, 17 Nov 2026 11:46:03 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 05/69] i3c: fix big-endian FIFO transfers
Date: Tue, 17 Nov 2026 13:44:49 +0200
Message-ID: <20261117114553.1484215-6-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24846
Content-Type: text/plain; charset="utf-8"

From: Arnd Bergmann <arnd@arndb.de>

commit d6ddd9beb1a5c32acb9b80f5c2cd8b17f41371d1 upstream.

Short MMIO transfers that are not a multiple of four bytes in size need
a special case for the final bytes, however the existing implementation
is not endian-safe and introduces an incorrect byteswap on big-endian
kernels.

This usually does not cause problems because most systems are
little-endian and most transfers are multiple of four bytes long, but
still needs to be fixed to avoid the extra byteswap.

Change the special case for both i3c_writel_fifo() and i3c_readl_fifo()
to use non-byteswapping writesl() and readsl() with a single element
instead of the byteswapping writel()/readl() that are meant for individua=
l
MMIO registers. As data is copied between a FIFO and a memory buffer,
the writesl()/readsl() loops are typically based on __raw_readl()/
__raw_writel(), resulting in the order of bytes in the FIFO to match
the order in the buffer, regardless of the CPU endianess.

The earlier versions in the dw-i3c and i3c-master-cdns had a correct
implementation, but the generic version that was recently added broke it.

Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and i3c_wr=
itel_fifo()")
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jorge Marques <jorge.marques@analog.com>
Link: https://lore.kernel.org/r/20250924201837.3691486-1-arnd@kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/internals.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index d16a79953709..5223c3a26c01 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -39,7 +39,11 @@ static inline void i3c_writel_fifo(void __iomem *addr,=
 const void *buf,
 		u32 tmp =3D 0;
=20
 		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
-		writel(tmp, addr);
+		/*
+		 * writesl() instead of writel() to keep FIFO
+		 * byteorder on big-endian targets
+		 */
+		writesl(addr, &tmp, 1);
 	}
 }
=20
@@ -56,7 +60,11 @@ static inline void i3c_readl_fifo(const void __iomem *=
addr, void *buf,
 	if (nbytes & 3) {
 		u32 tmp;
=20
-		tmp =3D readl(addr);
+		/*
+		 * readsl() instead of readl() to keep FIFO
+		 * byteorder on big-endian targets
+		 */
+		readsl(addr, &tmp, 1);
 		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
 	}
 }
--=20
2.43.0

