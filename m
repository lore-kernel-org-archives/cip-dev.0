Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC3FCD98F4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10749.1781685062555409910
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aaqDzgGa;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUdvV0UlP58oPG+G60RQ6d6B3pDvclymttS4YE9g91bAxmrLtQsygBDFGCAfkze4h9D8D6NpJjfNNqeFb538EhvPlVcYxTHfWoaUW3+2idoQ4QLAfiM3R7fSuJU/CJ8hU3xxwyG8g2rbMI4wgIlYDTb6Xkx5D+tjralqw9wiQItQqsVD2iPK1Hjs8Nf7QF+Pr+N0NbVH4YCw436buzptykNg8FOH8n4VNYzE1ROtbl5OtQsS+XORwpndqaS1UtOD0/3kew2H2owFkIdJNRFzjmBd2QCNDPVaf4L+rvimZWxYoSSH/dGmV3avi736PIaUxD6ke0cW4v5ftt6knxqoxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47QUaCvqi4DsZLYCr+sLJ1gSFrssiJwh+RyuI09xMyo=;
 b=GOfkq80glQit+iO+CDqLPFYOoxEi0Al+ig4RZJDaafEKXo6gJdgqgM1Zfi+DUipyMszW1naSiFHLUQY58vPOXI/YrlSEvQZvXt4Vy4m+FmY/1pVEW8cwaBxL1f9KzteMsJV5MLYh+KF3bp3uBSynFRxHbNrNpO7NfjvBphcwF37Y5yVujpE2lkV8XCORj3mubOhUmJBvdmp/zJxx3MbDU8tZYAgt2X4QuLEnKSNnpqh+bGB5Z4frkhGsirEm4r+qNyH/gDNu5EKz3DzM9VKxU/oHkWkNjb4qMNYV0CyeCf/6qt+DoHm4sM0f6ReDKAMbjIJJAH6Q2/CME5q2Bw+Udg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47QUaCvqi4DsZLYCr+sLJ1gSFrssiJwh+RyuI09xMyo=;
 b=aaqDzgGadIo0HvrfTTRwzpjGAs4kU9dVh6v8HR5VVo2SVrQ+jG+Z/sb5BtOmVyes6VHgna7ys7k/7/PB0kewwqAssa+bnZJb43EDaLJRb7WP5QQeTQpr4FjjUM/wLBQH/JGwiveek9lJRg8gefdDqOww/HKh58IORjkHaU6DC3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:31:00 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/32] spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
