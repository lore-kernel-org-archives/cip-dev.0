Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6EBCA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:44 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.12])
 by mx.groups.io with SMTP id smtpd.web10.1103.1755706180703552753
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=L+JjYJSn;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.12, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjxzEGlEQm9AgDTw7/SC+8ntdlUsH7GP7qB1AoaStOJZZ8nYBlU2bfBa8CMLNiYi/fzoT+XSd5ttkgkXqfl28TeP2n9ASya2TLKRNYWD8o8QK/+TGePpPlPa9OD70OreETSpePb4AH7/QdXWoL2K1uYnt9PMkwi4I6cD/1CUhMbTTufYQXq0e2b6XzSQiSYVemZGLVGBjVsdOtj381ovLCGQoGKCwfm9/D66rxrPIkq6ntNS6Hjt6xFj9H5eiX+8DyQ/YNPVfYA0NEu6CaJFw+SyJHR4XpOOOpe7jcqNnevnyone7+Up1ZxTNWUOTi4QKK/CZ0cE4aynOTTEEPK39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or+AaY97yA+3f++gNp8jUHclydrRCymjBcyydChLdXA=;
 b=QZpHZ6KVQSDEU629n2Iebm6dmjaKHyDHMmc2XQKPdE0UKBcezrpVAB2Es04niLHEsoAWDznB2OET1UcYo8qEPNIqXsWzIGHpRmouCbddPJj+fpsrlWbn9yw8kab2Aocxgckp0bh9fzjjCqzpAJQEpWazjso22lMMmIpZoPo/WhFIO+M3xoGjyInYNRTCIf3EbPnGvck3gCcJgyZdBDL/vQwO8X6Z3Zwt99sq10Kz9wL5BAs6Bjjo2sVLcXGuze0xSPYA2d8a2t/McxtEL8K1UwOB9D8jYRCc9WZmcjr5EXmbWaHz7qd8eByTW/WbFr914Kt8sr0RfaGAjivhgS/lMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or+AaY97yA+3f++gNp8jUHclydrRCymjBcyydChLdXA=;
 b=L+JjYJSnPjo9rFoZxhTBcjmZo2JB9hPXP1Cxc1o6E6cA6d7zfT77NjNTmevGifSCoSNnR1qMNTg8O8FoY9kV0PeZ1ctSLcNlVplNLIYd1mH0WWZev/U7MqMG/kAGInAe/oQ1i/DeN5lMr0GyDLCYYVxOqEdvV6uNSxhLlsKW2lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:38 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 30/55] media: rzg2l-cru: csi2: Use local variable for struct device in rzg2l_csi2_probe()
