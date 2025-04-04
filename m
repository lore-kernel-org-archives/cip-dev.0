Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABE2C369A0
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.58])
 by mx.groups.io with SMTP id smtpd.web10.6106.1743752356591242207
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:39:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=NcOWp08Q;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.58, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4ZK7UdaQoFTbAZMwwGhBVnWVuq4BRw/7WLrKfqqtq2xzzITsNbstPzJyZd2vEw/R2miBWwCxwpA8MfybAJGQUJTJunMNsn5lghcVVkRCpopL1RirQGww9/qf2wBkb3MPzJMlBBasH9FfzGZ1ihWlbY+h1WVYM+gg+OY5ZY812M5Wt5bwgbnctLAqRZhpVShcRySXoWz2WYeCROads6911ghuWhwO4HNv9Wpp7DP8hkF59DNrQJx9QTAc1aLgsl9P9Xpv5HlszVs1s4Fh8RH/PH7QA6qTdNIdFfMVHQV/w+IjOUwJH41kXSKsZ2s9G7GC+v+YmHHbYASCzpf5xAFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNP0G7O7FsfBuRj7qsRlCt6LZAmHKn6T4PHVUDp801U=;
 b=JfEXj0GJp/RNjUrtrHbnav/yEGXmzJEing4q8vTZlQl8unA/Yw07LeJMCqG1wTuL84+4B9CpLyOrFQPhGYRhYo9dUqMSifsZlCk73mZIjoKUZxGA5DQCXImsmTwEWExXnIodKxTbedMW+2j+bkF8SgdodjE/EdSb0cbG9lOB9ySHx5AjIvcg4AJZ7Fq/UfKcaMhx/uIDsHUIIZZA3AagBxViW9nb3M/NnA476ZbDqmN1u8PS63SlfWoSEIIysOVlMBwmiGiQrQqiMQQvkaBUFtOqirwiuWIcdqQM0HPRSCRSOuCeBpTJK7psGYpCTd3bTS+oQAiHh75g5vjGpFuO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNP0G7O7FsfBuRj7qsRlCt6LZAmHKn6T4PHVUDp801U=;
 b=NcOWp08QZ22gf5KgDsIBFlSkQ678sJTubrAF1teVUZrlkDXeBYGn46m73D9no7oEc2ZbeckHls7n8hasvirvPRhafrWKxlmmqTfhoHCJ3r8DjzHTIvJY+GqSF7Di6wj2qhNKJJ9LiZ9SpVdHe5ltCqGtNJiP4RZF0z+XwsSZ1E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13254.jpnprd01.prod.outlook.com (2603:1096:604:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 07:39:10 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:39:10 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 9/9] arm64: dts: renesas: r9a09g047: Add I2C nodes
