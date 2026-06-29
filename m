Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12280C44503
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:53:54 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9686.1782773623788839784
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=A/Vp6GP7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.16, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxz7wZ+zAVQxJoE7MsUiWm/LRrWtU3HiDaRN/JhyFHv07XVT9d0KzYYVHrLkpa1O/ogIKGH3wRRLW9QZs07JeEEYiUVoSa7BFXp++YBoGYDBCqJDEDOwvySX8khEsV4WGYMqgOmDxRzsFQ7EqokHqCbpmSha25nJD60EPzCLMEeavNGa8USGWEvwOceHHtQp2PrpvB+OtUALSh+q7DXn1M8LcqNlCMBzZwGfNNrYaXc3+NdSoWoechr5oJK/oqqT4k0ae1IpMqxbeKF6Vwijeo4SWjVzwRG2WIJHjW/rApa7eVKb9jYAlTfgPQlbyH3PJxuyJ66OWeb1CBdDY3/DCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeKtxk+70gf4e2y5g6DBmdQ7Mqxbh7LJZPWcy5UIE9g=;
 b=YLMdT14Kd/75fRFwINkz73pCUKXlcyo7X35dlcHn3MuTe8U1eKUkZGOce2r9PZvhsJtw821ydmHWGUU5oMZ8RhozhhGLMS6D/YL5/NZW/CHvjDJmNpFkYb11IEpSlzTi/8cuSi4e39QH5Wj+npV98HIxSduL1gKOF7ZmmjFzNKXS/8F7Q/gyejwNj5BCEcrrsIZOfnI9FN831zAFTgFjsaeCCwq0jBWhl0U6AdQUC/nnArLQ3ORoM6+P4E8o2UR0vxWtTFjVDCHdSJBPDh5rhGzmSFMQ+MDQNf8NgxMa1aWxod6M28GY6td9yZXuFGTEDVAL42kp5gNPqezvzwgfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeKtxk+70gf4e2y5g6DBmdQ7Mqxbh7LJZPWcy5UIE9g=;
 b=A/Vp6GP70vYUSz94lkQJiFfk0Y82p9FXEpgr5DwdxncyK7dQ1r7uR9Hme1pjR103Csxu0zgFXTTbZ9vW3E68+W0n9HuxjNYCGuKBM6wEwQR1rhoA/pg+cFz6YotRGMCbihXOTDULl0oq/nD3OYbYrPBTHVE2rDkkXI3Auz3v2gY=
Received: from TY4P301CA0002.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:26f::15)
 by OSCPR01MB13102.jpnprd01.prod.outlook.com (2603:1096:604:335::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:37 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26f:cafe::15) by TY4P301CA0002.outlook.office365.com
 (2603:1096:405:26f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:37 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4F1B03000256;
	Tue, 30 Jun 2026 07:53:36 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/11] bitfield: Add non-constant field_{prep,get}() helpers
