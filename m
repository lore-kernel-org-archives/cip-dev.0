Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA429C05027
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 18:53:21 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.41])
 by mx.groups.io with SMTP id smtpd.web11.19655.1675450397024460484
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 10:53:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IcQdUHU5;
 spf=pass (domain: siemens.com, ip: 40.107.7.41, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSk95oVkyEp9wxgaFQMIW9DXGgD1/hXB7NTAbIh+509vupYAnFPP+J6mLJMGRNrmIe6Q+seLlx0eBaoiZ7CHDUnnsEwM8Y6nJ9QdO0Q9fYXZkz78DweJsp4zBfIquYUZhiB8+1dMakypGN4em3880z/6zJ8CznnPKFiTf+6I/fzb+zNW1ookjJR3l6PmS8AY36ytZmpg/qjnLzzUw4f7ZFDVfB0otGJH28SuGUAxZ4WTfuRXNsVByXQgojPxUVbffT/OeY3rEndTivhiBHMD0cbFy7gYyjPabj5DOX8B/pFM24l0mKKIo4crNx506nk4rQjm3CRScz6bM7nUffnuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYEakLb8X28RXk/2rWfMxyDqjApP1lKDuiZpUiXXIm0=;
 b=GuC0iqdY9wedSbB30z7dk2/de1sCxJJO3F4tEHLcdAG+mUlO70+lJHAPhSTbrGA0yW31VkK1yYOZqj66UKX4TuHFvl4Fp9/2wGT+TOT/cBI2yMd6XrRZf/NsQ+K2m++LuZjDWO5Z2UZVWyc+mfSGsyX8D6ys2qgj26D1FIlbQessmomuoM4wP9Hbq39xhrmkHaSUw9QRbUyPVnyNjF99g0LAoBnMaBM/X2o05tLPbB/ZBTnoHt8j8gjUFn9Hg6t3NhaXm6KawRHSFYZxToc2jG8DJYm0eM3NYKllqZeAK8dlam/DNhwpy7HZ046bLubMYaXM5pNRTOuNOlFGRr3lpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYEakLb8X28RXk/2rWfMxyDqjApP1lKDuiZpUiXXIm0=;
 b=IcQdUHU5S90J8ewBbS983FxNfjrCckotiff7leapVvsufKo3zqwb3c6/dt1GXLtnaYh3gQfC6gDzmBDl/kEOw8D/oMN/7Qd0LVHV6LpO6W+cgrv5dl9WHN5MKnfJpyLp/GRewiTxAcV97nv7F7teg3I1kLJmSkYyAnCByxWHmvgtg14Oes+AmBa3BQ2X4zpBqChZM31QWfNO8a2GlzjRhydlgKtXmEbGUtDPsxEnkqgcZdon4ly2tB1vOCHUmU+lcOz+60RhI/whydhxilv57bLN9WAQ8mKLnRXX497ufUxVtI6L6nxNrvMwxrt/rhA7wmAnx/crPDB1oNBr4sHAYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 18:53:13 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%8]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 18:53:13 +0000
