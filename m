Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46998C5CFDB
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:49 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16113.1786617581341459718
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=CO0lgZ7x;
 spf=pass (domain: siemens.com, ip: 40.107.162.41, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ0SO5vENMGmDjcf39iRMklA90zIfok810K5nPXvJ3LdIhlgqMtFLGumKTfQs/PsPIBUPXTLsKDK7mIq6nzH8VgkXdmmbRzMqC4Y3eWO2gdDeXkYg/xs+sMbcQNrL8An1Wh4RhgQtgPk0PL+S+h0NkGKqtnaPyJBd2nK0UimtYea11O+5x06Hgiem4dFNM1px3WCCGXET0qTs+WKbt9F2NRLx040EnA5pbS+s9EtkN9VODWcq7bdZCi+0/wo/Cgmbv3oOQDQ7I1ojF1T9IFxta4Ya6fXPRUAtLWAF0w8X/QVjAM7VQ9VGYar4/HzLNpM0ALhXLIVY+PzEx7rNwJZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ0duJCpqcfruhBEpS3FSqjLLU69lXJGIa6bl8cqVnc=;
 b=KZFCcgG0pPZfwzMyu4yUfET2npq5ZLXLQ/10ok+QlghgpVnliKOOx4GNn+GCp84tEfKAbUBpZ0/e3VBP0xM7fYGd8XW+f2uAYJZmHwljk3+UQKGv3O0mNJZBV/9Ckqa0gEheHQRX80wvBWJI4PGPVKu6h4ZYxY2mv29tfnGStVbF3XuO6aq8squ8h8CzW+SMKnS9usR1yWP96gwAiPz2h2lgzBwVtiVfkf+i2fYU2ceitruibedgBqizx6yj9xovP2JTJfzST285FLvmflNpGwXp+2oQ40txdB6pMhHkTviUWkbxUBbVHuIfyRkwvS4cjSh4t94uu9jT41P0x5JChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ0duJCpqcfruhBEpS3FSqjLLU69lXJGIa6bl8cqVnc=;
 b=CO0lgZ7x/+klolbDJepMLPBHvubYYuvxYSr/S7D8IdyIcyu6KjX2RYV2GJPdB0gwRuxN2XHGo34YxY7NP7wXY4pClySORKWyZtA2qPm3teWiRzPlx+GPW3tD/6uvXHZxgskwRKATNxi7dyRS2CJaOJhKgydBXQGbVj/v4U+mMCw5tDbt9pq39XYCCT7I5I6icuMIkww+OrhytrcMRsiMyrJn+aP9h+HIWYNFrcdjsGogHD+0NnRSdBMcFgIi2gz38XqGb1zskXOA1jVfY/mhL14YnDiioGYMlvckSIGHyY6TwdSkgDRHhVRkXE9sJcucxLfC+B2pIavk7Auqi2sycA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:39:35 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:35 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 12/12] Add Kconfig option to select cis-validation
