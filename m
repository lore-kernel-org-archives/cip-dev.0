Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E18C77B7C
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:49:02 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.2])
 by mx.groups.io with SMTP id smtpd.web10.430.1750690137613573458
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:48:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=l7lBBGon;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lG3bW+y+f/QtyluPp7lreesy3ylPJ4eDGABJGcJ1yJVotbHmfPD67qxaF79Hnh4tPPPMjmyYeZCsStIpMTJSTJEBDcTe0h/TOQOq0wiNX/lLmeliIowJeZ2SC0GS5mZfso7O4XCMnjPvveBVnlXUEhiyrP8nQDH2D9pIhyD1LFNAPLi75L9pRxt/Mh2K2BzleuZ3o+A9khE8tZDO49e/AxoUI1KD4qFWNe06YH3bDx4KVUnvfPvy3mxHr818XQ3CcWakkx8oaAZPnV7yLU4h/zHnPMLfnQ6gXM4ZHWe4lbDu8GBA2QaRsIxhDCfpZKf3SJ+ZMPTiFZh5vo98Yw2BmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=176Oxg0fL1Aprd0KVRLskWNJpIBsX9dtbgBvMmXK+zs=;
 b=Ekd/oalsqZ6iAZbqJfQy9IwvOCZhKHl6xlSEUV/2DQPTL7voqcF/KJSBjBAX045RM1UilWgfdWfOV5XyIRsXkugF/1ddd19RfeHOzlhlzaPxDfPfYKG9RLiyLkckSiUk1Ell7rbXRtRlve/iF5axPfZcxrpXibChML3KGY0R9bhjHrKDzF6F7ao/vPxiOW+JLsI2wgJaVbyBhca2GFLvct7NIls2N0nWSerLbxXf8mP1cGrIN9+mWpcnOj9wCIbuwF28RGTNMgXs1UlzOykTNkQmi38VDSvebkTVHRlxP1rzYx/BTWy7npmM6pu+R85TmZrpRbjKDMsjhMfBqN1Dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=176Oxg0fL1Aprd0KVRLskWNJpIBsX9dtbgBvMmXK+zs=;
 b=l7lBBGonyVrnX27X3yRwyomWoxltd5hublN8h8injrVf734gDhfs4AP4lob4h5KwAEICJMdcFLPnCUWa1aXjav1E+/CAG5nitbmdqLEYohy2VAd4houfnZLmvYoldeNgLN/uY9RrBP1+dsRQ4X2H6ial+HqG3DEv2s5cMi+L4o0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:48:55 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:48:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 07/10] arm64: dts: renesas: r9a09g057: Add support for enabling SDHI internal regulator
