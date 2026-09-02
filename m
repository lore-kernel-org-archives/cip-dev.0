Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B48C624D6
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:31 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8522.1788341067002929071
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=ps7/jDtF;
 spf=pass (domain: renesas.com, ip: 40.107.74.69, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NL9wnxTnW39TPAHW1NMF/cApwYIrN/RsMlxwqyiAP+u+jTtDQ0mlaIuZ49xO9eJgucs4BWVJc4HhIWZk3vttlgDj/StSHyCrSzGe43EVcb9EP/WLF/mGMETormwMUxiCNTtBigSWCalFBIyNVBuwOooH1BEh4dJPIjU8x2tPe6euAh86t0zXQvQ9setvscAQ0tzyG5M7Qi+Lh73UC6pUeriJteKuQjWJHbhvkhHjBYUBF5Yn+3zpl1cP8iixDd40STciwiJd4N7Wiw9WlvKEVMq1sppsHmqRZSEJHEVEN7dmN8Rb2dW/r6vUinL5Nn/eteKRwsFgfNH6FkULck9NCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTYbRWF1H3DJh+chhIxA3qgwhbF/J8HiTv7Q8LjGGfU=;
 b=bbhjKUHSu0SjYdJyGBJRdAuh7xt1aI4y5j0LntbB//9o0dv0/D5qoHJEIWLR3E8FewL14bvRZfsy1lecaOvnLsJvYwjtjl7b9NoTBY71MvItx42RoL+EXiYcnxykRRWYNF41pZJVvbwLeFgGwJbB89YFp61xhXoQ/0E+IYYoIqp2DLdQmaxlXZAHPbFAykT3Qms7yz6cj8TJ7AtQ+ITWEfun2OufB70ke9TWWVzcSls+rz+uNlHWsT4TtXkKzC7gz9NsiAJ1/55nb91hd3OKDwOJVSoVWS0g+A/xCjANx8RaQjhvrYz9Sckr/nERl/T2UW9uQxc5eUyVHFPzppGwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTYbRWF1H3DJh+chhIxA3qgwhbF/J8HiTv7Q8LjGGfU=;
 b=ps7/jDtFcMocl9Nrx8lENDIQgKh/DYnVieAzJTw2jhOgxf/+hj5gwGfoUdmriFIsUb56u6zipKuZN4Z4nwk0G/p4HcyBcaZtVMor+UPEthZiggCRikofxPiajT985Mj68xnHS+TDzVuCxRDlZBRXj+TZVZVFOuUqoSxnY/PSrzA=
Received: from TY4P286CA0011.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:26d::11)
 by OSZPR01MB6846.jpnprd01.prod.outlook.com (2603:1096:604:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:24:23 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d:cafe::12) by TY4P286CA0011.outlook.office365.com
 (2603:1096:405:26d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:23 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 05AF6300034C;
	Wed,  2 Sep 2026 18:24:21 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 10/11] irqchip/renesas-rzv2h: Kill swint_names[]
