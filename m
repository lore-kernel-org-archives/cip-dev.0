Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F465CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:06 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.19])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10996.1781685357475207755
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=oKCJi/nu;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.19, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMZXT7m6g+bz+eqimj9XxDu/i35pjFHxVWIq81UE4OVvauLF1qd+G01DW+JyAcenTfbr1PeZBAvK3Of/eqK18TPUTcd4CEmA+8CiDY4kSKFjoBYXed3j/vBFlNPInVMa9biR1DB+24nHJAV+/RMoXnZzr60oZ5KqAU0eqbLWDDSrk7hxwxSW7yh7mRDY2+vNC63+BjrTdYMisexZUoaaXejsv+GzrcVUBN/inp++Yo1N6/cWfYEI1q0odSAjAG6yMIjbtFpfpBenY/vKhlbCc4XUNnZ0uLSmntAxvMGUQr3EjXCe0OxCqwrdlOKDnoxKM4tLoX2AMkLj/+kWz9w1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J147OvLms1QanZmmbKZi5pj4OtdvUfJD7I+eQov+wXY=;
 b=ttkNPZi1sEmgJoeUh7Sxtw3WsbFZYy6MN3ihfXAw5yhTHXxY1masOk9VSRxPjG7Trl2n7RQ5+UFHCV6plYDm/Xp+Ev+I29ZIwgWOjE6eEYTABoN3d9dNz/b2RySZu4hl2ffi1gJc+8cTkc4WwRi8Zwa4jeLiexqbsBDo0vNA3ky+zN4OpBDKr0i9QyO4FKFmWUJWAPDYTRVUiKuwbHtkjCCoWeBJBGCg26ILXQhSxx1NGbun2Cxriwp0RqlgbhkWutdZM1/G/RkBO3+71nMB+oI6BatEXjb8RsNqn3amp1d+mPQah6coyI93BCRNzlx9V31hgFhc1KajNrj4vrxHEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J147OvLms1QanZmmbKZi5pj4OtdvUfJD7I+eQov+wXY=;
 b=oKCJi/nu90GAkgw81Sun2SuiH3g4y4FBMzLg12m3ic4RXyKxCNMmOxIMZAWFcSS+uFVoeejsK1D8jziy3CjecvH2ByMr7eaoZDxJKzp4/YkNGmQcb+A57XnyhyqoZD8D3DUzusEzGL5UPqhM0GXNXQDjfZEFIoHVwM3+f5mfukE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:54 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 10/24] spi: rzv2h-rspi: do not set SPI_TRANS_FAIL_IO
