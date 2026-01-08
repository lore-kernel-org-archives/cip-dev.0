Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F73CF6A8F
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:20 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2993.1767864558230451415
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=N1XJ2rAH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.61, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+/BPYCpDiUkXHKb5AwhnGF7Ve0AMxul+YYskjEO2wIWCwen2Y7FL5GFnDzbB7Jl2l3dIr3HvMKacJInguZbLr31j42W4GlxpzqTa7YGtj+fQ4VTH7w9ulH4xM4PTBOX4vio8xr0GBhx7/DHV6160zLpAJ0IFAD/6yO7EDXXCpa19R8KRDQWQu/aEbznmlAumRjbEYRzDYEROg6LV8MEFVLiUuwvrb/5Xivd+KnHo3zQ/l9FgP6uXcS8SBPonOzeQoLT0mrEvlAiRHh1rkmsUG4Kl432GqSGdvhFDEBLNfgnCTQKeBPKb0w1JDDXwWnqLDgVdhMxCctVjznsHEnA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mFPqfw3mFDCs2aRxpnDs/svP3OfK61ychJotsm39e4=;
 b=dMzarRBH59K0pwa6uGN5UkcPTtv2D2fmvX0CVJTEWfvgQ1IRO92dyiVf7PDOKuJLuz/fppTZxnjIdNuynrx2rTJXKKXud3awb9TuJz63bUf9rx+wQPj5q1hzrlklsFmnV0z/m0HifvnrkrPTCVbzIKyDURaAozO45NFG/hywe1iAuMxn24wdahUWEmNdvK110C9EoQhpmo+JGBt8f6QpSy2VuhnKyqbWmcqB9FqseParZExggvxyLH2FH9BfyD/Lzbb9zGzt9sHqyGVllvHrfThr3ctrk9/XoSPJQyb5ekaisActp8xrE/9Rc0mi/sKEOpnZRUtbYwF8qpHP6LAWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mFPqfw3mFDCs2aRxpnDs/svP3OfK61ychJotsm39e4=;
 b=N1XJ2rAHYI8yElqbUY4Z/hJCHOUmrZSWkjVJ5hNG7/T+n+AVCJCjUY6jurRGmw42/NjjETVpqU62lFifTu9KbnZxeI4K0O8gtoZiMlXOt2ubpcTmUQcrn6R3pqHwYWEyuc98auHuPgd01zKwV46DcccSzMrJ7TtYOy+DTw2/VrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:16 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/22] i3c: document i3c_xfers
