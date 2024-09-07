Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1760CE6FE55
	for <webhook@archiver.kernel.org>; Sat,  7 Sep 2024 09:45:17 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.87])
 by mx.groups.io with SMTP id smtpd.web11.4293.1725702308117506479
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Sep 2024 02:45:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=zcrhSBuc;
 spf=pass (domain: siemens.com, ip: 40.107.22.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBLVc0OjmJgM3QDF4WXtE+7fY7WxrBXCNhEJjw4za65A/7HsWN2hNJa5QcC2KTDICtnzhTBaJUYqKVyN7WGdZp8eQNFlaihvOXOOuGqYacaDS8CdWC+KwBxQRzri3Ej9In3FPA0c47Et+Vv8AHz4r+/K7DZSVy/DqqEkHHy43gougMlmJNBHY6IXLs0DPh69RMcRRCLDuvqR+gvaiXJf+xzta/y8bHRX1kCOL2cc/0ctKo/j9tltI9zU1MyAgm8rlhX9aeEhsJrN2py3vAoU2ZNCTwGY5wo67jzPZvf/o2BQnue2hGG9uJC/iSl3g7xyEZhQJ3/W4SF4ij9f40uJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axCJGhLA2puOBRNlZ0PtTp4G5xUcX3GD2wt6kp7xRwU=;
 b=vdX4Hx6khr+3vwU6anNG0GMdZ76OUlVQmmkVyz7dxpkpX+sd4AYXtlMPfyvufbYelQ3nsAYrxH0aD2rhPmPOO48gER4O+Qg7rxBN3HGb0uguCkEMM8GeuTAbAaSySgMjq4JarBhTaTnVT+4/DGSulDLGxzUoqsDgVtpJrU9ShqhVvIEGj1ENhtQNe0iG+/VrwbRYYeOhSCg5wOC0STx5tgXh6juNR2d8W/Y9/2op/hp8SyuVD557Hp96i3MeZaksOi1uWzWcZHAhKrfTlosfbf1xPyozcgCi5dN6BcxhCNc3GD5DOAQxMzZGS7WS1wcXGaMqG5SJEIYVX1iKwJpbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axCJGhLA2puOBRNlZ0PtTp4G5xUcX3GD2wt6kp7xRwU=;
 b=zcrhSBucOWoI92QrtP/TCEgStGe/3O52geCwxe25r68np5CmOO6CHz6S59vOoQ5GIno+k8XPHL/hPYcBiRuEHbd5vXX+ifrIoRL/gfnwgZU3iKKJS4HakUZ1ABwo5rpj3zc1x4w4ilMf3JfQYQg86kPUrWx6gbmdmSn3eEHH9SZNkEpMFrUx08ITlbfC83cnmjTfVS2oghfQboFQ4uH924Ix1xA0qjeqEYlNeuDLzmrShAhrIgNSElmXB1IqkhRwoyI3R4ej7DsAcHq9WBPWioKRf14x/It8IwLz3wy4VP3ehxOSPsuvTqmLEqtH5gaN0m67K/8z3PZ+hTU5ohXkIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Sat, 7 Sep
 2024 09:45:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.017; Sat, 7 Sep 2024
 09:45:04 +0000
Message-ID: <9f4de9ce-5e92-45b8-a7ff-3a9824d5e07d@siemens.com>
Date: Sat, 7 Sep 2024 11:45:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] refactor(squashfs): prompt for dropping
 acl
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "developerdong@qq.com" <developerdong@qq.com>
CC: "Dong, Zhi Bin" <ZhiBin.Dong@siemens.com>
References: <tencent_EE69D05C78693B4A0913E07D06A7CF6A2609@qq.com>
 <d96b13c0d1891878bdea3e6a46bc33c14759579e.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d96b13c0d1891878bdea3e6a46bc33c14759579e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f71eb0-2959-491a-d6a4-08dccf21c02e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TTBX3dUJB0ymPlCtgMWjbPW2SRfymLd1CpDcBbrOpJyzAZTWV47I5oWABAYg?=
 =?us-ascii?Q?E7EF9L7eW3SwMBpAm1dhPfYRSOlHMalsF1xe+3RyawWp1n+O++cbRxNwGdWt?=
 =?us-ascii?Q?QqoTxFYk9qN27ojhW+7iNjiq2ilBCAuyYtq+amjXmmDZY6zm6QTdH+bpkAGM?=
 =?us-ascii?Q?gZH8zF+cHr6kzWtRB6vV0H9vb13ohAqnoxTMWiUCCvJbh+QXAvs37OjaOdRL?=
 =?us-ascii?Q?tNE9lQCf6IP4FzX+vphyF6PRfrYhNrS4QlgOv4+/BKgS6BTt+MvDk3EO81WA?=
 =?us-ascii?Q?dIlkUGaesLe61G2Ht5qUdeUz+26riVYUnUlRRmcrdTc89xKNbNKeh5mMBSKg?=
 =?us-ascii?Q?aAWHScSBbKpRsPEAr4BI+atu7fMz837IzDA1OMfLH5op6f/39wBqRAphuYBs?=
 =?us-ascii?Q?A836Txlx6VCVoj5Z41K5JDgIoVaeY8bY8dM5MSWNp/VURpCfvrFOaenZQHCH?=
 =?us-ascii?Q?ZL3bmn1c/lR7Lez4OwdcSiWjCxOhWBg4u8R6OAImhmLZRLntCM5zV8KOBo03?=
 =?us-ascii?Q?FYBM2JiXwc35mcLZICj+giBB/GAPFLNhvWe+A5cfYPMpLo3FLXkAOxWIHeWU?=
 =?us-ascii?Q?Gb9qdFGk4XUXmqcy7t3eaeUVG/ICfHvKX6SE341n7NnLq87y3R140523byIR?=
 =?us-ascii?Q?PJzfbzId6F1EN/G2+HLVDmYi8jLi0OOqgv1z0kbpvn0+THAJtyKsAZ5/ptWl?=
 =?us-ascii?Q?9ZckSCQGqe9abkyxpysJPvmVjvLdNkpSfHcASa1ySGhjqH7IB/QKJJPsw7n6?=
 =?us-ascii?Q?ttiOdsBdAAO4Ig4yRuz8IlDQAFNFyh7QhgNrSs5L+tU1tKz01W2xW4DcrP2L?=
 =?us-ascii?Q?nNxtQT5YA9EgWWlIP8hyXj2TCJg4ZfF1jd5AsndTEqZIzmFX5kE4L7HQgRRK?=
 =?us-ascii?Q?0oAR5w+eEwRrRImY9MztBTgoPa2OdSMOgiYm+prDvrdrQLbxWrhsnqcp0jnd?=
 =?us-ascii?Q?d9k4IVFJND6vLn1OsOPP+uHZDp7tXDqqF6e2eSksvf1DYWZrvDWSHh7OUL3U?=
 =?us-ascii?Q?zT0/ORXc7ubtKJP8zKAjWRXMUZKMtpvi9LS32nTWcpkjpCbCcTpHgUmIdD3Q?=
 =?us-ascii?Q?H9y53WbPVCAfF9JYWxfSuFje260rfWnrgf0X8wRV8r5JzreJsudzSy1JURnU?=
 =?us-ascii?Q?m3ibyb90B1irfNMHCQweucCmVCzAUTrlpEl1/ejGAFubA8ePBA10Zx1xfZtJ?=
 =?us-ascii?Q?zAELjof4sJobNhC5hnNgyhXrh6WNcWVc8WylG1gLdzmtdSrVA0rF/Wl3KZSG?=
 =?us-ascii?Q?85xLULZ+1t9g1cJq77hORCsrZ6r0gbuDG3ibYUFWoBaRnGPlF4swbEusBEU9?=
 =?us-ascii?Q?908hvqRoalzHrShB9/dqBYY5erPPBJSTnzlzhSaRefdXTimzQHtaxerEyKt4?=
 =?us-ascii?Q?1BC8MHk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Xl49ZFPXhBYygUIR++NNN7JbpyIW3Gh45TjAKgAltotfzoH4e/C7wNVYYiFN?=
 =?us-ascii?Q?yMI4ZOiGQwYgJfrMPYWbJ7/GvzmlTYEd6yi4o0MRRy6tEYu6OrnlhXjsLArO?=
 =?us-ascii?Q?AUNIz6VokzKdl+FFqhp3Gj/MClh3lhWxL/jjPo4IZUM0ouIxGwuXtmWHU/r1?=
 =?us-ascii?Q?1qUJ9QUUUIbimpV+KEc8CVSnbAhl10SrV6Y9UroJ6EXsDM6Ee7o8xhMzMzIo?=
 =?us-ascii?Q?qLNTIGD0jEFsuJfbteCm80rlpkaVLMLCJSdNF8LBZ+pkgQVzgCTeF7kox+7g?=
 =?us-ascii?Q?QkmZM6IRaQZHnxJ9kiw4sOO6p8JCk2rubQ0Btmy4vLNrRSKUvWmSMdawaKr+?=
 =?us-ascii?Q?sxXUPsmO0irXQGvAcVh5KBgxar3OcIwMMtPyt9oXqo22fJgpNeC5wbbAGZby?=
 =?us-ascii?Q?x5cK4wIaMPAx1nEHRE5NTdBnhpXQ+simWhGl+5nJMqOnA7z6iDcZa/0sCgcH?=
 =?us-ascii?Q?8dOvDZ2h3vMHzyxFWpf3w+4sykCerZV41IU2zQyVYrRxsO3N4wkRyBvs+oNX?=
 =?us-ascii?Q?ArXUObnBmIPkEzJcCvFb/0T2UH8UImA2ey37e/U/uE7/tXmVSPhUxpnmYfPZ?=
 =?us-ascii?Q?mggZO7voVM2t+RKjB1YI0VcuCqfSocFFssJmJc23/gJ+s4CTw4uw03GPEODH?=
 =?us-ascii?Q?9I4I3h7LY7zotNTRTaLQ5qzo0Ovrr97ZFTujae76EyaoFNTrC1mljRH1Fhbv?=
 =?us-ascii?Q?rFprmOpSdbJ61eQdKmuPgHSwIQid8vPi3Yii3sIdhdLlAEwp6fksLZYVIDEc?=
 =?us-ascii?Q?uahYfYjmte/m01nA62IVIUJtB5v484c1wDnfR8Fymia08tvNYTGFzIfB8fWB?=
 =?us-ascii?Q?RpUVz/wa/Z/JHPMWp6OolC5wkh0wT/YSNHEmpJhQH2SRBkTGHJPvzFWpG7iA?=
 =?us-ascii?Q?EY8PIp5z87TZiCrYblMvzoSXg04Wck4zXi1bKqosaCtjfn+M6qyJtI+sKvD4?=
 =?us-ascii?Q?PddkPIp83rcWzckmtCgmFnGju/VpH+iEYEcgiepmhAEa2d2cdkWS0gywKYCv?=
 =?us-ascii?Q?hiT2OacNhWsQmOCNy4/SBIZgQA8reA4h7cm7byK4OuAg8+hCoIRZO2PD8Rjo?=
 =?us-ascii?Q?QG2Sh//ZZduIqXh5qoAuJvHF2lB5wsDfw3rPGzNnmml8c0shYBo0QOGfw+UK?=
 =?us-ascii?Q?8WFjehXKr0bQScUr4GjGmWNSFYk+D7lcmzxfwneVT+I1MWNHkMs6FknyJeHv?=
 =?us-ascii?Q?gIlNhRs76VdlvXo4KdH/3XnaSFuIrTrY4fEL6ONF80KVn4keG+wXj9zav3pd?=
 =?us-ascii?Q?K4gVjR+QJHE8IGQXbeTzXMWbL4b4s52BVFu/f7NcnGUXAV/z7BWyN+J2rapx?=
 =?us-ascii?Q?hNETMVbKV9sux/514H9Hu8PmZm2i5xrD02ezlDw1/Ritb++GHJGr5o5uutm1?=
 =?us-ascii?Q?I9ZCMYkcwkQ9bEd+4LVXZlItBfMjm5Vbu8TYN+3BcMMtLfClx8Yk8aj6TdXO?=
 =?us-ascii?Q?tXrif7U6r+mkoEBA5H2vOf84w/VnjHC8thY8bxTIBMN5qi0VqtJbcLKxvejc?=
 =?us-ascii?Q?mnC98cjdP+k3Tl8DErcZ2cNzSs6BuXlQOzsF+je92RLMqPM7yMN2mhdsLk+w?=
 =?us-ascii?Q?qqVEjTtJ56pgn4/VdA0i24XsqssVuT9K9unrIvkY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f71eb0-2959-491a-d6a4-08dccf21c02e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 09:45:04.6477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzODWxlWeHESPdAO1fQbFZLItqiqIrBVxfCQ2ijz3Y/eyP7wcaT1DRK5EuICom+pIJdP5fYVzefZUznuFB7Dmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 07 Sep 2024 09:45:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16862

