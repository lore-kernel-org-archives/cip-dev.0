Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08B610BA438
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 15:12:31 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74836.1774624342055669531
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Mar 2026 08:12:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=shCz6LGR;
 spf=pass (domain: siemens.com, ip: 40.107.130.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/GTzjYxWooYL80CcG5LFJnK9QU237QavTm+1Jp5j9V6Z2bku0tdRZbT7RvZI9gszdilOwwKSNJJViiwuB5ZHVBQst98uj2t/Nq9+9Zd4KKd2hXOLAS8EGptUTEz2AGhKuMlNl7wQybObsXouS/YZRvI/bD/3wmd4MgZGZ8jTl39GUeAMLy80oJRqbGvX0zLNLqIYbNDBfY4gf500T7ueoyeJSfC/kRg8PzIH/FoGHPavUgECCkW/hcwR9VDRiIgtLxjO+S/9DFob5dgUtDsLihFJY2ITXTiELSXXQ6Js+B/nrepC8QwmPOHDD9UX/reDej2ttbMklB2FKxYcttpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orRcRPTpOm1hnHurDotmwWU6srdCxMao5XPCeo/a+kc=;
 b=xFQWXNtjOlebgP1Z8jsbyK0Yap200dEBqJP3V/4zFV10t1Y8bjOibBZHZSC1E99N13YMAwyHp/JKaLX6WOo+K1IGl8pyMAs7vNspTQfaqyiZDUJSSGUjdPQ4D7GSxmDB2WeSmcUkqXblIPSruLdSTcgg62czlxUEvuAq0wpvg9u+LwhG8UdqdKk8EmIOkZUCb9H3nUmOwWdaF7nH4lJGPojE1z1Np/yKt1XjzCaRhUpJ4vfJhUnKzsVaNAEkrQNg5B+4XWD2Sd6dF/5aaEJtQeJhjnYBZhAGhIDkhVBjEJlz2hGLxVT0jWspUYfDjGAUyNlcw1kJAxuet6wETYN4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orRcRPTpOm1hnHurDotmwWU6srdCxMao5XPCeo/a+kc=;
 b=shCz6LGROkkXk2eJUHNTGgTjQCPOsaxPu07SJU10ypHvNRSU80NxRXj4P/Z3GTe827s6GSX52xvxj9ZB8XPwN34yJPwngrrB802Rf5BvlYkQ5KrGJAWBeuIW9rtVKoNdJPjx54h6mm5lacM1A63YEkFsFbKLPX72anJZr6vyleTp7Gy2zRDK0vJPe9djzUCdz2IbzmTD5qMRX41J6+riT6M25M+ZcH/JYM+8DhuZWHxsOtmvrpg9xJLlDGbgNcjFxZqmouCraq2mCPlJJ/5vpsTN3yjhibPKRnQqnVpEhPFyfKp2IqTOBV2QhBI4r/K1UWyo0mm3zTIVRo+CfQnk8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:628::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 15:12:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 15:12:18 +0000
Message-ID: <92288619-2ff3-4fbc-b7eb-cf8ea47d91a5@siemens.com>
Date: Fri, 27 Mar 2026 16:12:17 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.12.78-cip19
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 461b83f6-f9aa-479d-24fd-08de8c133ca7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	eTuT9nfymzLCPgoo3T3sYlxoTdAgKAinPsKtxWjF8c1gTcrpy331YL5xjwTQ+EKNpGSN6dpFKxBJBeIdAzUl1c4OjFFhW4Vp+XXNybnLj5Bv0StXsQzM8cvhvM9cIs6IQxQnrFG3r9tkinA9GIpVP7w3sltdzr7+Swpr8OJqb+/iEvvMenEZZbjBuC0GU+dfBHRrUoXIU31wp1hZ2nqK+ECz16D9Hf0CGTOHshwZiYkRw3x2U3nwm6HBNzdA9zbRJ13QUwDvQbrV8yKE6n2CWdvN983U/JFZEZuC73kjJLKIyu7RF/WBQHbTaOEKR8l9cqlUgoD7pTc+HAF3Il4ZrSo4muephf+XQ2KYQXjruWgLRVxnt4Fsd/YPZO6odPR0m0di49DH1dJealkaRG/3WiRNyfHJrBsXmDWu5WXP7WtMNFYKxkEOfosishKc3uUGGtp8LtczFrr5uC2FlRJgLS3dPZuZv9RJBAIkETq2gDT3S2MDTaDVAjZthD8o1O/Tov5ja8ysDouk6UzzpHGBp0nVPBAjZyYrqoHZWbBuCgQ5GJC43L8o0FMt4ocr/C+7aukZDKHAZaD8nQhouSqePSd3WzF1t+5SRNNxldkaGWF0DdKuI3DXGoXLTlbGwbEm4y42IkN02UPzOhbSX50M9GrkkB2sofSyGYVqi+8KzyNMZzrnEN08byyuNP5bmHWZrX3WO7VJ8LTnU+6kgkbI7lZ/GTdoAqOVeXxXOCKFqB8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmRUZ3hvVHRSdGZPNDY2NE55S3pualBTV2RSc2szVEIzL2pmczJGTkx3WUZn?=
 =?utf-8?B?bEpsVDFaaVRmOHBjNTZrbFpNZXFjMDNVKzgvbWx3c1V0OG1Fc2twcENqMFBi?=
 =?utf-8?B?OVp0OVgvK0daTlFGK2Rzc3dVYTNCZEt2SEFwVEdvZ2hlZ3YweWJmWDdEOGVW?=
 =?utf-8?B?UnduS3l2K3JCTktJL1J4UXFrQmFNTWc2NHVVVUJoUjZyUjBCNUxCZEdjQUgr?=
 =?utf-8?B?WkxJdmlaS0MxQ2FYc2NtcmRWeTJRZXN6Rk1TNzcvZVBJSy9LQjNZWHUzT29x?=
 =?utf-8?B?RDdBS2YrWFJVaUt5T2tMRm5IRlBnSi9OU1E0bGwzM2dRbVhNdDM5ZXQxUHlC?=
 =?utf-8?B?Y0Vzb1g5TE4yZGlSL3h3UnpEOFN2OWpMbmV0TTJsRzNwd1IvUXZjR0o0aXY2?=
 =?utf-8?B?TmpFdW9NMkVZS0pqU1RJMGNzQURHczNCaE5IL1M2TTlCL1l3VWpiOThwQ0ZT?=
 =?utf-8?B?K3VJb3V4cUhtSG1WTlE1aWRBU0Jzcy9PcGJDbDVZVFZna2pBMk9saFdXa1Q5?=
 =?utf-8?B?NFVvSzFWRDFBbTNGNFpIbXg4NmZreDRqSjFzRTBGdDFSL2Vxd3lXZ3F4YVMy?=
 =?utf-8?B?TWFGSVdqbnczeEJPL1d3d0JHOStIOURQdGdJVVFCTnhMTWpqK1YwdldTb0hS?=
 =?utf-8?B?TFk2QitzcVN2anJPRzBHSWhWcTV2aFhGbUtHY2Z6MTdXU0E2bEFUemVXK2dW?=
 =?utf-8?B?NnRzbkcxbWtSVFRrazVibmNBK2VMUTJxY2laTVp1b1VEeDNZaWdqZVhzSU9u?=
 =?utf-8?B?enBhWXRISzhzSTFPTm9XYjY1RExvS1NrSllwUGRjNm9XdWozL1ltNm9YWHFT?=
 =?utf-8?B?cDdTdHF3WnhvekhKcnYzbVo4UjN3djFpKzJkeC9aOFVPMjJiZktWcGFYd0kw?=
 =?utf-8?B?VnRiR0dwL1JlZnZQbk9pc3d6MkFiQk41dEdHT0Fzczg0V0VxYzBhbWtpR0Jo?=
 =?utf-8?B?WmVqMzFqanJ0WWhic0FuTEdidWpnTThnYUY5RzduMXJRREhaT2wycnJJL3RM?=
 =?utf-8?B?bjg4RmJWNkc3RllzNkdBZThjT2pmZDFhOWtFbjIrVVMxdmFrb1hoY2p4N1Fp?=
 =?utf-8?B?YUlKdm9ZaHlkbDU5ZEZUSWhDZzlVTkdKSUNlTE4zenpUYlhkWU5TK0EyR29D?=
 =?utf-8?B?SEZUdklFZklON0tpWTUxZGtlVU5rd2tKditHTzFQc3MyZWNjVUpyTjNrQjVu?=
 =?utf-8?B?YUYwa21lRmw4RTVLTzdlMzA0R3VkbDlBeWx0cUF5bmhIRHZVck5kNkovVCtF?=
 =?utf-8?B?YTAyN0ZNOFVnaWNtMzhBOHRPbFk3VkJsNTFuU1Q0c29Jb2R3SHlZNGNRblNN?=
 =?utf-8?B?MFY3UjFleGNuNzlQWHZnZEQ3S2RTam8wRkRJckFrT1hTVDg3cStJbGZVUUNh?=
 =?utf-8?B?bEZrTEQwaENCMzZ3SFZ4MEVKUTRxUDY0L3ZlRk9TME5lOXI0aksyMHBjbEJP?=
 =?utf-8?B?dUZxWjd0SzJLMStmUWVUVzZzYzhZcGVXTjlhcm03Q1RlaWZXdnhQSVowcDMv?=
 =?utf-8?B?MDlJdmNqNTZPa1J1SCtpaFJJNUtZRCtraGszQzZydUNCS040WmhsWWxDeEZh?=
 =?utf-8?B?dXRtR3Q2M2FDb1poS3F6K2FORDJQRzdKUTRMNlpLbTM5WCttd0N5OGxhSFlP?=
 =?utf-8?B?SlZQaXk5L0syZ2pUL1dvRk1rU2VpRWZrVm1GWFdWdVlJT1gvYjQvV2NGdGo1?=
 =?utf-8?B?OXVSTEtKQkdaUHVIb0FyeFdyY3I4MTFPV0ZPWGwydGppVlJEQy9BS0RSZktr?=
 =?utf-8?B?TDB6NWlaZVJyOGcxQmtONWJpUkIrSHQwUUh2bzdCbHBmQ05HZHdsdlM2U1FK?=
 =?utf-8?B?ZTI1eGtmdU5TcCsvcStQSml3dXBZZEdlS0RPankybVB2dnlnRmlta01mZkNZ?=
 =?utf-8?B?dDZEOWp4U1lVVXMvSjI2ZktQekNCWUc2L2FhRnM2RmlMTWxvMHRiWlU3Y2li?=
 =?utf-8?B?Z0FMd1MyYzRMRi93U3hvbWdUd1Jua0hXdlFiSVg5NU8wS0ZwMVhRYVlRaVhI?=
 =?utf-8?B?WnhMRmFmYVc1WDZxaWF2Ty9mdC9DbVJDNWF3NDVLdGFKeW4zU1Zjd2Jsd25k?=
 =?utf-8?B?RzFYY2NIZFZzNnJiYkd6M1dnNU5FS2c3OCtTZ0w4Vmg5YUEycnZDUE5vU3h2?=
 =?utf-8?B?U1B6ZXcwRWpQaHZCeTJYTE42bGxYVzJaQ01lYXhTODR2YWFjNnBxVERVcWZR?=
 =?utf-8?B?L2x2V1B1T2FGVklTR1FsS1FwQngyMlZobTVudVFYeENQNGlRNHZCR2xrWG0z?=
 =?utf-8?B?NDUxVVQ4TTB1eFVEdUl5c0IyME53c0lpakFmWkZkZzRMRWxnbTJWZnJCM2t6?=
 =?utf-8?B?LzFsQktISHV3MEFxK1dScW51dmZ0ZU1BSGk4RlN0UlNTdE5CRWVmZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461b83f6-f9aa-479d-24fd-08de8c133ca7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 15:12:18.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyTxme+BlpfqTvH+3+Mdrij8R0G3cNEBPJbP78HB2BkV50qxV/Xh6c6hgWNkXrwiMo8K/lWP3YC2He4pfiLIzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9589
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Mar 2026 15:12:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22601

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.76-cip18.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.78-cip19.bb              | 1 +
 .../{linux-cip_6.12.76-cip18.bb => linux-cip_6.12.78-cip19.bb}  | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.76-cip18.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.78-cip19.bb
 rename recipes-kernel/linux/{linux-cip_6.12.76-cip18.bb => linux-cip_6.12.78-cip19.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.76-cip18.bb b/recipes-kernel/linux/linux-cip-rt_6.12.76-cip18.bb
deleted file mode 120000
index e4d559c8..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.76-cip18.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.76-cip18.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.78-cip19.bb b/recipes-kernel/linux/linux-cip-rt_6.12.78-cip19.bb
new file mode 120000
index 00000000..683ea576
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.78-cip19.bb
@@ -0,0 +1 @@
+linux-cip_6.12.78-cip19.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12.76-cip18.bb b/recipes-kernel/linux/linux-cip_6.12.78-cip19.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.76-cip18.bb
rename to recipes-kernel/linux/linux-cip_6.12.78-cip19.bb
index 9d602245..003487bb 100644
--- a/recipes-kernel/linux/linux-cip_6.12.76-cip18.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.78-cip19.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "c6287e9b9f77a2086f00a14613f8d3b613dba24ea75df71f60f9e82ff4de8152"
+SRC_URI[sha256sum] = "059a3370bde268861bf30b76bd5ac6fa4869ec7d623f97a5a3c955c6bcd73d72"
-- 
2.47.3

