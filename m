Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A30C77B7A
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 10:54:33 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.63])
 by mx.groups.io with SMTP id smtpd.web10.46940.1685357667033066676
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 May 2023 03:54:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bLlLleV+;
 spf=pass (domain: siemens.com, ip: 40.107.20.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL/2Uxfo171t6d8MIqHzR0jMumA6/uHmK/KKWriJngOWin3Ih7EyKLt4tyebH24G/MMApyzAShptXkOoRvy/gt1+VvhjvcXXWxKrENN/MGk7jnZosRf4NULC8zcWN5LVT1J8qah3NDlOjNDsP2HNCulD2bJGr0oYy6oGDDX9CBPtblK2EoRX5tV/aAyKx3H37eUU6YEMTDkmq3zDKM3287Zlp1+j850CQd2JtYWLz6Wu5dzMvjg75TCOxKIRY5fLXqbWhsy9D8C/T2j0ho0sm7NVXVJyTeFegHwMMecu2scuwNoaP6UFDYbOwAVpXJ0SRohLNdNxUbaNYR5s0RYpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EW+OLicgA9Iy2wKqIhzHk2jSdKFY1hg1PR5IrgQJFg=;
 b=dZOEE2NOsN3mzCZyJxGWT6c8cUyuJqTl1x54uHbHfwAoC338ayBFniifejkVRtyp263o0ENwPTJannHedgLjprxYd9jUJJlnFmhx6eQkpo2m5P5d8zBdSVmoS0FoXi4RhI5uQbB92/gGlQ92adTH4m4VUwmGAxektg77zTBJC1MMFn5QXDQEBHi98rL6sxQBueqrPhoEHxOTTGPHqLuHrd/DSPnCcBfM4fQZx4b60vgRDVJttY03qeoMZ9XeNN5hGHHDmlSZbLDq5FOGCT041VeFeqXe06d34KMG9zrPpvEjK3hOQ9GtXRC/J+O6Ntrody4XvPhF/GZnRXB9f6Lu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EW+OLicgA9Iy2wKqIhzHk2jSdKFY1hg1PR5IrgQJFg=;
 b=bLlLleV+24ZcOdNDdpKRME9IQvz5IhMJtLi6pGWvQAOIBQQ7DJPPrj/dqsZ4NL2ceddkjUUrTz+YW70iBHeOwJF3o0OLNTG5lF43tEhCaCpTXKfEwRUxtPr6jnJGpaDDXPJJ0v3UW0shMz1XiPYbZZJih0+UKtJbqZP6g45sUqHsDpi/HvT6iPWPkLcLQmZgSbrvxoc2Xn9NLQFwvNnicvH5U5ohXFs9h51RMatc4tga2a2/BHEAHnhBmIam4YO3x80FEA0mAnjKIUFlHppctzZlIQPEA6/EdwUkzmr3X8g85//FivS3GrVE3ij970llzs0rbUU9e0dqz9QFA5nSlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7262.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:449::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 10:54:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 10:54:24 +0000
Message-ID: <0ac9ef71-1f51-068a-7364-d119424b5bc1@siemens.com>
Date: Mon, 29 May 2023 12:54:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] squashfs: Calculate a smarter default
 SQUASHFS_MEMLIMIT
