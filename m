Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBF2CAC58F
	for <webhook@archiver.kernel.org>; Sat, 13 Sep 2025 06:54:56 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.13])
 by mx.groups.io with SMTP id smtpd.web10.528.1757746486923296458
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Sep 2025 23:54:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=itLzWM6c;
 spf=pass (domain: siemens.com, ip: 52.101.70.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEEnayBnPiYvNYYRhYXmzixKC9v1M4FQbtU+ShMy20uUdlew4SFZ0zOdGffWKb/70w4btD2wdU5F8clBVIwT6QG8GTweEWPA7+ZmJfSnKPCY7Dmq5DWU+U2d69MetjJktx5Q7VlKiE9OaMj2w6JIXWGtlW/5IFZVV6NmROHj9C305hOjWR09R/kGIiOqIkKa5rHE+fiwanzYkNK5WDNrlGYObV4ZtCJobmb1N6HUYL74MbSM+Djuf9GS1lnAabpUy3nN4DwHQnmMUspBlz4bc/A15qqMBOuFaiPPJ4mqlqXsopp/SDkhNw078MseXr0Ns48VuKC8kTCiY19l9sVP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVGDlYOB7V0xcPdeQc7UvAxrJqG+mNFgaiRcNkQmnd0=;
 b=xfeNybYvJlcXID03VCW9Uef0Vl6GCenDrKdrYdTWM0S0QxbuhUsMNmQFVz83Cq3BqLhStDdH39ERF3HXSB4vQcnb2QJaXZ6ecwloGhoOuuwINPV0MmQHlh8YgttIwa+wXm8JVkH7Y9LzXHg9mlBSWTkV3vrUDiD/VrJckXRFeBqfe17JdUYT9IaMxdHP7QKcrDBPzwvPbM6JGEapx8GLlMjdFPwsLwaRv8EM+Mx1hzNQ0Sv0fyXRy9m6Qes5rMeh3hdTu9vJ6el/WwXhR5d89BosidpdulrfQV94Ej/Z4NW44rokuv0hnOWIquP2T0n9mt0GECgqcG/ml+LhgufaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVGDlYOB7V0xcPdeQc7UvAxrJqG+mNFgaiRcNkQmnd0=;
 b=itLzWM6cMyicAdRUAEqi58I+o83jpuEMzLFB4DGR/S1BTfl+cUhCi1isQV2kquKO+rKSyBVea9Fva6hmVccr1JdNfZWosftZx/y07WCFHD3bDkywKlRhi4zxBqjcBf8Ij4pnlo4F2s5XUDRg6+iaUENZSZy4E3x0v24PZ0eS2UpqkuoSWiFVhtdIWWZOirgR35zAKacUHPFZNonNv0aZL16aeJX/cd8rCX+hPv8M6krqKkT8YwKrKOfgXQzBlMFwDVESiPNMEjnnppcRvIpD5KDu0RVZUEYgQCdIy81GOurQ23NU6xJbybWOYa1Iyl0WDDSTElNsHZLs9TbVz3aVUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB9058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 06:54:44 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 06:54:44 +0000
Message-ID: <890e1149-4622-4637-b64a-63e52c91c795@siemens.com>
Date: Sat, 13 Sep 2025 08:54:44 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] efibootguard: Update to 0.21-1
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 0610ac13-8b76-4305-7181-08ddf2926bd8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?enRqR2grTjBiMWNDMFZ2Q2pmRktkNVVKQW9uL1ppMk41V3NneUlGaTNMVGp3?=
 =?utf-8?B?MTNCUitVb1BSSU9pdXlwMlVuVTllL2txdWM5UVRBZUk1ckpvOUhTZnpDN2VT?=
 =?utf-8?B?cTFOR0tXT3BBUVBxTkluekt0K0JyQTRFQ3B6RHlUTTFncWs2TitBeUZoZklE?=
 =?utf-8?B?SGYrbTRybmFoZjR3a2QyNC9vRzUvTmlzZ2tRVlR0RTlMejFpNXpBdy9lcmEv?=
 =?utf-8?B?cWwyTHhFSUlpOXFORFRiOGRYMkxLL3JyazRLZXJvTTAyOFptaFNDQjVXUTBo?=
 =?utf-8?B?aDZMRVZ3Wnp4elluYTNqVHZtQzV5OGZzQWV3eHNaZXFFa3FidjUvN2V6YnJ3?=
 =?utf-8?B?WmhnenEzUXJsV09rcWlOZlAwc2xjS1hwZXlaTjUzZW1OSzlocklrZi91Z1da?=
 =?utf-8?B?RkZ1OW5DaExvRnJaUFVIVzRHM21tTFFTblQ0R21vVG1mR1B1Q2RqWVhiNmdK?=
 =?utf-8?B?TkE4S3d6NlpoN0MxaHBOUVJtQU1hcDQ4eER6dlVjUnVEZ25TYlh5US8vTDJU?=
 =?utf-8?B?WnlmKzQ0ZEtFTGdlUzl6d1RXcmFwd3NGZzJuWENIVTFPck5HL21FTVFGMzho?=
 =?utf-8?B?dE1NcW1UREN1c1liNUg4WHpmOGJ6WlovVlNLbHdWYnNlT0ZnUUR1b09PMUZk?=
 =?utf-8?B?ZDVaWWNyTkdmalJUWU1YNFhSNmFtK2t3YSsyR3YrcHE3OVhHMVlKS1ZzSUNH?=
 =?utf-8?B?UDRxdGhkWlhsemFmbEkyeDRtSEFaRjEvblVNOXlST1BMNFpVWHp3VTR1RVF4?=
 =?utf-8?B?eXZaaEk4U0VYUm9JNXpBUG1kMjlBKzk1MmE2V0tuNFFtSkJyTmVWcFl1UC92?=
 =?utf-8?B?TTFGZW5vdGZNU0dYSDZBQzdGb0F1ZnBXSUNRRC9EWUVqbm82Vy8xTU5hT2lM?=
 =?utf-8?B?YjBzaDYrSTRyVEZKa09zTDd1NWhwWk43MkFnNzNMVUM5R28rVEdGb2hwV3Fs?=
 =?utf-8?B?dGc4dEVBS3B0RXEwcjBGWFhOK09GUmprbFZQOFJBenA2MHRlR2NzUEQ3MTRj?=
 =?utf-8?B?amdzbHU4M0pXUDBKV0ozQzRPeFhXbStBSXlVbHZkNTBoMTlkNVJYVmticiti?=
 =?utf-8?B?K3JXSk9YVDNtVms1QXdJY2ZLVmNYTlFMMWR4dzFRUU5BSzFHVGZVbkNrTkhH?=
 =?utf-8?B?NHBYOTVpeFByZUU1dDR1a2c5NmpvdnNsMVRteEhNQ2ZoRC85OWNOQjZWR2tL?=
 =?utf-8?B?d3E5SHRnVHgvU1psdDhIM3lJdVJSSTJmeEJwdkJ5MzVtbmdoZFUwWWhVbFFQ?=
 =?utf-8?B?QlkrM2Mvd21MSEphQWdyaUh3OFJnQkpZOXE0V0VjWU1QZERpRkd0YXdLc2NE?=
 =?utf-8?B?djl6bjNIQ280WXRuVGF2NTdKUm1xY1hPa2tnMmI3ZjBHTWdzYTNuc0JKYitp?=
 =?utf-8?B?amE5N3k4eTJxTlhLakNjbkh0eWoyU2Fxd2FhbGxTZ0hGc2dPRW85NGdFWlFM?=
 =?utf-8?B?NHZTaGdsMGJtZUlFQ01IYnBaNU9Za2tMU1o2WE00M1Q4eXl4NnhUNWh6SUxn?=
 =?utf-8?B?NHc5VVhBZHU2cklhTHlnT3Bza2NCZ1p1KzVESFJBU0o5WkNSdlUwTlIwU1Vm?=
 =?utf-8?B?M0JhQWJsTlpyY3NZRHRYMFhqcmVkN0ZvM1hDbWIvWE1oRkpBbVFySDBOVzVy?=
 =?utf-8?B?UndsMU5peXJCK210SjhIZlBFRHI3VjB2RVhqV3ZyQ09DTElaV3F1OXRQdVh2?=
 =?utf-8?B?SVhZZURPRUd3ekdlZmY4NHhjRnNiV3BxWEJHc3l6cEoyaTByQXNiSXhTekN3?=
 =?utf-8?B?SHNDaHAvYlg4eWlzYWpGYVRvRUIrUk1YOGxRNjRPL0dFZzVyb0lscWlFUUhE?=
 =?utf-8?B?Y2l3Sko0NEVpWDRhczVqNGxEdzcxRElBQXhRSVdnalBUT2M3UGk1cjRLbk1S?=
 =?utf-8?B?b1lpL0hnZnBlY0d6Wms0bmdsUmJiUEpRVy96Vnd1OW4wa082L1F6cVFwQlNU?=
 =?utf-8?Q?i0MYkAhcWIQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0l4YTJUUW9QOXMzTEx4MkVXR20wVmVDd3VEM1F1REFlUy9WZUFOZVlQd2Ri?=
 =?utf-8?B?ZGR5bnRIeS9aSWxRLzViSk9POFdMamNYMVFRT01xUzl3b2lENkorSVZ2YSti?=
 =?utf-8?B?NVRtbktaMVFWbmZyZFF3N2NQcTdFbXhoMnI5OU4rbkIzaHFraFJ0eDBBUUtG?=
 =?utf-8?B?U2tzL250ZVU4MXphejBzREdoUXhKc0xhb0xCeHdaem9Gc2pkRkszT1ZPQUhP?=
 =?utf-8?B?UDJ0TVg5T0p1RXFCQ09XM05SV1QyelA0V1MrY2F1OGhJVXFnY0J2UlZSRlg1?=
 =?utf-8?B?RlFmMGtxM1VpZW5ncGtVMU1pQnZUb3lRQXVhNzRYM0pWUkR1M2NVc1BtQ3F6?=
 =?utf-8?B?T2svbWFvdi9QVFFzME9HanY1NkdUL1YwQ0hsdEpCZlREUXNWT0dxc2xRcm5n?=
 =?utf-8?B?OGRNUVN4MHU5YTc3cWVMUnVvcXRRNU90RUFzck9Od0RlSFdpQThuU0ZZL3hW?=
 =?utf-8?B?UmhiWFRobVpWeGhYT1VkQ1V2K1NtMGpiSUFXb2ZBWDgrR1gvcStnUWx3ZE8x?=
 =?utf-8?B?aUtCMzI0NEc1NExjWHNlRDRUaUlvampxczM4VVllTVg3OHEzMk9BemRHcEE0?=
 =?utf-8?B?emEyRi9qK0lmVTNnendqZ3UvZWZSWnc4L1FpZDhybUVxaHJ1RGJiKy9hRkRQ?=
 =?utf-8?B?VEMxdEh1em9oT2Q2a0tSZHkrNzhtTWNoQkwra2VBcGxRaXFRcE1hOEg3Tlc3?=
 =?utf-8?B?cTZFcDVZc0o0Zy9vSXJvbmJ0MnFCWGJvMndNUDA2aEcwQkVFVG1NWWptTlBm?=
 =?utf-8?B?ZzlEOWZWMkE1bGRmb3cwSnhsQno1ajNFWlJBRjBuUmdGdVZEWUdvNEZmeDhh?=
 =?utf-8?B?ZzZKeVVpSGhPc3FVb0N3M0Q3ZzYrM3NwK2t1SWR4MHFNQVNSQmhoWlJGQ2JX?=
 =?utf-8?B?RTkrdjVkYnV0SS9nK3JZL2ZjY3p2SWlzN05BMk1nV2RsVGkwRFY3U0NRVkNS?=
 =?utf-8?B?d0VIcjIzUzdpc2VqeFJ1WEFGQjlsc3l1aWYyeXFrKzlQdm1YZG9JYWNTM0dS?=
 =?utf-8?B?djNhY2JIcms4K05wVHAyTGxlVnlsd2JtWDBjd2o1VUsxOE5rakFjbTZPdzFn?=
 =?utf-8?B?MUFGbHhnRGNxMG9rWUdpejBZdmpzeVZrZ3JiVTJXRVdhcTQ3ZWtvbitZTW5X?=
 =?utf-8?B?Q0xGZ2xMVXdqU1N0NWlzWHRZQ2tnYmVZTWxVSzBGdWYrdExUc0d2bFllYnhz?=
 =?utf-8?B?WU0rL2VJSlZuN0VNdHh0aFZGQStidHBZZlJycnZJbTVzRGJQa0QrM2o4WURE?=
 =?utf-8?B?M3RnNWVDeTlOU2txRDh2L0ZGdVViaGhmak1Wdi8zUHR3cHVpSUJtd1F5bVJp?=
 =?utf-8?B?M29TTHkyM0p3VmNISCt6SXZtY3RHZFk3WjV3YmZDb3JpQnpYL2dmR3NnbFFI?=
 =?utf-8?B?ODVXSzYvbUh3MVY2eTNCQmhYN1VuZERNNmpiT2hsZUcyMi95b0ZtbnVOSnJ4?=
 =?utf-8?B?N0tWbkVkZFN5dGwzeW04SFl0K0FFdDFYTWIxVlJHb2tIQStvTDRvdkF3Yk9J?=
 =?utf-8?B?VFg3eGxYemc5NE1sUDg4MFJQUENVY2pLNGROc0xUeFdETm1uaVBaUnhmbC9C?=
 =?utf-8?B?WW5IRmVrN3dlUzBSeHZPVkcwYmxJNlRWdVFRSjFxck1IUEhsYjJENXd3WFU5?=
 =?utf-8?B?WWkxVHhjeXlvUnl0akRtc3A5Z1RRUzBIcHRReE5zSmY4NndEVXRnQmtLTzkw?=
 =?utf-8?B?UlBTRFl2cUY1SmE0YkJueVBjTldXdnFOZkp0YU12UDdENkVDVm9xRXF4cTYy?=
 =?utf-8?B?UjdDYjNyVkdOejBMRXNZT2FGZ1c3dFN2SkVtd2cwM0twdVRlNEdKVDdVdE8w?=
 =?utf-8?B?NXFGYjhmaHVNOWFqMnlHQTR1VUE3eEM5UWJUOTRGMkZNMVl2dk9sbzNsNHVC?=
 =?utf-8?B?MDViOVFaOU83eW05Wkt2cThVYzdabEMrRjhhakxtaEJWMndzelBjTUgyQTJW?=
 =?utf-8?B?MlF1a3hvY1V5RXhkcUY5MTl4RDhmREF4S00yTURyVFVsOVNlSkJrUG93TWFD?=
 =?utf-8?B?OU9Ja1crMmoyalp4NzgyUUl1WFhvZEZGZXhNZnA0SldoemczcU9iSDR4TFBh?=
 =?utf-8?B?Mi92K0kwd3NHSGZQbUdsclFJMSsyUUhzQm1GR1V2aWpPdmh1MWZoVUluWnNt?=
 =?utf-8?Q?TTv9fSGDQq9jsdv1lMU+UnU9e?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0610ac13-8b76-4305-7181-08ddf2926bd8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 06:54:44.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0h2Zu+hOSKQF0+9rC4nO3+hm4F9HpR4LXMDLFlvY223Ky+FAdiuASkYk1eHUovgyxc1cubYS1EnxBaNYrOqmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9058
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Sep 2025 06:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20046

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings various fixes, specifically for secure booting on armhf and
for using bg_* on mounted partitions.

