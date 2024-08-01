Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA2C3DA4A
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 07:26:55 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.78])
 by mx.groups.io with SMTP id smtpd.web10.62743.1722497210380235987
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Aug 2024 00:26:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=m0mbMESX;
 spf=pass (domain: siemens.com, ip: 40.107.21.78, mailfrom: clara.kowalsky@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp4CN1i/WwRYjX/nGr3TM/2tYTSV3c2uJyC/LG5yJyIEVIkjt8Wd7yU8/C+u83bAi4DxykNdTlZwx+Y43pc5LzZWv+MrPXki4yNOfLnbF+1sxCI8+4KhEw1+5aS6jMugpAE1b+1I2axoG5Yhcp31HluN4cc9EVqAz3slC1OcdwtuaQK0eIjxB/O2zZ/Mfd0DksKirpg0yr5iJHZj4WOkLWZLCY2y+w4pnXfSjZTVFt+KOTQJAZ+wvBiqp1Xu4gcXgLs2Ds9quS0u0ii38jVz6QpTMq+h4+97D8ZZ52DFbtjUIgsYOYDUGV8NoHSsNTmNtEzT3dNP+m5w7n75mpArKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PUB67ZSe7Dd/TFFk8dLTbWmJgn7QI7dBuIrew68GRg=;
 b=EstdHB4G4p9Gn8AtvHZ11xogW/J/weM6o4US3Xht1ap0Leg7mhpSfGU31nVnbkJI2NjUeYQCuk80EYeELBgIhdo+0VmAR3XPhwCpv7SiZ9cCktn3Sxy3LZsoqAJZR+qWIbuVorByBUdoPQE43ylu6zHmz3y5tlcx3m0C9B55Z1Xbtwvs24hZA5VUWIGquxTbYTiplUTg8G1LoiTQD8nQfstwUCe3YRkaICdHaiFr0HWhtRvn+xrWPpA+iUQ4bdnMMIZ17rXG0kO8GLzdUJT9x9ItnE8mWpW7jl2p+Ovj6wIweqp8AyZ4y78xGff6QWMJLGwyKEesrXE0EwgrmOXIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PUB67ZSe7Dd/TFFk8dLTbWmJgn7QI7dBuIrew68GRg=;
 b=m0mbMESXXsC4cb6PXZfKlRb5rDvJjarbaHSVvSZQYau6OeQI9r353wAT0nrkkpbGn3IpO5YcnOYlzicSpaI+uhcstMDao+2YE1tvwAxeO6ZSJxwZDhKTVHiRdQ2VCTVFkjI5MPpD0WM2wU9t7/DETGUKjsmm/WIJd1f8tzPdWB6x12JAF8KsVGWEYa5geBk+vpuiSX9ZHbXMQHH93OQSzJ0IkUdZ8UAIP5lW85IPR9CF6XWRXjvmrVug/2LvQo83HuiVBAbZB6EDe7j7G/9WNJcKiftdA13dZz8ZB7DvNCGDg7/jR1+MMVPfq0bF9h7RGOdDVop5Wobu9LLS72rc5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by GV1PR10MB8592.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 07:26:46 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43%5]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 07:26:46 +0000
