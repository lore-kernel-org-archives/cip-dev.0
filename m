Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6039.1795181750467816061
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 05:35:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ClhHCrxl;
 spf=pass (domain: siemens.com, ip: 40.107.130.12, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANqf4yF/fSz072pa21mob85RtUxeAAQ+ZtdIk09LyEWOxmLYIWwWHjrpXwzC8ARVTcPE3Bom5g6uyQoAF5kj3f1NbeIHVUeuOQwarTIupB8C4TKdjXtpD8z/XcHpoox99s+bV53NCLw0pxQID/HgiiR+m+EfM+vGrglSuE6J+Tfou0gKEyhlgY0BxFI22pPc2l+U63G+QfmIdBRE7Sp3yEhRYLrvdztfgjtlfQj6aJ2siBXs6k3RJ0ox9DGZSPjr8M0SmdJwOrvOK7TJ23qW+N8XZYRe4eN5EkjQPM8ogz1bt3kRA1qkUYm7NvtMGrqb79lZlPl5yDmQtTY5dUizVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrKedEoZ9K+gb7LaDCVGAobXClXY9jEDZUeB1fGgd3M=;
 b=a8F/owrwDxO7D8WdnqJR4hE/Xx4NJ2f4dKUwWJwHcDn8ozLKeZsOVcS7oDgOWku9IJ45jdV/3EOZjTuhqzmESiZb/XxlyDjFwIbn/JEt23QQ6NzeX2sgaDglUKQPp9I2K1EOQKXF2R/QGYP7RovnpLjE11Ne5QGKxUCTDUe0dM50pemvClY+FDGk6eJFJiDNUaG9R2t0anVbMLaBc/oqHzUI/Box2u9Ma24y/qeaoFXMu1aqZE/8WFD6IzTWk3Acn7YNQOk0hnOVB8z6ImPLr5vaSDubxV1PjwF3ChlmqXWVmOB6W92PP3Ck8dwayD/7JzdoXj1wEW/oBxT0uvJs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrKedEoZ9K+gb7LaDCVGAobXClXY9jEDZUeB1fGgd3M=;
 b=ClhHCrxlUtb2lzZIaHgEFdnCAZTtYFw1MShiygSKVTPuzMB4VKCMJFnj14Q0NyWWyYhP1RPcgnWEz4DC8YsEnrPLzQTlW4XaMbQI/c246pB5BLX/hucnBSg/pfFszwmbPslx3Cem9x7UXJCBMx4j6PYZmHaUzfCcms+8nDGLg0DR4xnhqvNhjoFRgQVa7UlnnudmWcZ/MFkk5kZjWweEBPtnzNGl5o0a8KkuIH4gXub6b7RPMV0GJ55BNIoj3I9wMr35gyQCs+oZ6SHow2Qboz9b8sHuvPVo/fNO4RCDRgBHCsFjHDtQyHxYOJ9zvr1byvLTl7ISusjVgsIeRzAVfw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cf::9)
 by PAWPR10MB121500.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:3ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 13:35:44 +0000
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7]) by AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7%6]) with mapi id 15.21.0662.000; Fri, 20 Nov 2026
 13:35:44 +0000
Message-ID: <95a45e5b-0102-40fe-9b8f-4b2c781eab1e@siemens.com>
Date: Fri, 20 Nov 2026 14:35:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Best practices to write CIP kernel details in a SBOM?
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: cip-dev@lists.cip-project.org,
 Akihito Irie <akihito.irie@atmark-techno.com>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <av-icExXuq2zIc1g@codewreck.org>
 <5a903376-5387-4836-9878-12db2e79afab@siemens.com>
 <awBDeyRZVzpnrQIy@codewreck.org>
