Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DCFC83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:07:06 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.11])
 by mx.groups.io with SMTP id smtpd.web10.8402.1751620022272481267
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:07:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=s0GCHfOh;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.11, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygyFZ5qwtZg0iupGLcpb/UB5YjVhmCb+nnIQn/NwuzvKJ9kfoJtUuBZ2nKDj+NBqH3+Z0cxRnA6hi5vSxhZFhTkmOdIosq+nTfDqyp8asl3lnPzyrJjRO2D3XE4+aoUbz527l+gh2EexMA+Rr4oRNLGr1MQktJOk60R43sJ4sIKdCBe5oelj155IhKIbqVBdJuPx9cy75gkg19nXFgV87YDwBgRvvlqPEbM7HUud6o/0q3vKoWsBDwrEZRQg8M9YQaExv+NxA+NUTvoKJSjfww+EekXNxp2M6lPA/VqWCRjiJLtuxJjmtKkqAE0sr7tzdcuccw6wCqC/2XlfZqGDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo/f7gU7dUvbdrslV9Gqw5WHAK7JInU9zOIdiFBuBbk=;
 b=hujP1UemuPcZ4YFy2S3sgy0eRlI/tgsdrW7BajGtxHEQdmj0sF51u2DyzRuQ6k5qYjenEVJ/KEKjCVqNe6nMNYGXIoXdOdX7WJTyaaCi+ne2xJruK8n8pSrFPz7sQzHebM/RslpBub+BsqflZ8y0ZzmVunuZTM8yJ6zRbZIqPAqID2E8lZTuuIk0QdvmYEZmnkpjyg4uSlmz5zEjGHyx1j/Lt+6YqYKE+GAo/SmjG0VEcaLfpMVLd31EDE4DjdK9dlSNaBMgX6ogNpfJ13mNz+l1IR9jyrESE3tgIPcty6DSeh1byqoeDW85F5CpPv3nRisLn2DXXUB7k3wqDfKQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo/f7gU7dUvbdrslV9Gqw5WHAK7JInU9zOIdiFBuBbk=;
 b=s0GCHfOhwK0UfBpueEH1VgNoFhX0nV9AFfH9Ab3aa9ByA0+j6vuxsF79KbmyqC6LzLdgISPb5AHZWdBuU/yh2Kq1ISnp216l4+F/AESuamBwKfCJU2l7WbBJGn7hrePnc0j/DScGPoVd+SKGxHg8gqIR7AEhPGfMcBdcFUlw6Ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:58 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 14/14] arm64: dts: renesas: r9a09g047: Add ICU node
