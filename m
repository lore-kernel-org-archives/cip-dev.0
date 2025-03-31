Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52A9C36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.57])
 by mx.groups.io with SMTP id smtpd.web11.49164.1743419245820480194
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=V0dB8IrA;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aB30zV/F7OjOQ30l1rYqtwDfdWqEs799ZN4ZMVrfxpg68gn02Hrq0mC/6UxO1VJgOpacB6AYyvWxgSUR8c3w9xO2SSq6R8tUGSd8KL7mJ7BRGB3/M4cafQd2f/C2m+LGReLztJyW59dec8B4KHrTxYsJuchdyQlc6jwYJX3B0JMu3+eGqRHGCnOm9y4ZjDHdmfzzerbMAeKC5MAd7QBa2RLjw/iWgxqp++eG6czT07b6Jr9BttIpN55jBWvnU2nSrANovYg6FIK/2sjqZ+2La/z9YhFr6CXZFbiVeuQA6FQ7Qpg27jcVA7AVlL0HAkuv09PoYo7B5koBGs6Tav7H+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UtfBw1ldZWjUZim3JPRsZwRNeoBxmlWgZkHGqiTF6s=;
 b=N4+HnKFzMPxv7Jqxx917KzF7Ptcthuun5Hkh16snnq12RCChiZHdTEV2r06/1qZ434ZdACqIJFwtfOVobakjKgGXuGbjubwPppyuHXsmv94M64NOeYcYvpbCFwPKosmAESulcCgg4+444u+24lEu0jDA16Ch7LOvVjjvLywRmrZVr+4Xde5ofb1rycAtCVvPzqYFWHbY7TkQVoScWeME7g5jHRUI5QfbIz8A+VvGi1Nqs6oEL8eXTcwiFMvf1S8ZyEJHHzZdVBiyiSl0ycegns1y601lOXx7LzhBQuFeDcT1o73NmIln6PYB4dnhKO37RyO+OWTiBmiDUxBYv/Zq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UtfBw1ldZWjUZim3JPRsZwRNeoBxmlWgZkHGqiTF6s=;
 b=V0dB8IrAZn9J0ImXPgw28a0EfVdDV8m6YlXwthSRGLnWwFXGHxfQsz6tGIFBSPhdgMdevfXsP4zsAKNQfnjKvM5/y0e3q0KxrUEpdCJT71ZqiNErVSZ8sObRa1s3q1JidcWE2ezS6A5NgbAreOtBNcm7lI+y0Y1Cde/gttTQb6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:26 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 02/13] dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
