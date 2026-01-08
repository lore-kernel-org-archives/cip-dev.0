Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FBDCF6AAC
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:20 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3041.1767864676230090975
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fGAVx77/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.16, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlTDEpNpUM7znAHro7URrDmCU/W8spqyESEtBq9tQjr6VnhkyuKymLG9iq5LMuCiueW5uoKaX0Tl9FcRcwATiM/VX35qRmToRQBMsrTfPRvK6bi8YpqPis8Jr7Lzrag8R9Kbigk1JnoBDBtu+3Klg2RtYOcvz6qwR7dM9UYK736qBPt3xpd77On2ITXg7jiNnezC+KrrjqFYvD69eeOpUM/G5wuaSCfRgAklxYgtR01owWzkCMJJZkCAtcMgrvdxyQwfRManQPiHnAnMuBSPLYupn1LxDzRnaf1WFWGQvcJA3zRMmwLtT5slAiVGydbah2/JbPjUdMqMuqNSFtCatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD1ETVTNwWvTwCoZT61DWbJWXVHZRguTokCdKis0WGA=;
 b=Hk0BEa+fgWgS00QVFQ4efTCIhCDj8EEeSRgDhv/MkwfgO9ypfsz+QzA4e+iaQmx92X7rmBqI99Z5vvZ7Hc8/iGDbijRMcRCWm96W9UvduOuVuXI9WyR7S29MvMTfMHugAmrQPTG/AoN/vxtYL0bySuuOwGS2j65rO/I4FLQl56csjGUHePHPyZ+WvIAELROZYhEk8MGZ/o0CWidWY9syxoc6MnLM5m4Njk+ARGki0kRv3n9fsXRNqQTuheWluVmvGrCFDVsmtdmyOKACNcqZAHAPSgh0Drh4ucCb+kJDh/c5dc0cdKPEJoUlgWwLYnwaJM1H7JxM0kMlw+gL4IG5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD1ETVTNwWvTwCoZT61DWbJWXVHZRguTokCdKis0WGA=;
 b=fGAVx77/oYtIRSsP/eMySe6vsgXXpgoqLbsIUvLYMX5IUAFOhNAZbR65Ju4DK5c5fIsdUIwrJDmcf+kKJVur75bEDe4VsOWxDAS84egp6z5Zofz9NQen+k4mzRhSxaP+24cfh3+rmOp+B6PRFI0TlTN+iZfSsrUaXv5Ei08nQyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:31:13 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 10/19] i3c: document i3c_xfers