Date: Mon, 23 Jun 2025 16:48:14 +0200
Message-ID: <20250623144817.2119838-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYAPR01MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d732181-6fc7-4b9e-2d00-08ddb2651428
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0ZXXTnNTiGoHDO0i2gZ4tZuHmnqonXf7zhd+qnUR+oS4YVhnJXBg7XQGH2q6?=
 =?us-ascii?Q?0awhNwp3lvIMNamMtNDBq4QMgwKK0QQD3TrfkilzNxkNV+KU61BHyVR9R3y1?=
 =?us-ascii?Q?CuQ/XIlfQh+BC+a/WMxKz5IcSNfSQuAqtf6Jp8CtA4lXJuTE9TtRWUGrCd6M?=
 =?us-ascii?Q?Cv1M2gSgvlz3g+67NqaX/D1cBTyesjNM76nqRCb3HXzrKZIG9NTpCu+HRfAn?=
 =?us-ascii?Q?tXM/fhmCPWD5o5i07BQZlhsM8hzobSuQsSbeATDIfXfDWNopXHols5AA+yDy?=
 =?us-ascii?Q?PIZZV8r7H0m+9Lb47U+ReaRqVoFHg9aioDOLtvK7O0tiPtX3wel0m4VL/Csc?=
 =?us-ascii?Q?WXx44SjPlD5zGiOfPOZdRCJz7kztwGitH1tBqlFPKVw6E+SW/spAMEg3HcRS?=
 =?us-ascii?Q?SFwptKst8r/m4r4v3pUy95Mv9nBz8/KJeABZSTm3ah0xfZMS2d3k2MF3koHD?=
 =?us-ascii?Q?AEcXunRYHMRD60hPH3YhFmh+u83BYjl2a2Qaap2FWKJKjmjUOD2ypfXCa7UT?=
 =?us-ascii?Q?6s9xIK3hoK7P6qFnE1yqlVKdhpPUqnLdsiKJa6LskJsBcqOu2YfxqcmYR0Z5?=
 =?us-ascii?Q?scO0O6ejZpC0RmiYC3pTdR+0ugxKUcHPdSxTHF2/lhG9gJf0hDQY2k6jvZvA?=
 =?us-ascii?Q?vxc51z+zjnNOLPqajaVPmgGLapSqyMkHs1H/2StnFOvWOXbmKCP+OuyQKqMm?=
 =?us-ascii?Q?hniapOMa1lRBNVqHWZDXkvXu/XhOrT6c2oXPhGKykIlpyhGSIVpTByPVy/lZ?=
 =?us-ascii?Q?QzOC7AqMn/aykzl7dl2AozpSfpSZPzYceN2B7M445/nhWz8y/mHw+Rsl2LtH?=
 =?us-ascii?Q?5PbkLA/VNRtuEA4AqBZfIGngfSd4LlbBKCD1NSrc6Hbnhz6QqFxYu7NzZMFU?=
 =?us-ascii?Q?LGNO0/T6DqmsdKVuwcVFcOu2tKcZJiFpebnQ+wT/vY4Je9U6Fub6p3oHNLJQ?=
 =?us-ascii?Q?LyqPI5bkH3cDeueS+XZCFHROf1OfDq7w7Sfk8se1qPKwECsL+imVIWuvkFkh?=
 =?us-ascii?Q?aOgFYFX9QwkSqK7tr6jsr5UBj2/B5/8RtB8NEq8S2Znb0geMDnyr5k7WSRzO?=
 =?us-ascii?Q?Q5Nwoxmzjcz4q+Kqe1J0NdHpI/dZxcd4DsH60cxoFYLHdztNDBSKOWnK1XiQ?=
 =?us-ascii?Q?J7jHSftTD+kJP1ZceXRJPkitZCGMwh448K2/jZqXcfQUUXJOp+BOAxPYvZks?=
 =?us-ascii?Q?gg7Da9Le5/pw1NA2QuxIDl/QjUXr6KLKHTl3oHh1Vs/KU/2vv4XUgvMBaouc?=
 =?us-ascii?Q?2aCWO0+yfBGqrLbgpqMCYgT1U0Rd3ELu6FaqII4v8gCkdeDXIIpockDcf8BV?=
 =?us-ascii?Q?Or83q3FRkeAWtqPRTE1nt16iuvXQQNkKK4uAHQBzEIzVy3SID4PgeuBb4naa?=
 =?us-ascii?Q?9YXfF4cuY5ypzQgrdepJvLqaq0RXF37InpY/vhdhr9ySeSRXLdRPMSqkpZ83?=
 =?us-ascii?Q?p3So8YecdeXwBZU3k2CTT/im/eIMZOAz3d3zAXIWq2TUeQ0Rh31K7NcPWx0A?=
 =?us-ascii?Q?UywJ0KynJb51WK8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?knZpb+dtnEqphVUHypYz57KjQ8yc8z3l9vTRTbiUX/JqY/NJrItJn51Muidf?=
 =?us-ascii?Q?AIYkqYrUF/d4LstwX3ZCdqf9fcNqJC8jl9oTZWXJ+o4ADdOXTo8qOGFtrxmw?=
 =?us-ascii?Q?xT60TGwPRKH/stjxSqnqw1AG8Oy0nJMXw4kz46Oc7NsNa7grXjLkjLXdWZ1U?=
 =?us-ascii?Q?ZcXt3fRAOGAbPKDfx0VTjhtSS7zziy0MOytzBZDUpsctC+C7iUxp7ytKUd+f?=
 =?us-ascii?Q?FCI1VUIcTF6Af9CGcMwCYsZqLTNxAG3HErx1lqRji8dny5i/vZ9eWyjYl85d?=
 =?us-ascii?Q?O7ecxmLWE9Ov7WmX4hhEJxqi0hFP6LUBUEY17cCHOBz3NckE69yGhLp+U+Dg?=
 =?us-ascii?Q?wF5DR4A7cbHC2Pd1g8tCheGkLEWwrmc3NzqZtdIvhGztEQ3SyDsbyjGUUCJm?=
 =?us-ascii?Q?g+7LNdrizuvSOoMzYvA7IFa6KD0j9ci7CFj9T6lQUOM4iOMCf5xYPo5Nj65a?=
 =?us-ascii?Q?cGm9kQ6+NAw33oB5bC8bbS2zS+WY7rSTJVjnTDYZyUHJHsFAJ1L0dksvyZBC?=
 =?us-ascii?Q?ZgH6C74MkF9U3CRswSypj0JBel+bx5psC3egwlYTqHTsqAZyVowozqrlokwj?=
 =?us-ascii?Q?omljEpXKu0v0SerKJbXDyeq0Mn6NanLBZCNQErSdILvnheRoHfqk/wahk301?=
 =?us-ascii?Q?+ri6kmh4tFuIvYztindmtbQAwK1D/Giolbeuro/o4CK70+SQUZ02Yu/z+dFQ?=
 =?us-ascii?Q?EYa+LIT+uD2jGhW2mLrhoezr0gZbKaaE9ocq467bWy8frYuu5JuWWmyzfk/G?=
 =?us-ascii?Q?BPaflDVG61IFak2LvO0UBXLaRIdatU/ow1hJo0RNQH+TxZJPUgePGYPHTFJ6?=
 =?us-ascii?Q?b8+QW4dnF+nzrRJQX16gtR0lCXMMHW9E6EF91k98b6o24R6obT2TPQ40tFPu?=
 =?us-ascii?Q?fpTXZ5fuH0iw9RHLchJmQKwkvuYkSNgyxRaBMkbivxMOzMp6T8QwVNJtOOfh?=
 =?us-ascii?Q?tqt2db9YzsFUlqwLFL7F8tMDE1eSEZh29MPU4+305ehq5jIfX3UmN93Uz8AH?=
 =?us-ascii?Q?Spj7LCCRDXnjM/nZ2PUEXeCUMxO1saLIzTmBT5CXgrCpDZQZk0t9lIy9d2kw?=
 =?us-ascii?Q?Hy19/CMZcAp2w6zd3mzNS7ywwJUmtBPpDwyxGsrenMyKMj1GyXuhmCF+tHgK?=
 =?us-ascii?Q?yAs4xE7/5+S4+QxXp7g1OoB6VMV9ar4iQbED4hkLV4A5XGsvkRWe1Z/LGLks?=
 =?us-ascii?Q?Hd/h2ZE9TjkasooFVLUv7rADQUmzoNHpeWRBY2EsDFOrRreULdemv+24SdTt?=
 =?us-ascii?Q?Zq1Ya/kg1IZFEN6cERg+nmS3QOxL39KHftgVzEGfKEXPHoKq3SgiCwcnfSs1?=
 =?us-ascii?Q?G6ja7b5mowQ28Kl7X//ofX34T+LIUhgBfTGB368evvoMz0R46teHZ8I4L02T?=
 =?us-ascii?Q?0FRVxP4esEOPGD28DuFJrs2ikxw7DG8iFKdu6v2bt2cChdacpjD7Pen36kLH?=
 =?us-ascii?Q?SBqi17QqxPghdc1XfqDpOXruUAjEdPKDGAP/DuDqqygEbZXWqie+kXPfMtr4?=
 =?us-ascii?Q?wfwUWQdLvfY+HS7+SDa4Zkc6dDwjwbfVsOUk9uarkrREP8Y8/jb5e0TZeJyy?=
 =?us-ascii?Q?AC4/2PSZns+uJ0kN1oTgcgihJvgAWifA3X9Vx7vl2+NuQAoCRWlhqoCi/W3S?=
 =?us-ascii?Q?ooRcZqht3tww6wfFn/oVev0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d732181-6fc7-4b9e-2d00-08ddb2651428
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:48:55.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Q9P5oIxt9idlM0VLQfrVK31tU6uRnPtwcsh/7knukO3YaNDChWKPtZZ6k3mH5Cw7iS9AIXrab0gR43v+Qu9r3/0tCDlzd12i4ePoWJhLt1gofHe73rgbtH8Ku3y/5fV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:49:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19212

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 674080a22768dd4c30f2272acbe03fe94c7387cf upstream.

Add support for enabling SDHI internal regulator, by overriding the
status on the board DTS, when needed.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/20250206134047.67866-6-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g057.dtsi
index 3a433f1e940c..0f8a769f1cbc 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -512,6 +512,13 @@ sdhi0: mmc@15c00000  {
 			resets =3D <&cpg 0xa7>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
+
+			sdhi0_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI0-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
 		};
=20
 		sdhi1: mmc@15c10000 {
@@ -525,6 +532,13 @@ sdhi1: mmc@15c10000 {
 			resets =3D <&cpg 0xa8>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
+
+			sdhi1_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI1-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
 		};
=20
 		sdhi2: mmc@15c20000 {
@@ -538,6 +552,13 @@ sdhi2: mmc@15c20000 {
 			resets =3D <&cpg 0xa9>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
+
+			sdhi2_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI2-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
 		};
 	};
=20
--=20
2.43.0


