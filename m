Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD03D41D57
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 06:13:04 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.47])
 by mx.groups.io with SMTP id smtpd.web11.80690.1731391977553925916
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Nov 2024 22:12:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qVkx33Jk;
 spf=pass (domain: siemens.com, ip: 40.107.22.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYoy9cjzz7ZqeovobPi47oxDerMJInlQc1E/kWngWD2Hf4pEnYYqnwJjunjBRqhP34ZNILHCtg232bBJNGiQC9U3HyHEudBhUdhSLPMebVr3XOAhLNN7onh4CaCHdBMuQAHj8fVUT+ArOCS60w6iSj9T2adq+0wn9w60erxdE3TwEPoc4/0feCYlteP6AKxzJu0v2dfx2P1T41E/gxqM77KW4ccigjoXZ6Q9frj+S1hqaNfqyCC5wIzn0tdYPEfyeLsoWXDbU2orDm+HyKyBZwI7Gt7Cc3AJ2uVwQfZ9RfuXXuBizCsofVMr+X+S1YoB4JuQ3aWmQeMRO9LyreKviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvWIwojvpmtFM+IjCa5m+maCIchdHF3hQkMRn9eTqPw=;
 b=ZyRYsSQlYZV4I8avJPEpJSHdslnTFht9KZ8gBPGjDa9KcW0nIjkPFuCoeysqbBJfKJ6CcIcOgbgJfDUyuL894AmvDU8j0w0CUqEs9PKRmLjnwsv9AvnZhHGMplKolJc7s/0XUwZYM051gdmB2Zfnv0O0h0VH2qXxIf47CReloSnjhX9ASqostd/1ycIKGFzDEs2W38/F4j60BPWCxIVvGIuMQgmFGpo1oD80FSkn7ryQsSw408PIgXc8SrazTN5OrbIValXm5LK5P5CIUSGm6wdLOmnHvApS5AGzXmaCYfxxY+QmibLzay7PPM25T7E0nOnTVhfu4OZvgVEzFA6oCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvWIwojvpmtFM+IjCa5m+maCIchdHF3hQkMRn9eTqPw=;
 b=qVkx33JkLJKMnbJGyp/p4bQfy+O7B4Pe+zzc3iEJ2BG8Bp8/y0XaBg3Q5Qgxv1anMxozd/6hNm+ey7te5CDKDT98KAMwXcV9ppGundXuolyprn5qQ9i99OVHJLDg8GHxlhdHSDb+nGxa7BxzrZrYUa8O8+7nRhdXXXl4bbehJSP6JyrBPw2eMNrxalCxilAEg2riLWHkXu8TLPFfLmfFQHt6iR72+Nho/O4/oTzqI2CYABu8sQHlUjKDVy8A6y2aAFE2Q2M1nEoy+hQOPsVVfzouaK5/4AFPU3b9Fk9/pL+KtKWLH92KSlLv1/IoaDQGw0qba63IZqPgEhJGUQcqeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5533.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Tue, 12 Nov
 2024 06:12:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 06:12:53 +0000
Content-Type: multipart/alternative;
 boundary="------------Gj00Q75eGmQQnSLMVuNgwmfr"
Message-ID: <59bd0258-8092-4988-80db-e8f5a14a5104@siemens.com>
Date: Tue, 12 Nov 2024 07:12:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-security] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
To: cip-security@lists.cip-project.org, Chris.Paterson2@renesas.com
Cc: cip-dev@lists.cip-project.org, kazuhiro3.hayashi@toshiba.co.jp,
 dinesh.kumar@toshiba-tsip.com
