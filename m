Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FEACA5FDD
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 13:46:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12569.1790948794907739263
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 06:46:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=xiat=hy=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7CEFD60A70;
	Fri,  2 Oct 2026 13:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187071F000FF;
	Fri,  2 Oct 2026 13:46:31 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2] PCI: rzg3s-host: Fix compilation warning
Date: Fri,  2 Oct 2026 16:46:29 +0300
Message-ID: <20261002134629.2382379-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 13:46:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24417

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Fix the following compilation warning:

pcie_rzg3s_host.c: In function =E2=80=98rzg3s_pcie_probe=E2=80=99:
../drivers/pci/controller/pcie-rzg3s-host.c:1558:2: warning: ISO C90 forb=
ids mixed declarations and code [-Wdeclaration-after-statement]
 1558 |  struct rzg3s_pcie_host *host;
      |  ^~~~~~

With it dropped extra ';' at the end of the moved line.

Fixes: c5249a6594d6 ("PCI: Add Renesas RZ/G3S host controller driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- dropped extra ';' and updated patch description

 drivers/pci/controller/pcie-rzg3s-host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
index 987015e8ec9b..010b6747a0aa 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1553,10 +1553,10 @@ static int rzg3s_pcie_probe(struct platform_devic=
e *pdev)
 	struct pci_host_bridge *bridge;
 	struct device *dev =3D &pdev->dev;
 	struct device_node *np =3D dev->of_node;
-	struct device_node *sysc_np __free(device_node) =3D
-		of_parse_phandle(np, "renesas,sysc", 0);;
 	struct rzg3s_pcie_host *host;
 	int ret;
+	struct device_node *sysc_np __free(device_node) =3D
+		of_parse_phandle(np, "renesas,sysc", 0);
=20
 	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*host));
 	if (!bridge)
--=20
2.43.0


