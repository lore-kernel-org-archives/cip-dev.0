Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16715E6FE57
	for <webhook@archiver.kernel.org>; Sat,  7 Sep 2024 09:45:17 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.87])
 by mx.groups.io with SMTP id smtpd.web11.4293.1725702308117506479
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Sep 2024 02:45:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uTasv7O4;
 spf=pass (domain: siemens.com, ip: 40.107.22.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9E3gU0dj2Dq7tdeq1ozuibi5gxmCTXxkuCBeGZzh3+05qh8IJ1gMGfGK3fnehXSEJekTzadoIY1T+w+gP3d8HmJkN8vZ91V9G+AeTz1izTzsL5eEFWroXfJbh/OVx2fWETsy/MB+RmPNKbKuvRMAnzDalYABmlup01Ec/9CnbFejYsD083U1l+WYutY67VgkS+4FBXvyVKpnKKrxKmVDklL5r4SSq6za1H2cu4z0qKs5bMu2bEV1+xQ+ZwEj0ryrN4p2YBLEzhL2diP4ue9JVHcXF72WQjlmnovs6nlisqV+/TQwKePkyJ0qiEuxyJi2B7FJLqgLfENAz7c6PSc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6hGLUqEvHVMDM0F1D9vM1qA0RbA/crs/ZjdbFjP1lE=;
 b=rNiREy+njsBoyz5hsB8cOft5ef0UXfWWobuu9lDNI13vXnYuXXqXPCFbu8b7jHOhEPhr/rZp7PU1eaxf9LGH7kCF6M/hW64JZpf5p9RV997xOYmL7mF/TR18bvKZYHz+BRmBS3MdZT9wcscrWvOv1etcr/BLaFJLI6AnUA0zbLRSqPP58wQuB6/SgNjVegUXpUDxGq4rJikkvkBX6VNhuhX0r+1yzbirbyfTK0csplxXpSMCwxub0bGCZKu4zh32ZZ1RwjwjEgNlfHQ7RCnTcnM1Gfg77S9DvDShz2JgEpya/2UbTaVj+D7yiLfmwuJC/H0BX1ltIcEKWGfUWXsrkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6hGLUqEvHVMDM0F1D9vM1qA0RbA/crs/ZjdbFjP1lE=;
 b=uTasv7O4hn4VSc/w3YfC6e40oLLnN1GrJvD5V54aFj4RcrQwbOIuuVfNu+6PJYtXoCM0BIfZ9SsgrI5Jo9Qz9VNlIS2k+aTQbebWeaLZXCmMJYZTVHmVE3Q3UGHA+JC0zyX2VdFcYpfp5Oe0Iw8cvl1o1V9DtEbOfXStEqjxoKhOC3IQ+i6U04tpLixhIS44DaOjBo1Luro7wauZ/WpLckaNDkyZXwrqWfxY+31xxz1Zi3bnSEWHaU8Iy7j/lojsM74OvYeDrcOfdlGiNPt+isgb3LWcbtpF+zHQ60l5/vk0Dm038SgppORgZ+WwaMBTlLW+WmSy9QFH8OFJg47vBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Sat, 7 Sep
 2024 09:45:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.017; Sat, 7 Sep 2024
 09:45:01 +0000
Message-ID: <7d88ba27-c520-4636-963f-94feef36567f@siemens.com>
Date: Sat, 7 Sep 2024 11:45:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1][isar-cip-core] scripts/lib/wic/plugins/source: Use
 F-string instead of traditional .format() and modulo(%) methods
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <f7a92fdc-894c-417e-b999-16f0c3b1c405@siemens.com>
 <20240905114529.876340-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240905114529.876340-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c524209-70c0-4a31-7cc7-08dccf21be98
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z3pweERkN1hsL2lSNTJ5aExLL0hwMURuRjUzcndVQjVDWkEwNnR2aElSL21s?=
 =?utf-8?B?eE5GZHRGeUFjZzNrdzM5bW9mU0xQWXJZVnJoVW94WEp3OXFOeHlHQUxtTUxs?=
 =?utf-8?B?dXFaTnkvOTQ2cUVJcUVNeklOODV6YWpiUTZ6MmF1dDUyK2NBSjBrZ21tckNr?=
 =?utf-8?B?emNRQnhxZmI4TS9hTFZXWXZpK3dpU3Bvbm5UdkpJUTJGd3c0ME84SGF1RUUz?=
 =?utf-8?B?NU8vYWt4L21yMmtXN3VLYzRINFVKaHRLL0hPejNTUVdOam9PZU9tb0NMY0tH?=
 =?utf-8?B?N2d6eUhwbTRFeHR4SlhrMEQ3bWFUUmthODQzY1FEWlNRUHo5VXVpbDRBZjVF?=
 =?utf-8?B?c1RwMnAydEk3Rkw5dnFwenR5K0ZxU0J0SEkydXY4a00rT254M0tkQk45SzND?=
 =?utf-8?B?Sjhndzg1N1FxVzJWSDNLYkgxcm9HTEZRRFpZU0pmWWJnU0wzZUZiYm5CR2lM?=
 =?utf-8?B?ZDhid2lCVE5QRW1LSlZ2b1h0amoyWUpwWnBENEJ0emNndHRrRnFtRE03T2dz?=
 =?utf-8?B?dWllWmZZOWdpRkhZaDcvNlVBMk1SL05maTlKa0JBMmtEVmxDM3hoeTFiWEE3?=
 =?utf-8?B?dFFaQUhSUy8rclRZNUxVSVdvc0JXZkNwZ2lrUkVCS3NGY3BmQzNUNzNOZlpH?=
 =?utf-8?B?OTgwallOd1hxUWcwdzdJZk1WWmd2R2RxU1JaMmdlcVFzZkl5bkdHVGtYelAr?=
 =?utf-8?B?WGRqd3hxTW82NlgvbXNpNVI3OExNV0hjRUk4QXFCaVNpZUxvYlBNcC9meWJM?=
 =?utf-8?B?OG9nQkhtZmZhRlVTamVyRXF6WUhHdmlDeG9nMXJjRHQ1QUhxY3NyNnRiRVdt?=
 =?utf-8?B?cUdBeC9ob0g1eWdRNkNmVWJ5OGxxZFVGRm1acVVIckR1RzhuWHAzV2cxTUlx?=
 =?utf-8?B?UDgvWjBac2llaFhnaDh2cnpraHNvYkJvOXpRb2hteXdhdGNWbXBHSU5KVFYv?=
 =?utf-8?B?bS94SWlMT3ROa3YxNjQ5S0JoU1JzUkNkTXoya1lyUUFZZ3ZpU0JhSHJrU3ZK?=
 =?utf-8?B?Z1gxNDRKeFh4T3dsOVZOZi9QVnhTMFk4ZEhtRHhxaUVXK0l5ZkIyN1FjaUZX?=
 =?utf-8?B?NERJckZlNU5rdTRBRkRNUjZRWTlXNE01dnNYRFBEby9TMDZDNVkrZzg3ZWlj?=
 =?utf-8?B?bXRPc0FPMkQwMHc1eUliNTVQbXVhL29zNm5TOCtFUzJKUm1Gbk1jS2VVQTNj?=
 =?utf-8?B?a1kybjA5bzhuODhNNEh6SkhqVUU3d3d2ajRBZVlyekpJMFpTYnI5d3JvcWZp?=
 =?utf-8?B?bUJCY1FteXVncE5oeXhYYmV6ZmFTdDV4dW5CVVpUZ0tZSUpPdjFRSi83SHpB?=
 =?utf-8?B?L3RiSGRpOVJrZ0x4VEtHNXl6Um9sQWFnRVNIZGp6NHZnR0hIWmRWUjVzUkR6?=
 =?utf-8?B?NjVnTEhoWkRzcGN5MnhwRmwrdGVjbWZZM21Pbkp6TXBJZFh1b1hkRnhDYXpG?=
 =?utf-8?B?WU1ZVXJmWFZ4R1NnVllGL1ZsUkN6L0g2YUJXQklXSWJMd3Y2L3k5cDdkMHhQ?=
 =?utf-8?B?MisyYjY5aWtzcmNIYWljK0VFQnEwZk4xRjhma3U4UEVZZGU5K1NSdHBHUTRx?=
 =?utf-8?B?bWxTc0lCamQvOG5aZ3JweFRzenc3OEJpdlZCWmpRQ2k3NWRqd3Y3ckRLSXNS?=
 =?utf-8?B?c1VhMllJYU1wSXpMcnRRSXpxN1VEQmFSalBmanR4RTVnUSt0N0Z5OVJZdlVK?=
 =?utf-8?B?WDJ0bFAwZ0JVSEJSVXZ0bFNsSHVsUkdSeTZxb1dCVGJNYnBXcGJZandYNjNo?=
 =?utf-8?B?UFY2aGYzOGplNlNvUG5neU1FVlpEdHVsOFdONFBpdDMzMnJzL0FWT2k3MUFh?=
 =?utf-8?B?OW5NUTdJVzdWUHRyTE5ydz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RC9pS0N5Y1k3bXJOQmJnc3lPRmNNQVZuam5Eamt2azBnSUhrU2JrV2dPck5H?=
 =?utf-8?B?SFJhcXR5SWN4a3p1ZUxhcURadUl6Smp4SHk5QWtGL1lyQ2toY3NCWVYwclVL?=
 =?utf-8?B?QjhUZ1k4ZHpIK2wzTm55SE8wY3JEMTR6ZWwrMmlZVDBSNW9XVWNoK2x5TkZm?=
 =?utf-8?B?alVBTHNCK2pVUFoyL01pWkFBRXZyMElNTkRlQlFrVkRZaGNXdDRDWmJta3h0?=
 =?utf-8?B?V1N2ekIvcTFPTitMbXRTNGIzelYzMHlLc25YaWFnajhSZjd3SmRpR3hkR3Ax?=
 =?utf-8?B?UEd5ZG9ZR3JoTVdDMDZMMzlYQ3d0OHRHL1RNYWRRTFU4QUcvOVMwbE84MGM3?=
 =?utf-8?B?MUhVUjRSZDdza1hnVlYrLzZqempORlk1YVpxNjI2ZXVKZlJST3M4KzZWSTNN?=
 =?utf-8?B?Ly9JR1RVZm9ZeUtxVDQxVnVjTVJvWmZFWWFWUEhVTzZRRnNISk1EYzN1b0JX?=
 =?utf-8?B?aXh2VzlTQU4yM1pGZ2crd1B5Z2ovbDFEUmRHZ0NBMDZGUHZlNVdIZmNnYy9r?=
 =?utf-8?B?NVdRZmhZMWt0OFJ1VEJTWEpJNEUyT1hoVDJmSW1kb0oxTkw3N29uMW5scGcv?=
 =?utf-8?B?UE9lWUhqZjVObktnUEJpd1o2TTZscm9hY3FpRG9laWpIWUo3cWpTUXl2aTRx?=
 =?utf-8?B?d3F2SllrOVBQdGt4NEZrV0wvY0l6bm1DU24yOTFISkxsVXUzQzZDQTd0SnI1?=
 =?utf-8?B?R0FYSDRCcU1HeUlobTNveEtROXdwejhRSDdYUDBSTmN4S0VQN1VUdWx4MmFJ?=
 =?utf-8?B?RHFFQ0MrVWVrVDVKQ0hjc1FlZTN0alhzOGlVcVVxZGxDSEJYbk9yWi9hdWZv?=
 =?utf-8?B?YXo3V2ZUbUNuckJ6OEFJYjlieUwrZ0FOR0hVVnBkZGNvb2JXZzZVVHJNMWE5?=
 =?utf-8?B?Q3RRT3BIWDRKNUc4Vzk4UlFWdGZvVjdlQkdHNEZDQktWWkQ1eCtaRndpNDIy?=
 =?utf-8?B?bkExL2ExT00wM2t1VEV4Z0d6aTJCUlplNEQva1kyaXFJaEZFdXpWcTBsQlhk?=
 =?utf-8?B?QWNHMzM2OHlzai9QME9mcEZjTy92K0R5T2ozWVBYZjF1VVlyK21Ka3I0b1VW?=
 =?utf-8?B?MXQyQ3hBWjJUMFd3NHdsdDVDNTZJc0k0UGVlT2FLZDdKbEpFVmMrK040Wjlj?=
 =?utf-8?B?eFVCd1JwRzlvYTdJTjh5aFMwZDM2T1NYZ3UwczhsTU5jb1BDYjJ6OUY4bnJt?=
 =?utf-8?B?Tmw3MFRMVEcveUtZc0t6Slg3dm56QVhqVlJDM2VXQ05sQzRrT0t4OXdFYUJ4?=
 =?utf-8?B?SlVGRDN1dlk3MnBzZjhSejN4dE92c1QrWTZ3ZEpCeWpWYlFvbGVCZWZ3c0dS?=
 =?utf-8?B?dTMzdWgrS3RGZ0N6aUFLME9oUGdjeUZTQzVuMXVWZm1OQjZSdWhuNUNGSEVI?=
 =?utf-8?B?T0RmZzRWZTlnNjZQcU5rUnpGc1JNeDFScEZOUTJoMUgrVG5EQ3FPUm03cWZp?=
 =?utf-8?B?U3gvRnRpSWw2R2tYcTl1emtsUWgzNGg1NGFGOFlJRmJRNHJ0Z2FET2VueVNy?=
 =?utf-8?B?cXM2cElkeEYrUmRCNGxqb1JnTVNMNWRHUXA1T0hheEYvN3ZXeFp3cDZlbE1P?=
 =?utf-8?B?Yk8wMHhtUURDdjV2UDNjSmlRdGtRMC9KN0EwY3ZHMmlWWlo1d0R0S29yak5k?=
 =?utf-8?B?WFJ0Uit6UmdYdEVaRW9reVBJYmFETXFiRTdFS3k2L3ptSjB4a1hTb0xiMGxs?=
 =?utf-8?B?UG9jNjB4VzRhS3MxUVZVaFVVb3pKdTM3V0R1TXVLakptRW90TXRmRWM0dEVQ?=
 =?utf-8?B?ZnE0bEVaWUZJeDQ4dWdic3NkVkM5ZFhFSkZDN3RaQTBLUlE3V3p3eXRrVEVX?=
 =?utf-8?B?d1NzWUd3c1NWNXZUdXRTYk80WWhtK3hnQlVWa1R2WXpBVG1BWUFVR0Q0R3U4?=
 =?utf-8?B?K2d6RlFNVm1UZGh4aEZUQkJ6eUlUZnR6aWk0Tll0VWVkVjBiQXJJdHV6S3pY?=
 =?utf-8?B?bnR4c0REd2lZMmlydWNyU0l4N3poeUZMYTN1eDFPaVI5aXB4WGNuRndzMzJ5?=
 =?utf-8?B?YVlycU9sWFlGSE9aVytpbTdIZUFhQjlFL21xaDhTeGlWRlVvYUhBUndYVDI4?=
 =?utf-8?B?ckNuYnVOa1VLNG1YOFBZQXBCTVRia0t4aXFXc25uTkd2RkdJMm05RTBrRlY5?=
 =?utf-8?Q?OfKi2y+maqTytC9nv/TvQ/ueO?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c524209-70c0-4a31-7cc7-08dccf21be98
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 09:45:01.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnN+NVy/di6x8bda30zL9e7V/jpa7A4KNVhwWseOqeDL58vadaH4CoV2fuT9X1QhCJHyibDzFJrrF1nVQBP0ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 07 Sep 2024 09:45:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16861