Content-Language: en-US
To: "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <46e8b3a2-128f-c63a-cbfc-6d38a1792a35@siemens.com>
 <5728b6ca-8c6a-9eb3-3926-e99cf7081414@siemens.com>
 <77f15adc8c93fcb3542abb215f00a7ec93f1bf17.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <77f15adc8c93fcb3542abb215f00a7ec93f1bf17.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b3a748-ca9a-435f-5ef9-08db60331086
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iOsC3aS1Ldngas8T85AUpHA8cDfNCnzFc7cnsO6IlF4B8k+ojFcOuu90beSmopT0ye+Nt+0oJ4Sa5PA9RELMIDO6QjSh7uqLnwsjWRizyNFzpl23Wmd/j3dO0AgEmKRi2IrYb1cM/rSYPx0VTEmv97rTWtFMVo/iRi5tK1i6fZkNPxfb9a7N9CnIkIg8yn3/rQ+bsjC3oK4VmrMWJLsc+LJT6qJNdhtq8lpEcZK5C8+bHoPOkE4lH+7771i0kufzukudkAgQldmLrM1H+brj8lqGE4kNSrDwP3WUn6R4G+UbRXyPc+LQTimdDNUkBtoPpdnMCndz88+e9i04eLfnWjYjzYpYjUfhDsA5PTbi6cDxYOhPmCYNzSt/DuZ81+6sQovnX2IDoWsI8XhTrFDUnQ+1IxE41x4954fhNuzUf/umpxD9aNzNjJ27GFTKZBCBu5zWvduOU5+8zwFdiwxWQETd5dmVIJikR8iDSeKS94e2aeOpBwwgBVBdsomy8yo7SzI2uITHyodKHtm87TIMpupTC5fDdKFZXzOkb2L6WtIzWfBPaBVawUBV5aKU0/NSHxR3WxU+YXjhC8VYpdUvchsBEZxRvcf/QA+a99qtxU0nmx6PtjFDnj4JJ9X/vkYxg+NqKsUh/Nlthvfbo9askA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(478600001)(31696002)(6486002)(86362001)(41300700001)(6666004)(316002)(66476007)(66556008)(66946007)(36756003)(44832011)(5660300002)(186003)(2906002)(53546011)(31686004)(6506007)(6512007)(26005)(2616005)(83380400001)(8676002)(8936002)(82960400001)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y1Z3OEZUQmt6dlg2WEJ4ZDRzcXY1UFgvMlR5azEveGk3T04zSXJyalpMb0JZ?=
 =?utf-8?B?Skl1Q3pQNHdOV0E2akRSMWlRQUNrU0J6RGgzQjA3bGs2ckpBR1VzU1QwMSt5?=
 =?utf-8?B?NHlaUGpjODZ0UnR4RHJRakE3NDF6Y3hPQm9yY2ZOV1RvRk9NNkl6WXN6dEJO?=
 =?utf-8?B?Vm5ETmp0cXA4ZGFTdWowMGRVVTIrdHdPRlJGdGZQZUs2Vm1uOTFJOXkyeldr?=
 =?utf-8?B?U1NmMHoydllJNXA5WlNOaFRBbmYreURtaEVsUEp0dGhjUTI5NVdzNzRIdkdC?=
 =?utf-8?B?d2hPZGJoNjFzRzRidkhaY1RiZ0N1YVAyZDV2MThzK0FNb3FqQ0dKeGRsSklJ?=
 =?utf-8?B?aDEzWVN5TTRaT1N5YVJ0aDZrUWpmcDFhY3dXTERXWkJJMnhUZDJRSk0xZ1F6?=
 =?utf-8?B?VWdjc1NrWTNOSWJaZjcyblYzZWJrSjJ3Z2U5RjcwOUEwREU5My9UT2dUcnlT?=
 =?utf-8?B?VEYyRm5lNWV0eXd0OEVTN1NlRTVXc29KdDRub2g4YTF3TEYrSDYzazlHUGR1?=
 =?utf-8?B?UG9oUDljWUJBdWdrcm9wZ1JZOHR4b1B4Qy9qV2VBaS9VVHUvaUZKd1VQc3pr?=
 =?utf-8?B?T2lUckZaYjNmNCsrRXQ0bFBPbG0zczNvN2tpY0g4SEEyOXJnMEFzOS94Zkl5?=
 =?utf-8?B?MkxUVzRYRG4wNDQyM3F5TCsxcUh3ZENzbnB3UkcyVUZ3R203bGRHd2RZb2lr?=
 =?utf-8?B?SVV1Q2l0NWxqUno5UTVlZGQrUzZoNEtnT0ExUHVyYzl1OXZzeDYvNEVaMExR?=
 =?utf-8?B?V1dXZzRTRU9sdmZZVE9KQVF5L3lyQ3BBR2hveU5RU2JqVEFsNElXZjNHYmFB?=
 =?utf-8?B?MEJ0c1IyWVhTd25XZStmbWlJMGJJZEhaU1ZTRk5GWDloTlRYTmpWWk1SOGE2?=
 =?utf-8?B?UUlLaGpIOFNscVM5RWxvOWJEM2RlMy80UzFvaTk4ckliblBRQk5jOExNbkVN?=
 =?utf-8?B?MlZLYWFDV0U3RVd5TEtVTlpMcmZWQ0tWVkQwZVZHYUg2Y0t4MUVLdlRGUHlz?=
 =?utf-8?B?L0J2RjNUVkkyZElRZTJzOXQ1cURGSTJzRkx5TmtOM1NxWjh2WGpuWlBXRjFq?=
 =?utf-8?B?NnkyS011Y2RVVEl2aHRmVjllNnVpWVYzSk5UQnM3amFFczNocE0ySE00ZkVC?=
 =?utf-8?B?VS9XRTZoUGNpRWd4dUZvRlRXSC8vRzZVOXV3ZTkwOFNqUmxJazk5dit6Q3Zh?=
 =?utf-8?B?TFQwSUhLWE5XZjJxcUloQXMxZ0lUVHBadjdoNmxuNG4vZFBCWFpBOGp5VU5u?=
 =?utf-8?B?UE5MNDk0T04wTWlqY05VTHJtQno1Rjh4K1F4ZU51Wm1hZTlIWHlRZUtuTHBR?=
 =?utf-8?B?S1o3eWNQeUVmanpGNzByRm4zWXlzQUdGUEdGcXlMYUVKZEtCNGwvSnVHbG9z?=
 =?utf-8?B?eFhLQWRkTFRlMFhZY2ZDTm9ocEl3RDNaZVgwbnN1dkxFZkUrWkxDSXYreGhV?=
 =?utf-8?B?TVhKUmtLcXE5Q1NHdlBERzVJYy9nVlhmN29UdFgvOGdJbDFpVkFLZDc0VGNH?=
 =?utf-8?B?Vkl6UFMwN1pyK0FLbktCTFVPalJOQ01BS2o5M2pOcDFsVmpmYkVRNFV4K3cx?=
 =?utf-8?B?WFQvTTFqRmdmYjd6K3VLZi9zTnl3ZWlxc014VzVmN3VRZzBKR3FMZWZVcHFV?=
 =?utf-8?B?VjNheVZaWE1ZZ0tvLysvOXVDVFh2bEd4ejJTbTB3ZUhob01oRjB0ZzNuN016?=
 =?utf-8?B?UlVaVmVyYVV1a1JrSVY0clVoOHhJc2hLZE1vVGNuZ09pYzlUdlMvS1JkZDd4?=
 =?utf-8?B?TkZwRG9hUDJlR2FtSThlRzZHTUhOU3Q5T2FIZk5IOW5WanBaM0lWVHB6Y21Q?=
 =?utf-8?B?SzJwYkV1dEE0TTVHQS9mWXd5a3VZSmlxNU43QVRCOHBlWHlZVDNPSCtvUXFM?=
 =?utf-8?B?WmMwRURXRkl0NjJMdnAwV3VIUGxIdG95aTNmS1plMGRWaDJQOXExYVRVZUFY?=
 =?utf-8?B?RmFjcmJrcWRBNE9WQ2dqUHBvYW03WDVNWHROa0J5UnppRll4Wm93MEk0d1Ay?=
 =?utf-8?B?ZkNUVkNBTjRjaUdaaFp4R0luaTlFMHNqQUZaMW5XRWh5SDRFeFp6ZTgvcXJ5?=
 =?utf-8?B?c3RVK1l1ZFArU1VxSUwwTG1BU3dLUlk3RisybCtCQzhjWnR1MnZmam1FZWxv?=
 =?utf-8?Q?/vSIY7Wm8llJXo6NsOJgEAkeE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b3a748-ca9a-435f-5ef9-08db60331086
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 10:54:24.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1176Sp1UJ0JYv4S2Tx4jgZA1VyV/IKmy2rL8oBHIIC7vScnSAunlICU9PWQjwYcwWUMNBEac7Npdb3LauP2hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7262
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 10:54:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11695

