Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45F0C982E1
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 07:49:22 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44099.1789976959390336555
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Sep 2026 00:49:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=abojxMuy;
 spf=pass (domain: siemens.com, ip: 52.101.72.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecMbJD5xckhhuRwi5s0fs2fMXyxyT9V0n9mlH/fQLLK/wqV/OITOPzuqiS+XHlzvrvPDw12jfuV/yVe/g6sQZHr3QmLTU//8Nm/gDyZ5x/Yo1KtuzmNYJlv0/XXCZJHVKG699o12CZ16sgGsdvcYIBBvqlowkXgGRsMhbWlfOBQPQiQ704zNP6b7EwaLxqoDXZsC4TnB6gxOVjBfju04vM+RuwzsbtB3pEODXYGJi83iayx+nGvPK+7AzxLtGPWlaeTrivAdKTNh4V49LHTo91X6qas7/bI5FFLIja9Y4q0/ybhiNYByBnDviImEpSWRQh6zmWEBYIsqpOqSCvpciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsZt2dLoxjtA7STOfpzo2Q1nrU46mWU4gOyjpLWIta8=;
 b=X/0YCfhEyHchKce0xjcV9B7YVp7FgJ0RwIXiWIXutE50nAtW4iZz38tb9wL1zu4g1X7BxHdy/fmP5/ja2ri4nr8wRot1s4vkuFf8PMu8tWpHxpWJrTVStKARUzEKHBAAkJcpCDxXsSxp2Tpj9pQXFLHuHg4aYBYszWgdYvpSyZlz7Cscl7cxYXCdwsPY0djjiZ9gqdjpUqvWoAzodyke3JamGjDL3yS45LI07nHW4E/x+zuAEHVWEnQ/4pzlhobjNky0f0XwiP7p2xRtrUHaAbbreB1nGQm+e45cae1zXyGp5q+dezgEc5DG8hD2uSzHfO8IziigDTZH6NV7HQAssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsZt2dLoxjtA7STOfpzo2Q1nrU46mWU4gOyjpLWIta8=;
 b=abojxMuy8pimvFTwL2dckWpn+4k31slSnWWKEBu7pciRf/iw7ZnzwSVRMVwpawLot+zgSraiIgOcZ4zTTjS0hcXqCgM9TMNIpShHspHBwawbtCB5KVP4S+mVSRX8wI+/TX9vu1wxzwkHAA1KMaHLJaB4t3BQFw7+sSpTTyY4jKqGy39WwaOwY7fslKn7jHmxq62hJbt8p0uRcZMnqazfh0iZsKBtl5YEuUw6StCmoUo2bktyN9hZJQihOSNrLvKTZItproDeRW8aVWEIxF3+isOIYg82+NgCVVZ143Bwk6+pT3mWb611cRcXXdDbe2TelFclQSN0y3brg76uHKD2Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6147.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:49:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 07:49:13 +0000
Message-ID: <9ac58ab7-f555-443a-b866-6ee083eeb1fe@siemens.com>
Date: Mon, 21 Sep 2026 09:49:13 +0200
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
 <37f91186-518b-400f-a3b1-c61e0207630e@siemens.com>
 <1b02da51fde7d2c2e71f33473ce6c933335df8fd.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1b02da51fde7d2c2e71f33473ce6c933335df8fd.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0439.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 6194adfa-a2f5-4e31-f3b2-08df17b4d48c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	hzRbJ/7LDyWo2hngbe7k7NZFRxY5NXBIJ28LPspP57w4YKbesQFZ8ofjA4OIISbS54WrJsDGIfKVPazLdd8BIuRcDyukR7tRmHpvgdNRUhgSjIG+d34bS+i3H4hfI+73B0yywFjG/eSu1qhGAqrSIT9Lx6hQrHDltZgqKxDQ8++Aa5qciaizyulntuVYpsRfLjstWI3fAYKH1qNCsy03Uzsv1RH9dy+Byff5B7ARF40Z9i/IW+n/DHhQbmO/8ko/9OAKIpEPVO/1mZFj/UXEcquq2kdWEBymDmP/0AY1h2d56wqg3QdAZGRKzGdF2eOW1MM/4gbHLrYj0pDMn4p7agca4LeO0WXeGrZzaxO53Sh/FZIke9xBUo0VgZYoFRkvwZIIqffJ7UKWyQ7AbSsWeAWZCefwwNJBnc0aHjDwcIEJI7idi4Q04usDFG5Mo0/CdjDuycyKdaO4p5b330CEUUtS8yvb6lKlO6fZL6vCVTFYC6tl+5D002do42JLuA14/QEYIMBwfo4hRpXvTDbkEubxGVV0u2J2rgCgKYhqdMlb0DfQJ1v0bDZefBGS8BJ80v24D5yiUiIVflM6QH1reBiZoPOldtqgmDs0MHPxZJ5pQ0T+6uq52fHTqM4YJrKl
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmpiMjFSTy9pcVd0WlY5MnhYV052TFZ2Q1ZMR3JncVRENllVNmNCSTRiWDhh?=
 =?utf-8?B?Y0pKR2t1RXo0UTJHd2RuYzE5OUQvWnl2dXJoRGpUcm9zUkx0ZWlUeGpKSnh3?=
 =?utf-8?B?MVdYbHE0cElYMXZwTjRaOHN6RTFFWkR5cE5teXRrTlRjUGVXdEJzRjNlVHZh?=
 =?utf-8?B?U05GOFQwUzljenFMMzdUZWFvekNyRENoWFpBTytQdUFIRXB3MWJUNHl1Kzdq?=
 =?utf-8?B?SGIzeG93U1o3SFJMaVY2VDNEdXVxSTh5em1mc2I5dHg0RVkzS1dJc0xPMS8v?=
 =?utf-8?B?dnc5elNVSVdEQnJMOE5YcHpuYUNTUzAwelM0NWdEZ2VWdnhZOTFGOEp5MmVT?=
 =?utf-8?B?VjV3dGU1dElkRU5lcUo2YXBhd01tN2V0Ky9qeFR3WnRMczdXSDRLUDhmUGxt?=
 =?utf-8?B?YWlMTXNoK3ZDdmJ3TERvZkFtbEIwRFd6b2VRVmR1dnhmMzhWb3A3ODlFUXkx?=
 =?utf-8?B?VDVlYTFYclpoRkRHTUxla2tVU1hNSUI0VTByWVZkcHU0c1BLalZHMGVBZFQv?=
 =?utf-8?B?U1FRM2FVVk1IS0NGMTBZUGozS2NtRGxIUm5JS1pWLzBuYnFOeHU2SGlxa2gv?=
 =?utf-8?B?YklPeGpWN3BNZ0tTUzZuV3pubmZ6dzFPVGxIckI0ZUlMM09mRkErTEd4dFYw?=
 =?utf-8?B?TzhSQ0RteXhZWGVEZTdmTUNic0pmRnNidjl5Y2s1eTlSeVhiQzNwUFRuMU9U?=
 =?utf-8?B?MzU1VHA1MzVnSU1rcnRtYVN6NXhTeElRUnVZSytONTJKMGRzaWtSNEdzamx1?=
 =?utf-8?B?OWo0M2pGNlVXVklLWmJPYjM5czhrR1BVVE5kbzJkemJYM2pzYkhtMTc3UVhN?=
 =?utf-8?B?bStjbWlWWlJIaS82eDM1VUY2eUtUL0Fhby8yTElFMWt1blRwbmh3ZTR4QjlY?=
 =?utf-8?B?LytEWnBpa2NKampHR3QzV2g4ZlI3MVN5K3FnSFFwc1J6ZXYzMDZmcHUwVGgz?=
 =?utf-8?B?TXRMOUluSHI0T3gxclpwWUp3SFhMQnBrOTExYTM0YzM4MDVKa04vSC9iRnVw?=
 =?utf-8?B?amZjUG5FSkEwK1VveEhjdFpab2Zxc0VjYVJBbzZYbmxITzBqdVFIdmhKVDdj?=
 =?utf-8?B?ZEpVSE1HNm1PZzFUM29wWDdmUllWZGNwaGVlWXRmOXJWYzE3cWRNRmZ2aVRR?=
 =?utf-8?B?TUdaQW9nbzd2d0htRGlJVVlFaVowM2dBS0V0YkFDdkxqdnBOOWhzMGNaOFB2?=
 =?utf-8?B?ZUE4cjMyeTlJR1hKR21yNW4yRjc2SFlxVDl1amlYWnVaZVNJNS81ZFk5UnJq?=
 =?utf-8?B?UHNPRDdjTVRXdzNTYWp4V1o5L1BHeU9aTkFoU2hhN21WYk9NNXhGdUUrYzR5?=
 =?utf-8?B?bnJGMXl5N0RsVHBWeEFoVmRhcWNJT2ZFRXJYZVQ4T3drNVNaaTFCLzJYNDU5?=
 =?utf-8?B?c0NNc0dtd3NoSG1PdEJvNGZ2dllJS1FjYmJURmd6RVpTVkJwcmZjeXQ5ZkxM?=
 =?utf-8?B?ZG5XdVBQWmkzR0dLTGpSN3ZUb01zbDRCcFJ2aG5wdEFmUHVRZE1neERWQWxM?=
 =?utf-8?B?M3NhNG1CdmxNOGh5UWdtczFwTnN5RHJBMExPMENZUlJQQ1lyY3U3VG83UXEr?=
 =?utf-8?B?eDM3em9zL0ZZMkVyOGZIYW9hQko2OTBPS0R0WEZocGFxcFBPODIzWk1oU1BN?=
 =?utf-8?B?MGNuTm9qNjBmYlVRWC9INVlVQXQ4UW5oaUc5amZDbG9Oc0ZhRjE5cUJRYldv?=
 =?utf-8?B?U3hyTDRTUTJQR2R5b2VGZzlUWG80ZVFiRVFiWVRDU2J4WlBxMFdWVXZ4ZnVI?=
 =?utf-8?B?SVZITlFDZzhqVXBnbmZMYjNsZDg1eTY4R2FNZUJLT0RTSUh6aEJnMmFSbGJI?=
 =?utf-8?B?TWYrTVRZRElUZnZNOEg5QXhvSEZ6UVU0UXE3d3h2QzVSdjBmU2lkZ1IyUldi?=
 =?utf-8?B?dC9LUkhCRDlRd3pSSE1wbU1kMjdBNUNjNzdieGZvVE5teVVXSUVTdEtBdk1S?=
 =?utf-8?B?and1RGF6VytOT1F6em4zd1JXc0JqSythMnhjeEFvd0l5ZDk1YXo5dmVaQkxv?=
 =?utf-8?B?SHhuVGk4eHhQcmY2Z0xuaWVoRDBOUHJXMVNDZ1J3MDg2SHRmbHBQSG9TTW9k?=
 =?utf-8?B?b3hXMC84WlVvWkIvMlhSbFY0Tlg5UVlMbXNEcTRrbDg4VTM0L0VQaUV2c3Mx?=
 =?utf-8?B?WWszMGpXb0EvNkhlY3c2V3JTbStzbnRTRXRaWmdyQ2p0SzJsUFYvcFIxRXpv?=
 =?utf-8?B?YzcvS3QyQ0dsWVlWWlBTZUVuV0N0TDc4Q2hJeG1TeCszVGdiNktEbDZOVzUv?=
 =?utf-8?B?WFNJM3lLdVZQdlBTK01XTmY3ZG9OSnlBdDlvV0xuTEMwRFpYTElJRDU4bndo?=
 =?utf-8?B?U3JNUGNhMHBlaFM5YVhpZ0RaSEkyRWZDWldyS0kvMEVNaDFHd1R1dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6194adfa-a2f5-4e31-f3b2-08df17b4d48c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:49:13.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1b6Kz6Wr4nNhwhLRSwGmy6gzv3cYp8Lj6vNrE2d8iD688gD2bXlvSHyCHunIh/56NJRZcJ6C0IIcw28Rh7rbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6147
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 07:49:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24251

On 21.09.26 09:37, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Mon, 2026-09-21 at 07:16 +0200, Jan Kiszka wrote:
>> On 18.09.26 13:21, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>> On Fri, 2026-09-18 at 13:01 +0200, Jan Kiszka wrote:
>>>> On 18.09.26 12:54, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>>>> On Fri, 2026-09-18 at 14:20 +0530, Kunijadar Shivanand wrote:
>>>>>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>>>>>
>>>>>> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162
>>>>>>
>>>>>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>>>>> ---
>>>>>>  .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb  | 8 +++++++-
>>>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>>>> index 263f794..6a5357d 100644
>>>>>> --- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>>>> +++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>>>> @@ -24,6 +24,12 @@ DPKG_ARCH = "all"
>>>>>>  
>>>>>>  do_prepare_build() {
>>>>>>      deb_debianize
>>>>>> +    if [ -n "${SOURCE_DATE_EPOCH}" ]; then
>>>>>
>>>>> Good catch! Thanks for debugging this. Please just use
>>>>> DEBIAN_CHANGELOG_TIMESTAMP instead of the SDE. This variable is always
>>>>> available and aligns the timestamp of SB parts with the one from the
>>>>> changelog.
>>>>>
>>>>
>>>> And simpler code - even better.
>>>>
>>>> Thanks for debugging my bug! :)
>>>
>>> While thinking about it, I'm wondering if the timestamp actually has
>>> security relevance (e.g. for checking the freshness of the DB). I know
>>> that timestamps in general are pointless in this context, but I'm
>>> wondering why it can be set in the first place.
>>>
>>> The DEBIAN_CHANGELOG_TIMESTAMP usually is set to 1h after unix epoch
>>> (for technical reasons 0 cannot be used as this is "magic").
>>>
>>> If we need a proper timestamp here, we should provide a way to set the
>>> DEBIAN_CHANGELOG_TIMESTAMP just for that package (e.g. by introducing a
>>> variable).
>>>
>>> But still, the code should use DEBIAN_CHANGELOG_TIMESTAMP to align the
>>> changelog timestamp with the SB one.
>>>
>>
>> This has security implication because the timestamping of the signature
>> may be compared to the revocation time in case the signer's cert is
>> revoked. Signatures that happened before the revocation time will then
>> still be accepted, those afterwards won't. Therefore, this timestamp may
>> have to reflect the actual signature time. And this is obviously
>> complicating reproducibility.
> 
> This is not just complicating reproducibility, but is in general
> problematic:
> 
> The packages we generate must at least be "logically reproducible" i.e.
> the behavior must not change across builds - which it clearly does in
> this case. Otherwise this package must be excluded from sstate caching,
> which also means all downstream tasks cannot be cached (until we have
> hash equivalence support, which then partially heals this).
> 
>>
>> I would vote for making this package (and possibly similar ones)
>> reproducible to become an opt-in feature that we enable only for the
>> related test. Or only for snakeoil keys. Maybe the latter is simplest.
> 
> No. Please just add variables which can be set from local.conf to pin
> the DEBIAN_CHANGELOG_TIMESTAMP of exactly these packages to a user
> chosen timestamp. Updates of the timestamp must be explicit. This
> means, we are still 100% reproducible and perfectly cachable until this
> value is explicitly changed by the user.
> 
> This of course also needs to be documented.

Sure, but I disagree on having such a variable for production. It's most
often wrong if a user ever runs it with a pinned timestamp for real key.
So better not even expose what will be security-wise incorrect.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

