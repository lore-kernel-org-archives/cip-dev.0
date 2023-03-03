Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F54C678D4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 08:45:45 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.72])
 by mx.groups.io with SMTP id smtpd.web10.19032.1677833138238451150
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 00:45:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b7acWbTv;
 spf=pass (domain: siemens.com, ip: 40.107.7.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG4e8f3hQd7B/YJeALhXwE09CMAXh/2dvfytQXhEhSNRskQQA3DYL/R66jesrHIXzgB4GkdfWBhcv+3FqyOEnAmQg0B8Vp5CEN8Z0bT41Vt+0/xxEe1Ry+LcAGcHEdlrgi72Dt32m5iFXhIy5NvqEDoh5Qshz7QIBcnhvOCfeBBaJp5sZD80yiFXIf8LAfZjNchAsD31L+hkNnAX0iqWHS8RGz+WwZ0M9bAjbnTCamfzg+7cDMuj6OGuhpC3B7pGC7OXIgn9btarkDRvA4Q3uIZcss3uoTL+G2UNplLkdXnxxkoSPHMSmQFBgq7qz/WLPOPc4wnJkfEzY+0A6k+1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb2+lOsKqfJb52zjim2s6O9D+ILtzuW/3MsmEhpCxSo=;
 b=caCipz493sNuAM9H2hYbHFz9O1XRKDPkHzOYvcnclceb4UX3YrB4bIZ2cEYIy8MfisQnH+m+58tlu3NT/vPui35EFvihsGGWk6jNCb7sCx0O4js00MbN7RQslGt04JFkoHI25pTngz36BpxDgQblTYUMf+I+dagjCofvSkCcxeTogx37m1OTqH8t57i5FlugXLhjWjOp7I8T3lG+LcMkqkac0UEOHRUR6Q9PSxGdF89lgBe23f5EHPxEnIbLXup6Tm1d9laNNOx8MFYFHkvCNq/jwwRDsQd7FNw7F6yVgSXmk7e+xKF4drNBG2xKOyyUVzoYo3+GF48yVT3IlFJRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb2+lOsKqfJb52zjim2s6O9D+ILtzuW/3MsmEhpCxSo=;
 b=b7acWbTvWJh2eyeJvh93b5kZymJthw02/M4pdS+8epV1KDP1fJXLm6MsyhBT0Myi+aTsifO1M63llIzJyP+928COprGCsQX22FUDcJp1w0R/JA+tr2g/X/65Cf2q51lLbfVoVCf9aR3P4nMrRZaT0xCGy52WKkKIttvVGr7+XI6SOn+aD9kCZODp2XtdnYIhnwxSuWbQsaodgCvCjbQcqESZ55SbeuPQVoEefqIAE74d3egruo/DRiUfCuIUsKimHCBPjI4eglDn3gYzc0C2IQEzsQ2s64ky2CMzUNQarw0hzgqYIfwXL8OM7LA9R/maRm7vaBD7Va6Cw7FK8YZgZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Fri, 3 Mar
 2023 08:45:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 08:45:35 +0000
Message-ID: <c58fda96-0e4e-e07b-d4fe-bf06370814f3@siemens.com>
Date: Fri, 3 Mar 2023 09:45:32 +0100
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e4f08920de44bca9d04ed3b3fb6787d059480002.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: de7d6102-8c8a-419d-bbe4-08db1bc3a7ce
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f7KYXNnZfzyKb/ot9hQ5GNotlITuenWK70XoiAjphL6T4TZMEX5DL122squ3ihS8tin3/kvjYjYVIH+lVC7s1fN7pK/DuWUhm+pzEGxzc+FPNuR8GOP5Q6ipzgkZsQRw9z314pfSTQqE7qAahWWZqLZCxR1+mt2JYG9GYY6me2vIdawCRGCRe/AoBoJT7KkDbQ3OsoA/BfqIZvjH8iaKYPKrWO0yiQdo/q2uMOWSYnzOcWHXFHs9/8d173FdPGFqtjEy5O2+jEFaD9CU/ye+hXEaXnqPmiipqXYuRp/1OH26kmNRDXqcFmUJZ5rC6VjH61UePQ3lGwsx0YOq2UDdoHAtOSBBSt33/zwtC7WhkTq1eM3yR91lpi0IjvkFcJw+5sHCmA3TqkOBZgSL4NTxgQY6zTeN+48R/r7Jj3GH0JZDH/R3o2olAmaG0Ioi76mk2ASbY3F4aTXgERgXt7UYhkYELJG5Ch2CS4rGlmoBZ2hjaXZ8NgwCiaf4+qEhN2d/lO43WMpqgG/Gpe93Qy5tz0hnkRDWfiyrhQBYsZ539Vqgh0x5yd4xLT2HZztuhyPikzL3aCyzSFrF0Yfvjs+oIADjxeamOJWTZoPvWaX38DRcR0LOYtQbaHRHAzCm6x4+53UvLep3jhs7R/2oTJHCdc63uEfnQ7w+vlZqKklMSmKy2tQ/MAV6R+pQJcxlxONMFF+WgYsWAujbVy43M9mhI8MN8mTljCXtunIt64kJM0A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199018)(6486002)(82960400001)(38100700002)(36756003)(8676002)(4326008)(86362001)(8936002)(5660300002)(66556008)(44832011)(66946007)(2906002)(31696002)(66476007)(41300700001)(6666004)(54906003)(83380400001)(53546011)(26005)(6512007)(2616005)(186003)(6506007)(316002)(31686004)(966005)(107886003)(110136005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?THJjMVU5dGpFL2NtTDkra1BZSk1RbUNnekFDOFNrZkVmWnhOMEdhMlNTNWNt?=
 =?utf-8?B?N0U5YmViTzU2THRsNysyMkR1eGtKbEdlY2RUQXFtWnRwc1NaTGRSaEF4ekJz?=
 =?utf-8?B?eFZoOUdEWEZtVCt4TVR0MUkwaXNWaG5La2xSN1U4aGQ2SzBPVU9SbG83Um80?=
 =?utf-8?B?a0NJZFRnYjZwUVViQ1gwN1NURWZLK2g1YkV3dGtqajBUUGI1ZGErd1kwRGNa?=
 =?utf-8?B?ZDBJRXk3Zk1xMnppblRRK1d3bWQrRW5kdy9hd3htWFRyQUNmNHg0aG83NldO?=
 =?utf-8?B?LzNlSFNpZ1Nlb2syY05ZTk8wT2lUbWhYVENmYXlFREZCNzNzU0k1RDJQcXBY?=
 =?utf-8?B?NGVhMVJudDIyK29ZSHZvV2tmZlFjUWoxbzlxd2tjUnJRSFYwMGtRbW16QzNl?=
 =?utf-8?B?N3FtWW1xdU9uUGNuYTFKbWZUWWRvNmRmSWF4VmlIVnhaelNLNWc1NGdDcW1p?=
 =?utf-8?B?QkNvZzdnMS9rcnNQcEhqdFUyY3NBWTNmbjFoNnBoam5kV3BlSUI1SE9RcjFW?=
 =?utf-8?B?MjRWTE9hY05FTm1jKzJLZlJDcXlidGlyZjcrVHBsR1FTU2x5d2VkdzFGTHpC?=
 =?utf-8?B?MFBxTWFEWGN2dkdRMlVES0NuZzRWR1NMMnQ1dDYwaWdBWDZNODJweUo4clk3?=
 =?utf-8?B?Z0NKY0NiNStSeVRrQ25oRjY1RnpGa3d6MnRhL3h2L0Q2NDhDUUJtSy9iQ3hP?=
 =?utf-8?B?QlVHd0VEQ2tVSjhRaHBJSjFFSnRadjdmWmpYRkZFUzd4akpjMnYwSXNXbzV5?=
 =?utf-8?B?VHYzeTFuN1MyU20wWHc2c0pkdUZEUGU3dHM0dVFrR25VN2l3a0Z2VisvQWxT?=
 =?utf-8?B?TStxRHVRTmEzSm0xRVhBQm9ZL2k5MDBLeGVFNXNmbHU5N25Sa3FWeXJHT0d1?=
 =?utf-8?B?eFpFUXViYi9yeHlmY0p0YW1kYnZFTFVUcVFNRllNbmp1enBhWUFOaWl5Z0JU?=
 =?utf-8?B?WUYwTUZBdFJxQzhNZHZ6QWEzU01kK3FXbE5YVlY1NVRuV2VZMGp0bTkwaHFS?=
 =?utf-8?B?VlJjSy9DdlRhdmVmYmsvSWNGZFdxRllROTJtalovUW5ORVp4VU93RzRXL25o?=
 =?utf-8?B?UG80R0IxQTJqVlp0WjNaOW90M3ZhTlM5NjBnTU9EVmZ0MXRtYlMveCtHNFNM?=
 =?utf-8?B?azBlaVdLcTY3UDlEREV5ODdnc1Y2eVZ3dkVoaFdtVVBXc3pIWHJULytteXlD?=
 =?utf-8?B?MjV0elZ2MndQK3drMmVIRHhYR09rNEh1WjR2eXUxM1VUSVNDcHJReVNBUU8x?=
 =?utf-8?B?TVVBalZpOFMyamVxNUg0a3pVK2d3M1FBVmlPNUtaQ0p1b2hDYU5tNFJIRjcx?=
 =?utf-8?B?ZVNhTnU2ZWJXNzNCMk53cWErVEhPSkZJekxSajRCU1lKQXR0U1duV3RtYlRj?=
 =?utf-8?B?RzFpYUl6U2NXbWhDUlhha2dqQ1JDVFVvYVI5a01odE5vSlVYSGkvUUxDaGJy?=
 =?utf-8?B?WFBINWtuZlJVQlNnSGxxQUFodnRjQUNGTVZBdFVNRlIrb0I1Um9TeFJmRm9I?=
 =?utf-8?B?RWE5VzFJRlljVkhsTElzR2tCQk1uRUdYVnZwU1ZmQ2RIRGRCOTQrRXBNMXBr?=
 =?utf-8?B?MCsvS204VlNwaG5Bdm1OTkx6YTVNaUR1QkVzSVR4Mm1uY2o1aExWbFErQUhq?=
 =?utf-8?B?TVpYTCtVa3VvaGxyTXRJd3ZZS0NmTHQwc2xBblhzbHM3UmFqSmozQ0hXU1J2?=
 =?utf-8?B?OUdQeTh1R1dLSllvYk9zWTRMRjBaT1BlZmFDMTZtYTVHVFkralgzOE9uZzNl?=
 =?utf-8?B?dE8xUUgrUEFOMHlrVUJIN0RmdWF0STc3azVUQlpGd3grbThObDc2SVliSUlR?=
 =?utf-8?B?TEdhanVDU1h4R09lOFRIOFRLbG9EamwyeXpsR1hPSTVQYzh6RVluSkJrM3JZ?=
 =?utf-8?B?YUduek9PUU96ZmpRRFhSSzFYeldVK0htNGMreFNoS0Fjc0JiV3RyVGlJSjZP?=
 =?utf-8?B?M2JyWU56MU9NMmVoanZva3FKY0dBeWltM3VNa05YeVlJa2FCU1V4a3JLbjNM?=
 =?utf-8?B?ek56RElhTXFsQ2VxMjJ0Q3JoK0d1RG5VMXRkZW9xQkE2cm90Q05GNkM2SU1H?=
 =?utf-8?B?YkdCRzB3RTZHckFoVUdQTGdjczJsWWZNNW1udlRCc3VYU0IvVGw0eGlTUHBk?=
 =?utf-8?B?TUthcVEzOU5TWG1ZM2ZWakZWU1JlU1Rmei9SUmxKaXZrZityOG9XOTVDT2kx?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7d6102-8c8a-419d-bbe4-08db1bc3a7ce
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 08:45:35.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xv7cHDlo47905Z5vfJLENNDqpJWx+2uKiVEjvgHu7QNUFp9H6IzCI3WDowflzA3KwLaxwVk8rHpz1MUGBzI3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7705
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 08:45:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10896

On 03.03.23 09:35, Moessbauer, Felix (T CED INW-CN) wrote:
> On Fri, 2023-03-03 at 08:13 +0100, Jan Kiszka wrote:
>> On 02.03.23 16:26, Felix Moessbauer wrote:
>>> This patch enhances the qemu-riscv64 machine by adding a reference
>>> to
>>> u-boot. Further, we now use the qemu_riscv64 defconfig from
>>> cip-kernel-config.
>>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>>  conf/machine/qemu-riscv64.conf | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-
>>> riscv64.conf
>>> index f1f3e87..8c1764b 100644
>>> --- a/conf/machine/qemu-riscv64.conf
>>> +++ b/conf/machine/qemu-riscv64.conf
>>> @@ -12,4 +12,11 @@
>>>  DISTRO_ARCH = "riscv64"
>>>
>>>  IMAGE_FSTYPES ?= "ext4"
>>> -KERNEL_DEFCONFIG ?= "defconfig"
>>> +USE_CIP_KERNEL_CONFIG = "1"
>>> +
>>> +KERNEL_DEFCONFIG ?= "cip-kernel-
>>> config/${KERNEL_DEFCONFIG_VERSION}/riscv/qemu_riscv64_defconfig"
>>> +
>>> +# for SWUpdate setups: watchdog is configured in U-Boot
>>
>> Is that true for qemu, or is that just a copy-and-paste statement?
> 
> Actually, I just copied that from the arm64 example. But having a
> second look at the code, makes me think that it is also wrong there:
> 
> - the u-boot option CONFIG_HW_WATCHDOG is not set
> - the start-qemu.sh script does not setup any watchdog in QEMU

Ah, I recall. There was a plan to have one, but it was shot down because
I was not motivated to add that exotic watchdog driver to U-Boot:
https://mail.gnu.org/archive/html/qemu-arm/2022-05/msg00154.html

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


