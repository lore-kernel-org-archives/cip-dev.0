Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55050C77B6E
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 13:09:31 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.64])
 by mx.groups.io with SMTP id smtpd.web10.8689.1681477764036481193
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Apr 2023 06:09:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=i3C8ze++;
 spf=pass (domain: siemens.com, ip: 40.107.21.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfs+Jn3VR49zTU40+5yfQdBzOE/jjzR/A5GAotojpG4mrgSvhU55Wcowe/bLtq5doUeuzbx0REoXOf0zX+KRUvUQWD4oAwQGznN/IeW4+uHiHkBlB8kM8c51HbCJjCXhrmiJImJ7h5kO1VDROK9ZfIpms46/D5Z300xSAUjfqQ5b8z/94eOaqGqNF1rA14rKGGcXUD0TNqBNYWa1R2oZRWna6hPuwqQkgSGyrxCr58widBpeita6+g2iAm778UJ0z/FqmoyxgJgwSBjUy9xCr+pNt4RPsR9cZ2vaJNvClhD4roOY2YIFuCY0YIfxHGEHT3WLh5vCbWxA+yeOFc4low==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pboTNpiGU70vbfMTHY4PODDlp1qMzkXiBStOr6Gmnrs=;
 b=YvPbIrwCkIQEa35MuO/AIGR3rt8oUJsSrM7tL9umi28RrTbAWLfRM0tR2WgBVbj/sf9ZXh149eNOW2FtybwDO9E3xhu4c+MmFCdNQCaKghOYNj7eXvzifdqky/ZkfmPJHjySgSxRO0rwb5zp4wVKA78jp6Xg/nqny6/kG1fQ9rq0Uz/c4EYZmpt3nurTYC9jNDTEEQljBW32gztyItqiR1QSpxwrqTcqouku4AZ75eID8xuyEVXHZeRJXC2S3su09WPNnqq/XooN2I8+Bv4hZWPL29/B9ASNlT3q0lEAoa5ZCkK9wW+nRaOpLF1kXzvXJteDaJ9ttITiERVYHUw/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pboTNpiGU70vbfMTHY4PODDlp1qMzkXiBStOr6Gmnrs=;
 b=i3C8ze++Jqu23eWOkjUZRgl6fYqFVUNgO2XPO1gjxo4cyeBAe5EByctVT+v8iyFpC6DWm61c43LT3BsiHXTENa9jg2TEidN50I0l8hXpir5l24eOJ0OwCgMmjkOwJfWKBkVxIRnC2fWunxvo5VxvWYdCcEPiCgCrH07yOdMPjP0x9MXJbZfaXhqPeGPrEoFKGT9fjmQPNmFIhQ7+gFqtNt+LCB5rSNcj4I1FYL4M59CVbGc6xkesl8Pi6yPRbttpVxM2d9l7OMauXCmfzHkoL1I827yjP3OVFX/On21jaNlHUlmyKGoRgv2MYTkTB+5/cAFNlq8VNc+pjeSrmU+Hig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 13:09:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Fri, 14 Apr 2023
 13:09:21 +0000
Message-ID: <d4be829c-75e9-3151-86a2-9e02fb969d06@siemens.com>
Date: Fri, 14 Apr 2023 15:09:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core][PATCH v2] add support to limit resource
 consumption of squashfs creation