On the debian package side, we now have a split between efi binaries and
the tools which allows to leave out the former from the rootfs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/efibootguard.bbclass                  |  4 +-
 ...19-1+cip.bb => efibootguard_0.21-1+cip.bb} |  7 ++--
 ...l-Make-compatible-with-debian-buster.patch |  6 +--
 ...vert-d-Enable-unit-tests-post-trixie.patch | 41 +++++++++++++++++++
 .../wic/plugins/source/efibootguard-boot.py   |  6 +--
 5 files changed, 52 insertions(+), 12 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.19-1+cip.bb => efibootguard_0.21-1+cip.bb} (82%)
 create mode 100644 recipes-bsp/efibootguard/files/debian-patches/0002-Revert-d-Enable-unit-tests-post-trixie.patch

diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
index 422d4270..cbd23768 100644
--- a/classes/efibootguard.bbclass
+++ b/classes/efibootguard.bbclass
@@ -9,8 +9,8 @@
 # SPDX-License-Identifier: MIT
 #
 
-IMAGE_INSTALL:append = " efibootguard libebgenv0"
-IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH}"
+IMAGE_INSTALL:append = " efibootguard-tools libebgenv0"
+IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH} efibootguard-tools:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
 WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
 IMAGE_TYPEDEP:swu:append = " wic"
