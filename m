Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1429D5B854
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 16:35:06 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53309.1765816502560085274
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 08:35:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=liesUMqX;
 spf=pass (domain: siemens.com, ip: 40.107.159.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWJXB0IVTI4KqWvKVgZWpskfSu0Gc1gCDWnLEggAM/dlfV8KgpH8/HlNeeY3+8eehSMFuMOeR4ksXuRKSLxjFYvqwJEzSolL3BsVNnZ9dfoVJVzBU+40gNeVNROc7D9tulNmaFxlHTxPDnH+69aDQ7/6dQTa+9gzQlF7Yhwmb5hMJ+b4ggoY3Zx/IeKyodYgLpgHsimRrD7ZTAZZAa5kDy87WOBoPUNTaS441gWhDhpnkX9hw9E9p9l7vgeheuAYutDf3EDKgoYySOZbsyUNP9BGRIcFrAp5I/wsdmzRytHQWTO0xiPdYf60Tw8PoQ0pnPZn8QggBlLSC2wZkHZb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHsZJzFB/L/fj8PbTTU1PqwVMfLj7kcFWzzjhcuWcj0=;
 b=v6ELSmBZ+NsRmG/EgBG/qUGZMb8LAg+1H3+HF6vogXZmcIXg9LHkBqYtWnbCrGnI4nfUf3T8QllufqheujUFEXgwGeQLYWql+cffEPMUKk7nkit8mXLTXUfCE1vY/SEAmXzNjaA+wcGA1K30ncf+lLmwnMbJJCeVyxg6edsuQAe13OP169HJa47ZE9Q5/xf+vpw2Dvp6vqUWf4taRVoqZiVZvrvZIWJlUonK4pGDIWuIA/xfcnSx08a3bjPAHIaNnz+GDXzH6fCgdTfZWjAxNff1MHwqFkqolOHn5KHykRcHgNY7++n+L7XghZG8P2+aQr0NV3iJAuYTdufkfQoPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHsZJzFB/L/fj8PbTTU1PqwVMfLj7kcFWzzjhcuWcj0=;
 b=liesUMqXNR1QWkXXLeG6b2yo051jK3inr7wl2RmV9Ixx0PxX1VgVqRgBpUHZXQ8BW3QAe5Z9gHaCfltmadF2SqZ7bJaFbYt2rQX2UQWvSVpKNFF0eW5nqkbTwjymOUDD0fP27TseC8HkEbs4HX91PIEjPArcPELcJq3ALmzbdYv1BYba+4dt2vHaIaYcQSvP9Ypdrj9iYriPR9BGA4HWznunOGdYJUTg77M9BEEbIxgv6syyxd3t159aL2lQzu7+M5CdJlvXFY2sGQ4IHSuZbNUa0YeNjAeuuyDgX3MuE8KZkAg24rWC9mI9XKzNSW4BG2dMViKkEFLnpiLklq2exA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:34:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:34:56 +0000
Message-ID: <f686ec46-7f87-41a2-8472-e1e9706438fa@siemens.com>
Date: Mon, 15 Dec 2025 17:34:51 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Disable module signing when
 performing reproduciblity test
Content-Language: en-US
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3561:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c2b714-7d56-47ba-79fe-08de3bf7e1f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eFZEV2RzdTJ1MGVkb0hjZXBScGs1WUhLZXQ4TkFmWmg4Z1FnTy9sVHRpV0VL?=
 =?utf-8?B?VkltSGtYc2hiZlppVjBOdzJscHJ2a0cxVVRGMVJZc0NMZHYrZnZxMWg1RG9T?=
 =?utf-8?B?bGxrUDdwWWozZE5tVVlneDZSZGhNTGpDUXFHUHY0NE9YZDhYTGFxUWNXMFhq?=
 =?utf-8?B?TnV5T1pnN0ZGcERCeDd3akp6VXJrRmFDeUV5T0dyNDc2bFdCRzR3RXZJK0Fk?=
 =?utf-8?B?UGJmVzlabFlzL01aeXdMdDFNbXByVXZxTlRzb1JkWVJFTzArSE0yMmc5UGEz?=
 =?utf-8?B?dERBQys5cUF5VGs3dlpQS0VTMk9ZZHpuSFhIRU9YYTh3L1A4Z1JIdlJjRW9Z?=
 =?utf-8?B?UmpRd0FERFZlMDQybFNCcDJQWHJJSXEvYkMxbDlYZHIyRlFjUEUrZEpvelQ4?=
 =?utf-8?B?SnhDYnVySEp2eTluV3BtZWNuRDBpNFR3TUxwc2pVNXZ4aHdDMVdnTDE5U2JV?=
 =?utf-8?B?dk5tRVpoVmRKbERLQ3hMTENRTVVWQVFwNmdRRExMMVpCQkdNcmpOMWV0U1hN?=
 =?utf-8?B?M0swVktQMEhSdzNyanhXQ3dNaWxqZlBxck5yREVLbXBtOTdUYlIyYnlNY2FD?=
 =?utf-8?B?SjlBYzM0OVliVmNka3NGUzJMZVRVRkplYnc1aVkxTk96VlBOR0c0R0RBb0th?=
 =?utf-8?B?V0lOZnpkWUpkL3Rhc2pxM1k5RGVZRFB2MHhOU0RQUU4xMUtBcDhvenA1RHlO?=
 =?utf-8?B?aW0xdTBCbDhPWXpOSmZydHBCL3FtNy84R1hCcllsZjBsSFdtRkFVWVRRVGpq?=
 =?utf-8?B?NmQ4eU44K2Y0KzFCRktNUlJqWHdja2pocHlnYzlPQ0pRbXlUdWp3dytDVW5U?=
 =?utf-8?B?b3dTeStuZE1sY0c1dlpQOEpOck1jZ3RZWVEvNE5kTDBhd0dRVWI2MVFWQUNH?=
 =?utf-8?B?Z0Via0wwZ2dnUDBuQ3NGNlhVbm56WU51NkE3ellTNVhFNGJETlVDNjVhTUF5?=
 =?utf-8?B?Nmhhb3hKdWszaFhCZ1JVY1NaOFVVZG45YWVUQXQ4cnZycWhPMXdBTUtpdDNC?=
 =?utf-8?B?alJtcFNxNFltRlBnR0piSjRvNTBtUnNPUmNCL0ZZbFg2V291MnRuNGIwWENK?=
 =?utf-8?B?Y0l1NFVJdUUyaVpXYjFOTHh4NVQrUkFmcFhRSlE5aWg1YWdFeEFqRHZMT1dY?=
 =?utf-8?B?TzJYL3Raa3hhS2JyQUtCeGdXR1hVMXZMWDRWWGcra0xuclNWTDlXQ1M1cVIy?=
 =?utf-8?B?U0Y0MUxPamVTZDhXZ1J4RGhZc0x5T0t1TkVsK3hCRTYrVVBvS1YxZ0NlZGFY?=
 =?utf-8?B?V0hWM1Q3a0IrckJnaHJFWDJIOEVoNjRMeStsWU16OHlzWUVNMXlIN3ZyY2Ja?=
 =?utf-8?B?dnpURmV1Z1FPT0lJd1pic2ZTYTdja05paUE5OTkzNzdQOFJhbnArOW1pYnc2?=
 =?utf-8?B?N2s2OVFZVjcvRDJUNkFJUGJHaXhhTTB0djJuWXRaYW1ZUHZST3k1bXNzSUNZ?=
 =?utf-8?B?TlZHdFlRV1dxSVZDdStveE51L0JnQkRESEtmdmgzY1NqOVFqMm83YWtCRUdH?=
 =?utf-8?B?MWRJak5HRWVmR2FJYitqaFI4M3UzNUwyaEFuZElBbllmbHM0TjJ6K0tQbnJ5?=
 =?utf-8?B?cWFFU1FPc0lBQTBSNGpxaERxOVEwMUZROXVEOVpsN1QwdndrcHdUMFQxcHFI?=
 =?utf-8?B?S0QzY1EyOTNHMW8vVzlqY2xaVEhVcStrMTlKbEJMZmV2aEFmRWM2NmNRTVAz?=
 =?utf-8?B?RVJ0eWhIVnFQcUxwWkdwczQ0bzdkbHh6dEdtMHpmdU5xS08rckpUNmtLdFQv?=
 =?utf-8?B?WjdEeUZRWkpOSStJSXhHTW1MczNYaVpLWk1ENk10UmpkQVhoMGlzOUV5YUpm?=
 =?utf-8?B?MUdCM2hwUzQxbXZkRTcyT0pkck1nSGo1SVN6SVg2azVnVzFKV3BIRmdGQ2d1?=
 =?utf-8?B?c2x2eVJxZjBNL0wrWHEyZjVZSXZHekk2STlGSys1NSs4b2l3U1Vza0VMRzdz?=
 =?utf-8?Q?pwZch++UnMhQG1PkacNq8vZz9MmG2aWS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1VZalgvSVV2VFByK0dSc3RIOSsrMlpITkJOUnc1bTlHeVRUS2R3TytPZ0Zr?=
 =?utf-8?B?UGN6Z0Y2SEUxb3d5ZEFWbzlMM0JHbm1IYmdCK3lOK2Vlekd3cFBGcVkzN1Vj?=
 =?utf-8?B?ZGpsSXpkWDRDZVF5VS8vMS9UV3lTRlpTYTJDNUZkYU9yZUhXc0xpNTVOUncr?=
 =?utf-8?B?RG9wOXZtMlY3MWJmNnJFZUZVVjdrSVlvaVRSUHNnYUV6RnBzZUhhODNSUW5x?=
 =?utf-8?B?ZVNkMmhkQUhlM2pWbDYyWU5rTTRDeDNxNW9tSnRKQ1h1SjNhNXM5RkhrbDE0?=
 =?utf-8?B?VWlzclI2dThibWx6ZTRjNEtRSmE5UWx5YUNXTzZmdWo4NTA0akpBUXBiMmlQ?=
 =?utf-8?B?b3NBWmRmNFVUL0QzWVZ6MGJEQ1JuNDcyd29oSXl6VVhOVVREaEpVa1VDbVB5?=
 =?utf-8?B?MG00UWpmK3YvdndhVWJ4L3c3Y090UjFzbVN4emhaeUR0djhtUWM2bC9jV21j?=
 =?utf-8?B?U0lCWmFPU2tBeVk2MnN5b1BuSzhnUVNLTWNWZFhUUXh3cVAvbXNLcFJKNTZx?=
 =?utf-8?B?RDQ2dG5OMmVIaVd1cW1PaG1pV3VicWk0T2lFVmpVOGozR0FySE5PbER0bHZQ?=
 =?utf-8?B?dHhCbTJQOUZXeHVITTJDWFRvV1N6Vm44dUkrN0wwa1pNYkhjNFZSQWJFR21V?=
 =?utf-8?B?R2FmNjlQNzlSM2V5YmljSnA1VWtuN204Mm5xZjI0QUVyOUJnUWMrb29CNjZo?=
 =?utf-8?B?aitFOWZza3ByR0dFVGtpeWs0T1hrcUxYdUt5NlQyY3FwMWNoc2w3Zzhxd2Rk?=
 =?utf-8?B?ZGQxWWh5aUsrUVVLOVpGVWhWeFR4TGRLbmRYUTlMeFdpNjloYjJCbXRsT3hC?=
 =?utf-8?B?L0VZNjJ4TFhUSDNoM0tVcnYvdzlpcGQxSDlyNmpwNkpVQ0o5dHB6UWFyNmJR?=
 =?utf-8?B?c3ovOEZobjlST2hZZ0d6SDRiV2dxWjByUDlIRDNoOFdGSlFTYVR6bzhMdHU3?=
 =?utf-8?B?QXMydE82VGVYY0Z6YnpuclkyWjFpQlRXdlBGelNWWHBpNFNJcis0M1d2dzF3?=
 =?utf-8?B?ODNJK21kTDY0cFVLNjMxbDVUYWx6eDl1ZjR6MHozMUpTTzg0WTl0T0hHQ3p3?=
 =?utf-8?B?d1haMmVnY2l1S3RPM1dpbFRhZDVzOG8vaHd1YjFKbC9ISXJ1bDB3dHZSR2tH?=
 =?utf-8?B?cEp1dHJHQmMwY0RsbjNvU3BBYmRmNW1mRE5sNGg3U0w5UUhYV3MxZTlwdDFE?=
 =?utf-8?B?cXNJU0J6NktuQlFqdkRqYUQrQ3djNnVaMGZaRXl4NGNUSWxsbFFwdlY2dUQ1?=
 =?utf-8?B?UCtBcUQ4d0hBR2dzVmk1c3dQMHZ2Y0xhWkljTkp6eERxQ0tsTWFubmRDdnZr?=
 =?utf-8?B?dVY4aHFmQkxTcDVzWDYvQk1jb0lRbWg1REV2KzNmbFVZVzFIaEpkMDZKWGtu?=
 =?utf-8?B?N0ZmYU9ialFKTnNnaWJ4eWl3dysrTHBWNklqam9KUERNWW9vWE1KazdHei9y?=
 =?utf-8?B?VVZBMnEvSHhKLzlrSnBwdnhoVjdxMVRSV01vaVN6VG4zdzhEaTd2WWNxNDBu?=
 =?utf-8?B?QVNkaldFcXBKRWdJZEhlenZUK1gzUlBlbC9uUlpxSUZ3Sk9PNFpWMHZXamgx?=
 =?utf-8?B?ZnVIYmFxZXpoTWtOMWlSN0JQYzVveFZFL0NBbVNtT05aUHhOMjVWd2UwQnVD?=
 =?utf-8?B?Yis1OHcyb0NVRXlSZXFsaCtjOE9ST25zVzRMNlJMbXRlYVIwRXVhdjl1emxk?=
 =?utf-8?B?Z1RJZWhBRWZnRDZBYWQ4UTVZQjRGR2tFVnQ0SnNNVmVlNEVZc2tXTDFmSkZ5?=
 =?utf-8?B?aXZKNm9BTWsxc1htTmtJNDJxMmxYbHFLMEtZaDNncHNvbjhUWEtMaXlHUEZi?=
 =?utf-8?B?RkNYWnZ6Z2UwdVpKZlhUZWxkR0hPcWhyS096dk5zbWlyTStzcUVWbjdUT2wv?=
 =?utf-8?B?Uk92SGtINE00WGdleTRiQzlPUng0U0NET1F5c1lvZmNXT0Y0YXBscVNRd2Qx?=
 =?utf-8?B?M21kYmcxbVdSRUFlZ3BOejR4eElHQkZlU1hZS21uNU1NZUJLRU4wMlk2ZCtK?=
 =?utf-8?B?ZktXM2xlclN6My8rbmU0S2pKOXZsOVRBcDBPVmpXZzkwVWN5aUVraXc1bWZV?=
 =?utf-8?B?NEVDWlFzenZMUWFkM09TdllSZW13QzVoanp6NWVGaG5XVVRkcExQdGVLWXEz?=
 =?utf-8?B?d25scnl1SU03dWFRcFN6WkdRMlhYam11cUxTVXVLankvbGZYK3IxL3dZWjRE?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c2b714-7d56-47ba-79fe-08de3bf7e1f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:34:56.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //kLTwu6wh/f9KviPgnHrrGkoE35qmXWoqZ4QYNU4xGoBdHjP1UoGXy8yLMUx1IRcI1TH0nNSr9uxW2TqSUY8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3561
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 16:35:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21070

From: Jan Kiszka <jan.kiszka@siemens.com>

With the current cip config for x86 and 6.12, the kernel will generate
a key pair for signing modules on the fly. This is inherently
non-reproducible. Disable kernel module signing for now. It can
re-enabled later on when Isar gained support for in-tree module signing
with custom keys.

Closes: #144
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/reproducible.yml                         | 1 +
 recipes-kernel/linux/cip-kernel-config.inc       | 4 ++++
 recipes-kernel/linux/files/no-module-signing.cfg | 2 ++
 3 files changed, 7 insertions(+)
 create mode 100644 recipes-kernel/linux/files/no-module-signing.cfg

diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
index a14d59c2..ae611ebd 100644
--- a/kas/opt/reproducible.yml
+++ b/kas/opt/reproducible.yml
@@ -15,3 +15,4 @@ local_conf_header:
   reproducible-builds: |
     WIC_DEPLOY_PARTITIONS = "1"
     ISAR_USE_APT_SNAPSHOT = "1"
+    NO_MODULE_SIGNING = "1"
diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index c4932d28..c69c0549 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -28,3 +28,7 @@ KERNEL_DEFCONFIG ?= "${@ \
 KBUILD_DEPENDS:append = "${@ \
     ', lzop, lz4' \
     if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else ''}"
+
+SRC_URI:append = " ${@ \
+    'file://no-module-signing.cfg' if bb.utils.to_boolean(d.getVar('NO_MODULE_SIGNING')) else '' \
+    }"
diff --git a/recipes-kernel/linux/files/no-module-signing.cfg b/recipes-kernel/linux/files/no-module-signing.cfg
new file mode 100644
index 00000000..ab54f685
--- /dev/null
+++ b/recipes-kernel/linux/files/no-module-signing.cfg
@@ -0,0 +1,2 @@
+# CONFIG_SECURITY_LOCKDOWN_LSM is not set
+# CONFIG_MODULE_SIG is not set
-- 
2.51.0

