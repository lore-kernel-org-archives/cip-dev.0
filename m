Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B832D16251
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 12:15:06 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.82])
 by mx.groups.io with SMTP id smtpd.web10.53560.1728908098798667531
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Oct 2024 05:15:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PJOCU0gj;
 spf=pass (domain: siemens.com, ip: 40.107.103.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7KeXm4ZfMec/PUbtAWgRT8JMSRDrCIlVSQ4a/QKBqHZgWpQaPyVjS2qxfJMRD8FIkFTCVyX+gKjuOpDAHf2uWUHheKldZcb9iN3jKsNwA39y/ovt32jvDmXv4RYuzo55nWlCe4QEDqJObcwwMJxUCiA/AK6GUlmLqpRFW1RnRAE6JKSeSJYhmnnTBqtKQcAsuxInuGnyx1QRH1JtDdpzpaUoYjYyN5RT/Moh4uND025A7ZQy6pCoLAT2o7RTiQKI1DYQf+nvyGR5AvwADmx4gshvEtUPv5eh3I3kLzKWKQ0MdoPNlfgsVaKgoFPrgrbPvhoZ8N38vkbiw+LPdW5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCtSKoLg7s5NMPvE8+CUnfd7t8kbQyYsZWDJ9W/4FGo=;
 b=ueNj0Q8zTgTs5n5r0ajnO3KA151niRACusGyC5exMXhqvfI1hCJglH0UBlMyAHhjHdlEAbRoEh3iK08Zg0h3EppsW4hRCM80GCxO/f8ZiAkLpRCKJjPA0dXsHkOhU5GKk4XIpA/1mKm86ByQmAklYL+SWqb09zPpmPnsADYhDKGuqKLxZy0FkH63Tp2uAJ6aSUupK9m24xRgs/UgM2u9kj3iJOkKvm6Ai39qJ5P2p0w2pKuC66cv1cRMjQ83ZVs9VAVHqcJEUGbspAPlURt1eJwTMzfagTyGCGEOeAJXOFLd22uK3BrIraOOUgNav4T5AXHIoFnKNYUDr0MghwE1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCtSKoLg7s5NMPvE8+CUnfd7t8kbQyYsZWDJ9W/4FGo=;
 b=PJOCU0gjP7EhpdpAgdpaE+Au/j/tzHlDU4OKYhE1c3aQZnmU2ledczyvBQ2y3aHJKZktqsiSmsw+nRzaLWPFjuDycUDsrr6uOKmE9eG68Fe8bGv97wxtIzth7cp0fJm7ceFfFQIVBu+UwJOAJo/1yBYR+gX9ikwl3vu451Et1mO9mOLdKQzAqH06edZFdF82N8pLGRGaH/TaYtTKc2aUks8agI/58DCM3Pfnlkc9QU+et3GmUS2Q+Ls4mQolBRVq8hHdrvmC5t4nTIuedd9SmqL062YfSTjfaRevxcI1XbX6ydqfamNV06yAysJHnq2dszEi3fUdCt7dymbKtDq2dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:333::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16; Mon, 14 Oct
 2024 12:14:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 12:14:55 +0000
Message-ID: <7ee2e004-03ef-44e8-82fb-39400b97acbe@siemens.com>
Date: Mon, 14 Oct 2024 14:14:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.5-rc1
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0403.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 058cdef2-228f-4fe3-dea2-08dcec49d037
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N1JwcDJ5QzF6VmJLbE42NzRYbkdUQW5XWW1ib0RENWVLSnNTODVkcW8yeEtM?=
 =?utf-8?B?M2pSNmtYNjgzOFlIOS9qQnFrS3ZKZ2U1dmlBbVcyanFiSXBwdGNVNkVtNnlq?=
 =?utf-8?B?VEp4c0F6QWtSU0ZndHRHMXVQRHRZRHYrbGEwdmJ1ZnBLbXFtTEU2RmwyQnVJ?=
 =?utf-8?B?bzNieTVHM0FYMWJ3UXBZc1pvQjVRY28raDFEZ2FKVWFscnN0UUlqSmxWVy9J?=
 =?utf-8?B?N3hmcldIUDNycGY1S1E0VWp0UnZCQmt0Q01pOUVDcHdKanlET0YvdkE0REZ5?=
 =?utf-8?B?ZFpHV2d6bU9FaGd1VWluSFdDb2FkaWxYMExKYXFOUGFkMEx4Skdta2lOY0w3?=
 =?utf-8?B?NWprNWV6TGtXSGZweEhhOGJWL0cyVWhvWW13NGpuUks1ZXhJZVdXTDNjMFhu?=
 =?utf-8?B?dnFYaDY3a1htcFdBRy9nZC85SnR6bitTb1ZIS3dRNC9ESmJUSnRIM01kbWl4?=
 =?utf-8?B?Yk95Zzd4Y0VGTVRSeEhlZnUvcmNPWWJNV3JOM3dLUGVDNmszeW5lZ3FQeitm?=
 =?utf-8?B?L0E5V28xanJ0eWhrbnNjUUV2NzFIdHFTOCtuTWdTelJDN25hdTI3UEpIYmZs?=
 =?utf-8?B?V0xsK09HZHJHQjgwYUd4ZlUrUU4vRE9Kd05ITys2aGQ1cWJuSVEzeXpaV0VW?=
 =?utf-8?B?NVlqQ0FxTjJ2ODVHUzJNdVpyY2FIbHZ6TEVQU0hIQWE3MTd3T1BTZmlOSGNi?=
 =?utf-8?B?dXhRdkdnWDNvakIvTVRydmpHOWdacGpXa2I5Uzk1Ukh0R05ZMHNNTjJlQ2Uw?=
 =?utf-8?B?dWZwQ3BZVnVGM2N4TDZpY2tkU1I0dWJUdno3bWtaN0wwNXF4czgvNWl1Sm9H?=
 =?utf-8?B?UXp2UHl4ak1KMlZoUVF0cnNpUnlpRDRyYW1MUUkwSWpXdStMSUpRekhoN0ov?=
 =?utf-8?B?dEhUMVRxdUZoNHlUaXQrTTllU3gyU0pjYTFFOVJHY2FsaU9GNUwyYmlHVm9W?=
 =?utf-8?B?ekdUZXBrNjE5NEN6RmZXOGxKWkVhYmdXam04VjVTRU81WHJ1ODd4bmRteTcy?=
 =?utf-8?B?aVdMTHRWeXFNWGhmR25RaTFINXdHOHc0ZjJSS2F0aGhyb1JEQlBsNnBPY2dP?=
 =?utf-8?B?Q3lGY3NNWnJJWXBweUt5YUJSdTNucDlLNDRRUkl5RERFNGdLMjYzbk9rRm0y?=
 =?utf-8?B?akZGRkJUM0g4ZEdLR254c0NJcERXYmpEQWtOaFpCWkhPdjIxZGFzMEFvQ3BG?=
 =?utf-8?B?RGNBWFhrWmxGTGtVaHRuSEdaWE11ckRGWnMrVVFJZGtSUHZEcnJ6TEIweW9R?=
 =?utf-8?B?UGJqUitUaXZWOWMvdC92TjhYZUVNcFdnQzFOb3lweGNDb0N0OEZUd0hWOW9w?=
 =?utf-8?B?ODZUU2FVeDhIeHFBdXMxZnhOazVLUGtKL1Z2M1JDSGIweXYyR0JRNEVwOElE?=
 =?utf-8?B?ZzBJZVdjZkFWVWI1Vk1HSHB4SU9GQlRBbWJUQ3pWMjZWVzZpM2NrSVJ5cm1q?=
 =?utf-8?B?dE5JSExac01xdjBGOFBVdjlNdnkwOU5sRlpra2pHMmhRbjc2anIyVXV5ZlFS?=
 =?utf-8?B?V1Q2azNzZUlrcko3SGppSVZqQ25GbzUzbjYvVTVTRDlaOHkzVFRuMk80a3My?=
 =?utf-8?B?bjZ1MlBxa0dCTkdHbHpEMFpnT0xrK3J4WDU1c2p2bDlkMkZ4cmxUUVEwc2hH?=
 =?utf-8?Q?dJcoi8wQ3sFc0khKk75K9OziunD28K3dEXMHQRdNs9bQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WllIQnc2SlZuS3NPSVdOeHJjOENYQkdDR3plUnRsblZoTWNqMENvZHRZQ0N0?=
 =?utf-8?B?VXNndmtlbW91bml0ZGEzUEJXR1hYYUlldCt0L25oZXdaalNIa1NhalhyK1ly?=
 =?utf-8?B?SVNWOThIOTRCaUM5alVzTVRFMXQ0dUo4T3hGTjlRSFBzZUF6VDZheVcwUHR5?=
 =?utf-8?B?V1lKMCtsKzIzQ2dLV2F5OHhteUk1dlRnbHBMMlI1U1pkbVdaMzZhNFdZcXdP?=
 =?utf-8?B?RDNhOHZDZGw1Y0xaYUthVkY2V3JwNjhLaWhhNGZmMEI2dTJyRW5OUndQMSt6?=
 =?utf-8?B?dHBNTmZXdXRReXh6ekVlYUx4Q1RINkZFOGp5NlU0K3Z2MGw4OWM0Qkxzc0g0?=
 =?utf-8?B?T2ZjcGtXWGRqZWxseTV4aFJaV2dZRmp3NnpuK2lhdklEcEZ1S0FxN3lrQUUx?=
 =?utf-8?B?QUIyMTAvRzR3U1BidWl5djdUc0taYXc4akcvOTZSM0tEbkRCTi8yU08vdEQy?=
 =?utf-8?B?aFlBOHo2RllHVUkySWdudnhNblV2Ym4wc0E0Y2MzNGlFWGJERTZjcFhmbWxG?=
 =?utf-8?B?RnYrdGVRdzZkdFNUYS9COVpUdHRDT3UwV3FpcTc3OTZDRDJ1TnQwS2pMT2hY?=
 =?utf-8?B?aTdTczd0aVlHemZSdE1GMnNwWEdNa2xBT0JTT1k0d1pFWlBjVUNFODZZQVdW?=
 =?utf-8?B?N0tCSURyNEJmT3RKS0xrcmdlMTlUQnd3Nm5UVXFtK2dRL2FyWmF1YjFLbnFM?=
 =?utf-8?B?UDV0VjhVZmRMblkzVFVLcDYzUWsxeTJ5V1VGQ0NHazVQQldBMGlmL2I4LzVI?=
 =?utf-8?B?bFF3THRPUVNuU0NyR1RpTmE3VGg0TzZaUXdPbmlGRmNaUkhuZ0JaRkhXaWJK?=
 =?utf-8?B?RERqUmsreURyQWh2VW4wV2ZaL1RPOU5WNEF5ZzRYYjFwN0hqYkw2NWRPSlN0?=
 =?utf-8?B?YlVjdHV6NXBuTzZWeGkzMFAxb28zWFFPaEdGK1dKYXJJZjZIQmdPc3NWWWFC?=
 =?utf-8?B?bVpIVm1zT2ZoUlpTdVFwamFNUzIrV1ExcTZ6ZHVOK2JSR1Rua2w0cTJtRWN2?=
 =?utf-8?B?Mjl3SHlwNUZvdjZlVHIrSFZXdTQxQ1N2UWc0S05QanBTNGdFZTMwVE9zdVkw?=
 =?utf-8?B?TUpXakllRTE3VEMxaTlzVis3dXpCVzJMNGM3RE1SWjg1UEFCaTcxU21CQ1l2?=
 =?utf-8?B?VXdJVmY0Z0l6Z3k1aWRPRnZ3R1ltSTl0L0FaM2RCTkp0bWtiQVJoR1A5VTFz?=
 =?utf-8?B?aG1JQ2pucDQ3N1RXcjYwWnBDWlVKd0YvRloxSGV0aTUwbFNMSXRjUGovOGl5?=
 =?utf-8?B?SDNhUzJndEl1Y2ZaRUFwcXBhbDVYcXJEN01hV0xEWVFBMmxQRXQ5bHphU2xq?=
 =?utf-8?B?QXZIV2tGTUlUWXhFVCtYWjRRakJlVVJCSEh1NnljdHZqaWVRNzByZ3pNQUxp?=
 =?utf-8?B?Uy9pam5uaVpwOWZtQmd1c2MyYllweXlDdkpydllSUTFJUjk0dWpYc1VYTjF4?=
 =?utf-8?B?Q3dzYlhlR0o1bmhuTHVpSUxrTDR2Snh2OG5XOXZmZmVoL2NCdTluVEFDSCs1?=
 =?utf-8?B?cVpKNzFaZ0dCZW9rSDAzYkpteDY5blpEcllONDh1bGZTdWo0WXZHYXh3Z0tj?=
 =?utf-8?B?L3dlSk1PWURJdkpaaEVyMk03bEpmYnk3MHVKNDBXWkI1MjRHRHJyWFZPNGNt?=
 =?utf-8?B?Mjh5RW50T0Q3aUJLSmpBMG1xOUo2WFF1dllJNkd1cUdlWk5PVXdWZHNsRWgz?=
 =?utf-8?B?VXRrZ1FUcXhTUU43ejBoOEF5MGRxdHpxQmdoTkx4dXFLMTRyRjZQTWVScWpK?=
 =?utf-8?B?Rzk3NzhrNzVPUGx3SXdwTnJkSWh0bTVUd3hBNHU1QVFwYUQ0anpEMjVQK0VT?=
 =?utf-8?B?Y3k0bE5UVDhhVkRsaFdWcG0rcTRoZVkvbFdlcmI4ajhqMzdEa01LWmk1ZW84?=
 =?utf-8?B?L29FL0pubkV6TzBqcERUYSt6SCtmMDEyRkloWFhvYVRZUTdKVS9vZkpPZUMw?=
 =?utf-8?B?aWFUVTYxVjNvYUJsZWRhamYxNWRsVEZkOTF4Qm1tUll1OHhNUkhubFgrYUxm?=
 =?utf-8?B?K3BtZ2R6WngxUkRRVlZ3b1R3QjdWVkpoTjRzWnB5MkxNL0JpN0pMVW5xM09o?=
 =?utf-8?B?Vnh2SS9Da3ZMNVFBcG5IU2tSaVoxMGNOK2JVOUt0NlB2UHAxS1B4QkkyN3Zr?=
 =?utf-8?Q?3+5YaV/lAtmeJ6y6fAX/Fj96t?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058cdef2-228f-4fe3-dea2-08dcec49d037
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 12:14:55.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6p9sjQq7Kg37E4mZezuzncrVdXp56lEyyE+UC0dDADjTgvbkqshJJppTGbKGAVCX+y+HSliVkHHtbF8rTB6e3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6759
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Oct 2024 12:15:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17033

Hi all,

this is the first release candidate for the v1.5 release of
isar-cip-core, the Isar layer which allows to build CIP Debian images 
according to the generic profile.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.5-rc1/isar-cip-core-v1.5-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.5-rc1?ref_type=tags

Please help with testing so that potential remaining issues are found 
before the final release.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

