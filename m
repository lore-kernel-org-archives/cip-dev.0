Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE8C83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:26 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.64])
 by mx.groups.io with SMTP id smtpd.web10.8427.1751620096496515045
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=KEetXUwL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj2rrZNMEgnBCVzarKsqolwvkoiSh+LKCRVvh9fkjLB94J4zBBnjxgvlQzu3EVjSD9RNMaLEYYwyaL82xyPzAcbky8MCGEfc94IyG3r5b+0C7wxqdyif2CVp8Pz0d3lQzHFOHFnTluKNF0iJUSgTeetMBHwy3ysG5AtQVtDbgvaZTvThYkZrMiTGINAMlRwPq2MPWClKcrjwPML5eiC0816nK0amW1X0By6lNt83OkcN37l5HNy3tBKk/1e0NJc/0+sQ5uVMtvgICG41MAzp8S/8aHL5MQWpUOaL5O4rXvyuGIzJTtOhjFp/FfzS2K5lK1UqhuK607cTQGbEDAo8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3R8Ye0zK6X9yb33go6U8wx8c8e0kFGPjGW21S0TnhM=;
 b=Ae2XSMiDFDMD+r0jjjkQUnw46CrvO6/XF8Wctmmhbpyk8l7DRs1YmrkVBcCt5LDGqJUzqdVSnhJ95pCoVVnwweIPeXebpTX3JctMxWh4lxAPeVNDnTPPZ8Ul2V9WDLCEwAYz3pXldU+H4QncAq6RjHZtbt3/Pi5o5bAlZaEJbGEfb7L6F0belPB734y+6Bthw5zaedaTdsPPaW7t4TSwd8L5ktZsHd4+pp6AUOre1ocGldBNG37Z/v9a8IdMsTXGR/d6NNS5HRofA/SXQZo6RdI1NQEaK9tfXuZGRueu8D9NEQZw+LlpUjyVDvmAbYolO06b5qdtBheeQzVCHY9i9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3R8Ye0zK6X9yb33go6U8wx8c8e0kFGPjGW21S0TnhM=;
 b=KEetXUwLF1onDEHHLUXVcTO30u1meroeqy5pSYQHJomuNmhWZMYI1UPDlLafYn5O88cEm6Q3RvKFbIAGfmlilneninNbqLxS7lI5KIFph4fP8/iu0p/pjEHH3sgSrPsKjY66c2JCSkurHKFbL4pEdOU6zSumYGYDs4EIb1V83vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:13 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 09/18] irqchip/renesas-rzv2h: Use devm_reset_control_get_exclusive_deasserted()
