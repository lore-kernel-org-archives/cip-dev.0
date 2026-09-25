Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E358C98321
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:12 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4498.1790359747804930283
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=nlCzSvJl;
 spf=pass (domain: siemens.com, ip: 52.101.72.22, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRzwlNyKzxVClezbinz4bMknC2ubINQgsSdx2FUqX92XmdZT2m/uX1jsyU0b6xlhlmDkR9SVQ0ukWeQVCnbU03WJ/53i/R0UFs928URZenJEWeye/rCW3CTw2Lnlc7s+yWY6otcMRGmi45onXtEzGnBOlxlTzfLjlq+VBMF3fQMRuhNIuSOgLtOWu6iEF+3PNbwi65z4E2fnJdpuXJRUou+27jHUUXwsxb139DQhDlPNvU1WQxkdCzOm+CrMZLxwFqf/1Km6bTJosZnA/UkTGBprUWlD4dBhX/uvBDKZ6aDoErNhKT9A+M/YWa7WRhdSiVoQQT/PP9+G1rjBwtGY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKu98pTlf39gOnYRs3MlM4g15HOFDAI3i3I6GIB8+gs=;
 b=BzTEMI0MqLg6et/74Nn0Kx5cv/vQs+Cn3qz4z7fF29MbfbJOG5VsPcndNHINGRVbbGOHNjANTH5Kb5xcQtobv/Wv/g71WLRSlgtQZ5rmL6O6nLzxP0akzbx4GEnIqI72PBKCpzRMcu05DcI3PdO6zGd67o0nLQkSoToD9mCC6AixxYld7uO2u769vLxZmH+E1gUyKdqCCEveBWIl9gV235xSk1Zp3GmwfMO2ntQ0aPuCze0huuZ1y87P9Oi/Wz+9MgYTAeYlc3k9p8BeN1Bxktmy1eWCw3PGUGucjXUlZv6R7mcOPwGntbEtiAbybMtZi7+NoXQY8ehGvdZemmBemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKu98pTlf39gOnYRs3MlM4g15HOFDAI3i3I6GIB8+gs=;
 b=nlCzSvJltoAhzhUoXuqsiQk7gj7uEw+5eai08EXASuWZcy4GLrdvGszS541IbZbJbwcuVhkDadFOTRNZL6Iah+kJHW2pGrQL6a7Q3WkAIs44k5QjhPbwHWiiSCaamsH0n0YjCg/w+g/uyCw6+agrpa0/OF9IRnoFKfqVAgxh+DnPAnCJjRg5lg5TyVLIVsmaN9P9dmvLzEbKuw5L7xmzWZUugh+XSVHdr5K1GtjkPT3nyYTb2XQUAUNduDKQuIyRy0/CpRiqYYK1A+Dla+hQ/Qpi1YhvCpoEBN768vThxCHUVSynWgwuHgiHLjwTdt02rXQDpIoq1MPl0fzZ2Sm81Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:09:07 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:09:06 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 13/14] Kconfig: add option to enable CIS hardening