This is v2, not v1.

On 05.09.24 13:45, srinuvasan.a@siemens.com wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
> 
> Use f string for string interpolation and formatting instead of traditional .format() and modulo (%)
> method.
> 
> f-strings are generally preferred due to their readability,simplicity and efficiency,
> and moreover there is no functional changes apart from the optimization.
> 
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>  .../wic/plugins/source/efibootguard-boot.py   | 62 ++++++-------------
>  .../wic/plugins/source/efibootguard-efi.py    | 37 +++--------
>  2 files changed, 29 insertions(+), 70 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 2b06fd1..079fef5 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -103,34 +103,26 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  exit(1)
>              root_dev = root_dev.replace(":", "=")
>  
> -            cmdline += " root=%s rw " % root_dev
> +            cmdline += f' root={root_dev} rw'
>              boot_files.append(kernel_image)
>              boot_files.append(initrd_image)
> -            cmdline += "initrd=%s" % initrd_image if initrd_image else ""
> +            cmdline += f'initrd={initrd_image}' if initrd_image else ""
>  
> -        part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
> -                                             part.label, part.lineno)
> -        create_dir_cmd = "install -d %s" % part_rootfs_dir
> +        part_rootfs_dir = f'{cr_workdir}/disk/{part.label}.{part.lineno}'
> +        create_dir_cmd = f'install -d {part_rootfs_dir}'
>          exec_cmd(create_dir_cmd)
>  
>          cwd = os.getcwd()
>          os.chdir(part_rootfs_dir)
> -        config_cmd = '/usr/bin/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %s' \
> -            % (
> -                part.label.upper(),
> -                boot_image,
> -                '-a "%s"' % cmdline if unified_kernel != 'y' else '',
> -                source_params.get("revision", 1),
> -                wdog_timeout
> -            )
> +        cmdline = f'-a "{cmdline}"' if unified_kernel != 'y' else ''
> +        config_cmd = f'/usr/bin/bg_setenv -f . -k "C:{part.label.upper()}:{boot_image}" {cmdline} -r {source_params.get("revision", 1)} -w {wdog_timeout}'

