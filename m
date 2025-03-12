Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFA6C3DA4A
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:36 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.62])
 by mx.groups.io with SMTP id smtpd.web10.34511.1741778854581734517
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=a0dHHk1z;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rj0jWYjvK9Jrcl3eHPH3TyrI2GbzuoXls4oBqIMHRYeRGLOr5+6Wesnz8+Nj2sCCEYEhdVAIDGaYMz/YAWtJpX2jjg98yZUcVhIndIsiTOuW2n//GFTh49dPlyFtaO9TEj4rKX7GLZoO/fEOqfi1+YB4jJjCl+fee4i2WKqzz7X9uvIzJ+xveaezCjVQz57eu5zH6kB2h0uNhCc1lo7G2K/15vnVKad9TpHDJI12LIjpA58FewDmYCZpW86DH+3LVj4Lus8Ol9FvL+e2JCDTt/lgYb4yWkgq6i2Ce5VcxcGcYpG0R0eMBWhgO4XBaTwMw+qzmnCVAjHQxY9csID3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUnKH0hgNjov/pPM2C3aLIw405qcL3gUMifYFIrOEdM=;
 b=CW1f/lsTefYOaPB9KNQrxGG8TFpb453Ret+phoBnjHBh31H1Rju1MIqzGYsFBMJsvJH3L2B0YD1Yea2db5YkKhYX8Kjnl2cSRMHf08+2aTK7IoeuJiORJCWDmU2x0wHJAeR8e+ECwGIpRzZzriRKt8HCH1x2Wg0lCoEdrZoxra+ZsIUffuzsUTDIkmKglmsKTFCULbyb256KwOMypsXViAaOcoJu5RdC04QBrj8nIhVTgR4Z2F6ylrSS2BzH80B+KuRMQe1EDP3cb1ApTdx0+QlFgBqwh1fLhaYrWbvMWR6lQTeQzPJfN7nL0naS3jW5rMGwDZgBXpyQkIYSyvD5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUnKH0hgNjov/pPM2C3aLIw405qcL3gUMifYFIrOEdM=;
 b=a0dHHk1z7GuCOlHNwPvaF6MNNz5rRJgJFnH6ymf7c/KJrtAJ51ptRj1RC+zqO7DwSsS1we+mT6b/x4mtt9K9Pd0k+Z/kucwtR7QMpCFIWs1IdI0cZcR+rfHgWrrfKqYzFgk+S+yj4qYdjd0mJX5/4u7UwAR1Qkkepv+ZSklLloc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB14981.jpnprd01.prod.outlook.com (2603:1096:604:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:32 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 81/85] dt-bindings: i2c: renesas,riic: Document the R9A09G047 support
