Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D872CC44524
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:16:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13223.1784294169300438317
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:16:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LPLcVA+p;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.56, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0oAdyTyOZHM0QitGotwklwINf2P8tYpwVcDlWwS946VLPpfzb6xIHR/gOZMf1uPF8ykgwitRJWVaIz3J4arnnjJ2y25oryG8f8TZAQEdw34eKX3FXzTT/t2qbvC9JEG/xT/hR85GVRPdLk18e1bFiaKp5RWahZcvAFxcQgaFKgldK6ZOA6jg34BxLHo3+RlH1qdSF7FLi5pgoQICsjm8ufonnh8Drgg1/0/ni4trKBXVmqlWWP3EoEQfw2N5nEpdk6TnmQbG+SKgi/+JKl6xWLLvP8jGNkVoFCEyVlMczRPqruU9A49ZzpziqJPPaEG4q3X01EYCjfi8zAarWTg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU8r0QCqUc8DkIJ87uDvB5CNQFE7eU/ACtXODuT0ePE=;
 b=mTAidTLJb7cJ06Qj7BsuG/blrJiuOoNYQR1GlGVWCY6TNMejqKK3j/1WnATExW6+iefJALIq494XT4qjU8/2hsHiT9VO0BygXDtnYaLKJxDGsJb/xxV+/Fl8BlEpX16sGc4DKb5Wo0h8gJw19kUupJIq3cDWIsR6IGecObvE75S3xnBwiborxrFLmPhTffp7X/cJaY47v7DaVLFDRTYYmK1ww+37bvmQ6hUJrQRthK7uB43XeY9bwhdryOb3BVCKDX+CvIe+sfIMzbLa6z8hM5VnfRknGn2sLNftnN5YvDaW1aaAczOhKR61irkx+kR8xzHn/LUkw6+Mu2ccEf+dYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU8r0QCqUc8DkIJ87uDvB5CNQFE7eU/ACtXODuT0ePE=;
 b=LPLcVA+pwH+Uc1X/9gJ/maVcRYhBEvjeAGGWurDgRzL/EEFiwMwAErDRMspGye3+tbWC81y56eiR5ivGt8AqrnjIQWGo6x9yJAuRnJlA4OKQ5zNLnUKMT1fzr5RohrG0MADNjPFj7EmZ/CXTDl71FzG7FVPgSWB6ojEUjfQRaoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OSOPR01MB12459.jpnprd01.prod.outlook.com (2603:1096:604:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:16:08 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:16:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 15/15] hwmon: (lm75) Fix I3C transfer buffer pointer for incoming data