Date: Fri, 25 Sep 2026 20:08:39 +0200
Message-ID: <20260925180847.622090-14-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1242d2-b1b9-4e72-69ba-08df1b301686
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	cMxZrYHOg9e7tKmStr8Y+hKy6Q6vnvv+lG9YLzNEctOR9xeBjIXvme/dT+jq21UwWBEcghiRuGJJIRD39zDo1SRQDUCbsk51v+PKztLVpdsmudDPxR6oHCCbTolrqpCDgTeZBIAFoCETU2RvurZFzyjld1rtptmeTh9AISz/w5FBmmtmj0V3LCU8y06P+wCrbHRJHoFNJhqx4y4zVsIUsJuHlcfjpDcS80wFpaG/nR5XHNbWZJr7LBHi2pWNubC6HWjcQH66Y3rAcBYd2st753a7KaxaK0UknGcdCKTaNUwvqQzqCblW5KWyuxC73Qp7mXS6cwVfmqkPZXGHNHdsC+sO/vcdqI70kSmmk9kWAp8N2T1dg1QiYk333Bu3QRg3OzZWG722u+lquObyLcpACTiz8whD/g7CWeMBnMgD01FiAUXWSq1PqAJyOr7ukz404QNatvNa0S9NVRU/3Hp/9Lxf43lK882bOZIRnJzsTBDyuUjY69JpJyYngA0+HehPfpxXf0NwknT5Z4hUWUugc2dbPo7beU9RLiIbrZOSAb1WYCIeILxlmKNm7n+n9b1pDOHAre/HOnlZ2lq3ancRp7xNR6k+x4ctl5U3dsYFbNEyXfDZpGBNx9p4xA0K695WOGBYC3K/3Tbx9broVHazLL3vT51/dA7tZSa+vhwU8H4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OYL3Fc2F5TjC99C8BjmX9dzxRKchDYYaVh9B1SsGHsL9ox0L9tde1iLWHypl?=
 =?us-ascii?Q?PL2Zw3XrRaxDe7vHPcMDMiM5Na3MjYMQ97hux2xOGJEpDBnJktzx4fZVyjGA?=
 =?us-ascii?Q?0oMcf2RadI0ncrjLMeruguFq7k+Oavk6IrjkxcSw6LAFheA9DfVAFpmttVen?=
 =?us-ascii?Q?3S4gL+NEcmAsBJCJ6OF1id4aS2mU4UxKGtdmJJCfEmeCsOGeoN9BYYppnQIa?=
 =?us-ascii?Q?wvoV72Xx++XHDm+7vGb0OARMO0j/W7okkdxQaUxJR1o7deFfHQ67rjRYc9XK?=
 =?us-ascii?Q?AeQ+UtLLFoi6eGCcsa/GT1g87Hx4Bmpy3i/maJu7g1mIaaSPgeQvo8sqqJWi?=
 =?us-ascii?Q?VPDKRRpQf8fLBS/FIZaG+2bDocDwrI/Hozjk2h/6TNEC17CPG+6jQiHjDrFK?=
 =?us-ascii?Q?nbDNc4qn0wuFWTm0Z4KpDAXvJkpXLA6yBzl67lIZFc5pSUtYw7/MVrAMBDOF?=
 =?us-ascii?Q?AnsLBGreFvevytlRciBJBuPn5wdwPuZYBsARovTSsfhaFHjUvHK5zgdcIL7+?=
 =?us-ascii?Q?WyGxJ0xBXm2KNxLc3aot+JwLtg0cgutMNmHsD4s4vM/MKX53vVvAIGozTw+w?=
 =?us-ascii?Q?oRj/6JPEwlDYOJrwAtdMKfV4yQEu2YV0p9U+7pzFtulDUs+gtwIWf4mk7DgL?=
 =?us-ascii?Q?ILtjHS2igWvCtZkz60R2fVElnimRSXpJUbJ3JBo5K6fIOC8tRdQTAptdIOoy?=
 =?us-ascii?Q?GmV7L3ZtganZ/j9vPngdPQlR6XJjMtKvyMNuMe+p66B7dCNbelY3hjQy0xW1?=
 =?us-ascii?Q?ELJIhLzXIeUe+vuWC1lE9eDt3Qe4eoEDAcMeAZvLdrxJpuWss5xh/ZU525DP?=
 =?us-ascii?Q?DfssaU7ewpatQnLmkEkybGqd3zHeLjq8SKoSK7s/XEZse460spM6s46bjOFU?=
 =?us-ascii?Q?qolr4APuYce53mCYyI63D6nln/2DyLqMipzQxGPFTLFxidzbtP/ijoeh131e?=
 =?us-ascii?Q?U0JTkzuhgxrLlPoDRjHXbKfHOU+cGQgrTNVT3PnfgdGFeEbxGyUP2KQejw/5?=
 =?us-ascii?Q?18nfrqNOA/Znng119GU4L2QsOODTLmJKSstHBXvWk/XmWph/zdX8ZD34vf07?=
 =?us-ascii?Q?n+03W7DWdnz/wvge9R4uo1oN/VoW5KJqHtct3KAqKBeNTVvbjSlZP9PZkfgb?=
 =?us-ascii?Q?qY4wUgJ1CIuYTMhVLf5vHQeOzQnYbtcYs/efKcbmmIo2g8LTCxwEQTm+4Hmy?=
 =?us-ascii?Q?BMSvNT00l3PY05XzOOgyEYIG90G7PfSMb+zekHY86DbNmmNALQHo+cl73ubU?=
 =?us-ascii?Q?hDNqwN08/kHxNQwNQvQAPC/WuwTmxtaqON7to6LiOxUxDgn08tgBKJNCwcSC?=
 =?us-ascii?Q?9YP3/TRKalG2Ze60z8oMyoM8siwc1scF9LqBQG0mu8yVMusFN/GfnWyi/KjS?=
 =?us-ascii?Q?7hCM7nmZJV9FZmjIsJ9RbG2GuMW+CLqw6RBj3q7+ZwDncY1aB8lXlwECgC2E?=
 =?us-ascii?Q?V/dkTohxM4MZrQZvIsqIgvRvJLxykb16JVvSNnDbBpT9gUU6sPcbr37SaRy7?=
 =?us-ascii?Q?sZraOMVk25C+leVQOIx9GsOP0Q4D2Ah5B+4AAnXGFFiMBLBL6Oqoyf9wbc+e?=
 =?us-ascii?Q?Hx2mY7B3TWoE4LD03au/BmCH+agrLJNDYzNQZS0G8VJdK01Y/6kYe3AiJn2N?=
 =?us-ascii?Q?FlK7Wq93XqVg6G7tqWAYySqDf8fOeD05diENYdKdKM9BLS3JbZ7OnnMAJjPS?=
 =?us-ascii?Q?RqMxpOOMhie7Ax1OW1o2lwU1tTrQ/M+m1f215yU3lCLhQDOstHKZQBizAF+L?=
 =?us-ascii?Q?gbvGV9Vvmg4Wul+jXd7J9bdBBOH4YDU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1242d2-b1b9-4e72-69ba-08df1b301686
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:09:06.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2HsbUNazU0xdnZaYOxO/xNKikRKKEmzy+pmDxPSLouNcdHJXetDpao7lF/Ru3z+3UEJg+nhhU0xYGjcYo2Rub4OYzEbHAT3rzrfSKUyKJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24365