Date: Wed, 17 Jun 2026 10:29:42 +0200
Message-ID: <20260617083003.1071543-12-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 8caf0af8-cbc9-4400-4241-08decc4ac2a1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|6133799003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	ElP8ZuCHbYotczeUlZdLspkAoNfD7yRTQ0CCMtlvqaG3bTuBnvTKbfRMBZO3e2z0T1iBzZ+eMDj/qBwrwACdA86iZpXI/kJWMZBZYm7/KcKxAErYWUfcRhq+wGvOV/uShWvL3HPDOy/u812ELB1i/fCZbhSAN0h607d8ZqrwtKU8+ueQydcjqyF0GcrjUPd6RaTmCX+ab+4WWmMasEMH2olCHtjoEX2i/NGsQyhJC5RC/Sndyulx7WDWsTSjyLLDdDjRDLXCRzXvwYBoMYRQa4GSPg1TecL1q1NlmHjwQC7ob9bdtlaVEqFi1DCvFdEOJRyOglWtouKIaoHhyqBRAauixASvwF2kNUz6+PkQNvLmFQKaglQAq88pCLcqZCm+lwZAJzut2K/EhIoeNWmdmQjsDsTQTPnF7ZNqyf54IFfIr4usRdcDMRRe2pYPp5VKeyzQYEGoviaFTs5zXd6Dfyx5Nf53uL/fyzKzjqrsg9Fj1vTdJo/CVQnxYyoY/+1+egYGELevTgBko58W4SeMgFhg3FhBY1xP32CNaTYwfdZyXsfWTqkAY2QBZk9doXzEEyJB4wjW0IiGM8AdLOjx9wnfgxsGF4rRr7jGxQDJfEHtZtsscAups1tmpB6V8trSuj2D8EokYS7u82Eb75of9By5VDovOcr7pD/7oU3KQCr44/B2q34Cixn5hCAZTdqrFAJ4sOyrRPPBIQhrpYR4Dg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cvis380SPVkqI5dASVGJcOqaKDJaXW8rMnrXyU28sdvUSkEI+rqgXNClndlt?=
 =?us-ascii?Q?YDAFZm/EjcVkfp9hHvr6v+62hy3DKDS8180PhM2XSu6y+O7gpoFnTeOSg73U?=
 =?us-ascii?Q?+1npfpgmuiMEu0g9NtHMXv5oUpGjwymrkrnA10w+SdsH/8UBfu4fNHIwnk4J?=
 =?us-ascii?Q?z8HkjV2XwiU0KVyVGrLjUBPa3umNCf0Ix8lselzpbo5Dk4n6XTMIYPRJ1cAm?=
 =?us-ascii?Q?xAvKU9caD9ZOElRvf5LVT97sZgpcW6ZVoa3VjLjRGZBjwCLD1OIigxM3hZRI?=
 =?us-ascii?Q?8RJ4EMGxdMfIAI+LlGJaI2dwyajScyQvYRcGrjJDX+hwtYFyBoACSBlG0W6p?=
 =?us-ascii?Q?i2QnDg16P8XWCrs2LEyA1SxSKptYUwQFEk/zwBFe7QTn7tMXyvmehuBPtZwh?=
 =?us-ascii?Q?eGwms0/dZVmOTlBOyyWiEky5Mc3hJhdgd434LPU1w5fnH8xxX6YxkIFuxYyI?=
 =?us-ascii?Q?luz7kb4LZSwsMGayLVavPDXMsWsxWlpQpM7Qx8UCU0aDdbu2NWH83iu4CKPB?=
 =?us-ascii?Q?jE480cUKlVe7+2/MyX2hNBJXHl77W0hL/44vJbl+5ziTL3N0UZVuO/YJzL47?=
 =?us-ascii?Q?AXfYjBRSXRPw9WqVRlssQUo1RfTSK+LGdX55WOSn+cXXvlIBtRCxKkooEK1Y?=
 =?us-ascii?Q?BeVHm80JDlaQ0GqnLQX+sC1cWXZpRwhq37jlDDN5HJR2s4/jkotMm8UjKyuG?=
 =?us-ascii?Q?XShhd89Sr5XhwqYnFBGoCbjYGXCYzCWbhjR/6Gc1AcXj1juUSNhgZMPpBOOh?=
 =?us-ascii?Q?neC5PI5pHD7XVUOhISbVzLvuhYOdzalQuKGvqDbWnT/04QFsh89D87GN7HKH?=
 =?us-ascii?Q?jyTIidsInPTmvOm7yf+Ik2ASbAMZ5Je3FkRBo5p7am7cRWCEN0W37+jz4q90?=
 =?us-ascii?Q?ucVUPHwsJCypzDFf0XFGc/XcwpIkJZj+tdYTf841QPqV3UWLwJKTHkRpTpo1?=
 =?us-ascii?Q?8zMzaIzEjSrIw1oaO3yFxJsa+xM9TY6kNa4NLvEeTZbxRhq7SATHuX/wsVnu?=
 =?us-ascii?Q?fra4poMaZDOGDWUHHTbqthTT5hkkSLB2F+zcqyzSqs6q/90a0J/LcsOFeNyB?=
 =?us-ascii?Q?D/OzMf0QVcul2RPo7Hun2gAPHXVxzI1Vyv+GCf2zDkmj12RvszQ4UjM50jlz?=
 =?us-ascii?Q?bG3Xlc8a/DJoa0fC4fmrIeCYF8Xcv6Q9BCZ3CtbUBj4aYmAtAqfhLfyl0Owh?=
 =?us-ascii?Q?y/OH+t2hhg9WCOIQ9+wrC1WN5bKAjttmUVJ4+Sf2MjVEmC6MoNB57m/fPQWU?=
 =?us-ascii?Q?2Ip3eL2GPW1MHLgHfbTfe/Uj11v31g4kdc29iOw6GxepKA5A8jEpp66tPI2I?=
 =?us-ascii?Q?foAsVQ5yRf634qAIsDOSKnEnQlMlHZKnu9uCkfZu96I0mdW1V/qCCcUOX2F0?=
 =?us-ascii?Q?1dYu1FHpaEmi0FHNRG3zKhV4NkwVdh3+FelPXmQy08Z9AMfOHqUaQTjjBBOA?=
 =?us-ascii?Q?nPyxP0GBQ6LvlqfUofMZ1dVOfPxslWEAYOTggmKRMjSG71mEqpIpbfOM6J/w?=
 =?us-ascii?Q?bZLk9hRE8lLRlR0AxjI73TJb0lyCKfJ6bLzHxrBCA86OR0Nshu+cNdoQdbEK?=
 =?us-ascii?Q?KovmvtqZYmQuZP8B4t1FViXj9n3LaMrG/B1NRXAJLlAjFalWmKORG+Eo2M3P?=
 =?us-ascii?Q?7zDp6hDAasDX3A6rNaoO69XEDU6RA9dvpMYTQYbmYPqLIQz7T+XlN5dQ6zGX?=
 =?us-ascii?Q?/YguAbZbzK64xPQM2+XDY8mqO/m7rOy7akbRbg0b05YWQYrGNxkVZAWy0j0w?=
 =?us-ascii?Q?pl+gOuyMYT7W7G30jW6+HmCTg+nbcyP9NPQMqMAwwmIzU2Zla765?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caf0af8-cbc9-4400-4241-08decc4ac2a1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:59.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQJkp2PQ1eQSD2jhleJq3qchUpVww86NrIhVgKH66s3x6cnCfVa8niH+vnyxZBdMY8uPB6BqCTVfBkCwq678UVKoVq2amyhA36MFPR8w1ja+WxURYxc8LDzjA3tZQuI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23170

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 1b7ce968ab2579702ea9dbc2fb599e540bbd8c88 upstream.