Date: Wed,  2 Sep 2026 09:23:51 +0000
Message-ID: <20260902092353.24648-11-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|OSZPR01MB6846:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e78603cd-8341-41ef-ab90-08df08d3f9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|11063799006|10067099003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	7Kd1AdeHspiuADfSyj8cKXVMJeb2WWe7uZQUBi+ApwI5uVMlJeozDgVr/UyrIqxCi3x9JJdb60vusubCDemyWtKSKdCa22y41wSqzUsRX5M/UpC8MRG1Hv234Wj36xgoZeyK9CP5uBB+bAeIqRWY/NJfXU0SPVQ/xPhmHOShgGS8pPUjeXAT3cMDWSbEZikcxNYYHuhAu/oH9xG8/6kZNT3/rZRHB/m/kKZK2TUn5u5TiSpzNPqHnVk8sWRlUW/yKNCXq+lCZ1wxKoaQqf/t153yVOLp+T4nY8rCbne8TXrjy1EaI4peyoAVbgjb0MnxiuHwNSUThjGgCUpL/Lvsu/S9ia/lIvnu2SlqguNo0XAN18Giext+kW1DtqIur1qu+hyQTr9264DUIg/bYmdth4lPb6gD2uSWp2uutbJrRa6cZTPunpXcUGlplV7mxyeg4HXBwDPx9Sdd/faFj+i/c/MHOZOwAR6ybE2LohVdYbHtJ8VoaVakzJf9ehxLdWBq9/IEYYvzxH5XI8Fn3AWvCEEMFwrevX0JxnXsl59FFge1fdX0O0fU9sw4u50/iC21Ex7xj1fXTcQaI4tuTafCem2qGoJcbp8G4ZFIR25eFDFZ7a/BfULJLd7OHXZGLi9wUC4mLK4BEhJaaGk1rHfs1w==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(11063799006)(10067099003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	+U96YVywr2VL37NBOfuWAUBhHQ0/cWKLUjsLWyDkZaM/MfIH8RzO5ZaUbwPrayB3oY7jVkNywbt4yWNed4NCjJzJiPDbpCvgp54QYOq0eaxmuDAxoqvLXoNNFNA7qnuZsf5F5vhVSKK5fjgPZBWcGxGSzBxpaPHOiRNUfrpeOp/zkDKMfBZaipgVX8NHF5zZzD0KknFcgAc+oIvtDmknvjfZ/2yCLG/DY0LVnD6K+6gIsTs0vNF9bXiOsk3CMm3fKVE/qfPQTXkO6oyhv9BdVeAwNTchf5HG0CxL6F89R1Xke6iigR1kH2PONSLGEUUjTLuQWZMvlxH0nW0/un1UAbCKzBUXQ9+JEEz3AUKFs+zpl1EC2Csd5A/vTRgpDG+JZ8NM5xkYrc0PEU5XDWguI6sLoONM+9cUvCtHZfA4zY4+t/rzYnK10SMpkyoFQKJR
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:23.1924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e78603cd-8341-41ef-ab90-08df08d3f9d3
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6846
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24063

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8c7ffedff0db88837de11cfaf3e5367e0b77bc4c upstream.

The array swint_names[] just contains expansions of "int-ca55-%u".
Replace it by formatting the strings where needed, to improve
readability.

Despite the two error messages can no longer be shared with the ICU
error cases, this reduces generated code size by 56 bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/aceab3fbc307ef428dfd62d8d846b68704dea012.177=
5205874.git.geert+renesas@glider.be
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 6c1b17e1ed69..e5e1982b2c15 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -758,10 +758,6 @@ static int rzv2h_icu_setup_irqs(struct platform_device=
 *pdev, struct irq_domain
 {
 	const struct rzv2h_hw_info *hw_info =3D rzv2h_icu_data->info;
 	bool irq_inject =3D IS_ENABLED(CONFIG_GENERIC_IRQ_INJECTION);
-	static const char * const rzv2h_swint_names[] =3D {
-		"int-ca55-0", "int-ca55-1",
-		"int-ca55-2", "int-ca55-3",
-	};
 	static const char *icu_err =3D "icu-error-ca55";
 	void __iomem *base =3D rzv2h_icu_data->base;
 	struct device *dev =3D &pdev->dev;
@@ -777,16 +773,14 @@ static int rzv2h_icu_setup_irqs(struct platform_devic=
e *pdev, struct irq_domain
=20
 		virq =3D irq_create_fwspec_mapping(&fwspec);
 		if (!virq) {
-			return dev_err_probe(dev, -EINVAL, "failed to create IRQ mapping for %s=
\n",
-					     rzv2h_swint_names[i]);
+			return dev_err_probe(dev, -EINVAL,
+					     "failed to create int-ca55-%u IRQ mapping\n", i);
 		}
=20
 		ret =3D devm_request_irq(dev, virq, rzv2h_icu_swint_irq, 0, dev_name(dev=
),
 				       (void *)(uintptr_t)i);
-		if (ret) {
-			return dev_err_probe(dev, ret, "Failed to request %s IRQ\n",
-					     rzv2h_swint_names[i]);
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request int-ca55-%u IRQ\n", i=
);
 	}
=20
 	/* Unmask and clear all IP/CA55 error interrupts */
--=20
2.34.1


