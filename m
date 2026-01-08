Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460F3CF6A9B
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:40 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3005.1767864577461928492
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OATJcOyP;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHCkdyRU8AcuHqR29/riKFH7yGFzz+GTacTatKtirCdXS1ybP4lIOFqwHdrNhCHC1gB/qtA4R6slL8NgRbZKZie/2rdBeUaAxt4PWZ//S1m20cDH4JyNfpiNzVdPPyjnjFqslhkzUKGrKdkD/Qc33QxJTf02XZDqmOlZRm7L5aHrV12YeYXmo6joTMdNevzc4DckjnpjgfHr+tgJzbg4F0xw036VYH2pg2Cpd7vNq/gzoTv/qieraBO/B95ta0BBd6Wq2sR8ij/f7r5sH3pca8OsfY+b3ZYzsVc0mPd4v9AnBPCxLSimxSWDidNwNEfNLbebbsZ6xYWNED4g2sEYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyhZG+1pOT5pYrTNYl47vjXN8wTTQ+dAHs/LPuYoZXA=;
 b=h6sfut7XQg9B5wEQ+TmCXFRZ7W+6dpjDwu61UKP1lzXF8iL9dy2jAjMs53GXPipTbZD9J2Enr/oZXO1X16M4iUc7BNodllrG1rsvtz0QeGRvfnEOI4vGmI/zvjwutOPwNq8XGFheMST+KEe412b+mzwHlOWoVbb4zG06XnikHmoAub7mbCwVxD3114QRIv7Vy0Ny9YQwhIwwXO4zK4FeS1zaklfVACJWOsuBUNJw6JPwx5vMZVlG7VSHpO/O+sjpq0VPo+6mUejaKXnQsqJJHfL4K5SjZThtHsn7/anAAUMOOO6a/bBDgctTlUapULmY4DNtDFuHm3mqm2boAhsx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyhZG+1pOT5pYrTNYl47vjXN8wTTQ+dAHs/LPuYoZXA=;
 b=OATJcOyPvNTzMpv6fmFCK95+cnhjwliw8sGcElS6xnmU/OGCAu71Qf2zzwymGJQco/KT2SQxIT+PxoHUrfnQKZPsgioSmVTJgobJZKec1mpQFoFFC071U7Y3w3KjYxHH/jiNWp8bHn7Li1WxAl0sxU+MIAcwZ/PYrHc8nMnB4kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:36 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 17/22] dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
