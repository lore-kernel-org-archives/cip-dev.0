Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6944C61DC2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 09:33:57 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8790.1787736836418192376
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 02:33:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=F6M5Tz66;
 spf=pass (domain: siemens.com, ip: 52.101.66.7, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKK/jpFrHPkS5VD5L094LzA5TjsiS5ZNLTwJe61zND5vKn/aFR5dLiVseqRDCJU5960RrKYQz9bXGlIIHYfvb2B4wJkq28qcqw/3zApqaANa91Gc6vtzfRLzDRADslm4iga0mTbsRTYKee2DDLjPLlyIWotW7Q+VLUfVpIzZi192HVVn6WEFS4GfWbULjtbUajGtPa1kyVufEK2adfBPuNZP0Zt4ojrjvXPk5OfSiNFkFIX3/sEII+mTgd+mr1SYM3/LTcK4myQaM3AzYG72JIx4OYPqYrf398R1FPubTn6c0ivBaMIzTJVS3/UZ6FvDOBxPBxTpAB/airkFmYUuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEQOLSEY3Z/X2A0WL40p30T/R+vRMMRjViYgPav6cKg=;
 b=L/MptSMIB9YlZZDpRccTjkBHpczvVH5oPbFwN155Fk4ClWKiQn9GwghZO4uOhuegiBKatsg8qpTzvCMmvwgpWVeZsAJW35fn4ULCJywildubYH9I/1emYO7l5/CGJXh7ZedJ1snyN52y0Ob36Alh81IzJKiFP1qy8pG2mXbJGLdp2+v/oIOyoWLDSMrws2AJIUsY/NZVrb4Tg0aw7/g38rdmZ4nEbf8m3Cm2nrh/OxVZFhYo1CQ5QeZYJlg6+isAhGdsL6rQT7Xtxq0f7RQqfu3uXm14lp/gB+Kjxd6E4IcfJX6kFGzeq7WNJO0zVXgy+rh8Pd9h8QzcG9ZEgfbVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEQOLSEY3Z/X2A0WL40p30T/R+vRMMRjViYgPav6cKg=;
 b=F6M5Tz66MFnjWU1f2D8ncT7mO6hrZpd7Fr7ukALWDD+q4ytqj2eXyMuZrA8rJFGV3tsbHaAuf1BjIFtRKSmSOQrtpUOhYFjjxVBAkvnFvkTnF4jpH0C3jcdM/LG/TU7qu8KsjTEnCnzBDbdWfDVaVzq7XhIHmKL5I+PudMiGMapMhhaVoHDKQhDgGAQO4GHHTwMR9UOS158zGQqJYK/Hl7NlbIF5SERn4+g6py7Xu2lgRR901oIOesFw5+4ac/hDENT8Tll+9f03ItNpFvBYIoRQ3ibhqYghFZDksRIpxxJuqHOZ1F7Ol6xghFaQQ80zMwms5BQWxAQfTm2/Ao9d2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by AM8PR10MB4083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 09:33:52 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 09:33:52 +0000
Message-ID: <a601a792-b3bc-46ad-82c8-7559f8e6da1b@siemens.com>
Date: Wed, 26 Aug 2026 11:33:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/7] cip-initramfs-functions: Add
 secure_boot_enabled helper
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
 <d55b05021ce583596d62e15daa1beddd6a32a242.1787722904.git.jan.kiszka@siemens.com>
 <12c4eff1-4a75-47ad-b5e5-6ac08dee982b@siemens.com>
 <e9769fed-d36f-484e-b659-72c3c3abdff0@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <e9769fed-d36f-484e-b659-72c3c3abdff0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR0102CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::25) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|AM8PR10MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a32993-8a65-4893-fdd5-08df0355241a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|55112099003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	yk2rxi8H4LCWKKLVpJUgWZexeCqKQUI3ngC0Wn6rXqIEU3UB6f2S+L8n7tKzLzcMfwhXHaEmXi58TBQRdDu4oRaROlEue38tEh2q29KlHDhZ+MX0eSDmIjG1WMmf7cf4gYs/ZMfyuL3idoRH30axY2Nx06SRm737LXlqkkp7dV3OuxzzXQPfSUdYc6QKbFLt6f1jz4OX5Jjcl/sgGmyPy7tDLjn+ecszkE8bH/IQqRpBuJ97A/dC0xofL+5JkcDE7zydag4/L0DrAO9rh8i+sEok8pCJ0De+v5VCDyElaPjsvyuSWoSR2KtRpseF1MEdQZgJtfwLi3q7PKRlr/SpvjANcPu55r4z4ZiulKxGtV5tZgs0XqIuVV8SCV0o/m17yyr7iDiceP+NufC6MvnduzugtLY31sMHxVa3XJsDLRYUrcAVP65Xz94inB10VU9Y/dxbWd4e/Y8u4qByTuPZHgfOBfCWesBYCNK3HoJbCc32TdU/tNY9br6qZcQ1CdkQOazYCPnu+SFj9bD3r7+o2y44i6WSWzb5hncpmw3e4/ez50OQ7sFqxbi6zLXABk9SCVygWBTv7r5eXpRdHhakVYZ5vTHiXf5SDpcKxPRBsNrcxEWkuDwFQ+QsWe0p2krfyMOFztUJSLkBOFthaAyW5eaQ1Kw2grm27bJC2lRXlns=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(55112099003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WGf4fj29dETWn1QFjlXhjNV4zlgIsw6KBEaJ7bPZcfgTEm9QsldC1yEGGfAP?=
 =?us-ascii?Q?DWVTQo4qyS3k09eWGPf6nI+RbYE7PTd0N1ouQxhBToM/nA0MioSFWJ2O0wsI?=
 =?us-ascii?Q?RKE6pfrrNIGWIYvYxHBbaXL67338BPTElPyYxa2p4zH//Y3XQzuYgMu5kpTV?=
 =?us-ascii?Q?axttf4vukFZlyxjScoHyh1k1ygTKFRVJ6mnkiDx5phcad0leQZlvzikskt/7?=
 =?us-ascii?Q?THbgxUfclWAPcdDoBToRKDrLxBlmfpVTSY2Hgv1SvHf/iQ2OokCuQk2Xlfps?=
 =?us-ascii?Q?OhcyikXW8cKNZmHUnCfG0k3ZMPXdb3jYDOw4IGICMw5Bmo4XDKOGSOnJUz85?=
 =?us-ascii?Q?twwBZD86vdXoDUItd8FnV34hzLuwoIfj+bpGWRkc+TO0g0UZyI2iiZa0Fek1?=
 =?us-ascii?Q?eECnG6lh0hREIexzLxorHokIvJHLBNz2IyCNKNpxxVq5m2C6bTqncDnXADGX?=
 =?us-ascii?Q?yvBNngWLgM2OD+bXQ9TV9fOUHaBUwAqIBjrowqoEXM+3YBJA3RM2EGmWavIZ?=
 =?us-ascii?Q?bMWwLmBS2FimWTaO6JAFMcpr6I1CDHSqwJISFPOx4hS2ek4f3fJdi+FAJEJ0?=
 =?us-ascii?Q?gjk1Qsc7TF7QmUZ8Vlekhoq/G8t5guatXDc0/+ST6eGXTQwej2ipIJZcACu7?=
 =?us-ascii?Q?YVNFNtZ5KMRgXVDkUaUMwWFg684nxbViJTLCn7XrajE7W1G8UXlWINAGdeJm?=
 =?us-ascii?Q?jGp+gxhhN99pTRmPYDpP4Gohpo+scS1IGHAUD2hZcQ0+CBK2sAi/RPR7httb?=
 =?us-ascii?Q?W3SOQXz7c9wsCmp7oza5wVsR1Y9AfSLeILUk4J3gfweNaTR1dlonpeptqtAE?=
 =?us-ascii?Q?S4fr0AGZxt3pnNA2r7qv/lkDW0rpIJwfTv91diwFdDUkOLZxAv9GoJ8fzPNx?=
 =?us-ascii?Q?eNVSB/qwKiMMgXfZl3Kqmdm0iYG2Iw77Cct1PyCMII5lh6S/ylwGQn0Ubb8a?=
 =?us-ascii?Q?jhDi2s8iNMoB197KILGEcTvlAgom3R3pCHPlsyaRhbe1GMTcEZeUVAalGxBR?=
 =?us-ascii?Q?pczRI84n3pmVqH00FZEoToPvnk8k0jvjq+xrftoroZsPowQnpvArocB2+mNp?=
 =?us-ascii?Q?ISxNVmzQ9XOmguE0Tbzkp9UWVY5slc1yetXvuV9jEBH6QnMcxNk+zJlxCjR/?=
 =?us-ascii?Q?+LzCGQKHS9WHW7/gEQ4be+CMEevYnE+qxh7IDlE5LPlA5K6jmRXdzBABL+0w?=
 =?us-ascii?Q?OEvtiC4BFsNshhWsQ+6qpSXDJKstde7sOsdtTjDySmMRVsT1c86T/b4Jy4qC?=
 =?us-ascii?Q?8jEUyrwP9mMMUbG/nZQjdL9+Ft3Orqq8Salk/WJjW+IDtl2nMlhug73h9mV/?=
 =?us-ascii?Q?k2bmxodxSVofbJjFQ89heugO3oxD1TvzeaDQJsncC/rCS0tCgMPX0L1xgXWo?=
 =?us-ascii?Q?4MWXkc6dM64Jjb5RWfCWX7vtX9D5Q5ba02iFQsVNxReGUIBdaTysbLVTGUxg?=
 =?us-ascii?Q?Q2MAQDhPK4fvc/QM1O/4ApGpGR+QUUK+1oWAIhjWbaqNrw+a3XnxEmJNM+Oj?=
 =?us-ascii?Q?tC8cZDTvD5bcoj5rDCKVwaSlOTZRsBTER3Vd6Z1UJiF04vR6Ws1HXSkdYNYA?=
 =?us-ascii?Q?uKhtIjWhmRgzL3gjKUdriYfMlLE8SJYJji5WvIGFSMURZJDxPWEwK+XgZzqA?=
 =?us-ascii?Q?rZ3wXLfv4wBMrtlttFry2bAhsGUShhAQcc9IfvQ4XrAGSGoivjXaLoKGH/iz?=
 =?us-ascii?Q?piDBIN3R3MAs1CL+aKPHJrVV7gOOIYdiEuV9lC/wqmL+Iasvb59LpRIFCPCR?=
 =?us-ascii?Q?rirQOt07b1lQ6NwUNbmdGLkVbHGkTi8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a32993-8a65-4893-fdd5-08df0355241a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 09:33:52.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkAIC88GMCt7CgJUCbRO+jJEq6EUrZoR2e+xNXYrA/ky4yKMLW9JR4KIwtXdzd7f5gXymdNk6ni7kcpcRyl/iNmaq+Nx5Tbnqyd10+gOg08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4083
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 09:33:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24021



Am 26.08.2026 um 09:54 schrieb Jan Kiszka:
> On 26.08.26 09:51, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>
>>
>> Am 26.08.2026 um 07:41 schrieb Jan Kiszka:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Will allow initramfs hooks to determine whether UEFI secure boot is
>>> enabled. The user is responsible for deploying cmp and mountpoint
>>> binaries into the initramfs.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  =C2=A0 .../files/cip-initramfs-functions=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++++=
+++++++
>>>  =C2=A0 1 file changed, 16 insertions(+)
>>>
>>> diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-
>>> initramfs-functions b/recipes-initramfs/initramfs-cip-functions/files/
>>> cip-initramfs-functions
>>> index a4c1fed6..f14956d5 100644
>>> --- a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-
>>> functions
>>> +++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-
>>> functions
>>> @@ -68,3 +68,19 @@ scan_for_partitions() {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
>>>  =C2=A0 }
>>> +
>>> +# check if system was securely booted via UEFI
>>> +secure_boot_enabled() {
>>> +=C2=A0=C2=A0=C2=A0 efivars=3D/sys/firmware/efi/efivars
>>> +=C2=A0=C2=A0=C2=A0 if ! mountpoint -q $efivars; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mount -t efivarfs none $efi=
vars
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0 secure_boot=3D"$efivars/SecureBoot-8be4df61-93ca-11=
d2-
>>> aa0d-00e098032b8c"
>>> +=C2=A0=C2=A0=C2=A0 setup_mode=3D"$efivars/SetupMode-8be4df61-93ca-11d2=
-aa0d-00e098032b8c"
>>> +=C2=A0=C2=A0=C2=A0 if printf '\001' | cmp -s -i 4:0 $secure_boot &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf '\000' | cmp -s -i 4:0 $se=
tup_mode; then
>> What about audit mode?
>=20
> You mean, I should check for !=3D 1 instead? Seems that this is what the
> kernel does as well...

Got confused by differing PCR measuers wrt. audit and deployed mode.

If the hooks start in audit mode we end up in deployed mode, and if we=20
start in setup mode we end up in user mode, which has effects on PCR1=20
and PCR7 respectivly, thus disk encryption.
Not an issue, just something to be aware of :-)

I double checked with uefi spec. In audit mode SetupMode =3D=3D 1 and=20
SecureBoot =3D=3D 0 =3D> your detection already covers both cases.

Sry for the confusion.

>=20
> Jan
>=20