Message-ID: <f640d73c-8882-4267-ac13-715947002c5c@siemens.com>
Date: Thu, 1 Aug 2024 09:26:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5] initramfs-overlay-hook: Check
 file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Jan Kiszka <jan.kiszka@web.de>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240723125925.1253022-1-clara.kowalsky@siemens.com>
 <50add61f-23b5-4feb-9187-acc48049f12e@web.de>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <50add61f-23b5-4feb-9187-acc48049f12e@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:672::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8173:EE_|GV1PR10MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: e233c572-3daa-4fc7-bb4d-08dcb1fb4cbe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YjJkRjc3YlJvVFIxZTgwWGIybkYvbytqTzFycVd5eUJzY3FpeHZJTDAyZjRi?=
 =?utf-8?B?Y1pVL0VPd25CeW04MGIyYVFNcXZzK3QxbFZnMmNsMjFPbHUwZmpabUUyUmox?=
 =?utf-8?B?MmU2djVnTWdRRGtnV2FGM3h0K3NFemcxclRjYzhlcHpQbEFUeDU3VUQwR2tt?=
 =?utf-8?B?RnR3UkFVYlFRNEM3THkvakVueW5FdmVxNm1CNHlTblN2WHVuc0NMd2p2R3Ay?=
 =?utf-8?B?eXhWeE9zYTYvUHRjaVpsN09BUzhMM1dwTDhiS3FjL3RtR1dvV3EyazlBUmlU?=
 =?utf-8?B?ejNNcTlqb01sUGk2NHVIdjNxRndIdW9pQllNNEZBNE5xVlNLN1JMMVhhcCtL?=
 =?utf-8?B?K1UrSVdpTFdKWEtNSWdrcVlKMzNLM0hJQWFyZThWeUtaaUhVRjhnL2N4Z0RB?=
 =?utf-8?B?eHczYWVhYytRTm1wbm1TbjlTQ2VHZURhSmFrZ0U4anN0ZitjOEtNdkM1VU1W?=
 =?utf-8?B?RUJUS3ZaM1Y5UTlXZUFyRHdrMVdkOEtUcTZWK2xidVpRT0hnSDVTeWJFd2tV?=
 =?utf-8?B?Mm9Lejl0TDYrQTV0Wkdxb3ZQU1pNRUptMFpBYlRzVm5TQmdZOVpqZHJrMDZn?=
 =?utf-8?B?NEp4RVFyZHkxZGJBRysvRVZqVHBoNHlWRmJadk5XZnNaeDJsN3R3RGlLQ0RJ?=
 =?utf-8?B?aTFlZmQ5Y2c4ME5DeWN0M0xyenliT2ltb1BraldYNkFpN2dzcWxaKzVDaUNQ?=
 =?utf-8?B?OEpCeThBWTRNWG53RGxCa0FFeEppOGdsdzFMWHRIQ2pTbnE3RnRXdVdyMTZH?=
 =?utf-8?B?ZjQrVFYvdm1NcGZyT1FCSDZyTUZ1MWVRTmcya01jSDBPaklQZnVGZ3BYQ2Jt?=
 =?utf-8?B?RjhPMnNTVU01MTlIeHA5MWZWRGdneW5hdEtlMUg1cUpHVk94Wm1EdGpyL0ZL?=
 =?utf-8?B?eEdCamJReThvanFJN3I2UVluOGM2VHZ5SVg3dVpOQTFDU1N2dVNCYjNLSzFN?=
 =?utf-8?B?VGlNdjFNRWZkZjIrQzVrS3pwcVZQWlBDdzdacHplc2J4eU5sMW4zM1RXWTQw?=
 =?utf-8?B?bnp2dkdyelRWVWF6WnhCYlcwVDZHS2thWS84YlFhdE5sdXZETWxJWHhRcHMv?=
 =?utf-8?B?K3JOTmZyVy9JMzFZTEhVWnFaN0ZObXdselRPdFVtRmhQZSt4cGVId1V6UVh0?=
 =?utf-8?B?WW9MZzBQL1RUcVhwQ0dEbjhITkhzVDZYTjlhcWxOaE14Y2QrVFRJY3RaQUpH?=
 =?utf-8?B?bXdsTFNMQ0VMVjFURXQ3RkdDN1pBVHY4ZnJvVHpjWlZnb0h5S2hYOUV2YU40?=
 =?utf-8?B?RWN0MWRWczNGSjhWOVNPcnlNSUp3bFp2WVpSako2REZPZnZzMklvTmdVQ0ps?=
 =?utf-8?B?eC9LR291eTBGVjF5bW5MdElTeDBrYmM5dDI2OExscHhRZk40RlM3WDhubm5W?=
 =?utf-8?B?djRkY2hSZGExbEpFdWRuallDeFFYcVdLa1A4ZDFDVGR4NHhnMkJIWXIvZzdv?=
 =?utf-8?B?bitvVDZteXYwblAyazZyNU1RV3ZxU3JkNm5jNkJ1RHlTUFVmdnlGVzB4Vm90?=
 =?utf-8?B?RWIxQ2Z0TkRxSmRLdnVnWWthY05sTmtZY21tbEw2aFFXNTFKQWFBOHFSeE9q?=
 =?utf-8?B?dk5oN0tmdkcyYmtnS0dEMThaUXZITWJ6MCtmTzJFNzlQNXZsZm10Qzl3aU83?=
 =?utf-8?B?TUJ4czFwdks3OHZsS28xTU1YU0hxQnNsU05ISGFyalRmQkFkUWEvSjFjNWFP?=
 =?utf-8?B?YVgxN2NHdkxGa1V6LzR0cGt1TElvejZHM0l3OG1sbk42bVc3YlNMamdTVDYr?=
 =?utf-8?B?disvQmF2QmxRUDB4TExocTNhQlJ0YVQvRHlxTXgxMzYxN1I2aUR1akd3V0l3?=
 =?utf-8?B?UC9GelpRby9IL09hWTVDZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MzFuYjBuVFN0bGtsdXVKRWJrVFJxRDlUNmM4WnBmcTZFVXVDSEhheG54cXV5?=
 =?utf-8?B?VWo1Y1BZQ2o4N2hMT1h0SDlYbGhkOEVkKzd6U3hnakVCc0VLMGF3Wmkwc3Rj?=
 =?utf-8?B?THhiU2o1ckZXQVZsN3J1VDIxWXd3S0NiZnRhM0dVYzhHd3R2Rk9nUlNLN3RD?=
 =?utf-8?B?d0pPdzlpNU1IRkQ2UkcyK09nU29oYlpOamxHZldIemZheTdDVUJ6ZE1mTmNQ?=
 =?utf-8?B?WUg4alROdWxWSnBlZHFtNUJSYlVPTlFIMzBkekdVY1JTemZIaEcrbERBazRq?=
 =?utf-8?B?S2MvUDJkaWI5UzdOTEF5ZkxIdzdrTndNTDJ4ckhnK0ZMalRJQS9MS2t6eWZL?=
 =?utf-8?B?QzJOZ3VzVmxNNkdYc1lGMnVTVGlMVXIyR2FqcWpCaXU2QUU2RGNYUXhXYnQ4?=
 =?utf-8?B?TUNLVndocDlJbHpYSytEdUhOMzFVenBrVFRHU3VZdnNrU3BHdHFxVzEwdU4w?=
 =?utf-8?B?NU4wN2d1d0dwdk9tcnYwY1ZUTlZvTjlONytTK3dVdTZMc3U3Y2V1Q0Vvb1c3?=
 =?utf-8?B?Z2N0V0RqS1B0dWpJWHl0Qk0zcHNJOE96YVp5N0hlVEEwQVB3Z2plcUNDeEdY?=
 =?utf-8?B?RGRLc3NZS2tVYkZOblZTZUdzQSsralN3Zm1kdnZwQW5sZll0eEVaMlRlMk5L?=
 =?utf-8?B?VjJTeXFCcVNwN3gyS2crUU4zNk1UTUhhNHRYckVnOTVsSjZJRkdxZ2Y2VnFN?=
 =?utf-8?B?ZU50TXl1SHBTUXc3Y2YzOWcrVy9QUlVBUkFOV0hjSEZ0bEIyOUxuNk9MY0s4?=
 =?utf-8?B?N0I1bW1sQ3o3aGtIQkxQQXdsR3pmVVAyNDZGd0FDZXhSMFcxbWFDMm9VTUNh?=
 =?utf-8?B?VjRuWmgvWG43TWw4VFlObDBTZVVlVFpsS2Y3TUxSVyt0TzJCYmZPMHdtaWla?=
 =?utf-8?B?MTdSQlVMZXhhRWxIM1BtMEw3Q2g1T2xrTmlHSDlvSkhKRGNGa0VFeXVZbjBP?=
 =?utf-8?B?VWp0ckJEajdaUjh5K1pITWo3OUxCNnU1YkJXUGZvZ0h6Mkc3TityVkJMa29h?=
 =?utf-8?B?Z1orQ3N6YWtKcnVlN0hjVmRET1l5eGdqZWdvZE9VS1NFeVFSL2hyVTdpZXBS?=
 =?utf-8?B?ZDFJS0JXdUpua0lxRlJMdE9McXovSFN1RVRuZGFIekUwd0RMOVk2cjFGMTNn?=
 =?utf-8?B?U1lOMTgwbVVuLzRSSkgwTDF0T21KbGZXb1BucjBQa0FSdm5lTWIrRUVKQjRC?=
 =?utf-8?B?dnlxVEZKVlNEYzdCTVN1NWRwZ2k1eEdyQ0xqakNaRmdNVTl5NUZ4ell1dXhL?=
 =?utf-8?B?OHhUMEhpcTRDOUhrUFJHcnhGWWlHVXp1Uk80aGlrT3U2QlFVdmxCZlNxR3FO?=
 =?utf-8?B?RGhqbjAvWjdsdTNrUEd1RnROM2RwM2dCNmlVamhEakpGU3VZeDViRzdla1Uv?=
 =?utf-8?B?cjN6cWJnengrRS9HL0FRK3BvV25lUU04djFpTUhta1kwaUZnL2tqcERlMDFC?=
 =?utf-8?B?a3BubmFqdUtDUkRMREJxQlE4eDVaeWR2ekRldU0yRXFHM216RDJEaHBST1hn?=
 =?utf-8?B?YWZiM1dTMTAwWFJUNy9wZjQ5czFRVnFkTFVzY080czVSd1NoWkZXdFdDQjB2?=
 =?utf-8?B?VnIzZFd6YnlrUTZ6VFQ5M0hXdVRHKytnMm9HTUY4VkNCTDlrM24yZHg3VGtE?=
 =?utf-8?B?b1Z6L1BCYTR2Q3pQSzBVWWNiTzZWVVRUMFVmbnVibFUwZm8xdER6c2czZXZR?=
 =?utf-8?B?MU9HeWtsTDZFam12bE9QSUh1akg2RmVST2krT2dVZlVucWxtbHlWdlV6dG80?=
 =?utf-8?B?YkV6ckNFSjNGNFhSbmZaekJ6N29aOFEvVkVMc043amVJSU1qUG94cEdBUm5z?=
 =?utf-8?B?ZDNqTGNTK0F0azhOMVhSN1N0Q2loSFZsbnZEYjk5SUFYNkNqUTdTcnlYRHph?=
 =?utf-8?B?R2YwcmJ2QnZKd3YwUFVXbEFGQUNUN2t1Mm5XenZMb2dQR1JnSzI3dkRCTTJn?=
 =?utf-8?B?QlZSZEpsejZWM1dRYlJYdUVLZ3hBUWt3UXBzNWZLaGR4cElNNWUvVlREQUNi?=
 =?utf-8?B?azVPMVhjcElySEF6UnRRUUVhbGV6YTZsY1hTV1FLVEcydEtKS2VYYUR1bHJH?=
 =?utf-8?B?bDVpTDFRNjhxcWdFTFc1QWFGT3RjMEN1TUhsdmpZb1RaSTQ4MzBKeklHZXZM?=
 =?utf-8?B?M1Jyb1hDVEpEZWlsTDAvdGJkTjd3Wnh2MVhTbFYxbEJFMFBudHBLdVRJMXBQ?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e233c572-3daa-4fc7-bb4d-08dcb1fb4cbe
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:26:46.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WN1Eush5eSGsVzzF3WGQ19FLUYH+2h5oNf718a3R0Fj9i6c+1sU792jJ/8CUT4YqRZcyPXW0VI2PHEfnOrRTo7LwzxoUORtrO6vpgUdHF14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8592
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Aug 2024 07:26:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16701