Content-Language: en-US
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Schmidt, Adriaan (T CED SES-DE)" <adriaan.schmidt@siemens.com>
References: <20230414092408.679342-1-felix.moessbauer@siemens.com>
 <f9ae5295-5534-1ade-80e8-159f623d5e8d@siemens.com>
 <115fb869e0b4e52ec477700057d14555e04eac96.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <115fb869e0b4e52ec477700057d14555e04eac96.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9433d2-08d8-4dae-89f7-08db3ce975d2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IMb2jPOL7qB/OZFD2F0r/kyOgctbBLg0EV+FJUABral7c7Nz54IIhWCi4oAH928apkj0hteXS0/qNiGhfxtZtRtlCTIV8wcN2AwsWba1Be+UsnUnYO57Nwg/RrxzIkxh1NbThPXCKSXOpUzKV+OftWZyNfg2jwOIe2Oz5MFWPx/6pjU5dCQbIHH76sZctDgKMHK53h40EK3OSJvOFncUPITqksW3NLS4GISXyQcekZnUasPZxfAbwZ2/qINdb2enytTBJM0/9vEkTCuCCNdyqRFYnWhRR41Z0PLvtpseRCIQxXKG6+bpAIXQIfHcCz8Vk/4EWZNaQNnkudzbdwTqMDim3BlJxjTottjdNbwwlChlr0fPbSWM/9nqp4/fkgUU2aheZ+NLfyOh6lbrSuu2m9hormTsd/XXnSco9sw7HMNtYlP3hjYvL4BRuB8RzBprbmSB7D5Qjqf7Yt/0vRfHH0cZb4y5grWcc/ShPvdiavUZfDf/084acw+LTnQc0aYoI3FaG44QERr0pBDqd8xEpVeafgllWQPxtyL8na4q/bHhIv4jE2iELtUC1yOTgKVNXUMv0fr4lLQB7l2mQeujWP4a0Ugi3nR5zxn8412sL7HJpsr7Sh4QD4HG2WiRdRJUI8qsnY5PQ+UadJ2ardbo1Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(6666004)(83380400001)(6486002)(107886003)(2616005)(186003)(478600001)(110136005)(26005)(6512007)(6506007)(44832011)(36756003)(2906002)(38100700002)(66946007)(82960400001)(4326008)(41300700001)(53546011)(66476007)(66556008)(5660300002)(316002)(31696002)(8936002)(86362001)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGFZQ0ZNZW5SRXMvdEo1MzJsYk1EQ0xaemJPSEwrV3lUcGJlUmNaN1pUYmx4?=
 =?utf-8?B?dGIrTTVjRTFNSElMYkI3U2hIekZYZlhOTTNBbVRNRVBvRmJNWlpucHdiS0Rk?=
 =?utf-8?B?MHdkZ2dMZ0RkaWFRSjZoVjlPdkxRMEF1VWh5R3Zlb1ZaWG9LTm5SVUMxbGF3?=
 =?utf-8?B?R0N2UzdxbW52Q3Jkb2srSkxySE5Ra1VZTk1vek1VM2FjbmNDUDhNMGYrUjZv?=
 =?utf-8?B?ZnlkNmJQd3A1N2FiVHpWRS9PR3ZkUU5MenIwVWJqRmtzM2psd3ZzcklKbDRi?=
 =?utf-8?B?N3had3JzZDh3Q1I1cWYySFUxVU9CZGJjYVB0WlhBZUQ2MWN1VzhGMDdadWhV?=
 =?utf-8?B?cEtiUDRpY3phNEtGbGhiQkcwV3NpSzZzb1RjaFZ2SVcwL1lDM0x5bk4wWEVi?=
 =?utf-8?B?Wmc2R2hOcVFqZkFtaG02VXBZWFhSVVdpWW15a1F4SkpZVjROdkU5Q3ZZdFNU?=
 =?utf-8?B?d0c2Y2ZoNXVOVHMwVk1VN290cDRkZ2M2YVc2UUMzclFvRUxZRmY5eDZnOGtw?=
 =?utf-8?B?Q0NNbDlkMUtWZ0w5bkNkcnltTXFuSXVWbWp6bzV5dUpMd2pCYlVWeUEzY0NM?=
 =?utf-8?B?anNYbmRlNXBvQWZPc2FVUmlpR2lkRHhqWnlSajNZK3lsaFZBVWRoZlQwNDZy?=
 =?utf-8?B?dElOU1dYbTB5bTBpb1F0S0NjQVRFK0oyaXFLampFbUpnRzRvMnZ3ai83ZGc3?=
 =?utf-8?B?c0ZQanJmcXlLSmFmVTJ2amdCMm1jRVV3R2plQTljaEZNay8xMVFNWE82U3Yr?=
 =?utf-8?B?S0RxaUZwa083K3p2UGhCbTMzMEJ5a3J2bTcvUDgzZmtxblNCZEdnRUgrMjRq?=
 =?utf-8?B?TytNZE9QNFpyenJoQmpibDNzQzlYOFRGOU5uWmZGZDNFTC83TEtCQ0p5RzFz?=
 =?utf-8?B?TkpRQXdPRDhjY29CWE1lSUVSQXMvV1UreDZmZi9URHhxeGxiSys2ZllsempJ?=
 =?utf-8?B?WUFVVVVXenpWUjNsemFMTjJMLzlCUFZBcUhJaVJMZjBoejNLVlhCUGFUaFkz?=
 =?utf-8?B?TUMzcGpnTXN0K2sycVBOL3ZrOVVZV2lmanlmSGJ3TXF4dFhmUlI1eTJ5N2lG?=
 =?utf-8?B?WDJmNUJFWUFZTFZUZUl4M0VUY25UbUdEdHNOUjJrQTlLbnVTT2k5dWJLTHVT?=
 =?utf-8?B?bXZSNlB3STJQaHMrZEMwTGZMaWJZeXRvRTVlajZWemQ1Q0h5aEhzaDFaaXla?=
 =?utf-8?B?SXkydHJvSEgvYkYxeTE4dm5OUUlvTzdQUUlPRENvTEZLWFYzVVRnWkRJczRR?=
 =?utf-8?B?MW94MCt6RnBDS1BBM09BYzhlSUdVZG5uM1p4bnNzZks0bU91VkpmSmtMcSt3?=
 =?utf-8?B?MWlMQjc3VHJkSnYzOUtqUVdTYVkrN1BWTUJwUTk3Ujl2djVLTjU1ZTZXS3lE?=
 =?utf-8?B?MytVSXRoVWFyMVAySGw4dnBaRlhaWm1lOUpLVTJ3ancrQ0Q4UlNOdVQrZXRv?=
 =?utf-8?B?Rk9kUVRER3VwbGxueE82YlpQdTY1MTFlUCt6RDBLdDZBTFYxZjBKL3N4TGtH?=
 =?utf-8?B?TWtzS1dBdmFseTMyR092VmZzVUF1c0JIcGhKRE9kOFhFcGU1Y2pkN1R4VS9Z?=
 =?utf-8?B?UGwzL2lvU1VWRG1VWkd1SzFZT2w3UjF4MTkzeDcwdTFyUTV5VkNxWS9NK1d0?=
 =?utf-8?B?MkdkMFdndUNNcTU0STE4Y3NzNEVHRWV0dHdOekxIVEZPRlJzRjJVTTFNZzJu?=
 =?utf-8?B?OUxxMWIrRll4b0xHUGhseG1Bck5aMjNYUHJHSjg1ZVRxbnUvSTlXdTRnQUxZ?=
 =?utf-8?B?NE1SVm5zN1ExcE9TVzhPalpwRVc5N3poQitUSTd6ZnFETCtoMnlnZzBpWEJ2?=
 =?utf-8?B?UTVjdnk1MTJ2U1Z1citYQlltd1dpSW40SEVpNU1MU0NzSk92amkwKytpMndP?=
 =?utf-8?B?cktIWU1KQk1rYmtwSys0Wjl1SGdML2pkN1M3YytmOTh0L2FNc09NNDFSS0hw?=
 =?utf-8?B?QTVrWUJmTWk5NEVycUFUSHlRZEM3OExUVURJUDc4YUZTaGdCYjN5OE9qTkx0?=
 =?utf-8?B?WkpCTHI2em9nbS8xT2d2ZWhCdXQvUkp5TzFyaG1RcFV0LzdDWFVsaXNpOWEv?=
 =?utf-8?B?eS9TMUlIVXZRMnphaXM0MUpYSkRRT2tmRHZJMUpOblN1SDR6WUw3OUJhQ21a?=
 =?utf-8?Q?/xV5UtCEvn4NDKSE1dCbfgBDL?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9433d2-08d8-4dae-89f7-08db3ce975d2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 13:09:20.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoKGXZRS+eh0+umMzIYGb1Ix3ykgzeQcQg+Ptl9ZQiv2x3oS1IGH2kWdpHW3pmgBa8u7YnofpIDH4/hpHjWOQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5318
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 13:09:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11224

