Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BCBC98317
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:21 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5834.1790249777502329221
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tZh8ji1K;
 spf=pass (domain: siemens.com, ip: 40.107.162.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8QaVawaQGJnngOugoupWc/Y/o/YGXdbOPLQnVVCJDhN3UyZCViETvpOLdRTF/XRJPYoSmoa5lqlkH/LT0K0wYqhNt0nGwrUjF/stNAI7AgCIG7KhOZi8LRD2ApwL6gTylHtNcI6h3mMcqonSyY3kYxfXNikoM/We+sbHiiDtnZcOT4wa0SsUhORgBuoA9qae24hTCZ7zewpCY+yFQgW1NgMaSqDhOJxKO8iJ7POn0o/2d92670jqC/mrNVahhrxPkeUF3AMPKdEyOrgbu/awAlBZBmiUHoaIkKtvTU7aqfv6e+AcQFiO37WXXn90i3V1nGhxJftEkWI9vxeCJHK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKu98pTlf39gOnYRs3MlM4g15HOFDAI3i3I6GIB8+gs=;
 b=QlbRAmslK42oYjtO806a2V1t6L7RtjnsrG0RoAU5YJTCHgTMuTqirXX4Ymgo1b/dKGvI0rls8unFt/A/UCB61lsWCr87Pcrw0mhNRLUTJJN6eX9lI9WAF9YwJhnay+6+wBYRcnXgIpIR1K1A+tdi9kEKqVwXiH71ATXG6HUmg5bl6NlOnIH8G140akcxZHq0+XIxWN+fVyZkadBlQJY4DEVQ4mZNMTCED+PAnfxCdM3RDsMYx9zBIeq4t5t+E56fVhzsVrnjZt8+40EGWhf+BrKbetvM8KYbycJ6Bra+S91yjGHEp9hKVnjsrn4Hflwn4vqqSOuC2+PALTRVDGsAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKu98pTlf39gOnYRs3MlM4g15HOFDAI3i3I6GIB8+gs=;
 b=tZh8ji1KzSCsjv5vR/YfSRcElkMtebUQhhQfy9gOM2osoE5HqMm+Z0c3zEn2ZmJQ7yrPlNJ2szH47GzPy64Vd+10ovuA5FTQp3qmWzmtWnNpocXnug3rzOsAUWL+ap/h0LQK175RXfDvS98QIVxWFzq9ldYzW7n3PWndlgXA+G4mlH35545iZ7jdRygHXUQdoRrtBkOngDCmTRIzoO8LnxUTvwrNXIo8CzkX2Cl0hLiJgyn983Tm+vEQTo9hmSjDMV30jg6c14pCYgviJR4bWXIetkD6Pv53NSnnOVie7c0eXUpN6GAvljwH2mg6d4i8rMQ0T+VD8TbS1M/VqFMAbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:13 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:13 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 13/13] Kconfig: add option to enable CIS hardening
