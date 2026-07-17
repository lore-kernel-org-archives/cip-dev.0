Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06F1C44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:39 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13136.1784294012080826226
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=B4NVEBHN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVhwjBpPlNdWktVHR5Hjo9UQTqq9Ql6FlY625pMH0wBA8Sdjj4H0F3nr8ty3NjN/FILApgoVzKODaEwzNoVSlQ6bQeq5TzcUEJIiQNY92pcE9C/yM76xyXnn6lyyzZcV2EBwTjnnIdrv64yVE6xTsyAgtAtACL6twykviP9SvqA8/wTxCHCxLaQxKr5I5SyG2V7yfoYZHlPug9d2JRBKQG1WLcU1pL64ungg7+6g0zoy7r3jkI9MbsRJywZ3NylC8eFvKpSOnzg/hHae/FAVkzSGb2lZoYjrBY4aenJY1fNvZ/GL/GmbuOyoofsaj6KgD+SpyLjstSH34I/VmwXe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdILe4IUGTy93vAVwv5S+nfeFvPmz3eZAUHv/9/ywFo=;
 b=IL0y9mm3DPMpFWKhwf0jdSsMtsrCoDLCMSOuQscWPRna28Y6Q1PcmQNQJnR4TSk8F87nk39yM/NwtZnUct8NtS3Hf78vRa9yQVHKTMPAHjv7OyEgyz2IUB626A7jf79k56agz4plE18WJu2t+sLBc3VT6rSejxdf0lizSsuzCp8J0K4UC4UdmeSfXQI/PbOK6ux8lk6PHAyFH11vkTDNKVhueW1gMK/gcmGI7LR2m8sPPZcM3ZJkQDo6s/XOt7YRE7oxXFMycbQb+723G6cY+PRQlxLfG3leKdvJihp3K8GG2SmJagoziTCwmLOOcTREilEjgDjLOUfsOhxC2N9GKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdILe4IUGTy93vAVwv5S+nfeFvPmz3eZAUHv/9/ywFo=;
 b=B4NVEBHNT0TSdt5mXez7IW3+S0RaJfMrDrq7G1XAQ0yHILtmv9dYqhZiq92XnIaNLFRu7ALo4UqmUBoqVkwTPY8Mor74K90QmyReraoYQXay5Oh+pCPM4ZUPYa2qy2FP3cf462LNAI5Bnyy8pobKjsF5vRfdYxpkZ3HENWc03QA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:29 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:29 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/23] hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module
