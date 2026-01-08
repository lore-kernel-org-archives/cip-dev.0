Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62BFCF6AB1
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:10 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3029.1767864649193704525
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:30:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aO/bHtH8;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIFDf+RBC4Mg2SzxD1DklEDP+pUIqLcmnPz/yqGpw4cezytVHhJ+j8Ko9XD8B3QahurAb5XffkE+Fl8DA54JeUMXlQZuYNj7p1bfPZyRunNi+zd0xNhofx8BjIzLKQO9umGipXa0vjCxOPnLu/iSwLoHRlm+6lU73cjA5BV3x/zBbmFwmKReQ91C5pBr4b6b0BChNv4ZKxoJ+aGgPs56vYWislJtQLtQlXkWEvrJx/5S0Zl208HATo9Vq8gwgc0uQN57arxt5ye9moYztZF0KnlzebNJhu7QOo3jpNK5c/+cu1utxGZ6xHXmEisSdP7PeS6NTB3sqG6DglmQJFAVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsDdqBNRGOLqQfxbFgqAifBWfWPF/ZPpfHK6nvtB2Xs=;
 b=Wb/7O4tSFQ+D3/7IWsAr2eZhDAsR+sbei/DXWg9Z5xVcGCyK0dC+QzPaql472N/mXMv62eTJIVGv9TzfsE5o/VUMfnUPzbWrqxEDTwZOdF9jv/0QPkcwzxVdFNa1mXTvDEz650xxIjE8aXvHoM4AGxlgxP1my75UE/o2IIcqe4X+5hYfELuh1/ZEKWlgZL/rnVoRL+BnVMTsrS86ADGqX2/LDxnXDZ1pAHyWvPQ/VvaMzYw8SUWRwauWKcod+k18ytuzqiXTMBYYbxeNf94MHy3nnmglAu3e/apZ0hMSuO0+GKAxKxmo0XUS5tAQaKeSefpvPMtrFZHUA9UhmI4lhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsDdqBNRGOLqQfxbFgqAifBWfWPF/ZPpfHK6nvtB2Xs=;
 b=aO/bHtH8KhxdWOKigL3Vo9zOmytu8xC6uj8CHwOGUrJ92EjnbNyVHpkv1bUzooZZ/DARtKFyRWUZ/EOpdZy+OoZ6gNHfWHgmiXNZ0IicW/vfKimlpft7SjJ4JfuX7et8Iq22tDEp71Ven/7cIyMVlI7Wy85bVYryYTyE56GDgn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:30:47 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:30:47 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 01/19] bitops: add generic parity calculation for u8