On 31.07.24 19:01, Jan Kiszka wrote:
> On 23.07.24 14:59, Clara Kowalsky wrote:
>> In case of ext*, this detects and fixes file system errors in the
>> partition device before doing the partition mount.
>> If the partition turns out to be broken, the factory state is recovered.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   .../initramfs-overlay-hook/files/overlay.hook      | 11 +++++++++--
>>   .../files/overlay.script.tmpl                      | 11 ++++++++++-
>>   .../files/overlay_recovery_action.script           | 14 ++++++++++++++
>>   .../initramfs-overlay-hook_0.1.bb                  |  8 +++++++-
>>   4 files changed, 40 insertions(+), 4 deletions(-)
>>   create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>>
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>> index 8b00ecf..6f634c5 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>> @@ -22,6 +22,13 @@ esac
>>
>>   . /usr/share/initramfs-tools/hook-functions
>>
>> +hook_error() {
>> +    echo "(ERROR): $1" >&2
>> +    exit 1
>> +}
>> +
>>   manual_add_modules overlay
>> -copy_exec /usr/bin/mountpoint
>> -copy_exec /usr/bin/awk
>> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
>> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> 
> Is there no "copy_exec_and_complain+fail_if_missing"? This pattern looks
> like it does not scale very well across all our scripts (including isar
> upstream).
> 
I have not found anything like this that covers both in one command.