Date: Thu, 24 Sep 2026 13:35:13 +0200
Message-ID: <20260924113557.3191996-14-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS2PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 5437b115-0d63-47f6-a50d-08df1a300837
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	KIm5j8iNrEJbLhwzwbHXVfnH3RmFvfIAM1REe0MnXxNE67yaWfYebp5zbusBGlya0f34RyaHxS7uRqk3CSXI4DwEoDRcW09txZSkydTV4zs9llMDalJAzfvHcudEez7amWYOi+tQsTvIY7d8MgW56A25rSbhXyWkSfJmIHNJfz3UFNLEITFyFPZfDJdOseEjFWf3AcdSN0o1OLkkdxGLRmDJnjguZynUOGXZcQtQP76IUbQ4zJiemLmAFvfi7oiwBwjFuJg+/WQb5CxfbaKyiIqcmpaZhHPANJtHjMIs0+pV/sfIBLpoXM0NpXI30rTxDGNCQjQN891CvXMHCTGMArR1UrRKAEa3dwlM0ggZ9F+ku4GAdsr7AhbyKS04PT9cr9tGm0EEZXUGjFUoQUi8YvTVWu+g+C84xQQeumzGKRsnR2gO+jl8nRCE8ealrmLclpqlgsXZUfCTkZJXPwwsGCviGGyMByxtCQvG/Zyiz4ddOeHeZDISiAVb0vE7H8DiOCm+zCAsBY2T15YQfZWcwwYko71oLO8G0+HAWMyOZ4gtPXF0HO5zvZgV/TX5qdJ8+nGup4CA0Rdyo+4Y2mdWMFxzoWoeGFy9eHXxxqVylITd3sUT8ITti0sbP8xYp1gQeqnG3ov+HeEP0RMi9tKtniSmDhvcfQprNLNPcCESnx0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m6silGY1se5PskMg5cogBUQdynIszDlg08SDhsyBVgjxnDu2JCUtPyp3Z6RY?=
 =?us-ascii?Q?ZXcM5R7DSmxeyhQM8ZYc9p0IHLb89H+q9V9fsmOSI2djL8TyIxDDSKVENc8i?=
 =?us-ascii?Q?/xKLTQGjarKwnOBgV4EMv0mrcfdU/FVj8FIIvPziI3cjehDMLctCzv8RjZ/Z?=
 =?us-ascii?Q?cv9R4mf6uu9v4g0AjMM5k4p57T7Yur//YE7XXQ1zszyhe7hEBuZ7wjdcaOYm?=
 =?us-ascii?Q?P7dUT5mW4sPCUanVEA7/vwBzYNLIji+39+0BrKs9pQflTUsfXpwh5dzd06ud?=
 =?us-ascii?Q?xz1XPhj0M0Dh4QtFNmZtqTf9qdSqM42mWwlpxKDvj6gG6LdvQ+eL5s80sa+/?=
 =?us-ascii?Q?WciV1x58wSrV+IUXMZSk0bI9psCiu2xTGTbcOQryADDEr5Z+mZbBFzNYHY+j?=
 =?us-ascii?Q?bRRin9UfD9XCYZ2BhZg/vUgt6IFGghz3Tio9nsjkN1wGGlIMgWz49BaKZOs7?=
 =?us-ascii?Q?tZiJax8ZI1+Ol/xvQHpGXV1dO7goXwq5GgOwMUNkVOLS5vy620xHLckbnqCF?=
 =?us-ascii?Q?+GBisIGcN+hL98Z3z/qwwBCJEpCs1PJWzRdqFd9cCdUYB6uXGRRv5Gk+o4sH?=
 =?us-ascii?Q?159Pq/Hvqctu6NoSFk//jC8godHpqyEAPUtJDiM/95JmMYnD3mjJvyPBxczm?=
 =?us-ascii?Q?X5uz2lIELjh4VZKudafXODk/j+lG5dWYqy84c/OUxr48Ewz9HWrl010MrdWd?=
 =?us-ascii?Q?e6G5qQgsJiveeD1g+PljYyfAyyPZRHzuGo6gLhjnir6QCp7fvZ1jy2PX+Z4l?=
 =?us-ascii?Q?NeKOb2Wx0FpED6MmuecyVXtTtiu+5ZkQYk7MBvZLOElbzXBdw5xY7EYV7LKf?=
 =?us-ascii?Q?xdp3m7KRPT+uIDwkho2tXNxH0AHyBrswcL0vUKk1M9rDEWI7C+/6tYDKQyH+?=
 =?us-ascii?Q?CobUMNM1vBDybWQ3EkBRq4x6yexTnQ1d2jb3mZURe8PdTkBN9KltwX6fUBMi?=
 =?us-ascii?Q?9knqnAJIQ0ImZMs9VhgS+Cnb1DtuEKekWx6jSQOkoUGEtuZrz7RwU8bsoT22?=
 =?us-ascii?Q?8qoSqOOETgq+3LMd9EDJdjKupp93TkTwWyNmaDI3MwcYnYt0omO9uc6E50pS?=
 =?us-ascii?Q?ic1KieqtRoJY1BzMwKZ3/9FvAaaSaD3H0wPHzHCiw0ofzLqoKCB0HKteq7UP?=
 =?us-ascii?Q?bWSQb62gvGGyS0tPWRtULY/WF5cQ1IYr5404mDTb1qpkk8CZo+dgG2Kj++0U?=
 =?us-ascii?Q?561+SnIx6U8cYi+qQZ4yoEQ3THycSGnpGXETQLCM63ia3BBg/lFfuuzCwuPY?=
 =?us-ascii?Q?Ae5TsB8ed176IdasBRJN8DsnqHBdVskSV/1YN+7cEFJ9U8KlkvlbTCuI3Cym?=
 =?us-ascii?Q?5tHxq6twODnmNybVE+8oMgNmeF009qX+wOOe8vuMZMR8H/zzCHpM+iiH/ekh?=
 =?us-ascii?Q?2dEyNzazpfRcJZifNReyyi15g0GZCHIpAdL3+t4baoeZdQYHBWe82a+oNpNA?=
 =?us-ascii?Q?+FXO692y1KZ5LeY+2yKdV7p7lZH0NvgFIIZgk4AhkzQz4gGetxu9g4I4gi0+?=
 =?us-ascii?Q?95TYbzsEguR1Ph8LqRsw2SMfHrkmRliy+nefFfT0uVaeE6Z0u7/qPUwFhKl/?=
 =?us-ascii?Q?UEfWpO2vqKzS9jDb8APlyzjKzj+AkMKYMuWyuUBPCulBzxKR/1egRHO+Z/E2?=
 =?us-ascii?Q?PAfj+DHfbRErdPOL5GC325ijomRsNuj9xfQLugOKkOlGoukWehC1Ckjt/4s6?=
 =?us-ascii?Q?lWiaJ2oK9nA/pBVtbsPwjqWIFrsLnNyam0NnDml4M/UU2lgRRgTJhuhx6UA5?=
 =?us-ascii?Q?XYYx/gec6af8AnXUwO+mugz5XIsoSN4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5437b115-0d63-47f6-a50d-08df1a300837
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:10.9522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYbSf3SMoYLhFWzBlSPyPR+3iH62cBjvZpOK0FmWSYy2SX6QuLlaUeKZkPMTMxdjXFMpWCufJPtK/ByE/LmqAX9txn7umljatBpGrb9ORXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24327

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


