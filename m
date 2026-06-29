Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A3C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:54:04 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9264.1782773637984006694
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ABx9FeZf;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.15, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYCFMZTzUO8i9H350bII5y3dNBI1moRyY60pW+J3E7r8LDo+PVoWU9pn1pDT3kxAouauVQWV47YCqH8wQdl8ybUp7yhavm5aDOrLN3bc0r+R2ryI+RW9u72qzvzGE0eWd2VK2llch5cUflBfpJQ0bmaSCSu189X2BU5/g4h3ttr1jUSdRv2BvLImFxyIZ/AraLexG8DGxgjyjmi6UNNYCn2Dg7KJUkjBX/PiaSK1lp4oPr8Smqa9CxNcIW5YvEpoqwABZH0ylydFwPcbLp2MhPei/qUFw7GDlJMgZRIj83KGvKxa1AsIVrgwDTi/5n5gNpD/hs8NrVBgCaJLK5rg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nIPcYcUKIldL5XTmzO9y37c0AL+UtQY2N7J/U6ZqjU=;
 b=OEmaprFG9u+Ctf74OeUDXfU5RfFIV2pvdCS/6FDzdPlYVitVwH1tqwyzkh+rkyGR+OKQ1ZFWBlp8auUE/rZWmYAWn/Li8EMKq8NNa+Gk/Uisv7uYkFcoKKupLHZhMorQ1+cjyeQafx47iNs2BpHckw9eSugPKHzzd5jBoLCPlhVIXZJoWaSQYGssedG7D3fmhI4wefZ5ZimYpaDgxmQKwmwc4/9yt2Q/Lcf1g1rAivJyPiVN0RnxTFVQslBgVkzB5zexURZ7PtFGONOd3jol5u9reZJm4NUoZAEAjdAm1elGSUB9ZYIl/Frynw3ug+/Smja8pXFVUVRza9+lmNAW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nIPcYcUKIldL5XTmzO9y37c0AL+UtQY2N7J/U6ZqjU=;
 b=ABx9FeZf9ji27VxKLAQxTDseQZIk6OBtORDGt9C4hKANtxihOxmWsg2Ug64DKNCg8yDgU4AlvkNgA0bdQggKe9GraTQ6JmOi9i/RNERhUKfuvFv12C/kXmctCCyeAnHJ2p33Ynq5JpKVa3KcUlRC9O8ttT08icyGzcMim/Z3+Rk=
Received: from TYCP286CA0355.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:7c::12)
 by OS7PR01MB17086.jpnprd01.prod.outlook.com (2603:1096:604:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:52 +0000
Received: from TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c:cafe::79) by TYCP286CA0355.outlook.office365.com
 (2603:1096:405:7c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF0000501F.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:52 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 48473300017A;
	Tue, 30 Jun 2026 07:53:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/11] pinctrl: renesas: rzt2h: Skip PFC mode configuration if already set
