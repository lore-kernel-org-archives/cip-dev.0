Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1278FCD6E43
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:14:59 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24335.1779898497642034350
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:14:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ARTPne/o;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.22, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOxmCDEBtSJmTpKfDIHHxVeoAG4UWz080LxGKrIaMxOt8Hrd34TqLIABQEvqCdZXXDX8DHLHnrpG5SS+gKoMa9/x3W2VNTTCsQ1AOBu3jrLkzIKCtfXCSoxvuCbtJM5bYc7yHtn8lctof/lZp+DmtEQaZod4+7kHnOXyjCzZaR/fvpuSn8VhtkWKrS0SrE5cdve4iGxIpdhQ5oUUpuB/Xz5jO+xdCXPRt6BQmucsoDGBmmfR7RRd1IkwJm0uYqqjjmTV/bALNCj92bQGjx+OUkZAJK9J3pj0SoAif4ijIb9ofoS5OJUP+ymeMEjCnGDWVaPGSCPeillGDGPEPARPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG+E5rT8y2HGkWiATCD9oJaV82vki5j0QM1h4w8tzeI=;
 b=BcVq/UmSkdRLS9yxiHeSWqhuA6TT0eGP5AiIoNdc58WUwf+iClxd3M+HYLHuHOkXzBtN7cUCBn7NF0kPLwYWL4GwUR8ACNmvgjWKYE2BBpi7G/9baoQX/8PUmkW6oVRzS/6L3EK0+t9OuaONQGWoe8x3BOyPMMf2u8Ri9+heWpnG8J1ANWheJSXWtsfnWS++fSUhXR6cZpMeo3D0/X49pTe43NdEHhHcA0HBlRkMAU07DbZafboZer1J9fn4ci8ITFG8gs/x6rgBht4GhJsrKe8tTuayWPdDH60r5rKwGqmrfWnuydX6WEJ09G0AEusMy1BpixYZ3c9CKnc9As9tpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG+E5rT8y2HGkWiATCD9oJaV82vki5j0QM1h4w8tzeI=;
 b=ARTPne/ouhJmsNXUllo2WvsQb+CofkTHjZyi+/+BAUJP7/sBx0i84l+RVBZPpJfcI1dMWX8kEgPCYu7L8i0HCR5/CdI3PQOdiJqtjnj6reoGbhOiUyg370PzFYP1s6bQN46DLlvQZUWCaj0+NSoEPfPlLNo28tmSrrAPeuI3efk=
Received: from TY4P301CA0080.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36f::8)
 by TY4PR01MB13030.jpnprd01.prod.outlook.com (2603:1096:405:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 16:14:52 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36f:cafe::af) by TY4P301CA0080.outlook.office365.com
 (2603:1096:405:36f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:14:52 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id E5E53300025E;
	Thu, 28 May 2026 01:14:50 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/9] i2c: riic: Use dev_err_probe in probe and riic_init_hw functions
