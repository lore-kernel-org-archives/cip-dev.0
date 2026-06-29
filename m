Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97DCC44501
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:53:53 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9255.1782773624649703816
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=G8KyUbdJ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.18, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3lIsPunKuNgJA1rzWOVzgn62rvD6f4EffjFVIX7PcgZc9mjUK3o8WPpcpzAeSrm/ZbkCNsUsoF2AGO9uJipVt3qlopqIX1ISDDU8dYs8834q3iZ7+1gAvUxgis6C9cgRKlrB9s7qo9BPO3HN5RK6FSO7Ecnkc8YmEiv2THPYBRPdE3HpU+WdBzcxLA+ibZ/Ifh4BlxqwJihx8y0y6x9FnpxgsxCRvovfveRcnul8T2bJFiBuX/65tLIIjIgxxPET+rQDY3DAnoUBZXbKCxO9a96hQnhX2UYCwWyK+Ap82eM/0ET/oQNFzmeldPn+K9L9+T7LHC5zgT4Vf33OUrBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6jCKasmMZhZogKmdCyU0TnOnXy830tYM4oeTOK8tHE=;
 b=hsg7cUw1UwPz0htmz7zQeZjwcJedPU82xayCnQHu36bUPMdUbYekT+Wt0QaYE2lFKdZy6uhMyn94hHk3MioZdRCWGB7vrWJLaoR9pnJfuB4GO7HdRnZTQdvnY3vEzItHmwLN9VjCAfsrGmVlSQu+dj/K7xjpUsENbxLhJzhlX2frgPIfd1OQGkQfsJ5yY37t/1g/1lwNshGd0vA7a6PUamxRr7ugZVcBPJCWfmsbUxxZ6PqIq310V+hw9X9foITEi7BsiVYK44GNq6QQA83ZaIxM4TDVw7IEF0AjstHB+SdYa8VkW9fH+w7fxe6ICKDT01KRyUAQBbVZ2kuMNiKb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6jCKasmMZhZogKmdCyU0TnOnXy830tYM4oeTOK8tHE=;
 b=G8KyUbdJZhZwPNpkFmSeBhiI1UYwX9vzjOvQRarHD8Jne29u/DS1sETfpfzZk2tbBPnpWmYkxMMXMEecbddIheLQ7pvbAB68q7r3D8AFeZ4wqQlZfF3bZ0/ggKrcL3RnbkKrObZ/oRRbMfCDW4oRh1DNDtSVdjVOEqeEvWHJiMo=
Received: from OSTPR01CA0018.jpnprd01.prod.outlook.com (2603:1096:604:221::16)
 by TYWPR01MB10709.jpnprd01.prod.outlook.com (2603:1096:400:2a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:39 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:221:cafe::29) by OSTPR01CA0018.outlook.office365.com
 (2603:1096:604:221::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:39 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id EE9F13000255;
	Tue, 30 Jun 2026 07:53:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/11] pinctrl: renesas: Remove unneeded semicolons