Date: Wed, 20 Aug 2025 18:07:31 +0200
Message-ID: <20250820160758.801813-31-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: a7573a01-c4c7-4a9e-ef6a-08dde003f6b3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jZCAkyuJbtluhWac3x9Wm8bwrG3yuhUgkzzJCz75qOOMInERuZuh1SfjK7Fz?=
 =?us-ascii?Q?J0fDLfXFKG2vAPJX53G4DQs3Jy0O4pKAxhA9eWfwTa5eDInPe1E0FOWZGJ+9?=
 =?us-ascii?Q?H0vWQVO4bmt6MKy7P6FaF9/i9zE2Rz70FAWvTS0AoL8Wlvv2LLDk5fLX0meF?=
 =?us-ascii?Q?jixUT3tbLohVN9Bk+as1U4TVvEaT4xzuPKqJClZMcLeqP3GHljRGnZdQ02R9?=
 =?us-ascii?Q?kI67IMWpHMnY/xc9Il0j+6dXv8Bj36U1OopnvcbaM1wEvgK8ATQDzuRgd6iC?=
 =?us-ascii?Q?VdcWHy04FuZD3zV5ei20LLhica6qCQTZljVZ+6sL0jW0RTu9g2WDRIztytv7?=
 =?us-ascii?Q?jQ5E03G1BOYgrhUoGvZ7wgVvpxwJLXkjElQ4P25jW/fY10UMNJdV/znlHqwi?=
 =?us-ascii?Q?iOhK5pchwjtu3qD8FQb2k4TyfGDi+KzcHr/fb+VYwd1pmBwOR/T/DBIEjtOl?=
 =?us-ascii?Q?tovbWIqlKgmYBzu/IlN6byStrDsCXCd+9EdVysRQPoNapiGhRPRwFzfW5y3y?=
 =?us-ascii?Q?Blc1Voo0yabPeYN24dyQapUBq5XRAb/Aj3tRGJP4CJ6wU8KMaOgTPWYHk/2y?=
 =?us-ascii?Q?MB01EeuOZeahSQClJFp13f3S3+OsK3ljfRiZ4XTEf+EwkKmTJn5hnApbdxnk?=
 =?us-ascii?Q?5haFKnUND9O59jt20OrZ8lMP8o8i+3Tq9HinJsSPKNhsXttms+BoD2Apt9lj?=
 =?us-ascii?Q?2SYBlUsRMi+6FbWEEDkmL0tpXPz8Cma1MCgN2SRku6/uMBm084O0oYdy/4TX?=
 =?us-ascii?Q?BoD7mMqPTs+hIGnPxt7lDnkj+EbpxKGj+wThiqknDRLtTUpN8/pXMoDMcNRB?=
 =?us-ascii?Q?e4BvbSYGWP0rZgXVoZhpwBgBqfuGrP4fs/AhczzszFaUcJG5AzNrefLkW5xj?=
 =?us-ascii?Q?900XIpZEfvpp9JoIlh6PUS8CM5+MPWmDTHZ3d/35GXdV1H0Rgh/isUPzQrKm?=
 =?us-ascii?Q?q/QlZ5ZfqBgF1IRisusPfc5k9zQ8zBLox50A9dgmVTUQkLREp22ZT2bIzetE?=
 =?us-ascii?Q?nzjBEa+Jg8M3Kq+lTUCtBTnkVeaJ/xGfc/AHAHBtBKykzw2m6IA72VX8PctJ?=
 =?us-ascii?Q?uEFMdWxWqpbisXMnVPtKN1mbMuH9IAuMMNcHIuI7quDauIzVej/p+fBWNU2n?=
 =?us-ascii?Q?3lKYKuysrLjQw8GH/xRowxYwvSzqCISXjKmECibisH5rlKpXwCLa4KXegX+k?=
 =?us-ascii?Q?YRHAH5ZuXsf0MhUQ5zQZKMr3p5CCANcimhkx9eDDsA13aLTgl9Z13EHdzOHz?=
 =?us-ascii?Q?J43uMCnQznv1QpeKRp105pu7XxDAyHLc0gFzC0LJJZH2EgBEZMHcZQbuGWVM?=
 =?us-ascii?Q?vijYDb+bQ3vWS0zyX5GCBWUq72FZAK47XGzR1sHNtgOAOJXMLFQ7Z7rUpvCB?=
 =?us-ascii?Q?Y31VgTagAKlRu7erAwNLCm6EQUJ6vHL8f35NF5I2prRLXKtLuwHnZsQzBvW+?=
 =?us-ascii?Q?a4H1D88MIM5vBhGUQtyAHqVJXbUMKOHOetaVUBMg7dCHPleeSET/7YGowqn7?=
 =?us-ascii?Q?/2z1ijK/HioJiDg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PB2H/e8pwF6vUWyMX9Dzk9mL7DD8vtm5+NjvhO+cVudBPuqggRPMG4eNmHhE?=
 =?us-ascii?Q?GuPn98gRVf1RnkgqsnbzS6b//Qyj9PwBsIKnx1w/rj1iWEHWxWnppJdII00S?=
 =?us-ascii?Q?pnYZxJp+x8goyhlkwCgHqiuN1V2yJgtQz8JHaV2A4lyWhV7ai9tvX4ezwzNV?=
 =?us-ascii?Q?+YRYzyUfrCojKom11Ka8WuGpQQzMt482vVXE6rRXyidf1X8h/QRP/hV39S4z?=
 =?us-ascii?Q?Si0QuhOUs+eMGEZeQ7x/hAZVnWy6A3AcLamdK/aIM7JbC/HYhgx6/2pZ8m/F?=
 =?us-ascii?Q?uflXFLR3EYvkyy+jL5Zlmw1ijMEashi/jnSgEadKQ5Mmu8sllqrfd5WjrS1H?=
 =?us-ascii?Q?3wJiFWHnM20TmiWDI9YGoYH0CS/qiFeBXqE6rWVmEwHdVoSwTdV9QTa64nYJ?=
 =?us-ascii?Q?amvn+Za776t51dU1LBoAw5LDejRPxjdrmChpXIRqSiCJWtkGD0nsKmGGi+KE?=
 =?us-ascii?Q?cKaApuh3d//rBVMO7wIznH75hbaxDRcxGvS7vYHjyVGCArAmQCmi/1BnPth1?=
 =?us-ascii?Q?BaAs/DzvoMVeENJv5OVvDZ6XyQFVa6Aohjxy8BxIvRd1l9pJwgxdnf+a2TgF?=
 =?us-ascii?Q?m6m/nho6D0AQEIj1bPNJjbBcSDCOqLRvx21hj13p2eR2uvnHRcHiG8IXc6zk?=
 =?us-ascii?Q?UlrZcKGD2wEONUWRBay9EnffwD5c4VcCufcgrzid+FNYbw/NAwb6PFUOCHu5?=
 =?us-ascii?Q?YCx03qRYSacO4q7zYM7/rv9cqRh3kWnfiO+6P5OJz+czYOd9GGV/JeupHQnp?=
 =?us-ascii?Q?Bzdaz3mXonpgEC7vSqfJ1ncmPVGA46pCRQDmqka1sLPaPvoR1iGWtPkJebrT?=
 =?us-ascii?Q?PlOyZaNTkg08jZPx/ooAHOLmZQdjnhWcVGdlOrFMVSOdq5yD8L/BEifW/jzh?=
 =?us-ascii?Q?Yd4QWg6t9vY4r2VAdZ4bpgHQWIAYiwATclLnGERRxqXwtPtqloLVEiBJpABu?=
 =?us-ascii?Q?b/7kF/JInQhMTgjy/X3c2/5OrOSNlPklg7XJr+jn0oe0GjRQZTLFrcO6Rsce?=
 =?us-ascii?Q?nPlR7r7Vl8nus9RoYyuE5DZ4dWf0ZKEn4PcYi9Uszgb8iiCiEy16kSIC9t06?=
 =?us-ascii?Q?W6ls+vPLuWbFO4/jqOeWOpF1DkueBS/1Hn7xlUfn7FeCXIVltucXH765x1po?=
 =?us-ascii?Q?FEgprAiuu/QR2UTYfGF3idEnTqHnk5J2GEBe8WkhMqjP+ealYdaLNFhHd9C+?=
 =?us-ascii?Q?0hDs7D/Kvsdp6x2WAlvRmoe8sLor7yfP1moAStxYkVChq4G/X8hadfTxgZ8W?=
 =?us-ascii?Q?fuGAojsG0ei96w7WH0apDJxD2y7hrFoyKQ3fJE+IU8Rq5TD1bxkQ9HSC2qTa?=
 =?us-ascii?Q?yY6fjG8hKYgyG28nExKKarfZp9biMpFsSk/4kOUGQpjDjk+U7OU7tSMzW3C/?=
 =?us-ascii?Q?L/1Mjy5CmZNI0m/d1Hb6lNi/UvHaItm29EV3zQ7VB8wDTdENePN5AMdnROvI?=
 =?us-ascii?Q?iEdKPXMwrXmBwfwJrFkd4FffuJEaD3Dgoa9uPkrLkeY4l2vdVPkOLd5zgxf5?=
 =?us-ascii?Q?SUMRwb7XfcM+/gtouUo+M1sGFZAsNs2jFN/pexho1BA5ngSqkooKyqoVY5+Y?=
 =?us-ascii?Q?cQH0BKD1Y+TyXFqGWAVSRJ//zG8+GjEpKzEc4WWGN8tS0dRrJEr/TzFIcFdR?=
 =?us-ascii?Q?a8iasUbTbQXLG2qJAfyhXZ0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7573a01-c4c7-4a9e-ef6a-08dde003f6b3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:38.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GepqQfBQtrQ2AqHkzT72Y9Ow3Q29piyORybTzKhNOENI1+8GN6UMU2KMzdWKgeup45ZO41bOP7RH+KUV9n9/JqQ7kYecqasNP5WtrnjNptVwVtBXC0fbljP4OMkLhnFk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19911

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7c537ccfe8982b186a6becc646872cde6061c8a6 upstream.