Date: Thu,  8 Jan 2026 10:28:18 +0100
Message-ID: <20260108092823.489287-18-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cd1d70-7ca0-47fc-26e0-08de4e9870a3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5PB0EphKMqyEcRLYOq0lSWEP/kkiDN29bjXlJFzWGJDvQSYXWKqCmBjuKQQ/?=
 =?us-ascii?Q?3M8gz3bXqSAsRNQ4+Di6dw+UzFfEJk7jsx0oxUhr2XdN2RokmB78yYdDHbwZ?=
 =?us-ascii?Q?5aLCObivdvDMmY2ZnqEnbXSZ0DojbdSKvGh1he/hCXNL9vN3qLiNPUozKuse?=
 =?us-ascii?Q?1FtPOOShV+kaHqI4NuIUUliiQkJfRmqb2mDkb7mWjUiYf1tK3jMne7HgTZum?=
 =?us-ascii?Q?94j43uqMOr30UUunEFtm40arS4tU8RhVUoIqNSPHHeSvUo8PNqCn1BLZz25C?=
 =?us-ascii?Q?5KsogiFzOuLY9anI7ybtUKAVrOT6zV1HB0HBGkm53EfbNPCpBXATVHwa0ByW?=
 =?us-ascii?Q?mPq+44FuiAua8J6bllAkj3EbmEw6x1xJbNPu/ayMirEkYNSGEY/4A4Xfej+Q?=
 =?us-ascii?Q?bdHBt96/W+Jib8sF8zkNLyy7ML5BrNEV0nX7FjcsI86irCDOil8Gx2F8v7WF?=
 =?us-ascii?Q?sV+s9vugOQeVVaRI+jEK5TA7p1oFNtjplr18H6NSZDCphAkkjjF7vnZQBgVx?=
 =?us-ascii?Q?nPm634TLfgZYhbFwBeOYM8MNiCHENly80vGwS8eRWoz5eWyjCdA/hus6xCTs?=
 =?us-ascii?Q?RhllFyvvtHGDaOhoB55XZWBowj4KwKaX7yc5qUpCVn7vHK3njVR6/6Ty7tDS?=
 =?us-ascii?Q?jHmhwz+/p0z04Z4cXrgn1T2CrzV8egBc17zDyI0BfNXzSduJ4TcZYFbZZmj/?=
 =?us-ascii?Q?hIN+RxxjvDXhT0WlwrcEfbkLbq8M9UN+7AGQIraJfQ9oSC4M16A71qDll8aZ?=
 =?us-ascii?Q?/brLnlhwKwNWbTF2aODwbCuYpRx54y5w0zyGtpPbHbuuuxKF8V+Z18P21AcJ?=
 =?us-ascii?Q?p7jAG7N0UFCT2kmYqz3sXh0s/FV6Wj8Dvtt16lxxnTNWj6Skt9SFLSvSRq6F?=
 =?us-ascii?Q?EzdReRFvGqwWFjfMQmCCaQA9NI1we4O250M/dNv7OCnoHbowLqkctyS+WyjR?=
 =?us-ascii?Q?JrVNqlJkJQLvN/buwfk4Gxh25hxzf68z0YpN/7UYK76ZEjs1qq4hJwvLEj9f?=
 =?us-ascii?Q?EII+yspLU46ORMgXFWo69gMYZ48ffJP+wkAlfleqg3WQDLA3NjeR9LoSvMf3?=
 =?us-ascii?Q?mBVcdJhOk51z9qtX23eG8dpnTcPWCGdcYT3z2lpRy5vjrVi/slcbicvaisW+?=
 =?us-ascii?Q?mubb2xJRvpG+EIGJslqo78xPTQBE+UuH9NCyc1wVkV8+hNE9uMPqpkZw1Czm?=
 =?us-ascii?Q?hDFvsX6geUA8JCQkPo1DzW7z2hRENGFQUFg0nqaPd8LyrOG1uTI2EppNpgX1?=
 =?us-ascii?Q?giwA37ivms6ULzBPPK6En7tblXEG5ASa06Kj4fo+NiTT3/yOZF6CQySQQrMf?=
 =?us-ascii?Q?231D07fNTwnhhHdRQWd87JsZLr3NTf97DE9gresdLEDYQt6E0roKXlFvPDr0?=
 =?us-ascii?Q?9OZaYxEbnHnVoKcFU8CkuH9VM7e+BKEXAWgmhdQJmggnrvIHmLu5VAF0fV2O?=
 =?us-ascii?Q?jPfAijici/0Y9Fwl4RnC0Hlz07vOjk1jS6jJ/1dwodNc9j55vFeucw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Pk2W8vJ+am91wuijaAKbXEIr16GO2sBhKTUhW7A72/HHLbP7SQyPkPFr/2YW?=
 =?us-ascii?Q?4mWliYcIn+F4O0TAfBzcJkScJqmnat/KeUHRzMkMtSmpmZe2Y+3OkcHDtO7Z?=
 =?us-ascii?Q?ikHGJgWp4Yy/xmwq7vvPf2foEyUKeZEVmRxDQfO20sCk7H3BSpO1zop6BGgl?=
 =?us-ascii?Q?pBs4Bktle7VzXJqU2qwD4Xsc7Dnq93rM8Hvo11uprkDyP/qFu6TGK3yqTKqe?=
 =?us-ascii?Q?tQDPR/KHWdUTDGt6zLdD9E7qYQ63/PW2BI5fpsHYUuZe2xe083B22eqUPpAR?=
 =?us-ascii?Q?I4s0WHbIvUgZq/QP8RYPd2tnFKjJGw/6sdOlRQ/VWvoOCqrDPDH0okSn5iTM?=
 =?us-ascii?Q?JLIPfRrpqdQflOqpvfLmfBXhYHInHQwhri6dnJGadxFHvIjO6wc5IzccWdFP?=
 =?us-ascii?Q?7w+/q7Skszgw+TepDq5kERFuf+mC0fUbWctMD2s+WGUHN+/RuApBDrWj1xZj?=
 =?us-ascii?Q?uGPSr9S0qnE8dqAHwcmt9bDhK3LvLIQeGTM5tvcnYWjRBexIRWH54l4oDt3D?=
 =?us-ascii?Q?7EPWE3ar1Y2dTc1F/AvNN5mD0vFa2g5Ah3/JWdfwd7Bptu7O9TFniTbCIMWm?=
 =?us-ascii?Q?lWf5qOm8SpVShoYUiqHd9E6lApraUJZV2vl3cQCQTmELf+b5K0NOTqEp4VI+?=
 =?us-ascii?Q?cjNKCH2nc+78WQH0UVRi6B7Dtq625V+/8eFa3hgzS/z/kUBVWS4fn4RUNAwZ?=
 =?us-ascii?Q?DuJ2SgVdKwchnOTApOZmigsd5pigqHd0zKyYqnL+f6eACWPtjL1jG4FF0bMt?=
 =?us-ascii?Q?F2B5uVxkef9yYsYVhaALXwsUO+si6Gt9Mm7gCUMVB+C5O725wSjnMIfAfIQm?=
 =?us-ascii?Q?+/IqZcs8a8HULT6gEWihNTxrBfsf11ZqFs8yfq948+xrQ4ew0Bazd2CTqrxs?=
 =?us-ascii?Q?2ehSoE2vTGNENd9p2c7nX8kFslpjE3MEffTza5ybMhCTZbDDpfkU6p//gerB?=
 =?us-ascii?Q?OZf/mFxEfhNHc2f7dCNA3CELSDujoGfUCh12pF283kOqPi1vunWgALryfera?=
 =?us-ascii?Q?pqzkL5UrnwBFQVirCX4xlwdJjYPjQxSyYGonxhFOlDna/+V2xQIkBSlnOoS5?=
 =?us-ascii?Q?sAozRPtjoMDEZnO/QEIY4aNPT4UdttkVzHaL66ifOrNaEGH7YoB3FpxV2ohs?=
 =?us-ascii?Q?wc+jVN0peSvS8DBUFVs4fUVXD0iqdZb+Dok4MqT//YC2GlTsDLiEg4anI7Nb?=
 =?us-ascii?Q?pTn50haS3jN+lOik16311hVhbsB5UnBlfVGBlfBnSEbgsbVKiZ2cRscXByhD?=
 =?us-ascii?Q?kTQack/YEDJsDoM5Oo8r6eVrEqgZ17OqrcFZhfyR6njJ3JGLSubh56ORarS8?=
 =?us-ascii?Q?0Km2BpIC04O9KlXa0/wDPhHTpmbja6bNXYVHDO6+QeaFInIZYcVLm5IUKOH8?=
 =?us-ascii?Q?4gCwtRKH4voMjPHYq8ohWk199OPP+YGmXb3Cga1iiXTsbyODo3AmzlV/2OlD?=
 =?us-ascii?Q?rsl3cQcmIcfzKchTsWh/M+yvECjA9QAMSPHDg51kLi2y9+B1PJKzqvibjAso?=
 =?us-ascii?Q?lIG38FjJ+3Ni8ydoY8bBnilkf3SM4K8xgVLpHGUzaVg0ZnCSNEkBWi7LFsMx?=
 =?us-ascii?Q?df2kqjuhUkuxHdszBWc9WsHPdSu9VIDYqSTC4LIBYHoc6AoBlmZHhC5g2ycM?=
 =?us-ascii?Q?04O54PYQyfKnYiyXgQX8Q2dfTOQqF/86EhfuWCwwHw+qKLqqhcWhTFpGN2Fq?=
 =?us-ascii?Q?xFVolNsV5Sbv5ffGkWec3SkLC1OjyQU4zbL14uMSrszH3/zBqTCXY3Feitya?=
 =?us-ascii?Q?IyXVMAIzvbJuOM2EjpRWfgsU47SxM3BI2K4wIjYAIm1Aps8m83Fp?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cd1d70-7ca0-47fc-26e0-08de4e9870a3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:36.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxGkzbiIzndciSwCW2ztzhEoAVzjZKDur+AfNSNGBHryQihdLvFDYekWzcvR2pqZ18GdwArm9/c1dqbUGWSVZSjo8Xzbuhbftm84P8Pc+FVc9TBF4qCFotNa+nCjNxcd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21453

