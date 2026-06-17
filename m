Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9A5CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:35:56 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10991.1781685347566192908
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XwTNDlkY;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue34JIDzgDXlagQ+CFurWkzfEVtdt69RrvpgqVA/00JBXxkzcvtPDFke54GY77xOG6ZpHm5wAjHLwCSKfCsoUwiLyZFSml0NZmzaZEnknAr6AFBj9764Hb0O3oAYsmYfb/S5I69iG9rRbAkXCEbhfh1z8VB+1DiGkGuzKvqecTj7UN0KEjyNQeuVrREkTrY+oQRBg3O4lEwrsQEToSHy4CMXZFbQApi+1rJnPJSRNuHN8k1cmcwuhItFHGVrXZKFXwTRGubRfNsE3w22D1g4H0s3UhOr4ceWW/pC7qC9RAjHYBNnMkJ5bRWpH0SK5YvqnszMRSx+ySg6+NILcyEgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7npm4Aq65bOLpG8egH3OFstylL9vJmCjJCJb2pEFy8M=;
 b=PXoTaCMewUm79UDCyAbnrR6zsv/Ds5IAhuXiQVldPaH4RPfwmFUKOvuSrjcFigXvMEFLhDrxUjyERpmaBNMWHsznf1h4YDekT+tlgU26npyjcxGlU7LYgBSJs5tTLs0Gorb6VXVH2AbuK7QRRcCMA7c6N6w2ibnfbmoZDfhrj6yeTRpMRYeJn27tO/FLeDzuVF8tFQUTci1ENOhBa0F0BE/v6V9rvqGSB9CJmEtNKOyIkT32U4AAaMExyhZvl04nACbhhlx6EINkoI147hskNLY16ShO+/WNxe+D46Bmx9Ij1INCttxBvwAmrlGBHflQE+YzfqAl5JH5emCOwPXQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7npm4Aq65bOLpG8egH3OFstylL9vJmCjJCJb2pEFy8M=;
 b=XwTNDlkY2b49uTQXkbxo+rHI/DfDd0XXUnSSnnYUT9fo+oxRLEy3N4Owxg96AQ4OPa88hK5mw+QXgjngCF66jhMkIu7CBOVptYYoVxTRtoVL82obESvoKxjLoqQtyIvn7ENiGMQsUucA+Bj/Fjz+4PGY11FAMYGgKAzAWPmmco4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:45 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 07/24] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E SoC support
