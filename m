Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCD4C433FE
	for <webhook@archiver.kernel.org>; Mon,  7 Nov 2022 17:51:12 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.79])
 by mx.groups.io with SMTP id smtpd.web10.1054.1667843464463446753
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Nov 2022 09:51:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wy5hpgAt;
 spf=pass (domain: siemens.com, ip: 40.107.103.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcjJvPECyAsFMTTo+F/poHK39qpPY86bjXlYhRvzmFeT/sxT+KkquwfMBEWWNITVvbABF39py7WM+qypQ0t72OU2TrT0WfNp9Dvmy7xPoRX8Ho//sDQkYWlJ9LQG8KwiOfP9pf/Co+WTXcvmBssanZT5G6GYXb82fe5fv8EHXUzaqBiTQ43PF823R8VolqM+HQs8ecLzxUhBvePf8MQmLGvP2myzvy0vME0A/+BQGInwzLx6sGV8zCr41Sb3wqOSLEySvekUgfBOPJrEobqghDVFWyXPQmwZRb0pZap3RBf9k78AQG9KwRxQk0W9hVOJWOEHxeNbnxDiv5p+cVvksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78b7D7XtMMvs1AdBSPls/0xEEQSD1ELKUqjkTNZEJws=;
 b=ech9K6TRZEhaOhsnSxSCPbiiRrFe7xxLfgpXkBhWVyJwzaCaJ4nQFVWqyEN4o71r7sim01rH3rxEdI6DMDfjmJ8c9jH2mEEl6nlSdrCVGYJitaXZcf9wMd4fQ542bYLDYCMjnRbmcLCkjHF1gyGK0Ybj8Fd0XLT9NPW+yPAv4uGkKWZyb2Yf9vaUOQiDk1JagaZtOs3Ro49p1521lqn2LFa0Hib3hC+38w6duuTVugOrov6C0915KfR5qvZnqDgc9yFCDca+dt4piBsjphg2z26RSMZfUY+s9SHF0P13AVPK/vn677eUFjLcK+ZyAnMeB84PXD+WT2kc1gGKnbOWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78b7D7XtMMvs1AdBSPls/0xEEQSD1ELKUqjkTNZEJws=;
 b=wy5hpgAt6nNjm31BfCqp7oSFkdv+9Q++vgadnf92hSzykpILqIVpDjT/7IojWNYEn1jCHLzMF0Y9KBjX4NOTXsAVcxBcCvno+yBqRaISX4q+fJyIAa4XaT37kO5wLy9y+BWmlj6R2BXaM2HywPfXHeFvwqYB7qhV2IgCmpTIzxKaB3yo+Bq/H5V5dqXyOfOsWYqs3edSWk/q3NCjPxWkzVnFUwwVocVtbsmtq1D+zgcz+kBaSgKQFHCVU/v89bp5s4wjUFZ7/sD4g1ZCICTIRowpGO09szS3S/c0YD2FFdUQHoWOnQmIG//VjntpYQnRjp7kqneDiKGrkKyP9pEGEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:265::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Mon, 7 Nov
 2022 17:51:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 17:51:01 +0000
Message-ID: <4cf6d301-bbf3-bdde-e4f4-fa646701c3db@siemens.com>
Date: Mon, 7 Nov 2022 18:50:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH 3/8] Include optee into u-boot
Content-Language: en-US
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
 "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <20221024122725.383791-4-sven.schultschik@siemens.com>
 <3d75d1509a201b658f4e5be035265ef82fa43b08.camel@siemens.com>
 <d8d40615-4e43-86ad-c947-cd3c0827e389@siemens.com>
 <PAXPR10MB5037772EDDB7F8F29463E6DB90309@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
 <4e5a1133-8b45-2d45-101c-b059a89d6251@siemens.com>
 <PAXPR10MB50370BA1C33D4D3C49939A5A903C9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PAXPR10MB50370BA1C33D4D3C49939A5A903C9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0542.eurprd06.prod.outlook.com
 (2603:10a6:20b:485::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e2c3e2-f095-452b-7c0f-08dac0e8a254
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MUjnq4h5vYXiw7Ab2X54tkTHILH407QU4A6TFdXdYVhIfrHeLnVWDetkEzhh/C+JgXl5Jz0ViXPwe86IIB6sewInvZNHJRw1U0xqlW0g9wv1bZNfZFLYqKIJ4nb+kBpgee6At+kR3Rt4zF0+H4ne1MttwMwBc5E7Sa9jmpy2yGslBaCp5F67OkPcAvs+XcNFPaXVrtFanzWeXW2QEokQWjlf6Slr0a6JPFxn+91EeWIh13fUTxvOcGNy+67BKj0Et7w91Qg6oBpCs0Vksgtcb1Utc1OstAz1aOTzL2cWMJJtiT8BwIf5COIASvutvUuu+F25U3oX0BbK2A8KzHt8enj7oHaWYNHIsQhvPEXi8rR7OCqpK9G0+HTLq1Qqkrhtio9n/dqzJ78SyVepvmFc8j4nfXfU7bbSFvLBMNysptertsdX3tO/wI/WYB3F3MSHanKTkJz11tFbqUFxJegzpizecnOHpzO7GpeUoBbwQO/tG2IGczvHLAYZ56a2/6s99c+Cf3OxRuj+MSoZa/N+jyXDfoO67jW9I1X6CK40s6m2qL1uvT9E6K0w8jGsyZCG4r4SVAzAFVhsCWbKv5GT+xBZ6GXDqp7UWZxOGQGFDMVWYV19usic2E+lrSNJlnHVewnTnEJFhpehh6xujj/kfg+cix71+GFPl72Tbi18H5+46LbWAsHs7WxhyU1EmmaMAawR+5Rv//MrmX5nsMtcTdbb4j1hCIWydVuIhlNybD5htpVHI9IlrhC3kKL6HR0VASzU/sUkKeC4yObUOFJ1sn2apGBIzgO05MOkyETad6Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(186003)(2616005)(31686004)(2906002)(36756003)(38100700002)(316002)(41300700001)(8936002)(6506007)(53546011)(26005)(6512007)(478600001)(6486002)(5660300002)(31696002)(86362001)(44832011)(8676002)(110136005)(66476007)(66556008)(82960400001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTQzaGIxcFdVdXJQM3F4NnBaT3pFRGhacTNVeVk2ZFNMUk1neVU5OHNlckUx?=
 =?utf-8?B?L3M2M2ZadElDMy9zZTZzN0QxMWRHTDdCaGU3Q29QYnFSRGdVNEM1ejhhaHUx?=
 =?utf-8?B?bjFnK0MwL1l5S1JEK3drTWpXcTJxUGhWM0xOWlFObFgxZFRJaTI4bzRqQitY?=
 =?utf-8?B?K20xS2krMHBkWENjU2ZkaURlbGRRY1o5VytRcUoyakRzd25COXdONzNJSXN5?=
 =?utf-8?B?cDE0NXl0dkR3ZGZuUnlFSUhVdXVnTWYyUDd6bkMvdlNGYzVUbDJxODMxTGRi?=
 =?utf-8?B?dGRtVWJ2b2JwUjY4eXhLc2d1TldlTDh4Qjh6Yys5endhK1FDRFBiY0U5Q2Fq?=
 =?utf-8?B?RHVxMGI1bHRXUUpYZ294VkRxUHJxNDBkWmcxaEVzU0Y1WTBiZ2VQbkZZYU96?=
 =?utf-8?B?cDN0SnUxRW13bkZEb3FmdXRDTUovTXNoV3lrdWZMMU40a2lRRWczbGVFd2VB?=
 =?utf-8?B?cjh2R3k4ZWNNZ3kwSjNjeUtrMmlDaitGQ21vWWNmdE9LVXhqOTVGSzdtZUxu?=
 =?utf-8?B?QnNsbHI0NURlUUwwOTBtMW1kdm1HZW5TYzFpclRYZmxoTUdOODhFUUIxbUhG?=
 =?utf-8?B?ZGFxbUVnNC9VU1A1SVZ1UWxibStoYnlSQnAzQ3FKTm5kZTloZHM2Z2ViWTN5?=
 =?utf-8?B?Y1JTZ2dGVnUrZStCSkhJNXdJZFBRYVJCNUZraHd0eEVzMXZVczNNRi84WERK?=
 =?utf-8?B?c2c2bEwvVlpoYTl6aDMrRWNDcXdBOVBxMnJwK0o4UVppNlJpb3R6NUM1UnA1?=
 =?utf-8?B?RHVnc3VzVFp4QmUvc2d0MXFWUUlpRGQvRjBGclhza0dGUEJabjRMS0YxbGxB?=
 =?utf-8?B?NjlLeUw3MGlPamw4TllVOStqS2JVeWJTYU9DaVVDTzR2Y0RvWW5kWis4V2FF?=
 =?utf-8?B?NEEzdnFGdTJXc3I0c0ZtYjEyZXl0cHV0SnFFT0ZsT2l3ejFPRVFwcnVheUdl?=
 =?utf-8?B?czl3RWhMZUMrNmhBaDNGRHpjbU9EMGNPck9VS2pPT2pySHQvME1JUmpxK2ZQ?=
 =?utf-8?B?RmdKQ3VSSUY3ZG5Ja0I0UnpkNUpSZnJYR0F5Q2M5WkVsWWZjUTAza2NxQnRl?=
 =?utf-8?B?UnBJU1lQL2NSbGQxeXNINGxHVmlkb0pBc2o3SHE5Q1BjOHZGd3hJbmMyWFRG?=
 =?utf-8?B?a2M0aXdlWDN6WDZRU2RsM0JSNitONzUrMUNYZHFpQWVqRlc0UWpHUHBaaHZF?=
 =?utf-8?B?VExVV0ZhQkpHU3FObVgwZFhORVlNZStCUGNRSGZsVTdPNk10QVJHY0wxbnZt?=
 =?utf-8?B?NDZZdXdMQzNGY2xLTEJVcXgrU09HUFN1SXcxZjlHMW9oZFFVVW1GQmhwbzJy?=
 =?utf-8?B?eGRXWEllLzhVcndVbGR2NTduWk8rSGpISVdzNGJKcUFCZURhNFdWS3h2NVFR?=
 =?utf-8?B?Q2xxUEF6ZU1DWDFQR1BuNGJHWnBVbnNUNkxWTXk4SzNEbTliTEd1VlM0Wjc5?=
 =?utf-8?B?aWcxU05mb3BGOGRqS2d2TUVEOVNGaWhGTWlnZVJtenhMNlVkZWdkMXBGM283?=
 =?utf-8?B?Z2xuNEFpZnZTYXVkdlNFT0FEMTZGTjc3c1haTDVEd0hUVU45Q1M2SXFXSUZO?=
 =?utf-8?B?MVk1eGpMSkF4M0FBSEwyM1I4c2VYSExWV2pNMFp6emFtdzBnNTdLTUhJc1g5?=
 =?utf-8?B?Rm96KzZSNkNkNkFVNnMwYWJCaThNQzg0UmZUSlNxQWFXU1hVakxaVVJVMm1m?=
 =?utf-8?B?UFFWVmxxM0k2OFE2OGJkdDMvVGxyODE2Y1ViYm9yRUVpV3F0M2tGTVBXSFpQ?=
 =?utf-8?B?S1FxOHFiUWlHNTVIdEkvYlRScWFCSFBCaXhiZlQ0R3E1cW1NbURPQit2elBm?=
 =?utf-8?B?RGpKZFdBUHJpam1RcHhOaTcySk14U255aWhmTHR5WGZXSWxzZEVrQU50SzN1?=
 =?utf-8?B?THd5ZWtQd0JKZVVRUmo4TnNndWJ3SStiOUFXTnYxLzY1YmFPdGlyTTBiTlh4?=
 =?utf-8?B?Y3Y1NDBabnNCQkc5NE5aRGNoeVlnTDRlUWZYUkE5RTZBT3F0b2drK3NZcitr?=
 =?utf-8?B?VHNQbjFiQzRIVVdxZnNWcW9zcFIwMmIxWE82YW1IUHQ0TzRGa2w3c1d4SVY0?=
 =?utf-8?B?azUxWHQ4SmFFRHpKQXU5QlZ1ZjRzMVQ0cjRNSmRBZjQ5Z1RpcFp4citqd0JL?=
 =?utf-8?B?emsvbWFQZFF1L0NmYWIxV1ZrNDBycTE3RitwajFNb2gvZVQ0UGwvQ2FDN0Qv?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e2c3e2-f095-452b-7c0f-08dac0e8a254
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:51:01.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuKP/LPU7CZP22ZYdcDOUBx1Fu+5jA4u1mMNXKXDMdk/hoBbmBitkAltD6mOBSGBFFEydRnMwciZm26V8BzXlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5683
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Nov 2022 17:51:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9943

On 07.11.22 17:57, Schultschik, Sven (DI PA DCP R&D 2) wrote:
>>>>>
>>>>
>>>> Right. When we switch this, we also need to switch the secure boot
>>>> setup procedure so that the result remains securely booted.
>>>>
>>>> Jan
>>> Do you want to do those adjustments within this patch series or do it
>>> separately?
>>
>> Well, if we leave out enabling CONFIG_EFI_MM_COMM_TEE from this series,
>> would that leave something testable / minimally useful behind? If not, we 
>> need
>> the transition to secure boot keys in RPMB already in this series.
>>
> 
> If we go fully on the optee rpmb solution only with the manual test patch 8/8
> 
> Else we would need to provide a
> - PK, KEK and db
> - a u-boot script which does on every boot such things
> fatload virtio 1:1 40000000 PK.auth
> setenv -e -nv -bs -rt -at -i 40000000:$filesize PK
> fatload virtio 1:1 40000000 KEK.auth
> setenv -e -nv -bs -rt -at -i 40000000:$filesize KEK
> fatload virtio 1:1 40000000 db.auth
> setenv -e -nv -bs -rt -at -i 40000000:$filesize db
> 
> Why?
> The secure UEFI environment is not persistent in the patched u-boot qemu 
> setting. The RPMB in u-boot is emulated as struct in memory.
> 

Ouch... We need a persistent and consistent (u-boot vs. kernel) RPMB to
actually test this with realistic scenarios, I suppose.

> Jan we could make a small talk if you want to discuss further steps.
> 

Can you summarize again here what options we have now? It seems we need
a proper RPMB emulation rather sooner than later.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


