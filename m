Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70297CA5FDD
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 14:11:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13086.1790950288485105978
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 07:11:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=xiat=hy=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 48CFA60A70;
	Fri,  2 Oct 2026 14:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9981F000FF;
	Fri,  2 Oct 2026 14:11:25 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3] PCI: rzg3s-host: Fix compilation warning
Date: Fri,  2 Oct 2026 17:11:24 +0300
Message-ID: <20261002141124.2402765-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 14:11:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24422

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Fix the following compilation warning:

pcie_rzg3s_host.c: In function =E2=80=98rzg3s_pcie_probe=E2=80=99:
../drivers/pci/controller/pcie-rzg3s-host.c:1558:2: warning: ISO C90 forb=
ids mixed declarations and code [-Wdeclaration-after-statement]
 1558 |  struct rzg3s_pcie_host *host;
      |  ^~~~~~

Fixes: c5249a6594d6 ("PCI: Add Renesas RZ/G3S host controller driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- fixed it by dropping ';'

 drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
index 987015e8ec9b..cac42fd8fc4a 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1554,7 +1554,7 @@ static int rzg3s_pcie_probe(struct platform_device =
*pdev)
 	struct device *dev =3D &pdev->dev;
 	struct device_node *np =3D dev->of_node;
 	struct device_node *sysc_np __free(device_node) =3D
-		of_parse_phandle(np, "renesas,sysc", 0);;
+		of_parse_phandle(np, "renesas,sysc", 0);
 	struct rzg3s_pcie_host *host;
 	int ret;
=20
--=20
2.43.0