Date: Thu,  8 Jan 2026 10:30:05 +0100
Message-ID: <20260108093023.489513-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14326:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e0f0fc-6eb6-4fe6-ef7b-08de4e989ae9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pD7KZoGSTMEyp5A6Lu2NO/ZqH2W3/4nr0zFsY410gQ3RRkCAv4INnE1hRoGm?=
 =?us-ascii?Q?hmHiccrKEqHXvC3q/6jHsjAAdSMVe2+3DZE2VXaHiFSU7ThAJ7YiY05bjaha?=
 =?us-ascii?Q?2m26s5udzfxeuOxhe0d9BkB/x85GCqnuvd1jpFBh4zRnpFEB8H1wQkOS7/Vl?=
 =?us-ascii?Q?Nn6/946eA5vbTaUwyJmZnQ3INbi59dCkHQz+TacAlvgCJBWL00KgDxC12PEP?=
 =?us-ascii?Q?Wbl21s1utobgplPtUovJV93mnsDDPjAmyAkxYIusoVBwEOkbfL0VXj6tu1tm?=
 =?us-ascii?Q?sfv7LbbzV9tzDJKPw+d7uz7NEKcDSlA+xYzRngTa228b0iPo8Ey72I1CYzhY?=
 =?us-ascii?Q?vmrJfmBM3fB0lRKK6JeIKdBLq2DXchDcVZn067dXUXM7s93E7Bwi34Z5O0eC?=
 =?us-ascii?Q?ly4QmAW0OXvJ0dL++SVeerZHuJbbR89eM+39KkHVrC1jxIjEXl6enb64rnJj?=
 =?us-ascii?Q?/dudimeq2ZfPfSfvjlZCN/5CsbzJtmFqIg9+BRq2NftmD/YSRUpOUG7O+BA2?=
 =?us-ascii?Q?qr7LtoVMu5IokyRTd0bFhh27RBsXStFrWR/ooYWOb04sX4sq+9ExhwsXQ+y7?=
 =?us-ascii?Q?1vGy3Bh6IxbzjDXTorqK8errWwVqMC1OjpS93izDMj9JOSqxzTvlFleG+bQx?=
 =?us-ascii?Q?3VEv9go1+aenvt6imNOOkW2ICOE7r5WNkfvWBM4SnAV/35+4SzGEpSDiHz2y?=
 =?us-ascii?Q?CFmQCUYppeSeCfbyG3ywIR1nsYCtUdUEQIs3QvFDYXB+78rUJwbLDTbEkxq6?=
 =?us-ascii?Q?34sLXcygA4SEf2G0uAIcOhXRYX3cxdk1bG6hrKlqCPopU6yyxT1RoZdC7opY?=
 =?us-ascii?Q?/LASrwJetjG0qP8a3wQ3nGF14B461ZHhAMyiRqLt9rTFAzCzURZlrWrcL49r?=
 =?us-ascii?Q?3JK7dGrPFWjX4aaiK2zut6t/qGwZFJUwKFkNwyANN2QPw9ufvxQPmU5telH/?=
 =?us-ascii?Q?tVkzJ0p2tlaZIYyY6gISvL81ofUfq/RefyVr/XVp99QgsRBpjWBGd9bD30tl?=
 =?us-ascii?Q?mfHd+UYM4H3oTY90t5H7lMLYlKiyio36zx2WNICBnu9osiBXxqqRhLXQ+GqY?=
 =?us-ascii?Q?B+OqLUrKMqmE6RdIeftubIBow6uWcD2IbnF8s56Jdl/DsOuSPlHz1i8XUX15?=
 =?us-ascii?Q?9CUY2dU+OPbnSDR4toyrVC6nT+dv6lHKG3Jkzk3rMOvK4KNVzJPgZ7Bfcxrc?=
 =?us-ascii?Q?y2XvxdKffDlSVMpzDN9CETaA6WzU6TqgDLhbJWy85aMjijfPcB7AXr67FR5B?=
 =?us-ascii?Q?D7vKfxW22MeCNi0Ba0fYgd2vq9w+5Aa+tZHErojOktqhYiUkNH1R+A0ER+OL?=
 =?us-ascii?Q?olVCPS2p2GZxs0zQq0so3nkwvStac5jUxPl0/PutJb1agamXkU0VyZwRPLHg?=
 =?us-ascii?Q?BHQMma4zqrS7u1faDQQ3QtDpurQeArFvacJDBXilZ0F4z9qwh1UDHp/Bk8T+?=
 =?us-ascii?Q?Ce4bDpoDetaXerJGW7O3v0bttvJht6F9kJoDtax+hSG0Q3aogdZhgA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oMOWMHPuf07Gy9nNB/NGJ8GN/bwhziLsztZM9gJ7KINz7X4v1CutlhNaBwUW?=
 =?us-ascii?Q?spLvW+QqkarsfhJIppnJikQbqHSkSQOglJ5MDL0Msjbe1nDvtV7MncxImZDf?=
 =?us-ascii?Q?eBJPKk9UJZoSr1VVT8m7zW8+Wque/7MgT5MC96vSlGGjevXiH/N4dJiSNIXg?=
 =?us-ascii?Q?OgQE4atPfOLJKzJS+1lH2jlDoFGwjvDOaYH9F82JYQZMqrxQEaYLibi2T8td?=
 =?us-ascii?Q?8T6NS945yKKgTTpCQZtdVhxQkawWwbJkdlGKK2I83uk1+HZ+S2KFrh0cuN+A?=
 =?us-ascii?Q?S1C7iKaQCScSjc4VjnZVhGIynEroP04oH0+KHKF1mrYgH0IlRK02sWpXhfMv?=
 =?us-ascii?Q?9R++1NsOipzvlhOqB6FqPX4FBS2XB4wIYCyMNoMOeB8+GmHaQLzAB8PoGP2A?=
 =?us-ascii?Q?wA5O9/a1UsD0yrgAiwIsV4CxopSLwjMs61CnFCew3Uu6ADVdgAa4ZsUKv0v/?=
 =?us-ascii?Q?rfRVkQkYejqGvLmWW94yiJOkd1pN1f6M3kOPevMTCpozlpdrAMjFc2f6ubrd?=
 =?us-ascii?Q?uhIwbOR4l2tMMLfv126oC0ObKj9nxuePTMM3UmoY3g7++gIRTh6Zt3t8BPah?=
 =?us-ascii?Q?BeJYUsnPYam+qrtRLwr7cITDeW3THi4mraTrBBArMOEV8w83dSyjDIJrRVcR?=
 =?us-ascii?Q?cJdNRIv41FOojeFpiZcU067wrv3nc3oZCwDv5N3yt9JsTftuzGnFbFFP5VKt?=
 =?us-ascii?Q?SSeSaB1KzFD+AUjzP2v8/kiVOVVw3e+NKoa+tdUHkXNuOnu9SfnIx0Vv2EaI?=
 =?us-ascii?Q?b0WYBkzKkDdxb5BwUnfJSUWQhrjcot+NMbd6bENRtPkRyCiNJJ3AzcLitdfS?=
 =?us-ascii?Q?oDiGqk1xqawRh4BK8eqH8NLi6TBKJ/nlYq7sLo5R/kBsC1WiWY8jEFcRq5Ll?=
 =?us-ascii?Q?h8t4T6JWp5RWWXUTQvjjYMLpW+j1idXUoL0zJUO/GfXiJttihyNisRp+TWyp?=
 =?us-ascii?Q?F/yT8BlNTUMt1Dk5NDxSsYbf2dz1qgDwpIy3hcr8+UOFF/HwALy9bJndySdj?=
 =?us-ascii?Q?EZLL98aXPMFFle6clpoxfx4+r4DNinyLgVdd2IMezxkjngEjze8WfCdKQ/b+?=
 =?us-ascii?Q?sTmDPHsi5WQ8nfVUerZIjkkmFwpIyL245vwFj98VWsQRac6cP5oFdGZtrJdX?=
 =?us-ascii?Q?AgjhCNcgDR0r7sA2/1/GuhRRkPzBesIVXM5ZRWopBzJuUdaQa4gFW44wvs0a?=
 =?us-ascii?Q?9bNXUOA/rGxpNlSyqLWqPf+bPUPgbyOQ/zyURA7pJ882LRoUY5gPZ9rcMRq4?=
 =?us-ascii?Q?0A0QPlp/rCy9FBhuxMaGX3pMm61CdUpitZaQbXe6R6kmkaaoUf7ANCcF35DI?=
 =?us-ascii?Q?SNhNuviaY4l4+JuaIHbr4NmWcJTPNQvbYtsnywGzwybz7VGnWMT+mPk+f5rR?=
 =?us-ascii?Q?lgXrNIykrVv1hWvTD/raihaZJI6SMbqkejagmHJe99NS7KtG+NYv43pKvjPq?=
 =?us-ascii?Q?LxevcAo0FyEfsoK0hNWMP8apNbVQJYJEaK0jh1nFltWvKRjTtssnrPkJlKEt?=
 =?us-ascii?Q?B0Luno4f1bUqArG85Fvhn2hmzXOiLKvDOD9paHP6am5CtzUvgj7Xcyuq/a5q?=
 =?us-ascii?Q?dkwsCFuBYuo9dPH6/bYYf63gD/I9nVZtWNFcFDoZzsSf2jMzhGXJbLjryXyP?=
 =?us-ascii?Q?8UVcawuAMzC05Uf12T/Cw8Ud9OWq7MybMmThwPz3EC+vs3n/HgvcetR/mZBY?=
 =?us-ascii?Q?O3sDzxAoSTS+QCOc6ma2GWAxQcYCvR8kI2svZC0fpIxAT9QxCJER4UZefSfs?=
 =?us-ascii?Q?+M2Irp0s9KptENn52xa0y+fg7ytkTS4uTXErCOPB3levWjW8r2/n?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e0f0fc-6eb6-4fe6-ef7b-08de4e989ae9
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:30:47.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUmFDqLSrE3xhz17BcYWmA2iPtNMLvY+kdIOhj1lYqyqTXLOubV3iLxbcKj67pRVXUvjfqqFIDJ5GVVyOQ34xNEt8X5e3KH4DHUc7ifIXMJ6HTQIUzFE7j+n/3qsJc5j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21460

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c320592f3f2a1e6a4e69e5db8e76fc66934a0a78 upstream.

