Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93DFC982E1
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 07:59:42 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44390.1789977581698648650
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Sep 2026 00:59:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TjbmIb+P;
 spf=pass (domain: siemens.com, ip: 52.101.70.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAbS697VfpPc02Fm5kdsvYu9oqAGAHHd7Kp494zNrSVqQbaB0qk413CPk1j3//NADpRODt5q0+LvIx8mnXulfYLg3atUCNx4hsKIWbyiLN57U6uxWK6aC7VP+9dPmkTgJoPosQ3rvv0EILAy5qdO6ZudhxjFde4jlTuAIZEHDDhGOitCfVF+TlHu+/vGhZnxhOr3lsXT/buPyeQrOQLmVGCDiTxITUw+TwYO3Z7ny9TDVdK7uEo3EO/2F+mHjYZGqGed0WA5GXbbgMc1mKL2YYBj2FA2pEZuChWzRnfZHd5tJ189cTAWUZ/f2efNSaRS2NU5wMPoY6HBSqTdOuYkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvqujgFwb6nRPClyjPaHcM8qAHDtsudfi0/mtPQqrfM=;
 b=UNni5i3EtrViMw4DYPj+2JmHpjuJ8wG5p8/K+jnCEqYcpyger0P0MxkWrGi33ckXvFS9KT5gQxmGQLlGPW+tQNu3fOk/5zTMqHXCkMtpiVVHCGVPqq4xCopCJb6Rx65VEMmnOPR4dJSsdiJhTxD+ppko4AU/Bm4zMhUIDTaB9FSF92FLZBQsopdSizo8wWCSKEipQofOTr6l2OwOEZ7b99Hw5WYIY5ZY1zYj+GstDPTuh6ca+r1yug7fMP/qnFFFNkZbUQaDPytiH1ibNPD/fXP6+strTZmFl+5XgZiji/Id1q02oAvPQc5VP6ZeEbMsE/aXlVbzT+MbTepNghXlsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvqujgFwb6nRPClyjPaHcM8qAHDtsudfi0/mtPQqrfM=;
 b=TjbmIb+Py3sC2xCl/FPK2Mtgz/LToScZbnDKbGmeYmdNfcAFHSNq1OqFWaOiQMoc+94efaFfcLnufSALBeaIN5MkHxHWtYyZPazvnDJCQmdZVP96FaTPzF+8o7lpIou9hT6YW8wQl6Q7zVRcapuvD/qkDtVla9nsxNT29WIg2GVmbCH0ouwauDAEx572jceS2N3IBdZUlcSMcYPeO8tiOq1XEh8JfnHgyNGxavav3c0LJ7U29zEqIaYcRnL6E6zwXfxxXV/B3Qyt1n2hEUZC3maufROUr+RgtnX4LyTcT8tNhz5kvwmEIOMyUZcsavaTX4Ool0fFr6ejeGz0bTaIhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:59:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 07:59:37 +0000
Message-ID: <545bf5e3-17e4-4092-8278-fbea9b293cb9@siemens.com>
Date: Mon, 21 Sep 2026 09:59:35 +0200
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
 <9ac58ab7-f555-443a-b866-6ee083eeb1fe@siemens.com>
 <639005687857cd59d75b22b7833f47bc68badefb.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <639005687857cd59d75b22b7833f47bc68badefb.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0293.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: c1de6058-f7d7-492e-f2bf-08df17b647ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|4143699003|11063799006|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	AD9UNb7QovuNFDjjXM7agDFP6w1OkoEs0mwIW5GzcvAB/N9AnJ5JD8km/QH6jcGxbe6suH0FCykO19Ls7LOwHPVzqa05qosgXZCGabzBSbYqkyGME3wr84KyKyNQJWLQGS3k19ltvNee7p1kdkSoY9UqgMuZo+cAsVmitn6SMmBz5EOBB7V3aA+XseLiXQPVbmFthI4GHn1x+XYTR888qPorLi5apsQOEQd90ZzW+LuBbZXjQmag9wWqKrUawMztV7fXDrrU99+mnncRvUmffP+dciyI/Pd8hpFKzWgy5kdRJhskgubchc9+OHe8A/KwUiYgcHd1SDXvdXO9JEH6312jtcBqM6G6FjR68pA/VxDc7zokU5UzolvryrgI3CrzBGaMS8Q9LZErUOQ3V/9CzFZmboaZOqGT8M7T4PsQ3ZuZeIRSOidBEWX45o++49QJ5SDFkLsNmbKFVyelIe94D4RqhA+3UPTheEdwoWNDPEWKsTyx/JSTPFobeGrkDdgtbegvr3KBc5YVb60xJ3kIpV+nuhbl9TQY6+7ofxySBZbJv3aDYgjc0DmSzoXHHYfOKxaW6U7zzDOX31LeNSw7LuBwlA1uyoh7bbWJRyr49Sdi5f85ZE3tUSWQMLJW+vU6
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(4143699003)(11063799006)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MG01SFN3R1RsdGRoWUFQWEl6UjBjblFLU3pPTWVOL1FQTnBiU2VKM0U0bEZV?=
 =?utf-8?B?QXVSaUxEUjM3RlhYS1BhMnB6YWRoYVBCME90SjhwK3FDZU5FdGwweEY2ME1E?=
 =?utf-8?B?TkU1OEtmVTZRNzY3QzlsTmVGWmxsZ0dNOURFUTIxM09CNy9oZ2ZCVEVxZity?=
 =?utf-8?B?eW93Q05wcTVQUDk1dGtaUjhXci9WQmFBbGxsVnhEaEgrSWJDc1o1ci85blp4?=
 =?utf-8?B?YXNRME8ySUxMYktDMEUyTjBIUU9BTzhJN3g4dlZqS2hDa0V1R2MvNkFrOVY3?=
 =?utf-8?B?cHg3R3h4UkFlbEZKSGpxMm1NcTlySFQxbjRRTHg3TmxmVFRXODJoaHJJN3Rt?=
 =?utf-8?B?N3RUemJMdHZDV2pic3A3SStya3hkdngwT0pLK2V0aGc4RXhUQ0RORzNid2dQ?=
 =?utf-8?B?aXNoMW1MdVZrN3p6cjFUK0s0YTIxdlRVWUE3Z2FValRLcHJSMFhYZjlYY2JG?=
 =?utf-8?B?bHJYZk55QjFBaCt6c05ZMjN4bFRtcUJFNmRKWlEwanIvZGtVQUI1NDhTT3k3?=
 =?utf-8?B?ckpSdVlkQi9IVWxiWlVoYk1aZ3RLUzczRjRkeEZZK1g4UUVUTVZVVE9GZnly?=
 =?utf-8?B?eTVPMVNscXNXVVhhZ3U0UFNmdkNGdk8wL2J1L2c5QlhMVlkrUmxiZitwZG1Q?=
 =?utf-8?B?NUlsSE5EeU5DaEVPdWkrTUpCSmJtVkt3cTdSek1KZUUxV1p3YzZOM2JJQ0RB?=
 =?utf-8?B?KzV0UlhpSFk1Mmx1R1ljTUxReEl3eUpkMFNHNWRKM2NadVFkdXdLclM5c0xH?=
 =?utf-8?B?N3FKcVU0L3J3UVd3emdDTTBBRVBjTEhPWGJIdWRyeTFjUS9VRmNSLy9wTkFJ?=
 =?utf-8?B?aHR2YlBKMEVGUHZNd1BaQklXMnQ4bUs0VU1vSllBcjlJY1hJYkgwdHVXWkJv?=
 =?utf-8?B?akczK1dOUVlQeE9uOUZVMDhCcHNzaHBhZW1BRGVsM2RXV0tEUGJOYnlOTVlq?=
 =?utf-8?B?Z3pmR2poeGd6Z3ZvWldubUk0djlzS0RHOTlFU1I1UHFXb2Y0QitEN3NFa2ZQ?=
 =?utf-8?B?NDdRcUVZaW5GbUwyQ1E4SEVXRTdFNFNJOFcwejJqU0ZQbklndkZUZWU3ZnRq?=
 =?utf-8?B?OFBrTEd5b2FCQ21VZmNLQVFYclFpZGI2bzA1RzAvNjRsNS9rR0k2bkdjWktr?=
 =?utf-8?B?eU52Z1JhY2VXYmRDdlVZL01aMnVaQUROOVR4S2J1TmVyT0pSYm0vMlhUTWJV?=
 =?utf-8?B?bkVRTXJvZ2l3OWlLUllDSzU4S0VIck4xZ1Bkc09Kam9iaGsxSFZkdTFIOVR6?=
 =?utf-8?B?SHdCVGhPd3ZOWVdYNFNvYWJIVnpQV1JwejBLN0ppb0JWSHcxRFhRN3dyK0tj?=
 =?utf-8?B?bW1NQyt5WkdVbWNVVHZFN0V0Y2tiZUlUSW9KZVE3VXlXeHRKaitVYzhTSHN6?=
 =?utf-8?B?YkFBam1nbGNEYndEWnpHNEpOYXE1UUJTaDAxbDBQK2xKSThDdytaVUFaQ3kx?=
 =?utf-8?B?TGRDd291elRGTU9hQlcyMkhKZGJmQ0c3OWIzemUxU1I3cmRSUXZPbk5JbXBR?=
 =?utf-8?B?VmJVVmtpRUR2UzUvQ3l5a2ozb2U1N25YYmdwenRaSHYzYXBvcGw1c1BhK0cr?=
 =?utf-8?B?RUpDdmI2WWtOTzcvUGV3OUl4YW9jOHFRYWxraHVkd05lQWp1N1dhWnNCQmVI?=
 =?utf-8?B?VnJKMUJFbDZ5SWJmNS95K0xQbmxXZUJsdlVjUk1LQWdHMFZlaDJmOGNGSHdh?=
 =?utf-8?B?RGdlZmxTMEVZbER1YVNMV1VyQnNiRjFYbkhTTFQ4VEw1WTRiSW9nSzFYNGNB?=
 =?utf-8?B?cTFFL1pudUVyS2NVUnM5L29XV2hMN1VDSG1LZnJMR3ZBbzZ1VmVuRHhCenNj?=
 =?utf-8?B?UWExNFlDUkNvNEZyZFlRSlZRd0dGQy92akI4ZU13L0ppZEhYbHJDeFoyYXVr?=
 =?utf-8?B?aTdjT2dZcFA2ekpIWDJVbGVyVDJ2MkNveUtWdmhOSEpMcWt1cUxzcWJ2cnNP?=
 =?utf-8?B?VWM4YXdXTnRNd2U2dTRkV1hYWjFMTW04Y1FUZm5yOVU5djNkUEZuUUpWZDZW?=
 =?utf-8?B?YVJ6NWpPUUJHNFVIZjRpY1l5OGYvUFg4d0hqdnZGWnVRN2hOaXZOYytISTFo?=
 =?utf-8?B?L25vM3BEOEt4R1FXOWZnaXY3OVFjeEZZVXZyNnY2T0hyU2x5ZWJ1NGt1eWhU?=
 =?utf-8?B?SkxzVGFBMjNqYTBDUFdPQnNiZkVBN1JhTHkwVXRkeTdiRlFSMjlsK2dKeUxv?=
 =?utf-8?B?UmVhWm50cTRBOGltSDhtY2NjZXBNejdvMlhPYTh6WVMyclhpUGpBZVpPSFZY?=
 =?utf-8?B?NUJCQ1hMd3R6UTZDNnhzTGh0M3FUZW1CUHRrL3UyYVFpNnF6TXIwK2R4T1k4?=
 =?utf-8?B?STJZMGpEcDZyR29YaFNhNytsdFBUSGN0cnZzN3NHWmlwbzhMeFM1dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1de6058-f7d7-492e-f2bf-08df17b647ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:59:36.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYD+BozUffGOKyCUxctVBwfVn0SjeL75A4UxbMu9RqG7VETcviDdcgULoOgYLteFTt7cxoJpgd+GBGCGpf4SIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 07:59:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24253

On 21.09.26 09:53, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Mon, 2026-09-21 at 09:49 +0200, Jan Kiszka wrote:
>> On 21.09.26 09:37, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>> On Mon, 2026-09-21 at 07:16 +0200, Jan Kiszka wrote:
>>>> On 18.09.26 13:21, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>>>> On Fri, 2026-09-18 at 13:01 +0200, Jan Kiszka wrote:
>>>>>> On 18.09.26 12:54, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>>>>>> On Fri, 2026-09-18 at 14:20 +0530, Kunijadar Shivanand wrote:
>>>>>>>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>>>>>>>
>>>>>>>> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162
>>>>>>>>
>>>>>>>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>>>>>>> ---
>>>>>>>>  .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb  | 8 +++++++-
>>>>>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>>>>>> index 263f794..6a5357d 100644
>>>>>>>> --- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>>>>>> +++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>>>>>> @@ -24,6 +24,12 @@ DPKG_ARCH = "all"
>>>>>>>>  
>>>>>>>>  do_prepare_build() {
>>>>>>>>      deb_debianize
>>>>>>>> +    if [ -n "${SOURCE_DATE_EPOCH}" ]; then
>>>>>>>
>>>>>>> Good catch! Thanks for debugging this. Please just use
>>>>>>> DEBIAN_CHANGELOG_TIMESTAMP instead of the SDE. This variable is always
>>>>>>> available and aligns the timestamp of SB parts with the one from the
>>>>>>> changelog.
>>>>>>>
>>>>>>
>>>>>> And simpler code - even better.
>>>>>>
>>>>>> Thanks for debugging my bug! :)
>>>>>
>>>>> While thinking about it, I'm wondering if the timestamp actually has
>>>>> security relevance (e.g. for checking the freshness of the DB). I know
>>>>> that timestamps in general are pointless in this context, but I'm
>>>>> wondering why it can be set in the first place.
>>>>>
>>>>> The DEBIAN_CHANGELOG_TIMESTAMP usually is set to 1h after unix epoch
>>>>> (for technical reasons 0 cannot be used as this is "magic").
>>>>>
>>>>> If we need a proper timestamp here, we should provide a way to set the
>>>>> DEBIAN_CHANGELOG_TIMESTAMP just for that package (e.g. by introducing a
>>>>> variable).
>>>>>
>>>>> But still, the code should use DEBIAN_CHANGELOG_TIMESTAMP to align the
>>>>> changelog timestamp with the SB one.
>>>>>
>>>>
>>>> This has security implication because the timestamping of the signature
>>>> may be compared to the revocation time in case the signer's cert is
>>>> revoked. Signatures that happened before the revocation time will then
>>>> still be accepted, those afterwards won't. Therefore, this timestamp may
>>>> have to reflect the actual signature time. And this is obviously
>>>> complicating reproducibility.
>>>
>>> This is not just complicating reproducibility, but is in general
>>> problematic:
>>>
>>> The packages we generate must at least be "logically reproducible" i.e.
>>> the behavior must not change across builds - which it clearly does in
>>> this case. Otherwise this package must be excluded from sstate caching,
>>> which also means all downstream tasks cannot be cached (until we have
>>> hash equivalence support, which then partially heals this).
>>>
>>>>
>>>> I would vote for making this package (and possibly similar ones)
>>>> reproducible to become an opt-in feature that we enable only for the
>>>> related test. Or only for snakeoil keys. Maybe the latter is simplest.
>>>
>>> No. Please just add variables which can be set from local.conf to pin
>>> the DEBIAN_CHANGELOG_TIMESTAMP of exactly these packages to a user
>>> chosen timestamp. Updates of the timestamp must be explicit. This
>>> means, we are still 100% reproducible and perfectly cachable until this
>>> value is explicitly changed by the user.
>>>
>>> This of course also needs to be documented.
>>
>> Sure, but I disagree on having such a variable for production. It's most
>> often wrong if a user ever runs it with a pinned timestamp for real key.
>> So better not even expose what will be security-wise incorrect.
> 
> Hmm... A user that adds secure boot support to his image MUST know what
> he is doing. We can't "hide" all the complexity.
> 
> What are the alternatives? We can't safely use a floating timestamp.
> This makes things even more incorrect in most cases. Along with the
> global variable, we could issue a notice regarding the used timestamp.

As I proposed: Demo keys can be signed with pinned timestamp. Regular
signing must have the timestamp of the action to reflect when this
happened. Otherwise, you risk to resign something with a date that is
older than the meanwhile declared revocation time.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