On 29.05.23 12:27, MOESSBAUER, Felix (T CED INW-CN) wrote:
> On Sat, 2023-05-27 at 18:48 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This should obsolete most - if not all - manual tuning in constrained
>> setups.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  classes/squashfs.bbclass | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
>> index 1f2a7595..b39be0cd 100644
>> --- a/classes/squashfs.bbclass
>> +++ b/classes/squashfs.bbclass
>> @@ -9,6 +9,17 @@
>>  # SPDX-License-Identifier: MIT
>>  #
>>
>> +def get_free_mem():
>> +    try:
>> +        with open('/proc/meminfo') as meminfo:
>> +            lines = meminfo.readlines()
>> +            for line in lines:
>> +                if line.startswith('MemAvailable:'):
>> +                    return int(line.split()[1]) * 1024
>> +    except FileNotFoundError:
>> +        pass
>> +    return 4*1024*1024*1024  # 4G
>> +
>>  IMAGER_INSTALL:squashfs += "squashfs-tools"
>>
>>  SQUASHFS_EXCLUDE_DIRS ?= ""
>> @@ -16,8 +27,7 @@ SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
>>  SQUASHFS_CREATION_ARGS ?= ""
>>
>>  SQUASHFS_THREADS ?= "${@oe.utils.cpu_count(at_least=2)}"
>> -# default according to mksquasfs docs
>> -SQUASHFS_MEMLIMIT ?= "7982M"
>> +SQUASHFS_MEMLIMIT ?= "${@int(get_free_mem() * 3/4)}"
> 
> Did you test this regarding reproducible builds?
> I'm almost certainly sure that this will break reproducability.

If it did, the current version would do as well because it already
encodes the number the runner CPUs into the squashfs run. But why should
the CPUs and memory size influence the output? We don't specify
'-not-reproducible' here.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


