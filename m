Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE197C5B574
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 07:37:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49543.1786433864695033019
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Aug 2026 00:37:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=A+wIqC2g;
 spf=pass (domain: siemens.com, ip: 52.101.65.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKaebNhLcNDW/1UFfnpCEsVw9qWiwcWW/kYG9zA6aV6OG9qqwMI4x6TbdmrUWXe98o503fXk58eRuX7xANF4xwhr2dpqlh2tsoyewks1F/kpRxNWk3xtoVRqpiZSBPx9JlG/uWX+fJS0jM6v8FatU7AbuSgV9vTg53la+zNFhusSuW6Sh7BK1y73V2F2aAO3oLrjqX5PkZk4BGzovkjuW6GYRrRwJmneCpUsjXukVIIqSBoSs5H/wYyxwX0TO6lglbGww7Oxb8PpV3RFV1XCnN/x7LXEm6Qli9frK0qjZJfmWWDpm/pwdXXJjxhXdrkhkZmzpc6EA3A6ajd2eEGc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsK9tsW1bkWgJkOw7QNAU/nAJj5lUCjHcAjlkrw5BvA=;
 b=CXozbxwSGnrjRI9KjZ4o7C+S+1uGgsqisrO7eqXO10u+APV9kEh4xvMsNoLf4XkQzciDExZBvHyXhMkbRgJCVj/C6naIK5l8eMQrUSMLUq3H6/BLEElhe3A7u8tQXPsyIJATe6tpGlypQsWQe+2EKcNcDL/hrCKV1xSix9pOOEz4c4bP3K4t/FtcYFkztOYaWRu4LKMgAnNUSBSlZJ+zgqmiSGPEu1YFIQ5PuUsYpJHHKdNpvHeEq8xI4XVkYOUzj3htuOSP9TkOL93v5kXmHAu9auzn+HHoEqsvsVB3xXVCRpvZsXCgFKQQwPao40oCFZbGaslT+Xn/o3qc2IiyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsK9tsW1bkWgJkOw7QNAU/nAJj5lUCjHcAjlkrw5BvA=;
 b=A+wIqC2gfQcVbHZipFFo/Ui0N/n2G9XFbZMymSY4R+3733yw7M9v6TtRaEq7wSx+V20Yob5tpoHJvtaCsGD0Hb4CgYf9nwiEYRaI81zVbA28pQ3xzzOsNzChMasecenDOF0rHxS0fELJjTYtGSIvY93K0JcolMTcAPq+P+iymXLVDrwIZcqExQj7EIYNUz+kftskxgObr+4gIIRTPE3eGgagSLcpJV7SqDTw01Vi9whOGuFwraVhjrtKr8/dGeUN8qvWV4VgWnIV5wQOB2uKcLqubKUD0LxKMfTb6YVuELpjDmw2cn9b5htRHquBmn3MXjhkfo5ESf1+jK6Qj58mOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7604.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:547::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 07:37:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 07:37:40 +0000
Message-ID: <5dd841d3-abe7-4167-866f-9f84bfc25758@siemens.com>
Date: Tue, 11 Aug 2026 09:37:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20260807154439.625212-1-alexander.heinisch@siemens.com>
 <31174e6a-78c9-4fce-8d1f-dff403e1f6aa@siemens.com>
 <b45b4dd0-03cc-4df8-94e5-ca3405e2732b@siemens.com>
 <4400621d4db82ea3313ff1907d4ef664ca0cdaab.camel@siemens.com>
 <5eedc605-7ae1-425d-876a-62c183e3a79e@siemens.com>
 <caf1c704548f130911b872587c82d15441ff88d0.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <caf1c704548f130911b872587c82d15441ff88d0.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cffc5dc-f2c6-46eb-19e3-08def77b6c32
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|5023799004|11063799006|4143699003|56012099006|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	zkZ0DflBsg9+T9EcQhw4BWmbj7u2c8oN6RZ4x89wsSzCZ9e2RrsWTQCwvrkVWfqk4aO/a4GW+4kZ2SRkZNYnuUDXzrEm5fWoTcbOBlA7+U7JCZpS9m+cytUalOA+aPUfRmSZafZs0iWe1Hh1RHvqN6U++KY0VcTdDlO9I5QnlLqarF70Fo/ZqB59Nv51gP+Yl2+tMAZnozLHCnN5Vi9VMpbZxy6DJK//79F2c2wiHIank0tWStdqL5VFQ43fi3U8ByEBkgd8VFqS24zf6uEXl5vlQIvR0pvkfnyFnMhIKa1D1ug1ah1HIJ3IvJlEXMfLp/bU8h7rZOdItDyTLXGsYSbhxB7CRhvWFT1En766MCkK6o+cHmJ/Ks0DOvm/ut23zBAv5EI/ZxMzPIPspLrOJwOebnifCSgZBIFORtVrCt8/wCu87lj/dEnnGobDI0aEsWIsPWENH/3x+XXuwGfpOMx5EA7CZwXLxsv4tjyuNWoREYC+akuC4+HZxlGhNBCZmcqEDMhPruS3TbjFliOjBf6+qG85fEK8TZwoFwTcfzkSnZLzjXTmv/pj5luOB0Hpsii35cu+4Smc+ZYtmH6wOFmzo+LiqaX1JP7MYyg6tC97U9Ewqiek7ujUJaKVjSHqzPuK8afU+YywFLf7VImGoVkkIuyqNpU8/uGMrARDEO4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?epVt9pbyjmvhsmHnqxLYAuhwVHvPyQPxe9ppeqZmVykkozKy644VjZmpxtCa?=
 =?us-ascii?Q?ziFoJQWFQoBqdIKrsfmuEWRXf/kdkhK5WZAXSqoX4qpfczM4b56fCmh2HIfl?=
 =?us-ascii?Q?cbOlGMDyn2jv/TBWbQahXx3b8/hcgI7P6SPhAW89IiHPUFM8geSb3mUigoPh?=
 =?us-ascii?Q?c0t8Xo3p9pFO9rx+pdrz8/E4xyxNyswsnZ8iY7V9JIP2KxTlAv2Qo6AB65KE?=
 =?us-ascii?Q?6HCp79z5lfYV29dZITOCq0vLWN7rUBOkAyFhQCUrFVKlUr1hdZgHxD7ZO/FM?=
 =?us-ascii?Q?eW//805aN35snGiycQWZKFWBZBhb1HjkRtgz/vwxpUfZtqg9MS1qX5T/aozF?=
 =?us-ascii?Q?XtU4Khfy1cMFLdaBuGf0QpTQ2YPzt/0+/yHJ5C0fXHNIZfmj81sLO68Jhsu5?=
 =?us-ascii?Q?3kky9QkzzhJuS8iU2Q/cuP4GhovJsew8yyNZG/RWMLMMdpZIV+G17Za1vYBo?=
 =?us-ascii?Q?0UA0RDpk8L5WAthVBkKv3xRpdt6AQyHOGNXYS3rorXw1TynLkigS4G4BDgMl?=
 =?us-ascii?Q?fD9ytBQk2kE4ndjrG/NrKvDlRHNSJKR9I4/xnM4BBbNLXMi7nXnreVLazx7Y?=
 =?us-ascii?Q?8PYW9imH1rHs8hr916l89st6JvCN1UOBz2uf0WMHYIs+sz892aDBglLPC2p1?=
 =?us-ascii?Q?As8avoA+ZyCi7JXaawhmz6H92Q+y+wXtBR1/327LAEy1Ka33qsk883dQCrOj?=
 =?us-ascii?Q?zvnSpXM0e2eVU1iUaH5l+lNBPtouhWIndTbOWv+BAl5ValbBRjYqxiESCOmA?=
 =?us-ascii?Q?55VHbsDvr732pwBdbrikKAFm24zxKzW21GXO39x6zghzUvG4zDWgGaTTRE5X?=
 =?us-ascii?Q?ucao70+jSgQhyUovNunRVkTDRU7B/kAy95kJo3+xKRRi+3CctKHV/ckYBsTJ?=
 =?us-ascii?Q?jwtl+Fy7utE3iGmuzkluLje7PC5FYH2QAwOOC050bussdSvurVY8okV+1Sql?=
 =?us-ascii?Q?pucK2uMrGC61CUMpwznum34frvmdLx4Pch+dIT811tF5lpuoX8gojiL1/FwG?=
 =?us-ascii?Q?UT0zPTTeUkht2WP8o2Ha6b5drJRn0ZkCTMNWfnySL95sk2QfuOaZADsKKbAm?=
 =?us-ascii?Q?5PBwzjvHYWxXBqryC34r1WPw4LsIlcE7setRlQnEjYvHwqOe55GAEyoMVmK9?=
 =?us-ascii?Q?oUqetpnlTeuBVJKR4vTwxgW9MtZQG4hzPggRnEpTEWePX9qTAH9qhPera/SE?=
 =?us-ascii?Q?jAHl8GGKbtvpgWPwSkJRrJWan+iuZd6+Q8lH1KYGXaH/D5FgCyn77Wa5QI1a?=
 =?us-ascii?Q?GJ3tt4ZOYQUi1M4l5sd+Jxt9JoqVfbcfT5djmg6v2gWcjo4Ae3FFR11pibUi?=
 =?us-ascii?Q?SFawL2LFRUn8v/Zyj/mDn7itmTQ5M8pH1n73dcTIlpLcwc8t5+8AHN9nKtCN?=
 =?us-ascii?Q?xdQpAqCgJsTDnCXRTPuejuPvUUfqVFp6yjZogDr26Hh3yTYikGQkicj+FFuG?=
 =?us-ascii?Q?VLfvSQ2U/XuOs3SmCU4qJeP5+z3vYlO3pElB6Zug+PDtUV8v9/3nO0v0Bh10?=
 =?us-ascii?Q?Zpyelk1UOjS8m23vj9yO1sTJID+1uc7fhN4S1xV64L0bYa1cEKSfa+R7N6gR?=
 =?us-ascii?Q?88HQlWtJCZ41uL64mEhVbIpEL1LttzpgYn8+4QsbENTQjWEHUFTHkQGo0GTx?=
 =?us-ascii?Q?dUP2P1UNZE/E+iewrZzi2aU2x4boNZvFiFtdTrQ0SvkhbbUGtFY4cXjDBgqW?=
 =?us-ascii?Q?IA91OPokVF2GhcwGK995MmNkHOPnSiXDcLOTmbs+nXy7lbpKYW6W3oGT3zyo?=
 =?us-ascii?Q?Wf+2k8kzjQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cffc5dc-f2c6-46eb-19e3-08def77b6c32
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 07:37:40.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajN6m0ndCMCtsFrZnhZYGpNFOTwzJqui1Fb1Xkdt+j7cMTGqO+U+MZE6lGvA1pGOES4Vwb5mxDiVMsPxuvobFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7604
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Aug 2026 07:37:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23890

On 11.08.26 08:58, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> On Mon, 2026-08-10 at 15:06 +0200, Jan Kiszka wrote:
>> On 10.08.26 14:02, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>> On Mon, 2026-08-10 at 12:39 +0200, Jan Kiszka wrote:
>>>> On 10.08.26 08:55, Quirin Gylstorff wrote:
>>>>>
>>>>>
>>>>> On 8/7/26 5:44 PM, alexander.heinisch@siemens.com=C2=A0wrote:
>>>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>>>
>>>>>> By default factory reset clears the tpm. Therefore, keys
>>>>>> needed
>>>>>> to
>>>>>> decrypt the immutable A/B rootfs in full disk encryption
>>>>>> setups
>>>>>> cannot be retrieved anymore. Thus, the boot fails and the
>>>>>> device
>>>>>> cannot be recovered.
>>>>>>
>>>>>> This patch series removes such combination from the kconfig
>>>>>> and
>>>>>> documents
>>>>>> the issue explicitly.
>>>>>
>>>>> This was never in scope of the factory reset. You could
>>>>> implement
>>>
>>> Probably, but it was part of the configuration options. Imo, those
>>> shall serve as a demo for isar-cip-core functionality, and only
>>> include
>>> valid/supported scenarios.
>>>
>>>>> it by
>>>>> moving the keys into the boot partition. But this move will
>>>>> create
>>>>> another can of worms.
>>>
>>> Temporarily moving the keys to boot partition, is not an option.
>>> How are they secured there?
>>>
>>> A reencrypt with new keys stored in TPM after TPM clearing of the
>>> partitions holding the rootfs after they got unsealed could be an
>>> option. But yes, that implies major rework of the factory-reset
>>> workflow in initramfs and potentially has side effects /
>>> dependencies
>>> on crypt hook local-top. And yes, there may be a small chance to
>>> brick
>>> the device when the device powercycles at the wrong time.
>>> Else, a more graceful removal of keys from TPM could also be an
>>> option.
>>>
>>> All things, we need to think about in much more detail, also
>>> considering the number of use cases for a true factory reset
>>> support
>>> with full disk encryption in place.
>>>
>>>>>
>>>>
>>>> We already have an option to skip TPM reset if not desired or
>>>> problematic. Why not use that, or build smarter on top of it?
>>>
>>> Yes,=C2=A0there is an option to bypass TPM clearing. That's also
>>> documented.
>>>
>>> The patchset is only about to document that the default factory-
>>> reset
>>> config does not support full disk encryption setups and not to
>>> offer a
>>> demo config option for this non-supported case.
>>>
>>>>
>>>> Factory reset has already way too many limitations. I would
>>>> rather
>>>> likto
>>>> work in more cases than in less.
>>>
>>> Without major rework, the only option is to disable TPM-clearing
>>> for
>>> factory-reset in FDE setups, but that hides the fact, that it is no
>>> complete factory reset. So either Kconfig shall be explicit about
>>> that,
>>> or not offer the option for FDE + factory-reset at all (what I
>>> did).
>>>
>>
>> Resetting the TPM is the poor-man's approach to factory reset anyway.
> Yes, but without TPM reset current disk wiping strategy is to weak.
>=20

One of the limitations of the current approach. Let's fix it so that
TPM-wiping-off will not cause too many surprises.

>> It
>> is not needed to reset the disk encryption keys, also for the data
>> partition, and we are so far too lazy to identify and delete other
>> resources in the TPM in a more targeted manner. Or was there anything
>> technically preventing an "all-objects-except-for" TPM reset?
>>
>=20
> Is it a reset so one can hand off the device to someone else? Is it a
> reset so same customer can start over again cleanly? Or is it a
> decommissioning without device reuse?
>=20
> Currently, the key exposure is not limited to the initramfs hook
> implementing the crypt setup. So depending on the system, users may
> retrieve the keys of their system. If such device is recycled and
> potentially shipped to another customer, either a key exchange for the
> disk encryption is needed or the key stored in TPM must be sealed so it
> cannot be used after the crypt setup.
>=20
> Not sure about the actual requirements that led to the factory-reset
> implementation. If keeping TPM keys for disk-encryption is ok, a clean
> wipe of the contents would simplify things.
> Do we even want to support FDE use cases for factory-reset? systemd
> (which served as a blueprint for the API afaik) does not.
>=20

All valid questions...

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