Date: Mon, 29 Jun 2026 23:53:22 +0100
Message-ID: <20260629225331.10023-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|OSCPR01MB13102:EE_
X-MS-Office365-Filtering-Correlation-Id: add0cb37-4872-4e98-11b7-08ded63141b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|9063799003|6133799003|3023799007|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	IJpAcvM4l94gtdV1QpWhk2CYVpTLx2SLE/5k2d06ydQnxm+3PKFRsQ2c7zGUw4EmJDltwH75ai2297HdM5da0UGxrDH6Y4XZUTSWuOOJtkYmlH8k34QjGbcZhSeZQ7QWtxlorHTYB0uIBWex5zJeWOvhK+EjS+WYxDNZcqAyl19z/Ut6a3u+OVGp8nEt5/feSWrPsEIeb+biuG3TUv0xmq/QkWwYKJRehOWJs2ip/eIriNrV9MfTqwioDV7EJU/05hTsVxlvqwJHsm+r+dKRj6vOYF2dsNmwdzF1L3ojYylek32K6WDSRi02ubDIvI0c51D2jKuS8Zq2g6X1NaeiqmWJIkWBlQbsmtXC4z7uMKS8hCRRTA+vdvJMDlWGgTHMl/5a7BkofLSCZepbgMmyjAmCoViWP21KEqXXSk0Gmtl/VMWYhN/jt+TcttHf4flEpU5o1gKsNVlKIvGXlVf7wvcfIb+LgnFLc2pz+51w37Zk1ipZhf4AeiNqPWC9FVKpEtlzfp8u/qxiTrU2/wIBcJaZ3NiawknAIWC9w8S6614T9VM5EWXTcga19JskY5dr7roDC7B05N8rzwUfuIATgC7fhTNLFCPXM8D1Chn73gPuxxMw18ENUPi87cMXQlHDzhMrcKWxKIOXHZ/JMsKRfPB5JEjlx4sle0McGdSi+tjKWYwjWflqO8E/Uq+k7Y2MJZkJ4rR1NXTxqXrlzftm1A==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(9063799003)(6133799003)(3023799007)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	0MngxG6c67KwqqVfpzy93sU1b1bH67Z+uAT6vwMirSTUXVyGz+Yq33GYzx93bah92ODA8GA+c49seN+WITw88rHXqBCxvg3tesODwdPQjdX6/zLIiYszcFS8HQM0BOP1oHDE/OMkBt9zAHMKpjAQX0O9KnQF2DhS522kbEHi36UCGVJH8qwLiAtqsipC5suGwl/fXAUSVooFRdoZ6Y5qHcpsBpg9SNSSPAB+80coasG7WdSgtGh/yLqULhzFuHhr1ykw7owQuuqmvOVmfCnZqZUwDmk+dPFbsXghFu0o44O9PLnYBouBy4A57vM5Y5BSjqv+SwDK6RBv2VpyUAEUw3e2advE5J6I1YKvzW/5y5aRx4IsEZeyh+tM+tQwetGVTOHS3pdJRL/OUiT9b3Y5M6i4Oco/2ZR8/WAGeN+n3vWxF7cs6a+pY65HhMGO5w6u
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:37.6482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add0cb37-4872-4e98-11b7-08ded63141b0
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13102
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:53:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23310

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c1c6ab80b25c8db1e2ef5ae3ac8075d2c242ae13 upstream.

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant.

To avoid this limitation, the AT91 clock driver and several other
drivers already have their own non-const field_{prep,get}() macros.
Make them available for general use by adding them to
<linux/bitfield.h>, and improve them slightly:
  1. Avoid evaluating macro parameters more than once,
  2. Replace "ffs() - 1" by "__ffs()",
  3. Support 64-bit use on 32-bit architectures,
  4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
     actually constant.

This is deliberately not merged into the existing FIELD_{GET,PREP}()
macros, as people expressed the desire to keep stricter variants for
increased safety, or for performance critical paths.

Yury: use __mask withing new macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Crt Mori <cmo@melexis.com>
Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Acked-by: Richard Genoud <richard.genoud@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/linux/bitfield.h | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 3346c6009c2ce..22bbef382bb9c 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -17,6 +17,7 @@
  * FIELD_{GET,PREP} macros take as first parameter shifted mask
  * from which they extract the base mask and shift amount.
  * Mask must be a compilation time constant.
+ * field_{get,prep} are variants that take a non-const mask.
  *
  * Example:
  *
@@ -240,4 +241,62 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
=20
+#define __field_prep(mask, val)						\
+	({								\
+		__auto_type __mask =3D (mask);				\
+		typeof(__mask) __val =3D (val);				\
+		unsigned int __shift =3D BITS_PER_TYPE(__mask) <=3D 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__val << __shift) & __mask;				\
+	})
+
+#define __field_get(mask, reg)						\
+	({								\
+		__auto_type __mask =3D (mask);				\
+		typeof(__mask) __reg =3D  (reg);				\
+		unsigned int __shift =3D BITS_PER_TYPE(__mask) <=3D 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__reg & __mask) >> __shift;				\
+	})
+
+/**
+ * field_prep() - prepare a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @val:  value to put in the field
+ *
+ * Return: field value masked and shifted to its final destination
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_PREP() directly instead.
+ */
+#define field_prep(mask, val)						\
+	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
+				    : __field_prep(mask, val))
+
+/**
+ * field_get() - extract a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @reg:  value of entire bitfield
+ *
+ * Return: extracted field value
+ *
+ * field_get() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_GET() directly instead.
+ */
+#define field_get(mask, reg)						\
+	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
+				    : __field_get(mask, reg))
+
 #endif
--=20
2.43.0


