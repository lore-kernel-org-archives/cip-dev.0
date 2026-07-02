Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F0AC44500
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:30 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.65755.1782987863186018676
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:24:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FGgd5T6R;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.10, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+F8MNahrWis2LVKniYMHTSQg6a9eDx4rS31PbFGLo13YBuIntCd1JuzfUdu7u0dL+VMlszhgml43tdSw7pn60DBda8vrmFxbVVEMvkWzb4yvfd+J0R4Tpzl//GSt99o7y+Zzsm0GXsbgWkVDJoSSo7U76ur6au+CAK5srCOB1ickz9g5Smxfa5aGBniUQp5woeI/AuyPhmSa13Ty2C8a32RnWvibzAgAbJiD9bAT8KS+2K37jQ/q3zgfwldVDvWl+r22wf5UBl3zfPUuZ3O00Kts91remSajj+Zf+x0n2sdxb+oU+kNz3YvZz/8Da50YMdtKYeyQHXK/j1Lhu1XuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hzy8rLTNW71pE5nl4o78T56x5xjQ7FlpJ4HeC+uW+P0=;
 b=xfQLL25AAFSlKqNX2/AAEZgkwD7I60gfKOSVvOBvqrKqT48inmJPQmwhXfXjA3vaHOhkVYpvoJh0zyG/+t1JBMNFmloAIDHCljY5nI9oCIP4pjYEcb5MsN1egPJ7MrqHLXToKvF7H9d2LJrBijboo/wekgLQrz36bbzH4wXDnZNYRttHWlpXghi4ML/desfdaoAUOpXMtsyq6mKD4FoNS6Wq9KQY8G8lEr49jgoJ6TcJAm5nhp4sYZXBh2il09OR0YtIx9cNoacB8wbwUgUOZ90QIdN1FZVd67hmdeXneI4oN6Y1/XmO45zLwL7igjrcx9LPsQOHRpS2lg3N1jSQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hzy8rLTNW71pE5nl4o78T56x5xjQ7FlpJ4HeC+uW+P0=;
 b=FGgd5T6RYGqKKKtUnVNkwilfiTv3Dq4cEBDl3a7qvzMLGHmf6nCU+LXwHQDvfR8Kd/WRp2nGP72FqpVxeRzEu0tIwf9Z04EdhQlYC+Q4XugsX7DUzNoFrTLrtODkWeDqXpNlEwJWdVM82KWFU/PU7Eaq2rYzIhZgzpT39y6smVA=
Received: from TY4PR01CA0014.jpnprd01.prod.outlook.com (2603:1096:405:26e::17)
 by OSCPR01MB14409.jpnprd01.prod.outlook.com (2603:1096:604:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:24:18 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26e:cafe::87) by TY4PR01CA0014.outlook.office365.com
 (2603:1096:405:26e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 2 Jul 2026 10:24:18 +0000
Received: from Ubuntu-22.. (gbr-5cg2250zyy.diasemi.com [10.24.0.18])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 44F8B300024A;
	Thu,  2 Jul 2026 19:24:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 10/10] pinctrl: renesas: rzt2h: Skip PFC mode configuration if already set
Date: Thu,  2 Jul 2026 11:23:49 +0100
Message-ID: <20260702102349.23431-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|OSCPR01MB14409:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1b833e51-224c-4a4d-5949-08ded82412fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|13003099007|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	bZ3g/2ZHoCcc0cxxTf1yHyI31+qM7lAUrX0d7+7OFALlqizWM3eg5eeXjUZyUKGYg4KWKGIs2VheZOvfErfQVkyPuczA2rUwsgSgmQ9Aq1OY/gmHo8TB0oipXtBKDIG14fN86pVrnuHcbHhDE1aRda7qdOalLmiJx4dJJb5T29vTnBAchZt+GcwDgz95V7HFJcs9/nXau64WXNZGawGNs4Tm9j0aJwNET1mWjcM6MxElOtkW7G+cgERGi9O4Ef+9e7Y6wyas8w8QwSGzpB8oFL2LZ7nTzjbo7NVco3frJ5gkz/tyPE3V8i88dfEF3C/guWftEPTczFErB1F6Vduv3cTvJO7zFUzoDF333hUBXuhCPpIgYgUbufKiEbOphujpN67ErlccWeG9E3VI1D86sZFQqMMiia10Dq6Eq9dhrifZ3kPtYa8f15erzKV1NhPaJMu0ewLN1jymJDtoX4MiXdxwtoxuaM1oek1UrN0XaGiRMxm/jnkeLX2yCVgQTrd1u/LYgehiGKfm3t/BMBrxUQnc+tzxCSJNZp4Day3+9+NZVbXJn0SmuVBrqqLjxuhCP2+7g70bR0Vc/kiaLQOhqEvEfCGhJ/hsiqQjfFOljfwS2FU2iRRp/uhnoiq3s+h8m6LYhsBMmeQTlN/vBuSb7EjVl1tDY/cKn2durbjnoMs=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(13003099007)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	bn30W4x6va0A01kfx8WKiremOifAFWY2oqBqmAAFOzScEx4eGuYWyhbgpexdwtAynecX8fCuqNKaNZR8bCias7MnNDEtHRzHzn8/eRtuHD6dJNo4CQbIWz1weRv49IhYp6gutcqOiNZk5dBwujKO+I0OuoujsWT8BoNErip6FIWIQPrZc+qjMm2uHCZJCOYnF/Itd2jWzCZUl8fthnke7Er8LTuno7HaPfu+l/bh7QVbOv3bucT3Bnaec8f6VJsJTaV8MeVd2nFTYoM0m/hTyud1Bf1sQZ+Ij+GbUcNlg13gvj8MJqwCzBvAGbEVUiI7zKFXznNceUlhlBx5bIJO8iCC0zQH1DlFCjDXf1zcYNSkDHl4fgfI++yVFb/HKYGNrNRHQ98ac+IYIowf1UiNbHxGEHapL7CoiVyqC3kh4pTgjU/2FLZ+z7UCWGZaYQxM
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:24:18.1636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b833e51-224c-4a4d-5949-08ded82412fd
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14409
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23391

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
v1->v2
- No change
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index 5cf67649b8555..25176f5df9667 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -209,6 +209,12 @@ static void rzt2h_pinctrl_set_pfc_mode(struct rzt2h_pi=
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
@@ -218,7 +224,6 @@ static void rzt2h_pinctrl_set_pfc_mode(struct rzt2h_pin=
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