References: <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5533:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf87409-6fe1-47b3-ea6a-08dd02e10b29
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|4022899009|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L2xmNG9sa09lYUFzSVp0WkFEdHljeGZ3RW5DODRrL2NQWFJoQzdwVE1WbTVo?=
 =?utf-8?B?b3ZLK1JDR3JxQjlKY3BmWnVPQXZwRmNhTEg5RVBhTnZtdk9jRmVWNFZ1WllU?=
 =?utf-8?B?YlhFWUFDYXZZKzBPbjM4L2RINzNuTEhVOEZKWHpObkxmQWE5cmc3UXMwQ3Fr?=
 =?utf-8?B?RVBxSE1MNVQ2SHhHRUR6RUpnYmk1dEV6c3dhTHpYTkFFVVBEQmVWOHRTV3p2?=
 =?utf-8?B?Qms3WHFQZDgwMCtFOFdGbXZwVyt6QjhndmRJWjR1YkZodkZPbkg2cWlid2R0?=
 =?utf-8?B?OGhyZTl4YktsTGUyYVQrZWtGQzJsR2duVmhDWHY4dVZwZUNFMUgxeTROZzdC?=
 =?utf-8?B?UXM1Ky9hZ2puZFREZEYvSVkrUmliUTMybEF1aGNNNFVLdkU4bldKUzEwUFo0?=
 =?utf-8?B?cVBLNkc0YXdVSFpuM24yUEw3NDVBRFRVV3FQOXRFK0Z4K21xYWNTRkhPMVZD?=
 =?utf-8?B?Wm5xeUloZUdsU3RKN3pGUjhDWXJHMW5LcVJSUjlwZDJ5WEVjTEpaT2xGWEZ0?=
 =?utf-8?B?eDVlYmh1QzFGZXRycUw5SHVkSTF3WGFQbjRkVERlS0NRTWdmMGR0eVpmc1VG?=
 =?utf-8?B?anpLbmlmRG5BK3RaRHVXQ3dzU3ovSEdVTUJ1L0daK3B2N0J1MWZjVHVET1d4?=
 =?utf-8?B?STJBT0xiOEFuT3VEMEFhNDh0Umw0N25UN2pxRHFRalNMQ2tuQ2FuVTVLdlA1?=
 =?utf-8?B?ZnlYZmM2RjNzazZLTzQ3VE15cFVDVHRZc2liekVjcUFZMGpwUlNCNHJaYzdG?=
 =?utf-8?B?cWdhOW9jUGFnTk9UM2oxaWlGa2JhVVZGOGVvYy93Ukx1R2w2WDZYVzhZR25q?=
 =?utf-8?B?VE9XWFRWV0ZveHZCVDdzNkt3WllNdXlMT2gwZTM1MWNGemMxMmZpSlExLytG?=
 =?utf-8?B?REN2bmx4dzhwaHVvME9yeEp0NHRCUE9uRzA5akFrVHZRRmV1MnNrbWcya05J?=
 =?utf-8?B?ZFYwTXVyWG9mM3BWNGYzbWc0UGJEZVp3dGFLM3g4ZWVPL3RHcDUxZndSQ0hY?=
 =?utf-8?B?bWxxdFNXNXNyZis3MjJzcE1WREhndzlLZk0wa09JYkVPVk9mUU5LOEk1c053?=
 =?utf-8?B?NWhTaFA4N2daZHArazM3ZExXclZkM3NkRlM1aTZwUndEUVc0SjJyaDdrQkw3?=
 =?utf-8?B?K0RYcmloSXUzaFVPMlIzNStkVEJOTmdqS0NOYy9QdHdoT2NuZ2NjYUIzTXhC?=
 =?utf-8?B?aUtaNzEvcjczRWh5RVRyYytVVTdOUWpxbjVoOEVWVjF3Mi83R04rNzZYNjF0?=
 =?utf-8?B?K0J6azZBdVJIK01FNm8vOExzd2tETmFwdURVVWM3TFlYbHNYRDI2aDk5V1ZC?=
 =?utf-8?B?MVVXaDNsdDNUZGRxZDdjOHFDT1YxOUNLZzBwQmNiS3ZLd2V5bWdLLy9XeXlv?=
 =?utf-8?B?SDcrWUNpM3c2c1ZxeWQzbFM3WWlMekVDd0lUY0dNaHpvTnhFUU13YW1HMWpr?=
 =?utf-8?B?dENIZkZoUENCQThoeTM1VWFlRlNuVVJ2M2hKelM4UFJqbkpiMS9VWERBMncy?=
 =?utf-8?B?NTRIRmF6cFh3aUpIdVlCckVwUU93V3BlSVNHQm1VS2MvZVE0SFVTaVoyRGt5?=
 =?utf-8?B?c0FZM21tbVAyMVpxVVI2ZkljM0lqTFZHdmdjZlBvaFNqcmtud092VXZDRzky?=
 =?utf-8?B?a28vSDd3RGNNc2ovd1JIMzFNa3pzbVJaQ2IzclJudFZPMDBKcDR6ek1jZ0d5?=
 =?utf-8?Q?SHeSBtpdTP3oMFd/Jhf1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(376014)(366016)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2J6RXdsczB4VzNFWFpWdGhkQm9kVlZtNUFuS29sYjYvRklvN29HcVdsK3Vp?=
 =?utf-8?B?YVJLTHRENHBZNHdUbkFocitiS3lUU3BNQis3d2pRUFpGb1cwaThtTmlJekl4?=
 =?utf-8?B?T0JWUXFRSzZzai80c0M4MjdRRXY0MHFLbjd5UXljbmgraEJpclJBRVJGczJi?=
 =?utf-8?B?aVhIeERSdGt6Z2xWbE9JQjEzc251WkVzUGk2UkhDdnIzdmVYMTdVb1JYTUN5?=
 =?utf-8?B?di9vUTRjWVp2dFZmaXJDQys1bW5HQmtOTEp0OFJpMFFwUVpCY3VCSldwZWhY?=
 =?utf-8?B?NG5NTzUvQ3hzNHFyTlZaYWtRV1FZMFNndXA4WHo4L2pocnFYdnZMZkN6Z1lj?=
 =?utf-8?B?aTlQcHo2cGd3WEdkV1dTSlpIbE5ENDhrdXJFOXpkRGVZODU1SWZiaVFnUld1?=
 =?utf-8?B?aFdjL01HblVrT3RITU9UdGpkL1JZVks0ZCtyN2pWU3E4UlJRSjFXcCticlNM?=
 =?utf-8?B?dUZTV3JobXNhdVRhdktyanZYbXE3R0wzZVNLazVvNWNJSDRqaDBVck1yNlVw?=
 =?utf-8?B?Y0hRK096RHJIcnV2U1FRalJTK0NYbEJJQ1lhVUQ4NnhQbUVPRFlhaGh2NlhX?=
 =?utf-8?B?VkhDWmJCeW83L1FXTGxtUmJ4OGwyc1BMeHc0Wmt5eFRNSE5lRzk1WEpZZlZT?=
 =?utf-8?B?TnhvT25kMXBEOVg4Y2JtT1BSVWEzN2RncHFBL0dVdkRvVTk0Q2xHc1Nwdks1?=
 =?utf-8?B?TFAwSExRS1FrT2xhYy9WY0ZRZmpjNGp5MVB2c3BCc0VkNW1ZOXhQYk9sdG5J?=
 =?utf-8?B?SnVsS1Y1ZCtaU0xtaXU3dFFTT1ZBVWZQNGY2ZitSV2J6V2lPcHFRSnZaN01x?=
 =?utf-8?B?YW5ScnBzUzY4dFZVTTBNQkJVdXdvd2RPQ2ViRW90L2MwN000UlVwV2MyeHRU?=
 =?utf-8?B?ejdpdHhmS3ZjQmo2L2phd3JQUmhCb2FKREZYSWRQZlFjd04reHdsTWE5WmZB?=
 =?utf-8?B?L21Ra1h0L3I0YTVSWm5qOHNVeUpwbXlKRlpiZVg1clQ0a1k5N1BtVnRsYXlR?=
 =?utf-8?B?ZG8vakpTRUJYTFJpQTVRVFRub01RbkEwR01jLy81S29iY3BwNlRkL1dSMmRS?=
 =?utf-8?B?RXZoTXdrRGkwM0VFZkZhRk85TnkxOWQ4UU8xNC9CNUE0Z0xOOW45QWZjSDl0?=
 =?utf-8?B?Q2FZNWJmM281TEFZelRPNjFyUmtRWXFUYkxHQ0VydGVvbzduWTRKY3dOZVhx?=
 =?utf-8?B?M2hNWXU3TVlFc0VSZGwvdmJ0K1pjRjRZdEVCOU96TytaTXBZLytYeHFtSHBE?=
 =?utf-8?B?d0JCM0xyNktZd1JYazdCeFFodTgvby9IMjE5YTFqaHBROUFmbW1nQ2s2cVl3?=
 =?utf-8?B?ay8xaW9VQXR6WFZJbTZPN3NtUzFNbmF0MmNvZ3VpMXBZM0FYT3dQUXgrMUhn?=
 =?utf-8?B?aHQ4QjRWcDRYc0hrMHI2bk82ekdacVdLeDFrZHZFYWRxRkF5S1g1NE1kcXVK?=
 =?utf-8?B?RFNWRFUvSStJdnJHOVZTRDZXamgyMEtpcDJEOXpTM2l6dUExT0swdC9sVVF6?=
 =?utf-8?B?U0xrY2tycnMyWVlIaXFzbE1CeHNMWmV3aW1ndzNPRlkrTEI0NTZZYTA0UjRR?=
 =?utf-8?B?K2Z4dmxCdXBvOWVhbEszSTR5S0NCQ3RqNlh6NzFQYkc4a1NTUjNJMFloOVV5?=
 =?utf-8?B?ZmtmckNJa29MMW1rcWlBOXplMlMzZU5JZW1WV1ZsM2hpaUZiTEIyVUorS05R?=
 =?utf-8?B?TTFudVNiNkhHSFplOVIrUmR2SkZWV1o0YitiVjJSaUljR2o0SlhwdTUvdnIr?=
 =?utf-8?B?K1A1azZDT3FYdk9wVmsxb2tzdDYzNG1qTkJtTW8xb3lodlBoWDRlQytLNk1B?=
 =?utf-8?B?cGh6SXlSdmp0cWhHOUdSamdqem85YkhISDhXNTkzT09KSGhwVVdIcEpCZmVx?=
 =?utf-8?B?cVJpYjc0ajQ5Wmk3bEgrb2xiYklacldKR3QwZ1U1SDlmMEMrazBiMXZMZnly?=
 =?utf-8?B?MmpldzFyL3NpYTZocTR4Z3A2NkNuamRiOGhKb09WaWx1dDcxQ1JycHNER3FO?=
 =?utf-8?B?K093WWxyMWFHQUg5b2Fzb2dqWXNnb01VeFRxeW9EZm1yUlYzQnNmOWh3TnNv?=
 =?utf-8?B?SHlzUkxFL1loZXlFcU1teTM5N3FtVzdYRi9JRm82L2NYT3VrWUUwc3hOcW9p?=
 =?utf-8?Q?bJjqXhdQd8wDmY3X7MF2nhno/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf87409-6fe1-47b3-ea6a-08dd02e10b29
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 06:12:53.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2xsOfE2NMxBT5HeLAO49eTHzF99ZLvcKjzBbpvezx1CnN/n/+Od6h59cihXppFd2m/SD40SEHUrTRnJwsNPFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5533
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Nov 2024 06:13:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17238