Content-Language: en-US
From: Christoph Steiger <christoph.steiger@siemens.com>
In-Reply-To: <awBDeyRZVzpnrQIy@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::8) To AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6cf::9)
Return-Path: christoph.steiger@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR10MB9423:EE_|PAWPR10MB121500:EE_
X-MS-Office365-Filtering-Correlation-Id: ecce83b3-ee45-46c2-e697-08df470b2da8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|6133799003|55112099003|4143699003|11063799006|5023799004|56012099006|261102123227099003|261026121527099003|261028144727099003|261102130727099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|261022113327099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: IgyE4Bo4uPrhYqokE+WRysuxmPl00Rn2F6/ZSa3cTAYpt9Dst2vnE2EALKzDnm+M0UbGx55qZKVYDlHLWKq4PmMstmRx5rEIGEtft3POjOKdefvMgpOmnIm0/e0YJ4XIuj0hxBgsrKYndx50xXRhh3O4abjNIgrn6i7bCyqpWX+ydGoAmFC34+x4XNylFxQ28Rtbvx5kyEXyv/d1uz0oaoLPG+903J7RsZxVPgY9gFkw+mCO8bH89xgp91W3/rl/J+UxallR1sNM8UHLhStkimzeMSEwMZPh8LlhbXzz6NEVLCkV/E2aPWeZLI054ryGhhYluSn6nuTBC+8eO1Y+PEavnMeqLajmMXuby6rSiKdSdjsfPa1vOw0ijxlaTEWW63OjeYo1iFiTG66mYAM5H6UhsPoHytKw8CFuuJahWEazzuaMXAq2YtyxBaXdUp33HZkTXNAaplvhzhM6T93Vw8sPZvQhSvufaI3j+JufxhvwQMKWUhYWDM9Mqy1cRBxD6cRIx4Ru3AwcrxYLLUh5D2eWmtxEs/vt6EIzoIvXCc5GEIK7LLvJT6oehUph3pddJvJSFDqYLVUS/Za7rIt+KRTvyn4866mcaVUhcjFgo+LhJ8Y/RmikZRzmpz4T4oDVnsMvDdt3IgrqvirEWMfDWbnHLX16roNBFD5A4hQ6KxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(55112099003)(4143699003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261102130727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261022113327099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlRFNDVsQnBzaUNCeHZldHRIMWNhMzIzTS9TK080Q2hZSllqUWJPNzVzL0dv?=
 =?utf-8?B?SFZaMGRRVnhYSEhzaVNIZUtHYTZvN1V3WVNWY1lqeTIvaWVIYjkxbTNVQzk5?=
 =?utf-8?B?UDM1cTBJaS9aenVWallHTzViZTJvZmFnY3c3ZmordkRvMGxMa2tqR0g2Y3pZ?=
 =?utf-8?B?bXlMbzlBZ0NIQUdhOENyYWVURzJiZWxSYzM0eU9nL3VOOWpPeTU0ZGVVdDVH?=
 =?utf-8?B?cUI3aUxNdEl0eGpHbDMraHZNVHpwYUVzb1ZlSndzVzBZZEN2VnNudEFmT0Rp?=
 =?utf-8?B?bWFFM3FFUnZLVkxuZE4wV2JHcmhIYzg4RXRvNGpmNlk0TTRBMHVzUVF4RkNu?=
 =?utf-8?B?QXN2Y1pNNFlVUGEvTVZVT3hCU3AxN2l3cEgwaEJramNKaUNFdElFVWNEZ3dz?=
 =?utf-8?B?OXA2d3NxN3NoYnppOGhiK293ZWNrcC9UVGQ2ZWYwanlpWjRWQWVTZ1Q3ZWE3?=
 =?utf-8?B?QXFGaGFOckN3STlYMGFJOTNPVjRhMytkU1VRUkE0RFlSdStWdzgwTDN0MXpn?=
 =?utf-8?B?alNoMjd6aHk5N0wrVkR5K1luamVYMXlLbWFaanRPZHVhazAxMVphZmZHWjBj?=
 =?utf-8?B?blZCdm1SSGhqNFVPemQ0SUMrcld1cXlocnRNdk5DbExEQ0VFWnczRHhteFZh?=
 =?utf-8?B?aXlXSHMzbHFySWNpTGtIc3BRbzl0Qm92cUJXdWYxRDBNSHR3ODRnL2dQRE5p?=
 =?utf-8?B?MXZLcFR4MlV4T0o0bEVVMEg1K2thby9lYllVM1p4SEFKdVBxVWcycWFIZ0lk?=
 =?utf-8?B?TjRjSnVsOU02N3c5Q2tCNnhodzFNMUlraFlPQk14elI5elVZQWlLZ3k0d0ZZ?=
 =?utf-8?B?Z21nMUc3Vk45YXJjdHJjVURVRVQxMkhPeEZYYVJHTlkyV0NlWTgxRmxDOEZS?=
 =?utf-8?B?d0VZZXZwMElSdXA5V0ZTelc4eUs4RmhpenRaemQ1SjgzOGoxNC9DRGVQYkIv?=
 =?utf-8?B?U0lUckJYd3dUWjVwNFNMdm9XbUV3OVJnS1pYTzBVcndtbTl5Ky84eUVYRnVl?=
 =?utf-8?B?UkZpdFo2NFIyL0UzOCtpOHhXeUdaN0lBNEpBMmJrQU1rbFZNUXQ1ZTMxOEdp?=
 =?utf-8?B?NFhQaW52RW1NZm5GNlViYm9IcnhlT1dvcGJDa0ZvenhzWnJoQzR3QVBCQ0JC?=
 =?utf-8?B?MDM3aTdnYjNjaVlFZWNkZ2F5dENqbUVKY3NKdTRjVU9xVmtPZEg5blhBbFhv?=
 =?utf-8?B?d24xMlZ6NjZsVCtiOG5IZVpBeW5ZNVk4enVDbk8zMnhIaFNod28zVm43VFUw?=
 =?utf-8?B?THBJRmlOQ1N1d2wveVNaSmgvN2J3RE8zejJqRmcwZVBuMFZYOHd5N0o2aERF?=
 =?utf-8?B?QS83dzMxN1FpYTZrRDNrSjN0dGJhakI5dDE5NTlTU2VvbGQ0ZEdBUG9iOS9I?=
 =?utf-8?B?YTFydDdPQ2RIVVBtdStmZzl2dU83UXQ1cFlLRWI5bk5JZlFJcnZHK3lNMk1s?=
 =?utf-8?B?dy8rOEU5U1RRcnhQVUFhampxbXdVUzNrMUdadFhEZFVuS0FwT1pHdGNaRGtS?=
 =?utf-8?B?UVVMejllOVg3T3V5TUVsNmVjOGQ4eGJ2SDZxMnhLcVRhUVdFRkRxS2tVRUJJ?=
 =?utf-8?B?K2NyTW9Kb0NCNzJMZVJJNEdSTHRKb0pFNVFNSXVyUnB6T0JCQjV2YTM4Uk9k?=
 =?utf-8?B?RndZK2RaWjJra0Y1aFFtSGtaNHdHWW8rZ2F2clU2MzJVamowVTlLY1lDWnZj?=
 =?utf-8?B?SElWU2F4ckJ2YlF6ZEdET1cwREZMbXg2WUZydUtRRk1VR0NZQU1yaG1sNngx?=
 =?utf-8?B?cjlSM3pyRkFFQmNqWGV1dnRrRUc3TzZQTFRRTjk5eG03VGkrSmpVU0NWQ3hL?=
 =?utf-8?B?ZFNPRDF6RU1qNEVNZmtZWTN5WEFFaDdQMjJudEZaNXY3ZDQySElNTVdjYjZ2?=
 =?utf-8?B?WEppSnkxU3JHRXJnTUk0ZkdNVHlNaHppQldPd0ZDNStra2t5eU5PVk5EQjlJ?=
 =?utf-8?B?UWRnYmJzc0V0VnhUZXA1V0wydDI0b0VySy83V3BLc3J5M3BTYWJDSDRGVzh2?=
 =?utf-8?B?cVJBck5kWEduclp4L2crODlrbGIvUkN0d0hMSzY1M3cycm4zUU5Ub1JJejZT?=
 =?utf-8?B?QzIzU09qT0UrRHNRRSt1RGlzbWd1UjcvRnFRL0xCR09FbVU4cEtIVlB0bFNI?=
 =?utf-8?B?cVFOb0g0MFFVa0NMY0dURW42eG1jSjBudDMzTW1DYWJZUE1pK0RFZ2R2N0ha?=
 =?utf-8?B?Z1BITXhPSG9qdytydXBUZ2N1Z3lZTnVPbDlsOU9xYlMwd0k4Sk4rOFVDK0pY?=
 =?utf-8?B?WHlTRUpzZnY4VFM0MFVacnl4R1NJZWlaZHBNOVJxRi90anJzNzdoRUZIMWxr?=
 =?utf-8?B?bHBGc3kxaVU4MEJOVndWd09iSkJQSE02TVFkY28xQ2c1cDdlY0dmL1dFTnZ2?=
 =?utf-8?Q?Ro5PyM4o5wYp+7Es=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecce83b3-ee45-46c2-e697-08df470b2da8
X-MS-Exchange-CrossTenant-AuthSource: AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:35:44.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/GmzlLFHgrQUmWBcrx5wkyKFzF9kJZb2YpeTXVXggGqn2O8XXpeoaCSzVsgSaL+SV/k1VbAuv319VxlvvWDByzRrc+WZa2iL2Gsitn46ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB121500
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 13:35:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25045

On 11/20/26 1:56 PM, Dominique Martinet wrote:
> Christoph Steiger via cip-dev wrote on Fri, Nov 20, 2026 at 01:01:09PM +0100:
>>> and since the linux upstream CVEs are fed to NVD/OSV databases then
>>> scanners will pick up the many CVEs still affecting the releases, so one
>>> can triage them and export the result as VEX as seems to be the current
>>> best practices; but if we don't provide a VEX there doesn't seem to be
>>> any way to describe the kernel version as e.g. v5.10.272-cip79 with all
>>> the fixes covered by CIP automatically covered.
>>
>> It is true there currently is no globally understood way to reference CIP
>> kernels. It would be simple enough to use something similar to the kernel
>> e.g. pkg:generic/linux-cip-kernel@<version>. The second step would then be
>> to start integration with all the scanners. I dont think there are currently
>> any efforts in that direction though.
> 
> Right, just deciding on a pkg format won't do much unless we start using
> it for data feeds scanners pick up, the question is how useful that
> would be given the state most scanners are in...
> Just adding pkg:generic/linux-kernel@<version> will make scanners report
> hundreds of problems with no way to automatically filter out what isn't
> built in or what isn't used, check by category etc; that needs specific
> tooling.
> 
> But to be fair that's not a problem with the CIP kernel - the tools just
> haven't caught up yet, and I'm not sure how much will be done by whom...
> 
>>> I've found about cip-kernel-sec[1] and kernel-cve-triage[2] and we can
>>> use it to automatically check boxes in a VEX, but would it make sense to
>>> publish this data as well somewhere so that "standard" scanners
>>> (dependency-track/grype/osv-scanner/etc) automatically do it in the
>>> first place?
>>
>> Is there any information you are missing from the data published in
>> cip-kernel-sec? It is not integrated with all the scanners, but I think
>> everything that we need should already be public.
> 
> I honestly haven't spent enough time with it yet to say, sorry.
> 
> As far as data goes, it's even properly tracking CVEs introduced by
> cip-specific backports (e.g. CVE-2025-38656), so it's really quite
> good - thank you!
> I'm curious about how we could track a vuln introduced by the backport
> process itself (e.g. bringing in patch X without patch Y caused a bug
> not present in any upstream kernel, thus without assigned CVE by the
> kernel CNA), but I don't think there's much we can do about it, and it's
> a bit off topic... :)
> 
> Since kernel-cve-triage makes use of "affected files" I assume the data
> is not meant to be standalone, but to complete kernel's vulns.git that
> has this info, is that correct?
> 
Yes it is supplementary, but it should mostly match. kernel-cve-triage 
for example, among other things, tries to figure out which .c files are 
affected by vulnerable headers as this is needed for some of the analysis.
> 
> But anyway, my problem isn't triaging locally than deciding what we want
> to tell our users.
> The main problem with local triage is that it only knows about the
> vunlerabilities public at the time of the triage, our users need to have
> enough information in the SBOM we publish to be able to reproduce the
> triage and get useful information regarding new vulnerabilities that
> came out after we published our data.
> 
> That means that either we need to document in our product manual how to
> use CIP's kernel-cve-triage, providing the necessary information to run
> it, and have our users run these scripts manually, or we need to work on
> some standardized SBOM that will be enough for "any tooling" to provide
> useful information (but as said above we're not there yet)
> 
> I think the kernel SBOMs you pointed at is a great way in that
> direction - since triage needs to know which source files were used for
> build and things like that it should be a good input file for it, and
> eventually other tools will pick it up (eventually with a bit of help :-))
> 
I think doing the triage with SBOMs as part of the product lifecycle is 
the way forward. Once you have the SBOM and the vulnerability from 
vulns.git it is very easy to check if the kernel is affected (<20 lines 
of python with no dependencies). No checkout of the kernel tree, no 
build artifacts, just the SBOM which you want to (or have to) store anyways.

