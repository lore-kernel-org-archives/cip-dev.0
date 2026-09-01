Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F393CC61DD3
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 12:40:15 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7060.1788266411551962311
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2026 05:40:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u8tCaVUu;
 spf=pass (domain: siemens.com, ip: 52.101.70.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKh2KzPiXhecaTHE3qwbnyF2Op4TwQqjLSABfkv1eXGJJ9bMuOfjXY0iLjI5Iqf/jbj/OLD+NLcaAXuDkFuUbCbIq9Rb/35m+evjVGZRHziO+cTTN3g6HpH7VI+aPJctpAWX8ECm5uwVIRatzF95/F1hP6QLo9o7tgeUr+wwqIPjmLd9VFC43M96MJ+EWlxBKt6IiteZv7qUyqBHTqE2BwTls3z1GOKBTDV63x8qJV+bcW5qUrg63YuSlH/MT4wcNpPaT0l5j5oOfSIZ7RKZkJ0+Bou43Dn0ys9PTmlYhP6CCY7ieQ4XAHQwHt5QzLu1YYPIIjytSiCbhVYdDexKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b06xp1KIqocEwmgwQ8ZuK+huozwwbh0nv69VggGoEDI=;
 b=JJZ64Qa0VsQbeI5f5062zNCKnPzwK5DPLh84u7exVaqt4qldWWPS8n2xDx9ajzoY0c1ITXeXvmNmFrWioWnPDWu9F8mQYpGJgS+v9bULUYIj6VmovpKrkYaMBZbVI2TERSH249REm2CERxwKQFBOXPQYRmq1nsd2hlnnVBiFZ8eDP5ibBLjt4BJ4nSFmSVoOgPNMX67mG7blVhOr9YyFwdkytnqZAYhgk+0n2kTFrKLGd2BBivGkUmHiFsL98B63jtJlmGBRDMRdMj4DVOthRAWA3ejboruyjan4Y/htvFM7o3uHsRKtd+vb0GszzFDVkzrpqgDeDqrHt8MVSnS7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b06xp1KIqocEwmgwQ8ZuK+huozwwbh0nv69VggGoEDI=;
 b=u8tCaVUu4OY4jIAWYtPLsAYnjblNxoI3wwTwd3zrY/bxG+io3U4UsuE3h+wRH7vQ+Kq0c4bT6T1yqVBpSxckKRi0hkdoLrERD1PenK8/2ZEsYjvCP9DisbKvcs6TqnxPEvS/Rccle1n5yY8Hsbe/eenz8YLRb9fvSrmpBJ1h9uZlznOwCfb1OXOPfUXhb5Aej8aKV9ELX9esH0rvaOvELU18jSIsHmAyPNr0IQYBNEvqus23mwVfUSpV0l6kkx03Xgjq3ikbuDFpXE5wQqXxKjSqVqQQyMkz9hbOZNHcz1gQM/p4/P3xZTpLeREwanScMjvY/u6DZckD0gYMZVjbaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 12:40:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 12:40:07 +0000
Message-ID: <11dfa98a-132a-40e4-8353-d46b1e8dd3a0@siemens.com>
Date: Tue, 1 Sep 2026 14:40:05 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Fix and improve lavacli container
Content-Language: en-US
Cc: Michael Adler <michael.adler@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3336:EE_
X-MS-Office365-Filtering-Correlation-Id: d1126c26-0685-4ef1-ab4f-08df0826271b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|10067099003|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	FFxvtPuCpMDfD30V5gjeHRIkzFjKeRBWq/vo7hmVs4DppdFPsbMwvxUuiXix4A8NytcaHfSV5ob4lGG+0sOMUzUE5elC6gEjI9DHgK98FqHmMMVUtVHNq5qWjeAyh4tPH/Q9JkpRegciekpV9HkXPrpfIl4k39uxU15NzwE0NE0pJxs7Df8rkEXEmdp9nRIAbb0bYzfKl/SDZmtlC22iRMcuh/Z7YlX78oRQ2f+AZ+U+HctCJBpCoBVeKh3ZFosLlCYyBesYggzHE4EDZ/nGqWOt/NPctHEcUlvuW+ieCnWribVT7yh572lB5HAmQMPBnsq/R0zrianTnujWCuqgFoB2yASfP+8l5bGiSAAMsYQAQdsDSDNT9w5mif20bATdCRrhFuRb2q+tF3U5iTYngcPxNyqjUlZWUHK6ICDm2RezpY9TnJvrRo/btEL5pCFAlO2r+UyFWrlFhgZMyR3CLcwbTeU92ssdi/zCoyN5FdITF1ttO5+mva1GIHdNfexsTKalnRgE5fqdDpkaDbID9AFbQTWEd92BhwgpZQCB7mkRNJ10/TUM+VgVh7zi78G1MSbVkCSbeuhKVWDEOurnOF8No4jbeGOXi3WFLodjpQT0xUvJKf9CqJXOa3XQoqxe
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(10067099003)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?azVPSERlYzNTN29CT29CL0w4dHB3VTVkTFRxWVFCeUhzRmhkekpQazROVDBH?=
 =?utf-8?B?MEk4UDhlTVdGczIvUUlhZVZPSEFFWlRpWHI5MW81ckpyZ1M1YVM2VERJSlFz?=
 =?utf-8?B?aXhYTEUvYTJDWWJDNGEvekRnVThkNXAyR3YwYzEyNkxXS0Zya21MenhhWTE0?=
 =?utf-8?B?SDNXMjBFbVJmM2laMExrRmdlR1o2N0IyTWZJWEhMWVJCT3AwMmMwMkRndzkx?=
 =?utf-8?B?OC9PZ0dzL0d0TVVJY3Y2b2pCc1ZVelRIUDBnL05ieHVGUmxqcDNmQUg2eVVi?=
 =?utf-8?B?UGcvMzhhM21wOUlmM21YZEdQN3E3SkptNS9QOUxDaXZQejhhbXNxY09WeStP?=
 =?utf-8?B?WG9zcktGeU0rcmpXOHhlaEJBUmRQNnBadDNxUVpYb3VpMTluMzNMWHdwd2Fi?=
 =?utf-8?B?Qkd4bUVOUDlzTnpxcFROQTN5S2plS0dNeEdMWmhPS2RFalJtVnZYOGdWMkJP?=
 =?utf-8?B?UXZVZXZJSzF6ZXhqTG1IVEViN09LUmR2ekc4OU40MERzdFJ1ellSam9kN3Zv?=
 =?utf-8?B?bk5EaUFtUGpMV2JObUFvZnh4Tm5DaUNpQmpyK2VNMWRjbFdVMFR5MVVmaG9r?=
 =?utf-8?B?R1FjMmlyUWo1ME13cFFNZ25HSWxVUjZ4YTRlbHNhd3pGcWJKZ0VkeVo1alh0?=
 =?utf-8?B?WlFYUnFSWXh2N3podkxyOE1aNjE1cGZBclEzeVJXMzl1V0Q2QzdNY1IzVk03?=
 =?utf-8?B?WE5XcStiM25TL3IvNWQ2eitINEpqeFg4d05jVXUzU2RjTTkrU3BGWXJualJq?=
 =?utf-8?B?MnJJdzdxQnZtN1BWWG04Y1B1QmhYSk9oUGlHek5lMEpCWFRuTDc4a0tRbVZw?=
 =?utf-8?B?ZG45MFRUdFlOOTI3NVR4YmtLNXA1UG1kSmdxTkZMY0JrN3VyRk91TWRkZXBv?=
 =?utf-8?B?WkpFRVNCZTZwblBaQnR3cWVSSHpHRXI2b1NWbGlNTStQQjRTU09NS3c3NGtQ?=
 =?utf-8?B?dUEzSzNaZE9pZURxTGh0amsrNm5hbVVyQlYxVW5tcVpBNnI4emZ2dHMyQk1y?=
 =?utf-8?B?STg3czhhb2tvRExhWU1vdm1pZGNnQ1YvQkJrTkpwUWx5WnoyVkZXUUQzSm9L?=
 =?utf-8?B?aEFPaC9OTWxYdnNicTVFcGlUUkhVNlJWZnFubHQyL2w1YTd5emNrZitwOFNV?=
 =?utf-8?B?cFNtSERwM0tzOWt5U3lVN3hvTDl6cUFMYTlkUTN0bG91M0dOTnR3UTRvYmY3?=
 =?utf-8?B?dkFyZjRFZFVCMTFFZEFUM2k5Z3RwSVQrd2FTZ1lISnVJVjBpcy9ucU1yaUxo?=
 =?utf-8?B?VVFDR3F6U0pPUzNiVnVoRm9QUmZzZ1NpdmxnZDVBUzVOVkVhNnZLNFNaaVFG?=
 =?utf-8?B?eS9uUk1XWEFUTWUvZ0hNOWUvNUkwb1FEM0RkVlljRE05RHJTa3EwR0tRNExr?=
 =?utf-8?B?Vk00SzZRTFhEelRzN3VubHZGcXIrZEZDTlNTaHg5WFZPWE1mYWdRT1Iwblov?=
 =?utf-8?B?aGttaVFZcFhaLzVLdGV2Sks0TUxoQldFd3VRS3JvcGZxYm5Cai9STzhtTTVl?=
 =?utf-8?B?MmNzNTVRc2hnREl1aWZpTjZWRUZwclFRZlhrdHovRlZMRTBSWU1OaUcwUW9U?=
 =?utf-8?B?c2lWc2FUdld0MVFvWTdMSG01ZndPQ3FYUjRjTVNLL0ZYMW9PZmJJY3VtRWZi?=
 =?utf-8?B?ZlAwbDhVNkhreWt3L3FzMFhzei9WNFYvMW1sY1BJaWhvdzlvREZrQUJ6Uyt3?=
 =?utf-8?B?M2ZPajJNa2x5eGZjSVlEQXAyZ0UyQjBMQ0dXR0w5dm1VRUtqcEtBUnBGVGUr?=
 =?utf-8?B?QTY5cTVDOWo0aG5yaWhtSVhLQVRhME9oT2tXWk11Z1h2RDRBRnd3NTZRSTdF?=
 =?utf-8?B?dlp5a1hjMEJaaWlqcjljUTkxUU00Y3Vzamw3WldrLytlUGh5Z05BNnJWQ0N4?=
 =?utf-8?B?VWZrTnhFTUdtazVFbHJVaWpaTUFZV2k2VkVpNmFuWk5XSEtYV3hBVkp3eFUr?=
 =?utf-8?B?ZGE0NXQ4eFkxRVhaRm1BSFo4RVNXekY1NmNQelRPRm5XUHhqM0hBVjhNSWN3?=
 =?utf-8?B?ZHpUZFlDczlZN0I2YnMzS09kWEhuWFZ3ZnorTTFCN2s4THQ4cUJmcHB1L1kv?=
 =?utf-8?B?SHI0V2s3UEdUTmZsZDUrMTBZRHMzazRRays2Sms0NFZRaUxjclNVdW5LVmpr?=
 =?utf-8?B?OEQ5d3V6ZzVGbmdCSjdGT0xWTWw0eDM0VXBaWUFPWDlZeWRHSjdOQUJKZkpu?=
 =?utf-8?B?Q09CbDlqZlVVVDlxdXgvaGNHRTJjU0lmdGhVVExkT014SStvTnVRbHNwMmxN?=
 =?utf-8?B?R003ZnU1enZvclZPcnVaSTU1Z29qQTlxd0ZUeCt3MGdNTlNvaGpPOVBsTEVx?=
 =?utf-8?B?YnViVk9zaXFqek1lNXUwT0FNZTNQNXpPUWh0bWgyRzFRV2dNSGJ5QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1126c26-0685-4ef1-ab4f-08df0826271b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 12:40:06.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iZIO1iRz3NM5FnXEiNpUAdEvh+WZsTjND2sYHStgBXx/D/bdTHBTED6OmnzqrW/Z+AwLAFeTFpIGzMrd8Bk5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3336
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Sep 2026 12:40:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24052

From: Jan Kiszka <jan.kiszka@siemens.com>

We have to set the STORAGE_DRIVER to vfs, now that we are running in an
unprivileged container via large-rootless.

While at it, update the buildah version to latest stable and harden the
security of password injection according to best practices.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Maybe we will find a nicer way with kaniko as well, but for now I would 
stay with this pattern.

 .gitlab-ci.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8dbe62d2..fb99b4cf 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -934,11 +934,13 @@ include: '.reproducible-check-ci.yml'
 
 lavacli-container:
   stage: build
-  image: quay.io/buildah/stable:v1.41.4
+  image: quay.io/buildah/stable:v1.43.2
+  variables:
+    STORAGE_DRIVER: vfs
   tags:
     - large-rootless
   before_script:
-    - buildah login -u $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD $CI_REGISTRY
+    - echo $CI_REGISTRY_PASSWORD | buildah login -u $CI_REGISTRY_USER --password-stdin $CI_REGISTRY
   script:
     - buildah build -f scripts/Dockerfile.lavacli -t $CI_REGISTRY_IMAGE/lavacli .
     - buildah push $CI_REGISTRY_IMAGE/lavacli
-- 
2.47.3