From: Frank Li <Frank.Li@nxp.com>

commit 4585580781d69d8627e15f027873e46282ea3787 upstream.

The register layout of P3T1085 is the same as ti,tmp108. Add compatible
string nxp,p3t1085 for it. The difference of P3T1085 is support I3C.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241111-p3t1085-v3-1-bff511550aad@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml b/Docum=
entation/devicetree/bindings/hwmon/ti,tmp108.yaml
index 5bbb7aedda3a..1f8af3a0048b 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
@@ -4,22 +4,26 @@
 $id: http://devicetree.org/schemas/hwmon/ti,tmp108.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: TMP108 temperature sensor
+title: TMP108/P3T1085(NXP) temperature sensor
=20
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
=20
 description: |
-  The TMP108 is a digital-output temperature sensor with a
+  The TMP108/P3T1085(NXP) is a digital-output temperature sensor with a
   dynamically-programmable limit window, and under- and overtemperature
   alert functions.
=20
+  P3T1085(NXP) support I3C.
+
   Datasheets:
     https://www.ti.com/product/TMP108
+    https://www.nxp.com/docs/en/data-sheet/P3T1085UK.pdf
=20
 properties:
   compatible:
     enum:
+      - nxp,p3t1085
       - ti,tmp108
=20
   interrupts:
--=20
2.43.0


