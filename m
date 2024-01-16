Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1923DC47077
	for <webhook@archiver.kernel.org>; Tue, 16 Jan 2024 13:32:25 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.54])
 by mx.groups.io with SMTP id smtpd.web11.13759.1705411940059520146
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jan 2024 05:32:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hjLKQspL;
 spf=pass (domain: siemens.com, ip: 40.107.14.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js8byVFaFzp5vtXb6EFtnsIJFrLwkt+D4LS/5VZMPHRW6jLOfwe2xttLQSf+Gq7YInAELdF5YDmCOfE8rzRuQTPWby06u5guNPdN4MQQCWXRwZ91/y8psgtzPw6XPiVb/KzB+2gPpddIqzMq1lIpBwhRFCUnUTW0Dx8xsjVexdrOTRqT0Te1t7MARCGZa9lC4hMt/0nipd1mwgrFTlAFDUWaNlOr1gUWHNDNCjg3IjWtIJnmWID+DkK52SjmQU7v0KsInZIUj52SMTzNcPo3ChxqCVjgWgJICN4phMc9XLRIV7/GY9yJH87V7Xgic0+j5VOY8qgq+JPyV/nTxU0C1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlyFzyR1htt36iDckHo421wKruMY7xTpPTOk/O7tHX8=;
 b=g4qc/6ECuzmo+AH6ohe9vyVtNrfsSRCXUIGD7AWSbwd+9Z+5tVw/uvvHxcgqGtfKi8AimRuXtZXEWVNGv1iT2IUVL3YURD7AiUawHcSwJf4ZeMEbK/qy7uBbNVWRp6Ft4skBD3hlIyWigCNbmDb3Y1nTrUerqnP+1mlrMARlbUVbPfvPqMFGNwwhB5EsjoAlQdsyOwnJ1AmOGS954pKL9SyidLSw+NsnAUG3aAxzWOVoCuJCstoB3LUFkBkN64+ZTKEwSEKbsWeZe+564GZAe8h4wymuoY4RoZRiSxE2odgbkTOpwLxWFrgBCJVO0LmZ6ljh5auPS/1GGtyJJKtgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlyFzyR1htt36iDckHo421wKruMY7xTpPTOk/O7tHX8=;
 b=hjLKQspLtFFS/Tw93T0qIHt3pnkICgSlBNn4CFU1Xy+V6gTRnMZVXR1J1gWI35iLYY56dh5f81pC3Bt40EzYCn8GcA4PFhDyDkTQPxkn8VmpJgRJTOlMeyUdejuR2ZTkRpvBd1fpPg+1AzRr3X6SNTAoxy7uVgstKXLK56nZvd2YXOhffgvQ8rZ+qB65n9jBKVm/amJfU6cr1CvIrioMpt35QV4JVhHji2QrC/DOIokwS+u+7Y9fgOMaW26o0fsR6OuOoaMwhqXy1MsTRDPJBC7SLNeztaFolY0/UiO2Iq+q5mLskfDQm6WATcvEFCQ5fC000fTSWnpwPO/CnOdNvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB6008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 13:32:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 13:32:16 +0000
Message-ID: <2bb4e18b-20bd-4dd0-9301-fb08aea7a730@siemens.com>
Date: Tue, 16 Jan 2024 14:32:14 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] efibootguard: Update to latest debianization
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee8a9f1-8550-4662-4f62-08dc16978e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	My1htle98FQ8/UuG5Sd90YgLn2i1HT7X/3BE+qI45oOfv8gaKFAdP7fCjVMu0xKbxYoV98gRuNkxp8S0lxIyqld7uBTYr8HyzaUigfdsimdGJNb68pC/rExjV1YOfdZgOGSnO4H08zRuozry2HifWfcrNnMyGd1gHGHrwol9EzxoTfdDt3qveow5+Z+Op1rhit3Ay14ZSeBSeNY2hRvvOzu4hDclTbjqWuiOzpRJH7Ity9XUX9B6Dn5N6g3OZUWbyc1lda3KbWyjQJFLNCIHTrThj/CM6EIg/3z1UHspP+ZlOVACM78BSiKcog3oNCnPJfrXcLKomYA2chH+yqH97OfRtlQVJDc4wkMX0/gobWFXlxYxzLeZadq9nSpcZBjMdHGY4zFNrmSiVW+2aJxSaa7JMqJuSaT+ZEq7uNtnVgjT9tpekkdJuMhOv2GCF+/xav+VSZdAAHK5J7Xlo6Us8HGrDSo7HLWqSum7abmWhnXhu/hAVi1O6jW1Myoh3AwfFNt3hXV4eKi6erdsS42EAq3/ZJvKeRBLbEvzqSut1LNmPUr0BJbaQIXg0j7HFecSxQ2bHAB6N2ymMpFwdRWhvrsG/ZRziazqNDH2lClqqiG04sYjeNKuIo5/MOxz2LMQ5Z7K2upPXw03eTXxN+0QRQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(107886003)(83380400001)(31696002)(36756003)(86362001)(82960400001)(8676002)(44832011)(8936002)(4326008)(5660300002)(2616005)(26005)(38100700002)(6486002)(66946007)(66556008)(316002)(6916009)(66476007)(2906002)(41300700001)(6506007)(6512007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1luNGpNQmpNS3RFK1ZwTC9jbUVUdDBlQ01PQ0gxZ1cwclRuemF4N002elQz?=
 =?utf-8?B?a0pPOUxLSDFpQWRqcmRrdXo5aEFGSmdTQXFGRzM4VjhCeDNzeldVWVBnMXR6?=
 =?utf-8?B?Z2NYQ252MmZrK1kvT0xjMDhUU2ZCaldvOWd4a205S3NKWFFHWG94N3RSM25E?=
 =?utf-8?B?aC9DUVVXdkpXSmc0c2V4cmczWVgzd002OFJFZjQ5MFR3S0l3WW1iWnBXQktI?=
 =?utf-8?B?dkQ1NHU1ZnFiek1TK29hQytxcXcxWFVHVFR6dEYxbFpiZTl2MTJhbG1ZTk9a?=
 =?utf-8?B?WGlsQWVZQUhacVppcUxBMS9XeTVleFlwY3ljcDlFeTJOYjNkRkE4V0ExUUJS?=
 =?utf-8?B?b2o3TkhJU1ZiaHpML0ZNU1U0NHl6ajZnWVdxRnhQOXZUQzRjc2RkZHJVTkdM?=
 =?utf-8?B?ZExXb2EwUTdXcUI1c01MNDFqT0VIR0VWd245ZTd4NTZJZWpFODdoL2ZQY2oy?=
 =?utf-8?B?WDRDZVh2ckM2enNFa1V0NXZodUlyVGpxbXBUTFc1amNDL053cXgvRDFVUStK?=
 =?utf-8?B?Zkg5cFU1ZnJ2YmJxeHdWZDF2UTlKV1Jia2NBUEt5bEZlNERlQnRqNFJnZVFi?=
 =?utf-8?B?eDM2S1FPTlpZS0VBWWgvRElIYW1SYk92a1Q3VDB5K095MkVIcWYvM2grRnpE?=
 =?utf-8?B?MDU0R05COEx6RW9BcWx4YkYrdkVvWDFpK05oUXh5S3M1U09LL0JGVTlYb2dO?=
 =?utf-8?B?UkF0QU9vMnZDRUtrT2dkSVNUWU1aM0dKaThnWFhlWGM2VC9iZEVPbXJjTWhW?=
 =?utf-8?B?Z3BiUE45SVpodlJNeVY3U0hFZDdZNEwyRkZ1SVVrQVNWSTg4eUhpSjRnWWc0?=
 =?utf-8?B?Y2k3T1hQR0xjNHFnWFdyakJxOUZrUmg5Q2NHdW03QzdPSXhqTWpqWXFNL2Rn?=
 =?utf-8?B?UVVUR2paSXZxYmZkbTBjaldmQ0d1TS9yRUFScURFMWNjbVJkT25kOHB1elJB?=
 =?utf-8?B?SEdsWFRRSE1Oc1VGRTVxTnlCanIvZDJEdElWNjNzR2cyQWQ0SDdUSmMzclVJ?=
 =?utf-8?B?SFgrb0JwK0hVZnRhVUxIVlRNWEZEWnJFZWk0RHE4WWttdklQeXZBdkh0UEV1?=
 =?utf-8?B?U2E1cnFVREJwamVxdTFvSk5BTllBaHUzb3JycWZ0a05SaTJmM3RWajdqK2ZK?=
 =?utf-8?B?N09xcDZLOTBZd1ZuMG1ua3IzVFY4THhSbmRpUVg4Q1RUbitabHRMamxRLzVI?=
 =?utf-8?B?QXprR2l6aFAycTNBb01kcWZqWDV3c2ZWMlptb1M3QU9Bb3VyaWdUczlLSkgw?=
 =?utf-8?B?cWR4SkhGYk5RbE55anI0UFJndWpaVGFRUUtuemd0Z0h0bE1wZXZ0R2hFUkIz?=
 =?utf-8?B?Tjk1S2RaNGd0OUI1NEs1bXZLdi93SkF6czN4YUpRZHViNHlyaVorbmZDdStJ?=
 =?utf-8?B?cWlQTzFZVDh3UEs3VUxSVVdMVXZpa2dXT2Eyc2dCWEl2MmJKMGdlK1dlK3Ny?=
 =?utf-8?B?LzNKR0Z5dGJHUHQ0c25MUVJ5QVpBd09nWFA5akVmZHZ6NFdqK25KYWJVbUFx?=
 =?utf-8?B?bXlvS3plQm56R1kwVGZ1eExrYm5pMy9jenJKZWpwak5OY1hjKzRlWE82SnVa?=
 =?utf-8?B?QXRGL0pvVDhGK09JSVJDcHd2cTZodVFSYUFEQVRxcXNyakdqcHluU3Q3UThj?=
 =?utf-8?B?WDVYbUFEdDRKTS9lWG1OUFRXQUhMUHR0QWdlUFB3MnVVY1dHUkoyK3hiekYw?=
 =?utf-8?B?WHc0SE5JaXQzUU1FVHZRcnFYNzViblBEbjJMOXZVendFcE80bjlUZjRsZVVN?=
 =?utf-8?B?TzhLRUJmV1dua1FNUElObG95YTVqeGRYWkFLcVp1emdHTENLSnRGdTlrNUNH?=
 =?utf-8?B?QnpNL2FaaXlaVkkwbHBEMmFtRHk2MG9pMXNjZ3p5MmZVdC9TMFR4UUR6YlpK?=
 =?utf-8?B?V2JkLzZQaENiRldWcndXUnRYR05DbktmUjRTNmdKeiszUVJtRjB1OWFjNUlT?=
 =?utf-8?B?UEZiVnJsZ1RENHdxR2I4UUNNZitxMnVzR0ZzTzliVmhwdHFFWWhIWGI2eVJo?=
 =?utf-8?B?Vjg4RkJaRk9kQlg0NE1wSEZMa0xJZ1BlZzNMNzRUWEZySENnMGxqMVFuTkdh?=
 =?utf-8?B?K2JjSkZZK2ZONHB4VmJhcVN5Mlg1aGxJUTk4ZFpYUTNPNFBvNk5oTFpvTmY5?=
 =?utf-8?B?OUxlQ2VFQkZRQU9zUWc4L0x4YkhCU3pGd0hrNFRZUFJkZHhJZVhRTEZqdXNa?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee8a9f1-8550-4662-4f62-08dc16978e50
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 13:32:16.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQWxHUJVp49VKy9BLKNkKbPOj/5VGkdan7LGIunAjt0qExq+P46TypeyeesFPB3pKrOVtIzkRj5oxcWS6SbZjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6008
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jan 2024 13:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14395

From: Jan Kiszka <jan.kiszka@siemens.com>

This fixes cross-building and allows to use python3-shtab in bookworm
and newer from Debian directly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...bootguard_0.16-1+cip.bb => efibootguard_0.16-3+cip.bb} | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.16-1+cip.bb => efibootguard_0.16-3+cip.bb} (89%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
similarity index 89%
rename from recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
index a7ffb00b..83be2a4d 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2023
+# Copyright (c) Siemens AG, 2020-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -24,7 +24,7 @@ SRC_URI = " \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
 SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
-SRCREV_debian = "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
+SRCREV_debian = "22b173a3293c976c9dff2ae92085d7ed995f6768"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
@@ -34,7 +34,9 @@ PATCHTOOL = "git"
 
 inherit dpkg
 
-DEPENDS = "python3-shtab"
+DEPENDS:buster = "python3-shtab"
+DEPENDS:bullseye = "python3-shtab"
+
 # needed for buster, bullseye could use compat >= 13
 python() {
     arch = d.getVar('DISTRO_ARCH')
-- 
2.35.3