Date: Wed, 17 Jun 2026 10:34:48 +0200
Message-ID: <20260617083502.1074160-11-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8a8cbd8-675f-4291-22cd-08decc4b71d3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	qG6K2oy0LQmpDcP7scSXXTwcV2x2mM5CFxU2eVnU9Npfue+BGRkhR30Qs+MgjbbD00OBwPukdAitoHTv2R/B3RDeVh31LwAuBcH3Z6sx39ahZsQ6Upwk+4e5mKmY3I1W0ThnEuRP3ZtAkElC1XmLZlztM3E0H92VAVmaP0J7L5bWi88Cpb8P8R+kIWT0vdcW+mOS5Br/zytZVxYLaZYKI4W7mjnRpNz6mHjOpZmleJewnnvgnJUZGfPSukdtaWGdy8Bwvwv5d2rbrMA8bQ/wJIup8vloVUxaFPBb0dhM9AibNE+bmDrpE3L6w8inFCznrNmtFRbKdRqpkDaUruHk+vjKRiLszS3Z5xJY0vykBN+kKIyyDXHH+eC7KOTRz2FDJzg/ziL3rInPHdHuYDPnNiY0qimEtLtqc4J7Jg+h4KJ2h8aHVk79u0UG0XNwzVz2/npON8f/m/FGrbrMw7jrYlxp2AJQBi8jIN2s86bUT9Usnq3fDOoT2BIb1rKP5rFyXhuXYTBUOUyOWDJoicLgsAAHqkxOREPeYCcGsfixuWXTTjF06g4TsKM8gaGBcNjxIk7cFRy0Lv+SKRbisMdFZvci5pSXr5leaTsSWW1NPI2xJNH+Sunbib117gKLfC206ERFunHYrA36m058Sw0XBe+hqdAL6dCk3AhBiVCJZRK36hDWUa2l26fnNDyjUBCj7XpbC6gEc/EJD8+qWubHyQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9sH/ALDklipolqgL2MPKjYa+7MPMbhBdQByNFPc8ITlYt3RoensBY0vsmyGz?=
 =?us-ascii?Q?CT96MuGa0ZLxPwCCH3WdPHhnOkxyCc9GcXsC4k/M9jY6q6RFIWBOEeqGcUZo?=
 =?us-ascii?Q?Z7O3sEPhQglMEFB3aj4xioMDMyY+8rONKNfPjRaDTPe+yuOw+h5746g//5w9?=
 =?us-ascii?Q?r9wl34voa4a/9nzkTRoEj/uOp4YvnugkDJXrxPvzZXfcrcC5e/zVJaX35eDh?=
 =?us-ascii?Q?ARpuduaUqLQoX93bd1Bqypo+poT0MNBJXHmJIjpQy3qyJceAYAmBtslKSwW4?=
 =?us-ascii?Q?SD8IHYhiyVPYUySSMdoS9TKI/ADUtcaZKqGTg35dukurrGYmb5aKG2gwL6Xh?=
 =?us-ascii?Q?nJIc1f2wgzMnfHY7fv76uvdbqUWplVK8NHlaivRN7cy1WO0C0UmQ5EcmYFcx?=
 =?us-ascii?Q?7s1PePEvthw6t73OVtZzc+AvCNcAZNH4T0dr4pKw7XtHQjjX1shGqkujl6S4?=
 =?us-ascii?Q?MhgAkGpxUkhnIyq95ANwWL3R4ZiS54kN8N70FyjUdSfjRJNnzoS4ROZStZt5?=
 =?us-ascii?Q?I8RCkYXTMz9mssSphKisX6lJjtYG2Dpse8lZHmk/u7n7EzqYi50vMub3oVQh?=
 =?us-ascii?Q?0K3M0NgFcTcPOe4ZlhpWdcX4cih+so81PpAha9imgqeI3tWERW9KwkFuKi10?=
 =?us-ascii?Q?+Jb9BZdZ4nnSyjRJtOM/agN4P7YT7l4ly/1R2l7t3YNK3Gzh6qSjM7yBgTcZ?=
 =?us-ascii?Q?Ybq6izbcfk6cjOvz1hkA0pLyLf86Hdr7Aq+eKhWcHdD+d4ZTNennxxV22M9N?=
 =?us-ascii?Q?Xs+vSjGt7Ql0aeml2rV3r/UTJiBi0srSCayZjT6h/5TnpT0qWzzv96D4dv1I?=
 =?us-ascii?Q?Jo2KT4Iw8n5T/DSQMjfQvGX2q5stkWZTCy/qRrJMeivgcGjGUs5hRLkspy7Z?=
 =?us-ascii?Q?3g2L2WO1oPNXOYQygtajv73iu0hvitwvoL4zMJ/d+VMAJiPrCCWjuRVQTl6s?=
 =?us-ascii?Q?+/Pofl8JBpWj+mh9UmS55wXYAJOYMeyQ4WacILVRJX8zgnOYIzEuqIs4Jc5W?=
 =?us-ascii?Q?lxQ2JjYD5pcTpJI5EsXoTFNENnDKExsjvLSh7mB1M9FAsqQy2ajDPp8zKOv/?=
 =?us-ascii?Q?AhYEbVZ0PxTwLypuDXX+EkhVPbGa2AoJMNh9lczeD66jSdMN1AF5KWpPJ7YX?=
 =?us-ascii?Q?HTNZHsRKh9cLP4beRV2lYlIwDXv6PBfIadjU1juZKxFCDpgmMEX7loR1CLYD?=
 =?us-ascii?Q?kv+WGmczMePtqcnexkOdvylmR6nzY6eFTNoxjtpVWxqBH+viYGAcoWNksEZA?=
 =?us-ascii?Q?HOPkJAq+/pN0bevi04cHfXTv8VoCn41MHAHoQbDINsInEs4+vQJWvKmmVfcD?=
 =?us-ascii?Q?SxE7wQr+9L9CJDzKm/eDGhZ0P194+a4zO5D1uvuXdRnDqYOTC0DbgbojEqfh?=
 =?us-ascii?Q?dWpqv7TEvl4FQsvpV7dQQaNRVd7uZz4Oe1pF/qKJkPfLzTpgDw9KGcMvLIUb?=
 =?us-ascii?Q?V0Fxrg4XN5mLtCCAJrE1NW3wtk6XKB7NXaFLsH1rGcRO+ZjWlMV5LvbJnjGY?=
 =?us-ascii?Q?R0pvPe0u6dMN1kGGcg8jzkcVBLcit4NGfC+6XtrldkVUjBhwKf2/2O/ifhaE?=
 =?us-ascii?Q?Wo1QC81MjAFxT51E0qWDONaYO7+lm3P/xjSXLARkxQ9avmJgFntAG+/cw8PY?=
 =?us-ascii?Q?HK09YIZ92tUUFKUGP1jkY2at7qjI782Caw6agg8QR2W1MResEhSTP72QovY9?=
 =?us-ascii?Q?RCLuvbMrn7IZrVKEKE6Xmphkoav2rfmsAYbCrKGBArR3uzKIDRaXQ2wAmIrh?=
 =?us-ascii?Q?URyhMZdmMD2OS2kVEYGSABhHaVIq3baAV5Uzmq5TYbXq5RQwlyRV?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a8cbd8-675f-4291-22cd-08decc4b71d3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:54.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TFtMvAqvYwDabBQPQ6zSkvIz96vuajmird5dcpNddvND6/NhknRAyxVuhnZeSUn0qUNhYl5BdXeQnzR2aP5U04jQcOYwOdvjnjsI3oFlypR9bUoPzJakOHRJmQs054G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23202

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 218917659df165cff72439480929e68a6e127b55 upstream.

Setting SPI_TRANS_FAIL_IO has no effect if the transfer completes in the
current context, as it is only handled when .transfer_one() returns > 0,
when the SPI core must wait for the SPI transfer to complete.

Do not set SPI_TRANS_FAIL_IO as we either return an error or 0, since we
do our own waiting.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-4-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index beea4fb83d10..02424d4e722a 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -247,9 +247,6 @@ static int rzv2h_rspi_transfer_one(struct spi_controlle=
r *controller,
=20
 	rzv2h_rspi_clear_all_irqs(rspi);
=20
-	if (ret)
-		transfer->error =3D SPI_TRANS_FAIL_IO;
-
 	return ret;
 }
=20
--=20
2.54.0