Date: Fri, 17 Jul 2026 15:15:02 +0200
Message-ID: <20260717131502.2234020-16-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OSOPR01MB12459:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c5f82a-4078-4acf-b720-08dee4059018
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|23010399003|1800799024|10067099003|38350700014|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	w8nVt0CQMiKEXIvapSSc9glzws/bJDt6Q2dAbrLGVrVy6FBTRmZC9ChDYYya1W0ja1zjKeUcWw9zieEfezE8Me7sI9Lj+Gx3/yrqoES1rxAhHfWea9YcTWPJ35QkO9S5HRDZ9LtwGTr8CWAN3LGsSpvdTLcN0V2IoQRR6bR0Rk8LWuWf8ITl67HBJ+UgOImVMRGfoNhV8OFTiamkP33zz/nR5Vq3YKHqd6+MPViQ5D2Vb38MLWdJM++aDib2vv1ycfidkzGy9Ug9DeUWKdDAklhUmxwWbsbsQEbonynr80ReN84VLm7lotMcyYynOTMeO5nKI9Kv/qA4hHEIePFsQ+VU66VNn/n45sW5ppxWrfTq3cNGAJe5Yy7jboYf5blQG7Wd+0Y4Z9BdL0A4Xr8dG6V93g1Vjxk1w0mBPOdPqWRa/XblJ3GhXD1qFSq+fiCFN2ZvVIcUS/BjZJHbmTDHwTo3mnhEPvPKqbvGvpUYSZMB6BNVkEJdHxa20wVqQyLINj5zbzljxDXkJgOQGS1Z+/H7FINTC6zlc5QmBVIWpO+g/UAw+5QE54KnVUpgAzQLPgO99YxfNGUdKPwqNsBPc7txbdRZiXdmkCsh9iBi6VhlEcNMeLKrg6KCWvxhyN7+mTAs3qRJ0Z9npqaPuKeAL5bSK4yie9PIUdIoWhuEEjTv5dquO53Uzu1pNHI99sZvdGtZYBBjEzHFOc5No9HA9Mk0itBnOL7hHynvjOwYcZ0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(23010399003)(1800799024)(10067099003)(38350700014)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LDfy42z6CafjpSVsBMQNXTehCYPshXJBqYlAi8nbYwMJI/dVE1v0sWG+ORER?=
 =?us-ascii?Q?S0toJSH1HzTVESK2zHklrOvzrlq1i/IKvcizwyx+8dUxwhptfsZhIMNjK/O4?=
 =?us-ascii?Q?LMCRy4DT8T2VGv7obVLYNz029Z5lPSsBA58XXuidFF4rCwU2NMeGDVqhhNLa?=
 =?us-ascii?Q?nIaYi52SgdIUJZaRle7Sd8+KAg9ffIJqgXphvfpYlwQQdviwPTefAioALYUp?=
 =?us-ascii?Q?Rdt9eOwxF63TfKkPEJ4VxCODJxpXf5Eyxqio9H4dglZNmONkJnhnH9EOrsl2?=
 =?us-ascii?Q?jvruAea3ohehT9+lpcjlbKez52yb4eKadu1veonweXXHg2zjVRyeMK6E1EpM?=
 =?us-ascii?Q?lODmg0bZymnZKn4bObVotY5iQ+FD+1MV+pbdYE+pVSsoDB8ScnPshuqrrlfU?=
 =?us-ascii?Q?CWvB+/wKTqKCoeeFuPdzN3iH0yeSnWdTAcXL/A/A2xU26QPl2SQy1OoRbK5b?=
 =?us-ascii?Q?VoRT0/STlmRzklgGXydIkjr1NQLW81SlljyQCthv+3/xyAaH24b19iWQRlOl?=
 =?us-ascii?Q?fAqIYfyJweptGhMX1zskHxa5PJJSnCIBXMK/oTjyYs/LNyyAhdc3SVMxP1Qn?=
 =?us-ascii?Q?/vpcYbjDS8BKjLnKsQut03r6t3FgSaI9IX/34hH1MwTkwD3t3uSbwJ7cliEn?=
 =?us-ascii?Q?s9VvXeyeJPzQtKghiwT4Ohs7mAn/95j4eeKF+tO5QvaM5F9hVeFRviADgHvI?=
 =?us-ascii?Q?+dKiV9qUau4cJcqEzzq8TrhpjcQB2MIUaExTXDooZ5ZqQ7l801d20UaUZPWx?=
 =?us-ascii?Q?SLNbAjX95v3TIZDmwXArFeTsBipsCTls4HIViI4B5WJVWAeCkFQEVXEvpw1G?=
 =?us-ascii?Q?unHe2zYHAvvBIq9bDwQnfWrGFpb1TPjdvuZI2t4eAoGkwhSqjYrbLjgknIHn?=
 =?us-ascii?Q?Dvu+Q9qj3sQNa+1HKuRF4W4QU2cOVZKOe2+9VtdX23mtNBJwFhdnrjHxSP85?=
 =?us-ascii?Q?BDFpbjUHy8epg/wNFQqQ5zV8GlsNWnKzvC5wSl/XOTJsv0+B1epovVKWmAqa?=
 =?us-ascii?Q?c6sY+WA2zbW1JKiHgRJASp9nLNQ3u519f2g6jTOEaue4phefxwY7v19fvCIo?=
 =?us-ascii?Q?adPo1KrX8fjkk5vY/YVNZfUvZY1pc2/EeNMZUzASs07qHK6Y2O+FoI+lK+J3?=
 =?us-ascii?Q?IfmFcU8PzsGGYKt6Hv0NBw8srsOLQWOlMo/i28h7/jJDizmV+xj5RO8NVLa2?=
 =?us-ascii?Q?KGLXFs95Vx8Ce3+ho7AzzmPFkmr0W76AHXxnyQYSEw2f9W6/a0+smjsQasQO?=
 =?us-ascii?Q?PKgb+JpMCB1sI5dSHEa2dSa+cg4tvCrDlhFJ/GBby9z7apCquI0RW64HW94B?=
 =?us-ascii?Q?kv58WtoailcYBx3sQKvPilrhVZVgh6yGyn/T2ojbpAwgkWmtXsbp8pd/tgva?=
 =?us-ascii?Q?duh3k0MW/+CAhLbhZnsMtat/QMDCawZiWzU9r+yGv2IlhvLPwm7PKW/DLLly?=
 =?us-ascii?Q?9CspSPddpQBA3JiV8U9B4Rl77sHe0H4XF0MJnnx0GpfvnkchaP69GnUHfpca?=
 =?us-ascii?Q?9+tOqXM0C0oEajLIepoRW3d4LGv2Y++9lCSXFSKM8GJ65KVzjXwmD74LUj4x?=
 =?us-ascii?Q?S5JSkbdmtNPdWChRyrj1NOOJCuUITdSNqzcHya1ZHs4QAw9mU6wimOjGtaZQ?=
 =?us-ascii?Q?06a8BVJasyY3AHut46OaUXNEo/+dBbN22PBQKRgTtWznL5IiPzy4xgt37qLd?=
 =?us-ascii?Q?i1AOQbdlVQKOnQZwlbSs2CCXxPvKfO6gadwgIhmngtDnKIkqaahwULdC5czx?=
 =?us-ascii?Q?VYraXTIiMsITDEjb9PbEedFQHNVyyG25Ml/S/FoysSxLz9quXDVo?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c5f82a-4078-4acf-b720-08dee4059018
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:16:08.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76I6cECPXKwFuMR8/iawQi4iK0THIbioja37PKyF77ck9aZnr5M7Fjhs2lvFqDrJlLG36AYAkllgTYAVZR497wN4lRCZRtCvZJ9h962tYvdGspe57oKVg8y/Ty0YfQgh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12459
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23667

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit 0ddce5549012a3f3b9ddcf59822aa0d1be61e8e8 upstream.

Use the I3C private transfer input buffer pointer for incoming data
instead of output buffer. For now this is harmless since both of those
pointers are union members but may confuse when reading the code.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20250513111739.508886-1-jarkko.nikula@linux=
.intel.com
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index d95a3c6c245c..9b4875e2fd8d 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -622,7 +622,7 @@ static int lm75_i3c_reg_read(void *context, unsigned in=
t reg, unsigned int *val)
 		{
 			.rnw =3D true,
 			.len =3D 2,
-			.data.out =3D data->val_buf,
+			.data.in =3D data->val_buf,
 		},
 	};
 	int ret;
--=20
2.54.0


