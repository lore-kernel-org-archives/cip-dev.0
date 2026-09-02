Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E40FC61DFD
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8273.1788341056252708715
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=M9MbmHSJ;
 spf=pass (domain: renesas.com, ip: 52.101.229.15, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=be6rvOPvLLRUdlpCmTqVah7G6ClKOidWloJ3CcF+mZwC4iijK5Mu1xaDzI54rXqkFuJxyD4k8ZNVYY+vqeOcSOy2Z3+0t8P3HO+mPrRHPR0J7z7Rlio0p1rFgK49ixHes1P+ImznkYlyWR1XwGuWxxgqWndOEymFOtN1ZybTKLCWyPBHLYVOu0mpu3b7Qolbn2XauYYIWefAwY1U8Ch1FxHfA69yhJVg9X3xg50eN+CdtFh/JXGw3SFisnN4BgmICGJgPpxT6lyV1xnnOVcjg9bOQ/EAnLfzNJjpMLa+e+dtuIOFlLvUzQwJ8xk6S+e3igmRQK8fPpctPBqKb4sj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syR4ktP8LZ1mk69mjfhlfNWNlgfHjodF9Pwn6rQnX7g=;
 b=mbjJ8isFh5mBUt7o1ruVGrZSudWCdPyiU5xfX8Elznqkq2K7P6V7vBI1Z+uJrn59pR5JE49VXUDMK0VpC2OJ8dUaCPiHf9ymSouEkZOauvq+zBIgQlv8/5ZUxEM//nhGwzSs2EBE6peUfpKG5n1sbOZYoq3GokX3hD3B0ghoMXULQb3vXo6OU8bn47mK4/u4B4LdDUDCRjQrRi/ZtJqrK+77iD+a6zjL+tbxdbv+E5IB387xZCiHNA0i3cVM1aJY6sOn1evBQTxGdtUbkQ1fWvmkIJmu+a5q8ltX9u4ldkNdQvpwyFfGPPAidkWtm+sw1efhpJ55Afi2MkChvgttYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syR4ktP8LZ1mk69mjfhlfNWNlgfHjodF9Pwn6rQnX7g=;
 b=M9MbmHSJTaJ3Nsp6cNfBVbtoOoTddfVK7GyaQTN/l6vDiulDN2iRuAUBTfUnZsET6fByzqM6QEM3j2uYl38YOvlfxn1odvIyAMjag+FdSGqcR1KViUciuTf0+hAlVUQuUzUy5jmQzdWW+29NuCOm+oG0s+TDZL5kIum2KUoNQkU=
Received: from TY4P301CA0111.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:37b::10)
 by TYYPR01MB12449.jpnprd01.prod.outlook.com (2603:1096:405:fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:24:10 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37b:cafe::d) by TY4P301CA0111.outlook.office365.com
 (2603:1096:405:37b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:10 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C90B2300035F;
	Wed,  2 Sep 2026 18:24:08 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 02/11] irqchip/renesas-rzv2h: Use local node pointer
Date: Wed,  2 Sep 2026 09:23:43 +0000
Message-ID: <20260902092353.24648-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|TYYPR01MB12449:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d5cff01-2593-4dba-3762-08df08d3f1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|11063799006|10067099003|18002099003|22082099003|13003099007|56012099006;
X-Microsoft-Antispam-Message-Info: 
	aOu30AGfJx+fkJtmdutjqu7B3AxL27PZiYiU0heTVYHthbrMQDjbBveC7m63Hna70l1YQ09mwi++MuLEzYUqjceTijzro+U5HxQd9pwQKm8j7mseKpOwrs7kDjGa0I4DZ8ZFqPAuVfvWLTyytDGrXT77VqEAdBwh+wGTRgpji7VyJ2XoWsJDIMLw3pjSvg1UNWsyk4p6dObTKmf2MtYNn8Su8YKkm500jZ9s8OYNtnC0nyJUDBLu3A4otMoxMXxozZ+4hh00NdNPUDxP7YDUdEH77BVqlFNG/fIrBgCDnEbJHFMfuxgskg4QrVW7TNdKKqtKk0rVl5uQuP3sJzJ8eNLuwwBIOiLGrD5e9NyifphZCJV50BPoAxafCuNNReKloLpVMmd5zCinCwwrRccbphZ7k5i+2jDydkRBbpJysvDnoOaJPhQYTcc+Cy8tv7wb6vfuj0slJ0CDjmdGnEuy/6xmIMt2AbFqXdQXbuaVREBPHkbFG8J5YkYKIobagysCvyyqnO5c1CBoHFBwn+dmd63sauv1zDI8+hCk3/AF3zwVmCMQHwqcsbsVQQ/RDO7W+1QWTQQOXi3TpGaYR+u9pVpEINFM3w0K8y9iAyCeA4FIrvj8mvQwZFpW7zBlZEr+FF1JV0Ajo3m3RKQRY0U6mfwM+29K+93V9yI/vOHpZIw=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(11063799006)(10067099003)(18002099003)(22082099003)(13003099007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Ev7FLbUmUHG2/9GiwBv+K9yXpGBXNaauJhKi8CON5CQj93WciN0muG8eiCZtwknZNT1Dk0h6Z5UBdSc04VDaCH6/chD9owu+1hwWM+QCtowh3mVM7kwOSZpvjQIo9K1bpv1e6CJGbdgJot+QggUOxCV4RIMh51HzM8skEjCTbirBxqmCkyL1MirqUbNigG5ACO2lVEUVixo8rinQ0dfL6aBCwr5I0cemvuwDw9nfTa0uktMZac2293qetNnV1ZiIJ+BHq90UF4O6J3EHRDEqJPQg6BYlTAz/2PON1wIEirR6cWMFhYgAkE4TdnI7ybobc2RfsL1HTnoe0biIe94EzXnBzMihJqhmW+Uj3iy17y2G/XZV+maxRTYp+QB1OTf5qM4QJGnBJ3/yBhOT11yLdDSUX88oXQV5A/5RDZw/yC0QykLFQPiK8FOhWmx/zW3F
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:10.0219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5cff01-2593-4dba-3762-08df08d3f1fa
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12449
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24057

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9fcd9ffe94da4a34a451e4cc0e3e007b4ed7f114 upstream.

Avoid dereferencing pdev->dev.of_node again in rzv2h_icu_probe_common().
Reuse the already available local node pointer when mapping the ICU
register space.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260304113317.129339-2-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 0a852b6c3f44..e599ac398237 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -582,7 +582,7 @@ static int rzv2h_icu_init_common(struct device_node *no=
de, struct device_node *p
=20
 	platform_set_drvdata(pdev, rzv2h_icu_data);
=20
-	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, =
NULL);
+	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, node, 0, NULL);
 	if (IS_ERR(rzv2h_icu_data->base))
 		return PTR_ERR(rzv2h_icu_data->base);
=20
--=20
2.34.1


