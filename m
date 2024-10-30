Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB5ED5CCA0
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 11:52:42 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.63])
 by mx.groups.io with SMTP id smtpd.web10.13039.1730289136689243128
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 04:52:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DgrbOqBF;
 spf=pass (domain: siemens.com, ip: 40.107.104.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMA8GhD1ti7vBuL6yiuy0iQYX6hPXyk8zOm9dLUZgd7qSkVmu/psnJ7jIufb72ft1qrEmaZbuC2h2g4Z0yqciccb2bbnwYR3cO2RxSgIYR6bhwJ2ppd/3vGJ3mUCSWkabrrP2r2oilloSGocCbxzjfqRWXgNvw02qFqGk4Fow/Zjhx1kU0L7uH/mB8HOWwUvUrO2jSSAVilry/pGfsFIcOq+txBcIQ0mtkXzxPJYk+ih9c5xbnVi79bMW7vanFs7NcyGCF+RJq4XakBfKgDGKhYOco5L4ifsRRJlrZ/jJ/D4fSpMFtyn3s8HGIy2WbuGZLo57MrXFNLwHA+Eg+tM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7+tvCDqXU5e9iZvNGBIuwMT2QnKKIyNH6hedRAoMAI=;
 b=HXmAJMfahspz7mWlWe7K/hXFtu48rjclo95fs2R5DuZTrlpDVgi8lk9LrKxXlHUV9pDuYTO1WvNULnyBk04NW3PMfroaAgol36Nq0pVqKYJbKeQTj+UY1sPrSdfk/bEDWFx0CYUzCKND8SpNxdxO3DgfAY3a75cNqsN1579gLg6GG6BqSBs/TO1kicz5pCtjaPBvLS2Eu7sj0V36uiOFV5FCNgghiIZCteOq87u2RLR2GDZ8EQs8SYSvxZgJzRSBIOqkqIa3cuD3/jgCAONboFwiuLqjReFKJ15Z2A9Hqe1JESogJ5KXQZRmAM84HeUxTRgnXjLY3hXbqgwmuJAVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7+tvCDqXU5e9iZvNGBIuwMT2QnKKIyNH6hedRAoMAI=;
 b=DgrbOqBFGXNKxJptmwzlld36BjS+x/5ueZMnTfU/eZUZcehfMx5HJPq6kEvtgHKJaMhsT4Umo4opZsW/IMo4QkQ2L11vo+Ltd7TxCTATUunbPCu6/1/WlaaWKs/0u2q8JAMuLLs4vi7C0sS256uZ8bZGd7xWW+0DxAymh89b1sAczuiXOWMGzK41vyXsNpZpF9Fizkjq9Wg5Qcz2HhzEtlee0GCUvGveyt0Lv31a4chcWP2oGzUsCtFfe78CAKC62hqs/6A8tx1O2PhsiP+qEHccab/VRuGDtEKRV9Fy7DEIoerotCsKXVTRnZOIqXjf6x53vL/4ZVWrJoxUAC5cWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8541.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 11:52:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 11:52:13 +0000
Message-ID: <88cc6520-d4ad-4d66-9b83-4d1410ff3eab@siemens.com>
Date: Wed, 30 Oct 2024 12:52:12 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] efibootguard: Update to 0.18
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f31d48-80d6-4eb6-a116-08dcf8d94b7d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Ny9FaE1XMVczVUpHQ3VaRmNwR0JQZXhwRk1tSkdWSzdyK2x2T2FqdTFDRFNT?=
 =?utf-8?B?dnA2bWR4T2MvNzRVMGY4ck1QenFnV2lWOFFkZnVkdXc1b3psOUxueDJrWUlK?=
 =?utf-8?B?a016RlRmbzBhenNRRllNaHJsVmdwaVptdWNQTTlGd1JabU90WkwveVdxeFN1?=
 =?utf-8?B?UlRrVjhQOXlLd21sTXZPL1B5TE9KdHNRUGVYYmFpZk5EUkoxUkhzTnZ2bVdY?=
 =?utf-8?B?QUNwZzlSb0RXMEE0L1RGU1FJWHlUSE5meE9lMm1oc29RM1lxK0JmYWs0SDdk?=
 =?utf-8?B?c3B1Q0NidVdhVk16WGF4ck8rcHovdVZEY3Joa1dGUUFTTlVDYWhpM05sbzBT?=
 =?utf-8?B?MEhKOWRxY0RjcHNEMWxML0lHdU5LeXJOWlFOdUpnR0lhMFBGRm5xTWMwS0ZD?=
 =?utf-8?B?Zk5qTDVGQ0NJd2hrSHAxZzFaN0FLVjVGYW9Rcy9JUEJCMDNidTk2WlFNZHpL?=
 =?utf-8?B?U2hQczVmVCtNVEllWHp4bnArbmdjaHo1NW1JL0tEU09QL3p3Q1p0cHFJeHAr?=
 =?utf-8?B?TE05UWhoUGNaRE84MVk2UzJwS0pVRklucWJudytiVDlKUVcydm9aOVdka1Aw?=
 =?utf-8?B?VFJhZFdFL1hmc1NHTXRFVVNCbVQ4TDYrYWdzam84QXIrMkNpeXp6NjdjdFp3?=
 =?utf-8?B?bXhPTmxZaE1nKy9IcFNlQW9JVGhqWXJsdWs5ejlibGdjZXRsREU3NGRib0hP?=
 =?utf-8?B?eWVNdHFIWDYvNmVEWnpoTWYzYVFoSUlhYnZEOVVEWFFSNUV5dXMvTmhJaXg0?=
 =?utf-8?B?THc5V2VWcStka0JkY2VtSHVIa2FISVBjYVE0NENvMngxaWNFTEw2ZHZ6Y3FP?=
 =?utf-8?B?ZzFET3Q3R2ttUmNCUnBCRXAxSDFMcWJBVEhULzYvQTN1YktUVGxyOElVOVBQ?=
 =?utf-8?B?dlA3NFJzMVZ0eFBlN1R3MGR5QTlJQWIxSFVjSWVBK0RLanJVT0pSUmRnaW5s?=
 =?utf-8?B?cXEwTjlWSVF3WUVKVHFqVW5lRDRqa3hQdXVndDNLQXFPUmJIUnZKRlhUV3dj?=
 =?utf-8?B?cFk1M2x4Z0xFRkVOVDAyTFZNOU5ZTTlEZVhzcStlbXpOMjNOZHFmNTR0K1lm?=
 =?utf-8?B?cy9TNXRFU2Y3QlZyMmNYUm1wOEd0dnMwYXdROXNHcS9UMGdtd1dNWlE3ZmpC?=
 =?utf-8?B?b1ZiN0txY21oR1lEcEtXYXhvd0hOYnROblRnRXJ2TXAydXRSbWRoZGRaTFBJ?=
 =?utf-8?B?Umw0RVlQODc5WFBpOXRYZkc0b1hFUGtnbXc2eHcwL2VVZDVla01uK0tzbm5R?=
 =?utf-8?B?ZnArV1d0eGxTWTE3ZllqaTg5a3pMSDJIY3YvVmJzd3cwRFprR0pWWTRLTmFR?=
 =?utf-8?B?SGNlL3NRdTZjUjMyVW1Na1pieEZ2bCs1bitneVZkMlc5THJUL21XZittZEtT?=
 =?utf-8?B?K1RvVkw3NUMyM3VrWERBQlc0Y2dGY0paNERoTDVob0NWRFA3VzFEeFlqY1RX?=
 =?utf-8?B?NEU3SzlhckhQclRyaEhrREJYb3drRHlyQXd6YzNUaHFCdWd5T2RXbW1Yb2h0?=
 =?utf-8?B?eUpqVUF0ZGxYSGYySzk1ZUNEQ2kyME9BQll5K2w5RXBrS3JSYmFXc2N6bENo?=
 =?utf-8?B?Y3pDMlRacUpQYlRqS2NjWFBHUnNUa1BrZkRDdmk4TUo2TmNpa21qa2pkT0I0?=
 =?utf-8?B?cUU4QmJkelhuUHNlalJlRnRqMzBQa1FSa0lWRVhpaGdMN1FWbkpyNlQ0ZlAv?=
 =?utf-8?B?QjI2NzUwekJVZVBHeUVGbmplSStoTStiZEtONkRNSEU0N1dzM1pCRFFJQnhH?=
 =?utf-8?Q?NIc0V6gjMAgbmzWFhO3EF52OHMcJN5S52oHStd3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1lMRTZwL0t2c1d3TWZRb0FPazVsOGU2cmw5RDdZSjJqeW1FYzdFamdMenla?=
 =?utf-8?B?bThvM29oemN0QUZFYzR3d3I2UFRXQ093RFpGTmhZOSsrY3p3cjhIeEZmZ3NO?=
 =?utf-8?B?OEZYOEUxRVgvUjZGNVdJVFhwOEVteGkxcy9RT2ZXbytkQ1g5UTFSTlo2NTM2?=
 =?utf-8?B?b29ERCsxb2xJTUtwMjcyR005clNlUkNaMmxIbjJJdUcxWExVaUlaQUxaZith?=
 =?utf-8?B?WFIwSEhvNXowb3AwK1dBb2luNVlqMFVRNTdlMyt6dHRTZXVoK2NnU3dJeUFX?=
 =?utf-8?B?eSs1bzRub3FWeU9xRjF2dEU5QnlZaDRiMTl4cmgybmFqcHcxWEpFeFFkU0pa?=
 =?utf-8?B?RFRwVnlMa1RuR1JzZlR0N01PYjZLeW51c2k3Ujd4WWFhL2g0dElNSU51NjB2?=
 =?utf-8?B?YnlwL3g0RCtReGlFZWV6a0pXdzBFYTFMa010Tmt1eWpNQWprUWh4RW1TYlYy?=
 =?utf-8?B?S3hrV2VsbjNVRjQraUhqRW1FTW0vYkw3UUFnaGo0ZlZtNm9LMU5kQUJHY1NU?=
 =?utf-8?B?N2UwUFFFRnIwSGROVkNqWjQ1eGc5d0ZUdlRZVldWMXhZaml1ZXhOVkNQQUJI?=
 =?utf-8?B?R2d1SGhUNlVjZEVIdTBMeDRza3I1UlBZU2tjc2pDeVV0NEN6RFBpUkVyTExi?=
 =?utf-8?B?bkpOMExENTUzSi9lNVhzYytkQzBLLzZKRVpaV0g4aFdTTnFBUTVJZ2tQKzNG?=
 =?utf-8?B?YlJRZDlQdW80b2FhSnV4a0FWazhuRlNIVnM2ajVSZEhUZGkxaEp1eThJbkpn?=
 =?utf-8?B?VmNKQnRabTJLeUk2OVBlWGxGNXljMFN0dnB0dDBCcGpxNGhJTWJpRG10a081?=
 =?utf-8?B?VDQzdy9mUmIxS3MrYS9RYXVTRWVsUmduWVhySyt4TWVQMktRZFhJTno2UW40?=
 =?utf-8?B?UWdaNmZ2a0NORVFDL1Nzbkg2L1pCcTlvUk8zdjI4bUZLZXgrUUlJZ0dQVmhR?=
 =?utf-8?B?cEJQSHZWcjFUMFpLZGxMdExQcUVCY0NpdlR6ZUkwaTk0eWo1QlFoeDlIV3E3?=
 =?utf-8?B?M21OaWJzeGVsaHJJWWdvaWp2SnQ5MUlWaVF0cVdORVkzMDZMM1o5QURMOVY2?=
 =?utf-8?B?R3ZmZlpNZllqeUpZUkVlNUtWVERvbW5mVlRlZkQ2MlJWQU1nZDVJUkw2NXk0?=
 =?utf-8?B?MU9paTRuS0wyZjJRdkNsbGg2NEovb0VhL2tkTm9xaU9HcisrUWJkS1dlNmo0?=
 =?utf-8?B?Rm1yS1VValdxNWNEWXozRGZ5cG1ZUUtzRGppQ2JDN2hIMnNCYVlERDRGSkZT?=
 =?utf-8?B?aEtUWHVXRVVYTm5MY0RNeXRoSW1BNjlqWjk2SVJCblAxV3FRYmFtRlI4SUtm?=
 =?utf-8?B?VmpIOWRsdTN2VkR2Mk9VWnkzMzJmMGl6Yjh3YkxUUjdCclp0bUNQUi9pUEZB?=
 =?utf-8?B?ZFpvVVh0UnRpNFk5Z2g4OStINVdHOHFxZkR3cGpHTzV3aGZXTXZiNzFlOGNp?=
 =?utf-8?B?WDNJZ3ZVOEFpZDg0Tkd4dHNvVHhPSERtVDVHZWcrS1h6bURaKzRkaUY5VzFh?=
 =?utf-8?B?SmpkNkt5d3YxN0pIZ2dvQXF6WmJsaW9YTFBoK3JST3JsWUtud2pocTA4V0Uv?=
 =?utf-8?B?bW9GOEFuTGtZU2ptK2g1UzBtYkZyYjVGSFh3eUg4WHo3OEtUc01Yay9IckNQ?=
 =?utf-8?B?Mk9takYxVUk3dDZtMjZTcTF5ZWt3VXFBSWJhN0JvMWkzVUpHUVhXai9zTzVL?=
 =?utf-8?B?U2hDQUlKTGlHaUhUdkYySDhOV1l5VUtLZWRseHEvcU1HYnJDS3pLUWpmYXFq?=
 =?utf-8?B?UVkraEQrWWMzQWxpTDVPT0crQUI5ekxCMGZ5ZDF4Q2pEQUNJSUV6YlU5Tjl6?=
 =?utf-8?B?SlZ1aUJWeVJQbUlOclRJcUh2OWxrQnZrWWx6U1ljMjRNakt4RTBsOU9zY1Vu?=
 =?utf-8?B?S1VXMFA4WE9XSkJmaWVzT1RzMWY1eGZKdHcvOTVhRk8xN3lnU3U0aExCek9J?=
 =?utf-8?B?SU10TTlSS25BWVFGVGMvdlYyS2E2bUxBUGY3akN3Nk5WdDRHeXVIUDlpU1FH?=
 =?utf-8?B?M3MxZlFVQkU5Qk5obzFQdXNzRnZoTy9sTFhCbUlWa0U4ejcvTjc2OG4yUERJ?=
 =?utf-8?B?S0ZUbWIvcmhPaUZzQzBZaExMR1lFczhBblhOYlZ1UDBMMUgxQ3krOFJld09n?=
 =?utf-8?Q?RWJsCvFFNqgYJ2+dtlAwHhhSA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f31d48-80d6-4eb6-a116-08dcf8d94b7d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 11:52:13.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2l9InhSEKScYMMoYxogf1jHiRZ51GHR9xjxASBKQMKu3+Rokjr+G2bHLdeIAWSo5rYQJ60HtUKza9R3IFyctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8541
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 11:52:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17120

From: Jan Kiszka <jan.kiszka@siemens.com>

Extends the watchdog hardware support a bit and enables compilation
against newer toolchains.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...fibootguard_0.16-2+cip.bb => efibootguard_0.18-1+cip.bb} | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.16-2+cip.bb => efibootguard_0.18-1+cip.bb} (87%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
similarity index 87%
rename from recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
index 20cc907b..931bc8ea 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2023
+# Copyright (c) Siemens AG, 2020-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -23,8 +23,8 @@ SRC_URI = " \
     git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
-SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
-SRCREV_debian = "74b34b5a3bbdedb628bd75422d6a8bfef70ab58a"
+SRC_URI[tarball.sha256sum] = "023b96548e0779bd7aaf58899883099dba9993b1b4af0c858adc00382523ae52"
+SRCREV_debian = "7e31b8f9cc204d1210c6c03381f936a96c29b35f"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
-- 
2.43.0