On 14.04.23 14:55, Moessbauer, Felix (T CED INW-CN) wrote:
> On Fri, 2023-04-14 at 11:33 +0200, Jan Kiszka wrote:
>> On 14.04.23 11:24, Felix Moessbauer wrote:
>>> This patch makes it possible to control the number of CPUs and the
>>> memory usage when generating a squashfs. The variable names used
>>> follow the imagetype variable scheme.
>>>
>>> Especially when compressing a squashfs internally with cpu and
>>> memory
>>> heavy compressors like xz, we inherit the issues we had with the
>>> image
>>> compression in the past. On CI systems, where many tasks might run
>>> in
>>> parallel, this often led to OOMs and poor performance. By providing
>>> these options similiar to the other imagetype options, we give CI
>>> administrators an easy way to control the memory consumption,
>>> independent of the other options passed to mksquashfs.
>>
>> If this is targeting CI tunings, we should also export the related
>> variables via kas to allow pickup from the environment, not?
> 
> We don't do that for the other variables like XZ_MEMORY either.
> IMHO we should also not do this, as usually no further customizations
> are required. But if they are required, people can just add the pass-
> through in the kas file on a per use-case basis (e.g. without value, so
> the corresponding env var is picked up).

There are several aspects: XZ_* are variables of Isar upstream, and Isar
upstream has no kas support yet - isar-cip-core does have. If you wanted
to run isar-cip-core in CI and should run into the need to customize
those tunables, you would have to patch it. I agree, it's more likely
that your downstream layer will have that need and could then perfectly
add the tuning vars downstream to kas.

But then when looking at Isar, the other question would be if those vars
should not eventually be part of Isar's bitbake.conf as well. This class
here is downstream (/wrt Isar) so far, but maybe now another trigger to
change that.

> 
> The more important thing is, that we provide clear interfaces.
> And exactly that is what this patch does.

I don't disagree on that, and I'm fine with moving forward as-is for now.

Applied to next, thanks.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