Date: Mon, 31 Mar 2025 13:06:48 +0200
Message-ID: <20250331110659.252237-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ccc874-4723-49ea-3bdf-08dd70443831
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bUuXQ4iWsL2+uBEJvvbeKuSBLsYiIK8tJm1WCuXnFV3qTtZNPg5lOyxoMStc?=
 =?us-ascii?Q?pJpC5A0TS7a/CJu19Z3s/xhWV0iyM4MVsGjEfrdxUQfOcthldf4ZiVdMS7IA?=
 =?us-ascii?Q?WWi++T9tlcyWJgs0cTX36KZTXqBdFsbrYXzMq8Py9TEmpTvSEV9aCupP1tSQ?=
 =?us-ascii?Q?MrWca2W5yLmuTYWp256Eqd77QFLqin6TJrZZicHz4pU2pS2scTCvf1Lc+nPY?=
 =?us-ascii?Q?hrKAhDvozVghfvmMCKosvHLuaOLoz2UOTeMccBCsT9gaUtbFdSbsZmPvZ6QS?=
 =?us-ascii?Q?BeMvy4XVIMdMMSFBS2KZlHJ7ve+Rm3q8ngWmp+HG/v7ytP1dnTbFJQqu3AEH?=
 =?us-ascii?Q?tXOd4rxhB0FFX806ue7hcX5AL0Gy/gLMoRqjvv9MgN6Gx2GT/uC/lgmLGHsl?=
 =?us-ascii?Q?w4ISyCgjD6ZYky4aa1+g1i8Cb8FxfhwJlnuyv9UxI68sElHBev6gQEyePkKp?=
 =?us-ascii?Q?VYWOIrwP3QiKvaBSnUhJLJflbPDpBygSP/vnOPG/HL/Ax4jxkG2aLjPau5Dp?=
 =?us-ascii?Q?gEDOB7V5sBxIzhZJKb5byg/HwYEJkYW0MVTYDcec51wxVpCf3ArXyqAhMpTz?=
 =?us-ascii?Q?sDVhX8icTBeyiCFeA+ZNyodPC7q561P/lqxW5YKjpF1HP6SsDaY5mucCMa4Y?=
 =?us-ascii?Q?5RFpeh4y4gxF/+t+9oYaHnKlkPdtRXMu52hWEYtYx0PNezKB6FiAI6ZYwTSw?=
 =?us-ascii?Q?7lzRZThSL+ibEmE1xpKDcN2AGhAZrx66Y5S4u0N0hrkCLrLNG8GMxGghRPEv?=
 =?us-ascii?Q?6Q7GJEiBN2wsJ6elcVeclIKrGtpn+BCDUCrG9CaxXt6AA5GgdA5JtWYhlXBF?=
 =?us-ascii?Q?yHUJr0f1+KC4YLZdHjsj7SxMvTAJGNv87yp6xtDYWmzw0evtF6vFqp/SlDJc?=
 =?us-ascii?Q?1PKUkmBkP56dAk297BlhZIcKyZ+kE9DOvHB8Vb6Q20FwlB17K5qbz8ZOY44k?=
 =?us-ascii?Q?66wfzZZMnSvFfGxg3z229xyG9pqsGgS9dHW0VjGVTMA13sOkRXQWjmV9czST?=
 =?us-ascii?Q?EbzmM2RfsdCBAW7j+Q6NMrK2BmQhUMjbBpZRHnYYlP7jvv5apMUL/WbMieDG?=
 =?us-ascii?Q?gdD+GD058R7gRDk43UbYaHTzVsTL0F7xOV/TVZdK96ksDmwmpAIJlqFKA3L5?=
 =?us-ascii?Q?2S7ZfeJKRWuYj02lGtv7xmFfLdBSbkQZozjhmFRKNNeIjlb9FWOtch0sKrO2?=
 =?us-ascii?Q?mcqgw/JaNd76WIfSUO3yVEsfMEicH9P9fU26v597IhHGTpuI46NgCZSiyXec?=
 =?us-ascii?Q?IikBRPxEMbl00vfn/Jf4LscE7BSH+UtiHCQUQUR9wmC4O4EFDT9Fr/IleoQF?=
 =?us-ascii?Q?slxNmmHpT/oBbyB92XjE1QaT7fWIeONRgbBt5zr7WbV5bLlYvbWYj7ff/nq0?=
 =?us-ascii?Q?+u/qffU1vb3JW+sBsy8QzZOKnmzFWIE9TcC+XS9ZDhAMun/K+LCp2kON1bzR?=
 =?us-ascii?Q?WldGeiw9YTvzPqE7v5meYFoS9iFjNV9x?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n8bbJdWFgYvHUbrK/IqFJB6cK1omGJzQy9Zdcbm+6nJBPw3mEwrEiF6l+Ndl?=
 =?us-ascii?Q?vApDGR+io/b+6fhybMQahUhi+HHEdMMRoyNw2bmzipriFuWyhLySjBk3MgOK?=
 =?us-ascii?Q?Tmd7MGpSTY5ikWPnR3GyP5Q9+Wc7sIR3dSl2bFmMkstJkWOL0bkDSUTx6Kcg?=
 =?us-ascii?Q?6SLcOc5qcv+Tekbnn4YlpOpRs1YXK66xZzWsS64byei2Zc4Ewqt1jpzB2idZ?=
 =?us-ascii?Q?UGrn0kfM89trxppMP/3e59bat9R6IlgaczV9ZGuaORJxt4sSt61U24QLCLfq?=
 =?us-ascii?Q?MA9C8kfjxgpeH5Ri/j5nu3DD5WEVr3N7iMtEwU5vApC1oBJL+/XSqE3AP+YV?=
 =?us-ascii?Q?uy72ADJyQmqJcuM3/LWNolr9m/t3dfFnPiMAPgVGgHruewUXGa6QfmE3dxKw?=
 =?us-ascii?Q?MyODywbAEBeyxMNH2Qt2O5Mujf1wv0/qM8F3nenZe61j+t0HFdeWIz/BkKtw?=
 =?us-ascii?Q?MoJGAhIwv71UE4a47bugJgh93OsJL2HGQkMImKj7UsufevWM7TBp4l7SND82?=
 =?us-ascii?Q?n8efVz1OeijWoYtgivXUehanKBkoGq/wowuEV0ve6TclDfztJheqpx+gOGyV?=
 =?us-ascii?Q?TGvkXDGkFg2ukvce7H6hdhqowVDMzwexaf+09f/Wtg9TGmbYFJBLc31gt6sB?=
 =?us-ascii?Q?4iIougfo/jzySSRbYzjslLf+1XQJI+3gQfHn9nQNbByCnf+d22zi6XgC7qX3?=
 =?us-ascii?Q?Kjqhl6MxNA3Y6DSV8Y82v2MYT/KbmueTY1UtoJKJIbDYyOEv03i5FfnVg38b?=
 =?us-ascii?Q?WKX+8q09VQohQTuyiFU2vpS0FOJG8VNKV94ERsEotJIc47KQA1Ln3YJDnH4N?=
 =?us-ascii?Q?+OeQjGvtzNy1q2I2/2U8FYXMX2YkZkv/RwFB2UkkGp93f9vuKycrx+D5UJi9?=
 =?us-ascii?Q?N23iMXRrq3Nv6lyPviGDXkrMIa8h2SWFa7pKMu+MVq1ja9yehtlQp5wPhzqS?=
 =?us-ascii?Q?IrhHmwRifipoMTrQ481e6Fcsc6wGx3EUOaDRgWxjIHKWu9n7rWig8zqOSONH?=
 =?us-ascii?Q?KzA90BvYe2x/U9CE7MEDelAHXmKN+irerkEO/1P12+Q0Qtg42IwBafkizuXr?=
 =?us-ascii?Q?hOlDCDYr8n3a3seZ4a4t1qTCQIjQKNzudClDuXEDRD08uZ/rCSbW+N+Dr3dK?=
 =?us-ascii?Q?IpegVPVXRoDtwq1TQxbgtPCaU2fFm9phLKEg51GqHPvAqFfhjPYzQvm9Cpmj?=
 =?us-ascii?Q?2HanYUAPKa2iVT59YqoWRtpwx4B6bYS0mmzSWz17j7Ol0E9lkCqvUAChYeze?=
 =?us-ascii?Q?8njXAEFEFtjexAwKdV+JVLB1G0xLXet3Vt6CVSeVaxe1Ll3MzMkdvk6RzLnJ?=
 =?us-ascii?Q?bTwYgd0isvYnHlegWd8G5AAqCy4BaLlPCrPTLf932ejVKCtPgQtn3EFn2zgk?=
 =?us-ascii?Q?7RFp66oTP4xFj2Q327dwVr1vGBTw0plNZYU9kBzCd9orLVB0IzjxpFCiVLCC?=
 =?us-ascii?Q?gnt+/aRSGT/omeJyzkqiM7kAssymiBNLW5uwhERCqMiGufFqxQz4dQfrULGi?=
 =?us-ascii?Q?ECQH6uJ4sQLWKa21ilZVjVW/60gcFiVvZfYGDkmwQsNzmWucMcKi56UJu+g3?=
 =?us-ascii?Q?PBNwpjAYt/VomckjPIYsT/51fa9fSKPPBrKVX/h4JWAaiFcLbm9XHsKl1PVc?=
 =?us-ascii?Q?PLbpEfpi9396b8Va5UrI7EU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ccc874-4723-49ea-3bdf-08dd70443831
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:26.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTIo/cg+pqouutGvfm795xY6IOB/YjjOMvznthkstziIsSvp5e1HoGygqnhiBftKDqZF0SCwTXt+FHp0+Lno+V3tXwwAlM4RwrEtA89lpD9++U0CiS/TaoXkPPeduzZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18434

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fb73d663b31398aea8528fb231e660c4958b29ff upstream.

