Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3434C28B28
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 08:05:58 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.24])
 by mx.groups.io with SMTP id smtpd.web10.9682.1741853158283184279
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 01:05:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=0IS0oCdh;
 spf=pass (domain: siemens.com, ip: 52.101.70.24, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaIMxnwQl0w05PYeLwqoGLiHh72hnev71dcuKMUac+BbWgnfhi9MdyJNwG5HoOYrf4BeOfmfrvannEghUqzTXgrKBS+aiomMpfxV4iNmuounorNaQdvH2LXcqmQ7AIAs6l9A7zJUtijf6lTSW48Mx4Xof4cw+iCy9HcTW/+c8hh+Q8j9/XcU0wfqvl1hmOFysczsh1h8D2mmiDEC/DUwA2w1OX3NTBf/t/IlC851Qu0u1YsBLnorpyr9OjRKolrYN8M8qMo7lqHKMQ0mXRrtfXKwDRS3V3DtXD3ExAAh5+QyCbUN3Y8kQjegpNCpS0t3Ngd2INNuYKXZr1iQSXSg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tguVG2IJWaRaBl6erO7MJ0C9Gd7jRs/RymN6QZZsdsI=;
 b=EOAaId02yaOyzTPWp43KN/tr/TMzBKAv2sWV3ejWJbySham09+xrCr48ckbKCcqvGOCtQ9dpww3yUAOrohHJ3scslCZnaNfnBzb8SV1wMAikiCO8C3NTXv87wmO18PsR8ByNl8WlhAXIYR4Y9/XWKsO/M6kMXgmUZ+ZouG0P3ucSFo7cg02oCQtMz7edkSxwFxQ38xYJM/CvpiZ0jwVafEnE8Q1Bc0SDYv/rKoESlO2rrzJ2bVsSQRHBx7Zk5jQ5T1edyQv2cSS6QNRlkS7QJHPm3xZcAAhnV5U8bP2S6RCoisHbunlsy8KzVi8dLvU20xArs3gHq6xdIglQXYNd8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tguVG2IJWaRaBl6erO7MJ0C9Gd7jRs/RymN6QZZsdsI=;
 b=0IS0oCdhM9MddHlIHYZkT26cQgPhZ2cvNloNglCZnPJH59ErmWzlKZ0N5nIewBHRrq0AMQQ3C42HK1O8mCO7ij7sUwdAdbi2c+WmtBQ4z9MOMQ1dvJsr9+DEf43FKJnSOGEMe/n5s8/kI6DhYfKjQnIOFUvyqLuSRV1gAMfg8e31ery/9PS5vpbbORlyNR2GeSiLzV+UVST+lCALHXFq0307pHIJaDYoPahhNziBWKbgTBKB6OgswRCQUtwPBsrsPBUv3/lfQ+xtywTkZwd1J/4AWxmt/QKpk3mZQpKoziZN/hYgRNPR+GP1ccJ2j9OykwwwbwL19AbVd/KhDwbWNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 08:05:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 08:05:55 +0000
Message-ID: <99ebe8f6-b459-4744-a5a6-fbd2ce0c3934@siemens.com>
Date: Thu, 13 Mar 2025 09:05:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] linux-cip: Update cip-kernel-config to
 latest revision
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: cedric.hombourger@siemens.com
References: <20250313054155.337079-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250313054155.337079-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f1ff47-ef72-4aec-d179-08dd6205e0ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U2N5cGl1U0pTWG53WkR0bUdyd3Z5NFpYZXVsV0VrWDhucUQrMmpqRkwzRlRy?=
 =?utf-8?B?NjMvK1IyNTlzaGZTbzZQTHpMQUpNZWZJeEZBMXBmamtvUGVoNVZnSTQ5N1Fq?=
 =?utf-8?B?QXZxL0tNYVpNc2VLZXhJWWw2YVgyVnY4NjZnZjZWRkpRTE90UEVqd2cycHRV?=
 =?utf-8?B?czRBV2RZRzNYcER3T240bU10cDF4eTByZXNpQVRpNENyR2VQM2tSTVBFV0Z3?=
 =?utf-8?B?RlBuVkpHUjZOOEQyNHcxVjdhSUk2RXkwNGxSaGVzVzhMRUlNM2NwVGpQeE9I?=
 =?utf-8?B?SjZISmJiSElybkhYeHNxZjhDVG9WMHlHNE5VRzNlWlBXRlI0djg2VnUyRHZ0?=
 =?utf-8?B?bllwQ3hJSE9PQjczczdYRitOZHdEd0lzc2RvbXd1ZDV6T21CQ3VhTHIycmtW?=
 =?utf-8?B?RHllTVd6OXNOQVlMNW1zNUhZeFhlUkM4dzV3TkQrRGdVd292N1dZTjgxdlNx?=
 =?utf-8?B?ejZ2QldESnp0b3ZhTm9hN3AzM3pMQWw4V2t4NldFbktjVzlkWGFUVXRSeXky?=
 =?utf-8?B?TmNlZWs3TEtwdE1rRUFUa0RyL3pkL2ZsNzZ2STEwdE9RTHFTMW54VnR4R3Yr?=
 =?utf-8?B?OWxFdmdSTXhoUjJWcitDcXRkVkl5VFR2Q2dZRWdnKzMvQmhUaG41a1FnMitY?=
 =?utf-8?B?Sjg1RmVPaWk4eHQzL0ZZcUtyRUlDYlBRZnYyNVFDUHYxYTBDQnVBYTdXZWVJ?=
 =?utf-8?B?d2NPRFU5bnVjY0Z5K1p5UGErVzkvLzRTWnJhdlAwTUdlMTdoMmN2N0pGUTBm?=
 =?utf-8?B?TGVscXJlSWNaSDdoWis2am5xMmVjZW9malFmZVRVc0Q4N2c5WkR0aHg3TW1F?=
 =?utf-8?B?V2RoVUU5RlVTczA1K0NSQkNhbVJKQ0U5Qm1WenlMVFNNOUllZS9tclF1bXJV?=
 =?utf-8?B?NzVFOVNtUFZwRGNWc2hNM0JmajdwcUNlVkRtNWxOVmcydW15MTkzZFhuanhx?=
 =?utf-8?B?VmtxMVkrQzZFY0k2aGJVVkhvUGZtNUV1LzlnTFhVRHRjdFVhWWJYNkNqZlJk?=
 =?utf-8?B?UXNXZDR6Zmd5bVFmeVlOM3RTaG9ISzBjYnltanFJaEVyM2pnRDI3Q09QNHN6?=
 =?utf-8?B?aUVtUk1BM0lGRmF1andGYms0emNpcWVQdUNsNnR4MEpSNFFkTEU5cDhOVlo5?=
 =?utf-8?B?QWR0Vkg0TVFkVnM5RWVLM1hiQlcvaVhtVEEzQkt2cnlUTTVJWFBTSzV4R21v?=
 =?utf-8?B?MFBMZHZ2b1VuRVFFNnA5YmRKQWh3MGJ4enBxaUozNjB5UDE3cENXTmFkTDVl?=
 =?utf-8?B?UmZuekc5RlhaeWtYSW4zNnZSNWk1VVVZbTdNWnd3ekJaaGxPakNHbitVZ2Uv?=
 =?utf-8?B?SkhhVVA3aFJFUWxiRlFiL0ZMa20rWnNycEYvL0JRcjdXWHMvU0xCV0JTOEpr?=
 =?utf-8?B?aVdQZzdWZ0JKVjRlZXVrZzZSYkR2cCt2T20rdkFRWDBFYUI4aSt4YXVZYUtx?=
 =?utf-8?B?eDN0dGZsS2g3Y3JRUE1DaDg1NlFjUkpMODBJVXRjTjdtMzk2VDJLRjFlbTdu?=
 =?utf-8?B?NlJHc2huUHpuVDFFYkRXd2hCcWNUaDhZSDhlTmNCRTBaallDWVhET2dSTDlG?=
 =?utf-8?B?VXBEMjViZElPdS9pbWZ3YU1xNEdFZXhidHhsb1pJRC9peWVCVHp5L2phcGps?=
 =?utf-8?B?VTYvOFlvUWZLUWZneDErT2JSUllxYkJaTUlyL3VoSmxLWWhlWXZhTkpLV0Ju?=
 =?utf-8?B?a05CTGh4U2hTWUNRREk1dVpiOWNDa0diTVhEcHJ3bVhTem1nNnBIU21Ub2t1?=
 =?utf-8?B?emhLSXFTbEpZMjJPa2xhVzlIUEJ3a3IwakhMdDdVR0NJY3EvbUg1cXdRUkx2?=
 =?utf-8?B?UFNxcks4Z1Q3eTZHTkUrWlZsUXpSaVFwSHRRNzdmeWlLMDBvUVNYeWQzdFlH?=
 =?utf-8?Q?yLOZU0EmRuv3c?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVFmZzJicytrK240VURQbGVpNkJ4M0dIWGd3WklVbVo4aEZSNGJLdlMwWlo5?=
 =?utf-8?B?ZEhoa3dPM2pWM1J0Z3g3bTg1Q25ieFBISk1ya0JBK2ZHOFlQK2tRTFdWT0Ir?=
 =?utf-8?B?eWc4a3hmRWZPdDUyMkZic1dteXprT1h1ZStzL1FJR0xkanNodzgzYWYrNmlB?=
 =?utf-8?B?aitBL3lNRkl5S3ZDYUNpTmMzWGtiRS9tSkdXd3VwM0k2ZmhMWVFQaG1hZjB4?=
 =?utf-8?B?c1NjWE9UbVBBUGxNQXRGWk9qWTU5MjRaenZuNDRyeThVNzRScDNvNmovYi9k?=
 =?utf-8?B?QkJNdXVHaDl1bm9aaHBGKzMvMzZ4eFFGeWNxc2JrMHdUM0VXb0FwbVE1YzRO?=
 =?utf-8?B?NDc5eU02Y21jY0ovY25yUVFxcnEyekYwMUhSMGFxdUIwU2kyeFdVSFFHNEF3?=
 =?utf-8?B?cmdvTWVSS0V3Y0oxR1lXM0tJRnZJdUtGLys4bGFYSzNySlJsL2FNcXdZU01Y?=
 =?utf-8?B?MEJTODZBV2xQaWpPZ0RzaXpNU24xTHFFaEt2bWZWM3Q4dlRkTDV1VUZlQm56?=
 =?utf-8?B?VWw4aEcvbFJjaGFKUE1hMDh4T0FlWkd1ajZKSWUxcnZZTFdRbnZwVjdRRklE?=
 =?utf-8?B?LzZjZFp4b2lqVlZxWjVHUHhpejR0MWxLcnE0eHNkNU9oemhtWGl6elB3Tmh3?=
 =?utf-8?B?TE92VjBGRWpoWlpxeUUwVGFtT2M4dnhLN2lka0ZqUytNMjR0ejJmS3oydFh2?=
 =?utf-8?B?WktDVTd5aUVjR012S2I1Tll4MUZXTUx0RmFnSjAydHMvcUtzTnl1aktvSmRr?=
 =?utf-8?B?cmNIeXBkK2E2dzFsaE50aklKRitpZmhZRVdTTGtHRG13WTNSZnpZUERuR0xQ?=
 =?utf-8?B?bFhET3JzQkd0alRCanBnQUlEbm82d0FGWWxhZncyT3hwSTBhOWsrWEk4Qmti?=
 =?utf-8?B?cDhQQlRNeDdjMndIdDBrdFhZVmVoQ2N4TEtOQTFtTWgxZ3N4QmRPNUlVZ0ZF?=
 =?utf-8?B?QXVaaW1tTmkzRnJkaDNmR0gwMlV1TkZ5TXRCUXIvT01pRWhBUW5uOEczRXpW?=
 =?utf-8?B?TjREQnFqa1pwb3ZIZGxDYW9GM1kwdEhzMEJ2VS91eFFVcCtDTW5yK01GL290?=
 =?utf-8?B?SVpmcUp1cFFSdGFweUJnWTRualJnazhhWXkwMzRDY3NsaUNwbVplNUdhcnlh?=
 =?utf-8?B?Vmc3aGMzNFN3QUNkQzhTZXk2SW5FemhwQWlJZ3BZSWtVT1BxNVhnRFRVTVgx?=
 =?utf-8?B?bllzd2N2c1ZPRWxtd3dkY0FUMEwrWWJJem5OVnQya3EwcThMblZibzNwcllX?=
 =?utf-8?B?N3AwVU9maUFFdldTckV1OVdxZzRPbzFNWWlqYXpJOXVySzVwQTVXTE9WTUZq?=
 =?utf-8?B?TjdiWFVxK2EzRnpYRnZseWNqQjFTZU9JbUVnNEk4cWJqMXp3UzV2VHhZYVBL?=
 =?utf-8?B?NVYzalBaa2xLVFJiNzVWa2tMbVN0eHpyejBvdTlrbSsrSGdKOWd6RHFMTEFj?=
 =?utf-8?B?aFVzR0pHMGEwd2srQ1pXL3FITGgxOEZzSC9tUkRYTXhPaEFRdHM2RXBoMGdP?=
 =?utf-8?B?UjhOU1E4YXFCS0ZKM3RsZ2lLUm5qclVuc3pqUkVvN1BqamxNVXhpV29rRlND?=
 =?utf-8?B?MXlWMXo3d1RXUWJzNUxGc3RVNDVPUllhZHhrbDdFVzZIYWdtRmlqa2ljZDRB?=
 =?utf-8?B?OTZsRGpYcm5VUlFxUHZZT3krTVpkc3kwWEhWVFFkNktrZHdqaDlNVkRKT3N2?=
 =?utf-8?B?SVlqU3hxYzI1R3lZN0I3MkFMOEtEdlM4aHJxc1IrUWdhbjBOOHIzL1NVRHEy?=
 =?utf-8?B?QTZLSDFDcFN0WkdwR2tPUnJ5UHV1Vnh2RFp0QkpaSlZ1dU1UR3QxdXNId2Jv?=
 =?utf-8?B?QTFVZHFJeW5aRjkzakVzeVh6c3VlVG5zcE5oaGlCRmkyMitBZmlkc0t2alps?=
 =?utf-8?B?TEdhVHVwZUpmTVpQUUtpRDZrclhJbGFHM0ZrZXE2eVg3UUJzcThjSmVJaHl3?=
 =?utf-8?B?azlwN0orQXh3a3N1YUNNK1kwWnQreDlDSXAyOUVRQUZ6T2tXUUdnTW0rejdw?=
 =?utf-8?B?eFJnOHhxTmUxV1lETk1qUjc1bzF0Q0FRQ0lXZS9LV0RVQkxzdGhmY29FMXlI?=
 =?utf-8?B?SG1uZ1IyYXRRa21oVmhjVjBJT3dvTWw0dVVZYU9odTUzUHJoZlBnZVRHU2Mr?=
 =?utf-8?Q?kk6RRwRQEDxoxNdEHszjOeXSs?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f1ff47-ef72-4aec-d179-08dd6205e0ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 08:05:55.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ifz67H+tSNEncY4PoZWdkmZYZexky1H0rntKtfghx1o0zJh/2SpsQh0dZj0ejfM9aLxIDW4lXU+K+MqLJIXYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8048
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 08:05:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18181

On 13.03.25 06:41, Badrikesh Prusty wrote:
> Enabled CONFIG_EFIVAR_FS and CONFIG_BLK_DEV_NVME in 6.1+ kernel configurations
> for simatic_ipc227e_defconfig:
> 
> * CONFIG_EFIVAR_FS: Read EFI variable information via sysfs
> (e.g. for checking secure-boot status)
> 
> * CONFIG_BLK_DEV_NVME: Allows to recognize and use NVMe block devices
> 
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
> index 53bee8f..3f9078d 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2022-2024
> +# Copyright (c) Siemens AG, 2022-2025
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
>      if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>      }"
>  
> -SRCREV_cip-kernel-config ?= "e486c93a916cb6f78b4917b7345e8818f96069f9"
> +SRCREV_cip-kernel-config ?= "fb0a224685c6ffecfc2e45ec3e4d84eb98727c4a"
>  
>  do_fetch[vardeps] += "SRCREV_cip-kernel-config"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

