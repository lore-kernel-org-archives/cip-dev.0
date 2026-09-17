Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375CC982D2
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:20 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35090.1789636454791728542
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YnXFZAhO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.53, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rsl/SCVnQ2Ai9bIofVK48oAvp8QGLWQWtv5xWXdtbOi60iP+4ebinrv56ZP+H7I+v33Ss12mSvK/ZFQxSpel2yY+WHRGaJG4mn1DKXt/GSOSu44dR9AWWsS61erVedeJgGVwNYQCSMbfuJR8S+fK9zL3i/VeCQHlDxutuaVA1VN8mZvObrsmL1IaxGnFtzWAg4lvyPidwE6E7rMdtrPlmt2Kshz+ANFE+48dDZBj6hGENGsJF9WKBaB6iyX3W8c3gmv9RQGFHnCVQMeUdP0OjbNRJ71mNZRedfe3Q6PtpqUMtfo7bD+MG6YLW9mAchyUEZIAz7iPLc3XtCVf+D6muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bUby7XM/VxIeM6UDTFltynJA6gFnK5393fJi3Ym29Y=;
 b=M5mcCQsmLOwp8+mIeiKlZn0Xr2CRc5/4mhZJ5koWEhEk5yHfyBPC3dbmjF54LL8ulNkVrpF+VD7X1pjM/S/o+C3m6t0+po6mIrnbO54plnly4RBPaIAVdo0xNr31bXi+n48PUbOUSZeC3kr10xwi+RRR/EGgDNEexu0QxQ4yJe2+/IolTqxlfXaMBDHo5DdQ7BmveA7Kv/X4PjQMuFuna9NoIkIqshv+9UqEbRQUpjSGc8pArYUlhXZps6/DA6IAzKH/azhFeO1F2qXKy7kJznFG6Pga86+94RiSJVSqyuurj2q9WxSBx2Sx5+RnTAgbfd/abdRNHYAyEiojyJmX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bUby7XM/VxIeM6UDTFltynJA6gFnK5393fJi3Ym29Y=;
 b=YnXFZAhOvamwAdHzhSgJ8rVhEg00ComrNmb/zGWav5y0bhb26tpr/SwRa7QZEIXgrk3YPeEjSHCI5zligzLxHIqwLN3/c6LWbDYsqjCX1YVueC2z2y9HA6gpvzmOwnjut6GEs5zG/dlbOHQxrTLsJJp4MJvQ80sFsLRL5aA9bIs=
Received: from TYCP286CA0180.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c6::13)
 by TY4PR01MB16984.jpnprd01.prod.outlook.com (2603:1096:405:337::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:14:09 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6:cafe::8a) by TYCP286CA0180.outlook.office365.com
 (2603:1096:400:3c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:09 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 110E430001E3;
	Thu, 17 Sep 2026 18:14:07 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/10] rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle documentation
Date: Thu, 17 Sep 2026 10:13:53 +0100
Message-ID: <20260917091359.18445-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TY4PR01MB16984:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0f8431e1-fec2-4520-6022-08df149c082a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	CZFYJ7bPEMV7jn1Jqg98yTvW5lKRMZwe86C1QHz38pMjqVpxDnWaigx82yklZ5roK60hK3+fvdkQOjPYRoeFDpF14DlA3gs9or+RlH15Z3wRMEAUOOqAA7Vxcerj1IoOVhFRzV0Izqmxi53gFByMZSsGSRpt0nyri4Y5iHfp7DhGa1D6IFN6aByUZK65A/6U3sW5vZpmmtBL98etFlezHNH24FkjTlLWXm93C4+OgeE1O7Xi7wEfXdTO64tWkLtRJMblBWBi4YKCbU0NbVvPESPnkiZEtF1qxLHiOucOsOB0Ws20pwjOxJgMab/08npJAwHcSuI5KPLy2I9aNwT+dSy/QfaZQYwPKHO8Z7er2jrNJ6CohI2khKeJdegIfFoOb18+SPMakyoT+OXRUjXGV/Qep4+9kQtWz5iiPylfNLBQ7vXcQhAYZP38kNG2h/YWyKjykTGyP/okN15y4aXKvY6A4woBrrXF1TsXm/a0UdLhV1HraJSYDiglcbOZrqORqq0c834dhxQIan7sx/Uh7msH6A0AzsD/t/UOFdo1AQzOS1ru5BiG8tLOTHkmganPoA3HFLJAOTYeH9HSGtNcAYSZ9IZzcobpogCfmHJoNnfSTN26zol/EoyJj9zss8BzBFEa6fCh6MDnWlzte8h+bg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	2NRfOcZmjoR+Dt37bwJQuBQkFC60+0oBzZrkq3s0+PssOAs0ZXNfUckbNASEfSiceHNlXVnxAyzfuYaGKLiaI/vKEsaQaIUzbusIFioMug2AxVL9ffg83VKnwZbiMT3KXHSKGpTw76BRXlqa17q2qx2n1WVGCL6LwamDiw4+9q0HE7q5DoD+RN4PXdtw0ObfzemaBqeMOxZTpecvdICY0VIWaBJqrkWjup0vX+IX9m0pNjFGbc5HA8W6zEA5L2YKDgWthWiXXD7cT/w6PTeyfnLvI0Lr7RbIlknuAzr8ArO0iYWVF0hIKCNELSq4zY8ZI1nXTDhLjlhSsB5+1j/naTsZeBMa2GskaFSw9a1s+n2DAyz6j5SNbSpZu1mwY4KMeUQ8H4X0tiUXzA3ZVoKaIwKhqVzG0IHYX/lpI/x/OtPdhx0LXg4olBjQaIk7kioU
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:09.3839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8431e1-fec2-4520-6022-08df149c082a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB16984
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24201

commit 9fb12656a7a5473b1ce46e27f78e92e5e8df7c58 upstream.

Correct a typo in the kernel-doc comment for struct
rtca3_ppb_per_cycle by fixing "adjutment" to "adjustment".

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://patch.msgid.link/20260602192559.1791344-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca=
3.c
index c1e07eaa4c4fc..9ce28af388c96 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -103,7 +103,7 @@ enum rtca3_alrm_set_step {
=20
 /**
  * struct rtca3_ppb_per_cycle - PPB per cycle
- * @ten_sec: PPB per cycle in 10 seconds adjutment mode
+ * @ten_sec: PPB per cycle in 10 seconds adjustment mode
  * @sixty_sec: PPB per cycle in 60 seconds adjustment mode
  */
 struct rtca3_ppb_per_cycle {
--=20
2.43.0


