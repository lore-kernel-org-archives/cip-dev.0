Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1261C982E1
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 05:16:44 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42721.1789967800492704229
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Sep 2026 22:16:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uyCjOyOC;
 spf=pass (domain: siemens.com, ip: 40.107.162.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hmjf4/2yc8m9Gyq8AUmA/gHCQLM25AkvbeXr5NEtpiV9t6aH7GMNc19DyfXdi/DkksfZbcTw7rhukx1hGEcLverF6gT9P4Lnq68OKUaBOPQ9+2Qup7nyRrSKneYgq5AZyItJLh0SoBi8aAmeZgWgtSTjoIQaqnn5wImOhZgadmX0sYUWwWBPdqFPunMl67CPGtUjEMREDJzzXJqOBg7NIMyJ8omNEmxsNwjZUUACmRZMUUH5u3jj/g7tiZK96EFEKRp0ilS3qHfchhuIbhPq45CSuO8WteKALcZZd+5gUyYUyYtOtt1ECDafJzIRZCApkNZJ7xeeNjnPv8D2ztStlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+enXAm/B6Z9kGzvpMJ38N/E23wv7GXTNCKf0hxElrus=;
 b=ARUDOedQtR1Gkx2tQbhKg63iF+HuemY1VDZApGIdEDgik8A0y/F2WOzDfcWV9Iqh3GUN7bQoHbiuzybGVNm/4DpF2kMG/Nz/vp9UoZsa4Hl4N9IQQ674lT3eGjQ3HzKfvP7IZf5wYqSedcfB3xaiGjJrz1M/lpDXJXPINq4lzwvU0POIsAl/munYbFT8ccOeEsGyYbxMsBilJh3dw+SLb8HgN1n3CNo9fRkkyTeEnvNVQ51vmzwgFyj4qmo+W+Z4lIVKYLtIJM41AZx9s6ftGUEroRqVvgHrCAoZav2tSyEhtipZRksTk/BoivBsFbxtpA0EUtorW/AlyY2tFLpMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+enXAm/B6Z9kGzvpMJ38N/E23wv7GXTNCKf0hxElrus=;
 b=uyCjOyOCK5Y/hqu6dycb0Dj/QisuUrSX3Fzqk2XSjLaFMG9zmLgE2DF2Bp7W75GqST6619fDXbBDZmA3cjB/4Sg0Ae/EEk1gzkaNfbwW3NPv2BL+Uh+LayzgnGLjBZUhOMTN1Z8E1RX7xyKMLZYu2tsunhvs1L/EtDinIGygBeCdiyG7sgDqIVPwCihhD+/m9Bd8UbR42ezqdVSLdWMPP1oRKwlGpkQVraxpokcPRrzy6maiknq1fOBeCvh3zkraG9BUskViGUEGAUQ2jXAgX1qNjOE7f8mpCrJ1N7EATigT5uXaVIhorw4YRornZkPXFpEAidtAehU7cGpQ1mJxJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3272.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 05:16:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:16:36 +0000
Message-ID: <37f91186-518b-400f-a3b1-c61e0207630e@siemens.com>
Date: Mon, 21 Sep 2026 07:16:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 Kunijadar Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "kazuhiro.hayashi.f74@mail.toshiba" <kazuhiro.hayashi.f74@mail.toshiba>,
 "kumar.dinesh.h95@mail.toshiba" <kumar.dinesh.h95@mail.toshiba>
References: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <88b6f524427c6415422dc6dba589b4cafb4cd439.camel@siemens.com>
 <868cc7cb-d990-42a9-a759-05f7cfc22e36@siemens.com>
 <004d186545ac4db6066399ccbc21cfe43a27cd66.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <004d186545ac4db6066399ccbc21cfe43a27cd66.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0363.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3272:EE_
X-MS-Office365-Filtering-Correlation-Id: 623c19b8-7f32-4ec8-2236-08df179f8207
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	tK0kNjurLLl66Y+X70HGdWYP7WJW68XR5WgZm6vJTAzxXzyjzCwoA8aVetEnartTzd6y/DEn+zjDU2GK+28Skj8VcVVn9DUVy2eS86wFdlSLo3+2rBJvUnjTBNupQBZr0qZeSyli2huOpV8lEYzV2YpSDflCNGLsfhbcnLfj2xJhSGIvRF3bqzxmTVJzcxHdOGD5RSkJ2iji4K5XOTHx46LSnldv3B9EKSmqmBZeE8Myc0QhGBXyK1wxqvDU1LWYR1zsBItiGAe0cmvGR0OuUuESko0MBSgFdGLFiguLbWYIGbQsBxvkIj16HiLKyDyn8MnUhzlhmJY3djj/OVao74gfhTBluNDi39aqmFPZVGSTWddjQmNCg77fZhJY6xcV8X43fet7yZ7MSzxgtHju3DrpHRJQvMXXBMHsGpzx4wVaa/U5lQ2OMig9oDkTGh/Kb84e7a0YAmmF4ruEaUsr7Bt4AtlQegaZn89YAFrpQAljr7c6mxoCZV7Sswx3TZMMMJRl8+LyJCDO7nOGBr99eD6ewIqDj3HEyU0k6aCEtCGBHfVzntohKg7gD4fqy7jm3xJuiEtyMXatFY2LM48y9BqCcGyUXPaA+sFcx3+Qy0hGBHKdK+GjOWcw8XuEs+P/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2VSYjhqbUl2QnZHMXhzQkVSei9CSS81QTBrZGRaVWFrTjFhdExXUEZlanRj?=
 =?utf-8?B?Y2xlT1k3M2NrRXF3blhoNlN3Q0g5SzFkb2hPVUhoNEVNQmJVREN0QjVDL3Mv?=
 =?utf-8?B?R3R3MHF0Vm9RNmFLb2FaOEVPRkx2Sm5IcVJUaDEwNFQ0NmgyRitTT1ZTenpl?=
 =?utf-8?B?M3dDckEwM0Vhc01WM2UrWFVEeVUySlMzUkpCTGdsZjdSNTgvY3R0SHRNRkFM?=
 =?utf-8?B?ZWh2UlVCL1A0Nkk0RkcvZTBZTVZxMjJ1eCtTRldjamtCTGQ4THl1em40Qld1?=
 =?utf-8?B?VTlteTVXb3dvOXhZNVp3WlV6WHFHcW12SExxVEJPc3ZYRnhlbnptODMvZmlZ?=
 =?utf-8?B?aHI4SFFFMVBYb0gzRDQrU1NSclp3V09QQi8vUkRKcU02YVRZbWI1S01MbEVY?=
 =?utf-8?B?WVlNNEU3QXYwdXMrV0V4RENOTUJNVmpNTWlNb1dXbDNubXZqM0loakxlY0Jm?=
 =?utf-8?B?RVFYbFAzSk1qdnh5L0FzRGVkekJ3YXFoTVhwYXdsZVJic082Sk1NclpQSFNu?=
 =?utf-8?B?YVNkbUxKNWZ1RjlrYnhRcEdadjZoaTZVY2pZK0RPRVFxRllmbFV1OWVRK1dn?=
 =?utf-8?B?bWc0VEpBRVBHdlpKUlJSaWFmUUpOMlROaEkwYnVTM21UVVE0cUNGN1NtR0lL?=
 =?utf-8?B?NTVmNzN5Ym0zQXk4ZG9GWmI3ZDRXc21aWFE3TGduYXV1QVlxUkNJYVJHUStP?=
 =?utf-8?B?TGpQNHFtK3ljbHRiNkVNWTR1RUx1TE1vYVBBWFhhdVFCT2huWUJLa1Z1bGww?=
 =?utf-8?B?SklUQ00yZW5EYTAyclBUM2s3d3pqQTZRanlBNnc1QkpvWDZtbjV5WUoyZDJ0?=
 =?utf-8?B?ak4wQWRDYzduOU95SHNaZDdZMjBrVU9SSnlJdHJUbFhGa21jYVVwcjRFd0xo?=
 =?utf-8?B?ZkJkVC8zU3E3RmV6TC9iV1NLRURRQjMzaWxUU2RMdGp1SlYzTVRxbGQ5cmhx?=
 =?utf-8?B?c1pMbUp5U2FJQkRpRFBudFlEMS9uc2JQUDNHNkpTYkgrSFEwNDlFWk5lRlF6?=
 =?utf-8?B?NjJqTnVYeXdoU2ZlL0t5a2tQL2tCZnIyanJBNlpUQ253dWtwaWVHdjBJOGxl?=
 =?utf-8?B?bTMvMUU5V2YzMFdZRTNaMTZhdkNCY0MyZHB3U3EyYXNDK2t6SVREL2lSRWlD?=
 =?utf-8?B?MlAyY0pDbWRscXB3RUFQV1hLaUh1dmRNbk1RdllLcG0xVjBadmM2ZmNyb0ty?=
 =?utf-8?B?NUNyNDBzTy9xeXpaMTJST3lkdG1KSnpLK1o0RDlKaENiTEZwUFJxWGRieWxs?=
 =?utf-8?B?NGxEQWpueGYwaWcya2hPeGdjWi9rUmNETi9HbmNGZmN1K1V4S0pIblRWU1lZ?=
 =?utf-8?B?dXFCNXJ1T0hyQlQxdjc1aThERTMxRlQ4bFZhKzRGRWxrTHpsWlQrTy9ZenQz?=
 =?utf-8?B?Tkg5N05nS25ONlIxdStFNEJTbFdxTGtPTHNnTVl3bzEyTUZaalhhaVZJVVEw?=
 =?utf-8?B?Y3BlSjNzTUpqQVkycGFJRG5UOGk2WHUwTUVwci9rQXBNWjJVYzRpQ1l1Wk5P?=
 =?utf-8?B?c0QvRnNxMk1ZY3VScnl0S2draUd3ai9HaFREZTdwVnpFcmJUNldib0FmZnAw?=
 =?utf-8?B?bUpJakhhOTQ4SW5qZmUvRWZMSW8rMWs4aG1PeTRja3RRNC9JUDlyVTNNbmc3?=
 =?utf-8?B?RDNGSFl0c2Z0TFdib3BxZ0RaWUFyYWpsc1BVdGZYam9vSXZhMkk3RjlvZ0dS?=
 =?utf-8?B?NjFoMmRJRVA5L0wyaU50UFBSYlR1MFFMSjFzT0ZFL0xDbTdDOTc1V3haYm1Q?=
 =?utf-8?B?aUJXalNpV0xZSFZqLzVoeTRNck9LZjM1UGU2S2RXYVpFU0g1UllJQlZGaDUv?=
 =?utf-8?B?T1psNldXcXJ5YlpoUVI2TWEzYzRtYXl5NytRcDYvUmVTVU1VOE8rMENIemVp?=
 =?utf-8?B?MzNYOTNIRW1kTS85TWtxSE9QMmJ3WEhsc09SSXU5amlLVVlNZlJrSHJ6YmUz?=
 =?utf-8?B?T01ONEc4dWxNbzNPZFcycEJERXJTMHVsMWNUNW9qbUh5Y29sLzNjWWZ5OVZU?=
 =?utf-8?B?b2t3U0xNUEdWbyttR2phQk42MVFGNnF1bURld1IrRUtIdXBzTlNnQ2hxaDB4?=
 =?utf-8?B?Q3RPWkw3T2xNcU1ySWZtelA0a3ZjSTlHV3d3cG5kZ0VMdHE4c1dUSFJNZ2E1?=
 =?utf-8?B?ZnBXd1graTRyc3JFaUp2NzNCQ2xlbGFTdUpCeWRKUDBLT2p2UXB5d29pY25k?=
 =?utf-8?B?bDh0d3QxUHdPb25IQzF1Y2Frd2daUzk2cWVHOHRpeXJxSFA1b3FIcjBGSFh3?=
 =?utf-8?B?UnpFQW04SVc4Q2ZOT2FsZ2tvcmlKRUl6MUgzZ1hMRGhHVHVGWHdZa1RCVEsr?=
 =?utf-8?B?UVF1WDE1elNvYXc1eXErNjdoKzJIN1hFc1o0cWlBa2tHOE5TbXlMZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623c19b8-7f32-4ec8-2236-08df179f8207
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:16:36.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klufKMzLV9u/BuVMLapyzE+WGMWlSYB8GbZdUYnY5uql7ypNej2A5c4BS2WRQOvFMr6lIWz8NXyjXcUfqVW5ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3272
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 05:16:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24247

On 18.09.26 13:21, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Fri, 2026-09-18 at 13:01 +0200, Jan Kiszka wrote:
>> On 18.09.26 12:54, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>> On Fri, 2026-09-18 at 14:20 +0530, Kunijadar Shivanand wrote:
>>>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>>>
>>>> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162
>>>>
>>>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>>> ---
>>>>  .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb  | 8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>> index 263f794..6a5357d 100644
>>>> --- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>> +++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>> @@ -24,6 +24,12 @@ DPKG_ARCH = "all"
>>>>  
>>>>  do_prepare_build() {
>>>>      deb_debianize
>>>> +    if [ -n "${SOURCE_DATE_EPOCH}" ]; then
>>>
>>> Good catch! Thanks for debugging this. Please just use
>>> DEBIAN_CHANGELOG_TIMESTAMP instead of the SDE. This variable is always
>>> available and aligns the timestamp of SB parts with the one from the
>>> changelog.
>>>
>>
>> And simpler code - even better.
>>
>> Thanks for debugging my bug! :)
> 
> While thinking about it, I'm wondering if the timestamp actually has
> security relevance (e.g. for checking the freshness of the DB). I know
> that timestamps in general are pointless in this context, but I'm
> wondering why it can be set in the first place.
> 
> The DEBIAN_CHANGELOG_TIMESTAMP usually is set to 1h after unix epoch
> (for technical reasons 0 cannot be used as this is "magic").
> 
> If we need a proper timestamp here, we should provide a way to set the
> DEBIAN_CHANGELOG_TIMESTAMP just for that package (e.g. by introducing a
> variable).
> 
> But still, the code should use DEBIAN_CHANGELOG_TIMESTAMP to align the
> changelog timestamp with the SB one.
> 

This has security implication because the timestamping of the signature
may be compared to the revocation time in case the signer's cert is
revoked. Signatures that happened before the revocation time will then
still be accepted, those afterwards won't. Therefore, this timestamp may
have to reflect the actual signature time. And this is obviously
complicating reproducibility.

I would vote for making this package (and possibly similar ones)
reproducible to become an opt-in feature that we enable only for the
related test. Or only for snakeoil keys. Maybe the latter is simplest.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