Date: Thu,  8 Jan 2026 10:28:11 +0100
Message-ID: <20260108092823.489287-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c1ba6c-59c7-4132-99a3-08de4e986464
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oyqvzyyQ1DzVU7ZYCfdO4FEVyWHS4Qrohugw1HSHGPONcur4fw00s8wUxMW5?=
 =?us-ascii?Q?kvu1dn5V2/vWijYxQVNASORz82zNORAyZj6JTG/R6JEH+sl6GgX83x8My7oR?=
 =?us-ascii?Q?O8GdgqADHKh1mK7m4vE35itT3j5+9hV7MvRW52N9N1dBSJv8M6lEUGk/s75Q?=
 =?us-ascii?Q?VPTCow+yveceWuuKoQEIfYWkLOHbkJ2xqK1YMjyffSubg/VDrFFDWFxHybkj?=
 =?us-ascii?Q?vzmI7UkbyyI7ULqU08+N9Lj16HgA0TWSo5dahqs8T3YaM/djrrorSFbFhFCG?=
 =?us-ascii?Q?tpP0vsjgyjU1W0wABX19IT63GtCUGVphldIbVqMObvD6JNHgPcxbmGOilp64?=
 =?us-ascii?Q?IHX2vec7KOUkTOx4WVkqjvDMgmHQtPXa/m8Yw4eFQYGa+PE2shfhnr1LQFtu?=
 =?us-ascii?Q?P6H1OuBBQqI9yAaR6vN1K3KkjtI142ppcQHTAZILnY1I3lgdSpUboWVC/1+/?=
 =?us-ascii?Q?UHzR9cqjyjuMebPZjZ8kd5NA3UVD0kIv2yOfe8YJxiu/KK+yOBpC0XWCQYTH?=
 =?us-ascii?Q?+SLW2LvCmaqhIOgxEvuovre8e1IkFBf3T3tkEMdSFD62dX34pyIEX/VD3PxP?=
 =?us-ascii?Q?TWEdXymbTSk4skaqxPzaumDZWV9z6j9X35ekk65FzGciPYHnlvrWoiE3egDw?=
 =?us-ascii?Q?Bqw9TZhkUj7TEIurqvRs2uvMqN1jOavdE4KIc3CBNtwu81OM1xh4qfxoxUIZ?=
 =?us-ascii?Q?vljSiJgaiwvIbM/9y+C2tiHLaOBkyMDNC5ZL3mPyWiaQ3LJqZcH/8tx94B/+?=
 =?us-ascii?Q?fteC/poj5W9s5jX3YfGmeBbSu+r7/8Z16wUYOGXBDETyYU92wjyupcfNfaeV?=
 =?us-ascii?Q?1xWiHE8hShM1r42VfgwaLcRAZ7jClYBwwQ34n0pvBViFZxuoXvh3h2CkDHW1?=
 =?us-ascii?Q?bNC9h9KsABC/ltRldTPoGDVt2comIEZU80twzxLgFxowjvcv4P3DG97WW8ML?=
 =?us-ascii?Q?Zgt3c3YoqerCYuWb4o0XFaUE8m9//xzUSeAQ7K8b8fkT/WWBFrkUwFeIBtyI?=
 =?us-ascii?Q?IQseboomw+w5sGjuv/raXcR6u+IwluHCpNGIqRzaZDW2W8pqEnGkGDtouytz?=
 =?us-ascii?Q?6PGmSIlkPAKq1P2++heFZsbCGjAierYqGbzxqaVDcBJEH1q1LG2kOQ2g5v4n?=
 =?us-ascii?Q?N7JlZoOeYNz8+/ITHtwePOSIwWhr8jn8JOAKlPwybyJFrKZbOGfcmlDcr1kq?=
 =?us-ascii?Q?qDh3tLh0MVhsFNOJktnycVdnkfTpBJADp17OWWMZ05v1kZBYMARAnF/7Cm0J?=
 =?us-ascii?Q?yPx20sAw3n3mcjDRIuZu/h5ls2mB1KJ0xrygGG+NnB0LnU4R3LbuKk70UYqV?=
 =?us-ascii?Q?BLuNYt6vqQ7ZohfxzzP2azg81GijKXb0KHbf6LP20l2IIsr/jVX3/rTe5tOH?=
 =?us-ascii?Q?y2wK/XsmUBAUPTb9w39w6pWdzL0wa0JrbBmQ07Amw+9b9wUutfucPnfxy5Yv?=
 =?us-ascii?Q?+0KEoNeKUR2CF55RiWrdJ/zxswvibnCj//ulqRMGqy4QifJSOZgIlg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ShmzWcO5i0besLjdEN2+jsUXveC6Kty1YG9b5MH4fU/RnSxESNMZ9P+QNBQ7?=
 =?us-ascii?Q?b7tm3YLrieYwAZbYofUMGfIXwgI10J7lIFX0Z/kInLFmMh4bbJrte5UUDsLW?=
 =?us-ascii?Q?4yqqdxia7Vtibn8ZU1K8vM5vihbhlqRYDPZqil0rOAAOUkiyivv4ExWYoFCX?=
 =?us-ascii?Q?IAx1klyR+0JIiDEmPCJU1863iff3w1HR3Rv+3jOvZ65nkpWWOQjjuzf2vNYO?=
 =?us-ascii?Q?gv5YB+3Lth38q5iZdZwOlwJQVTavaRLkEhknj15NhAUF5xKdS5j3qlz2B8Rr?=
 =?us-ascii?Q?+Z/sXx+NJDmFrzPKsuZV5rI741pnYrz0aJEJ6EtEzUvd4iQ8vndw3K6uGgq3?=
 =?us-ascii?Q?Z2ArfSFezhF6lb3vh9uhAqzSinoLrtjjlFqdZnBElCWj21NNkJaCh7/nJcG9?=
 =?us-ascii?Q?g71C9kdFQ8616VcIw3Kpyu9L45Ej7h0RzcoEauMe7Z/anTIaoo4UEERg6wBZ?=
 =?us-ascii?Q?/Z2+IZaezJv88WUaatViWMCqnLCrjeJ7MWsTrCBYSuh6KT7zJX6FT8TgqINQ?=
 =?us-ascii?Q?1CrjJihW6NP/ppX4yRaqUrbWNcv5eIB3AGndDPYly10ekek1svr2zJkUMVN4?=
 =?us-ascii?Q?uH6GFXdlhUi/koubsMMJmhYvgCTRY0Bru2V9KF+mvmE01S+mvIy4uFsqAl4+?=
 =?us-ascii?Q?1o1xpxGv1ujA3p9Hq/AGd3/GTbxvCIG7xR+8yDUAfMuY6sbdLUjL2tsGbmjb?=
 =?us-ascii?Q?E65V3xiii2FEhCwe5scf9tKZhk4Ywv1ZAueoNEBY3PLMg6TGXdLOZy7SioI6?=
 =?us-ascii?Q?51pIFr/vNcPC4fnqIWwlsEKEeptquZUWMMkHa2YAnbDeUvIgt79EsTppRkMA?=
 =?us-ascii?Q?wLe/pq4vPuwmCxTokIC8ADoX0bhkVs7Pr5jxrZioEZxymZAEaSjtY+p2RRSr?=
 =?us-ascii?Q?3Z4QcRg4KTQPJiZC3CBULOQ3gpD4ZJbIbcr9e13pWu/yn+kmL3frtbn/xogs?=
 =?us-ascii?Q?ulUBof2yQFZod6yCSjpwFn1uTvqYRPt8ImxSShX11UuQDivHPH+ws3NxB+Z4?=
 =?us-ascii?Q?OvnYaCSOHKScDkjAst22RG21ACr+xmY4bA0Cpdz2hk/WBhg0iU5DBvaNFLvc?=
 =?us-ascii?Q?Czf74uyFkyGsXhSFmRuuZJTpmkrTkfjeUhZ2yaGoVzjiWO9rAqYmIj/e01J+?=
 =?us-ascii?Q?sdmji2Gd5looGHjlHhGrGvZA4R5plnEPq8uQ2PQBqWfrzde42V3GvGHYOiZP?=
 =?us-ascii?Q?uv09I58B08J7ZVJmnlF55SPqAtvGRayMyIYbpNUpme05XVMdFGz0S1Lqj5XY?=
 =?us-ascii?Q?Rnrah56x7Nq50BjPULm8UjZp6PIJCZ+QsneTVxduf7Q+Myd7hDmSQy393pEQ?=
 =?us-ascii?Q?Ko5eV4ne6cmbBYLrH1R0ymdVAzGpZbxxiQ2jZTkZO3TbKMIi9NhTh7xIRHTJ?=
 =?us-ascii?Q?Q16RVElaGI/WByLeYlNjkGozaDy4x7O6k1og2ZkMzElAmtsIxlVeJMrIBSNv?=
 =?us-ascii?Q?4ZMRBV3HauwSjHGtfvDD1Ylwdop3VsN2Vm4PhFdQ35TG3dHkeyDGQjdr0MyH?=
 =?us-ascii?Q?kur61KCCztKgwuPKIm/PmWmwRaumdPHlwbjPgXs3e2349vMYNdY7o9lRg+Lg?=
 =?us-ascii?Q?QQa6ZeIMtbkHLTDuG1IqlXM57Q/0V3xzuxujW1NAXtjjbRLwPBkf9e9zHqZ6?=
 =?us-ascii?Q?fcudfwX1VxONpE0E30nr3s2U/6x2OeYvUR3r6XKbiEsTStetx9XAQZQo06dX?=
 =?us-ascii?Q?TTP8eb6+72YKd/fPi98kQIoNulkAJycrZTEhYYWFQnuXQHpBPJy0n5N/RRY9?=
 =?us-ascii?Q?o5FRs1MA4rZwiS3hewSNuG4avOhH8JUo1CggQw2XviLWbQIAeNgj?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c1ba6c-59c7-4132-99a3-08de4e986464
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:16.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/6jeqxuC3I8XkkbsWDVNCDx8/PiI/9vaNo5pdaexDmjdT03jIj6CSgUVaZUGFov/+MU3PECtYAb3dD6gyk0YcqXwJyD+bIvMjD7ut/F2oYRUF3K5LttdiwfRnZA8o6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21446

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit e01a8baf60af43f6f87a5850dee29cf31377ec25 upstream.

i3c_xfers was left undocumented, document it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://patch.msgid.link/20251202153804.2640623-2-alexandre.belloni@b=
ootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 include/linux/i3c/master.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 4188a6bdca12..1dde400afaf6 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -409,7 +409,11 @@ struct i3c_bus {
  * @send_ccc_cmd: send a CCC command
  *		  This method is mandatory.
  * @priv_xfers: do one or several private I3C SDR transfers
- *		This method is mandatory.
+ *		This method is mandatory when i3c_xfers is not implemented. It
+ *		is deprecated.
+ * @i3c_xfers: do one or several I3C SDR or HDR transfers
+ *	       This method is mandatory when priv_xfers is not implemented but
+ *	       should be implemented instead of priv_xfers.
  * @attach_i2c_dev: called every time an I2C device is attached to the bus=
.
  *		    This is a good place to attach master controller specific
  *		    data to I2C devices.
--=20
2.43.0


