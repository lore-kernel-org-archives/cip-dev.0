Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276F5C678D4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 08:56:15 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.55])
 by mx.groups.io with SMTP id smtpd.web11.19142.1677833766023930892
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 00:56:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MIT3v1hL;
 spf=pass (domain: siemens.com, ip: 40.107.7.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0XqZ0Vn/gnCTp9V2YgmeAenhV6MdmtP6iOwwk6vF1GvfnjPUox2rnorNlYZZ1kWakE4PYNFG39Fu1F/hsfT+awaTkSb/R3fbwFojPb/PK7akU5RXKQBThdKnBeWZtVqTTLuB8oT+W6SLtdQwDvi2PbtaARGwoOnTgW/uywAY2+2Y8X24fIgnFAX5VX6D0koUk5hUFrdkR5w56MG/DRa9rHGstUWSan/iOjh7wlbhTt7ku502q0yyydCODejBcR0mo8zg10WsfKkGnVYDti4S7ifNlh0HtA0Etzw5EA0BMPUprtALtsd8FjwF9CTzAb9V6JOO0+T6bdkstB9KSgJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+er6NZhhsgK/EnOJ1Z5kGmyWnhfNca6j+sTXbI4oLvw=;
 b=QeLgcP1qXpuylJ4Ak63hSSCx0uZvTrFwmqzPmjHityiuCKu91XD1395s34SexwtKmxxUeBknryn1M22RvQ4oAOE3LLdCBVbbeknij20/aq6uMPqKbW/0A/ZNQNW2AaXwCBa/O37g70j1u42eyQxwos/kMwW6Z0rlyJNmuxgeAjHWcpdsk6JAuwCZ9SG0XLt4zvlkUGRmv01mGi+oQUhZLmVjwfJ2ryY7DwMNqYYM+MtyiAvHS2Je8UZdMOvAhQXVFhuxnKdvJEB7ZQq++ithLrqk6eMzx56YKKCJAGTIXhsFTOHkVfcevAg7w6k9q7o0XdupeNtE7i68T0Uc7IQukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+er6NZhhsgK/EnOJ1Z5kGmyWnhfNca6j+sTXbI4oLvw=;
 b=MIT3v1hLoJsqZAJbLNnHn+JvwH+f+XR9iur7uGJvDqoZZ/WEIwI0zBOi6V0Z/JxxWBsOJKLZTfL7dBsImM3IEsYI9JcGI2infA9Rn8Y2r0jOPqkG00T++XhnuNuXWX8C3TCHcgwblLM/17wabkeY5wuhxBC0OZmrurelfXOTtpvIMWLpyivxWDYRXHwfz367PRcyEtXz6KvJ8DVhTf/pYoV1qQML9NqY/TxNPm0qDfUlP3lb5VmpGgocHPZr72gOxOEHDX/8Q16P7Ad+LSWiKWy4PJ4i11XYq1Af/YSSlCLc77QqrQ6t7z/O9eIrEBxOnvpoStSBFusvHrEXl/PfHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.6; Fri, 3 Mar
 2023 08:56:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 08:56:02 +0000
Message-ID: <c3ac6024-9444-67bf-55ed-91f964d6506e@siemens.com>
Date: Fri, 3 Mar 2023 09:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v3 6/9] enhance qemu-riscv64 machine to be
 testable
