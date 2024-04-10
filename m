Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B69CD11C2
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 20:39:42 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.103])
 by mx.groups.io with SMTP id smtpd.web11.1167.1712781580602560741
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 13:39:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=W5HD3mvo;
 spf=pass (domain: siemens.com, ip: 40.107.105.103, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zsi1c2CDrQrFabJLnrPcjzOj4ICGpZV3F2RfjGslYLGDCKYby9rxc0vgDzczEZc8J4Tl/6Ul1bJHEHHN1QMrVTa0oKoLDrqe0LmNt8u3NLgoI3PRUVkTlevMAANsIv7lgpT4k6T7dF3rmsO0J9QVcINOD5a60hBNf23SSIKIFBCk+bb/td8/6qeeGvX+8X3T3QUjDLtq2bgzq/or8zqv6rV//m/qHuVj50Krfv+L21fzQqb1K/x9jnNQKZmApOG5UGFxV+SpZnp8xYdgkxVbHZTutRAJKlEtynYcTVcUid3txOvjCVg5zJxYp3AgGuYP306Q/Dg0YIMgmE/MCbsT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayWKwvKWqlkZugNdROPdyelcU47o2WeKcaRuV8TnqQc=;
 b=C+tpua2FEti5RU7a8zlQLilGYfE1YEszW7x6lRJGzyQljOhSt7k5JpD9k4oU5sohXlKP4XrmV7mH0q78qupnKcr9Qk36mYRORV8F49f4JwJyipAvVBd40WXXemo45NhRPWuELhVfKvFlZ19i516qURE/DTUlvVLYzDjps92sPeDOm2Jo/u3z1wbu1HxmgciMwBS+Skgnt/AxLXmmIj5EPXw+2MSwkOBqydP7gyQGCnLsSgw1xsm0vM7UpJucMZW/I2ROPQwOT39uhxxoZfQ+ifIOXANq3eGqjoo08stHlBntKI24TAcFt5ZMjT2CHN3YFaANefEVQS73NGTeknM4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayWKwvKWqlkZugNdROPdyelcU47o2WeKcaRuV8TnqQc=;
 b=W5HD3mvoGnSPrYKKXi0A8ht8gZuIAARQZYGvNxMIwcjXdVGo75lmXl+GUhyyZZdV01uOgd0KareStW8ioMiSkDsHVh3+UhOh8El3jZIUe3M7n9ubbELVoKJJ1eUJIOTuANQZamHaoX9PE9IgJop7WphMXuzF1XjkbdI1BbdXtMB3wiUDJmjbGcLtA3bAQwqYJf4utxvNmAJOTLibwYjOOFVVWaJgYoytFvuutE2gR+0eCHJAKRhzvGA0+mD9SiGiQ3D8MTvyhbxQ+IvtoSNND82fxoywYYMMAcw1M1SKcqAppB2L26dnU86JNLEb/NTf66zXK7GFxHU+Z/nfv+ZVNg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 20:39:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 20:39:37 +0000
Message-ID: <8f4f6c67-2166-40e7-99e0-bad7cefff8c8@siemens.com>
Date: Wed, 10 Apr 2024 22:39:34 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.310-cip108,
 5.10.214-cip46
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8615:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6l8aX44BfFXxaeTgBe7/clhazZmWEviWrM2AGn5fhWkjbeTkKF7w6PuUU/KEtg/4slqF1T1ulFl/k2evxXBLBCEGJt5BrL1EgvKfRvhoUoTEgykOM1M8wlAMsFiu9lcIGLhMvUzNEv90Su5g199Z3/KkLkwfVxMqmX25P456GdXU7m0NE6cayoJAFmtxD8VY+hrxttPkDESMF+XdK6gFqfxQk4M+i+HNwQhxrP8SKas8ofBY4qjjGWPZNOQb4hVKjGEdltbzRYx0yDponPJIusgwLyEeZqNIaymOBpvjFBwgL+9gxwNcYVJuu5DZqWLrYjZIvg74WzMruyiUeS1U+SxrzHTJ/cYy6qJWqvvieLTXGLAlWAzL0yfNF9kozMHBIz8ZnImZ7p9x+motnn6mNG0OON3xSut/KUzuESxNmYd47chrEEBgzmqnB3Jl1cKgk7kI8lzOfEqbYPBeUU6dyGFUMhtxwl7FucniWe/s6pjeXj620Uqr8/Dm5V+TqzTHDe5a4L91zkNhRjZl8YLRdM8c7wCQloKOYFK2UeM9pr/t2Z1xaLQnj0ThNHwGUC8DZq8WKlqX7a3uPrxstleBiZ9QexSC1g1CGwSukFnpC/etGiW/ouIbAgtTk4oFx8kquZJDPCisv/L4re32ls6ERlFtXD2HGvJ1dSQGZTVF6Xg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?anBYWWJMc1VIclVmc05QK2VLL2JKK0ZvWkRobWN2d0N4aUd3TTFBT1UrZU5a?=
 =?utf-8?B?amw4ek51Y2o2VWdZV2FNbi9UYzdySXdsd3hJWU53R2p3aTlHT3Jjdzd2RDZT?=
 =?utf-8?B?ZkN6MEwrVGJvZ29iQ1pNTDhyVmlzVExwVlh1VSswZzF2c1FhMVpmeEQ5ZS9Q?=
 =?utf-8?B?TGgwNmxiOHBPQVN4RnRVK2poQnh4eFZ5QzJBeU1IUzJ4RDlPbXg3QWQ3NWxY?=
 =?utf-8?B?SG1lR0N3azNkTHZPajQ4dGRPc250Nk56OTJTM3FkUlJkMENaWlo5UzRzZzRN?=
 =?utf-8?B?L003Q2xZSFcxWDVVb3lDVmlSMHVsblJKWCtHVlpQeEJrWWdGbFVpd25Mdk4x?=
 =?utf-8?B?cklSbmdTZ1FwblgvRHU1MExFT0p0VVpUUWlOd3BNazAvVVdlQjFFUWkyUGkx?=
 =?utf-8?B?NmxMU205T2RNaFhzaGM3NmZzUE54RDRDSXJpcjNRMFQxemxTZGtUaUo4cDVX?=
 =?utf-8?B?THRKSmdLQXI1c0RLS0V2WjdLTklKZnJmMlpHK2RZUm9uTXRBYjlkUENjQ0tJ?=
 =?utf-8?B?T09mNElnV0hIR3dqbDViOHF0d1pGRExqU3RFcjVWSEw2dHFJMXV3cmRrblk5?=
 =?utf-8?B?YWZXRzk5MU40Z09KclRvK1RrdlZKeThvbUl1SGY0Nkl4dlp1T21jYlVka251?=
 =?utf-8?B?eUtrOWkvbDNSRnRocGFjZU44eG9Zc0FVemhuSnZsODMzclNTZHFJeDhTVXpI?=
 =?utf-8?B?L2FRWXhuRXBPMUZ3Q29OSm1FOHQ5d2l2UThINnc5TGQ2VVY3aVdhOC9Cbjhp?=
 =?utf-8?B?NDJCWGxmckFwdkh4T2gwcTdZTDQyUndkK2pWaDNRNVNhNGZ4OVBmZjV5SjU4?=
 =?utf-8?B?UDlSR0JMTUhtdmJNOEhIR1V3L0JrZTNmamFTUnZDdnBwZCtGYkczTFFrbWhw?=
 =?utf-8?B?RmZpRmdJeVY3OFAyeXlaaFgydGQwc1hyeUltZFpMdkppNXdyK3NLNFRHVmFr?=
 =?utf-8?B?c3BnTDRESUVYS090bEY2dUtYUHNXWHRnb1dDQjZvMEswUWFyemZSd0taU0hQ?=
 =?utf-8?B?M2JZeE5pNVFTM3lOSFpLdFcxVUdaci9YNkswZHpwNzJwSWVlbjF0S0RXS1pI?=
 =?utf-8?B?cDlHb3dOKzFTVUpXdFdaOTUrLzFFTmtXZldJdUdFYU5CSTVidjJLZFZtRXV5?=
 =?utf-8?B?akg1TmlRVjJpNEZ0aVp0VTMzRDA4MitWcW9xMEdiWURFbmV5cTl6QUdQSVd0?=
 =?utf-8?B?Q1Y3aWVzYTgwSE9kTTVLWm16bmlsNWRlVG5ZV2l6RStqSXlMVmlBUHlkMGZ0?=
 =?utf-8?B?dUxhMWdLWGRHNWxSVXdhVk5kNmlQbFd3SjA5ZnpZVjdnVjBOZ3VNN3ZublMz?=
 =?utf-8?B?TEdlV21WQ1RyMnRuK2lITWEwNFpOd21Wcm56Tnd3QndlUEZDOGdKR2hlQjc5?=
 =?utf-8?B?V05MVnk1cnhFT0JsNzkwUG5qb2R2d2F4ekRIdkhWcHNFaGhzYTg1RjhzZERH?=
 =?utf-8?B?bHFrUm5hVUMrT3M2N2RGYWJzTTJ6L3JFOUlLaUNjYzRiMUFzQnZJQWU4amFu?=
 =?utf-8?B?U1dBNG54K0NuaExPZjBlN0JFU0Y5dVZPMUVvZFArVVY4OWlMeUhxeE5QNmdi?=
 =?utf-8?B?U2lURjBrNFFOaVRkQStuTW1UOW4vM0hzaVp1RHpyQUhTNnk0cjBYNWF3cUdF?=
 =?utf-8?B?VHdoRGc0Mi9ON0ZVV3h5a0h1dmo5OUFsNEQwblpwcjA1U0ZQYVpZZ1duVlF1?=
 =?utf-8?B?NlFtSmNwSG5xcDNjQzdiNXliejNlL1kvdUp3enMzQmNBZDI5QjA2VFN6Q2Vv?=
 =?utf-8?B?RHpweFRNalREeVB4cGVVSm02OERadm9UZ3dObkdOU1NXS1ZYV3V0M3gvcG1t?=
 =?utf-8?B?NWxXa1VXY3RJa1dOenI1SHEwZU5ybkF1U0wzYkp4bTdMQVkxR1d3VkJ5YWwv?=
 =?utf-8?B?djlRZGwzWG03RVZ6a0N0OXFBZVMwVHpzd2Raakxkd3U0TDJKdWx5YXErTkZ2?=
 =?utf-8?B?WWpZZE05OHdib2VjZ0NBWEtaSk5vMm5SU1QybGllNnloOWlsNngwUHFCQXpo?=
 =?utf-8?B?SFBTdzJOVER1NE9DaEdyckNzZWprQno3N2NrTnZucnZ6di9rS0M1KzVjcUpG?=
 =?utf-8?B?Z1pyTlZobURkaFk2SDgzbFVCbTNtY3hNQWFEYnh6cW9oREtyMnZTWi9SUmh4?=
 =?utf-8?Q?DqpiqzrU70W0gF5IxPysvByKH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d375a9-b1c8-41ad-09d3-08dc599e5664
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 20:39:36.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM8TyvjBR/rgNCBHPnZnRYqebeUGKy/oAjsrJgTiJ9mJ155RapL7N9GDevS3sT98pHxA+CSIfqv2Pd8n0ryKnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 20:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15537

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...rt_6.1.80-cip16-rt9.bb => linux-cip-rt_6.1.83-cip18-rt10.bb} | 2 +-
 ...inux-cip_4.19.306-cip107.bb => linux-cip_4.19.310-cip108.bb} | 2 +-
 ...{linux-cip_5.10.212-cip45.bb => linux-cip_5.10.214-cip46.bb} | 2 +-
 .../{linux-cip_6.1.80-cip16.bb => linux-cip_6.1.83-cip18.bb}    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.80-cip16-rt9.bb => linux-cip-rt_6.1.83-cip18-rt10.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.306-cip107.bb => linux-cip_4.19.310-cip108.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.212-cip45.bb => linux-cip_5.10.214-cip46.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.80-cip16.bb => linux-cip_6.1.83-cip18.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.80-cip16-rt9.bb b/recipes-kernel/linux/linux-cip-rt_6.1.83-cip18-rt10.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.80-cip16-rt9.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.83-cip18-rt10.bb