CIP could provide the kernel SBOMs as in mainline, and also the 
vulnerabilities with affected file information in cip-kernel-sec. That 
would allow an easy workflow for users. And we would be somewhat 
compatible with mainline, which should allow us to reuse any tooling 
created for it with minimal or no further effort.

>>> Just to be clear I'm not asking for free lunch here:
>>> - My main question is, if people here publish a SBOM, what do they use
>>> to describe their kernel to others, is there any recommendation
>>> somewhere I didn't see?
>>
>> I actually posted a lengthy idea about including kernel SBOMs as part of
>> standard CIP kernel builds on this mailing list yesterday, but that is stuck
>> in limbo somewhere.
> 
> Great timing, I'll wait for this to get unstuck!
> 
>> Since v7.2 the mainline kernel provides scripts to generate kernel SBOMs
>> [1]. That is as close as we can get to a standard way of describing your
>> kernel, and it is conveniently already in the correct format for all of the
>> compliance stuff. My suggestion is to backport the SBOM generation to all
>> CIP SLTS kernels and generate them as part of a standard build.
>>
>> The kernel SBOM can also be used for CVE triaging, very similar to what is
>> done in kernel-cve-triage. Yocto for example is using their kernel SBOMs for
>> exactly that purpose.
> 
> Thanks for bringing this up, I saw it when it was added, noted to have a
> closer look and promptly forgot.
> I didn't test it yet, but from a quick look at the documentation it's
> definitely a great step forward from what we're shipping (which is
> basically useless, scan of the built binary kernel/modules only)
> > We'll definitely want to use this as well, the standalone version could
> probably be used without any backport but it makes sense to pick it up.
> 
>>> - Are there any plans going forward for kernel? If so is there anything
>>> we can help with?
>>
>> I hoped to start a discussion about this exact topic with my post yesterday.
>> @Jan can we do anything to get it unstuck? I can repost too if it is not
>> recoverable for whatever reason.
> 
> I'm on the list, I'll check it out when it goes through, thanks again!
> 

