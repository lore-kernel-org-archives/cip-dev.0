Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.430.1795708441471882653
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:54:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PKmggKph;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2eAkSP9gTiWCF4LuWx8IokWPdtNyTnKJ4MHDeLBgihxk6pFJCNio8TPG6cf4mAkapdOYqvPZEr5AXBQxg0tqti68pXk2WAUf5+MTiMojq5J4SVtr2+U104athPQLoEHp4dntxfKEXJNHR7OwiKDQvkK9expAxsvNdgT5HaXn/Xl/6A/m8wwGeBJfWWwvJKZ7uAfiP6Dpr0bnyTFTf9IHoCyEXzJNqoLB26ze8DkrLzOVfoRtZQpQApBlgw2SlN2sCSdNmU77beJTa20D9m3oAvIAYw3xONiwjfS11RGN5vR9G6reCBhUqAItDQ2XjTRy0nX85WVr+kIMEUkeLY5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIvLtemKOE4F5pVdokAYTcDSeesji9K4BogWNJVu1EM=;
 b=DL07JClHQtpc1n42uFNATAfnN3ZroG/n7o3xpImoImybzyEAJtkGgdH+uxTNxhAXHde2N/V+3xBTh9oKWJadKJjWCmyx02TRs6/f3yQa1gxEtyj5txvSPe610wcfgD5NqdASIAOEnFAs4HgQYSK9jC+oWX9m2LCx7tESjBUgwCKHVTenOqODWL5BbbEg51YTiuhTtrN/ZQEU8azVlToL2KMRHcWFAiPsde0JrcnrVOFx84t5eWid47Xsz8yXoftsU6liqHhP5+FVHaWJ5aIKGKo9mzZagMGSGIVKptexPr/kv6j7jA1UbhaaIPdOILCawjJCPEB9dFY37nkkFzu6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIvLtemKOE4F5pVdokAYTcDSeesji9K4BogWNJVu1EM=;
 b=PKmggKphaR55rQrG+NN1/NMY+3OWIQ9vcaUy0cvErJG5jRsORkWZsTG06CwEo/bojpJ7jBSC13DrFK+XHlHrNpWKsVY0Ueq8spFtPwda5bmy8B/92UBUB+huB5uFIpOLzwcLnGzxRVw84pMJryWDN3QSnNp5dBaP9hEcHrj2StA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:53:57 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:53:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/12] ASoC: renesas: rz-ssi: Use guard() for spin locks