Date: Wed, 27 May 2026 17:14:36 +0100
Message-ID: <20260527161446.48789-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TY4PR01MB13030:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 00d9b435-9e38-4f22-34a1-08debc0b1565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	+UEYdNtY1Y8QjzUx99qq422OUtHH10UmQZ0VQIM7m3ZU25dVTSeCk4AReCyk6WxQzrv/jra/UwnMcihzTjnE4kW2smTtNgQsRv/uRDj60MDofkxwcXSEQQeMG6770QLLaJEKMKrohxtbmEzSUIGXtNXvu2t6UWga2LIOr8t47ubW0vKYJxcmeU1UjUB+5vN8yYnX8rgUlXYHLMiIOSXQnWTgRHSxHPQTgIHAVfVGRpLJBUCyx6da/GFrRI7QOkVjl0pruGSPqtvnJo5eC6yCXaKoHRkM/IMvWCPzdFbOKDd29fyICGEgUfULZBdP2qJ9m38cMJpJVOP2SZ37oAEKRc32ltF2G6dids+kyeTwCIxhRv37ieqOJd6572PcJiTHf2SIeT9PQ6I6Ul5rD6WPuaQduvDKkTGSC/1bdcYueQ5qNKgCKt1XAGz9fRfl17WluxVhRUv56REixbphQg0kJwTZ5VeCcIdXciumABShJWIcI3bgwcD433S4+6qQc3UWNisqgZqZyHGXc0uin88RZGFL6m7Um2MqJ+n5AUw1wYl4gOEZNGh7EwzQtaqRFJm0oquJr4ObtdDnzGUfKorQfSTWACDEVLv3Lphib9lf6ShGZK3042lNY2T/3aGgtjNEtOIhDGsHnx8GxtrfN3KtreDmOfwjUp79A+uBuIL5cPyIZu87zEBk5KI/HKi+8dEgD3lqwl7TvISOiKLRopyqzNhpfc5aEwiLGa8CmZJ1f8k=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	bovcAZYnp5IRppALJOR5Cj/txNQr50WjPX8E51STeGQpG0/oOCEikaGoKg79WUepf2fVr1C8L0HmxPdnp4IoZQ42yVykKFr2LWQNVE2I0al5RYl277I76TjQhTVzFHkAVKbyyxX4Eio95YUNisGc8YX50hnrB7nmRS2DEjgNdl9MaD77ieYkSQPF7lCvuCUMX+EpWDnkmjGk/Nr2r1K11istnC2pYDTc0BKBSnhTP4afzEmTlQ1kPvi23F3PatkKkNLCIIAF78gXqXgE0uXhrucYmcPiJpOsvthx3+6Ag8E4ZiZT/rDR64J0e/N+VEHwk2LvOljunZoVsF0HXWnS8NVRVpbuXXMeSkdIF/Zl1QaaGvT0SQvXiLRs9gmTt/sgqndmvbySIT0Ik6b8jD7hSBi+Irk88+FOB/YIRV6cbfRcdVIKJV/iArWgPnv5zG0z
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:14:52.2218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d9b435-9e38-4f22-34a1-08debc0b1565
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13030
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:14:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23017

commit e2aa2502e8067527e36dd7a3cad81b2004614a6c upstream.

Refactor error handling in the riic_i2c_probe() and riic_init_hw()
functions by replacing multiple dev_err() calls with dev_err_probe().

Additionally, update the riic_init_hw() function to use a local `dev`
pointer instead of `riic->adapter.dev` for dev_err_probe(), as the I2C
adapter is not initialized at this stage. Drop the cast to (unsigned long)
in the riic_init_hw() function when printing the bus frequency, and update
the error message to display the frequency in Hz, improving clarity.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index feab444495a4e..c4a85f8a5b874 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -357,11 +357,9 @@ static int riic_init_hw(struct riic_dev *riic)
 		rate /=3D 2;
 	}
=20
-	if (brl > (0x1F + 3)) {
-		dev_err(&riic->adapter.dev, "invalid speed (%lu). Too slow.\n",
-			(unsigned long)t->bus_freq_hz);
-		return -EINVAL;
-	}
+	if (brl > (0x1F + 3))
+		return dev_err_probe(dev, -EINVAL, "invalid speed (%uHz). Too slow.\n",
+				     t->bus_freq_hz);
=20
 	brh =3D total_ticks - brl;
=20
@@ -446,10 +444,9 @@ static int riic_i2c_probe(struct platform_device *pdev=
)
 		return PTR_ERR(riic->base);
=20
 	riic->clk =3D devm_clk_get(dev, NULL);
-	if (IS_ERR(riic->clk)) {
-		dev_err(dev, "missing controller clock");
-		return PTR_ERR(riic->clk);
-	}
+	if (IS_ERR(riic->clk))
+		return dev_err_probe(dev, PTR_ERR(riic->clk),
+				     "missing controller clock");
=20
 	riic->rstc =3D devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(riic->rstc))
@@ -473,10 +470,9 @@ static int riic_i2c_probe(struct platform_device *pdev=
)
=20
 		ret =3D devm_request_irq(dev, irq, riic_irqs[i].isr,
 				       0, riic_irqs[i].name, riic);
-		if (ret) {
-			dev_err(dev, "failed to request irq %s\n", riic_irqs[i].name);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to request irq %s\n",
+					     riic_irqs[i].name);
 	}
=20
 	riic->info =3D of_device_get_match_data(dev);
--=20
2.43.0