There are multiple open coded implementations for getting the parity of
a byte in the kernel, even using different approaches. Take the pretty
efficient version from SPD5118 driver and make it generally available by
putting it into the bitops header. As long as there is just one parity
calculation helper, the creation of a distinct 'parity.h' header was
discarded. Also, the usage of hweight8() for architectures having a
popcnt instruction is postponed until a use case within hot paths is
desired. The motivation for this patch is the frequent use of odd parity
in the I3C specification and to simplify drivers there.

Changes compared to the original SPD5118 version are the addition of
kernel documentation, switching the return type from bool to int, and
renaming the argument of the function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Link: https://lore.kernel.org/r/20250107090204.6593-2-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 include/linux/bitops.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 65d084abbc2c..9be2d50da09a 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -228,6 +228,37 @@ static inline int get_count_order_long(unsigned long l=
)
 	return (int)fls_long(--l);
 }
=20
+/**
+ * parity8 - get the parity of an u8 value
+ * @value: the value to be examined
+ *
+ * Determine the parity of the u8 argument.
+ *
+ * Returns:
+ * 0 for even parity, 1 for odd parity
+ *
+ * Note: This function informs you about the current parity. Example to ba=
il
+ * out when parity is odd:
+ *
+ *	if (parity8(val) =3D=3D 1)
+ *		return -EBADMSG;
+ *
+ * If you need to calculate a parity bit, you need to draw the conclusion =
from
+ * this result yourself. Example to enforce odd parity, parity bit is bit =
7:
+ *
+ *	if (parity8(val) =3D=3D 0)
+ *		val ^=3D BIT(7);
+ */
+static inline int parity8(u8 val)
+{
+	/*
+	 * One explanation of this algorithm:
+	 * https://funloop.org/codex/problem/parity/README.html
+	 */
+	val ^=3D val >> 4;
+	return (0x6996 >> (val & 0xf)) & 1;
+}
+
 /**
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word
--=20
2.43.0


