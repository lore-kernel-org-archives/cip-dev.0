Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905C7C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:51 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.63])
 by mx.groups.io with SMTP id smtpd.web10.49103.1743418062781393708
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=sGbdqhD4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.63, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWvwzCQrUm4DUIp53kCUASpfPGxVs4xwRs0nD65daLr+ts8pJlhGxA8jWeBvZCEVnf6nr9yzX9aVmNqax6CBLsXaaL0Uzzw2x1nRUm/NkbJVxgNJ1wJ6q4oNLyYwiHGUELGngnV6ORr/2g36H0iE3tI2Bw7WfMbRpQmrarLaDejahisgiWQf1CvCJwJ2HGYMiQcnBThhPbDmXN1voxFvAMcNiJ3yl4kdARNn5SYTbEtz5hjC5ZK3X48K1Z94UcDEI3KcS2h6Z1IjKviGbHxRt8g3sbDDCgzRwh7IFyAIjXduqgBXkFP46Hr9ZvfmKYExf+McGVd1Ce0E+hqqRgi2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEALd6uSJ63zhlZhlF6MntZ5FEmXlNSK5KCQaAtKg2M=;
 b=lgT//tBc/Gfu9kc9huBqSaNcUpi+AgfMfn8DFjpTHXSkrvwuGYqXpqW2ipv8gtm9SfLwUiLVev9OpUr+822lOx4D1+Stw7VwdgcOlTEFLnTJm7bkClHgnM0V8RKHDw0U5hJFStaCzf8gqWXvcf6mQzp05t7SHxUsGrxYY0+debtiQhMkj65HUNhQltFzw5TNKACLD/M3H9ie4d8jEnqZxCkHoGpQTgElgLvnbTvtCsfl67RuFOf/PL3HWlG4L50E1erlUraeYncsiJ91b+5HFC5rIgdy2BgxPesqlZlAaU0wgurFZQUHXozh5CsN1C+b2PyzL61//DZ5pMyEdPDgGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEALd6uSJ63zhlZhlF6MntZ5FEmXlNSK5KCQaAtKg2M=;
 b=sGbdqhD4j8qaN1dUqv2F9yjTpcsmIIVPLCrKr87fZKTZ4eSRX7XeIbq/36QQ3BGD1X0D2E/QQ5eEQA3acJ+BSpeDZz4I9C7QTtsQlKXaC2Gm57zJjdh5ZfG5ZyKzQjBrt4dDHoSuyZaVtCY/ykq/QoXadVc52S1PJu2AgiExfxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB13299.jpnprd01.prod.outlook.com (2603:1096:604:34f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.31; Mon, 31 Mar
 2025 10:47:40 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:40 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 43/43] arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pincontrol
