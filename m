Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF22C44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:15:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13194.1784294128494967485
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FxfnOOby;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.56, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrROPa11XiBvln7BseLl/X22KdOu02dibmuzoxN+oGscNJVJr4qNCSSNpMAF5kAdL7hN8R/ovL8Bj45rYMA+iD1m/xmmW9r7JXsm8Rs5KnJ2hGTeNXJfLfGv7uO7B5d2CAIbmWGPE/XO+cXKwM8lejdSlZVjOxLYKi90cjQExdcNbz+ltASBPiXSdlBJ+KRIZOlZjzy3BpXL40vU8RxbRAOaOJRCQBJNiQzJUYXD1tJhru2MwA1ZReWy/DnqJcExu8EVgUkiMoIfAUIm2ZQqQnKlTUP4Zhj7vqY0QfXNmRfFo8TM3T198UH83SC6gJaXzBgUKSqbHcldQnedi8uGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWZSCtQ4qGkS25YY8rw8zyOyMzbrIYQlj+Z8xgzIXbU=;
 b=Fn1XYJ6MD02XKp1bjiVzMqooswVz5L1tDipTV9oSot01sWX7jXrV7Q2x2S12+FGqSlwXom+eLk88iHA9HjIeGLjDrRfdt7MVsGprYJLkB6RPZUspWkOOCn8QRsCNztEmJOVdAbGxTY3iyt249roKSVlYCLOvjg+7Op1tiq0qPq0p3PenCWMvsKPI/mkkdLw+xMpSPzK+3qeWBtoaki6W7cz4Z8WsOHsNr1YZtLmsh+xqocr6xtgtOWv/ouFuFBi7Xlmsp/Zd4wlfdxoKxdA7J3lOEO4fDfVvkJPVoyrzCcOQbx7TbP4iNkumN/BkZUcd8jlyd2wHACa/0b2VfxAljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWZSCtQ4qGkS25YY8rw8zyOyMzbrIYQlj+Z8xgzIXbU=;
 b=FxfnOObyzN/OF8bAcy5BeWYUWh9KWAeHBhWZuW36+WIah7I99KPeTA24JRJ2EL7FexTUbYNDoXhzVG6rvBFMDqx4w+EdTPopVu92v6SmwKItZAurGyanhmcTFioEr92hZM6IasZ6vrTSKNB1MCEuMQsH9+f/6Z3MMfWENkUwt14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:26 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 01/15] dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
