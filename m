Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA82C27C79
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 04:29:38 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.69])
 by mx.groups.io with SMTP id smtpd.web10.40175.1718857770648318750
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 21:29:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=V2FvzMb1;
 spf=pass (domain: siemens.com, ip: 40.107.104.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuOSaokxRHvmSkPjBJacZdS9HuODhnasLKYWkwjyD4OYwds6DcTRAYxbgszrReTF0dm+V+2VU6/lZ0xt+RIufuMC0uE8QaLBmPsMahVwMehXvztzygYnqYd9Js2SC1+1v5bj3lsS3O6pP3n/UwD2LScEljJlDsDifSrtfwNJjrRkDV8tloBUBIebTWpYSlUalJeJzxnXhHviNWEamcq62CEVTFSDfcMRSV92wRcErnYxjht83xW3q7conaY7nx0L/lqwL1HGhSAPF6htgZjm6bIH4AkO78c3c+FDf7+vvERYPSfDlhVXHEEF0drFTVM7AdNUbKpQfFJYHQ2rpqzNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvampbyN4OJ0vr8wZ+6DgDY8uA+Tk9JhORuOFY+8nHU=;
 b=jxmImE7cFUl4Cok/suNtYsoKutZHtN2qEJPa+Z02/UMKuJ4inppbJRNtjb6vhTB+lSe5QQFcHFwAhw2To94z06piJUsy4MvQaWhB6Rw3I/JUpnJsG10mtoKjhUvfnIvgBPpge5yCWkrh+aL+9yZB9JrY1+iEvdKurLeHLlcfZ8pvE9qmzkNblOC1PAPAUaXWzX66kY0lg6tItOBFHFqEqvGpx53htw5U9Ws4IQ0Yy3/m+aw1VVxXAg+d82wK1WPFA0mV3Iq+O36jPzC9RfLNQrvrKn12siWXpf3rODo3afpK3V782yQh7JB77cV7zjuxxKs/98Y17K52LaCTSKqPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvampbyN4OJ0vr8wZ+6DgDY8uA+Tk9JhORuOFY+8nHU=;
 b=V2FvzMb1zDWsjFs4OWjW8DPpZRRWEsttQEfd+46tDAOO5dz1gs22AeweB+HtU7ZFrqKrZ3Z6QUl3APhxFcVUmX21vcbcpVwVp3UhYbXQfffClEGIia9R63iATZIVN4/S35AIaXWlyTmcVY2llVOCcLMK0hCc4nPmu97qzd6765blgv+/eR8XIU9vzIg1n20vptCG3rY9rX9yQqKoo2KS9mo3XUhmWwEyXdYx8ziFbIXYBHvjPOGh1pigPhj3gNeWnkPzkX2tS0K85THOaUptH2A4Oo3wZYsSFXYQwM+IlbT6H+IQEfJbjaHyxA9thHKbdvxbiqOfUFh4Pd+32F0qNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6364.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 04:29:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 04:29:26 +0000
Message-ID: <f7147f4c-5caf-4c40-a8b0-a9e09f25cf13@siemens.com>
Date: Thu, 20 Jun 2024 06:29:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: MCOM device testing status
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 schilling.benjamin@siemens.com
Cc: kazuhiro3.hayashi@toshiba.co.jp, dinesh.kumar@toshiba-tsip.com,
 bjoern.kaufmann@siemens.com
References: <TY3PR01MB11075D40AA8B013BAF6DED310C7CF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <5e3a4961-6b59-4fbc-900a-981144572682@siemens.com>
 <TY3PR01MB110751E3EC5B5EAE8A15B3A08C7CF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB110751E3EC5B5EAE8A15B3A08C7CF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: cd13f62b-9cdd-48f6-43e4-08dc90e1918f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Tlg2RmdDVjk1Y0xyckdPUGdNVlZLeWZJanRIaVNVRmFZTHZNRytDZWtqUDRn?=
 =?utf-8?B?SHFrRHNIWktqbDlmQk1KcEFkU1NpTkdhU2FJdnZnU1ZOUmlVSUlpL0NydC80?=
 =?utf-8?B?SEdQa0ZwTlBzR0ZTWXJPdS9aeW9RWVNEeGJSMnFMUUlSdEhPdzdHcjY5K29r?=
 =?utf-8?B?c2xNNkp3T3RvdldRZDhnRUlZMHMzbXMwYUJEdG1FbmpXTTNHTHhOeEtoczJl?=
 =?utf-8?B?YzFTRjlzTXhGT2Rsa3VKd040UzV2T1dRTmNRK1ZoeHJrRUdFWXQ4aHFtTnFy?=
 =?utf-8?B?blZBdnR5ZUxqMVIwTGV1WVVtbnhQK3ErM2k2WHRnM2JmNFRXZFVybkhsTkRW?=
 =?utf-8?B?aWVlZUV0cWwyUjJ6Q2V1MFZvcXZ2cnhSUXBNRXlNaVQ3ODFLL2owTWNyZDY5?=
 =?utf-8?B?U25YaVBDZDFPUkRrUGJYc2JFRWhUV1hRejJLRERmMlhyMHFETWJnSmNqTVZE?=
 =?utf-8?B?WVlZUnA3VHlNOC91cmlBcGwzNk16MWJBYnRXVFVWZHRzdENTM3NGV0RrV0hY?=
 =?utf-8?B?ODhQR05ReG9hc0hDUFhBNlovZi9QTVdCaU5BLzE0YWo5d2V6NTNZdTBCdXN4?=
 =?utf-8?B?QkM2V3dKY2FPWHYxTGg1VVYwd090T0tEODJXemY1eURyNzhCY1EzbW1qQUFM?=
 =?utf-8?B?bU9PcUE2ZDl0eXNPMDhHcmZhMEhwR2FPTjlKU1NWWFRLZVVOdTdKQmhWeFZh?=
 =?utf-8?B?aUJVbURYME5TN2ZnT2dHRk84VmcweXM4Ny9YWGNBN2tia1VDUkxncHg2aW9H?=
 =?utf-8?B?YytzdEFhdkZ3MTIvUDBlQWRkajh0dmcySzVCMjgvdVYvdTV0T1FPQlNzVHNU?=
 =?utf-8?B?VmNuek9YazJlOTc5TUdyZG9YeVpxNTdFeW9OeGtFL1NORHp3N3c3TGczU1o1?=
 =?utf-8?B?L2FIdVdtVkMvTFRzVXZmL2dnemZxaTJ3dFlHcVN2RFBKVkFGNDVuNzdYdmZp?=
 =?utf-8?B?WG5LWldia0tPMXpFMVFZNGFjUTZPN3RKZFZsdWx0cGp5aW1INVplZnJQNUg5?=
 =?utf-8?B?ZmwxTzRORG1yZXRQbmZpOXovQm9BbEVRK3hoMnZZeVlESFgwWlZJSXB0Vk42?=
 =?utf-8?B?Q0V0bXYxR2xLMkN6R2picFhzTG9KWVVFZmpOeEp3aS82RGJ3bWhWamI0TzRh?=
 =?utf-8?B?YTJGWFJDL1pHY0t5V3JXRVBYOUhTYTArblFSRlRLeEhQTWpnaEt2VVJTWXFj?=
 =?utf-8?B?RnhrbXpsTkNJMFUwUnI4NzlZZVo3a0tONm9xaVVKT29RelhNSy8zMyswWE8z?=
 =?utf-8?B?amtMemtPTUM3VnYrWkNRa1NzNXdaWHdJUWI0ak5mb1lQd1VqUEw4QnRSR3Rw?=
 =?utf-8?B?SkJ3M3VxaVpXVHdxcFhvdU40RDFGeXNMWmxkWUY1ZmlrUklTdHNsZTd2UWlS?=
 =?utf-8?B?dW1JM0pMSnVFQy9jTEJsRFRuL1BIUDg2Q1FHZm93VWwxTlI5U0VtRVlDSTNX?=
 =?utf-8?B?M3dwOGdMaTdORHRWZll3bDMyOFNxZm83S0hSZitRWXJERjFmcnM1MU5hR1VL?=
 =?utf-8?B?VFl4WTB1aFFha2x0R0pxVFloWlFsRmJJS3E5NDY5TkdmTWQ1ZnZ3TmJWUGt2?=
 =?utf-8?B?RDhMcXdtVkpVYjdmVWN6M2ltMTYvZ295RmI5TElwTVF3ZFg0VjV5RStRbUZM?=
 =?utf-8?B?MEhwemFyNGw3VjZySzJvUGZ0MXQzOExYUU9xVGlrUnl1REdnM0Q1SjJSVGRT?=
 =?utf-8?B?U3JBQlJlcUFrTmdqYk04SE4xaUJ6ZjB4cE5PRnpRRGFncDNKM1VrTE50MGtt?=
 =?utf-8?Q?oFulc41418oOQVA3279C9vTpWLNc/nXmZgW4JPK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGt0VjdyRWY5dnV4KzJFZmZqNkJZb01WWmdSbzczVHBnRmFMVVFQVnFRbGtV?=
 =?utf-8?B?U0thenV6YVNiSExNdzUxYkRDeFdSRlBWdUpkZTE2bzZEVzRuazlPVVpPKzFa?=
 =?utf-8?B?aFA0Sm8vbFBTZW1ZZWRvTkhYQmp1aWpWQ2RNa3JHOGljSkhubmh6MktuMTZ2?=
 =?utf-8?B?TkJ0ZS9xem1HMTRTYTY3dVdzVjJzWDRYTzlLYTd5K002TnVmVENZb1AyMVJ3?=
 =?utf-8?B?K0FIeDRNVy84d0N3VmlwWWhsdktMNzQ5L25vR3F3Q2RvQTN4M2VPSVRtem9U?=
 =?utf-8?B?NEwzVk9XaGQ2UEJmY3ZiL0gvM0pUaFJqV0M3ZDh5b2xPZUV2WHE4a1FwdFQr?=
 =?utf-8?B?UHkvNlI0UVFiN1poS3pBZGViQzdTZWZ5VytUMFZEazQ3bEdJdnVqWG9Ea3I3?=
 =?utf-8?B?YXpqK1FNcFkvMENqSVZpQmppdVhsd20yYVU4ZGpBQlE2NnFpSzFYVkt1VGo1?=
 =?utf-8?B?MGp4N0xaSml5OHdpOURhYXFVUGVwMkFvemo1dFVuVWtHWVZEUTFvU3o4a0RI?=
 =?utf-8?B?MytYbWE3ZVZoMlNiRHdTYkZ4UzBTQ2RVZUdIcUtzK2djRkFLQUUzd0lwSGVG?=
 =?utf-8?B?SjNQYnM4KzZaa3dIQnk3Rmh5UFFHVnZwYUZKcVIzb3BJUi82b0xhSDhKTFhZ?=
 =?utf-8?B?Rmh0ODExNXd1QjVGanJ6c3o4QWxuNmg4Q0xsMUoyVXZGN3BtV1VuVVhrZWxX?=
 =?utf-8?B?Mzg5NVJUMjB0cVNqRytJNi9hemhvd3Z4dTBpMjNTVWhVRlBYUWJPT0gwZm1R?=
 =?utf-8?B?c045ZStaZ0lxK0xkNUpwM2Rzc21mcnVhUWN1dSt0b0E3aG9QMmJVdlh5T2Mw?=
 =?utf-8?B?R2pMTlQ3VVdFUzlPNDdWbjluY3p4Z0NDR04wV2NBUGFwNkxzR2prdXEvdmtE?=
 =?utf-8?B?aTROVWFwa2k3ZDMzdDlSdkp4d1pVK0ZnZmtyUGVkSEdTb0hyQWRWdTdrWFdY?=
 =?utf-8?B?UEZIYkE4dzh5WEw4YzM5ZUNaNm9tbGQrZzcrZ2pmL0M1UityUlJVd3NwQzNM?=
 =?utf-8?B?ajlkWUMrTTFmZHl5aE1uN3J3WW9UUk9LSmtSUDA5NURuM0ZDcmFabjk4WnlW?=
 =?utf-8?B?Z005Rkg4Q2JFOXJPRjlNN1pEcFNJMlV4VHptYXFsUkNpWXRibFZNN2RRTm5m?=
 =?utf-8?B?NGRuRnRlMVc1dGlWL2pHd0NFNzZxMDduK2FwTVB0ZDNhSDgxQ0VWTXR1ZXdk?=
 =?utf-8?B?T0w5aTBhZUIrY3ZaK1hqV3JwWHhSM2hMbDFQcjFmbE9aNE92a1FGSVR6QkdJ?=
 =?utf-8?B?bHlHRGZSYVZFZHZiaW1iekRyTnIrbkJqVS80UDBXZ0hpUlBsdWg5dVlzS0RT?=
 =?utf-8?B?WWxFb0lrV0lFamZSYnBSWkRaTnc4SHdxWFQzWTlLMXh3a05uMStPWkF5blIz?=
 =?utf-8?B?QlIwNk1CTG1qcnhmM0ZXU0E4UXRlK3FKOFBtQjNwaEpDS0RPVWIrU2JsVkx5?=
 =?utf-8?B?WDdpcC85eTRINXMzOWQrOWlLK0lyblVZZWJwZnFkVURGcFF2TUJkd1BRb0hK?=
 =?utf-8?B?UWZTeFJJaW5SZVNvMG8rZ1JsaXlRL1huS2dtSDZraWNBTUFGdU1iUmFEaktj?=
 =?utf-8?B?Zy9TZWpVcnhtdHVqankwV3lKeWFRTFR6YTVIN3U4cWZlcDl6MmwvZDlYZ3Z2?=
 =?utf-8?B?dmY5Tjk0bWgrMmhUZ1dsZlptaDQrbWoraEJSWE9XbjVJeGxSR2FwNCtEVXZ1?=
 =?utf-8?B?VGJqVGZWTm5nc05KV1Exdm9oMk5LOFd0RjB0VkxqZTRrTlQvbVdyQ0NGT2FZ?=
 =?utf-8?B?RlNGb3NCamIrYUlyR1l4RHdhV1ErMEtkNHQ1cGhoMTUzeWMvSmtvakw5N0N3?=
 =?utf-8?B?R3ZZWk5MWktrZGc4aysvN0hCbWsvYlpwdzVPMWVkTWRDenZlOUdOL1ZKbWNl?=
 =?utf-8?B?eXkwQ1lUaUVUYWNPOGcvZTlTR3lPV3ltd0EzMnV4QURmc3ovcHFwSS9vWXl6?=
 =?utf-8?B?cFZKeE1iU2lHcUhHUEpZK3VBekgyL0hOMWRLWDN4RHVaK0dlbDFsZDFwQUlp?=
 =?utf-8?B?N2tsREdRQ0FxMDN2ZVlGc1hKZlJTRjA4SE81T3REdnNjNmFjdHZpbm1QR3ls?=
 =?utf-8?B?aDhUTlg4Skc4M0lUQ2xuZXdZVjBtc2JheXdlQ0VqamZpVzUwWnJXakRvSXhj?=
 =?utf-8?B?NHdlRlFBbU5qM0k2WkpWdUQwMkp5QU5hcFF6Y0xzS1M1L0Y2ejQyV1ZTMHBO?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd13f62b-9cdd-48f6-43e4-08dc90e1918f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 04:29:26.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AuxPGo8IXPo7mkhO4VhLLjm4M3QblvwEoTQGHKzp4VpKKAd9+UWnR6dAacjI2pnYXHfb98HCWkVvNIgjpMmkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6364
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jun 2024 04:29:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16300

On 19.06.24 16:38, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
> Thank you for your quick reply. 
> 
>> Tests ongoing, will be followed by improvements of our deployment
>> instructions (how to get a PK.auth file from snakeoil.pem).
> 
> Ok, understood your point. Readme file needs this kind of information to verify secure boot using snakeoil keys. 
> As of now, I verified secure boot using user generated keys approach by adding new yml file in kas/opt/ as mentioned in the secure boot readme. 
> 
>> We also have an issue on the M-COM that EBG starts WDAT (the default
>> watchdog of that hardware - that's good) but our merged defconfig only
>> builds the WDAT driver as module, and that is not available during
>> initial disk encryption -> reboot loop.
> 
> I see, so if we build WDAT driver as statically linked to kernel, will that fix watchdog reboot issue ?  
> 

Unfortunately, that alone does not help: The device's firmware does not
report the WDAT watchdog as "enabled", although it works. The kernel
ignores it for that reason, EFI Boot Guard not yet (patch sent
yesterday), and that leads to the watchdog being turned on by EBG but
then not taken over by Linux.

Benjamin, we need to sort out internally what the watchdog architecture
of this device is like. If a different watchdog is supposed to be used
for technical reasons, and that one cannot be described via WDAT, we
need at least an upstream kernel driver for it.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