Date: Mon, 31 Mar 2025 12:45:14 +0200
Message-ID: <20250331104514.79090-44-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB13299:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb62cd2-d180-46e5-3e5a-08dd7041753e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uxQScpglp9Zhf8Ck3Q1Ry6b5MLlxK9A6xJgFtl3LFvglfxVIXpNUBDokZ/xY?=
 =?us-ascii?Q?hsSFj/y1wIDuDAMdrb8J/cXeRyRDl6D42xRvXzydwp7Xs9CyaFVHTn2TLVZ2?=
 =?us-ascii?Q?AZNMLNKhhIVanxdbfcTa+yUVVyJcfqX7TSio7T8gqCrB3/zMRODpFgvCR/sV?=
 =?us-ascii?Q?lQ9mGQkJKTDOo5bNWmfBCoejAgcKIkGg0bYGnZ1EwjOsmlw/vC6fBi5Ft920?=
 =?us-ascii?Q?OV5WorIJl/0DE+AEstLOjMXW51c/v7s6Hs3+9XItLmEFhFOjlgG0xzIIBxUw?=
 =?us-ascii?Q?HcA8idorHeeTV+4tpGdYp1fBrjsWWHmAtlE7zHZm/M8Gn1e8skpXsDzpI130?=
 =?us-ascii?Q?iX1usmbJ0hAIUHnrvOJI3tcxsiGKu2EYfR+nnbOAiHucTEYMsTFBrYjeMgNu?=
 =?us-ascii?Q?fa7SmZ4Lk707oJyv+S8LUhGqTFxmF+tYiiKNx5zGnZDYSU6YtJsuip00N9G+?=
 =?us-ascii?Q?uGW3YsvqW0vBMOVY31zpVyUA/eC8nSFqUU7OFnOgZ/kr8Rplueqow6WMuC04?=
 =?us-ascii?Q?4nQmCczChRdcRVX9L0N4EuQZpWPlKkaXkEcG3Nfh+WWf0IUZSXoqTOe0Qi2w?=
 =?us-ascii?Q?ueOcoosrmsiqnlBU+n7a8o6jSbJzhxNar8baLgPHKvC49SQpydBtTkFJhn+0?=
 =?us-ascii?Q?aQkuxnVAF11XWkMg11Ch8NVjTONkV2Y/4Fgee5ghcwEJvT8oopGivaVFr0PB?=
 =?us-ascii?Q?23+MJLThrDiepvks7uTfzI33XMCsa+JzvrCVqvJiYCh9ayHU8/sxH91vlX1+?=
 =?us-ascii?Q?PYZhNzgAw27hIHMAKksKWqAJaFqrFGuyflgqEuHLCQlw6Aojy9sFyJIGadPk?=
 =?us-ascii?Q?XxKYruB+ZtuO8O+nBjAugfXL9qquJEFMbnQ6ZhStlb2v8on8DgzP9rMHDRVS?=
 =?us-ascii?Q?saf5vF653hvs3B/bMpH3EJtoudimVqdS80xDehucGkPorad4D7gz/7rhM91H?=
 =?us-ascii?Q?Xs03QUj8uayHlAbP4TQmBTYolh0PdINysMTQFnQWOMJ4YfpFzFQ+bHJ79eNO?=
 =?us-ascii?Q?hUUmRnjp7XZ1kahfcM0n5OkS7NC78C0M5+hltFEzeRnTbG6zdFin8IKsPrM9?=
 =?us-ascii?Q?v8wQT697ZaQ2zuZRYzzVGekT2N/wUpWZGI14U34h5stB9ljJKjsZqJg4Xwe1?=
 =?us-ascii?Q?/JN6rp8GtHN/90iiUc/SIZjPDimX6ZiXUXGvK18BzMblxHLpopIQuzW9IfjY?=
 =?us-ascii?Q?3BMB65iRt5grbNYOQSwwOodFibWSbEfi3d4M/sPtxgjWwWBTw3GJVDBp2TOv?=
 =?us-ascii?Q?oafc2/AOTIH49zDoXZ2SWZX8IzkvD7WBUAsKiVJhCnmvNLu54HFnWJTGzexB?=
 =?us-ascii?Q?RHdGuIvjNejT0OU9cBEBRt/03e7QIzVQWtwkkfpUgqExXsKy2OUMLEW0d/NT?=
 =?us-ascii?Q?lMGPt8FZdrmvfuPzOaEvzdOLvqUGquE01us+KEJqrik6Do87ywQvijDkxDFY?=
 =?us-ascii?Q?JgeSolU6PgUiMto3zyGpTFvqR6rER8Ix?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+mJzLNZ82+By/l+4WaniY6mzkl6tvYg82iApPYwKtzLlN7xMbABO5daC3vCb?=
 =?us-ascii?Q?QwOF7VFyVZauC6L8cq4d9nO6Tvt5UHcuctFe5rhnQxg7s5ns/sHDB3yigm3p?=
 =?us-ascii?Q?/DKR1c4hd7gGcLkOLUO5/qewPteCFQQYW1huD95MLwvehmwwZnkgSK7IrROd?=
 =?us-ascii?Q?qepMHiCQAu418QWF71bOm83XZLTNoipwaV8ueG9VDY5uJLLiUsyWYwwF5VES?=
 =?us-ascii?Q?J8rJdHNqjDC6vG58/C1mWN8ogWfd3ergzzfUtbihsXJq37W3KRU44g4ckw5+?=
 =?us-ascii?Q?UXMfrSiBbLkI+3UI1ZRQQlq2axMRsTWcIGsXcOezfuMy3UuFQ5zdl+a/MFzi?=
 =?us-ascii?Q?SW+a33VO/fQXJWa/zXFiEtH9Fah4LGP1bSNFLjZsaQ9mwPfa0j90RROIK9KL?=
 =?us-ascii?Q?gTJpBlhCNq1n9Z/iEbGwW0dNv5ChjVtbSgt+bTuj4ExNmw4+LNwfD2eNJGxG?=
 =?us-ascii?Q?Cq6nShqJOeWulIBvJfjQh19hga7zuBLrzEp0qTVnfsTy90U7WXZc2Ti2DGRH?=
 =?us-ascii?Q?/8E1ZgyzpxG/CatKqcmEEJAMAVg/iegHZjdNV3C2ZQiDZjEwKhxgIoEMX3Pr?=
 =?us-ascii?Q?mwrYOBjFrDpmmc28Pi9oxU8qf7ot7HjcqPKCJl/Fz2Bmx3o/ARj8zHAX4Q8m?=
 =?us-ascii?Q?idJIkuuy+aC9okY2yI1iB/PImo4LIzFkpYRozexsh12oMrwPy8KdUk16njvk?=
 =?us-ascii?Q?xdQiN7wNX/yx5NfYzT2ElBeu5e6JdLI0N0hoj4AatOCiE8qefZKLScb0P7cv?=
 =?us-ascii?Q?u1lSDWUg/EMsAFOSzLDRWokHjZAGJPvWkUrB6JWvk58+r+hs+kLouZv1PyGQ?=
 =?us-ascii?Q?EREvBJrzKzqRtE77cM5kvhNOrgxHX1abecD1Is4CnJinYXyjGE3YNb1f2/ni?=
 =?us-ascii?Q?x+mzeYcrcDQz9Snk8pKR3REbe4Rgp8G3OI4e0w7z+RbTT4yqDMHGflgOo1Gm?=
 =?us-ascii?Q?aFPcq5ZYcfN1sL/kWazRR27sxYSsiZJUkcO97A/asNbscRQf11JrZShCHyqQ?=
 =?us-ascii?Q?ZE7HuiFndGkdehcW2C8b3zkyaLG9FOsdfB30/mU67gQCGWWnGHx0y62HRLp4?=
 =?us-ascii?Q?uH/5+9hxp+vPoO709ui2jz9s3GMd9coHVtJvADX08w5obyJ0Gt9wPwfqxbo8?=
 =?us-ascii?Q?jxqh0At3iEUMnnLhxG9OO4t8nspBuyfeYXKDKmdSmlZLKsweeag76tydqkvU?=
 =?us-ascii?Q?5TBBA1PieMj+YW6pWJbv4mMczRffqQDv8VYP79N+CpWOy6CA7oGCIx3FcjNK?=
 =?us-ascii?Q?dvJkE623v1ZBVFzwqo/2dG1jXEYDfscog2HFqaDlbVmoaxf2fZoImHue8hAM?=
 =?us-ascii?Q?ervvmSDw966OGFlufd7D7eWfi0s9jMdaBon8o06zSsdduCjDZUaVgqAuhFTv?=
 =?us-ascii?Q?inKmteKOkYIlf9MD5TTyv0nKZe6cumUqd6uRsgkpLHNP2jJHb5XDTGUC9WmC?=
 =?us-ascii?Q?+lsExCdNBkCK6cNeqzy3lfuZlktls1pwtwsi/rSLmAh2i+7FoNnJPp5MZTo+?=
 =?us-ascii?Q?QncgO3cbJ5scqnEND+RVW0qsD+AIi3457v6R947bFO996V82g7vRG2kxMChN?=
 =?us-ascii?Q?kVwpk1iIHr8vBUQ65q3/kIxio/a0CxiBVMYUa55CnoxF+Omg9kjnD62FT885?=
 =?us-ascii?Q?1o//mLXYcrIdZHnjE61lsnY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb62cd2-d180-46e5-3e5a-08dd7041753e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:39.9716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gok08ZaTLmL7tMhOMupH4yloap84E6e/V0cqMPDG75C/ufuTfv9pDvyzRY/GGqrFyWnJ0dodxX5D19T18Nnp1eR+KJv17Q8qqPrpSK8Rsqp1snun9EXVGmAqI/by3yOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13299
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18431

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9e269561b363038d573a69755c9eeabc9258837f upstream.

Add device node for SCIF pincontrol.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241216195325.164212-8-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index d4d61bd039696..c063d47e2952f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -7,6 +7,7 @@
=20
 /dts-v1/;
=20
+#include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
 #include "r9a09g047e57.dtsi"
 #include "rzg3e-smarc-som.dtsi"
 #include "renesas-smarc2.dtsi"
@@ -16,3 +17,15 @@ / {
 	compatible =3D "renesas,smarc2-evk", "renesas,rzg3e-smarcm",
 		     "renesas,r9a09g047e57", "renesas,r9a09g047";
 };
+
+&pinctrl {
+	scif_pins: scif {
+		pins =3D "SCIF_TXD", "SCIF_RXD";
+		renesas,output-impedance =3D <1>;
+	};
+};
+
+&scif0 {
+	pinctrl-0 =3D <&scif_pins>;
+	pinctrl-names =3D "default";
+};
--=20
2.43.0