Date: Fri, 17 Jul 2026 15:14:48 +0200
Message-ID: <20260717131502.2234020-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 12acf6d9-93d6-4a5f-28ee-08dee4057797
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|3023799007|6133799003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	pyOL1lycqYukm461imfoGnYwzZxwCLWUWBumHoNyeOO1a8izZUobkuFIUAlbKLNvOp/3SNwFU8VWFQQA2FxM0HoWKlpp2laAYuwcBH4GGCFILu96RCgBEDe/o82UQYdy2uaCG1JrgJnAOK47lfdsefR4g3+dGZjHWUbgWE/eHQXjgqP33iMTFJ5u9EWPlKAdsK6c48otZqu/PixudEfxqJhMCAGX7sOCPK+TVEJ+CEK8jy+IKlYKPkTrU5a9fEhFefyRevj80+i6QxbJxlt8I1fZWFopzBNAJVoJ20YH8pPDTAwvkAGRkEIlSzHyQiW8xBrthw/EA1OwU4YLf6aVjKx4S+fGXFy/GqFF/H14m+6l9Trs+tKhsSiv6WSm75Z3IeMW88o60gGqyp9UlA1N0/m/oXVocZ7cQf2pcy/SNZN+Pd1D+v3iw2qNUf2t8ALg3L8K3uor6O1eQBmxWGK9xowDTILFX5CsgaT2vWCLf2NZZG3+BFNGM4WOdFW6Zs/gXCpmxu1CbRLeyPIzgHIPqMoO9W/13Dq8bLRgbxuVTmYyNF2EstwMB/Y2u90E2CGF+D0cK53uobaU3YrigY0kz3LsKx2Vr5oYm2dPFh1YTXgklYoFF3fBUIrT24bREwy6hhuQAWZDHU1AW3UrE936ouxKCG71Fapon1K/wIuIGMI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(3023799007)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yfsvG9i2UZSpVdR0aNG1H8155qZe7Fj5OpSBVpzwa8s0RSv3KxImd4a9bP+H?=
 =?us-ascii?Q?TfJJ3PeCdVMwpyWlYI2UUrw8GwdpLDZab9MVRzRPAS7wK/czCTXTpRpBwDA3?=
 =?us-ascii?Q?gGMlPJat2dVlsPVde4mmxSGndrB/othrdVtOu6hjm4aJxmJZsCuEacYXC93L?=
 =?us-ascii?Q?RRKy36Y53fCQ6EvyzO6AEh9QrpqZGu6HEkdWU9qG2y3jKNhz16rX5HUXci13?=
 =?us-ascii?Q?tKcYZYd+WY8RPfqH/eCvRn3cYLyqezkvT2iNyDWwJ9wPcYYISIn4C6GD+fhE?=
 =?us-ascii?Q?hMQnKX1TJYtD9qQYARwN2snArcbDYHbRtmysQPSmgTRhoEQmhxn2e5Ulm457?=
 =?us-ascii?Q?dc3CfVYEHL9TX5oFMEa8OtFADOFJJsSxKSw8svhWEGLbuf61n3iseOXu/teQ?=
 =?us-ascii?Q?Qb0xaoZdZGLp4pbdKwb1sMJdHgezL+CLUQgo+PEWQOE4kQ+CI/v2L1cOOnh2?=
 =?us-ascii?Q?og2lW5OFkE5xaopk+MUpq9thOV1LxxCUQAWGWomLk/8chOuJhBfb/QNRPoGK?=
 =?us-ascii?Q?DxnmTLdjPF5UcQt5finYxTOHaX48rb6AOR/NT1JrAnPWutMJ1MaIYI99I0kX?=
 =?us-ascii?Q?McfMubVnIsY8XenwWNafPmFNvEsfdRXMtiOq/hIuHLF4lkaK80HJd2trNWVF?=
 =?us-ascii?Q?7477PHhKBHoZlGtzup56Cm1wwShcHfTpsqXNDpJ/4sfN/Dk1iBe2BfGkfmKP?=
 =?us-ascii?Q?YoslbJkzu6Y38+JMmp8KTId1MhKd1q6PjMHl4XMCPnSWaM+ijWqgVU86YAtx?=
 =?us-ascii?Q?Deiw0EbwdQ8HR/4FK6mqmz3BOOJWqLy0FcU+ntlIxfI2locYfL+bEISc7cDk?=
 =?us-ascii?Q?OLQ6w8t21/r6e23rWpSWmwIRliFD/cyfgH+m+wMV1MKcAFdOrdqsfGyCVVCX?=
 =?us-ascii?Q?KSfjzo1a/v60CmRXew04/4ZJdpUgEfjWJjYCNh8lhbz8cVR+OAeoRM1s1M66?=
 =?us-ascii?Q?chiSDbb9wjlHNoJqBQe7hMjwsVCLb87CDIKpfKwbno3JBkGhtpuaGmClXxTc?=
 =?us-ascii?Q?EtxIA5y6GYkCcUNG9ZwnDPfzFLdcbPLgVzAmPZqhn4gknU8YHbF+NwlQvZG+?=
 =?us-ascii?Q?3u5R5wbhjcCZHfiS01eRiWDrHJqNQ7zwKCNWL0601afIQUCHDY7UoF+l+BoM?=
 =?us-ascii?Q?XvTC6ZtLj3pP4VLF4qvYx/5gxNpezUhxn1GUgyXmX31eoMpqZL0jpUceBS8d?=
 =?us-ascii?Q?mTkmoINxkkgVi8J5KL5Uz1vV3EQdUV0ieD95Xpwzk7SkHbZjFUHIjJ7sDOCL?=
 =?us-ascii?Q?kj/9aUtv3w6YjibG2jcb0PIyhv6epCWgiWHbgpkE78+XE+hXaRcS4w6prOyc?=
 =?us-ascii?Q?3JGKhsG5dk3wd4d4vFc47ZiV9QdpnWEEyJc3EGYL+WxB0ORvOssBBDb0R6pw?=
 =?us-ascii?Q?cU+8JoQWy+3pWCIenwx8wO2WrR2gB/e+5PCGGtI1IU/T6xgvJ8eCvq8cZcvH?=
 =?us-ascii?Q?JYcnW0DQxUnzXKMQg0tGusqKQTMzQXepXJDQEU7nV8++/INlM05t5dPQV6e+?=
 =?us-ascii?Q?hP14IV3D7eNevFA8q59sgCnfJ6963r7z2h/tteSwR4jeo30SXp7mJnVe6qw0?=
 =?us-ascii?Q?easG31xdcy2C+TcV+6eUOOEg0oupqXCLuiTiu0lO7KQhlXIsS4z1/9Br5RwV?=
 =?us-ascii?Q?UiPnAVy2J4Ed6PU1FAYVsFe27dajwQXPIREOiwk69m0aopao/pSXhm0XNfYI?=
 =?us-ascii?Q?chmTw3wG9ilj3orpxlo3Sr8KOxt+QwSELl3auqAKt4JRXi64GI9IU0ngUyki?=
 =?us-ascii?Q?xakECiqgGNtGVVYvGJyQ9aVAkQR6Zd8aD2w2wePKXfPlsdC96Wmi?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12acf6d9-93d6-4a5f-28ee-08dee4057797
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:26.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucwyRRu9Jo5Lv/Miyof10NpKC2OOuFZ3SH1gOHf6K2vRQOCqJkPVLwGIKjc+8qYx+75tZIQ0YO7w1KiNY5wtoFC8ucNnGkA68/AeLptWgNgQUmD+LoIM+zRYH07JgB2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:15:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23653

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
index 0ad10d43fac0..a6f9319e068d 100644
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
2.54.0


