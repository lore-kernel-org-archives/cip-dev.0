Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0BBC77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:22 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.25])
 by mx.groups.io with SMTP id smtpd.web11.366.1750690033414325324
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hmxpG5r4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2sxiMTgWobuFt1No1xU904mDYg81dJt9RVq5OectjrlIkBbB8XqnF7PXIkOWl98KWhpp955eVmn3De3E1U1wm/e6z5JFvmH5Kt+dmIPOGuRoSLao2lGqnkPmcGfSbeDP6NBkPPzPcjm+ZrkMTmb/j9WHDOiG5acIzImUbWktnaCNVRNitcXV75P8JPMCDZ2OkP28UiImtR5m3NLuehMOD1yK3d1li2HYcTYq8p7RKQ1udhLMPYuLNbHmA8qIdG10soLW5lcxL4ogTAu24C/w7q7Txz9laopf4/dtl0VndmgM9thHTD+pns6x77OMOWir0HtGPi5tHFgHZFuoOpu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXOe4TnCCcS2Q/c4+6iSbhKYHGnO8WY2pm4iO3z4K8g=;
 b=y3vB/tstxGxfVgti+Dn4G+cJJuByHqpuqwlf3G4yWRGIrl6vXmkAikzlH/bcRWYrL38/HPIZ2ZKIs4523QkNqRB9tERIZiKPz1LxrEggPmw8LgcavwrbQtRgwhEBZ4wsV19n4bH+UHlFu9evwkWkVBopQ5zQIWZC2h60wg7/1T/mH8psc5JESd30TRx45esW0Bx0H1Cd3appVRLY3Wkzy7XnL22SbOg3tQM8Pg/6gVHjfPsmqXMAgg2OXPXRvRfhF7HinP/fLpFWsEdSaQzkcYYL2+qhhBxCxqkiEryLS1taDJ3hyT3V4Q3nIA8G8abkhdSCY9MDV2WA4YtA24BEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXOe4TnCCcS2Q/c4+6iSbhKYHGnO8WY2pm4iO3z4K8g=;
 b=hmxpG5r4I4eCMYGoLrsNGCEycujQuf9F5dQ+pbzM+J/NJgSsF7TM54FF4gFUkp17aXWCLt4/C4Oc3mzHoyYf7ZVh02jLvlGyU/f7Zz/irNS/Sj74qqTo+z6nkj8VWB5CiOPWruysU8bOiyrnWqAz9h0rS/Ajx0Dl4Py2LEadknw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:12 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:12 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/17] dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