index 3b690741..a2c23690 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.80-cip16-rt9.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.83-cip18-rt10.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "384369dbdd689831e69899c8c584feef6677382c1448a2e9195523c0594ba761"
+SRC_URI[sha256sum] = "d0b66c7084dc64df2c7d0fce591467dae34a1dc5e8dad8d88b521a2f8c4b1cf2"
diff --git a/recipes-kernel/linux/linux-cip_4.19.306-cip107.bb b/recipes-kernel/linux/linux-cip_4.19.310-cip108.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.306-cip107.bb
rename to recipes-kernel/linux/linux-cip_4.19.310-cip108.bb
index 57dd2502..caf2064b 100644
--- a/recipes-kernel/linux/linux-cip_4.19.306-cip107.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.310-cip108.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "ed0dc5037bcf213bd4852710f65f99e87272f6b295d2214ef270d1651c5c4896"
+SRC_URI[sha256sum] = "a4a9802aa6eb03ab0d36e4d7552dee14619f233608363605f334ee9629812625"
diff --git a/recipes-kernel/linux/linux-cip_5.10.212-cip45.bb b/recipes-kernel/linux/linux-cip_5.10.214-cip46.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.212-cip45.bb
rename to recipes-kernel/linux/linux-cip_5.10.214-cip46.bb
index 111866a2..1ad22ede 100644
--- a/recipes-kernel/linux/linux-cip_5.10.212-cip45.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.214-cip46.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "904e4b2547eed965998236bebbfbbd60ae8bd800d11ad46fbeeeb0d67a4fcae1"
+SRC_URI[sha256sum] = "66de32f23d3d69b0da06c4c3018cc9aa661aa8aacefbcbdb6bccb583e4ea2f2c"
diff --git a/recipes-kernel/linux/linux-cip_6.1.80-cip16.bb b/recipes-kernel/linux/linux-cip_6.1.83-cip18.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.80-cip16.bb
rename to recipes-kernel/linux/linux-cip_6.1.83-cip18.bb
index 10058ac2..24533f35 100644
--- a/recipes-kernel/linux/linux-cip_6.1.80-cip16.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.83-cip18.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "70c9e7ea89951450885f33f8056f484e1197ec39ebe2b6d49fb9357bec4247a8"
+SRC_URI[sha256sum] = "10473fafb808267cf37830054ed3593060696b7007bb78811b5c7a7a2fbdde56"
-- 
2.35.3

