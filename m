Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E41CD342F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 05:44:36 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.19])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7162.1778219071648758220
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 22:44:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kaiAwYem;
 spf=pass (domain: siemens.com, ip: 40.107.130.19, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpLCsEVXdSa3w/+7pwd1MFDS2GY/ytdTAcp274vxUYZA0ZebtwmUKiFOylVOGCuP1apQxQpSjTSplxSutWXXwd11/sYSRekB8shqCEladD5hYjtf+8qGOd+2imdi6QQ4uRwLhY2AUq2OIYKJxx+EJlkRWhvTLsf6uJn+J0YRL+7Kyfd30f0XN1CMImGmkp2zpiO9wP8A/S4q+6SiE2NfR9QKYYElvHPm9MQyqxefKFN8N4msS7mDOagifcG7snCWeSLZvIVBzw87I9Z8fQmPb5qhl7vdqbB7fau+JGxc27DZIOu0kpm51LkbgV/HjYGX5070S3UVpwW9TL/BactDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lOidv7WvGmoA5HLCiVUfkB8xi5IeimsHKGehF1Y500=;
 b=N9mVwTn45SuLZNcwDioGDiEl2CNbdxDEX9dBQ5uGlUri2EgSVrAbW93b1PkLmXjlJemwVmnk1z4Mvg0JRjKA/5iEBGoKnYClYPhAJYdpvjDiJitFgzhPHQa33Hh7BcNaP3UeQG1xlJja6LxSXdG+IDoAP/avnq3uSFeY+QKpuuQeeadXoikRKkvQfaDi9p2kVgn+HxA5nWA9sAz/iyLC8ilIvkI3/94ciWjrMYsrtyM6aSkgXrUlQspss3nwpDNqmU4DGAulIQ9KqutCizJeuEgpu2vpSfHoX1ohP+88z4u5UeTqZ3L9nE8yluyHk916Fr+cwRm0hxMuekYXx3i19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lOidv7WvGmoA5HLCiVUfkB8xi5IeimsHKGehF1Y500=;
 b=kaiAwYem6Evlf2VacjnqwFlne8JQ/O811lG4LwhZ1SvrzG3XCD1XJVSxITlYFz8KQuaWIFB7q3FAb8K1rv5m2txVgEMuW9TZAdZfRDSL0rJFWT7mgD6z9vEAzESFZQtdZH3bjbuiIWydo9+RoQ9A+pIcuR3sVbSeA8rVTdKEr0BJwpwPMWeeSdQuwbfZp/F0hADKK7f98myAmzM4NGZRmXIy4N5FLpEl2unclsW3S+o6VtUK1YYOt9EW+CGvMef75XJzoX8myWgXkgE/zQOzve8kTmxac1fONKFW9lZ3dZLyjzSF5OpFNFayAaAsbxl8o2i6I3iPQsFrLcofR0x4+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:446::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 05:44:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 05:44:25 +0000
Message-ID: <891d080a-c5b0-4cc4-8141-f40560d964b1@siemens.com>
Date: Fri, 8 May 2026 07:44:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] lava: qemu-renesas-01: "client version 1.41 is too old"
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
References: <e4be98a1-10f6-4b0f-9e5f-b990be2204e2@siemens.com>
 <18AD50B115979D9C.2359280@lists.cip-project.org>
 <OSZPR01MB8123A5AB3F64208BD0E653E2B73C2@OSZPR01MB8123.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSZPR01MB8123A5AB3F64208BD0E653E2B73C2@OSZPR01MB8123.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8dd244-2b3c-4f81-b85d-08deacc4dcd6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	eDp0zUAULAlhmhdVZ0d6V+C/HlJnqEM3H+VOHfGlng/aeITyOGV13aQz8ZsZlS2ySqvN7Gq7WKgcq443+U6LpH20F8SqRATJ3A1fvRNeheBYGtmQsvSSYqjtoLYO8R1fkTXPfaRuOiRcRnxIJ3am1zJtcJ7XnLFCtGhSn+aplI2OSuN3y7+0J17L/6nZFuLVHoCSmWoRLjdce/hTHyc7LWg/+leJ9c+vy6cuL7iFG3uocaeZFLS0WJEHYOFF5uUDChMagdv8d5RPK9+31Ebnp7H1w7TDdtIHJ3kFAmCswBUxZk0FxXkEws8fknhFkGm13fLBHmP5+Br2Q1dKcJe51s/h1sRyTE7E5GbYyADYgpvdqE0IaK7wcGwvJ2Q+OdBYP0v9gRj1rk41boOXYCahriWqZhvg6dwHlNtNF40rpppyxuwSowWOmwd9gjDB19AtJs+P+qfgUSavZdD+irGYqYhYaxE69zCuiLeVDbwVCxh51j67j90buyPVxnMARw+CEybgPEapmV+sIkX3pgOS7ROS3/s/c8QATp+grebus8HbzQg15STxgP0sLNl2oZXtCH8J61q4zAx0E0yD7GlXHIRPV5mf3k6RjJ5RWkzqIDS58t5qXqDVQj14wx0ks65WykzQDnW3eXeJBAvHy9e/MA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RllvNTg3ZnZIdnJod1laVkxjUi9KWG5mRUJoVWhHajFnZ1VtK2hDL0Y5RTY1?=
 =?utf-8?B?bmZCcmtRYUlMNFVLVkVnQys5K1I2NVJYbDYzSkVxbWtReDNDdWFjMmFVWDZC?=
 =?utf-8?B?SnNlWCtOOGNiMzgvTXVGTzZHam4zelFSTi85bkdlMjlTZHY2RlFiSFBvOUJ3?=
 =?utf-8?B?UDUyVDZ1SmJuZW9jMzFld1NIOWhwTUhpYWs5TE1DMU1XYkN5dTEzTW1IVis5?=
 =?utf-8?B?SmZpYUUrd1M3UDBLanBSSkhQZHJrZ0hYNHkxOStDajBCU3Q3SEVRZ1p0RWpN?=
 =?utf-8?B?K01XSFdFaHYrNVZpQzQrZm5xL3ZBWmpRbEtLNEwxcUs3Y1RHdjhhTUhpUml4?=
 =?utf-8?B?WFR3ZVIyZlk3Tm5JWUlmanoxRVpYQzhLRXhqdW10bm9lNjhDYW11dWZnTi9Q?=
 =?utf-8?B?NWE0b3g0c0tyUmhPS2w2L2xMa3N6RGdXUFdXSW9zWFh1MHhRUEtWajFaS0lX?=
 =?utf-8?B?enoxbEhETUxQVnFGaEltbHBtcnl1S28zRHgwR0NZc3NPL2VsZ2RsQmo0NkZI?=
 =?utf-8?B?cEVqZVpZdVpMdldnRDl4MDRGb21UM3M2VmowYTlkVDdxTlJnb2gzcTQwR3h1?=
 =?utf-8?B?bldoaUhYMDJLNVJnM2xSRlJVemhmN0dkaVNnWWJxMC8rU0QwN2Q0dTVwaERS?=
 =?utf-8?B?VDRSR05BeUpMeUsrcDR1Zk81ZGhTMm9xSHhVVEVjWDJHbTlNTWk3QlBmS01y?=
 =?utf-8?B?di9xT29vNWc0clQvWUZJUkk1dHhqWCt2M3lrVWlJRXo3SXU4N2NTUWl5SzEv?=
 =?utf-8?B?eERuVXk2NndOaFRKbyt6bEVQeFpieWprV0VTUi8rTTZCc0gyZ1JvcTd2aklL?=
 =?utf-8?B?OVIzNHQ2Nk0yL2twMlVwOXdWSWRqZ0VHbkhuRkRHVTgyYzlPTy94WEtkWXZ0?=
 =?utf-8?B?VVNBdFI4ZHNPcCsvb1crbjM3dTFadTRzbzliZGw4eDA1ajFaRmhBMmN5dlpX?=
 =?utf-8?B?VEx1c09YdlNRZFpsWExyYWxGOXkyMjZpZUQ3dE5kelRRLzA2YzVxZnc2cGNu?=
 =?utf-8?B?YkIrWXRJa1NidVYyRUkreXJVdjRKcjB1dEFuS2dIV09GeTFGK3JiRkhhRDJn?=
 =?utf-8?B?a2RSUTBaU1ZwWThsTU1oMllKOXp2dFRGeTl1eWozT1ppTGdmZ2s5VW5CTHNP?=
 =?utf-8?B?SDFnMEIraGxxNjVvWE96dmQ4Sm8wWExtVE1xOUxiWVozM0QwTld5Q0hScVhP?=
 =?utf-8?B?SDdmZ0dFbWFMcU5GVFlBOUs0N1JNdk9iQVRTSnd3S2F2NXZtMzIwTUVmbUpQ?=
 =?utf-8?B?WUFNQUZ4dGNRSS9qZUxocTJBSkJjTVYxekJrMHB1TlJwZDdqRkRBS1QramFY?=
 =?utf-8?B?MzhtV0ttMCsrdUh2NjBOSG1FNVV2cEh0YUxqY1lPSk5FT2U3bi9QbE1pY2Nn?=
 =?utf-8?B?cUVBdDVGaDRMYXN4ekVwQXNvK1RNemJKZFhiVi9sWDNyZXoyL0RnYzBYeGpV?=
 =?utf-8?B?RGppNkVZa25ac3VWRFZsdC9BV2l6K1hXQzJITFgxY3hiNTdXT1NQbFhVSlpm?=
 =?utf-8?B?RXk4aXBGMW5XZ085WTFjUnhnd0lzbUVNYkZpdStRLzZFenlOQVhNWmp5REdy?=
 =?utf-8?B?S0F2MlZLK2ZvekovcnJxdFVuRnZNVDYxemIzUTRsMlRjVTF3cGVjVlJYU0w3?=
 =?utf-8?B?NXkvSzhzaGkyMkdEcHA4RUlVc2djSVNCdExSUHY4bnYwbzROUERObC9SK2F0?=
 =?utf-8?B?ZkltUjJOWVVTVTNrbnZXUHgvczgzSTNZTFVwNFJSRTRiK21YaTNraWI5M3Vj?=
 =?utf-8?B?U3hDN1NjTU5MM3liSHZFOWRVbDludlRCTVNZbVZENTg4M0hvbkRoWUcxRjB1?=
 =?utf-8?B?QUZXL3dtUmdGdjB0bEhzbXdhVnZYb0RMWVBvWEgwZkFyUzBGMUxBOXlZZWd0?=
 =?utf-8?B?djk4STh4UnVuSjd2KzNRZHM4cjc3V1hXNXNJcXBua2tNUVdTMVV0MlppWVBw?=
 =?utf-8?B?RXA2Qi9nMlBnbDQ0MktaaHhhcmxiQ0dKWmltZUJSNTlNODQrSGdGWVYrVjJL?=
 =?utf-8?B?WFFGNzFzMytLbGZUU0N5Zk4wUVNkR0JlUWovVmliVm5Zc0xFM1RjQmZsVkcv?=
 =?utf-8?B?N3NoOXo4QnphSGt5aGZ0TURWWCs4Y25LVEtNZ1ZzWmdMWDZJa2ErN25nRCtM?=
 =?utf-8?B?US8zWGdkT1lSaXhrMjlzTG5jRGZ1SEV4U2htZU1kT3lmM0o3V1lkSEZiWFdL?=
 =?utf-8?B?c3hsZEtCMGVvZ0Fhbnp5d1VGR2N4WGxJQW0yREtIRVBHZnpSTWI2MDN0OFlq?=
 =?utf-8?B?MkZOSmFTelducGV0TFEyTTYwNjNyakRQYUIrUnlnRXZlb0c5YkZ3ZmNJdWtL?=
 =?utf-8?B?ZmRNZmtuYmNvMzlESVZ1eDlOczVIVVh3ZGpqU2Q1alpsOFBTbVMrZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8dd244-2b3c-4f81-b85d-08deacc4dcd6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:44:25.3200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcCmZFurwkdW68u2knGb1PHLYk7ccdgG8WIXlHs1OlnNeCLiqtnLVJdpf6A0dAUC+48Z4/tcFvIVe0p8/72Krg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9102
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 May 2026 05:44:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22917