Date: Fri,  4 Apr 2025 09:38:19 +0200
Message-ID: <20250404073819.173272-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13254:EE_
X-MS-Office365-Filtering-Correlation-Id: 381d7aba-58ba-473b-2767-08dd734bc9cf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wGRaYEA8T505lOMEQuZ5YasDzPJsLrX5t0tYl/Kj2eaSBwikES9LlXUPV9PN?=
 =?us-ascii?Q?dfGPVd+5KxSk3Ya8/MxMuJvJHfjSO03L9voBqfbFADKFFNGq69e06rZKpkF3?=
 =?us-ascii?Q?WJx8akdCl/MVOKk9Ffaokc3I48H4T3anXbHqXqAUsHrgsfyghKQhagCqWQiT?=
 =?us-ascii?Q?A+g+/wVrSUTP0vUYBe+DneP5O4lnmuwwqxg468bmezCqzkPjdMMsn6sPITrb?=
 =?us-ascii?Q?hIP8AK1ZfTVwVDLQJCc+5cLyqSNLMjyr/i1miCw9glkueOK4D+tbtDVes/5A?=
 =?us-ascii?Q?akS4ptbbZPFX5VVObGUdYjyW2Ql/JhkkkNdzF47/36ebpC7eeAcFdaofgxC9?=
 =?us-ascii?Q?BLTjhap2BghB1nF8OkdnEM5lPrZwJZU1MIWHmj1KoypQTE0LkGhwMJkh4Q8g?=
 =?us-ascii?Q?PYWzPCUelrEL+bPIopRf3pDrIM/8XmuQRsQOSondEBYd1QMFbFkiZixirZxT?=
 =?us-ascii?Q?ofx9aRy6hnBbHeBMoJtQJ8mKIYTVJOpHAkEW8Y2jlaaQOrFwGVbcEcHc3pvr?=
 =?us-ascii?Q?1+0CQL5UPFOTxUzs70M98zjQgM3XvBmYp+kvKgeiXOe9G55y7c+hMy0rN2Cl?=
 =?us-ascii?Q?dMi0VF01ZYkjBBmIfHYP0UHQPfe57M/fozohwGm0BJ9UEikelq1fw2HsGj8n?=
 =?us-ascii?Q?AE2n96WpQMDaNjw7c++yJS4Ntg6MsKJ1g3jrNnApbdevhud1Z3P2hon77gzT?=
 =?us-ascii?Q?th3WqUSqaEJ463GuUHwtIOYSw6IlPzyF1g5cYfErcS5ZB9Y6S2Nm6tovnLYF?=
 =?us-ascii?Q?s7kEauzh1NNo3iwFe0j8mFhSSR2BhBCNv5UM5YZUDhPsU1vyo3weaOckH9q1?=
 =?us-ascii?Q?/qKxAJJpZCcWlSCOVGl/RA/eAwHE4RSU3dzefLfjKKWMhzlVOtg5kjvX/eG1?=
 =?us-ascii?Q?hVcu6EZ/Zki3plxcwSFr+73WeeiEX+gBrNMrqf/5ch9XnZWu1+Uat7B0s1Cn?=
 =?us-ascii?Q?u98tPcioj8TXcoK2xxmsETmw+jT/KdYDubJaUuwQu6sva7HhwnF1vKmtZWH3?=
 =?us-ascii?Q?pXkw40zcYbocXRfQGz2QA3GC6XvBVLE0eLnCXi/CootnxuCUW64iFa6x5gq6?=
 =?us-ascii?Q?PmHWYo9u745Twm66RSV0Caw9xZIiSQlBETiQm0q4vsMqIOsGKxGKF6r0VBMX?=
 =?us-ascii?Q?LcIA++ZZD2POuPSXsmE15+j6HGKxCzgjQcqzfIWKAcHpfF2I/RV+X/viFosn?=
 =?us-ascii?Q?IkDvGhEeY7bVbxrkCsTvVpS6hcCQggyYZvD1yEriiUSMAPD6Y5awjboZ8gvH?=
 =?us-ascii?Q?NXr/QIHh2klxlSx6SQH03uNnUnO9D1BKztdNEacJjFhf0mYUhLC41rWFU+z6?=
 =?us-ascii?Q?MGs4p7MQzoTT+3DT4A/Wlwbh90I6oTb5Hpqa1y/edbMzZlTibo4KepVprUnl?=
 =?us-ascii?Q?TTaG1S3J8zZgiNaUcHgZjO9VAcaeavDCk7jc7qo0ryXuE1wQ60ZEdHXRS1bc?=
 =?us-ascii?Q?4CzuXTr6uW7Eiz4X2nQff3n6+EXNLObC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?niH3UBjlR/IkB+NcRIMpYYW5tj1BTKZQlu6Ot63qmqApJ/LpEgDBUQXsF1n6?=
 =?us-ascii?Q?QndVPFdkuGirE3r0+YcoQGtXdV7m45hwaioEeMtmpzqrRMfKHnovd3Mh7aIm?=
 =?us-ascii?Q?6rnY5bc+VmqxZTBtemxKVpXj2kdoQe63TcLKdwPZKyCSACYddlA/4NhGPfhb?=
 =?us-ascii?Q?BHn0bBGiihFt+VB5mbHby8remjZtyDowixMcXJS1Hc5V+TKXoGizjnaw1KFE?=
 =?us-ascii?Q?qkz75TmmnA2AJV7py6UqarrizXIwtH7hSMxUEwR6zfrU/M9QkjU7gki/2KLq?=
 =?us-ascii?Q?r4O1JgOhNg72qH4lXnGLUhA/rE1mfF6eSu/XG/GUqgVrDzjCW4+2shSYWSUR?=
 =?us-ascii?Q?dezJxWpkjI87NwYTeWe2VqkBoNRsPRwFAXkImXLmZLjP0bNsNwgrzjxlhANr?=
 =?us-ascii?Q?4NIEDN8inKyXCvlGTbgeIjKDKAo277u9Lu4BHbpvJMLaHwNXproZs9IoMpgo?=
 =?us-ascii?Q?qFHWcC/UzKYIVQsfE1qqtT5ZIoqiWYHZ8B9RSo9zgdsFJc1HlyuCngdXquuf?=
 =?us-ascii?Q?WV7BVN76+vLhHWMpemybNROgFZ/7ETG+Dotv9UpRCXunQXdOFpwNXxyoGvQy?=
 =?us-ascii?Q?9VF/k43Skka1Fj5BN6cUAhbBIHSltkPyQsWqlJWSk1cz/bJtAcNuGjF7DO/l?=
 =?us-ascii?Q?fWmh/J8PyGnqrXBnxlzoCG9dUGQ/qAKbh3V+uKiDiAlobpVX9C+UwdWg8hU3?=
 =?us-ascii?Q?kNwlZikn9eKL69wa7reCj2H5Y2v0mKmTThaWBkyJ6cA1LFLgK99vuYUTM6Do?=
 =?us-ascii?Q?L5/iM6xzySTzsR5SLotFvoWsw1jkCBp/vqsAK8rIvyfS4qyP66m0WMpc8Dzt?=
 =?us-ascii?Q?OaP5Xivxr+uyE5Pi5i1N5LCK2l0XB4RD5/J9lLaYKDviEac9fsKz6J7cxz+k?=
 =?us-ascii?Q?qzOcj2NDSkgHfARAq2vNXgKdE1h6g7wYwVQEE00VTp9mqxzdyMYoWqjAr/qz?=
 =?us-ascii?Q?kFKN8vCEg1NDr5xBeri2D0ZdqAkNDkrI8JlP+rp/8CXDQwwSiW0dEVEF7C/h?=
 =?us-ascii?Q?ySgiTHtZp+cQkKlwZVVyTJZoJ2qWtz1NIPnjEdLZUuY5sqgRbiXriBdBqpEw?=
 =?us-ascii?Q?E9WPrv8uyiNiCcL0Oudu3v88323RTSEFM69ujH+yGVuyaIc/fmCiM0qN+VPt?=
 =?us-ascii?Q?3BY6Q+RrlqZK6oh6YV9Q9lUiiDwaqiW3TXub+SiRxRp56Q1JNWK8hPBG+sL7?=
 =?us-ascii?Q?lugQNxXeeYl34K+eBisf/JoehL2DMCBB6vdp4O752SW/1aVLhY4nThiOzVQz?=
 =?us-ascii?Q?ail6B1b95eQbgKGi7HlQCH/Me4Vzubc3uYn8SKnTRSwl6NiVNvF6zgUBDh1k?=
 =?us-ascii?Q?qqnkG1LmTf1Wyjtndn8/uxe4J5VA8INv10h8v7+VRnXxZkXprP1XemAHh1vx?=
 =?us-ascii?Q?m3fDfsVT+H1JHpM7Q3O9qZXMpbrsc600CTo1sfRFbLQbrrSFV097DxygunIr?=
 =?us-ascii?Q?wol88iIK9EeQbR2c28/PMimpYNc+bwbvKuYF8qza3iC8BKDZyxfT2eephTEv?=
 =?us-ascii?Q?0zKVkOxm/Djb8uvFgK8kY+l1VHJua2S/eVMfJpvTblFL5oPztXi6YVvGVp9C?=
 =?us-ascii?Q?bhZ6WTaFCG0C08EdtxOj+0Uv4rIH2XQzi4Bgg9626BZ+zF2JL3rHmGL1OI3+?=
 =?us-ascii?Q?Fyd5R0E/LwbvLXsKrR3sRyk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381d7aba-58ba-473b-2767-08dd734bc9cf
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:39:10.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OitTeXbptXbt+2ML92IAqrFZMSAiLbjiAGfriLVEXQ5EPLuGhjWOtelPpE+oSHmWvs0qMFx5gNKkS+G82d274f89Ds7KJ2+3USyOtZGbKO17RDOhmmM4Zr0wVQInDeOy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:39:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18473