In preparation for caching the last requested transfer frequency, move
register writes outside of rzv2h_rspi_setup_clock().

The transfer list is iterated to determine the speed of the transfer
and the bits per word.

The speed of the transfer is used to compute SPR and BRDV inside
rzv2h_rspi_setup_clock().

BRDV and SPB are stored in the SPCMD register.

Move the transfer iteration earlier, move the SPR and BRDV writing out
of rzv2h_rspi_setup_clock(), consolidate writing BRDV and SPB into the
initial write to the SPCMD register.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-5-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 45 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 4f8c653579ac..e61289877eff 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -83,6 +83,8 @@ struct rzv2h_rspi_priv {
 	unsigned int bytes_per_word;
 	u32 freq;
 	u16 status;
+	u8 spr;
+	u8 brdv;
 };
=20
 #define RZV2H_RSPI_TX(func, type)					\
@@ -260,8 +262,8 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_pri=
v *rspi, u32 hz)
 	return 0;
=20
 clock_found:
-	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_BRDV, brdv);
-	writeb(spr, rspi->base + RSPI_SPBR);
+	rspi->spr =3D spr;
+	rspi->brdv =3D brdv;
=20
 	return rzv2h_rspi_calc_bitrate(tclk_rate, spr, brdv);
 }
@@ -280,6 +282,25 @@ static int rzv2h_rspi_prepare_message(struct spi_contr=
oller *ctlr,
 	/* Make sure SPCR.SPE is 0 before amending the configuration */
 	rzv2h_rspi_spe_disable(rspi);
=20
+	list_for_each_entry(xfer, &message->transfers, transfer_list) {
+		if (!xfer->speed_hz)
+			continue;
+
+		speed_hz =3D min(xfer->speed_hz, speed_hz);
+		bits_per_word =3D xfer->bits_per_word;
+	}
+
+	if (speed_hz =3D=3D U32_MAX)
+		return -EINVAL;
+
+	rspi->bytes_per_word =3D roundup_pow_of_two(BITS_TO_BYTES(bits_per_word))=
;
+
+	rspi->freq =3D rzv2h_rspi_setup_clock(rspi, speed_hz);
+	if (!rspi->freq)
+		return -EINVAL;
+
+	writeb(rspi->spr, rspi->base + RSPI_SPBR);
+
 	/* Configure the device to work in "host" mode */
 	conf32 =3D RSPI_SPCR_MSTR;
=20
@@ -298,6 +319,8 @@ static int rzv2h_rspi_prepare_message(struct spi_contro=
ller *ctlr,
 	conf32 =3D FIELD_PREP(RSPI_SPCMD_CPOL, !!(spi->mode & SPI_CPOL));
 	conf32 |=3D FIELD_PREP(RSPI_SPCMD_CPHA, !!(spi->mode & SPI_CPHA));
 	conf32 |=3D FIELD_PREP(RSPI_SPCMD_LSBF, !!(spi->mode & SPI_LSB_FIRST));
+	conf32 |=3D FIELD_PREP(RSPI_SPCMD_SPB, bits_per_word - 1);
+	conf32 |=3D FIELD_PREP(RSPI_SPCMD_BRDV, rspi->brdv);
 	conf32 |=3D FIELD_PREP(RSPI_SPCMD_SSLKP, 1);
 	conf32 |=3D FIELD_PREP(RSPI_SPCMD_SSLA, spi_get_chipselect(spi, 0));
 	writel(conf32, rspi->base + RSPI_SPCMD);
@@ -313,24 +336,6 @@ static int rzv2h_rspi_prepare_message(struct spi_contr=
oller *ctlr,
=20
 	rzv2h_rspi_clear_fifos(rspi);
=20
-	list_for_each_entry(xfer, &message->transfers, transfer_list) {
-		if (!xfer->speed_hz)
-			continue;
-
-		speed_hz =3D min(xfer->speed_hz, speed_hz);
-		bits_per_word =3D xfer->bits_per_word;
-	}
-
-	if (speed_hz =3D=3D U32_MAX)
-		return -EINVAL;
-
-	rspi->bytes_per_word =3D roundup_pow_of_two(BITS_TO_BYTES(bits_per_word))=
;
-	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_SPB, bits_per_word - 1);
-
-	rspi->freq =3D rzv2h_rspi_setup_clock(rspi, speed_hz);
-	if (!rspi->freq)
-		return -EINVAL;
-
 	rzv2h_rspi_spe_enable(rspi);
=20
 	return 0;
--=20
2.54.0


