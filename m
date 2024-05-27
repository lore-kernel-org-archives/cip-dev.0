Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E340CC25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 12:30:52 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.53])
 by mx.groups.io with SMTP id smtpd.web11.26377.1716813042592315987
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 May 2024 05:30:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=wuR/BVG6;
 spf=pass (domain: siemens.com, ip: 40.107.7.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd40463qdlN6E2ZQry0ThrKYeA0DdDaHG5hLG5wFFc80VUCcc6vGFPn24flPRDa41fSfoLVJJavKtkPQkrQlIlEm84ovrlt3+zNRLsWx07skc7pnylCzjUKMdBZchNHtsejl4U4bvK6MIqhGc7H/tywinYBx41hYotRLw4bUIx3CulcRZf9L5u9EFxS1mrDq+v5MGoABDTQcsSP7KOiZ+DRRE9EdbnDlPunkfJ96jOHZ/2B5qraJSEU8hXuDQyZpBSM8oj6grn6ch2owZYK086oqhu5KyGZBlftZ7qVcdh/uXesCpVFp7LbqpAXKxthAF60LqUsuBq75ISxhMVT6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTAxoVQinhBvWJiRVX2Rnp+YU+36qkqQNcwRktQCleY=;
 b=PaOOqW7pm1cA9bmOZDHq5Lt7BcKpts1TETp69WM056/w8cOl32TJ/Jj/moWvrFsmDj9fptFtrp4c4WB9l6+Rv49iW1pnOeWec/+pz+V/2oCdeQgwXbAreLOsQjB+6rQHKlrPHo82HJwLjjqKL9wAGD+NEBYAIL4JLn7zMlpaHwzJG1fnxdzdy640cW/saACXvlMdw/ks8WEwz7XWHzCvetghXAj1IRLiSDW6b/T29Up0bDOI40/TU4DQhqtnlDGjVUVUMX42lcVqpKRSTmISbzjWhxX709QLSR0ooJhC4z4m0veM9uuBRfjPsErWosOhJkwFIYsZuHgwWXfQ3DbbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTAxoVQinhBvWJiRVX2Rnp+YU+36qkqQNcwRktQCleY=;
 b=wuR/BVG62dRdPqPGCTY7CriMnC1Bdh/jPykoJL5QXWpdeqcJ7P/eiJ6PbAqwvdKsiKTUm6U7P5Ff9wfqVcxnxQM5KV8cf2dP8UvRjMNZMYxxNKUozUkji+Yz6knOtImf6zL3Pb2YZWlG5bDHooBeQ/rctdVq5VcKa9l1jM2Fy2AlhvQcDqj4m1OF2V6dfYs+GDCb9gGb4y1tVgboFdrkc/Th22d3giGlVn8ZdjduGKiaP209ucAqaa6nzvGxJP6H9GLN6wz8/0BxOdW/IG81dxcaYZRsKeKwz+AOB1khVZVSsRcmXwITTRbZDG9qpS3mkJ0MbYJsAdUO3I9jtFvraA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5253.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 12:30:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 12:30:38 +0000
Message-ID: <1bd197ea-e2f9-4f25-a088-8854c73ae16a@siemens.com>
Date: Mon, 27 May 2024 14:30:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] encrypt_partition.clevis:
 select tpm2_device for encryptition
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 gokhan.cetin@siemens.com, cip-dev@lists.cip-project.org
References: <20240527052948.2471630-1-Quirin.Gylstorff@siemens.com>
 <990c3a80-79b4-4be8-865d-c1162a5988a4@siemens.com>
 <9c12851c-d29d-46d7-8769-ade8aac4debd@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <9c12851c-d29d-46d7-8769-ade8aac4debd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d48c90-ace8-406b-b907-08dc7e48d06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?b4ktpOvdeNjVbEvIt3hNMjBI9wj4Q1PzDfi/Oa/oKygEce460KXnqZ2mgr8D?=
 =?us-ascii?Q?ygCdkpqvPn5XT/UwcJJuTrnL3biAN5Lv42SGN+yJZQ4ma/kG10r9umwqBV0e?=
 =?us-ascii?Q?fvQZF4BVEdJ6PckL+pNMamPWayFMvU4HwpMRMzRtdwia93u4xYcu0678kRSm?=
 =?us-ascii?Q?o8jYl7dROBxyqjtsETQoghtI34P4N3md448rL1sq8HKpkAY3PJWdcAE1JYIY?=
 =?us-ascii?Q?0PZvu0S24OC37t9vxR7zfVwYur+ayUhu1CYolDuHXLblnQ/Vp8pcXMSAAV/I?=
 =?us-ascii?Q?YeC9lAGVJeIDIbo8/DnYKPTs0tz9u+c/AdEz4cwLrmnmI0Qfy79I40AoVsth?=
 =?us-ascii?Q?IkeqTCbgNGrpiZKK50y2oyd+TAnhfoK0PDFGmagyseEwEWmXN5mmASYdsi1b?=
 =?us-ascii?Q?zelQLjVOc0K349f9YZN2gXc91StBGn/Wa7gqM3xiAPifH6CXWnKgFUj+b+1t?=
 =?us-ascii?Q?SQZ1cwAr3ebaujZEmLPXd0S7Cld3j1SSa/XjPOWjvKcrBvzElZCULNF/YzGT?=
 =?us-ascii?Q?YEUEJHwRvzPikzKvrvJw4eImbX9K5Ofkmd/l++ZK3rLz7wkeuDSdVvpNtLJx?=
 =?us-ascii?Q?GyRaELt/nhpaS0fehup4804mGtf8wjtRhsk8bbgfnmy33rRr3xizQWNBpxNH?=
 =?us-ascii?Q?SNGEfATeunXfz9Ek1PTE1LOh/issb/y3ALKFk7Rh6aJ6N27dyWSHn8DD6t+U?=
 =?us-ascii?Q?Az01yln/ERkjOOjmc+RABhTC+OweHffjZckuOTVhG38e/dMBZivFTDQKxvCw?=
 =?us-ascii?Q?9b77S5DfnGDpx6V8340SnDZdyzimk9/P3JEHaa2Oi9EJos89rE/tzf2opEtt?=
 =?us-ascii?Q?rd9scoOQKRrrjLCcoWgb66XVRNc6q6sq4REl82NHXNE0ZsS3yntR3NtndzYc?=
 =?us-ascii?Q?oBklpq2+4VzBJYeH3tdAVOn3lpnJn14tgr3EEp5x5PHsauyWcikkycigrkqd?=
 =?us-ascii?Q?wz6HJ+Hv/J9gzJOXnH6XO+c1tQzln50A8dj8D/DrE28gwulClHErhMGNtJu7?=
 =?us-ascii?Q?s0A1SdWXmYOvzhXhzVCDzHMCFb6KLZxW/ILX4aZIJKqVssZPiTL8hURSM0Wh?=
 =?us-ascii?Q?FBXuzef/gvVEfGh26lGGSaWN/LrT4QfC66A8pbliO1g1Hlb2eC9mryVWuV7i?=
 =?us-ascii?Q?NiC6IzOTK7fOnnl9mhw4a8IhvBFnjVvAf1JxdvyJKVNCbQpK/9EFCSg8fSsi?=
 =?us-ascii?Q?hD93oVyrLjk+ahmBfuN9iNpeTKjN8nLlCwuBig=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W+I3T4fU8Dvmza2pADPkLChFwj7zeExzea29SNMjNh4DopXqCzqUqeMXEmEV?=
 =?us-ascii?Q?ruqlar/HVwO9qdG61ngTzuqwh8uNnueec+77esPtDMTEfazaLILFnvcwQFfa?=
 =?us-ascii?Q?LTWP+zxG5jHhYa6szR24yrqCQ6V7PBD4fw7ETZdFFW8Pi7LDlHnkgRh/Afgw?=
 =?us-ascii?Q?ZiDsf5R5mblFc/WIe0axA9fdVazYiODSkocITq9BC7I9qFj8YeMHuuQBAY/h?=
 =?us-ascii?Q?MU7eEEuEx+DCgUN1oDjyX/lNAOoGFhVxI4PK3IuctWjSgR5tKX4RGwCl2c5i?=
 =?us-ascii?Q?JaCTkbywa44uSeeXcps68WW2+BQi2scNj3JbYFHLP77lW0VRTJgJMhmGTeVd?=
 =?us-ascii?Q?k9Yd+yoRcmcqXPaRrC0W4isgqgGMiNH9nnTyNyVjMQ2blhO2iPutFBuv9ojx?=
 =?us-ascii?Q?XYg9HkP/kPYqbPYgjJQhOWs6yFUu5UGzCEg8PAzJ93JWUoxL58Cfbk8OnDfJ?=
 =?us-ascii?Q?ZDyrSzs56RpZDxr7P0HjlpSk6hWu9di4IImHxq92eDTtay2AKDCsNO+E+eNF?=
 =?us-ascii?Q?kQGvn1lKLLKJz7xxMVxrpIytidpFgxBQbM0Mhn+FC1f1i9u/6gQzLlOYvTLs?=
 =?us-ascii?Q?mZTFS0uJUVTBmjPYeeyFOqpgI3MPLox/8lZACaDxgcwgcS8rUAQhhCHFV35Z?=
 =?us-ascii?Q?N080qF4E+Pfmrd2sWuIM9/5HQitHh9KmN7GNcxmjexscILd7H/nCy4gN8erm?=
 =?us-ascii?Q?jzIr6MiCDnUcopK3b0AHk99gvaMaSjNws6je3+15nE9q0BaxdT7qPNVJd55D?=
 =?us-ascii?Q?YiLinH3OMEINvR2t42xApdllNw/oMxPN7rg4mfpKjfb5QKgqzjA8R6ai852b?=
 =?us-ascii?Q?o5VQjbeBsEdnKiET0UQtkI2Ji42QtySQ4tSMcLKQBdnzMYRYRrnjRjsebIZ3?=
 =?us-ascii?Q?mF/RrN3ihC6DVverEBUe0+z1mSY4SR3xgPj0xo1k2maehn8PZK3LJXzqKNwe?=
 =?us-ascii?Q?DUFbUcO71q28UGxoPUiYwx/ZKRtUcU0MGXnqLSxKSX2DDfO4zG0BdB4WL4wn?=
 =?us-ascii?Q?bbMVH/IyncFlOikXrPgbiRM7IXQeF/8H5MNLzXmhQE2mD1iHzpphTCpl66bM?=
 =?us-ascii?Q?hGx7fKcOjjO/j+O2LJqNWl6MwL7i5KHXdFJbQLQiaV41ua/agWRUIn6HAgtq?=
 =?us-ascii?Q?k6eVHmpsngbgkqNK890nlxDNbPserBBr6p6Tf3RrMeLucHP2Ql8HDhaRRuGv?=
 =?us-ascii?Q?/USzySbLb+TvU19qnyrQTdY7avOJzRQABRL+zjznn5c4cY2wJuPWuKIC6Y4g?=
 =?us-ascii?Q?X0svq6JmrpZwCI5pTx2EktaysdJl6T0WVRh877orMfWE5vXpK4KypB4tcrND?=
 =?us-ascii?Q?W0rFwwN/2STPIRlGW78MpBA2Mune/8h8ws61gKe9ph2a1ErhdaYpOpsopW2i?=
 =?us-ascii?Q?8wKaMYKU+ocscKRps5T2sycaraXxjUVqc2KR9h8cNamF3rTtEN9JZXJ8X/Rb?=
 =?us-ascii?Q?X6Kjf3yUQ0VOOqWgRa9tYkkvJ11b9D5huCMc9tMuy44qt9FUGD/GoTR381Ak?=
 =?us-ascii?Q?+hyZbb2dtyvZe8PY0sIgfJR28JNG0DzvLMORn2lSqJW+gBkvVxFGKallaVwg?=
 =?us-ascii?Q?zncPDSMzIkQ6Qg8yUXeUDwIHeYRMJn7dTCu75EHdQDGCP3QCtVUIYizzOPwP?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d48c90-ace8-406b-b907-08dc7e48d06b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 12:30:38.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gjfl02kmYYN0GllGr54r/BQRBEW55izhY5KIgOkhVH1v1BB+4LzcaLE0/MKg2ZdJi9lcolP9djaBJtIUjPL4bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5253
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 May 2024 12:30:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15956

