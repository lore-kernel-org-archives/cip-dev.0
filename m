Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7B8D43358
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 12:18:04 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.51])
 by mx.groups.io with SMTP id smtpd.web10.70583.1730981879284068606
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 04:17:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oY+5yPhx;
 spf=pass (domain: siemens.com, ip: 40.107.21.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2D4mHLF6bz5INam20OYv/M1VTi+AQsEkg7mj8SWf88FsFj2mC4mQiVHxlGF42mq6vXOj2mbeZnpRFKQVk8vIOXZyFEBglFWVRtNtWjwT/eEI8VlcdSqnPSqmyEzbrMc2+YgG8mRK2FCgL6anJggTPi3EhMTnCzaUwD0sTfiGJSBi8ELf4ZUkQIDZ8j0LhuZuc4NK2sMAygIB/h4tZTIXpWFR/4dOmF8x5ThzO3CoHEvLTTa9N8IjflfpWQfWs6uDCGfzrqzNhR6OBz2XvJXz0JLtHS/CqR4KVDeWWAGuUOF8Uc4BgLmETsNY2xvRMCEmJXZQfVJoQlwxZZXaEqB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRXcaUTIau9Rnou3jjDJeFCxIMhDWpy9+hTY0X+L6r0=;
 b=SZrrxbsXQoaUxlozm4r3JUo6gXfGXKsdXEMHn5uZn8DMd6bB7/B/VqjPHW+fMVm4nUdYCBkpNGXkyFnHCYRZ/ZXACj904Fz6HWf9pCSB4LaWJl8DPvYm8I6Lv1g0+ISwQJj8PBIidRk7fZVVK9B1npJ7oGcyYoF65zyZHT2VmpMi1QbokUxHRFOVobQpDg9qxQM2QsTk3dSM0vcgT2uo7efIPIknJEx3UnJKoQt9xO3aCt0jEsDf3DcKoL6GnfbN+gK/GUu6XuU0VD8al0zOJCKHW2GrwkJ4MtHK1Uhj1WlTj7pF1W/0Z5p9sG+dUYR6JT6xO4wwkthaWEtLO2vuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRXcaUTIau9Rnou3jjDJeFCxIMhDWpy9+hTY0X+L6r0=;
 b=oY+5yPhxHB/H0K1Ak8GIK3sHdNx+T6I6vg3L7iW44+bovNQxdAY2hh+DKCzuAV0SkUjvw2U6SbL8OIG/aNZfgtT1MaYe9JaqgHBCrt1bOKCT3wNNC2z3bxoeDKphoqxnhCoOROdFyrnCjDYlVL3AiZSBM4Ht7eCqjlGoavRFMqGmq4AjlbSNMkyVTqMY/TH15NLI9qp7pYI8EdZZbwYKXy1ZeUjmLRP8REg0m2zyWz72hEA8mmciH26foTYNEEw9ehnP3nUgBiREEgleKaExioYU8ViSmPdl9+9t6PonjqdMuYd7d/TZnBjBKhLa0AslfjzDEPWCWDuWR+h4VlnQwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.16; Thu, 7 Nov
 2024 12:17:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 12:17:54 +0000
Message-ID: <690f991a-a496-483a-8125-8245991ab25b@siemens.com>
Date: Thu, 7 Nov 2024 13:17:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/9] swupdate: Control self-building via
 boolean var
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
 <c6ab307ddf903298d2fe23ad93b1e6a251ecc6b1.1730977077.git.jan.kiszka@siemens.com>
 <af85d99b-c02f-462d-b668-7a41ca966dd9@siemens.com>
 <e5081064-f132-4d95-9254-e2962ae7bcc9@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e5081064-f132-4d95-9254-e2962ae7bcc9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d14cbce-8b5a-48e3-6355-08dcff26350b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TVdQeU1LVkxyQWE3WmRKdDhoVHhXajJvcG9QcTRCbGtSeDYwc2N4S1dQOFNo?=
 =?utf-8?B?QzRlY3lsdUNoMmVTN3R6cGFvMU1seWtiS0ZSb0xram9EV2RweHdqZ0cvMDRt?=
 =?utf-8?B?SGl4bUNHdDZXRXlXMlNlR2lEY2E4YjIyUENtNFpFS2lyWWJZbTIwazlTOXNS?=
 =?utf-8?B?VzJCQWZzNnR3OTVhNUtNQjJPNk82TDEyVzA3aEhyWERpaUxKaDJYT0x4eXVi?=
 =?utf-8?B?YkJyOUNpNjZyOXE0bEVpZTEyNlcrQWFlSWpuZy9iN3JtaEw0S1U2Y1hJUmIv?=
 =?utf-8?B?eU84akN1d09jUGM0RFozbjRUR0NYYWdpUG5SR3dGTjIwcDI0QnFNOG1EZW9o?=
 =?utf-8?B?RnRBOXphQTg3Mm8vcDJNeUNjMityd2hOMnh1MzFJZ2ltVVRmZmpSZnFWQ0NE?=
 =?utf-8?B?Q1ZWYlVsbGY3djdMeGN0VU5Lc0tpSXVjZzgwN3BFejI1Y0Roc3Z1NC91TnV3?=
 =?utf-8?B?MTFTOFVaR0gzUmZiL0ozTmdaTDB0SExoNWJLRWhUSUdETVdMS3RUbk96RnFZ?=
 =?utf-8?B?R1lJaUhCZmdGL0xqZ3dKS29tdWdsWkVhdUt5eGRiYUJtdWM0aFgzNW9TVWNt?=
 =?utf-8?B?Sk5CR2ZPV0RUSW9BOC9HcW5KTnZzQm1MMTRNVjdLeVVsQVV5WnloajRCclZZ?=
 =?utf-8?B?VEpsWXJibkc2NnBTUjkyc3d2OW9xMnU1SEVrZERpVlg2OVZDZk9XWEVaQWpZ?=
 =?utf-8?B?MmZyUHFIMlBFd2I2WVVadWNDRk5BUzdHc051d1p2amhtc1NMK1B2MEE4MGVj?=
 =?utf-8?B?emJ6UTd4ZHduK3RkNjJNSmlXZUIwbTExVm1ob2ZiOUxzRjIvQksrcEZ3MTFi?=
 =?utf-8?B?bnBUVzdMVUtSc0lnZFE2OFI5d1FsZStmelVhV1E5QitFVml4RzZXTWtFYUtn?=
 =?utf-8?B?V2NhSTZVQnFCWDQ5ekNCT1BzQkNUQ0lmSFJCTFVVSjl1YlJOZzFTK3dLWEhF?=
 =?utf-8?B?cWE0eC9yV1RRNytBTXlNdTQvOVhsMHJiOGZRd0tBY2MvTy9KYThldU5PRTAw?=
 =?utf-8?B?YkFOZVJ4MFhNdmZnUDJnQzVrdHpHY0NWaklRL2xMLzBkQytvSklpdzlpekMx?=
 =?utf-8?B?WHNQZ2MvTDVmcnFMczhEc2xWQzFwQnRoNW1EbFdFb3BmNHQ2UlZQQmlhYkJw?=
 =?utf-8?B?RUNyOGlMZEJ6bnVOb0h2WkRRZ0pZT3MxT0F1cS85Q01UTDAvVmdHNHlpOFFE?=
 =?utf-8?B?dVgwNWZUaS8yNXBGVDRjcndwTmRpVGJXOG5rS0lVQ0o5M3A2empPaFBybkVE?=
 =?utf-8?B?bjNjazYyL0N4YXRtNFNTSXVNaWlxMXg4UGd5d0RUamxsRUtxVTRLalI2SU5B?=
 =?utf-8?B?cERCOGF4bDA3MkdoTHBYTmp5ODJNN3ZDNlF4aFBFcGcxQW1wV1lYN0p0Qlpp?=
 =?utf-8?B?N24yQ25nRVMrZFBZL2l1RDJuaEpKcjZoQ0NlMkdHWWd6ZjgyeVlENmNvUXJD?=
 =?utf-8?B?MHhjM2RNQjF3cm1wQ2xoM0pZQU5wQjlFajVQTEh2MjV6V2MrMmdRWWQ2endj?=
 =?utf-8?B?L241U3NrQ1JPTGM4VGwvQzN1a3VkWGpTV2ZkaGpZQXdYNUNkNTgvLzZlV0RQ?=
 =?utf-8?B?R2FLZkJLTlRFVEE3b0R1ckpIM1puODNxL2M4YTVtc1ZLeEh1bXB3TDQwdXcr?=
 =?utf-8?B?R1VpNWEwVzNPYmZLS1pQZzBsc1B4UVFwdXEyUUQ3TEhJSjlRc0g1UkttMWNx?=
 =?utf-8?B?MWxGZUZCY2YreDdrcjNpSHJ2YVJpM0xlaWJIZVVUYXcySEcyMEtHYVNORUV1?=
 =?utf-8?Q?tsofbCQD7SxvMk/3cU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWhDbHdkVkF5aHdOVlIyK3R5ZEwxbXExNVJodG05TmlzTlA1VVl6TmhSaktN?=
 =?utf-8?B?ZkZXdjB5cW5JUmRMS0JTd3ZYZXIyWXVQTjU1ZnluTk5ydVNYWE1Ca0VqOHg3?=
 =?utf-8?B?OEJPRExhbzlvcEhOcTI3aG1SdGpoNGh1N2RPR3JvR0Q2SlI5NVNEbjcwUmFl?=
 =?utf-8?B?WFR3NWJsU2E3bWdaRjZBT1RreURlQTMwYm5rczhwWVZzSXBmaHI2b1czRFZW?=
 =?utf-8?B?azNwSHdEYk5LN3BwUzdZaHllbnN4Z3VZQ3JEcGJmSEtKaGh6dU94SnlkbVdY?=
 =?utf-8?B?Uk5hRkl0NnQ5Mk00ZWtKNnZwTnVoSkhyTktQdmkzOGx3L05VOHk1eHpXb244?=
 =?utf-8?B?ZDRpbXY1bS9yaU5uM25GcFVZZnhST0dBSUIzYTNTT285Mm9Wcm1aeDZ1bzdD?=
 =?utf-8?B?K081TlFOenlaVkRQSXVEbHRWa3RtcEFRUjFHaGpHNzNhMUVoamk0TmdBaExG?=
 =?utf-8?B?YW5GRXJreHBPNXl1My9STVpFR0hpbFBRU3BNbSsydE1aR0RIeWhnQmhjRm94?=
 =?utf-8?B?VXA3Q3VmZllNUW1Bd25oalRWZlFVZ3lqb0RMQUN2dTJzTE1Eb2J5aUwvSFFY?=
 =?utf-8?B?a2FkMi9GMTVTVnR4MFAxREVzdTA2YUNwbE1leitEeExvbzVPcis0VktqTFhI?=
 =?utf-8?B?bGthSmVWSFJ2cDNOby9DOUU3a3cvUVBCa1o1dkRVL2EvQVVMcWNPZ1RlTU52?=
 =?utf-8?B?ZU9QbzRoUXg0NXBiMzVaMVhoQ3FMdnpwWUFQaVdCMTRabng5ekg5SVlNd0gz?=
 =?utf-8?B?aTBqTTJaVDJXdzl2NnMzc2lscFNlSk5sN1hITUxlZmtVSkUxaVZ2NDUxbFE3?=
 =?utf-8?B?bTlJN1JxZ1Z2azRKbWUwUXlNcGRUT0FOdmJoanozZWtNS3NPRHFEaEZ1bVd5?=
 =?utf-8?B?ZmU2aDBDNWJrTVg4MzRWd0YzNXZxR1V4UHV6b3FmVWJGaEhXWmRRNk1NU0l6?=
 =?utf-8?B?b2kwTVdteXduTm5qMXkwZ0NRTXBGVVpFVWVaZG1IRVNXaTlVQ0l1OTdidFlv?=
 =?utf-8?B?MGtKNnZnWWowMHVmcFhOQkxDbGhiL09oanJrNk1tcm1rRUl4Y1M1Uno4d3Fh?=
 =?utf-8?B?YXhKTmFReWx6R2FHRi9DT1hUaERoRHAwaUp4dXlOSGNPMGp6L2hsZVlJWU45?=
 =?utf-8?B?ZzBKdXRxNUM2Uy9HTEF2cnhmSi9Rek1JUjV1Nm95cEFLREp2bkExb29QSEtm?=
 =?utf-8?B?VDc4b29RYXpiVjQ5Yk40Q0tYcm9LUFE3dkhCY1lReWdOODlWNmdjdlJvY2hV?=
 =?utf-8?B?NUEwMWFDbGY4SWVZQndhbXp1YTAzV3J3OXczNVNTYVJzYldsUU1SRE5hTm1p?=
 =?utf-8?B?SVJRenZvZmgxaEV3N25CcGVEUUI2NzZ1Q2hwV3pUOFQ3ajZaWFJRQ3BrUGVW?=
 =?utf-8?B?VzNQN1dDditSK1hmajJqQzU3WmFaZWg0bWxiMnl2SDhXSGZWNHNLZU5kNGdY?=
 =?utf-8?B?eElJdjdBbTJ0ZFNmbjJpaGhFaElPbWFid1E5N0ZwOWJSbXFudktVVVJtNVVI?=
 =?utf-8?B?emJZOUsycE11c0xtUy9ZS0g3Z3phOTlUUFU0c1pUb3NTVGtwN3VDQ3RvTEQ0?=
 =?utf-8?B?T1J4S1pTVzFSbVJWdHRzV2t2dGJoZ0ZSZ1FXNEVLN25JbWZ4VndTSzBNU1BS?=
 =?utf-8?B?ZXdFTVhCWTdDcFhJajRCd0hrSlZFMS96TWE2U1gvdVB5UGdwSXNtTmtTcmJo?=
 =?utf-8?B?VUZhY0I3aVdWSVlxZFBlUUdzZ3lPVThRWFpBRHpwTGRDTlYxZWN2QzYzZGxN?=
 =?utf-8?B?eUNQTnBCU0gvN0dNU1ljNE5YWHpXQllyamQ0V0xHWGl0QjdmanVtdUtOZUs1?=
 =?utf-8?B?ODM0YmUrQ0ZkQmZkR3RxT1dHMEpXYlk4WmZ0bnJpZlRNYVhCQ0ZzS00xMmpB?=
 =?utf-8?B?TDlXcFdQdmhYWEJZNHVrdmV1S05iQzRhWmh3OTQ5S2VlNlNsMmwzMWgrcHgw?=
 =?utf-8?B?T1RIQ0pYelFXUk9BaFV2ZFhHOHVvOFdWRlZha1Zxc1htM1JxeThiYlpQZEJY?=
 =?utf-8?B?NUdGOXgvSmp3UnI1Q2tGUnkyRGxRcE9NNGN4S2R4VU03Q3IvbHpYZWdDc0dO?=
 =?utf-8?B?ZkN3TG9ENDVTd3ZVSDZQL3pnamkvMTNqNjlFUlhQK1A1ei90Q0QrajlGVlJC?=
 =?utf-8?B?SFdDUHdoS0lkL3BvM2EvdDRSaFJCeFNVeTYrS2dSTXNlYTIyOWRGbzVMbTNv?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d14cbce-8b5a-48e3-6355-08dcff26350b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:17:54.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIKsWgq2a1vuDu528ER+Cd+Z60i+p+B6o8BzQR2t9TkA722tTMx8dtSUtKnt7EC1hHM/VQmnlCJxEnI7gjMbng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5305
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 12:18:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17217

On 07.11.24 13:11, Jan Kiszka wrote:
> On 07.11.24 12:30, Quirin Gylstorff wrote:
>>
>>
>> On 11/7/24 11:57, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Under the assumption that future versions of Debian will deliver us the
>>> needed versions of SWUpdate, this eases to opt-in for self-building.
>>>
>> Do we need some additional logic for SWU_SIGNED = 0? As swupdate from
>> trixie requires signed updates?
> 
> You mean we must enforce SWU_SIGNED = 1 from trixie onward?
> 

... or do you rather mean we should switch back to self-building if
someone selected SWU_SIGNED = 0? The latter comes with the risk that
self-building for >= trixie could quickly become untested and start to
silently break.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