Date: Wed, 12 Mar 2025 12:22:58 +0100
Message-ID: <20250312112302.1605750-82-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB14981:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc26b94-7fcf-4142-a1d2-08dd6158e1aa
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DOIyQA16Qj40iFNdbjt0OV+fzgDDfiDUInIrdnWeyuDtYUWe3Kb98o0qDK4a?=
 =?us-ascii?Q?cH+pob9tffA81Ct4VV+24Ax2IoKOsQmAkPbEhP7u5ZwwdboNyO8YwAxMZdlq?=
 =?us-ascii?Q?Gu4mRvSTcKYUbXj78m1FQ1Ddq8Z9rwO2smLZ9s/mbJ7Q00klMQAyIuAAZZSr?=
 =?us-ascii?Q?tBWcabA4hpOzFSiQ2bOAVuUub8R1s5WKm50H7jqhaKk6JdRG1NTjF4Jawl23?=
 =?us-ascii?Q?KGlCL7lPSplNv0QHFdxtwCKFCorid3zBQIlikbKg5IsHxfFwGfgvV4cNc5nY?=
 =?us-ascii?Q?eEU83MEgc/1+iDr8kdSAnauU60dgBiLGHdSGz9RBKt98y+HnAOQ2+YhQRDNF?=
 =?us-ascii?Q?2u/4d++C67YPjViFLeFI/WrvzLch5zH9FzzdFk+DWZUJdJPvPAdmpW6Guocv?=
 =?us-ascii?Q?mKKw0uFAEw3yslwn4V0C6/v71iW85yNvCViCIfM/rvCkA6zbVWeGOFLRzSr4?=
 =?us-ascii?Q?V4LXV8B+YuhN7iAPnMH4y90p85weLl5cCJHb18WS9yzPkBeEV4mYHxLucsDN?=
 =?us-ascii?Q?f/T5Nu+pS7E729+5XYGguztuxDSR+spGKzi0c90PXakjAfl3BMFfqYCUrHM+?=
 =?us-ascii?Q?cclLHgrXprJH+FEvi22NlWI09sQX8u3cm1Nwt5UZ5xe9zdiXKf3ULzvV5mda?=
 =?us-ascii?Q?cG9dYyaQucnKoBZ7qwWsCzZ2/pQKAKCerJ65lcqy719KAyIo95wMxj7KaXF6?=
 =?us-ascii?Q?M2aS2MrfkqjW53K6ZMjMlLX+V4AF8XPYllJEiS4fKttIT7SFKcYISZ15kIs6?=
 =?us-ascii?Q?LjBDGDyxpylKqeXFO+gIB2bW9ZGsUtx/BZyvF4Wk011uM9d5StqyTawfkACQ?=
 =?us-ascii?Q?FmsGP8kajm7SQ14dZAuG+RkYonPmTDYrtc6YAu47AfPhaD9Mdd0BZWPS2ON3?=
 =?us-ascii?Q?nq9CYjiF7h9JCioBv14ZFQqDF7N9uBWQ5ufRS9I9+/PgTboahLuKf3InYkIC?=
 =?us-ascii?Q?/RF/wv0ZmTHA95YiCKscjfUgqtSf6gudMv74KSlENzxvM9L1U1hPLXoIUcJz?=
 =?us-ascii?Q?vT9i1t8h01z4r5aZHhTflIGfiA03CxoUV3a/JUI9HAjLKZfJep3oM9SzCeLm?=
 =?us-ascii?Q?920jRyXcEHKLbulL+oPZxk5du0BqTjj/IYJ17IObQTJVwzVXjQHcOIUYNh5R?=
 =?us-ascii?Q?0i+THInf2FbXcHWPkzV2HRgbOwbuX7OHZOz/nE63nuFocQ+yFfdBZkI+QtA7?=
 =?us-ascii?Q?jEY9pdi3ZmQzmt4o6jdvYIvhAC8Hwa1e0uF6OSGhM+ZS36ieo3Az+LGLIAUq?=
 =?us-ascii?Q?y6NF3S+iGvcnJxKjbfGtkUoLBboAeHGM3FYkvE7+Dc1a/cLDPfx9o7yLdMgI?=
 =?us-ascii?Q?KH9QCkEsCvrhqNshKeTpqQCy3cx03Q0UDUCXrrfmmaK1gaLr8KXINnZHbNki?=
 =?us-ascii?Q?aPs2daU/4vsexwg2rhiMoWhUCcsSTls+29+tUVPVA2oLEjtxnWGNgu6olVUL?=
 =?us-ascii?Q?nLijx+qYJWY7D+Ggailgkzp01IazKuVN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6YJRoMf96RJTuTp01mqDhUt4Us8O6q4s0aBK9spybIhY/aExEkgZsOAo2Wr9?=
 =?us-ascii?Q?b19U1i7slz4Fq8gABKZEYh0hhyPWceIVKqe4eYIbQ4EUX68j4YcBcmxKmlBp?=
 =?us-ascii?Q?LFzo8CVJRIATrfxxllHwd3HX3S2nOIYg5qbk5uuO09DZGp87kPPYeMtNyhVu?=
 =?us-ascii?Q?S0ygwF9JECAC3/nErRuKPW/i0LmifYlnWsVruvRAk3cnvaNF4LnZNR1l1EbJ?=
 =?us-ascii?Q?7SE/SfASGvkv2vfdoNfixDiaZ+lJ4zachyCo13OosHgtbGug9rtEwcbqssT8?=
 =?us-ascii?Q?H8cSZ3eYLqDx3A8VqknIWotGkCNbDhzX8hlduHs1LetvxVs+6Yd0P5IFTBB1?=
 =?us-ascii?Q?CBDRc9keCYeAsnJt13Zm9XSiC6kc781hxriYcqyuGSLnGKPBmH3KEOvozyn4?=
 =?us-ascii?Q?7hVuGxkgZMKzzPfpNRlNlaIztOP58mA5QKcdEvMU0dxpev8YURibo7nwMRzW?=
 =?us-ascii?Q?x+ebeEVNbLRzSg7KIWO1wjzeEboLOGCDW8lu3erewqmWLjB8oZihy54cNuet?=
 =?us-ascii?Q?BhAxorVdAavnxx0FRBUkENxRJSkxNQW7hZTROYUo/OkjXaHsaM8LYP5bzOy1?=
 =?us-ascii?Q?qagk38VwhTRWrF/D35R/sUlgmhQMT/ewglTtWtpocs0pmz6HZVKJkULypnYC?=
 =?us-ascii?Q?9hgZU2HOQ0uWON08Z9HLjI+g+dRqu4yQvFSYi/ocC9RYscH7+v3FftHiPshR?=
 =?us-ascii?Q?ftVD8+y7OaxU4rkK6KBsJyGbRAwrua9HdlmaJg3iyJkm2/6HXqUkX6ASCgCR?=
 =?us-ascii?Q?/u4kT40Kwqi1ccEWqg0+K1KG5aHcpiDATUJ88eOeTNGz6gJLBBYfh3RWXqF5?=
 =?us-ascii?Q?7XJmY3pGkKCjzG3idKRg5GyrAeJrE/F29CsOTZ/6eZxu6Ptd0V8OazdG+lSB?=
 =?us-ascii?Q?S6lr7VT74OdYccWOrA/+dGS7+GGm6axJ3KGvZymBnqaEpvPXHVAWcYnYqwCD?=
 =?us-ascii?Q?QPQFEYgwq9xgbIVqbD+Lz6qKLIbEx62ZEIg8gtN0s6csLT8NT7OeYlPdL80Z?=
 =?us-ascii?Q?dKT/kdWgeggcqKR19YZ81YfYHKPz+/ZHN3+xjLHcv5S+5avuG7KW/VkU3eIV?=
 =?us-ascii?Q?sEgPtfiaO6FZhafIWgQQhnOKO6WZUdCO55zBNWelaioBgRTl2Z+uFsC5oUqn?=
 =?us-ascii?Q?qS+f4sZpLU7x0JuHHD5/w/18D25DyoVzhoHyT5NNkzmZuK822VYIFvX3Ybiz?=
 =?us-ascii?Q?2U4St387JcPh6ZBgdzZsW5+3hIw4+w1nnxgtZiC9KyBrqE0XDX79mkgsRfbQ?=
 =?us-ascii?Q?02b4KNrYthTd/Vx9+kAM/mqxpba1a57y0syJC6kUXr2n0vXG13LAh4JbPMqO?=
 =?us-ascii?Q?7FzOm5ZWqJRfTMDAAMdiExJAKfeXIvmw03eplaFUw54tWlck6etn/Qz5FZRW?=
 =?us-ascii?Q?VuDRpFAjGhoWZhLVy+nrziqLEHf+3MSfrPEUOlMZ8zDejNRPPDQ9YmVRT/40?=
 =?us-ascii?Q?1tiOfeeG5E4BhAPt27bGbKXuHqKz4+QMngGlbwZpO2E0xNopu7qQCfjUbLsp?=
 =?us-ascii?Q?Soj/DmHUmGEM0LH4In+TtU5ApvlOnd9URU3oN7Nq+J0mtMftD62w504GLcua?=
 =?us-ascii?Q?kIv/8Y9cBXFcu8aFO5C3pZK2MXnlZRXvOv5HvA+sAaWcCA5GrH1Z/latXlnp?=
 =?us-ascii?Q?c9ohfURpNUtScDz9osGl9Ng=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc26b94-7fcf-4142-a1d2-08dd6158e1aa
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:32.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaHMWIj29Gb03OL1NcTLoVUwHQXOSTZLUuz4P/CTVOudmofBL+jpWsqj/Fbu7noI6NH3at6o4RBt3EIJIUUqby69twks+S9D7ruRjWTegqGVddf54Ab/6AkFd99J314+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18173

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 567ef9035f820ecd3e6fcc142003f396848b31f7 upstream.

Document support for the I2C Bus Interface (RIIC) found in the Renesas
RZ/G3E (R9A09G047) SoC. This IP is compatible with Renesas RZ/V2H
(R9A09G057) RIIC IP.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20241216202436.185773-1-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Docu=
mentation/devicetree/bindings/i2c/renesas,riic.yaml
index 60578c3ad4b9..7656c6d8ded1 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -26,7 +26,9 @@ properties:
           - const: renesas,riic-rz      # RZ/A or RZ/G2L
=20
       - items:
-          - const: renesas,riic-r9a08g045   # RZ/G3S
+          - enum:
+              - renesas,riic-r9a08g045   # RZ/G3S
+              - renesas,riic-r9a09g047   # RZ/G3E
           - const: renesas,riic-r9a09g057   # RZ/V2H(P)
=20
       - const: renesas,riic-r9a09g057   # RZ/V2H(P)
@@ -89,6 +91,7 @@ if:
           - renesas,riic-r9a07g043
           - renesas,riic-r9a07g044
           - renesas,riic-r9a07g054
+          - renesas,riic-r9a09g057
 then:
   required:
     - resets
--=20
2.43.0