Date: Fri, 17 Jul 2026 15:12:24 +0200
Message-ID: <20260717131241.2233788-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d67c10-7f61-46ec-57cc-08dee40531c9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	RKVJJc3wcXa9mPUobH5ScHi4H0KcIPen2UbtL7e49NZ7/ukNXgl+d05XjhjAjUJMer6SwHBVGQM8Jo6DuXEoPlZreVWZyQQkoGZwhWOcl1vyCUDD3fg66qskttSAaG135ZxthFmUMYNqXs6zgMZF2F9nN53YWVgXTdT5eBZUje8WXSrXAzufstu/Ei61rRp6OQbhbkEGQkTq/KDjY21m3HcFRN1R8dE3GwOpExZ5sHCqPebrcLYlAqJVHbf/sKwBsN6XIQ1Te/ZA2M5x/6q9JHhfnZFilT6gWbltLgHp727EozvFWtm1Z3n+beJG4WF8nLjcBCsQoEfHH/GI4GkwJjjZ9Ri7Jfdt9t9RS4cDVwXc8yD42/Fshfog41fPUagcvYu9jMutOJdsDzB75Ovq0Zhu/pGQ6RkVsrxi/1BV8Qt9zx6QANSh0zgHSon6AjEGRmYtNxVdVyEIRdwWieuA3qLBtoRfA4oWW5DHk8V7j3raKmE7hTYvGCCxAt4AO2f5i2sl5+pANj2uNA4eSxpvv2b0xT69MwfANoYZXTvUYocOr2C0wMHvoSYg9bZGJD7QkQHMK8DFrRpe8nRFXaOMgxxW4AX4EdiJodaackY4ibv9zy5/B7XkBr7DiPHowAaUZAMeZQ3pQdxYzm/BJJAOwdpSgNPw/uHlhTOsi1C6MxeDdQOak7qtT0xRzvaQx37WexbbyKG3IY7mQgHH5zHs1pzjk+1l0dmnX2AlYo3d4eY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xdP3prnXgITU5ceeOEp1g7QODUv7L6/f4ja7ULjkBsoWcCn7QR8hghSoSfM/?=
 =?us-ascii?Q?oCBix8wfzhGrtJx9MschL8/YskKPqtoBRqjoHO2Lf8PpbuxhazBLUKk4aTnF?=
 =?us-ascii?Q?bkOS0US88jgvlL8sxP/6Vh7fpOnYpTP/DtmYstO7/ymO8Yw3tde5gJlOB79M?=
 =?us-ascii?Q?VlL+WZu+loZASmSuRJShj/nVpEdEneJzoUe5zsKD6FXwRekd818aITpUQWkg?=
 =?us-ascii?Q?CFc5zclOzePlvb8grLNka1NYTEVwK+fu6uTMMRZZlrSYh1/00OL2JM3zJGvl?=
 =?us-ascii?Q?RBu1CDyBK5827MRpRb8S4hp9h1mljNEjoNH75es3jqvVAaru3Gvpn1wzXmsF?=
 =?us-ascii?Q?LOWav/Am0lRorNzFGFGtbDiuKEfx9c0iKAktxOgk9kIQzbJep4vUwgjQ0pr8?=
 =?us-ascii?Q?Dg2ca3XGgu7SatH0aM/oFNaNoGeur/K+Gkq98+0YGgdqEryZXxAi0F4CqQeQ?=
 =?us-ascii?Q?wls3cx4teMfArJvzRELpHXJJ6OJyk9PqatHRCJNwswl+BaKsYGUbG+tLUiw5?=
 =?us-ascii?Q?+QFyR/MiVxryeS2c9WjRKJzVcOxM/xqYdKB3wWPcfYwVHZ4s+K+/+2eDFGUy?=
 =?us-ascii?Q?9Cbs48k5LfyJiWTLXEev+oDbCMO9L0Ce7BPH23Bn25cg64ioROEbqQzpwh+y?=
 =?us-ascii?Q?t+9ny87aoYe6uDX4yTtedHZVmuxjqu1773iyWrNCDieDrmMgg+8PBnxyNBXf?=
 =?us-ascii?Q?vzCYMGbwNgYpI+zY7y6JebX1jTpO4WZ5dSgy9BeJS5sbpqaWZi4OxLNdWAb9?=
 =?us-ascii?Q?qxmx1ObGGdL4CBOog9dXurptzIl/t0ehwRdo30ocuNthVaDL3Pq1XBc5S+qK?=
 =?us-ascii?Q?Fzv931V7fDB7huKFse17yRgM46aq3s3tFJOEuJYHwhOwWugeuGmk4I+9vl3T?=
 =?us-ascii?Q?jK2aYbAyZFl5SfwZBx3pWSmIcyHoH+e7vbvgKKU8yFqOIEeRYc7wjBVtvCUZ?=
 =?us-ascii?Q?eSwrKE4btw+VbU8k0I7CS+QcYoiPpYwO19JDvhYlfkH/067SXkHL0f665Fq3?=
 =?us-ascii?Q?oSlKD0YCo/B3X5P1rDwF+jqiApdKrkJJQgPRLsg8Hnp0Ivqfv0daK2stmzDT?=
 =?us-ascii?Q?QiMSUgZlB8jav21QOedpSMn1gln6hTTrn/CqOcztBAmNMKYpqxeg7Q21HiQz?=
 =?us-ascii?Q?jem/YlZpxlHwDjM/tH8gSv5qxcbO2rFQrijUPrtc0U8nkFYubXTl0/eFkoa2?=
 =?us-ascii?Q?78Xohq8usLi7gTYzp7C/zHRCX+t+xgVa2nWNnDgGMR5tD51hNegA3Ll6IX/T?=
 =?us-ascii?Q?jZCWuwuwiDEHjcayaddo4kV39c0FYkr0mlyuL2fYRubVjV9ZwcMTJgNU4rWK?=
 =?us-ascii?Q?odKg7WjkMXi/FkZyZf+AEPFj22LN5feE1JxSiAxJon0gy89ysWPfjk8FMWOW?=
 =?us-ascii?Q?K+GSVexkriUgugQDDQqS0ilDlJ6Bv08RvZkydvQ8arGsDgZpY4E7EAcZtPtL?=
 =?us-ascii?Q?UCWQ0ylv4U1fx11/GplhT1U3WSO4Dk3O+O7A6edhkwYvmAA0XcgtBAy+z3au?=
 =?us-ascii?Q?3Bx/aKdIH9AieTM9PO6dRn9Rd5/0wzrPfv6BdwzRO7lLIks4yWD8nwoXfsSM?=
 =?us-ascii?Q?SdIg6+mQDP6y7/LnNHHVdVuvBOnjnbeluARtwCQ8TsUXliUMSWqnFmG0QdUp?=
 =?us-ascii?Q?jj7WLa1+7PsYrgZ3I3wv1mB02T7Oyuy5UHBxqlA9uacFEUPODQQiYEP98R/Z?=
 =?us-ascii?Q?+LiEOiJixxPlSHJq+n8yNcbZO5ho4fYBDFNnm1my4NubqfdsiNDnoBzjEI7x?=
 =?us-ascii?Q?9fiI9Q9GQROQMMXJVor1t93lRITvUaSG5gq0M8xAxRkC4kqMagv6?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d67c10-7f61-46ec-57cc-08dee40531c9
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:29.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxdOCt4CgM58/Zq+0vKmgpfHkmN2OWh+PP2lEH0j3kFQIG+fvBIpFkEc2uDCSHgr+8PD8oswm+XLLPjd8h4zYbbvy8Azxc2VODSaXiTEYlVLW7gUM8W8s+VK8tQsHQRk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23634

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit 8281d627905dc72241ca3969ee18f3e029e96d00 upstream.

I3C device probe fails when CONFIG_REGMAP_I3C=3Dm:

	p3t1085_i3c 0-23615290090: error -ENODEV: Failed to register i3c regmap

Fix this by using the IS_ENABLED(CONFIG_REGMAP_I3C) macro in the code.

Fixes: c40655e33106 ("hwmon: (tmp108) Add support for I3C device")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <20241121121819.393104-1-jarkko.nikula@linux.intel.com>
[groeck: Remove #ifdef entirely; it is not needed due to dead code eliminat=
ion]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 55277ec7c54b..955e6cd378dd 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -452,12 +452,7 @@ static int p3t1085_i3c_probe(struct i3c_device *i3cdev=
)
 	struct device *dev =3D i3cdev_to_dev(i3cdev);
 	struct regmap *regmap;
=20
-#ifdef CONFIG_REGMAP_I3C
 	regmap =3D devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
-#else
-	regmap =3D ERR_PTR(-ENODEV);
-#endif
-
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to register i3c regmap\n");
--=20
2.54.0