--------------Gj00Q75eGmQQnSLMVuNgwmfr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12.11.24 05:14, sai ashrith sathujoda via lists.cip-project.org wrote:
> Hello Chris,
>
> Hope you are doing well.
>
> Regarding IEC 62443-4-2 certification, the certification body has
> asked for Kernel and IEC test results on M-COM device. Based on my
> current knowldege, I believe that the test suites mentioned here
> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/submit_tests.sh?ref_type=heads#L55 shall
> run for every updated kernel image on different CIP reference hardware
> in LAVA.
>
> Since availability of M-COM device on CIP LAVA Lab still needs some
> time, we are manually running each test suite i.e SMC, Smoke, LTP etc.
> from https://github.com/kernelci/test-definitions

https://lava.ciplatform.org/scheduler/device/mcom

Jan

>
> There are no issues with running SMC, Smoke tests but while running
> LTP tests it is trying to install some dependency packages to the root
> file system. Currently it shows it is a network issue but even if it
> gets resolved, the packages cannot be installed because the security
> image has read-only root file system.
>
> Another idea which needs to be discussed is, since Kernel tests by
> name means focusing on testing only the Kernel, we can try to use a
> different root file system to run these tests. But this is just an
> idea, this needs to internally be discussed within SWG and with
> Certification body.
>
> I request you to provide any suggestions regarding the attached LTP
> issues.
>
> Thanks and regards,
> Sai Ashrith (T S I P)
> _._,_._,_
> ------------------------------------------------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#2295)
> <https://lists.cip-project.org/g/cip-security/message/2295> | Reply to
> Group
> <mailto:cip-security@lists.cip-project.org?subject=Re:%20%5Bcip-security%5D%20Manually%20run%20Kernel%20and%20IEC%20tests%20on%20M-COM%20x86%20and%20generate%20results>
> | Reply to Sender
> <mailto:sai.sathujoda@toshiba-tsip.com?subject=Private:%20Re:%20%5Bcip-security%5D%20Manually%20run%20Kernel%20and%20IEC%20tests%20on%20M-COM%20x86%20and%20generate%20results>
> | Mute This Topic <https://lists.cip-project.org/mt/109529918/1050698>
> | New Topic <https://lists.cip-project.org/g/cip-security/post>
> Your Subscription
> <https://lists.cip-project.org/g/cip-security/editsub/1050698> |
> Contact Group Owner <mailto:cip-security+owner@lists.cip-project.org>
> | Unsubscribe
> <https://lists.cip-project.org/g/cip-security/leave/11905283/1050698/1444493412/xyzzy>
> [jan.kiszka@siemens.com]
>
> _._,_._,_