Date: Thu, 13 Aug 2026 12:39:02 +0200
Message-ID: <20260813103919.184402-13-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
References: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 327d71e4-edd3-4906-7908-08def9272b32
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|55112099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	R6spMAJXzX7qQ2Y20QH5PJsgy1lzD7UKyomds2+x8oXR9csfOilz2WlhSvDNNwIYRbko9k7gG3lS8yrAsZvA4h916JSNhSHQbfuaRTHmSEobvcwASsS3MENaAZTSIb1njHA0ZGBK2P32/AEp8+Nf86m0bnUpNwllBQwBNl8dwVxIeK0oVxA//9e2NYnfZP7HKvwykhexWihUFgS7KeWiBsxRSHf/Yy2CcZpOXkF2JEagXiJm38eLIyi9RsSI7IPT9vRIPSqGV1WP7l9raP6gr5CP4Cszzt0dZCJ/fFlEqaussOBCa5IaUxdJIUQjCjgWpcAR/6GlbtB01bSHx/qWlmy9Xd1lwpEXJ6fToizoRQIUgntx8eLKe+rgKrH8yGIwAQd4R3Bm5B+wgpcvCc8El0egNAxaN68V14/Jb3/Jc/X58MJZR6V5zVL0zKVpRaeTglupW5cBiJarksTMYJbjBb5hXHnCkQOpkp6sMCjnIwubvlCqK724beCGypCY2PlRqUI/CWp+i1vktnLiXD4ShX3VneOXW98KTowE2DDbZcsTpfQm204WfJ42gg+p0b6zq34faNNETXpC6qXKLFKHc1TI7F+8EXs3PWEcPICE/p7v+u/F+VlOETMS63c1dMxrkJyOE+tcHUASCDFjFRzO/0mEycwO8UkZZfJzR9AeLLY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dl1p7OE5sCVrmTtDPUjnvxyCCE8eZKJPke+mUZeb4tUqyekHb8GEEfIOcEoX?=
 =?us-ascii?Q?S6qgN33GIWVH3rrs/35g30RGiOK9O4bwQ5CI8yo6EcKhhMlyUy30S9TWxHUf?=
 =?us-ascii?Q?zVNvwHjqFw3TqxzMuBrnf8RbPgYTgSSnfvZLKGgXJluper8GQYJ8/JtNoz0L?=
 =?us-ascii?Q?Z05lt5KFCn9/SWpeYY2pTK4tNmbIeaC9KOInNTgvGnH+KrxxIRkw5qc9vC1F?=
 =?us-ascii?Q?hhYBkVgpLEKQvOLrB0rETpw8bar9TNYNSCKDLb/PriYwqba9NbW89PnWyyV1?=
 =?us-ascii?Q?m1yDhbiuE2/xuVtDDYatso9dWvUOfyC3HNOq/4lJzIizDR1EHRS9OwJLXYxC?=
 =?us-ascii?Q?bQYs13EppL/aZbLyxGiZe/O51jpPc1EdJ9LfVR42Vj21g8G1gkF5slKhDqTL?=
 =?us-ascii?Q?AocC+Jv8A+Pr7MWmvb8BdhSDs06OX/CZEVhzBLnjRMQAGH6dUlzXgTFNoxVj?=
 =?us-ascii?Q?ZI+o/b0uS05giSL6jVymw/yIrJzVVSJyAprvk0ANXd61WV9C7LQ1h9M9kXq2?=
 =?us-ascii?Q?INo0tYDZuKQkhGzJdEQPOMRoXd5802rnWeOUUjMYBS5jck5jYEVvuoQmjEqp?=
 =?us-ascii?Q?JII2uWLR+DMqPcwluEQnxHIZ310GynU6mjWL+sQf7qfneSSa2xdkzkHpQkpX?=
 =?us-ascii?Q?LzC0DutQ0x/HSGh+zy/ADCKRQtgjkDmPTu/XvzNdMYyl3I+O7/aD73Zo50LW?=
 =?us-ascii?Q?4Y5ntWudJP+3jP+GnlLdEjUAGkrVzzpz1vmAPxs0XOq1uT0+5s5rqsN6UvV4?=
 =?us-ascii?Q?qs3E5l23uu1qhMnAVLKKrKbdKIu7yWp1tyjDz9pWMEyhcJXdOJBuwVxxP05v?=
 =?us-ascii?Q?r0LMSANCVuqFo/ATY2/lfvAx/XzSzLj5v/Ehh6YRbwItMo3Tqti7TDIrAo/k?=
 =?us-ascii?Q?5dBOjN4ZIg70VfohDGnp73aF8rt8NxnwwbHhA8tAo6tCDv7AV/YZfn3DMp8B?=
 =?us-ascii?Q?e4Q8UsNEYD8RQTJGUBuunk+mFnVdKaBMEJsmMeryNZDw5lS1ESGD/oeHK06m?=
 =?us-ascii?Q?SEm6zcacX9jxv7yk30/A1tWYCIM6XNAZwH3s96eBz+/BC/YfXTaXBF5y8hpJ?=
 =?us-ascii?Q?HNYpRDU7zXxY6a2dttyeZnoqsR2DyTh30JdMi8MlbzF6BtyYUQexz+jtifQz?=
 =?us-ascii?Q?/C4uKfQO9NsfJ8CBjgCgCiGSvSeJBgDLfolmA56cy9OnEbqNwBF8qbYhXnT+?=
 =?us-ascii?Q?NBfuM+VU65RyMF2pgjdpa70O/jj2P1TJX/fQIul9XoEMg6XHYzOkMYwWQ6aX?=
 =?us-ascii?Q?OQnwjUI5V5XCIOFis64/AzmBWrSuRYoSknSDutPa0YOTGekngo0OunncOK6Y?=
 =?us-ascii?Q?1EhIyJ0chpSNiQgMRV6Irvrlj24ZXbwZTOrGiqrXtt4XTGm+FJqn7hc3bLGI?=
 =?us-ascii?Q?h8YAWi4E8y9r/j1KPRtVozs+wRRcNp3XOsEstvCUEwPCIVU5UyX+kl74kLKg?=
 =?us-ascii?Q?QO+BsTFn7X+YVhWpdAJZdsls+4Bob5I77f5RtSi52+XM7m77dSFlxSq4V+nM?=
 =?us-ascii?Q?KsrbWd52Rdp1m9BaWH3vmUVJJO7oRVfuVOFpMl1M9ABT7gpus1EVEVvtDWFY?=
 =?us-ascii?Q?CvT9u1DzftpeDjc3iZsSLPdDtR/sMvaWX/L9PGgH6bb17qILcdeFTS4I0AKO?=
 =?us-ascii?Q?5eFYROYqZw53+rK5/ZsD21LbFB40vzQSZ6y/zcSEMqai/vcdP4XL6iUIvMSl?=
 =?us-ascii?Q?1RrT4/zTLfXF5OY+KC5ULkUyC2bJ1KSq7txSDRHjUPybT6ciWhlpt95sJwwO?=
 =?us-ascii?Q?clx28M/Baj4J6/dj3d3hfAZ34VMtpxs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327d71e4-edd3-4906-7908-08def9272b32
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:35.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4Ml4uHtqcuIhWlbrwCDcMBmhJajnDlUgU5Jee0/60kLpRmP7QNUVR6qM1GNPoyy3hxMonW3eiice/S6OkONX7xjuQLcvkhguCYhXuVPPUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23928

This is for testing the cis-validation.
The following rules are failing as the prerequisites are intentionally
not installed:
1.3.1 install sudo
3.5.1.1 enable firewall
3.5.4.1.1 net_fw_default_policy_drop
5.3.1 enable pwquality

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Kconfig b/Kconfig
index 7575d89c..b01caa5d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -368,6 +368,12 @@ config FACTORY_RESET
 	  This adds the necessary packages to request and execute a factory
 	  reset of the persistent partition. See also ./doc/README.factory-reset.=
md.
=20
+config CIS_HARDENING
+	bool "Harden image according CIS rules"
+	depends on DEBIAN_TRIXIE
+	help
+		This hardens the image according the CIS Debian Linux Benchmarks and val=
idates the successful application of those rules.
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
@@ -384,6 +390,10 @@ config KAS_INCLUDE_FACTORY_RESET
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


