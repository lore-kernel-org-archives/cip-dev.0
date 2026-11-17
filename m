Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15906.1794915959197220387
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:45:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 36EB1404B5;
	Tue, 17 Nov 2026 11:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0558A1F000C4;
	Tue, 17 Nov 2026 11:45:56 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 01/69] bitops: add generic parity calculation for u8
Date: Tue, 17 Nov 2026 13:44:45 +0200
Message-ID: <20261117114553.1484215-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:45:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24842
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c320592f3f2a1e6a4e69e5db8e76fc66934a0a78 upstream.

There are multiple open coded implementations for getting the parity of
a byte in the kernel, even using different approaches. Take the pretty
efficient version from SPD5118 driver and make it generally available by
putting it into the bitops header. As long as there is just one parity
calculation helper, the creation of a distinct 'parity.h' header was
discarded. Also, the usage of hweight8() for architectures having a
popcnt instruction is postponed until a use case within hot paths is
desired. The motivation for this patch is the frequent use of odd parity
in the I3C specification and to simplify drivers there.

Changes compared to the original SPD5118 version are the addition of
kernel documentation, switching the return type from bool to int, and
renaming the argument of the function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Link: https://lore.kernel.org/r/20250107090204.6593-2-wsa+renesas@sang-en=
gineering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/bitops.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index e2930a990ea4..7190bbe4566e 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -209,6 +209,37 @@ static inline int get_count_order_long(unsigned long=
 l)
 	return (int)fls_long(--l);
 }
=20
+/**
+ * parity8 - get the parity of an u8 value
+ * @value: the value to be examined
+ *
+ * Determine the parity of the u8 argument.
+ *
+ * Returns:
+ * 0 for even parity, 1 for odd parity
+ *
+ * Note: This function informs you about the current parity. Example to =
bail
+ * out when parity is odd:
+ *
+ *	if (parity8(val) =3D=3D 1)
+ *		return -EBADMSG;
+ *
+ * If you need to calculate a parity bit, you need to draw the conclusio=
n from
+ * this result yourself. Example to enforce odd parity, parity bit is bi=
t 7:
+ *
+ *	if (parity8(val) =3D=3D 0)
+ *		val ^=3D BIT(7);
+ */
+static inline int parity8(u8 val)
+{
+	/*
+	 * One explanation of this algorithm:
+	 * https://funloop.org/codex/problem/parity/README.html
+	 */
+	val ^=3D val >> 4;
+	return (0x6996 >> (val & 0xf)) & 1;
+}
+
 /**
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word
--=20
2.43.0