Date: Thu,  8 Jan 2026 10:30:14 +0100
Message-ID: <20260108093023.489513-11-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: c598a6a1-c54f-43e3-019f-08de4e98aa8e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?M73RbIOOJvOwCPVASRa9MlNQU6b51TiqsfhF3PPGqEcodiHke3asjQ1ttPvQ?=
 =?us-ascii?Q?2UQqnBG3YLvUisyizyMRSdXErvKNm4Ro4h7UZIgPUQsKY8BbS9COd6qUj9Gl?=
 =?us-ascii?Q?dBxbUWVzo9f7DBzyb0faQN1t5ijPenph4bqsZU6BuFGP2ouj664LjdIwwuWP?=
 =?us-ascii?Q?/T2Zrzpr0g+jwux0vH6LOZ48SCLPGHdgwvUGoxXrNVuLT0WVqWO3yhGoa6ej?=
 =?us-ascii?Q?OwCW+U/Wwra53y+EzAWF9kRq6m0awPxfawCqxvQcvXERdkKw06vZ8tW3b48o?=
 =?us-ascii?Q?PY7iaq3i3kTMrHgAJcwS9vg8iFnXp3gfcTZt/f5eC6Sx1irySlGxE9y7y3vD?=
 =?us-ascii?Q?1Q0T7i3JE3S8MMWTjsdawJi0pJ48kZ10DWZpb157es9wP4WnKn1o0vzu61oY?=
 =?us-ascii?Q?z/ySvXWryGPnYpQrfN+jji1fo8/jWmZBKyTkQC4a8FVbM31T85GR5aiBmrZg?=
 =?us-ascii?Q?ygQx0vO0ODNQNOJpwCuCu9mnWuFC4VhaMAJ/cN5upmZSGYKjS1kdIlYlc7Ch?=
 =?us-ascii?Q?NP9I9Lbmu1zuHoSIE0eeUEEtfBWckt9vB5R7PvPjQNXx5GlDNgH1uMVaCvj+?=
 =?us-ascii?Q?yySsk84G8KT7hfgUGoClHlqFsR4xuXNXuXOdfIpXyaGaS0Y5ksgyUqeo8eFj?=
 =?us-ascii?Q?hX93JK4Ka/qKp9yrjgSLIq/ihogDU5JrjYANvypwXBn7VDcf+wBc0a13XOjM?=
 =?us-ascii?Q?+e0xBF0k1JmcTnhMyxdK4TPePN3uHGBcPg5kbBOv6pTJwcYCaSYBsXgVluA3?=
 =?us-ascii?Q?3ACc7DVoA3vHYPQ70xyLNqcmUSMvlsCXwmmkESx9uzBvo4OdBV0GCR/kGPeW?=
 =?us-ascii?Q?Udx/poQicYzX4DvT65fs22MKf1gs6dXc3vEnqq5L/jH7jhnKlAPim8hFNq4m?=
 =?us-ascii?Q?fyn136a90Y+zIQpwnxIe8YG6X6uiZD8hcFzj3JJP+0X3o332rKCoAkoeDo5n?=
 =?us-ascii?Q?xb98vhQ9jW65dmNZBg06dt3Nxvtcu4lvxvVsLo/CzMH+W4gr3ZHnq7srL9y8?=
 =?us-ascii?Q?p//mdKhAkzfmuYfz5ELRbeL89g1U5qvr62gWIh85jL0eZiuyWq0h++k8Ql20?=
 =?us-ascii?Q?0WujdnLrmm0rZdrbBCIiyfPOt25h9MBNN8uDlIv4l3Iyv3uvj7msv58iR1zI?=
 =?us-ascii?Q?ZKaOIpIXIJmDzAy0brGQ1obfqK0LR5fSlRbX64vvIEOmLIfZgU80kAHYCg/E?=
 =?us-ascii?Q?nMBmX4OXSfwv78ElCVTOQjhQ2BwfFjbv92ASMC9TWMcFkZLcC8od76vANzNS?=
 =?us-ascii?Q?DnIg3TnPtVSh+IcD8+/vF2PBLANvViXE0y0DfAw03kYk21+92sMp5LEmIsnT?=
 =?us-ascii?Q?FVGP68496HfJxwluGkFZuUZfH9deqEbqILWxMegH1HQFzt30yr0hUMyUM28c?=
 =?us-ascii?Q?CFmr8BSF2Km70sfBkSbsFPVlm2zp73GRPMNzOWGxFFV7kVu9bgj7tOvxKZvQ?=
 =?us-ascii?Q?fvk8POiMCebjoXzmiNQJV1Mqp5J3qlDh2G+cLZV5bJQ0M3J6z8H9Ww=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0lTHosDnEZ0U88cd45M9hchFIiAf1QwLax23UpvwrlB6e9P3vURAHUS3jp75?=
 =?us-ascii?Q?yKyOYx0oFMCFHijjd+nHeC5YZRRsj1QgMupPfcvr9SoH8AIGhyij0znFEvRu?=
 =?us-ascii?Q?sJyH/pg39FJ/t+B1R5K+y6yDA4HAkNpemLxTs4Y5addxQwd5Ev1sMYPEZG+S?=
 =?us-ascii?Q?yaLwZsCoIN3VegjG2+Ex3HKysufDH2hVYZ5BHM5G/79RHka2d6iyV5l8r7Y9?=
 =?us-ascii?Q?nf7xuxMOLszuoLNDQiAY/xvSwlAZEL5d/CyD8wfvHk+/yQZc6vevd+xT4YI6?=
 =?us-ascii?Q?EJw8FpMbujaB4IvQdXTU03uQCTnySXD0ZtpK1ArOBV7sY2FMdVKajSPB+Os9?=
 =?us-ascii?Q?2ma01NkcuUFQ6zfgcRTuG57AN7tNUqRl8SbuDwdVJFbbFa/+w3r/Y97Tu2C0?=
 =?us-ascii?Q?EwMD/cNN17RbsSjMFwkpO1KRoXgaowQ3jAUeDj/qJt6gw82UnYv/qly5ghJi?=
 =?us-ascii?Q?FJBRH6zqebvCxo5asF1VONVz8EG0mltqDdLUgeNurT0oYFoQunL5Ic2wvQgi?=
 =?us-ascii?Q?A0RUFBmvD5L7yWs2YxgSHXNsdL7zpr4gaJ2IzCBCNrsi1s/FqDk5yHPbxpHW?=
 =?us-ascii?Q?xCUTdeDpEWLzFdeVkcg2JsCnaB6z5+UOOvHCg5DdrcbtKMCfpdJ/mRZHOGXa?=
 =?us-ascii?Q?ezyo8ONeWqX/uCLsY7WUQ/rRlmxNaemtLzA0NqbQgHMRo+HRa6bsZGFNo4f6?=
 =?us-ascii?Q?j8WQKA4ylO558VhpmMA9fkHwS3cgCVsaBnqW+MfdmgjTdSWrBJp2eDDTsl8w?=
 =?us-ascii?Q?d3iF+LE/2Hvt5f8AYRaA+LMi2OOgEDEkwnmv3PMSzGGqYbdcMNUSSYaemtAp?=
 =?us-ascii?Q?dSifmh2gmqjQ8x6dtOFmo/0UcHX8e5a6ZXcr3GvX8qrxdrGmkSncXcBLxPy5?=
 =?us-ascii?Q?Q7n43pR7RuNwWz5OXVF3VVi/R0jZecNBB5Qfw7wnzLpBtisBX0nKPaXuod4t?=
 =?us-ascii?Q?wkixiIE+nBAATJyv78tSXthPXPQvjmYZsIKwcCDEvNjNrNwUr/l6MCp4LRq4?=
 =?us-ascii?Q?wOrorX2C57rV6eTT36+WCUV5+Ie3zWkzvHKUu2ZzRfeeVVt+B+IbrQrrLEmY?=
 =?us-ascii?Q?zby4eY5qYmIiE1WUz8psLI7/vkQ6lMJMZBlDudNEEKYG6ztNw0SrLdr5pSHT?=
 =?us-ascii?Q?h2WMtLMc6+3Ryg6HMCV6rtQ8cIK6P0mYZu6il/tuDvX027UZIbpVfKkXqo/l?=
 =?us-ascii?Q?jH8E3Y9oqojgXQHMyALMcJi1PhehF/dVLB/DTrks8GDfp9sNg9JoDH6+l0AD?=
 =?us-ascii?Q?llVCpIZGoqt6vmV6GGkavmxzFiY2H9qAYKZf72ke3Mkv0pf9b5L+M8kFOS/L?=
 =?us-ascii?Q?ab/k8069mNJa2b9lggOi0ahi/JdUifsnexw7+vLAkt035CQhqt3iXxoH/Qg3?=
 =?us-ascii?Q?EGnK5tabhC5FHMMcX28XNgHdDQezVI143maOn3NZ8yuR6vn21Wiv+VgNGk8+?=
 =?us-ascii?Q?dLccOKjHoiQxfzEkXqAeHgkx/cQeas4ENN0Ub5D68aW77xNDAitSD7bvy+jO?=
 =?us-ascii?Q?h7Ct6pfQQ8oopaqmdpgn+PP+ykbCMrSeBc5kkZvzaxtNTFZOetvW3OgbxqOk?=
 =?us-ascii?Q?wYEex2GOE9FmpSdkkop2S0GNYByrEQ0F6TEBBTt9jWCmLvEYWfUbSYgTdP7K?=
 =?us-ascii?Q?Vv5AguRDiOtOSFS5eUnhF+BBOSyUrqzi209qTM1LtceqJj6hmHE5ai7kBhOJ?=
 =?us-ascii?Q?53XODpkXha46MaR+ZZ75h1iGEyUZbVIEp4qS2RrxrGNIyrmsg19dCDIHX1tW?=
 =?us-ascii?Q?mjXCI3D4FuYPvqF8LpI6ySJaHQCgSDDKGNC8CT3j4cYfHU8mxluR?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c598a6a1-c54f-43e3-019f-08de4e98aa8e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:13.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oi0g1I/ZnxuYK2wqs5irLd30LEdTiHU7TfeUiees7Sw8RqPadlN4bn9QVmxFsUxRYCuBYfWLP1J8pkVbL4215li78fjLKb0UsREj1xVaiU+qjGDk7tO9DiGzC9KVcarz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21469

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
index c52a82dd79a6..b8dde3ad3e2b 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -418,7 +418,11 @@ struct i3c_bus {
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