Date: Mon, 29 Jun 2026 23:53:23 +0100
Message-ID: <20260629225331.10023-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYWPR01MB10709:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: de8c1101-fce1-4455-a2d6-08ded63142ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|13003099007|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	GdS6ydA0JKahgh0QVy/u7tHSEH5xzr+XGBNJstPRD/HRd0Fr2mx+h9U36j9kNt/ut8GBwA+v1QMRcUu87KCdCZio6XZKyuRnjwD6k8vSgoRWNDH65bgJqPMWshx1HoEF4obvVyEMMSYksUtfjkZZKhvfLD8HeXhCYAFqIYuRID6ESPtC5wrPDdDNkkFN6PmDDSYA65wW7SxdWtLjuSBt6GzjxYhz49vWw25BJzigcDOKkL7qOTJoXQloHEtw1XDipoVpSJMTI5anElB/iMH32SjsLyl1lAZf8CK5GpMXNTBle3y2MrwTOA9hWo6ga/MccmIGfNZbZhxcWhcBoJ1CI6M5Y1DdO6WGZHRJ7xAwG8JpzuraMRPt9eeDZEiMsFJT5Mo8gyMl2U2R15EWV9QEr2NuQINHVNxzg7Jdz9ziVly+dEQDsiB0TRtz9SogjvWyCUHTPRFFlCnlV7RJx/3PnX5gzU5MyIAkR9DD52N3nlF/Or35BVQwwnkBMvJ2giHt/T8HEgIabXltBpALlzDwbNjLu6gjUTqccx2lPG+fH1g68u/8gLm87i8Rwh7ip0mgug3IMLrETXwLaqfwwRhBtu8L6iMNMqlywoa0OK3pcsq6MJ5jsob1QhVdPlGcGa+127Oy2LCEc00hrFEkfJoImQ==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(13003099007)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	sUv3ve1XdrOaLeaNe4EnAtmfoSD3L+5spjHmeA2Fk2h1iIWA/SUk3wUOdZwfIkXJOBAfnTb+IC7XdnGoolUDl9qnNb0/VpgbrGrayKk8t0Qc9js0BkdeyJEKeFoUVlTnTHw3fEZeASPcpDK7PKPdhCqmA29vvP5hxo4zzNLuR5biC6DkC43og+AKkc6vvq9399BTFfMQ300MI9QeWpDKKBAwVhAnXg5meWAkVC53/qQQ6JITO7V1YLbVJ5qPtwF7VsIxAzQbd/jZ2SuNkvf/REEJOnMQYXN0WA1AnF/rnsjO/nDJJXada9KMEEvTTH3Szzif30Tl1Gucwmi5XYe7iO/7iO+p52aFiVshw+IRAOM/fwQk7DpHuuKVQhmdzXj0tncwiQLnf+qEGv908HR0ITZpHZ1iyTAaQxlArI2vDkppf/neXOthAphNZwtIbgb7
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:39.3043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de8c1101-fce1-4455-a2d6-08ded63142ae
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10709
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:53:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23311

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit bf48f99d95dfd664ddb7c4d69b182606f5ed8605 upstream.

Semicolons after end of function braces are not needed, remove them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/99db8c1bfb64980b54a4b5c4988c7935609133e1.175=
8718027.git.geert+renesas@glider.be
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c |  4 ++--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index d567612b30953..63c49e813fc15 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -144,7 +144,7 @@ static void rzt2h_pinctrl_set_pfc_mode(struct rzt2h_pin=
ctrl *pctrl,
 	/* Switch to Peripheral pin function with PMC register */
 	reg16 =3D rzt2h_pinctrl_readb(pctrl, port, PMC(port));
 	rzt2h_pinctrl_writeb(pctrl, port, reg16 | BIT(pin), PMC(port));
-};
+}
=20
 static int rzt2h_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int func_selector,
@@ -182,7 +182,7 @@ static int rzt2h_pinctrl_set_mux(struct pinctrl_dev *pc=
tldev,
 	}
=20
 	return 0;
-};
+}
=20
 static int rzt2h_map_add_config(struct pinctrl_map *map,
 				const char *group_or_pin,
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/rene=
sas/pinctrl-rzv2m.c
index 8c7169db4fcce..fec603758687d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -155,7 +155,7 @@ static void rzv2m_pinctrl_set_pfc_mode(struct rzv2m_pin=
ctrl *pctrl,
 	/* Unmask input/output */
 	rzv2m_writel_we(pctrl->base + EN_MSK(port), pin, 0);
 	rzv2m_writel_we(pctrl->base + DI_MSK(port), pin, 0);
-};
+}
=20
 static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int func_selector,
@@ -186,7 +186,7 @@ static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pc=
tldev,
 	}
=20
 	return 0;
-};
+}
=20
 static int rzv2m_map_add_config(struct pinctrl_map *map,
 				const char *group_or_pin,
@@ -551,7 +551,7 @@ static int rzv2m_pinctrl_pinconf_get(struct pinctrl_dev=
 *pctldev,
 	*config =3D pinconf_to_config_packed(param, arg);
=20
 	return 0;
-};
+}
=20
 static int rzv2m_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
@@ -689,7 +689,7 @@ static int rzv2m_pinctrl_pinconf_group_set(struct pinct=
rl_dev *pctldev,
 	}
=20
 	return 0;
-};
+}
=20
 static int rzv2m_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
 					   unsigned int group,
@@ -716,7 +716,7 @@ static int rzv2m_pinctrl_pinconf_group_get(struct pinct=
rl_dev *pctldev,
 	}
=20
 	return 0;
-};
+}
=20
 static const struct pinctrl_ops rzv2m_pinctrl_pctlops =3D {
 	.get_groups_count =3D pinctrl_generic_get_group_count,
--=20
2.43.0