Date: Wed, 17 Jun 2026 10:34:45 +0200
Message-ID: <20260617083502.1074160-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB13245:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fe3cb0-dd22-4ae1-e0ad-08decc4b6c88
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ZvZBQLG3YK8xh1KpV8aUHoA41Nz/3aAWwgXAYebx/kCcgp2Ils4ZQNO2XXHpEv1WtEScIatdL+elGxux00uDVtOpgukj1dvXOt1mPOSMRugqjptEvcT5DxhZkn+8rQwksBmkN+4fhntc8cn/S9LeIdJALCxMcS4kE5cqdaSQC5FDK3fuvdfY2z+cWnB380dZ/fsjH6OlduiARYBHUUeH31nHp8PKsIPGcgmViyttraSL/12M1tMiNz9UeDWG2pX6J89coLXNO407/ea1u2SZFJgBjohBA67VjHSeSJUsy/yGqGf3SKozkrnH9Tfnn5SOPevw+oKOFnbqTpfxz6y2vpc+enWkbarxdD/Csh8WdX5x1zAfBpdAYTb7AVmsvybaORUAZYe/V7zwBnZoFAoZnAfR69DkORIJtuX/JMkBDr6rb790C9Ohr2Ij8DAAsyl2I3Mzh48XSbn9AbOIP88c+OBtMq+yjugbkx6HZNeaO9wWRmwbwDjMzlHjULJR+BTkNRHVqzlOcJ31mgPkbA+GvFSEWpdatqztitx+FazHw/5pAaNpnL0KZztlvSZo5VGz5ApNEcMPv/0lgZggCsS5VtmX5BzZOMLSxQ3lbVwAXKdz6sTpr/73JrVbRU64+E2gcIl+scZSBJp8K+k9Rm8yjC67DJ2i5G/gkRI5n8sxjOHtV9YXM2ki8Nd/t4sxMa5Z4irXqZI1tYC2ERRSU+FHPw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?muqGbTOqP5l5+Co12kMeyyeeS2LMK3JneQBtLnCNxTpfvJVjClrs5zdUrTtQ?=
 =?us-ascii?Q?Evd1cpeAsrD3wbdOQlAqtjQVYXHm6RqCoWemXOljfZwEXhmbg8F4rxtLi31E?=
 =?us-ascii?Q?EZlEObyVXF9ARQRPfbgQBD3RU0SD5GjOBy4Tj00jUuwPYgZiutlJydA5ZnNO?=
 =?us-ascii?Q?hnE4SiZs2KPEavTCObrl03Q5yO6WcxREelMQmBX+n3jcpfX1sE+yoiYBl7MC?=
 =?us-ascii?Q?78N+gpFoE2OdXTPSyoJ3hhSJVnR80jJA9hlovMVTX+A+MIxoYrBRWJxI+buv?=
 =?us-ascii?Q?GaePRAjhxIUaiqOW/H02qYlYHB6Dw6dM8sKqBNUSTdA2mCHCmr1HOYGM1C/B?=
 =?us-ascii?Q?T5fb1sljLIZNe3buvkwVFA3V0ZZBwW1WDJUgCNLgV4VNHzUICcKoFqKpMaLX?=
 =?us-ascii?Q?WPW9ImBXVzDTsA5vVML3qvOW/W4NExc0tueE2qMTxXzb4K1cIWDJsLSthlji?=
 =?us-ascii?Q?mF3qiYAngoVcvvmpl/7kyo5+bW13V/pzyOyUZ8oA/7trl0h6nL/l2qtoRihw?=
 =?us-ascii?Q?uzjy/C0VWxeuWNwPACXr5QmsaMiI/70ooRw7YW6VPnxe053FoRRQqFcnwqoR?=
 =?us-ascii?Q?w+eXdFeugKM9aLPVB3m3O6XCVG4m6118vobmVlRgwL8uVA5USBSxcfCT6B9f?=
 =?us-ascii?Q?XVZoQFJW92xDyFYl8ePguxlbvIn15SVHzx1YjVLeAmWHX18wMgSBRqeh6Zlp?=
 =?us-ascii?Q?pPS5PcFwBwmgI3ESAJHlWO0awOIDvO4KHvApb7/nLcQcqBVHqX4C7NjNv8EI?=
 =?us-ascii?Q?q/6WBNCNTaVfcWpidDrtgh6usgL7lj1SAhN+6p9GEla8ziRTG2yJEVjSOeaE?=
 =?us-ascii?Q?1sXJlSk6y2O5bNPzEw2Z5iW3azDk0BIgRzhSBHRTVDsei03O0qB/5Xn1kwbH?=
 =?us-ascii?Q?2wYoaQBzDsj3afxy8gcn/SH1BQ6fG8oyRchwk31aj6M0Mwwq4finHbyocwiH?=
 =?us-ascii?Q?gLUbgdOqAKBh3SBz+qaNrrK0Lm5c82TO9ATJ7j+m0qDhPgyTxC48QxeBi6x7?=
 =?us-ascii?Q?YIDVO87qXAwY/7JV5HqCBlN1vIUwU711EDuEv+bZNSRXuY8XIzStRBlSpeP+?=
 =?us-ascii?Q?1Sc8GdAALOIOKIrvoVIKfBbnOHEzO+j0auJlm3cCX/8YzrjS3uyg+uZVKSU1?=
 =?us-ascii?Q?UWHfr2/6RfOohd7/HwC1Cfcdioe76k5D7uWyHS0tyg5s8Zu9qVN9X+jZ6rIK?=
 =?us-ascii?Q?5zmBBbla5es8Nm1CSe+S7/AHGtQL1FTPDyXZ+b4/vyjfRkpDSYrmT8zzWPTB?=
 =?us-ascii?Q?UcTNXbhzKaFqEPZLCfxYgL0DTXOXr3elYK4+0QK490GTPuStr1n/nhAe4BPv?=
 =?us-ascii?Q?UMkAD5AU9nCy3ZUP6H/swPlpE/TJBCQGTIY1HZt3wry0HWtyPJK7QxFfDwUg?=
 =?us-ascii?Q?MNZx9gl+pyNixA+tOKf8bBY/R9kDalpqAfV6Z/aBWqHMDwsvXz+1avTKxeCc?=
 =?us-ascii?Q?IG/18EjALMS5ojZX9uF5+WQrZoDQrW/jNQpT3vIc4iDXf06ctwkNvFRZk0zY?=
 =?us-ascii?Q?W42PRgzTIt7YTOsR/UQZLQR0g8OItX6Wdeo9W9Hj5x3FnobjSkIZIC8ja0wQ?=
 =?us-ascii?Q?HVUDsmRA7U8UKH1aR1Haz8msGNE/8gaxMz70BMR3kTSIreu9Idf+5Q7V32Gw?=
 =?us-ascii?Q?mvnsxIkfhtn62uRa9d9NPoLjWVCO98XqXGCk39HsBoynCaFd/Il2l+yQw+Ai?=
 =?us-ascii?Q?Mh5rksJ+CS8hNyme0hDmt5H53DKNxWWCogAcRtBbQK9N85rJss9JIZDUEfj7?=
 =?us-ascii?Q?C6LP+n/3paaRIiXQ3fj/VV/iSS4V4KPZsyioaR5iIpesBMV9/jDD?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fe3cb0-dd22-4ae1-e0ad-08decc4b6c88
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:44.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpjHQVjHDWl7gLzbn4BRvqNNP56tbYJ9DLHPrDo1Lnmqd+99F8gA0CMEee9vZLtwJjMqwMl3o8v2El2rhSXm9HPd/gwTJNzrTFmWiIF73vR9eT5hrY5qKkjHEsRPQFHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:35:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23199

commit 5b7ac8ca0eae522735d24f7c5c2296c8094328b1 upstream.

Document the RSPI controller on the Renesas RZ/G3E SoC. The block is
compatible with the RSPI implementation found on the RZ/V2H(P) family.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/f6b43f0dc64e13b1c9942c164dea30002d4c4466.177=
1344527.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml =
b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index d6a5338d6521..2c9045fd51de 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -16,7 +16,9 @@ properties:
           - renesas,r9a09g057-rspi # RZ/V2H(P)
           - renesas,r9a09g077-rspi # RZ/T2H
       - items:
-          - const: renesas,r9a09g056-rspi # RZ/V2N
+          - enum:
+              - renesas,r9a09g047-rspi # RZ/G3E
+              - renesas,r9a09g056-rspi # RZ/V2N
           - const: renesas,r9a09g057-rspi
       - items:
           - const: renesas,r9a09g087-rspi # RZ/N2H
--=20
2.54.0