Date: Mon, 23 Jun 2025 16:46:24 +0200
Message-ID: <20250623144639.2119707-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a98cd5-84b0-485a-8dc6-08ddb264d658
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hblDlBBbxV6AuI1uFVzpY+s31oJuJAczMa/YvVHGistu7G7Sj3jARxjG8bSO?=
 =?us-ascii?Q?N5MqIKICbZKoLpPTOpfWO1y7V+t7yoNj1MTZoO9hz5iYWbAr3E8ITum4b+60?=
 =?us-ascii?Q?/DpBNbO6mFelbIWNrZ1Smqm9ASdJ/cFRhaBkCgREyMqEUFviNjnPjFEJ1Uu6?=
 =?us-ascii?Q?K2oH6p+/PUU3uwG/cKZB5ysLFhWO9R89KzTA9OuTcs3TipbXHi9l3NfZ5GJ4?=
 =?us-ascii?Q?QfANde8e39AviTr3ghwR2zOr4PJhpDPtFic+v9Vm8GRrAXBkhIfNmjiYVdrK?=
 =?us-ascii?Q?68KpE1WJsP+0/zkFny0rvX+l5Hw2cMerKYwObKll9u/lYWKn/MzXM+r2ftGA?=
 =?us-ascii?Q?KWr20MpYtASR+8j6r9sOW2lv0rHM53N3jbjYhd2CAhqObexixOwcJo05agVK?=
 =?us-ascii?Q?q4Sb6z9HA/SXeiHzpvZ8AcA9CD+92g9pKJGFIOs/KLC6oqN9NtvuQui+Y+21?=
 =?us-ascii?Q?wpX48OTank/mj2t+E3mm/u9s1WHcHRxgYTrmJyonxS+kpQ7SRMFNk6JebBTq?=
 =?us-ascii?Q?bjb14M7Z09GaiqOpyt5E3muSJzfIsVk3rD8S0+qy2BCGd5Hr8wUCIiPsv2fi?=
 =?us-ascii?Q?2msbNNMUIVimK8FhlDkBnPjOO8nu/HjzTrf747wGil8OjbuKpcmR0tpLViLw?=
 =?us-ascii?Q?xU5/Hbk5SaluwvW8ilvygiyBKomUHZKi/ARqoTuCBzXzerhMaFWuQTHxMQOz?=
 =?us-ascii?Q?u7JHd/lZthZxAAAgIeWF/3EUmJYjkFmCmUo65GCPSPc2ofgoR5d2sAgsKnQB?=
 =?us-ascii?Q?So9l6O/Ro1KPfmOjSxjxubMbAnTVTaWdFmw3uF4ddZR6w1l789dmgJFNihw/?=
 =?us-ascii?Q?I4POY0vfQbyaKDGgObrow+th4MMp1h71jDpeY7HA/ec78qGzlM46ATjwmCRZ?=
 =?us-ascii?Q?cQ7RukRYHmDPCaBd2EBBUTbdxNNYp0+LWSr0Ccl2c+B6AAkCnvakUNpRnyB2?=
 =?us-ascii?Q?w5ZbxgqfB/uhwp8o60yU0NmBNeyjh79Fre0PKxcQwO5Lk7l5sI70l8z9/Ldy?=
 =?us-ascii?Q?3V8FuqIPoFYzrVoUs3pPaRgs5uJYQDLKok6vMCMzs1bbfhVn6h7Z8/Pjgw7a?=
 =?us-ascii?Q?21BLFtL3UY6/xDNc9GQV8HPmMBTDqpeHE8/faYDGXVZ0qlMnZsTUgfcfbaR/?=
 =?us-ascii?Q?mO9HFnTpMo9rd3yb9WmKGh8uk+79o8WC72yaHZ+VvsE1LleTor3ZbOTaOYey?=
 =?us-ascii?Q?XYgZBSF8ICcyTqK+oej6NRAnUC03Bb+3eWOEtNY2lnVqdvV3lelO7bzi5wxr?=
 =?us-ascii?Q?sM1S4mNcY6SzwbDWzxieQ2MkKNDyl2Lp9Hz6ksEwb12Qm0bZ4jdhPTdWSVnL?=
 =?us-ascii?Q?XOBYLGUCksdgvClwP1rBPqkecnWAtEDKbYiffBmvKAhtH1IV02RKGMkOO9/7?=
 =?us-ascii?Q?QmsgzvxcK5bwHt0oYH8v2ku8voHPMITbfN2XqUN04SXFIsOw5FFFNr79QZvy?=
 =?us-ascii?Q?xD4nYcYK/rCLe4gtn+cEaFQ1cu/ZmpMjQzlh+BOoeQj3YptlJeyp/A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kI7En3uoCtlMDZzJKBvUnxZw/cONrJwwwVSYjDmPlVXlHlZ92q+lvTD+LyVg?=
 =?us-ascii?Q?0m5QhrBsNml87t/ook+GzVrZusd8yVRYozrb75y/QM+NGkShgqECTD7V3LFM?=
 =?us-ascii?Q?esPSiDn+jI4/5fTa2IlBYWtp6hHE7lfFaH6PU838d2aOtAOKp7FsNKqqJBr1?=
 =?us-ascii?Q?DgklhCgyKoQb6M/AllZ+heFIU6K1HHMhHs24iQyPEQ8ouippddl33Jd72p3i?=
 =?us-ascii?Q?o1Vx1grv0LIYN0IVRoJ0D4dvQJAHNEC6U33aiyzUd1oYJtPX2JrnR8O9OrwC?=
 =?us-ascii?Q?hNATJXyIzrUYEh5xKppCfu19P8MS8nn95+mLzVnPe1Iz7+/LH7lnoNwAMUGD?=
 =?us-ascii?Q?8ng3EeG3Gr3WTlqHQamtCfO6BQKH05nBY67TzNpRckZNmcdq7eXB+Rr9N2ss?=
 =?us-ascii?Q?3TxCSNpJ78Q4O/whYOVK9sN72uEKhWCbay4wor1Q+KH7hcNaqZg0RVnobxjA?=
 =?us-ascii?Q?t9rvYjhm5+3VD1XJgwWTyVESbWZHsO3jLzWOUZjW3IXoV1nZpx3Xylc4njLQ?=
 =?us-ascii?Q?zq5zwlxvNedo+8zIYoYwV+GKhgtHz0BXK3F8XBaWasiPP8j2H8ejphLKD1nx?=
 =?us-ascii?Q?QDyEsV8JvnoFfH+hHKmrQxPIEGFaH209lBQ09VhK0PBzZTLfhssZXCfuihhQ?=
 =?us-ascii?Q?PFgp5kYAQEZwymGLI8E0raRy//56mY6SMsh8d9IEZ5zdsLCuMRWnh0mqbXZv?=
 =?us-ascii?Q?DDjW57isfTSTNG5o1FtkrrMHHvI+B77xZ7B1biVlG81ckeUk+ER6gl7IhSou?=
 =?us-ascii?Q?exE8IunWKeSPWP0aSAhjLSRbfA5+oOCmSPDJXTs2lFpKuwHz5XayMCWkkDiy?=
 =?us-ascii?Q?bpah3Bqpbl4EzwDrAQ0xCIomIO+kdEIRd4I8E+rrUxPP4X3B4x43SvJwEflH?=
 =?us-ascii?Q?FWQ/RGuzohYRb/Db4mm6KuOT3z1bvLy5SKsDWGWd2h3/MjhWSCDgWcXGS5tK?=
 =?us-ascii?Q?lAcBXBNB/j3hp/rQVImkdd8O3s1xNkugSnmaLCKqolF3j42hu0EdkwZkWtq+?=
 =?us-ascii?Q?nQWOGy408IQeYj/ULoX5p4A6ZB1jO+Xu3N6Vd0Zm5jjyfKJMz+8/9p1RFkg/?=
 =?us-ascii?Q?uLdQwDFmnlRlnvj5qq/l9GO6kP99o1NEQ2CtTlNcwpjAb/ISFZv601ytXoZL?=
 =?us-ascii?Q?3ssaEjh6ATQgZUntHb9IbKWTWWD1Pc8nBSW8QbOjRhX2VxLsPHQunaQQiE3v?=
 =?us-ascii?Q?0+Bx4RzJjmJOVqII1/fOV+wy3VmhG+XIcFUwLGSxR99xOc9N1YY+QHkLY+wk?=
 =?us-ascii?Q?JFTK9AYoY5cy8cqSoGv4Mq6zcCr8ZCRCK3DYHquqQG8O4wSG8Dv7RSxzjoSf?=
 =?us-ascii?Q?Mzu1VekqchC7K5UOzooLT72MzcFs8VwIBZXT/KYCmswLbOb5FYIaYDBKp998?=
 =?us-ascii?Q?cb6S8ClAQlb7Xe1Hm9XqZRW/TXAvgMvUaqfPrEqwpUtUrdEmIwY/v/6mZ/fS?=
 =?us-ascii?Q?5Ek7zPuFVNF6Ee8m/1oyYCnprc9pGd2i+G8ruV7cPLYWHR5Q6BMLxjjVC7TZ?=
 =?us-ascii?Q?d+kHhJE7DDxiEnP3wNdgwHdhIpAx4w1C+x4KmcERMkuUuHJURcpQvqYkUkYl?=
 =?us-ascii?Q?QXxTsUmZZWjeqwlH0n1qWp2qu/+5Y9vyu8+XSXS0Zsf3KeaylxWVC/MXX2pY?=
 =?us-ascii?Q?OkSIRlwpKF4czkDgA3aLMdw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a98cd5-84b0-485a-8dc6-08ddb264d658
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:12.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2LSFgPgyu3PnvoluMznbAM6owUlZAkD9KNzm7mx9bC8eocw3HvkXgjjQyj+lj5E4fiGc6acNmCiGwScKW1OsT9rz2Ml51Ous9kSbaSZMpUSSlv5pYq0+OEOootSGVSn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19189

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 93745285ad9ba11ef68922787e0f46da408ab0b7 upstream.