Content-Language: en-US
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Bovensiepen, Daniel (bovi) (T CED INW-CN)"
 <daniel.bovensiepen@siemens.com>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
 <20230302152659.2096307-7-felix.moessbauer@siemens.com>
 <ee664f4e-64ea-10d5-e53a-87b5773f90d0@siemens.com>
 <e4f08920de44bca9d04ed3b3fb6787d059480002.camel@siemens.com>
 <c58fda96-0e4e-e07b-d4fe-bf06370814f3@siemens.com>
 <b90a5841bee0baa8adf3389f5ce8b83a479a6061.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b90a5841bee0baa8adf3389f5ce8b83a479a6061.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 83310642-90b2-4575-cf56-08db1bc51d60
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KfOxX0hv5+BZqRr12pzjc7SRmdVuYVi724MIOr+MZi/7G+3/earvKEpgX/B4ZNkDie8sR/Lt1N/ws0UaC8eTbBwdbQJHW92ZJXKO+CncWhj2KS3aao8eE8E6b/Jb+DWhbDrKnRv7FLjzK0rNTGXnTSkbYwBnY7wR4juIac/+dzUecx1jKLyjNZ6LVjAtjrlT3le6P5HfhhuNeJRPFwUG7xofOemqt7fwO3pvslajKLz/RLBQytp3pAdr0GOWC23FAXMyu2Lc/RAXrNpItooiaGt1iJXN8btX0nQNjbUc+Tj6v2VQ+ioqCzrSnU2KvXRHqXoK0e9OSIhFDWtaQWRhNLy8GrujEWtDI2JGWO6QMvx5sGrBBxZ/KKPSUG4Hlucwmy2ALin/0qX5i2YwRDgEZuLjWWfC2aRC/7eRDpyPbXk/tNiHpM1NypTjUVBCldgZjzUTkRH1NwBYjashkNo39BAE/UeqLdyfKAKMv6D15p5fIYSccaHQShk+wdLIjLhwdhR0R11AsEukDiEUy2IOan3hf47S7DPr5L2Wm6bPCQxotju3RNIm8HfvfXhv3kNU1rPd4EMHxXQTDX/o8gkz8URwA0XXUwpqQX0KqPfDqDIBbm64GdyWXspNtUUXT0pycQdhRzUcJdNvwiJy+1/gnONcUsANmAoVmaruC4xGsBU5eTflqaY3iNxfPbb1cFIUlCLLUi+e6yJ9LnTNmkgM1+9Na59bmB7VuJ12LRr2DRY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(36756003)(6666004)(107886003)(38100700002)(6512007)(53546011)(6506007)(966005)(6486002)(66556008)(8676002)(26005)(186003)(316002)(41300700001)(2616005)(54906003)(110136005)(4326008)(66476007)(66946007)(44832011)(2906002)(82960400001)(478600001)(5660300002)(8936002)(86362001)(31696002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bndPcExlcnRGZ0VTSGtrUjZPUTdXOUUrRFBpZGFqcmFHTXlaQ0puOEpXM21s?=
 =?utf-8?B?b203c3FycGh3cGlvU0czejZpZmpqN1czdjVLZ2dlejhlVWl4U3VQUGwyOWcx?=
 =?utf-8?B?aDlIZEQvd0VFamJzQ2JoYU1HOGM1NjFYNzVOdEZEaVBmZE5Mdllhc21IUG9B?=
 =?utf-8?B?QkRyR3VsN253TUE1d0ZEU0lqd1NoejZUR2xUYXB1SzlVMzQzcXQzWFIzNXVq?=
 =?utf-8?B?YTQ2azFnUzM1MzhQZi9PM2pJcVlIdU5UZjM0c3JpWThmV3NBNTBmc0JhSTRn?=
 =?utf-8?B?Rm9QUzFka3U5Q3hRdHhLUVkzT3hXbFZseXVtdmNBTEZqRDFUcmNLS1lOUU1k?=
 =?utf-8?B?OXBtOVlXYUJCN2F3TVQ1NkdGb2dISmprZDlqMkJiNTkwdVdPdFJ0QnpsNVVO?=
 =?utf-8?B?QWZtV2EvZzZ1cXpiQndQRG9yVmM4c0o5Zi9pTTFPckdDUkhKVXlTM0kvQ1da?=
 =?utf-8?B?UUQxM0J5cjR4dW5CMXZodUdTTHJhajMvZ3dRY3N6RDVWRzhIdXdQc0pqTUxm?=
 =?utf-8?B?VCsrbUd5SllFT0Q2Nmk3NE9nbGQxd2pmTFVJVkp1S29yVGUwM0NUT3FncjBw?=
 =?utf-8?B?VWkzN3VhaG96L1E2N2s5UWZReDd0VVliSUM0dGVYVVF5cmV0QUFtNUI1Y0gr?=
 =?utf-8?B?Zm5WVHNhTTZKR056VkdCbTA5Vm5zNE1MRTRITzRveXYrQ3VtNXo1bm11cHNC?=
 =?utf-8?B?ZzhabG82eEtITk1sanpFdFd0dnlvank1dmR1Z1Y2ZnZ6K1JNdWdNS1ZmR21a?=
 =?utf-8?B?bnZ0QVZRQTU5UzQyN3BkYVlrRklMcXBySTZmWGZFOHRFU0JuODdHcVlROE92?=
 =?utf-8?B?Y3o0cHFES0JWTzArODYyMTZOenNFSkkwS2ZLNWZrWVNkMkRaV3N2VGl1U1lr?=
 =?utf-8?B?QkV3YUorYjRrZWxhN2s3L2hVOWcxU054aUZEK3dwMEhXMTJoNWZQa1N4Ykt3?=
 =?utf-8?B?V3M5QWZEQTdqR1g4eHNVYnlpWGRzQTVDdUVIbmtEbXZESVFHKzZabS8vc3FO?=
 =?utf-8?B?R0dLZ0gvcCtoWUwwSjd1VStzTFJJWDhZUkdESEgzYTRua1lzejZxWkFQVmhq?=
 =?utf-8?B?Q09mUjJpMmhkeTY3YnNuWWM0ckJMbE9jR3dDYXd1U1Z6aWJLN1IwcUVzMmYz?=
 =?utf-8?B?eXlCazVFUGgybVRnV0dZbHhpSmdmdFdsY3JOaDFvSmRXYVdTcEpTWlhEVFBT?=
 =?utf-8?B?L1E5MmE2UU0wcEc0MzVaZ0pBWmJoc0ZDc05GUWFRR3dtYzV0T0xjQkdIS1F1?=
 =?utf-8?B?N29YMkg5ZWRGaVVHaGpjOUd2VzJNNkpWNHZ0UFdsQUNpcGhYNHlKc2p5cUdM?=
 =?utf-8?B?eG5ERmpDejJqdXZRS2Q2UENzNGRNNDJyNEJNTllEZTRod2xFeTdGYy9nNnM0?=
 =?utf-8?B?NEozRmc0aHpzeVU1enJNVEtVY0tFc3JscEFHRGw1eXFHemlJN3pMRGxMamZW?=
 =?utf-8?B?UkF5ajJlRXZaQzFPSzJONDRWditCVmJmK2tkcUNKMXJHbTRDeDllbTJSL3hN?=
 =?utf-8?B?MExkKzVBai84SzIyZUtmeW1DbERYK1hWZjR2U3IybWx3WFNqUExBOHBYeGNJ?=
 =?utf-8?B?OFJuSEZKTktoMzl1SkVqTkNNR1FjNmNmVnM0Ym9Dcmx3aGwzeC9kZE1HbnNu?=
 =?utf-8?B?SUlDUVdPakpvVFR2MGxBWkNQbXVLejYzMFpaeWdMVU9pQmJNN3FHMlhYQUNW?=
 =?utf-8?B?S3JqSkc0VFR5VGFsbUdtaWEybXFXSjlMYUdhQkNzRVROU1NVb1hnNlBNejRC?=
 =?utf-8?B?THB6TkFQZFBvWlFwZHVhQ0ZpRlJWMXdpSnlIQVZwbEU2eEhRZE0zbkFtcWFG?=
 =?utf-8?B?TnJXUy9YTlR1cy9OUnVTRUxqQzcwcEwxbDBSSGlETGcyNytIUzd1dFdSWVpM?=
 =?utf-8?B?TG1HVUQwYnhxQmszQVcvSWtjYWdSYkVKUThBNGZuL2MrYlJ2cFhHM09OR1hm?=
 =?utf-8?B?R3hGYS82RWdaOUhhd2RJbDluMDVkcTlOSjh6QXVrUi8wOWpHV1ZFdE9MOWVs?=
 =?utf-8?B?OHRPOWpGblF6Q3dQOFFjOVBzMndkZG1wSEdwNWdJOWgzZFpSbmlIc01XL09B?=
 =?utf-8?B?VDhPSE93bjU2QkpORWpXcEtlV2ZhYVVnY0JNdkNDSUFvbDl5VUVJSVlzUTl1?=
 =?utf-8?B?SkRzcnVEMHRJdFNpQ3RIWUozWkpuSTFndHBRSjNXcWpTUE9OSEhBY0ZsS1Rz?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83310642-90b2-4575-cf56-08db1bc51d60
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 08:56:02.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeAhmaQr1LSFqulRRAgMVltu15sXoTWqLQdjmvYkBkDqU9Y+Yz0GbXp9EutuogfuLYDINUJAfhAk6q1VzTcrIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 08:56:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10898

On 03.03.23 09:51, Moessbauer, Felix (T CED INW-CN) wrote:
> On Fri, 2023-03-03 at 09:45 +0100, Jan Kiszka wrote:
>> On 03.03.23 09:35, Moessbauer, Felix (T CED INW-CN) wrote:
>>> On Fri, 2023-03-03 at 08:13 +0100, Jan Kiszka wrote:
>>>> On 02.03.23 16:26, Felix Moessbauer wrote:
>>>>> This patch enhances the qemu-riscv64 machine by adding a
>>>>> reference
>>>>> to
>>>>> u-boot. Further, we now use the qemu_riscv64 defconfig from
>>>>> cip-kernel-config.
>>>>>
>>>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>>>> ---
>>>>>  conf/machine/qemu-riscv64.conf | 9 ++++++++-
>>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/conf/machine/qemu-riscv64.conf
>>>>> b/conf/machine/qemu-
>>>>> riscv64.conf
>>>>> index f1f3e87..8c1764b 100644
>>>>> --- a/conf/machine/qemu-riscv64.conf
>>>>> +++ b/conf/machine/qemu-riscv64.conf
>>>>> @@ -12,4 +12,11 @@
>>>>>  DISTRO_ARCH = "riscv64"
>>>>>
>>>>>  IMAGE_FSTYPES ?= "ext4"
>>>>> -KERNEL_DEFCONFIG ?= "defconfig"
>>>>> +USE_CIP_KERNEL_CONFIG = "1"
>>>>> +
>>>>> +KERNEL_DEFCONFIG ?= "cip-kernel-
>>>>> config/${KERNEL_DEFCONFIG_VERSION}/riscv/qemu_riscv64_defconfig
>>>>> "
>>>>> +
>>>>> +# for SWUpdate setups: watchdog is configured in U-Boot
>>>>
>>>> Is that true for qemu, or is that just a copy-and-paste
>>>> statement?
>>>
>>> Actually, I just copied that from the arm64 example. But having a
>>> second look at the code, makes me think that it is also wrong
>>> there:
>>>
>>> - the u-boot option CONFIG_HW_WATCHDOG is not set
>>> - the start-qemu.sh script does not setup any watchdog in QEMU
>>
>> Ah, I recall. There was a plan to have one, but it was shot down
>> because
>> I was not motivated to add that exotic watchdog driver to U-Boot:
>> https://mail.gnu.org/archive/html/qemu-arm/2022-05/msg00154.html
> 
> Thanks for the notice. How shall we proceed?
> I vote for keeping WDOG_TIMEOUT=0 but changing the comment to something
> like that:
> 
> "Watchdog is not yet supported in our QEMU executor for this platform,
> disable it".

Fine with me.

Given that qemu-riscv64 would be the second "board" to benefit from a
i6300esb driver in U-Boot, it might be worth looking into eventually.
Provided both qemu-riscv64 and qemu-arm* can have PCI support as well in
U-Boot. But not a topic for this series, for sure.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