Date: Fri,  4 Jul 2025 11:05:56 +0200
Message-ID: <20250704090556.669652-15-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB13039:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd4beb7-a93d-4871-6762-08ddbada217d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?N56hXXeWrDMP9yetV8agKDWhREX4tXH7ryQWc+FPagGNU9bcfnMYEJFLJuSM?=
 =?us-ascii?Q?J6HfjDIHmtOlQK5cq2pp/LLCnvcR1PJ/RZq/jI4hvivCPdGm5Gaqa2XN0XkB?=
 =?us-ascii?Q?gMKVrt3F7eRLjCAsFeD9tAKzfxDlC60OJFCDWbQXF+FFhXhPAdFIjO6EeS0F?=
 =?us-ascii?Q?1IyzfXACiXXsXvR7SirYtyM14uUU+kV7kiOSg8DuyUdI8FOpqWAa9Jd4qpeF?=
 =?us-ascii?Q?+qEpysz81eGWE3HaDcBCk4p4ZyNZP/UxSzUlMY22UrkNlbXjz9dSfCXh1PVM?=
 =?us-ascii?Q?LLYxT405G1VXl5Ldtqwc19sG12Numl6oIb4e4CNAMsqkmJwMLcR3bVP0hBqp?=
 =?us-ascii?Q?vKp1S3aXiWoW3GFpxY0PHB73qDDVIWBq+3Kl/ra4at0b4sPvfXsJmAwA7hqM?=
 =?us-ascii?Q?LS4MZFmgvIy1dEGP22mBMjbBra/zp/OgvN5VdpDFm5YE7yMWAx531vvwshf/?=
 =?us-ascii?Q?CDRNVIsjPW8VeczB7SHpzNUGC8kkiuK++KoLN44JofIJ+pufOI7h9/u65UY4?=
 =?us-ascii?Q?aE/WLD59SJm4pRKheJ3dc7Dzt5snlg+cLsXGJJOcVTigioQuwPfy1Ns/0Jlg?=
 =?us-ascii?Q?lJ2+7xANJNVRIhPUGUl+jbB7YXCc2SIcZrKrjWM3TyiE8Q7xq8feOEUtvEEd?=
 =?us-ascii?Q?Iuze7pEkVIMflP3f7uOtvxI6SxNc97AgEAfItNshfkptxjkcDOkS/fjc+Ew8?=
 =?us-ascii?Q?hOzVifVypgXwfhIhvD588RzmqoMAZB5pPhrtz2nI/VLYNCER0UkPqVqO4c9g?=
 =?us-ascii?Q?K9TT+3WBvkmX6EW/BBVSg1t7s/Jsm6SK2/ihp6xNKev3ZrHffvUTEjjlPQyV?=
 =?us-ascii?Q?BzIS6hXIJyspfY38MVfTSv3I/LRK7J5uObVSYyuRl1qZxKyhBK4M/VqEklrd?=
 =?us-ascii?Q?bX/ke8D28Xh1beLzCFgOxuMcxUee9OAhoSjUYTG4RMsO43uMIMmUvk/539gz?=
 =?us-ascii?Q?umaKZGmUSKM1LlA9ZeXfGurzWuX9YkNL/H4j7RqLoxzK9TdfLFhamMCxOqyg?=
 =?us-ascii?Q?+Zb7iB9wXhTfU9fUk6Y3DrIg4iPnh/JrbIRlI2eQ7do44OyJVSJiXyOSkB2Z?=
 =?us-ascii?Q?bf3r+aZQcUtk8b9T5tXuCK1cJNjud0SSOZ6iRy9+7T88RTewpeMdKyU14+WF?=
 =?us-ascii?Q?PTOra2jq42veZOXkG9rTfDnvHeqIlFjByTwItQTP5/cRPlCHcw67x3DT5q10?=
 =?us-ascii?Q?+dS9dIJLnaDfuEFITh0LQiTXRCW0nbpyMeX4vh71F5n2PHsEaSdNMV09PYv8?=
 =?us-ascii?Q?mfjEgMK4H+4UHWI3FbesuUiDU3y2W6P4hEee0LmoQ9aAomUwCkWAkscMZ8bT?=
 =?us-ascii?Q?Eoj74dj6ZFmSzQ89UegTea9NWbbxOe7Git8Dq8vjKEL6FWuJXmO/V0XqwnZt?=
 =?us-ascii?Q?gWnR0AU2gFnEFKdo3Roi7bNZMGUXf4n4WAo8vgWH6DfB7tr4C5q1s6FTmQ7A?=
 =?us-ascii?Q?YAjt+YVeR36Ful09aTzbRZUcWjgQI4hVW9Vz12SIPx4Ph9I0rduE1OVXiUnC?=
 =?us-ascii?Q?kpmCHTSKveFenNY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XKHP1Zu+m2YSW1Spv4InjS6IT/4NMXU3RdZRYy1Bl91AvqGIQzJzBiUmfV+9?=
 =?us-ascii?Q?ZDX+OUbzNyr+r9XIu/ZZwhXs+iUM8baO3m9/OAlX+ExwOCTpvwdoRyoOI7A4?=
 =?us-ascii?Q?qrKtSSAm4uTu+su87XUBFckhKIedjRqSFm1dE1TXejQGkuTAZ+tMxaYTSVdd?=
 =?us-ascii?Q?fpFBhhopv/joFK03PDL8i8DuRUATBlwIqlcJWKuISGQUUO8XnKzaa/gEvhtR?=
 =?us-ascii?Q?rFTdJ+4TfX3lxRyIGiPRjzuGAT2Vv9/Y7xkyt+9deM8suXimpofA4FUU1jzz?=
 =?us-ascii?Q?g3OVEiERgLr+YLa0jZ/4o5IabiDGqMU+dPgHRUZiJSYOzkyS6zZ9N4QCGqGa?=
 =?us-ascii?Q?y1+/3Wbfh3vlUklwOMC2O4qRqtd9rQb36rNtf8JRsqRviw8O/B4CRp4LONsu?=
 =?us-ascii?Q?jEinRgYqRxBiqw9XmZq+A8LmFXNKAvfVUpL1/KxTwYjo7KPPix5R5ZxPHYU9?=
 =?us-ascii?Q?qr5/F9NQ1xl/p8C9OmswVgpmH+A6rXwNLHG5QOKEQILZ7o0oto6SpoqZ4o+F?=
 =?us-ascii?Q?rXjYD5Em4oS2avv1jURSN1Occ1XpjMfG3oA+YG30/XrC5dhsS7xQbswMJw5E?=
 =?us-ascii?Q?fQzdVNmMnZZmNgs+iRDRf3wNlhAxTZNG75nKCnEIAvtEjYNGnc7GEQlajCM3?=
 =?us-ascii?Q?FX0R6J8fIJfDNBqoV0UNvG49E2fjKajKL7Kik39p5ERBRr9gCXpcE52R/rD3?=
 =?us-ascii?Q?EW1nBsiEVL/Ts3mOD/QWUdlqXIf1WCFrqzGZ3L9O+Ha+YqVUe3EJde3TuZ+J?=
 =?us-ascii?Q?U71adtN5sFC+VVWrJ2mm7XCMYvwQCnz8pq3N+ieYn+6CZah2uVGydDw99yUz?=
 =?us-ascii?Q?ErN5JG2nTqvMmgK0X0ZKXy/J0SwJ7UuqcIp9WpwYA9QCsQqHHC4p7cPVs7w+?=
 =?us-ascii?Q?WSNxcY9EW+BFHnZrJ42u1PoqEd90hOV7WhJ6KE5JrznXZeY6QHeCdaxBJ3Ed?=
 =?us-ascii?Q?vzmxG0EXk6mCIO5NjtYy33xG7WMuGZOsZv1nrrP8BAmoc4UjhFgR7PGtvHSN?=
 =?us-ascii?Q?5gWjVY2LP6Cr0y7/9yZrXG7MhR9lKe2KPW2SJ4Qw4fix4jvBTxq0buzrTm+m?=
 =?us-ascii?Q?tW6Tf6piJYczJ7+YzEsYzTiclUZmZNJw1yMUfRrn4KKWcZDA2PXuV0p9SjIS?=
 =?us-ascii?Q?NLIsQVfXqtP26FY3X/fSkpp87RcutP+jRku+FM1PPlfjOgKMsejjstimjpTR?=
 =?us-ascii?Q?gMj4YQlxSZUGpiexH4IAxTEmhG9YYu1WobBl7D4/WarT/pfjoSbWtVKxh1hH?=
 =?us-ascii?Q?gviwD0UdSZBxTmwFHO4q8dSKAlhrlgHsb7BYGeX1oEtjJO1nNyzB4Vvv3WM7?=
 =?us-ascii?Q?FNdAAwBpATn626DRLP5Xqbpsb4sadMmpuRVbCn+d+x3OYIP5WTUniwaJctp+?=
 =?us-ascii?Q?WKih9X3UILKigGtOq1rmT7CF4BmTeI1FTVff+XJFDJ7ICaAu5X7/ZE2pO3Cs?=
 =?us-ascii?Q?0XCbA7yrZafz36KjJ/nHxMBqR3c60tMD/DhQXGMJ14VS+Izy0q3Ibw3KSgI3?=
 =?us-ascii?Q?nV1UT58I2RTt7i6+N9zpFFvsi8RmAVmg2X3lM79vyhlvZmqWUW5mtTsE8bvB?=
 =?us-ascii?Q?sJ9kb5QxwKFYs0uJpB90UHf+2X6aEFdIMAALTcV6v+vmrl97PuGQs/fluScM?=
 =?us-ascii?Q?jcPi62VXfMzzq0TiuODGIVM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd4beb7-a93d-4871-6762-08ddbada217d
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:58.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6K1xnS7oTJjg6Dc/hJVgUs6VkO24zvS0+CoxWFi1QbJn+he56Mv6v5J0tPeeDA58w8lWaG9S0CYOp3ixmiwgXOdzB0Ptq2SpAMO6YnB06prrZ4n8atKNgbnMAuCJMe/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:07:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19343