Date: Thu, 26 Nov 2026 16:53:12 +0100
Message-ID: <20261126155321.3834347-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: 3972b6e3-60b3-45d0-f0d6-08df4bd57b04
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yHxF7WRxuEPUkPJx1iw/FgNC0Z9NrLlvZA4B/EZ9wdt+ltd1g7yt0z9hfhCNPABnJDcMo2eNpvMNPeyGkQl0UjDuFFKdsRFELVN+LAUyN4xZ3DexWELFtvsfi1LLuKeK38pdBp/k6VQPVkXbhgmduHf1W5Nc1zk1uMLvgYqXUCRpuOuuSNExoVY8WFklnKdaoB2UfWZ8zxgXtb8DoMOICbzfiNQxaIiuawWeziQ7ZNybCL+OZRQSBqDJI0YTpmQ+bOdFAnXKvPY/GHEC41kRDbXqmMMJRt0WgfcOwGw0HsSUvRbhBviJ3RDvG+6AUVjqdyCRH7iGWqlXHuvE9RrNlCcmeJW5rasfSbBfeLyhAAXlqCrr/QXk35q/KQH6UfMIc8O9/H/b0kiCUfJ+0MCGjmi3qyTkOtjHT7TVKmgqpF5PHevVJqbcGMEakDMKT/toO7Yd9zTJ3+cUfWuHG7WuCw/I00N2yGkf07QgBCZBDtfxxugj1V7CDR14KP6sZ9uQjymTl1KjdhnTtyRqcHoPYqdUYA4kcESetibg22FM4CNddBEbAmXHvnuHtbvRXmpfN8d/ehlMLqOvltrcMwhqE/OYyCILeFVSKo4MEz5ZKwEjGrnT34l0ALyEE5xE275HhhcnqFq6/l728BlczxuZPhox8a51/jtubSggpuyy6Hwx9MjtreIj9F34d2pwCbm4tQCxJmnx6mpCWHusc21f7VeX4dfayFnqxr51jme3Y/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PjJvpYPBgqLlhKCPkMVaTFNe0jAO8JxXdmohvnAkvfyeU9xyVzsWwR5zzepw?=
 =?us-ascii?Q?wX7gpCPHMV1bTcznJU4cff5f12QFk9wzF/XbPb8dgmSOurHcWKnO4vWcoTcA?=
 =?us-ascii?Q?ph1XhngRZGuWrlDtMeY5n6aP5P0LMuRKhVBxXCIVu93KU92ul6ux5URfMmKK?=
 =?us-ascii?Q?zDAZU1xcG7ECrwBKhkiU0HRCaqid7ovNTklMfeJoYRTOHNv/5W/Hk/NE3mC1?=
 =?us-ascii?Q?8lYI7/qIWWKWR6pV0gtKB3kkYTJXeERG29AvZTCkJKPmRIcVU9rom8J+y7sw?=
 =?us-ascii?Q?bdnXuxqw2YHyxTUpZiqlPeFv9CAeKC3k/zkORxAzIanEGZ6xnZdQV97IN4bE?=
 =?us-ascii?Q?mnnsmRUrQYHkAEJRJLh/20mdtlM2+LdyxkL7TXhUYmgo4AIoTdvzd1GZfx2S?=
 =?us-ascii?Q?4n1EYcgCyz6oOXfbFwGOZ9ehhYkC4JSiQl7pRfLyhtqCvGv3XGkuIerCUxW+?=
 =?us-ascii?Q?0xhH42ojqedcpxI7ooSgDLBU9RFgK737aYeGekXQ0Ljzgz+ZLUiEOLgvdurh?=
 =?us-ascii?Q?3jiK7CLbe3IxEeaLps/5AoUxJGaCyAcJ0hut830o04dTxL0VqTIyQVUnPDAr?=
 =?us-ascii?Q?vFqDFWQl16U/YdSGQL+xe9IVAoD/dXf+DQhN7xof0j5IiRabMd8jBuVdru0E?=
 =?us-ascii?Q?dzpWR9BVIFcYGc4/8MULZRfd6BnjeMxBa3t9YN3ULCeIQFhvOFY6w9Eon8iZ?=
 =?us-ascii?Q?1Dbh+9AZH04ycvUTINbSCuV4dD9a7Dx7EZZJDV/AXjNSkiq0LUj7K7LuC9dG?=
 =?us-ascii?Q?43+mQSObcMcpR8a70UPs2B+Dqy0Pu45/LNKPWhRISQKMDT4tx5rMsNVY1rPP?=
 =?us-ascii?Q?vlppoWGizD2/MWJR7vICAWLCZcOXpwboBjj3mu3rUxr1rOPjrdqak+lgMFh3?=
 =?us-ascii?Q?SfYazBIBI9JxKwgm+lmyZXmV879nESCyuQw7WBcNvOCwOhpgx4U+tq/+EYe2?=
 =?us-ascii?Q?bB81W+O6/Sn96TCwj1UrYReZqJIYCr+fwPTnnY/YQwriqEBwD36exqedaS+c?=
 =?us-ascii?Q?lHrVk+o55auKt30stb1dMoLLRZJjYccXc053HUVG/zKogXzKIZA0mOwlgBdL?=
 =?us-ascii?Q?nwmO0JDCyThKUvWx4C4zg7lsaEZyzzhd7KProx0EIerZFKJXBJFUX3cOn/LX?=
 =?us-ascii?Q?Mw0FFzCnr2GwQAmtBw5PBoKADsIEnlXW+EJ2V6OimqLJUq4LJsn4j0A6+d8c?=
 =?us-ascii?Q?s7Oh4T/Yn7844sRXeUnPdusx8dS4JjSjG6QzY6fVkdXlDPgU8+nvPFzsKxbp?=
 =?us-ascii?Q?iMoBNHjw8ZsjyUVtW+PSdAXfSEpjFQiaC/KWlq9pbrnHRtn3CffnqiA7rnZZ?=
 =?us-ascii?Q?TRr3yxAcRn25rEUI73svTzgkmiz6Ckn2CFYUnbylZBVeNW96KafT5wy13zxo?=
 =?us-ascii?Q?C4JveRpXyL6mHbG8XSilIox4L68LgaFNIuBG83lhRJQeqRkD2ClmNfQWpaOM?=
 =?us-ascii?Q?DwzgWk9yz10F9X5IM32S+HfqZyP3gQOskn+4j2iZfJ+jFKtWiZNmylVE2pUh?=
 =?us-ascii?Q?3LqgB7rH2JTySoIlJSG5uW1MJt9nvDMnDvdUllLVdvr7l5z7ShKrvdcvhxQL?=
 =?us-ascii?Q?yebB5V6CoXvllMsYtd5mkoU/sbV0w5yly+wBh1dMHgU7UWzDhaajDQrjhiVm?=
 =?us-ascii?Q?uBuTIhTVavfC9JTbtmQjxDcPBomfOFJU99PMGZ70oeilwfqXmiP8Sz+RRvPj?=
 =?us-ascii?Q?Qd5kCb4fEiwas62vb/6iKuKGlFkEDubTECDBOtJgnLjSmb1MaVlAwngXn/eY?=
 =?us-ascii?Q?mB4+falGxOoT7wT5Qx+CPvuKSqP+TOODRL/SgxWCgqhyojvqR8wn?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3972b6e3-60b3-45d0-f0d6-08df4bd57b04
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:53:57.4437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzKhhUGnwV7EXZvJ9zPbZStPKBtfcspWUenvkCVHsJ9sEV6FKT0QbxF0xNHM2JO83OWYVg4Lmw99AjwPTuz9GSY0C7z3MQR+q6Wm/T7LEuZ1ofA9bEBgF3WqLqDtCFZv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25181
Content-Type: text/plain; charset="utf-8"

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 7d083666123a425ba9f81dff1a52955b1f226540 upstream.

Clean up the code using guard() for spin locks.
Merely code refactoring, and no behavior change.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Message-ID: <87frcx1yp5.wl-kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 0438de291f81..d1e21e08bbb6 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -206,24 +206,18 @@ static void rz_ssi_set_substream(struct rz_ssi_stream=
 *strm,
 				 struct snd_pcm_substream *substream)
 {
 	struct rz_ssi_priv *ssi =3D strm->priv;
-	unsigned long flags;
=20
-	spin_lock_irqsave(&ssi->lock, flags);
+	guard(spinlock_irqsave)(&ssi->lock);
+
 	strm->substream =3D substream;
-	spin_unlock_irqrestore(&ssi->lock, flags);
 }
=20
 static bool rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
 				   struct rz_ssi_stream *strm)
 {
-	unsigned long flags;
-	bool ret;
-
-	spin_lock_irqsave(&ssi->lock, flags);
-	ret =3D strm->substream && strm->substream->runtime;
-	spin_unlock_irqrestore(&ssi->lock, flags);
+	guard(spinlock_irqsave)(&ssi->lock);
=20
-	return ret;
+	return strm->substream && strm->substream->runtime;
 }
=20
 static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
--=20
2.54.0