diff --git a/recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.21-1+cip.bb
similarity index 82%
rename from recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.21-1+cip.bb
index 981aa3d4..f5dd1933 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.21-1+cip.bb
@@ -22,11 +22,12 @@ SRC_URI = " \
     https://github.com/siemens/efibootguard/archive/refs/tags/v${EBG_VERSION}.tar.gz;downloadfilename=efibootguard_${EBG_VERSION}.orig.tar.gz;unpack=0;name=tarball \
     git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
+    file://debian-patches/0002-Revert-d-Enable-unit-tests-post-trixie.patch \
     "
-SRC_URI[tarball.sha256sum] = "167a808d508558341b81d9a493f76161ac7fd7119e764435eae1b13e31a69737"
-SRCREV_debian = "040c116a61ffc99a92b6cbdb793abb7f51ef8d4a"
+SRC_URI[tarball.sha256sum] = "f252e87b6acc74df34a0d894f2b5188fe797c2a2b7a14a231b9f224ad9b9de20"
+SRCREV_debian = "86f686fab1a5a55c445718d4bd6a32106f2b8800"
 
-PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
+PROVIDES = "libebgenv-dev libebgenv0 efibootguard efibootguard-tools"
 
 S = "${WORKDIR}/git"
 
diff --git a/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch b/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
index bf02a8a5..f5ff6c08 100644
--- a/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
+++ b/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
@@ -1,4 +1,4 @@
-From 299b2fecb4be67b3b669762a88cb3376a9fd5628 Mon Sep 17 00:00:00 2001
+From 2550b65d0ae7bacbc79c0a30f883ff4895e5ff01 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Tue, 14 Feb 2023 10:30:34 +0100
 Subject: [PATCH 1/2] d/control: Make compatible with debian buster