>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> index 42eb59c..c6f69b9 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> @@ -31,12 +31,21 @@ ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>>   ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>>   ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>>   ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>> +ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
>>
>>   root_mount_storage=${rootmnt}${ovl_storage_path}
>>   storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
>> +partition_fstype=$(get_fstype "${ovl_partition_device}")
>>
>>   if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
>> +	case $partition_fstype in
>> +	ext*)
>> +		if ! e2fsck -p -f "$ovl_partition_device" && [ -f "$ovl_recovery_script" ] && [ -x "$ovl_recovery_script" ]; then
> 
> Why testing both -f and -x?

I was thinking, what if someone sets INITRAMFS_OVERLAY_RECOVERY_SCRIPT 
to an empty string? Then ovl_recovery_script would be a directory and 
the next line would give a permission denied.

Clara
> 
>> +			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
>> +		fi
>> +		;;
>> +	esac
>> +	if ! mount -t ${partition_fstype} \
>>   		 -o ${ovl_mount_option} \
>>   		 ${ovl_partition_device} \
>>   		 ${rootmnt}${storage_mount_point}; then
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>> new file mode 100644
>> index 0000000..d13111d
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>> @@ -0,0 +1,14 @@
>> +#!/bin/sh
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2024
>> +#
>> +# Authors:
>> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
>> +#
>> +
>> +partition_fstype="$1"
>> +ovl_partition_device="$2"
>> +
>> +mke2fs -t "$partition_fstype" "$ovl_partition_device"
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
>> index 955748f..7097130 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
>> @@ -12,9 +12,12 @@
>>
>>   inherit dpkg-raw
>>
>> +INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
>> +
>>   SRC_URI += " \
>>       file://overlay.hook \
>>       file://overlay.script.tmpl \
>> +    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
>>       "
>>
>>   # The variable INITRAMFS_OVERLAY_PATHS contains the directories which are
>> @@ -35,7 +38,8 @@ TEMPLATE_FILES = "overlay.script.tmpl"
>>   TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>>       INITRAMFS_OVERLAY_PATHS \
>>       INITRAMFS_OVERLAY_STORAGE_DEVICE \
>> -    INITRAMFS_OVERLAY_MOUNT_OPTION"
>> +    INITRAMFS_OVERLAY_MOUNT_OPTION \
>> +    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>>
>>   DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>>
>> @@ -48,4 +52,6 @@ do_install() {
>>           "${D}/usr/share/initramfs-tools/hooks/overlay"
>>       install -m 0755 "${WORKDIR}/overlay.script" \
>>           "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
>> +    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
>> +        "${D}/usr/share/initramfs-tools/scripts"
>>   }
> 
> Looks good otherwise.
> 
> Jan
> 