Date: Mon, 29 Jun 2026 23:53:31 +0100
Message-ID: <20260629225331.10023-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF0000501F:EE_|OS7PR01MB17086:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1f41d783-4a82-4f95-ca23-08ded6314a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|18002099003|6133799003|11063799006|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	/fnm/qg8cAFyQ0N5JGxukU4SiV3biP43E7dNWdSPX2ovbht5BYuAAuDuNTpf4o6+yVLvNr9Cns2Q77hmtbSlXPMIfXx/9e+RPBbdW6EXsTwBo5L7VWbzOn01Epp9hJdkOfuU6OtsTWavsKz7KacrkWofJoMaRJiZ5Dlsa5sinEwS1KcaT+J5HmMrH4nM4+gotNtOUDGMLFjrRVEFivDQcJskGbyt81maY2yjrz0GKa9NWRGNlTZnXfFuyeNePiGAeXPc+UCpvoaBCOq3wH3HpJXk+/HkxMfGgPLEOic76CtHAZ4RKOEyebjloLbVuiFS8mnuoiVr+USWY20xOsgNJ9Ma4J/An2vO8a+MHutecj9P34nr2jHLsPdjAyOIGP3RT9jht9/wlmRcfioH9cYWDlyKx1sKc9Sfgd+A1O4Cmrn4X2/mIpcpn6i2ZVVSxa4WQmsMcbKkDpGs9kSH+1z/ZlijdzMcTcikLQ4INPO4cNUx5UnLxnsNbufZMBViRhtKagzB/RflPlDE+pyJxfNmmEJDQ3uWYB4o7ZWsc3KMyAkhMWGGCLlvaNVgmnSkDSsX8WuXx76ygJegzpEmhNMCfDaRSpKTDiMEHZ+OjG5e7tvafNc9thv1fuRUsaODN0pHhz2lV3U6CJ2gCSWQXmdWdCiaSwtwzxEBoqYUkP6TWO4=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(18002099003)(6133799003)(11063799006)(22082099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	p3pGJoYKsmJ/iPOw58rAisKwfBARIIbn4Z+chLlHnLFNbP0mFa2Gq1GL0qeFXke1Kfs5pZJZ5LcA77HZK1xAF3sad2Yar4aTKkLlvODV+gv1ANCFZfmcbrsXSFmVhNmXFY2GC2VfO2uQkBwG0ldg8hT+bMxaSHeoBLyyRE+vFL0X6khA5O4GVAas0KraEdAXFjjCz2bFEEKB8eiOTIhXRRHKolJm5u4jURWpCO2745gkgJIp7OreffigaUvudL/6aYsFrdlHnYq8/6fgNSqqVhruzvC2EJpKsABTMK0V+VmTlTF7plctSVNdZ48TP/3yZgmRaHrvax+zwG0fUyCSZj0+PnabGmNkFA/dkM3W2xbI5bw8G+4XrAsu7oCPRg95uEIzJzZhrVxpgGESRK6ySnSuwpU+8vLHEp1qOOlFnmscZcEOKQNJr4aKJq3YFbvz
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:52.5753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f41d783-4a82-4f95-ca23-08ded6314a95
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17086
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23319

commit f9fb67bc77d322568bf573e81335be0e9be2a7c8 upstream.

In rzt2h_pinctrl_set_pfc_mode(), read the PMC and PFC registers upfront
and skip the pin function configuration if the pin is already in
peripheral mode with the desired function.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260513115312.1574367-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index b620817f82db9..45166c77ac2fe 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -191,6 +191,12 @@ static void rzt2h_pinctrl_set_pfc_mode(struct rzt2h_pi=
nctrl *pctrl,
=20
 	guard(raw_spinlock_irqsave)(&pctrl->lock);
=20
+	reg64 =3D rzt2h_pinctrl_readq(pctrl, port, PFC(port));
+	/* Check if pin is already configured to the desired function */
+	if ((rzt2h_pinctrl_readb(pctrl, port, PMC(port)) & BIT(pin)) &&
+	    field_get(PFC_PIN_MASK(pin), reg64) =3D=3D func)
+		return;
+
 	/* Set pin to 'Non-use (Hi-Z input protection)'  */
 	reg16 =3D rzt2h_pinctrl_readw(pctrl, port, PM(port));
 	reg16 &=3D ~PM_PIN_MASK(pin);
@@ -200,7 +206,6 @@ static void rzt2h_pinctrl_set_pfc_mode(struct rzt2h_pin=
ctrl *pctrl,
 	rzt2h_pinctrl_set_gpio_en(pctrl, port, pin, true);
=20
 	/* Select Pin function mode with PFC register */
-	reg64 =3D rzt2h_pinctrl_readq(pctrl, port, PFC(port));
 	reg64 &=3D ~PFC_PIN_MASK(pin);
 	rzt2h_pinctrl_writeq(pctrl, port, reg64 | ((u64)func << (pin * 8)), PFC(p=
ort));
=20
--=20
2.43.0