Message-ID: <bfd92d92-fda0-dd5c-45a7-804aee40b0c8@siemens.com>
Date: Fri, 3 Feb 2023 19:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 2/2] conf/distro: Delete
 debian-sid.list
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20230203105142.367778-1-Quirin.Gylstorff@siemens.com>
 <20230203105142.367778-3-Quirin.Gylstorff@siemens.com>
 <cf0d1b16-fb3d-454b-5fd6-fa6f33a7ddeb@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <cf0d1b16-fb3d-454b-5fd6-fa6f33a7ddeb@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: a87d923f-7951-4e1a-ffe7-08db0617e6ea
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pL5qZYXJadUSxf1a82dC5nj2ezPRz36Vg+42f4BuRgNxsX8/Ht6Ctiy/zmeb/Rdrg20Nvg9ehBhW5vZXe01cIw1cLPoo5tdYqLSxh+zNw/0hrMAc7+R8phbjS597aDRstNYisUBP0ctsmXBOjbQpoKQCVADiEmRZc9U9mAt0SIQpUBHt+tZvGfwdUKYgar23Iq3kAetkXgUatbvZZV4AdEpRmyssryjrFAJOzDUWaCu07DcbjR3T1X9LCH7WYlY0PqpVrliO9sCS2dxeAvgfQ5p2yQnUPWIeuP3IWhppqYRnE67ohwU+i1ZYbXt1fVRjqLXL34s9uLAxkAEqAL1xRX+vX51f1zknY0sElWXmsWmmsAHbHLb5Ce1KOHZHV2ZUuS9Lb7HH/E3T5T9+rF8QHvLgxcaqBJCDb/0DuVmw6GRh2U6H5jImCCT0wYDjQ5V3eJVYAhncGLzSsqBU8KKT4kMcPRRwF/fJAbe9G0OizxtuDlc4gvu/pNwQKsEXE4681Ahk7FdmHb3lmAYp6Q44pfK28iyPcX34v1LaHXXuEFfiGrnrpnSXZVWBGTwPNWXSaka1cHy4msgRdMBOXdFtjwOqA/sC9LAhbAB6GrMPdPFxCbKcAXw78+71yYP2kDGtF+2MYFwMG/hyYA47j20gIoBDwRzelmAbKC5QdsQ9Znh8sQOkJDgHkT4pBmVO3EyrS/98EVL2LUBxAenmBy6ch3VZYAPWJakRPBdLZkosUthfjaUQpMAd2miJpY4Q3pbkOILfWMNLOyBkiCnYE5rN6Rq7qeSLcHAMxd0xQKUCtOVb3Oko7YpABxiy9CXj1kyT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199018)(2906002)(31686004)(86362001)(478600001)(36756003)(966005)(6512007)(6506007)(53546011)(186003)(6666004)(26005)(31696002)(2616005)(6486002)(8936002)(5660300002)(41300700001)(66556008)(66946007)(83380400001)(82960400001)(316002)(8676002)(66476007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nm5DRTFPcVdBbXpRazFDTHFYVGFjMk04cHNzek5LTWJCOXVhcnp4YkdyL2VM?=
 =?utf-8?B?S2J4QjREUVZ1U0JIVXVoN3ZGRnZRZUp4dWlqeGVQUWZiR0dIM0FwNWVJVktK?=
 =?utf-8?B?MFVUR1pZc1diZWxTOVFma01CTWl5NnY2cWN0UWk0TW1zekdSL3hMc2pLV0Jn?=
 =?utf-8?B?UHVLc3BwbVdYNnZCbnFzVWdJOFNyNVdEdE9odlNXSEhLampZMENKdTNKQXpo?=
 =?utf-8?B?eE9jTjVKaEgrcHZTTHFHK0NaTFJ4bmp1RnFQN0ZwNUd4MzJwVGtGWHhLZktB?=
 =?utf-8?B?Z2xEbnJKUVVsZklSV1ZNbzBwdXJTa3h6MWJsNHhna3JKY1RSaVFDWkdkZ2tm?=
 =?utf-8?B?bHNzYzg3YStlWFlMUXZQSXZSNE9sVHZ4djlzN2ZOWXNncG1jdDdwN1UwMVU1?=
 =?utf-8?B?WUxxakRtSFNDKzRkaUpHamo5Mmdxb2VBckE2ZjV3UnZNc0tkNnJwNjFTTXlQ?=
 =?utf-8?B?VFpFdzZHMHZ6Z0x5OUNyTE53bGpTek1YaHJidktXZkxPSVhOWHVDa2EzeFhY?=
 =?utf-8?B?QzZhUjRQbjRHa2RwOFFCNXJrQW1pN21rbTVsNUorVHVpbHBRU2w5WitZM1Bi?=
 =?utf-8?B?RDFpK2ltcWxFRTBQYlZMMVgyNjhIbmhYcmpDUXowUWVrVjVObGV2bkdnVHgy?=
 =?utf-8?B?UnR6N0huYUordW1MKzNINkJQdlQ5WFBDcVFWbWh0ZFBVdzk1RldPREttMFZT?=
 =?utf-8?B?RmZZYjRHMVY1dE5YSWJqTzNObWg0blcvWkFuLzE2QlVRbEozZ2JkZXlmNFdY?=
 =?utf-8?B?TE9ncWxQUXo3Z2ZDT2piTTNsbWNEc21SKzE1VVRab3BGZTQ3V0JWUDF0R3pD?=
 =?utf-8?B?OE9WdU41dDc5cmc0RVFOb3JKQ1IrcDZkZlJ0SGJMekc4ZjR6bFhxYXExeWxC?=
 =?utf-8?B?OUs2MmszSEt1MXIrMlBRUHBGeHhnUFMvbk4zSU9NUzJkSFNXVzYvdXMycTFJ?=
 =?utf-8?B?czdKWVRCRy9WVmxyVHBoaFROdmFPZGI0Wjd5djFuaExjaGVPVW8xU0xOdXVU?=
 =?utf-8?B?TEZCdmQ1UkxoZFZqOTM2UnlmMjNDbm5nTE5OSlJ3OXRvOUdzZW8rNmY5NGVX?=
 =?utf-8?B?OUJ2dUo4OFhtMzVoYnFZS2VjUWwyY09zbS9XbHprdXIzUS9LcWx2SWczYnpr?=
 =?utf-8?B?MDJNNU5JbjIwN2V2d1hGaU53WjlXdUhHWllSaEJaYnhCb0I0L3NpYU11WXBt?=
 =?utf-8?B?bGxIa0M5TDFudHFlVjhFd0poSWNCY05KeUF0dlRpNWd2dnlQelorN2ZWZHZo?=
 =?utf-8?B?SUVTTTVSOHBYK1pXTUVqbktOYkN5bVU4c1lDV0VEME5LV3JuNmFOK3VEczFz?=
 =?utf-8?B?dmtYendDTTViNnFzMVFKS3B2L3JBL3hXbzRMbVhNdE5uM21HSEpRTDlxUU42?=
 =?utf-8?B?dEQ3dlJBekxmYlQyby9pRklMNGRrZHh5cnZrVWRsREQ1NmRPZE9saTVTQVBX?=
 =?utf-8?B?WHRWbDhuVmlhYzNIQmhadHd6Y1hKYzhlWGgyTk85UGFHcm5EVHhQdGN4Z0Fn?=
 =?utf-8?B?VXNsZ2FNTi9sQWF4WFpxcVpGWGNqR1hmdnhtOHZJYWN5emlXdWZncHdCRHVy?=
 =?utf-8?B?OEFIbFZDckdWZ3FyV3M3M1h1YWw4OFErQ2cvdXZuZjlmSyt3NW1hNUphSElo?=
 =?utf-8?B?ajNEQ1ZmbjJLZks5QkNrWWtJQUxMemMvRmZRMkhNUXJXNVQyenQrMXQvS3Ax?=
 =?utf-8?B?Q0tFdDBkUkVtL2lxS0RnYXZGaEgvUHVWZG9Hc3FiQ2RyZDJ4N3hvLzFlZm5k?=
 =?utf-8?B?dnY4ZU5FcmFuMlhTZm9jVzRGcVJzMXMySStmL2ZoWnlXWS8rSnBHT1pSSSs1?=
 =?utf-8?B?ZmMrSDZaVDRuZTVMQTNDcDdoVlRkSzRJT1NacVpSOXhYSGVOSWU3NjdKdnl0?=
 =?utf-8?B?eldTVFVpSEJteDBoQmV6V1BCWUl1VldTTUthZnhtYS91QUxiWm1weDVHOFN0?=
 =?utf-8?B?cjFtaUExSEQzT0huZndwUG5tVGhBc1VCUlFKemduSTNiYisyUFRnWTVtVmJU?=
 =?utf-8?B?cndiNW12RlY2OHFwS2lqWGZBdXhWazM3WUVFL2FHTWRlOEVLNTBIS1ZkSTFG?=
 =?utf-8?B?ai9ZdVUyaE90T0ZsYUtyS1krNXl5eXEySG9NRGlLWHBoVGhiODkzUnlVTWxL?=
 =?utf-8?B?SVdVY1UxWkxBZTNzSllVY2gwc08xbHJOWG81RkdoeGxKSlJjQndFbUc4Ujd2?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87d923f-7951-4e1a-ffe7-08db0617e6ea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 18:53:13.2637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wo5COKa9wWfnPHIwmrTz0ZApFNi7T7pkIdagmRa7Ur5mqvEAGUEoIO+9ePqqa+EtqVNsF+mo3+d3di1M6XCPrniqpI/uYl/38O9GB3eYW4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6867
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 18:53:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10589



On 2/3/23 12:05, Jan Kiszka wrote:
> On 03.02.23 11:51, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> As the file is not used delete.
>>
>> This is done to avoid infecting other layers with the snapshot version.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   conf/distro/debian-sid.list | 2 --
>>   1 file changed, 2 deletions(-)
>>   delete mode 100644 conf/distro/debian-sid.list
>>
>> diff --git a/conf/distro/debian-sid.list b/conf/distro/debian-sid.list
>> deleted file mode 100644
>> index 46d34d7..0000000
>> --- a/conf/distro/debian-sid.list
>> +++ /dev/null
>> @@ -1,2 +0,0 @@
>> -deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
>> -deb-src	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
> 
> This is wrong. v2 renamed it but forgot to adjust the user of it. That
> was what my question should have suggested.
> 

Was this every used and what is the usecase?

Even ISAR has no offical sid distro meta/conf/distro/debian-common.conf 
sets DISTRO_APT_SOURCE with default assignment:
```DISTRO_APT_SOURCES ?= 
"conf/distro/${BASE_DISTRO}-${BASE_DISTRO_CODENAME}.list"

``` [1]
Which is overriden by meta/conf/distro/debian-sid-ports.conf with
```
DISTRO_APT_SOURCES = "conf/distro/debian-${BASE_DISTRO_CODENAME}-ports.list"

```[2]

[1]: 
https://github.com/ilbers/isar/blob/73f0cc16ca50f1102084851b1bc0f2d59925c9ad/meta/conf/distro/debian-common.conf#L11

[2]:https://github.com/ilbers/isar/blob/73f0cc16ca50f1102084851b1bc0f2d59925c9ad/meta/conf/distro/debian-sid-ports.conf#L16

Quirin


> Jan
> 