Add documentation for the pin controller found on the Renesas RZ/V2H(P)
(R9A09G057) SoC.  The RZ/V2H PFC varies slightly compared to the RZ/G2L
family:
  - Additional bits need to be set during pinmuxing,
  - The GPIO pin count is different.

Hence, a SoC-specific compatible string, 'renesas,r9a09g057-pinctrl', is
added for the RZ/V2H(P) SoC.

Also, add the 'renesas,output-impedance' property.  The drive strength
settings on RZ/V2H(P) depend on the different power rails coming out from
the PMIC (connected via I2C).  These power rails (required for drive
strength) can be 1.2V, 1.8V, or 3.3V.

Pins are grouped into 4 groups:

Group 1: Impedance
  - 150/75/38/25 ohms (at 3.3V)
  - 130/65/33/22 ohms (at 1.8V)

Group 2: Impedance
  - 50/40/33/25 ohms (at 1.8V)

Group 3: Impedance
  - 150/75/37.5/25 ohms (at 3.3V)
  - 130/65/33/22 ohms (at 1.8V)

Group 4: Impedance
  - 110/55/30/20 ohms (at 1.8V)
  - 150/75/38/25 ohms (at 1.2V)

The 'renesas,output-impedance' property, as documented, can be
[0, 1, 2, 3], these correspond to register bit values that can
be set in the PFC_IOLH_mn register, which adjusts the drive
strength value and is pin-dependent.

As power rail information may not be available very early in the boot
process, the 'renesas,output-impedance' property is added instead of
reusing the 'output-impedance-ohms' property.

Also, allow bias-disable, bias-pull-down and bias-pull-up properties
as these can be used to configure the pins.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20240606085133.632307-1-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index 56d90c8e1fa3f..dda91d0a5cb9f 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -148,6 +148,20 @@ allOf:
         resets:
           minItems: 3
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-pinctrl
+    then:
+      properties:
+        resets:
+          maxItems: 2
+    else:
+      properties:
+        resets:
+          minItems: 3
+
 required:
   - compatible
   - reg
--=20
2.43.0