--------------Gj00Q75eGmQQnSLMVuNgwmfr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 12.11.24 05:14, sai ashrith
      sathujoda via lists.cip-project.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Hello Chris,</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Hope you are doing&nbsp;well.</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Regarding IEC 62443-4-2 certification, the certification body
        has asked for Kernel and IEC test results on M-COM device. Based
        on my current knowldege, I believe that the test suites
        mentioned here
        <a href="https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/submit_tests.sh?ref_type=heads#L55" id="LPlnk500022" moz-do-not-send="true" class="moz-txt-link-freetext">
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/submit_tests.sh?ref_type=heads#L55</a>&nbsp;shall
        run for every updated kernel image on different CIP reference
        hardware in LAVA.</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Since availability of M-COM device on CIP LAVA Lab still needs
        some time, we are manually running each test suite i.e SMC,
        Smoke, LTP etc. from
        <a href="https://github.com/kernelci/test-definitions" id="LPlnk743732" moz-do-not-send="true" class="moz-txt-link-freetext">https://github.com/kernelci/test-definitions</a></div>
    </blockquote>
    <br>
    <a class="moz-txt-link-freetext" href="https://lava.ciplatform.org/scheduler/device/mcom">https://lava.ciplatform.org/scheduler/device/mcom</a><br>
    <br>
    Jan<br>
    <br>
    <blockquote type="cite" cite="mid:OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com">
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        There are no issues with running SMC, Smoke tests but while
        running LTP tests it is trying to install some dependency
        packages to the root file system. Currently it shows it is a
        network issue but even if it gets resolved, the packages cannot
        be installed because the security image has read-only root file
        system.</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Another idea which needs to be discussed is, since Kernel tests
        by name means focusing on testing only the Kernel, we can try to
        use a different root file system to run these tests. But this is
        just an idea, this needs to internally be discussed within SWG
        and with Certification body.</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        I request you to provide any suggestions regarding the attached
        LTP issues.</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Thanks and regards,</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Sai Ashrith (T S I P)</div>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
      <hr>
      Links:
      <p> You receive all messages sent to this group. </p>
      <p>
        <a target="_blank" href="https://lists.cip-project.org/g/cip-security/message/2295" moz-do-not-send="true">View/Reply Online (#2295)</a> | <a target="_blank" href="mailto:cip-security@lists.cip-project.org?subject=Re:%20%5Bcip-security%5D%20Manually%20run%20Kernel%20and%20IEC%20tests%20on%20M-COM%20x86%20and%20generate%20results" moz-do-not-send="true">Reply to Group</a> | <a target="_blank" href="mailto:sai.sathujoda@toshiba-tsip.com?subject=Private:%20Re:%20%5Bcip-security%5D%20Manually%20run%20Kernel%20and%20IEC%20tests%20on%20M-COM%20x86%20and%20generate%20results" moz-do-not-send="true">Reply to Sender</a> | <a target="_blank" href="https://lists.cip-project.org/mt/109529918/1050698" moz-do-not-send="true">Mute This Topic</a>
        | <a href="https://lists.cip-project.org/g/cip-security/post" moz-do-not-send="true">New Topic</a>
        <br>
        <a href="https://lists.cip-project.org/g/cip-security/editsub/1050698" moz-do-not-send="true">Your Subscription</a> |
        <a href="mailto:cip-security+owner@lists.cip-project.org" moz-do-not-send="true">Contact Group Owner</a> |
        <a href="https://lists.cip-project.org/g/cip-security/leave/11905283/1050698/1444493412/xyzzy" moz-do-not-send="true">Unsubscribe</a>
        [<a class="moz-txt-link-abbreviated" href="mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a>]<br>
      </p>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
    </blockquote>
    <br>
  </body>
</html>

--------------Gj00Q75eGmQQnSLMVuNgwmfr--