On 07.05.26 17:49, Chris Paterson wrote:
> Hello,
> 
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Chris Paterson via lists.cip-project.org
>> Sent: 07 May 2026 16:02
>>
>> Hi Jan,
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: 07 May 2026 15:58
>>>
>>> Hi Chris,
>>>
>>> is there something out of sync with this particular runner?
>>
>> Thank you for pointing this out.
>> It looks like we need to upgrade the host.
>> I'll put the offending qemu machines in maintenance until we've sorted it.
> 
> Fixed now.
> e.g. https://lava.ciplatform.org/scheduler/job/1439373
> 

Great, thanks for the quick reaction!

> Quick fix was to upgrade the docker version in the lava slave container:
> 
> diff --git a/lava-slave/Dockerfile b/lava-slave/Dockerfile
> index acf7bc2..eecd446 100644
> --- a/lava-slave/Dockerfile
> +++ b/lava-slave/Dockerfile
> @@ -7,6 +7,18 @@ RUN apt-get update
>  RUN DEBIAN_FRONTEND=noninteractive apt-get -y install telnet git ser2net patch lavacli libvirt-daemon-system-sysv
>  RUN if [ $(uname -m) = amd64 -o $(uname -m) = x86_64 ];then apt-get -y install linux-image-amd64 ; fi
>  
> +# Install up-to-date Docker CLI
> +RUN apt-get update && apt-get install -y ca-certificates curl gnupg && \
> +    install -m 0755 -d /etc/apt/keyrings && \
> +    curl -fsSL https://download.docker.com/linux/debian/gpg | \
> +        gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
> +    chmod a+r /etc/apt/keyrings/docker.gpg && \
> +    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
> +        https://download.docker.com/linux/debian \
> +        $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
> +        > /etc/apt/sources.list.d/docker.list && \
> +    apt-get update && apt-get install -y docker-ce-cli
> +
>  # Packages for SW Update WG
>  RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ovmf swtpm
> 
> 
> Other labs may need to do the same.
> 
> Proper fix is to upgrade the LAVA version (latest now uses Trixie), which we will do soon.
> 

Yeah, that would be good, indeed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