Use a local variable for the struct device pointers. This increases code
readability with shortened lines.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-5-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 84230926875a..7f75db9917cf 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -764,10 +764,11 @@ static const struct media_entity_operations rzg2l_csi=
2_entity_ops =3D {
=20
 static int rzg2l_csi2_probe(struct platform_device *pdev)
 {
+	struct device *dev =3D &pdev->dev;
 	struct rzg2l_csi2 *csi2;
 	int ret;
=20
-	csi2 =3D devm_kzalloc(&pdev->dev, sizeof(*csi2), GFP_KERNEL);
+	csi2 =3D devm_kzalloc(dev, sizeof(*csi2), GFP_KERNEL);
 	if (!csi2)
 		return -ENOMEM;
=20
@@ -775,28 +776,28 @@ static int rzg2l_csi2_probe(struct platform_device *p=
dev)
 	if (IS_ERR(csi2->base))
 		return PTR_ERR(csi2->base);
=20
-	csi2->cmn_rstb =3D devm_reset_control_get_exclusive(&pdev->dev, "cmn-rstb=
");
+	csi2->cmn_rstb =3D devm_reset_control_get_exclusive(dev, "cmn-rstb");
 	if (IS_ERR(csi2->cmn_rstb))
-		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->cmn_rstb),
+		return dev_err_probe(dev, PTR_ERR(csi2->cmn_rstb),
 				     "Failed to get cpg cmn-rstb\n");
=20
-	csi2->presetn =3D devm_reset_control_get_shared(&pdev->dev, "presetn");
+	csi2->presetn =3D devm_reset_control_get_shared(dev, "presetn");
 	if (IS_ERR(csi2->presetn))
-		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->presetn),
+		return dev_err_probe(dev, PTR_ERR(csi2->presetn),
 				     "Failed to get cpg presetn\n");
=20
-	csi2->sysclk =3D devm_clk_get(&pdev->dev, "system");
+	csi2->sysclk =3D devm_clk_get(dev, "system");
 	if (IS_ERR(csi2->sysclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->sysclk),
+		return dev_err_probe(dev, PTR_ERR(csi2->sysclk),
 				     "Failed to get system clk\n");
=20
-	csi2->vclk =3D devm_clk_get(&pdev->dev, "video");
+	csi2->vclk =3D devm_clk_get(dev, "video");
 	if (IS_ERR(csi2->vclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->vclk),
+		return dev_err_probe(dev, PTR_ERR(csi2->vclk),
 				     "Failed to get video clock\n");
 	csi2->vclk_rate =3D clk_get_rate(csi2->vclk);
=20
-	csi2->dev =3D &pdev->dev;
+	csi2->dev =3D dev;
=20
 	platform_set_drvdata(pdev, csi2);
=20
@@ -804,18 +805,18 @@ static int rzg2l_csi2_probe(struct platform_device *p=
dev)
 	if (ret)
 		return ret;
=20
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
=20
 	ret =3D rzg2l_validate_csi2_lanes(csi2);
 	if (ret)
 		goto error_pm;
=20
-	csi2->subdev.dev =3D &pdev->dev;
+	csi2->subdev.dev =3D dev;
 	v4l2_subdev_init(&csi2->subdev, &rzg2l_csi2_subdev_ops);
 	csi2->subdev.internal_ops =3D &rzg2l_csi2_internal_ops;
-	v4l2_set_subdevdata(&csi2->subdev, &pdev->dev);
+	v4l2_set_subdevdata(&csi2->subdev, dev);
 	snprintf(csi2->subdev.name, sizeof(csi2->subdev.name),
-		 "csi-%s", dev_name(&pdev->dev));
+		 "csi-%s", dev_name(dev));
 	csi2->subdev.flags =3D V4L2_SUBDEV_FL_HAS_DEVNODE;
=20
 	csi2->subdev.entity.function =3D MEDIA_ENT_F_VID_IF_BRIDGE;
@@ -852,7 +853,7 @@ static int rzg2l_csi2_probe(struct platform_device *pde=
v)
 	v4l2_async_nf_cleanup(&csi2->notifier);
 	media_entity_cleanup(&csi2->subdev.entity);
 error_pm:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
=20
 	return ret;
 }
--=20
2.43.0