Date: Fri,  4 Jul 2025 11:07:15 +0200
Message-ID: <20250704090724.669848-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: f94891e9-0bdd-47ae-70db-08ddbada4dc9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oa/TluniRiy/vsErPKijIYDlSTcBL9f6wPrU1tA59Rx7OW3NoH0gqhycLvDb?=
 =?us-ascii?Q?4NRyC7C3e8hFDVdyeMEYTTwn1GvVtuLhDykyKZRTuBecnLjp5n4ZhyjRUT8v?=
 =?us-ascii?Q?aJ//WutcnMMGbCaVqaQvx4JdTT+nKMwYK1Sh+ZDh+fFPD4c/gjsNB5Tyz+xR?=
 =?us-ascii?Q?SRZoN089P21lDkMl5o9iQF8OXjNxd+C/beazNGcJfyL8j/EEfkaSGr5cSp6o?=
 =?us-ascii?Q?Nr1tA55aQMSZQHN8oC2K/E2jVkU5k45bH0d1sTm+YQbw47yR2VE1T99MfcVo?=
 =?us-ascii?Q?ylyI0LQDGBoZduRQiHk6tRCayJ8FGzdzruRex7Hs7S01WFCtE+pKYRzCgwBs?=
 =?us-ascii?Q?Sv4iuBeRct1M134JP82N+PJcRjWDDwSZhkPH8CngEG33gEFTzJYmm844fy4O?=
 =?us-ascii?Q?j+5YjQu5ZaoUvCePJBkcYcOPvF0hG2nXBjdk+4426NaXEiSO+YZ15bNtVtgA?=
 =?us-ascii?Q?23GRVqk2UwQGsVJRbxuJgfpG+wVvw3QSQ9xK6ODkddh3n6gc6RRhNtpO/SIr?=
 =?us-ascii?Q?vx3PYvJDNiXdKiRwjVDxV1122I/UkjiE7A4OjBGNA+1eh1F7qm5Doe6O1p4z?=
 =?us-ascii?Q?xjM6kCIQoJEmBfFvxppu3BamRZpV8UdXgooh6uUHAvNO1rrsbGaXMqgUvObt?=
 =?us-ascii?Q?v0aojeobEkULzQOfWXou3U9uTHYXZi6RoY6cEkZfbcg56rlU4wvWXHc/9H1h?=
 =?us-ascii?Q?wB0DimqoLPpKFAJBGm38tts5Gb3wb1+prlISzyrmIt0EjWvEfaKLpIR3Qd19?=
 =?us-ascii?Q?InXgsPF4TeLsSyzHUzkcdmZK0Xh/r410UxHrpST9MB0gJ/1VKIPHDdQ27vuQ?=
 =?us-ascii?Q?3lZk8XtLO1pcWvnwi+CXmZn4sTXIIr79o+/c7dVuF12J9nbyZXXBwmUTlTRs?=
 =?us-ascii?Q?OVXmvtuFOmSdJZpEJzRbSmZer5k18ZHH2OZFRO7TgvCO1Q9KNgj9tt9+zTQ5?=
 =?us-ascii?Q?U3C7+ous4F6ijF1OOIf+TR+LKbgMIQKr+rV3las3Ya1mgRFXyYWwfT0aMgUh?=
 =?us-ascii?Q?jzvHzNHJAk7k12NlHh4lVjGa2ddA8t2GvZJExOjqRHojVsSkK1+xm7RXHz/u?=
 =?us-ascii?Q?JHih+gZ9rzdwyIlxFS1AnNokMUdi+3HctNVnd+4MkZFMompMpfdm7lQJJvge?=
 =?us-ascii?Q?JO/IctuHjogKzDVULGSSIW3iYKFmT6OGdqzy2ZTEWz9JPlAzAFvvzKlp8pgs?=
 =?us-ascii?Q?257t25QMiQqjFZLSTVMJ55VOmCxjuUAbsqUmu10Ef27aEfWTf35MljeX0bSK?=
 =?us-ascii?Q?8OX2N+kMqoNdkaycZSG2/NYxlmG5n4mAcuq2EfFXJRFsI/Uuuc6o8YepnsWs?=
 =?us-ascii?Q?FI6BYsuCktYs5eiOGH89mwbTG5bjSNHkmP955GSm3YGkbucTNQ1NrsrMMwn3?=
 =?us-ascii?Q?Sd8PwexjqNzrT7976rPy0mOh2gl4ifocxGUpjO/pzL4ZMsmkBTA/uxGJk3it?=
 =?us-ascii?Q?0mL0mq9CC/AjrWB9unYLzhQ4bf/9eBKmh032EeEBz3SmkqMcqQzhSlUtmDLp?=
 =?us-ascii?Q?SyXgd22ncbRzWJQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JNzg3+ZmIvNXVI0z6LPwlSqZPd0WupfV+isJwp7y+liXrTPDzK7N+99hL/WV?=
 =?us-ascii?Q?af8hCwEWKHyap2i7DIUPtC5+rEp7w8N7JYP8KQ60iTRCEeY207DUedJV3S+G?=
 =?us-ascii?Q?7CuhYB4ubUi7SOaDuhPcenfU5rFbUnPEVbCkbWqExqwxObepCrRAwfdtGcy0?=
 =?us-ascii?Q?WOBibyu/UzHR3fnETJwiR9wXgvx+kHdXwquBQNZmnRI0YMVkbCQ8fVWgZg/G?=
 =?us-ascii?Q?EWea6dMbpPxzm7osDnrCVLR4kMIV1ZFo46O2hJoSrcyfZZKwCY0POkDb48XR?=
 =?us-ascii?Q?qtVp5DKLAt6dOumsJYc8mJ5kZHGXGdbxqmQXjDjHJKJ4LkahDW7xIiVvTWjx?=
 =?us-ascii?Q?cLqIFwcG6E2syQTV5MmpF/ONkKTt5r9tha4QWTGk0UNR+8kpeCjNtHsXlpCv?=
 =?us-ascii?Q?P+N0OQrVYrx51nr5sEYSjhQXLUg57Gk4zsFGW0sYrtB8lZYmGQfBn7VS5331?=
 =?us-ascii?Q?djwSzfuWBqpWK6xUUnQkVREZi/ns9FI7kwByFOvuJEuojo47H/fmsWd7OP6E?=
 =?us-ascii?Q?kLOiIXwprzej2mavYVRmB9gGL5Q4Qh5HEL9G3ic4/DDvy6o+o7LIxae5L74i?=
 =?us-ascii?Q?61gsqmS0PY7qpq4cabmLcLA5kXzvfxypYaUCl0J2YNZzpeO21psjD+nPozJG?=
 =?us-ascii?Q?Vmg0Ln1Zu+pXwX/TCrs/d1Rh9otryCDL4EL8lKgPZmoCiV9LkfGAoKQWab73?=
 =?us-ascii?Q?fVrTZFlBrs1Oij6RhA9392xVFnaUjE5F67XWyo4mCHywppy3HNCvZOI761aI?=
 =?us-ascii?Q?ubQ82w7lpbwg0bro/iAUlv3q/wKuWdDPblcf/gzID3a6ZdDINQDm+CgQWkK3?=
 =?us-ascii?Q?qa8dk5+1nLKoA269/vD/qIdTihZdrLAdFMUC+KBUy63QhSp8qSzMpZ/+DEP3?=
 =?us-ascii?Q?zvUmVPl2nl2XLA49NwmlHtF135B0UkNqRrFv9csdxuFl7dX6UWeDNRqASNo2?=
 =?us-ascii?Q?GM2DbjxtcneROVdDNAMPA1psGic4XaT0eDEbhLY8MI27sB+GXLqhteS5mtn0?=
 =?us-ascii?Q?BcjxNIHxKBxZyyoLe3oE6MSNSwDCdEhJdz+ChTTGesQUdgdGfjWnS6Fw+6KA?=
 =?us-ascii?Q?6+NoEgvhKXwjkNTS/8tGYgcUYL17FzmwMvpGeiOnAsAVQINyK9O0wifW48T+?=
 =?us-ascii?Q?ovPUjHWIHiqyeU1iQjqwi/wjxIhGhabQ4DBHwejMMiKFW9WU9wdtdQXyvk3e?=
 =?us-ascii?Q?ITtahWzydsRvfOGmsavHTt/NeiIFoCk+qDeDXmPpzyxAXNbdrbms+ZTfvtx5?=
 =?us-ascii?Q?gyXtMwfh4XBxLNSDm+ayHp3ZLYQPq2zfV/LsJMrfbIuXafPsjMTAN9Pog8Iv?=
 =?us-ascii?Q?/NQx1rCuDXTr1AD0RDHghN4DuM93wuZXJLU1R1wivupAAq+vqJDwgrOS1+ed?=
 =?us-ascii?Q?JMDouJumjZYtho0SREVCaje45DKQ7K4O7PJIWaGEEvtLaVBUaIwGZnPYhUeY?=
 =?us-ascii?Q?8UIXyiB41UyuFjCWHY2ydTzsyr5K6JXfwDVLtlwPz/9SeboZUOO+OCq6kZiO?=
 =?us-ascii?Q?plGWtU8bDmfDKyJOkafOlx0ntk9px8nWf41Gr89yikwm+/mVYl8LFF7G1foL?=
 =?us-ascii?Q?ufPyAjG/HKJaQLYUe8MrZInKLVtJLhR3n5XtYdeWfh+k3cbnGiOg6L9wkRDG?=
 =?us-ascii?Q?e9bV06Gc//J6wqTmJdASSMQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94891e9-0bdd-47ae-70db-08ddbada4dc9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:13.0256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aqHUXPOOMeybz6/FJRWcRPdVESBe0P6eSAi716TqGVI6+7T/ObyBHERcl9NZ/UqBB2fw05xbGh6datVItd2kq5U/C+7R9piVQaAlNTEehdTL/bz2FqtaEEZcA/XCRq4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19353

From: Biju Das <biju.das.jz@bp.renesas.com>

commit ad773ebc6e41f0004487726e432b86795ae426d9 upstream.

Use devm_reset_control_get_exclusive_deasserted() to simplify
rzv2h_icu_init().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/all/20250224131253.134199-6-biju.das.jz@bp.re=
nesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index d724f32dde8f..edae54f9f5da 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -461,13 +461,10 @@ static int rzv2h_icu_init(struct device_node *node, s=
truct device_node *parent)
 		return ret;
 	}
=20
-	resetn =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(resetn))
-		return PTR_ERR(resetn);
-
-	ret =3D reset_control_deassert(resetn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
+	resetn =3D devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
+	if (IS_ERR(resetn)) {
+		ret =3D PTR_ERR(resetn);
+		dev_err(&pdev->dev, "failed to acquire deasserted reset: %d\n", ret);
 		return ret;
 	}
=20
@@ -498,7 +495,6 @@ static int rzv2h_icu_init(struct device_node *node, str=
uct device_node *parent)
 	pm_runtime_put(&pdev->dev);
 pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	reset_control_assert(resetn);
=20
 	return ret;
 }
--=20
2.43.0