From: Biju Das <biju.das.jz@bp.renesas.com>

commit acb247afab5bc2b4462f4dfc17a9d930e1153e52 upstream.

Add I2C{0..8} nodes to RZ/G3E (R9A09G047) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216120029.143944-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 189 +++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 15711f9b6038c..200e9ea891935 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -175,6 +175,195 @@ scif0: serial@11c01400 {
 			status =3D "disabled";
 		};
=20
+		i2c0: i2c@14400400 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14400400 0 0x400>;
+			interrupts =3D <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 507 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 506 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x94>;
+			resets =3D <&cpg 0x98>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c1: i2c@14400800 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14400800 0 0x400>;
+			interrupts =3D <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 509 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 508 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x95>;
+			resets =3D <&cpg 0x99>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c2: i2c@14400c00 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14400c00 0 0x400>;
+			interrupts =3D <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 511 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 510 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x96>;
+			resets =3D <&cpg 0x9a>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c3: i2c@14401000 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14401000 0 0x400>;
+			interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 513 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 512 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x97>;
+			resets =3D <&cpg 0x9b>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c4: i2c@14401400 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14401400 0 0x400>;
+			interrupts =3D <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 515 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 514 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x98>;
+			resets =3D <&cpg 0x9c>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c5: i2c@14401800 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14401800 0 0x400>;
+			interrupts =3D <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 517 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 516 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x99>;
+			resets =3D <&cpg 0x9d>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c6: i2c@14401c00 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14401c00 0 0x400>;
+			interrupts =3D <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 519 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 518 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x9a>;
+			resets =3D <&cpg 0x9e>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c7: i2c@14402000 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14402000 0 0x400>;
+			interrupts =3D <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 521 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 520 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x9b>;
+			resets =3D <&cpg 0x9f>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c8: i2c@11c01000 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x11c01000 0 0x400>;
+			interrupts =3D <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 523 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 522 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x93>;
+			resets =3D <&cpg 0xa0>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@14900000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x0 0x14900000 0 0x20000>,
--=20
2.43.0