From: Biju Das <biju.das.jz@bp.renesas.com>

commit b7509775670d69999096b55c0e90a4e03a373bae upstream.

Add interrupt control node to RZ/G3E ("R9A09G047") SoC DTSI
and add icu as interrupt-parent of pincontrol.

Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250207113653.21641-13-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index b742e57f40b4..5b413d31b8cd 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -160,6 +160,95 @@ soc: soc {
 		#size-cells =3D <2>;
 		ranges;
=20
+		icu: interrupt-controller@10400000 {
+			compatible =3D "renesas,r9a09g047-icu";
+			reg =3D <0 0x10400000 0 0x10000>;
+			#interrupt-cells =3D <2>;
+			#address-cells =3D <0>;
+			interrupt-controller;
+			interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 263 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "nmi",
+					  "port_irq0", "port_irq1", "port_irq2",
+					  "port_irq3", "port_irq4", "port_irq5",
+					  "port_irq6", "port_irq7", "port_irq8",
+					  "port_irq9", "port_irq10", "port_irq11",
+					  "port_irq12", "port_irq13", "port_irq14",
+					  "port_irq15",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "int-ca55-0", "int-ca55-1",
+					  "int-ca55-2", "int-ca55-3",
+					  "icu-error-ca55",
+					  "gpt-u0-gtciada", "gpt-u0-gtciadb",
+					  "gpt-u1-gtciada", "gpt-u1-gtciadb";
+			clocks =3D <&cpg CPG_MOD 0x5>;
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x36>;
+		};
+
 		pinctrl: pinctrl@10410000 {
 			compatible =3D "renesas,r9a09g047-pinctrl";
 			reg =3D <0 0x10410000 0 0x10000>;
@@ -169,6 +258,7 @@ pinctrl: pinctrl@10410000 {
 			gpio-ranges =3D <&pinctrl 0 0 232>;
 			#interrupt-cells =3D <2>;
 			interrupt-controller;
+			interrupt-parent =3D <&icu>;
 			power-domains =3D <&cpg>;
 			resets =3D <&cpg 0xa5>, <&cpg 0xa6>;
 		};
--=20
2.43.0


