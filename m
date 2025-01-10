Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE29E7719C
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 16:36:50 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.51])
 by mx.groups.io with SMTP id smtpd.web11.23467.1736527000924036915
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jan 2025 08:36:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cV8HeK0+;
 spf=pass (domain: siemens.com, ip: 40.107.241.51, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4NFyCh88QH6nayZAwewZGnmQCk8jAA3yUQXcKYCOX4szgxNy8pzHMnimQ5v80771ikdGDVZph+M0NsBYWl7V1xPmc4otLS+OczqqG4+GxKCEkThKfnZnguR0oUZZaO6KZO7KTVDbmwge3/K6sr5i0pmvUuFAw8lK9nRjFhUaNOdItG9Bh0BnFmfsF919avbCxH8jliHqsfzNLjcBoZ04ab5aAMBZf2iTvGb0STptT/7pjvhW3J65Nj7hXfwTXYgSIi0lGB9UlSXzXNaJ6HfZ8W6pOTCtXOQThX+stcYlsIMSOpCtmBk/9shy+M9JJiHptCSfXLuHuDN0Zx2fna83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1v5tp+KXMMW6Cu2s4KWERNfCugn98VithUtJ0w6GFZQ=;
 b=JT10gy8aemiCo5QN6tsSA/KqJpkg8abUA37qODT8BTRQjkqTjFAPwPSycDmxOnerJd7xoXi1FZqom1bOCeJGgOKrXaCJbRV/TyABS5zFFwe3M9OLPTCJ3mxawjzvTsKvRikyBd9pQ271LmV6W3FKN7H1S8H4Or34jeAPCCsxoSH3fAZKAkdnAD2XIZX9376PW/P35C3Yry/UxokYH3jjLcxENkr6FlmxtmPBZfw2K1Zqnqy0M8qE/2i65wtSf7dqiWQ+x2Hc5JQ/srZuh4Wx4G2uHFTq726rj8++5F2v5VCyHNc5chSVrQjZKiw9Sa2ubfQ5i/f5KLSFqcENaPIyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v5tp+KXMMW6Cu2s4KWERNfCugn98VithUtJ0w6GFZQ=;
 b=cV8HeK0+t2E9YpOmT1ZJfJP5l+540oav7Bh5tY1nhWEkSHEXaoE9gaFBgj47AKf7026TwESYabwBD3vzAUMA7xVXIXcm9O+7wGG2Dd3MEx8CotpS2fxvCjm62kW2zuEcrfvLy3Zfo0kbA1+Acpk6AGViES4oxujME20roebFxC50TIBgZkXnWQzJkJ0+/PouoHdvid9Qrh1zXJhR4/V5BYoRy6YMLp5YLRtGqYPh3dZlqaQp/rgbv/4PBUXpWwbxgM5uBPdAoD5c4OiOow6GnqWMRz2pVZUzsxHfbLHphB5M+R06dYjJ9xi6Zp5KEn0ZpXpcisWcsBbaAPiP8NPMWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA4PR10MB5635.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 16:36:37 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.8356.003; Fri, 10 Jan 2025
 16:36:37 +0000
Message-ID: <63551c2f-48dc-4577-9f20-ab7ba6f45c0b@siemens.com>
Date: Fri, 10 Jan 2025 17:36:36 +0100
User-Agent: Mozilla Thunderbird
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-overlay: fix missing
 scriptpreq
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250110154457.83539-1-Quirin.Gylstorff@siemens.com>
 <134dbe0b-84a3-43c4-a60e-4c7d9c1c2eb7@siemens.com>
Content-Language: en-US
In-Reply-To: <134dbe0b-84a3-43c4-a60e-4c7d9c1c2eb7@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA4PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e10edc7-6318-490e-f169-08dd3194f3d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VUF1eDVjTE9BOFA4YUdZczZLSkpYVVJNK1pKTk9jTllsakhyQkFYU0dGVkds?=
 =?utf-8?B?VmoxWCt5bFNvV0dmOGxrZ05NWGNYQ1lZU1BhUzVlaWJOMXJ0YmQ4V1Q4NXFS?=
 =?utf-8?B?bndEL2FNMEk1bU5JOWtmMVdyWTZrKzRrclRzN1dib1BlNHpoOVhaU1A2QlhD?=
 =?utf-8?B?SXp0dlo5cVc4c1VkVnE2MWovbldKcEM2UVZQaCtrNHpzL0hyMVJ4NnpyOHUr?=
 =?utf-8?B?M1JDRi9LU3pmQXQvQWhJRkNhbEIzdm9yR2NLZVVXbmQ3aWpXNXgzK1daSmFD?=
 =?utf-8?B?K0tZQnNmV21FNjV3UUF3RkxoWTBFZXVBdE1yZFRMNmNOQ1VKTmlVUzJWdTZ2?=
 =?utf-8?B?WDg2djVKYXlUZ3ZueFVMcDhDY0RyWWFqelVCdHFKWEhmZnNoQUgzYW81cUx0?=
 =?utf-8?B?UjNXSElVNFUrUU9GK1BJaVBieW5iNk9iKzVHTHJobCtJNUZXUi9JN25jTWY3?=
 =?utf-8?B?TW1IRnlTVjZlZGUvdldtdGc2a24zTk91c1V6YStDTit0SHVzUlpDTlZ3ODVk?=
 =?utf-8?B?dVFmSUgzZUkvYU03QjQ3YjhIdFE3TDE2VXorTEhsNjljNkFkSXRIYW1ybEtL?=
 =?utf-8?B?d0FOaXFDVGxIWnFsQkU0NGptV1AwdWZrcm5DSmNHU2grOEVvYmNmU3R1bGJ1?=
 =?utf-8?B?TzRLT2F1SGQ5WFFRTGxVdHVEU3pmMkNCU1oxYVhhVkdITzdCb2JQbVpBeDVH?=
 =?utf-8?B?VkpuODYwbUNzaThQVzNRSjVMOVpSdnlwM01sTThHaEZiVjhKTVRsb1hOUjN0?=
 =?utf-8?B?TlVTcEFrMzhpZ3FEVjE0VDBmWmNPQk1kTlFCTW1UQW9wTzduZm5VTVBWVno4?=
 =?utf-8?B?SFFCL1RKcElER3N1dE5YSkhjeSsrcjJMWWtyTlFCZ1lHS0laN0JyL3VBaGJN?=
 =?utf-8?B?bUxuOHJqOG1PVXhYUENiU2hFMnoxNzhpd1Vjdm9oYzV1bi8rS2RuUExiczJR?=
 =?utf-8?B?Lzl2dEpPUkZmUlhzRFdBQUlQQmlPY0p1OWRTS3NIc1JHa0wrcHlZU0RINmtr?=
 =?utf-8?B?dnFvcEJPSlRiMkR3VThhRWMzK01wYUlHTEZGeVlQay9WMDJMQXdrN0NxR2NJ?=
 =?utf-8?B?Z1ZGa3RFek4rSE9sUXkxOU1SekRoTE1FSnJLN1R2NmUyZHVGUW50RUVIQ2lp?=
 =?utf-8?B?bjcvODdwWVV4MWFYamhzR2FWaGNyTm9xVVd6d1ptUThjQW5kYmJaYU9oVHVI?=
 =?utf-8?B?OWl2N1c2bHNZUnFjSG9zWm1IQUFKRysvNVlZM3lBQUlFOVBkeVlUWHJaV0tT?=
 =?utf-8?B?Yk9JTlIrdUtFallJU3IvOXVZYlN0VnR0cS9UYmNyamw4NFV5TnFhZHJCeU1k?=
 =?utf-8?B?SVpvSEFPSzJVTXcvSnVLTVhLcmpVaWVZaEl1endMb3BKekZWMVBMbkdpVnls?=
 =?utf-8?B?WHQrelhwalpIMmpoOXNwZ2xUMWhCeW9RTlRGNzZvcWZXaTl0OVZwM3VVQ2tC?=
 =?utf-8?B?c1BDclcvajU5a1BRSHhVMzJxYmtHWk1aZC9ybVM5UEJQRSs4RGttYnhiMXlO?=
 =?utf-8?B?Y29KeUhhV2RrYkMzeFNCRDRvQ0JHNEM2S1pvQnFTSm5xUW03b3FNL2ZlUHg5?=
 =?utf-8?B?QTdNUUxFb001VEZibk0rcStiODRnTlNqOGRiendydXBOc1AvYnQ3UjhPV2ds?=
 =?utf-8?B?TmZXUDJUM1NITHpETi9nb2lmdUF0b3RhckV5ems0b2I2Q0grdzJaZmJYU3oz?=
 =?utf-8?B?WW9lUlg5UlR0OTFFM3VJaTk4Q3hFZUMvb00wS1dVbWx2Wko0bmtnQ0xEK1Jr?=
 =?utf-8?B?bDNnMGprd1Z6V1hlVjhRa25meFJsaTR0a1hpZ0ZJRUkrdk80ZG4ybUZmdHNp?=
 =?utf-8?B?cHhlcmFBb21KUGtnNWRWT25OWXFMQ2tiZy9mdXFjcUE0bUozSTlsdUlzMkp4?=
 =?utf-8?Q?m5le5V+ZCYdJK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWZUYzQ4bkN6UGp6SkZZKzV0SjdCbXY1TTdvUE5YMWM3M3hoNUF5b1djWXVQ?=
 =?utf-8?B?Q2hNY0VvYjRVYXNNYndpT1V1R2VwODRKWnhZYWlNd21rQWE4bVpDWXBGa1oz?=
 =?utf-8?B?K3F4dTZrc2plaU12Qm9rTS9QVWtvM2VlVm83aGJ2cEpJSVdxZWpaZFhRaGcv?=
 =?utf-8?B?SmpvQjZvTE1NU2ZGK21pS2Z2VVd0MEo4K0hTc2l2R1NNQ2NtYUo0NjRCVFNZ?=
 =?utf-8?B?WkpBM1NNMGNhbktNam9aNVQ3RmFpVVRhb0IvcWJYdDFDc2U5dWdtZlh5RmpO?=
 =?utf-8?B?WEdCNUUvWnZtZjFUUU9SckY3WHA4aU81SVlDd2RiS2UzUm02VXRZUEMrbUNw?=
 =?utf-8?B?SU5TbVdES1g2RFg0S252U0NuYW1yVk5sZmZ1aGw2STZCaytUc2VKU1pDYkVN?=
 =?utf-8?B?UzAzR1N0K1J2TEpRRFNIaVNhSXdIZ2REdUNMNWxiSDRlWWRGcW94L2dBRWxs?=
 =?utf-8?B?dGY1N2ptVGc0SWR1TldaMGFOcTVIT3cwbVFjaXpqbkozUkZsbGhyRVdKbmFa?=
 =?utf-8?B?S1hpd0RoYi9JbnNxTXFLaHJUVFJuU3VzbmNGOFZ3bFgzZTJkNFpDSWhyRzdr?=
 =?utf-8?B?QUMwZkpSOUlpUVZsOHhNOGNWRVhjLzExMXNGUWo3MUJUTVZ4QVh0V0cyWFYz?=
 =?utf-8?B?WndrY3RJeXlPQTlFc09HVVhaaEdjZzlOTmtiUFRtTGtrTy9MMFBSdlVHbFFT?=
 =?utf-8?B?Z0JXVXJsOCt2V3JLcWU5anUvdkpuQUhhcWh3a0VqeFNiam1YTmhISnRGb2JD?=
 =?utf-8?B?dk12NDJ0WmJ5QlgwOU1XMFh1MHdZbVJRYmRBQWw5SlBlT1dSTzdMK2l1QlRR?=
 =?utf-8?B?WDVyVnJuMXllYlJ4d3RtYnBKRk40ZDNldzZPQXdUOURVRnZPb3k4QnhubEZw?=
 =?utf-8?B?Mnlvd0dYYmtvaUpHSGhaOWJGeFdqNjNUUnVNdFlJai9GbmtDK3RBaFBleFhV?=
 =?utf-8?B?S0NFOTkxaE1ycEV4d0theHdmY1ZiNGNJRDRFN0dxMXgxZmtVS1RyemZGZEc1?=
 =?utf-8?B?dWRJblRUZkg4YTJGdi95Y1NSaTdzZjlvNDE5N1JyYTV5RUdFME9RbzJwRTll?=
 =?utf-8?B?c2tmRXdiQ0FNRzZmRFdidkw4NFZJU2grMVVjdFEzck9XQlhGcXhhaVhDYW9J?=
 =?utf-8?B?NkRNcU1jQmtmK3JaZXA2R284ZDl3d0FUbTlYOU1IL3ZLNVJ0cGN5SmJWd1py?=
 =?utf-8?B?S01FWUg2aDlSbHNTbVNqSlJZRmR5ZjQ1L01BdlVFR0VLakdxaWRDR0ZJbzdC?=
 =?utf-8?B?UStLZDhUMVBxc0JVWmRIVEpudWtudGZyN0w3MjJERDl4YVlNRjNYdFd5Wkor?=
 =?utf-8?B?VDZHdHZCQmltU1I3cXFwcStGR3ZLcDVHcnZqVTIyR1BVMFdHcFhJODg0eEN5?=
 =?utf-8?B?bDUyVjY3TWYrUHo4R2FNdkxEdndoTDhwMm5VQWsvRlhYbUxBUjlyOVBKaVpS?=
 =?utf-8?B?bFBEZTVSTVdZeENzQWFYeFd4bW5JbkpSeHV4dmhtL2FJVTNQd0NwVUJERWla?=
 =?utf-8?B?N1RucGdNSWsvVnM2TTFOdks5ZWFLaDJGbU5iZWdJN0hWZUhoQ3QyL2h1MkRh?=
 =?utf-8?B?RUFubjdtT0V0SHNaUm1uM2F5dWdOQzJLcTRCWFRrZENZR2ZWSnhCRjFIRUxK?=
 =?utf-8?B?RVc4dXljZURyTjMwRk5pb3N4Qldja1FmOXBCbk95UVZweFJtcnVqNWFPLzdZ?=
 =?utf-8?B?RlJJQ3BEdDN2THZvd3o1ckZYZUhWTnFhSXlHbFdNcWdCUnFucFgxc0dkWG1V?=
 =?utf-8?B?azV6WHVXUmVIL3R2bmRGd2Fqb2M2NHZyR2E1NWJucFVsUnZZUU5rM1J2dWUz?=
 =?utf-8?B?ZEJUTk9JMWFGSzlJb2JjaTN6bUV2Z3pwOHJ0UUZUbS9kbHIzTmhOaFhXZGcv?=
 =?utf-8?B?b3ZNbktDd1gvaUdNQ2U2czhMem92c3F6aTF5N3I4YjhnUHY5T1pVelQxZXAz?=
 =?utf-8?B?VWFnYUptRmhMOHdyU2V4RUNXQnZXcjVHUWUwSVh0b0ZBMUYwaThBWm1KMGYy?=
 =?utf-8?B?THZNbGVBVklkWnVpd1UzdjhpYnlJSzdkbEJwaVNtOWpPZzBFRTVNU2tDNkJ4?=
 =?utf-8?B?VXZzcXdpQ2RRbEdWM2VjaWNnTDZFZHpHeUVRZjM1dU5KY2tPVmNxODRFME5l?=
 =?utf-8?B?WE05QzRaMlJHTnZvaUtTZXZSZ3hHbWFxZ3RrTDVuNlJqN0FJTEZET3pEU21y?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e10edc7-6318-490e-f169-08dd3194f3d1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:36:37.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Og9Ykrb4L7WVhGZSHeKk1+kG5SVqFrBPcOYS9jmQbexrOaYt+QNCzWHDqCs+5V4SdWHGenva48LFJMMw3DmClq6tmtlET1C+lCgr7+6PBlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5635
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jan 2025 16:36:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17528



On 1/10/25 17:07, Jan Kiszka wrote:
> On 10.01.25 16:44, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> During testing with LAVA it was detect that the overlays are not
>> mount on real hardware if the image is booted a second time.
> 
> "mounted"
> 
> Is this a regression of my refactorings, or was it always broken?

I will send a v2 - I saw it this week the first time on the mtda-mcom.
Could have  something to do with the slow disk.
> 
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb        | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
>> index 56ae8d2..4e2e292 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
>> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
>> @@ -45,6 +45,8 @@ DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
>>   HOOK_ADD_MODULES = "overlay"
>>   HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
>>   
>> +SCRIPT_PREREQ="crypt"
>> +
> 
> This is a weak dependency, right? Means, it will not fail if we have no
> crypt in play?
I tested it without disk encryption.

Quirin
> 
> Jan
> 
>>   do_install:append() {
>>       install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
>>           "${D}/usr/share/initramfs-tools/scripts"
> 


