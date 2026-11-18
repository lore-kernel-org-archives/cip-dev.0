Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.962.1795020139008892401
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7080362BFC;
	Wed, 18 Nov 2026 16:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4856A1F000C4;
	Wed, 18 Nov 2026 16:42:17 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 21/35] i3c: renesas: Don't register devices when ENTDAA times out
Date: Wed, 18 Nov 2026 18:41:32 +0200
Message-ID: <20261118164146.3040784-22-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24984
Content-Type: text/plain; charset="utf-8"

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

commit b6e56fd8c8a8ac7992868a28702192372ab04015 upstream.

renesas_i3c_daa() derives the number of newly assigned dynamic addresses
from cmd->rx_count, which the response ISR sets to the number of address
slots ENTDAA left unassigned. It starts out as zero, which already means
"every address was assigned", so a timed out transfer leaves that value
in place and it gets used as a result.

On a bus with no target connected the ENTDAA times out and the driver
registers RENESAS_I3C_MAX_DEVS devices that are not there, each costing
the core two seconds on a GETPID that can only time out:

  i3c i3c-0: Failed to add I3C device at address 9, error -110
  ...
  i3c i3c-0: Failed to add I3C device at address 16, error -110

Start from maxdevs instead: no address is assigned before ENTDAA runs,
and the existing rx_count >=3D maxdevs check then reports an empty bus.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C c=
ontroller")
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260731070150.2519825-1-tommaso.merciai.x=
r@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 8249ef338707..c7dee242967d 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -692,7 +692,7 @@ static int renesas_i3c_daa(struct i3c_master_controll=
er *m)
=20
 	init_completion(&xfer->comp);
 	cmd =3D xfer->cmds;
-	cmd->rx_count =3D 0;
+	cmd->rx_count =3D i3c->maxdevs;
=20
 	ret =3D pm_runtime_resume_and_get(i3c->dev);
 	if (ret)
--=20
2.43.0