The option CIS_HARDENING includes kas/opt/cis-hardening.yml, which
enables the CIS hardening and its validation.

Note: With the default configuration the following rules fail during
validation, as their prerequisites are intentionally not installed:
1.3.1 install sudo
3.5.1.1 enable firewall
3.5.4.1.1 net_fw_default_policy_drop
5.3.1 enable pwquality

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Kconfig b/Kconfig
index 490af8d9..f922a2ab 100644
--- a/Kconfig
+++ b/Kconfig
@@ -369,6 +369,15 @@ config FACTORY_RESET
 	  This adds the necessary packages to request and execute a factory
 	  reset of the persistent partition. See also ./doc/README.factory-reset.=
md.
=20
+config CIS_HARDENING
+	bool "Harden image according to CIS rules"
+	depends on DEBIAN_TRIXIE
+	help
+	  This hardens the image according to the CIS Debian Linux Benchmarks
+	  and validates the successful application of those rules.
+	  No default rule selection is shipped: provide one via HARDENING_CFG
+	  in a cip-cis-rules-config bbappend. See ./doc/README.cis-hardening.md.
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
@@ -385,6 +394,10 @@ config KAS_INCLUDE_FACTORY_RESET
 	string
 	default "kas/opt/factory-reset.yml" if FACTORY_RESET
=20
+config KAS_INCLUDE_CIS_HARDENING
+	string
+	default "kas/opt/cis-hardening.yml" if CIS_HARDENING
+
 config WDOG_TIMEOUT
 	int "EFI Boot Guard watchdog timeout in seconds"
 	default 60
--=20
2.55.0