On 06.09.24 11:13, MOESSBAUER, Felix wrote:
> On Fri, 2024-09-06 at 11:22 +0800, developerdong@qq.com wrote:
>> From: Zhibin Dong <zhibin.dong@siemens.com>
>>
>> Because squashfs does not support ACL, a prompt is needed when the
>> squashed path contains ACL.
>=20
> Hi!
>=20
> I would rather say "issue a warning in case a squashed path contains an
> ACL".
>=20
>>
>> Signed-off-by: Zhibin Dong <zhibin.dong@siemens.com>
>> ---
>> =C2=A0classes/squashfs.bbclass | 22 ++++++++++++++++++++--
>> =C2=A01 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
>> index b39be0c..fc4c5d7 100644
>> --- a/classes/squashfs.bbclass
>> +++ b/classes/squashfs.bbclass
>> @@ -1,10 +1,11 @@
>> =C2=A0#
>> =C2=A0# CIP Core, generic profile
>> =C2=A0#
>> -# Copyright (c) Siemens AG, 2021-2023
>> +# Copyright (c) Siemens AG, 2021-2024
>> =C2=A0#
>> =C2=A0# Authors:
>> =C2=A0#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#=C2=A0 Zhibin Dong <zhibin.dong@siemens.com>
>> =C2=A0#
>> =C2=A0# SPDX-License-Identifier: MIT
>> =C2=A0#
>> @@ -20,7 +21,7 @@ def get_free_mem():
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass
>> =C2=A0=C2=A0=C2=A0=C2=A0 return 4*1024*1024*1024=C2=A0 # 4G
>> =C2=A0
>> -IMAGER_INSTALL:squashfs +=3D "squashfs-tools"
>> +IMAGER_INSTALL:squashfs +=3D "squashfs-tools acl"
>> =C2=A0
>> =C2=A0SQUASHFS_EXCLUDE_DIRS ?=3D ""
>> =C2=A0SQUASHFS_CONTENT ?=3D "${PP_ROOTFS}"
>> @@ -45,6 +46,23 @@ python __anonymous() {
>> =C2=A0IMAGE_CMD:squashfs[depends] =3D "${PN}:do_transform_template"
>> =C2=A0IMAGE_CMD:squashfs[vardepsexclude] +=3D "SQUASHFS_CREATION_LIMITS"
>> =C2=A0IMAGE_CMD:squashfs() {
>> +=C2=A0=C2=A0=C2=A0 acl_paths=3D$(${SUDO_CHROOT} /usr/bin/getfacl -R -s =
-p
>> '${SQUASHFS_CONTENT}' | grep '^# file:' | awk '{print $3}' | sed
>> 's|${SQUASHFS_CONTENT}/||')
>=20
> This check looks really costly, as it operates on each and every file
> in the rootfs.
>=20
> I'm wondering if we can get the same information from mksquashfs
> itself. Also, if POSIX ACLs are supported depends on the squashfs
> version. There is some upstream work [1] going on to add ACL support,
> but I don't know what already has been integrated.
>=20
> [1]https://lore.kernel.org/all/cover.1548406694.git.geliangtang@gmail.com=
/
>=20

Another reason to add support for EROFS [1] as well. Patches welcome!

Jan

[1] https://docs.kernel.org/filesystems/erofs.html

--=20
Siemens AG, Technology
Linux Expert Center