The SD/MMC block on the RZ/G3E ("R9A09G047") SoC is similar to that
of the RZ/V2H, but the SD0 channel has only dedicated pins, so we must
use SD_STATUS register to control voltage and power enable (internal
regulator), for non-fixed voltage (SD) MMC interface. However, it is
optional for fixed voltage MMC interface (eMMC).

For SD1 and SD2 channels, we can either use gpio regulator or internal
regulator (using SD_STATUS register) for voltage switching.

Document RZ/G3E SDHI IP support with optional internal regulator for
both RZ/G3E and RZ/V2H SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250305092958.21865-2-biju.das.jz@bp.renes=
as.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Docu=
mentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 653832d4f32b..d7473e99fbd2 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -66,6 +66,9 @@ properties:
               - renesas,sdhi-r9a08g045 # RZ/G3S
               - renesas,sdhi-r9a09g011 # RZ/V2M
           - const: renesas,rzg2l-sdhi
+      - items:
+          - const: renesas,sdhi-r9a09g047 # RZ/G3E
+          - const: renesas,sdhi-r9a09g057 # RZ/V2H(P)
=20
   reg:
     maxItems: 1
@@ -205,6 +208,19 @@ allOf:
         sectioned off to be run by a separate second clock source to allow
         the main core clock to be turned off to save power.
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,sdhi-r9a09g057
+    then:
+      properties:
+        vqmmc-regulator:
+          type: object
+          description: VQMMC SD regulator
+          $ref: /schemas/regulator/regulator.yaml#
+          unevaluatedProperties: false
+
 required:
   - compatible
   - reg
--=20
2.43.0