@@ -19,7 +19,7 @@ index 0000000..9a03714
 +10
 \ No newline at end of file
 diff --git a/debian/control b/debian/control
-index fa7867c..8b92019 100644
+index bcb9df6..c56dd1e 100644
 --- a/debian/control
 +++ b/debian/control
 @@ -2,7 +2,7 @@ Source: efibootguard
@@ -32,5 +32,5 @@ index fa7867c..8b92019 100644
   check,
   gnu-efi,
 -- 
-2.39.2
+2.51.0
 
diff --git a/recipes-bsp/efibootguard/files/debian-patches/0002-Revert-d-Enable-unit-tests-post-trixie.patch b/recipes-bsp/efibootguard/files/debian-patches/0002-Revert-d-Enable-unit-tests-post-trixie.patch
new file mode 100644
index 00000000..2eb3c807
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/debian-patches/0002-Revert-d-Enable-unit-tests-post-trixie.patch
@@ -0,0 +1,41 @@
+From dce9246ecb5935d815a1b2c1975af00d542da562 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Sat, 13 Sep 2025 07:29:35 +0200
+Subject: [PATCH 2/2] Revert "d/*: Enable unit tests post-trixie"
+
+This reverts commit 2bba3769aa3a6d80180ed96501e7b2a852f30b78.
+
+Only supported after trixie.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ debian/control | 1 -
+ debian/rules   | 3 +++
+ 2 files changed, 3 insertions(+), 1 deletion(-)
+
+diff --git a/debian/control b/debian/control
+index c56dd1e..684fc1b 100644
+--- a/debian/control
++++ b/debian/control
+@@ -7,7 +7,6 @@ Build-Depends: debhelper,
+  check,
+  gnu-efi,
+  help2man <!nodoc>,
+- libfff-dev <!nocheck>,
+  libpci-dev,
+  pkgconf,
+  python3-shtab,
+diff --git a/debian/rules b/debian/rules
+index 12a3ffb..ee00053 100755
+--- a/debian/rules
++++ b/debian/rules
+@@ -20,3 +20,6 @@ ifeq (,$(filter nodoc,$(DEB_BUILD_OPTIONS) $(DEB_BUILD_PROFILES)))
+ 		tools/bg_gen_unified_kernel
+ endif
+ 
++# do not run the tests until fff is available in Debian
++override_dh_auto_test:
++	true
+-- 
+2.51.0
+
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index dde72725..5206f864 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -215,7 +215,6 @@ class EfibootguardBootPlugin(SourcePlugin):
     def _create_unified_kernel_image(cls, rootfs_dir, cr_workdir, cmdline,
                                      deploy_dir, kernel_image, initrd_image,
                                      dtb_files, source_params):
-        rootfs_path = rootfs_dir.get('ROOTFS_DIR')
         efiarch = get_bitbake_var("EFI_ARCH")
         if not efiarch:
             msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
@@ -225,9 +224,8 @@ class EfibootguardBootPlugin(SourcePlugin):
             msger.error("Bitbake variable 'EFI_LIB_ARCH' not set, exiting\n")
             exit(1)
 
-        efistub = "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
-            .format(rootfs_path=rootfs_path,
-                    libpath=libarch,
+        efistub = "/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
+            .format(libpath=libarch,
                     efiarch=efiarch)
         uefi_kernel_name = get_bitbake_var('UKI_FILENAME') or 'linux.efi'
         uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
-- 
2.51.0

