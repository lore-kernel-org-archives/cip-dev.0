Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4677.1794226503218236005
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:03 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Kz6RHeLr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.71, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kftdwrn+C9Ma0V6AS/RyFU5uxuygKOELzMbj8HoSDHK1mjea5hpYTsHQnAbG2rEcKrOY2fyC71qihuXVNR9YbVgl5P9Sm552Gikd6cVMMx/RAS3V/dAcWdLqG7tqHy3VZ+XcFQvO49/6siFSgp3qj0K+qR6Aid7qrXeFqoj1rqN13FZ7ilnjgqLntmQQ4mLXvsFH7DlLVKx1Lx2BkiOdv8IjbBKmLplCFTOjtw7wfK0qPsGUXpkcEb/1Tuv4yzjJfAJzHxC8mW+2i2vv+shFkxOBS2xuzGz0or9NJetljpVbxSBPEWd6l1twVik/7GONZ5c5K7G8MtdTP5PcGhzFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGKYMbJ0VJp2Drg7hrnp4rv0uacjPC5p/5fNDaaWBWM=;
 b=bNvXwGB5/OD1saulpz9xcjjb3GQ1Pdt5kp54x+jCXCKLvfyppnGZuFGnbq5KTVOQVCu3JwdPQTCpcBIQajT5xyROZmqW7MPNkXXxPegRv7aeVfhMOiQYHy5PYUM2EzJcdtwa3KsaAznT7X2G/ewhNcfyAfNmAaIUkvO0+um+34VV7I6KHsaKGVV7BSCVBobXnrt6vRXZjYNrK0WS1RW5/EszQVq4f8NtILlu+TW84R/uPraFM0gfdw37WebrIaKilZVK4omccmmaFBxJ0GR79QiKkXzA25774wAl/1Y156+h0kvhT4udMZIZfUGa2ZOFk5jZh//nq7xNGM0OjIf1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGKYMbJ0VJp2Drg7hrnp4rv0uacjPC5p/5fNDaaWBWM=;
 b=Kz6RHeLr9ZQ3If2zNxmeLYf/gpSalrM19tzkGkyrB51EEPIItgB07cpsvj5YYm6tZjre4Hst0VMsWrpTk4bbHvdwsXhARCDgpHNjMcBK0not/GWo+kzUnA+82nGVb89HgvIxhNE8ac2ASJWntI/wpMvZJCoTZg5wMN6Kk01BcjE=
Received: from OS7PR01CA0048.jpnprd01.prod.outlook.com (2603:1096:604:254::18)
 by TY4PR01MB17864.jpnprd01.prod.outlook.com (2603:1096:405:34d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:14:59 +0000
Received: from OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:254:cafe::a3) by OS7PR01CA0048.outlook.office365.com
 (2603:1096:604:254::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:14:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D215.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:14:59 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A1AC1300022D;
	Mon,  9 Nov 2026 21:14:57 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/24] dt-bindings: clock: renesas,r9a09g077/87: Add LCDC_CLKD clock ID
Date: Mon,  9 Nov 2026 12:14:30 +0000
Message-ID: <20261109121451.6042-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D215:EE_|TY4PR01MB17864:EE_
X-MS-Office365-Filtering-Correlation-Id: db7b46e1-ad3e-4b4d-7652-08df3e5b12f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|261021121427099003|261009223027099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: GI6ZbUYUGdwO/QQAodf/5BzjyOjz4/0yOMnQ4owXtP3UE54pq6GCvB1qEXNaFsNJ7qcIJD68SBNomuIMTwtwB13jM1wYXkTIfK8+NKuZnRbGuCKd+Ra09UbPI3g/CigLFR2Oxh9J2s+15TDPXtE5JIuJMNduZW6xbD7l6PFN9rB87RFvtYomclG4zU7dwPNmXxp+fpjlfnttM/STtCEqjBI65PpwcLHvK6nleTa+5GlpD5Li8epZ+o8sET3ekOaqqlN9oakgEvGIz20Zkjfu1CSb5U9ucqoV0DctvO09U+IlbAqTgs4V2RU3P7KDBHVylmBNicldV7WeQy/79OyLvNPUuutxIoEAHYM/BWrjb8/whNyeVcEnZH3Mm3U4OnHXjoQjvkYZCRWum9dfrmsVVIy6CKZ2jHxChtcLyl6BfQ52iQqNAn0Vk9kzutJjB0YdqjqQ2uEW5HUpRg1Dvf2MIUpYwCptIi4JHRWJC4OdcLuDqYXXo9nx65dLZHIDRaQYrZcwRAkEXQTBCjz+tm9esprqmgubfWuRzEOBboZO2i1J1ekKSRvD/q4nQQVJihOjrAfaxO9ul7XfIoJOj680ivQa+isrs3j+RQiWRR9Ie7dRL1qEtvyHksi7OozJfqgTdfsDwY8JMqha7ps/NvC4nw==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FWbClRyEm9TYr7gpmyavvZ2oJ/L7h6z6HFX6PZndihzctJWcGxMswKMr+V0Q/KEJFO2R4Lk8IWBwhVN9BQcXpwMOftPHke233fCAhL9xFEi/zCkceDp7XNpnrEHhhC6hvRa4mEJUYjMHkRDxyr+oRyZH5d9oGetYVIXB0YBDkqzTiHVR3WEs/rCSyiACyL9PIcPtS9xe5PHbLERBtXaZR7W7dtfjGlsX5zOTuZvasDzwmwr+9Ujct5wTuVAN/kTrO/albrMUzcm24HxnXBINriWu112CraPTfUxxnaDjpDpG8p/RYZSryMr7BqAjie2+2NnLBOBku77wxSC2EhwgISEbRpFmVp9P9Y719czL9d2jv361JHUvpN5MQvq2ZzmVb27mG/pnbhAfbihZAbOnVP7LoUmKG+HZR6si6/BDPCZREXB1b4Ti90G4Ac0ix26a
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:14:59.0084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7b46e1-ad3e-4b4d-7652-08df3e5b12f2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17864
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24705
Content-Type: text/plain; charset="utf-8"

commit c4a16f90797e2d8bebf875fd02547fef76ae3b76 upstream.

Add the LCDC clockd (LCDC_CLKD) definition for the Renesas RZ/T2H
(R9A09G077) and RZ/N2H (R9A09G087) SoCs. LCDC_CLKD is used as the
operating clock for LCDC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260615104845.4122868-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h | 1 +
 include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h b/inclu=
de/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
index c4863e444458f..f6cb8d649a467 100644
--- a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
@@ -34,5 +34,6 @@
 #define R9A09G077_XSPI_CLK0		22
 #define R9A09G077_XSPI_CLK1		23
 #define R9A09G077_PCLKCAN		24
+#define R9A09G077_LCDC_CLKD		25
=20
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G077_CPG_H__ */
diff --git a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h b/inclu=
de/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
index 0d53f1e650776..312e563b322e7 100644
--- a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
@@ -34,5 +34,6 @@
 #define R9A09G087_XSPI_CLK0		22
 #define R9A09G087_XSPI_CLK1		23
 #define R9A09G087_PCLKCAN		24
+#define R9A09G087_LCDC_CLKD		25
=20
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G087_CPG_H__ */
--=20
2.43.0