On 27.05.24 13:06, Gylstorff Quirin wrote:
>=20
>=20
> On 5/27/24 8:18 AM, Jan Kiszka wrote:
>> On 27.05.24 07:29, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This allows use to select a tpm2 device which supports
>>> all requirements if the hardware provides multiple device.
>>>
>>
>> This is fixing a regression of cfef8103, isn't it? If so, call this a
>> fix, bonus for linking to introducing commit.
>=20
> It more of a improvement for clevis with Debian Bookworm and later than
> a fix - clevis in bullseye does not support this feature and this was
> the target for the clevis implementation.
>=20

Okay - now it makes sense to me. Can you enrich the message accordingly?

Thanks,
Jan

>=20
> Quirin
>>
>> Jan
>>
>>> Since clevis v19 the tpm2 device can be selected with the
>>> variable TPM2TOOLS_TCTI[1].
>>>
>>> Setting the variable as no effect in older versions, so
>>> no version check.
>>>
>>> No interface change as systemd-cryptenroll already allows
>>> selecting the tpm2 device.
>>>
>>> [1]:
>>> https://github.com/latchset/clevis/commit/c6fc63fc055c18927decc7bcaa078=
21d5ae37614
>>>
>>> Reported-by: Gokhan Cetin=C2=A0 <gokhan.cetin@siemens.com>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>
>>> Changes v2:
>>> =C2=A0 - reword commit message to clarify intent
>>>
>>> =C2=A0 .../files/encrypt_partition.clevis.script=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 8 ++++----
>>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl=
evis.script
>>> index ddb3eab..a7a5009 100644
>>> ---
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
>>> +++
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
>>> @@ -13,8 +13,8 @@
>>> =C2=A0 open_tpm2_partition() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition_device=3D"$1"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crypt_mount_name=3D"$2"
>>> -=C2=A0=C2=A0=C2=A0 #tpm_device=3D"$3"
>>> -=C2=A0=C2=A0=C2=A0 if ! /usr/bin/clevis luks unlock -n "$crypt_mount_n=
ame" \
>>> +=C2=A0=C2=A0=C2=A0 tpm_device=3D"$3"
>>> +=C2=A0=C2=A0=C2=A0 if ! TPM2TOOLS_TCTI=3D$tpm_device usr/bin/clevis lu=
ks unlock -n
>>> "$crypt_mount_name" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -d "$parti=
tion_device"; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Can't dec=
rypt '$partition_device' !"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> @@ -23,11 +23,11 @@ open_tpm2_partition() {
>>> =C2=A0 enroll_tpm2_token() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition_device=3D"$1"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 passphrase=3D"$2"
>>> -=C2=A0=C2=A0=C2=A0 #tpm_device=3D"$3"
>>> +=C2=A0=C2=A0=C2=A0 tpm_device=3D"$3"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_key_algorithm=3D"$4"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcr_bank_hash_type=3D"$5"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -x /usr/bin/clevis ]; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clevis luks bind -d "$parti=
tion_device" tpm2
>>> '{"key":"'"$tpm_key_algorithm"'",
>>> "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPM2TOOLS_TCTI=3D$tpm_devic=
e clevis luks bind -d
>>> "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'",
>>> "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "clevis no=
t available cannot enroll tpm2 key!"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>
>=20

--=20
Siemens AG, Technology
Linux Expert Center


