Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41CEF8D74B
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 14:31:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15680.1776349864213353104
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 07:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=x4S11B0T;
 spf=pass (domain: siemens.com, ip: 52.101.84.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZxXG7gMpSL9P/M1n6L0h5L5nP4VLax2CPw8hLskAFjpUHqSuZ939nePsmARlXA7lGTmxz8szweqFmR6i+qnLfwUQEBtjYpsPoS2zsPli3ZiBeSuTWzyWNf+UMY85Gpe1h7QURKPle8PmJYsT66+66Amry5SR/1VA1oLf7bij+2zOtP6oCm/xI5pHVJHr5eX8M9ZMOsz5BYzaTTlzygVAKnyX8acFoTe5MCtL5uOI3vOAsXYSC6ZtYNYLBrQJNTz+MXABEXblYRs92JMVAe2RAyVH89/uMQZIwaHP8hLKHARZVYu91MfY0v6UNmsxr8ZwNOOots/hJ/RFnEJNUFVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L10QnVkW/I5EWp34wD/+BlnWLTV1tc0J1Z+oKp1pMWE=;
 b=ilf3RAvBe7x9+d6ayGRQ7R2ALnjVhdkZXZLvtKzd6dsI0R/zw5sYyd1p/E/evNGlS+7sSFvkaPGhnH0IsyUF8jQit9row7oOrxp9ID6+YrpdgyVMoTBl03b3C4ngRUqHA0JZw5PSuPwwPUrC6HV5K/COa5hygaTVlPBTzGOdxKnlwRCShvvr6iAVkv1bVFPPQBiJdqHEbV75PSui/Kw9atymLz1liWJICEVUvbJCaON4guDBslRgs+KsxmyiRxeKB7FnG56RYl9RH5QmOe56gybmuFe/Tundspx/YN53umdazKf/uP24PMwzp5Qps4Y6u8j1YN93L7nrZ7YR7mw+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L10QnVkW/I5EWp34wD/+BlnWLTV1tc0J1Z+oKp1pMWE=;
 b=x4S11B0TbdEHRu56Y2NKZn46lFdW7M1MBK/QmvCZSEi/0OfYwD9+ByuADJVFVVXYHSKOQItsluTusUb3aXItoy66SZ9Py7k2l9qXFk4sI8RrNwMGQrTvIPdpaOnb4U6LPDHa7NOV6EZPfDoO8dnUsxHRQU+JrQiX2+b7bcVcCRD+SqMKCAKhzQoBWdclupUsqAMR/Mv5vgJGFgZgpEyVe3X0aVkmp8sH8jj1PxA1EsD8asNlqxBt7thEX51ToRvaD/Q1zUpelQgPp9hDrzMWaWFGSLtYuqYE66w7jFgIo4PkUUod4O465L07Kp4DY/yjIEryHwqi34VFyl9MGRzwHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7410.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 14:31:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 14:30:59 +0000
Message-ID: <ad76a9a3-9c1d-4b06-8358-201c7cd0bf70@siemens.com>
Date: Thu, 16 Apr 2026 16:30:58 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update to kas 5.2
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 599b5e2f-58e1-4f3c-b12b-08de9bc4c785
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	B9t2DpfbS+RAeJdQoJAq8NmrT6p1132Dvel0tWKqQXEknS2wwSXFPp4j2affW8ksQFmyqIbDprZMdUayMvyRZ0Er7P/XjpArVL4LXKxoiEvOkl1H2AyJ36+fKemjRsVlm9j0zQe+rTdnW/3O4Z0beCwxAR3zupsJmYTAgpkgH7yrIegRwOWElnuHXT7CqaksFMHfBETi+KAEUiOH/Y79hTYyjhqMOqcUduhxdjYOLDV7QI0niQmN8PYwxKPt969xavljHaGZ8PAeYLGLLays0Vf4Do0MAujryouFu9/uDCVDSSH31zWfrh1zV1YPkRSX2OQdwdM6pucAj9rU6rkv7EQ6r/M9JiKP/ULBb29YY/EgNHz/tFXo6nq1G0+Ld6eX5ADTpWC04KO94Krm6a7KomEXOj1ib4mViw3KF3onVa/EuGDNwvdQxONM18H+Y7/ep5KXJ4kGpjPje/ldUGM4wx8da9mKWEQNjmuGNewkEgbi+BwgcD5F37dD8uCt8OKZus8LG0IyeEVAS3RfSl4OfcyCquPPQR0lv8jwQp1fxy4JVuwhBCb0dViLrRxn37W+MwBXIu4gGZ9QjfXe5PXWQn+3x8KgLroR83mzW/wBpur1SvAPyuBh8B/p24f/yfZRQ+U8c1TyZEAnGeDJfFAoAYsa2vb8kfpbE1ROEU3W4Hc/lphWpfcdgTzwkx3wA7TT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1hZN1NNU2pXMS8yTGI4Z2l4T2l6MWFsdVRuRmxDdnZhN1Z3dG9EQzR5Lyt2?=
 =?utf-8?B?ZFRNSHFXck5hNm9hcDRyeDA5TmdJVXhhTUhrUi93Vm1nSG9QWlpnbnhHM0Rq?=
 =?utf-8?B?OGNrNG43NnZJV1dud2x5SGJwRDdHYXNqYjg0Y0hqekl0bDY0WG1ZczFWRUo4?=
 =?utf-8?B?OXhsakZmdFNDbjVnWEM3YTdZTG5TMVBZK0tDVXJBd3FjYko0Z1FFY05hT1Yy?=
 =?utf-8?B?TTEyVXJMYzRIcDhzL0crZlZsSm11UmdTNzZicmx3WnFXcWlCVUoySk1BM0Z4?=
 =?utf-8?B?OEFWNmVpZ2NLSzVDV3BYSHRCaVowMHgrZEJSNjlETUJXWHFyZzVLTnRPd0g0?=
 =?utf-8?B?MWhJbnBrN2tXU0phSzFLb1JsaUtvSEVvTnpzTVRDUVUzSWlpOVFCRFVzRlhn?=
 =?utf-8?B?T3dXbzlFRlo5UUZsbHRqUGxYL2wxU2dwb3JReS8yZTRBbEMzdkE5UnFEdzBj?=
 =?utf-8?B?R2VON3g3ZmZPa0k3dzhpc21UcHl1bDdPMG1XUEdiOUI0NzFjWnloUU1YMXZT?=
 =?utf-8?B?WU5YMkE1UmZ6L2VwdEpTU01ybG9xZW0wUnptSmxRMXl6anVxSFRBTFZaZ1dH?=
 =?utf-8?B?Y2NNSStnQjVEbVg4a2tLRjN0cWxzb290WFJJR1JrWHFlM21EaG00cEY1TjRk?=
 =?utf-8?B?bk92dExoSGo0WjdBbk1hMHRmNFliUGdxa01TQlV3TmZsVEdSR0dmSjhzdDJY?=
 =?utf-8?B?N2oyQnRoOVcvVTVoVXRTeHVwTVEydGdDS1B5d3NXSXlldlFaRjBmcDUyb09P?=
 =?utf-8?B?allIU3VFV1B6bEpxTzV0QVpOQld4UEplQXh5c3h3RGZITDRrUzI3V3ZPUlEx?=
 =?utf-8?B?bGhPbkJXdkxkMk9SR1laa2N1aEY5NFhGa2VQdnQ3d1diaW91d3RKcndoemo1?=
 =?utf-8?B?c2xPUTJuV0NDRUNoZzBiY2tlUk9DQlMrNXJnS0FxUFRNTTZiUCtOQlAvU2J4?=
 =?utf-8?B?YW5lS05ldHExcXdvM2gxLzloeTY0YkNONUJxclFNbVh2b3NudVV2bGpSYzVu?=
 =?utf-8?B?U1hPcmpuM3N5QnVQYTlManMyMUZGT3dYV3FQVTNZVEV3VFV6TU85YVFZakQy?=
 =?utf-8?B?ZWQyMUI3c3BEcDV4cUxMTm9UTGdCK09pQVZHWW9zWkZDTlJaS1lmRC8zRHY2?=
 =?utf-8?B?c2lBeStFQStoa05ESTk3aCtHTUhzb1cyR3NDMGIyNml1VE4xS3NCcWRJdkdw?=
 =?utf-8?B?Q3l6akNOd0tmcFVHZFl4aG1Jb1NVcDJGU1l6OERvaC9ta3ZMWVBTYU5yZzJn?=
 =?utf-8?B?eVVvbEdrVUNXWVdwLzc4ci9GZTdLUHlWejN3a2hpTHJXeEtmUnc3TUJlN3hH?=
 =?utf-8?B?UVl2OW1YcXRFdTFodkdadGxZM3kxTFRvMnJPaHl3RUE0ditXZkVZdDRZanFT?=
 =?utf-8?B?V0EzQ1BkSGFhMURuckpSM3YxaUY5ZjMyenRCQUgrd2VWL09mM0phUk9XV3FY?=
 =?utf-8?B?QXpqWGMwdkU2R3ZmSTZ5b3laMXhXRWpqT0N4aW9RYzYyS3Yvbm9MWFZ4RXF0?=
 =?utf-8?B?QzY5VUMzSUdpdmEwNjJsNldVM2hEdUJQU2Zsd3Z5VTJYRjY5dXd0OS9vdEw5?=
 =?utf-8?B?bmMwNTVlc0tuNUpSYitiMVBXV0ppRlI2ZjRITnQ4Yy9UcENOdzlDMDNteUQ5?=
 =?utf-8?B?WFc2R2FtVjhITmlHdXU3Njd0OHc2Y2pxVlJiL0I3YTBXenVkUk5la0oySERt?=
 =?utf-8?B?c1FFbWxOaWtJU3RIbmJVaXVGcTE3MTF6S2VNVTZ4ZkFqSnNOQ3lQY3JxWXk4?=
 =?utf-8?B?andlR1EzelBwZ3NnRFpEMkEyVThjVW03R3NVRmlENUdGRTVmUGRJMnlFLy8z?=
 =?utf-8?B?SEtUYjlHTDk5blowc3N0bDhnbStPRmNDQWxkK25jUjJBbyt0NkZZdFNMU1BP?=
 =?utf-8?B?SnhIK3d6NXNuOWtWR1ROU1JBTkdKQ3IwMmFOTytXaUpUTENCRE96cHdGRnJO?=
 =?utf-8?B?eFE0RGdiVUUwMEJ5Rnl4N3hxcjdQcUhZdE1LbHhUMjcrN2d2VUxPQnpPc29Z?=
 =?utf-8?B?VVRkV1p3S1hwanNHWGgxV0JjcTlMcVdCaUk4SmcrYllnVlozRlpPeVhiWlda?=
 =?utf-8?B?cksrR1FlOUQzQTZGNEFGMGlkcG9TZnpxczNJb2x4aGxDVjZqTUtnSEszSmZY?=
 =?utf-8?B?RWIzSmRJTzZEUjFFNHZDS0pXa1I0S21OVUxhYk0wQ3Q0UWlqSDZsSWtkcUVa?=
 =?utf-8?B?a3EwYU4vbG1kRmg5U2NHbmtPekMyQ1MvbVZYU29pUFQ1akhGTGlOMzA4eGxC?=
 =?utf-8?B?cVBUMGI3ckVKVGdwT1g1SGw2c3ZtcnU4bWJ6dlJFZFBTOHIwRzJybVpCZHdM?=
 =?utf-8?B?QXdtTExRc1g5UEM1WDVEblBTUFFpOGtaQmRHUU1ZNk1TWmhRWGpXUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599b5e2f-58e1-4f3c-b12b-08de9bc4c785
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 14:30:59.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1IMns4VYrou5XXQB4zx0QHHsn8O2sp88Ue6EuaeckflVoqZWKcsBCYO8H+L9K1Z7q4rQKuCAwS6975UZ7pOhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7410
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 14:31:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22743

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows us to switch the build container to trixie because all
blocking issues in Debian and isar-cip-core are resolved now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 kas-container  | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 602c5034..8f983f7e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -33,7 +33,7 @@ stages:
   - cve-check
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:5.1-debian-bookworm
+  image: ghcr.io/siemens/kas/kas-isar:5.2
   before_script:
     - export http_proxy=$HTTP_PROXY
     - export https_proxy=$HTTPS_PROXY
diff --git a/kas-container b/kas-container
index b46682e4..993f0bb8 100755
--- a/kas-container
+++ b/kas-container
@@ -27,9 +27,9 @@
 
 set -e
 
-KAS_CONTAINER_SCRIPT_VERSION="5.1"
+KAS_CONTAINER_SCRIPT_VERSION="5.2"
 KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
-KAS_CONTAINER_IMAGE_DISTRO_DEFAULT="debian-bookworm"
+KAS_CONTAINER_IMAGE_DISTRO_DEFAULT=""
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
 KAS_CONTAINER_SELF_NAME="$(basename "$0")"
@@ -80,6 +80,8 @@ usage()
 		    "container.\n"
 	printf "%b" "--ssh-agent\t\tForward ssh-agent socket to the container.\n"
 	printf "%b" "--aws-dir\t\tDirectory containing AWScli configuration.\n"
+	printf "%b" "\t\t\tAvoid \$HOME/.aws unless you fully trust the " \
+		    "container.\n"
 	printf "%b" "--git-credential-store\tFile path to the git credential " \
 		    "store\n"
 	printf "%b" "--no-proxy-from-env\tDo not inherit proxy settings from " \
-- 
2.47.3