Please keep a reasonable line length, normally 80 chars, but if it makes
the line more readable, a bit more is fine as exception. This one is
clearly off.

>          exec_cmd(config_cmd, True)
>          os.chdir(cwd)
>  
>          boot_files = list(filter(None, boot_files))
>          for boot_file in boot_files:
> -            if os.path.isfile("%s/%s" % (kernel_dir, kernel_image)):
> -                install_cmd = "install -m 0644 %s/%s %s/%s" % \
> -                    (kernel_dir, boot_file, part_rootfs_dir, boot_file)
> +            if os.path.isfile(f'{kernel_dir}/{kernel_image}'):
> +                install_cmd = f'install -m 0644 {kernel_dir}/{boot_file} {part_rootfs_dir}/{boot_file}'

This as well.

>                  exec_cmd(install_cmd)
>              else:
>                  msger.error("file %s not found in directory %s",
> @@ -143,14 +135,13 @@ class EfibootguardBootPlugin(SourcePlugin):
>      def _create_img(cls, part_rootfs_dir, part, cr_workdir,
>                      native_sysroot, oe_builddir):
>          # Write label as utf-16le to EFILABEL file
> -        with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
> +        with open(f'{part_rootfs_dir}/EFILABEL', 'wb') as filedescriptor:
>              filedescriptor.write(part.label.upper().encode("utf-16le"))
> -
> -        bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
> +        bootimg = f'{cr_workdir}/{part.label}.{part.lineno}.img'
>  
>          part.prepare_rootfs_msdos(bootimg, cr_workdir, oe_builddir,
>                                    part_rootfs_dir, native_sysroot, None)
> -        du_cmd = "du -Lbks %s" % bootimg
> +        du_cmd = f'du -Lbks {bootimg}'
>          bootimg_size = int(exec_cmd(du_cmd).split()[0])
>  
>          part.size = bootimg_size
> @@ -170,29 +161,16 @@ class EfibootguardBootPlugin(SourcePlugin):
>              msger.error("Bitbake variable 'EFI_LIB_ARCH' not set, exiting\n")
>              exit(1)
>  
> -        efistub = "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
> -            .format(rootfs_path=rootfs_path,
> -                    libpath=libarch,
> -                    efiarch=efiarch)
> +        efistub = f'{rootfs_path}/usr/lib/{libarch}/efibootguard/kernel-stub{efiarch}.efi'
>          uefi_kernel_name = "linux.efi"
> -        uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
> -            .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
> -        kernel = "{deploy_dir}/{kernel_image}"\
> -            .format(deploy_dir=deploy_dir, kernel_image=kernel_image)
> -        initrd = "{deploy_dir}/{initrd_image}"\
> -            .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
> -        cmd = 'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} \
> -            -c "{cmdline}" -i {initrd}'.format(
> -                cmdline=cmdline,
> -                kernel=kernel,
> -                initrd=initrd,
> -                efistub=efistub,
> -                uefi_kernel_file=uefi_kernel_file)
> +        uefi_kernel_file = f'{deploy_dir}/{uefi_kernel_name}'
> +        kernel = f'{deploy_dir}/{kernel_image}'
> +        initrd = f'{deploy_dir}/{initrd_image}'
> +        cmd = f'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} -c "{cmdline}" -i {initrd}'

Here, you could easily wrap around after the last positional parameter.

>          if dtb_files:
>              for dtb in dtb_files:
> -                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
> -                    deploy_dir=deploy_dir,
> -                    dtb_file=os.path.basename(dtb))
> +                dtb_file=os.path.basename(dtb)
> +                cmd += f' -d {deploy_dir}/{dtb_files}'
>          exec_cmd(cmd, as_shell=True)
>  
>          cls._sign_file(signee=uefi_kernel_file, source_params=source_params)
> @@ -206,9 +184,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>              msger.info("sign with script %s", sign_script)
>              orig_signee = signee + ".unsigned"
>              os.rename(signee, orig_signee)
> -            sign_cmd = "{sign_script} {orig_signee} {signee}"\
> -                .format(sign_script=sign_script, orig_signee=orig_signee,
> -                        signee=signee)
> +            sign_cmd = f'{sign_script} {orig_signee} {signee}'
>              exec_cmd(sign_cmd)
>          elif sign_script and not os.path.exists(sign_script):
>              msger.error("Could not find script %s", sign_script)
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index 48f7523..5d65ffc 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -73,38 +73,28 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          creator.deploy_dir = deploy_dir
>  
>          distro_arch = get_bitbake_var("DISTRO_ARCH")
> -        bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
> -                        libpath=libarch,
> -                        efiarch=efiarch)
> -        part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
> -                                             part.label,
> -                                             part.lineno)
> -        create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
> +        bootloader = f'/usr/lib/{libarch}/efibootguard/efibootguard{efiarch}.efi'
> +        part_rootfs_dir = f'{cr_workdir}/disk/{part.label}.{part.lineno}'
> +        create_dir_cmd = f'install -d {part_rootfs_dir}/EFI/BOOT'
>          exec_cmd(create_dir_cmd)
>  
> -        name = "boot{}.efi".format(efiarch)
> +        name = f'boot{efiarch}.efi'
>  
>          signed_bootloader = cls._sign_file(name,
>                                             bootloader,
>                                             cr_workdir,
>                                             source_params)
> -        cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (cr_workdir,
> -                                              signed_bootloader,
> -                                              part_rootfs_dir,
> -                                              name)
> +        cp_cmd = f'cp {cr_workdir}/{signed_bootloader} {part_rootfs_dir}/EFI/BOOT/{name}'
>          exec_cmd(cp_cmd, True)
>  
> -        cp_to_deploy_cmd = "cp %s/%s %s/%s" % (cr_workdir,
> -                                               signed_bootloader,
> -                                               deploy_dir,
> -                                               name)
> +        cp_to_deploy_cmd = f'cp {cr_workdir}/{signed_bootloader} {deploy_dir}/{name}'
>          exec_cmd(cp_to_deploy_cmd, True)
>  
> -        efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
> +        efi_part_image = f'{cr_workdir}/{part.label}.{part.lineno}.img'
>          part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
>                                    part_rootfs_dir, native_sysroot, None)
>  
> -        du_cmd = "du -Lbks %s" % efi_part_image
> +        du_cmd = f'du -Lbks {efi_part_image}'
>          efi_part_image_size = int(exec_cmd(du_cmd).split()[0])
>  
>          part.size = efi_part_image_size
> @@ -116,11 +106,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          sign_script = source_params.get("signwith")
>          if sign_script and os.path.exists(sign_script):
>              work_name = name.replace(".efi", ".signed.efi")
> -            sign_cmd = "{sign_script} {signee} \
> -            {cr_workdir}/{work_name}".format(sign_script=sign_script,
> -                                             signee=signee,
> -                                             cr_workdir=cr_workdir,
> -                                             work_name=work_name)
> +            sign_cmd = f'{sign_script} {signee} {cr_workdir}/{work_name}'
>              exec_cmd(sign_cmd)
>          elif sign_script and not os.path.exists(sign_script):
>              msger.error("Could not find script %s", sign_script)
> @@ -128,9 +114,6 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          else:
>              # if we do nothing copy the signee to the work directory
>              work_name = name
> -            cp_cmd = "cp {signee} {cr_workdir}/{work_name}".format(
> -                signee=signee,
> -                cr_workdir=cr_workdir,
> -                work_name=work_name)
> +            cp_cmd = f'cp {signee} {cr_workdir}/{work_name}'
>              exec_cmd(cp_cmd)
>          return work_name

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


