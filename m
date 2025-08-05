Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA18C87FD1
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 13:24:05 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.41])
 by mx.groups.io with SMTP id smtpd.web11.21618.1754400243972123523
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 06:24:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qOVTXwjh;
 spf=pass (domain: siemens.com, ip: 52.101.83.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9Nav45CD1Cmlk7f5i8JlMExDpY0SzaZVDMXQm4eUAwvB682P9+7PYjOSA/bSbdcW+YDAUDjXJNKuqZO7eaXxrIgf4jWPTDAZMyxvubzE424SsyJRRlOqCfzZr8aW4BNnLHfsihRUOCJ3MatF+ySWMmJ9AEmARkannTG9Rwe8AL1ap5y/eZMBtRu85NG4z9o1+3CqxuuthL3oUnKbJcfpCz7AqAZxOr7zs1+C0Fo9aP+O8NLUStqnfPqBqXHOCvVe7FvNPmPBQOslc+YMO0tCyJiPUapeOi4VRzZiV+7N71aMYD2RFRo4ySuQLXUh0XVve+yIPXzeflG47xrDfGhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQtbOnE3OJd77tYL2ra+LdW+ffaRkMMVTqzctSnOHcY=;
 b=fdHDTtkgH1kQW3wIQTheaGdCF496UBCoal9PrfWseHfhOd7Woc5rt6/8dL+enUZAUO1P7d7ajxQ0fR4l41TZ6IzqnnOQ4O9msn+xwJLqmTIuE6H97rIk7uUPhagvHygr/j+Txlv2kkE0RUM4jVs9Zi7GDcuU+mef4PGjxwMuhWDVyUDyVyWpQb/+inGiVMRUeaoFSY3KR5VCBTcUWsk9Rs9LF8by08AY90yvAVptI/55LF0iVYlV5HeV9oGsH6QFFasltVL9WygsetzVzCOceWaPmR9iSqR8pp7C2l+tz9fXLpgMgyzueQC0tC0omkEoB29WIgaiyNSBOnmsfKFcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQtbOnE3OJd77tYL2ra+LdW+ffaRkMMVTqzctSnOHcY=;
 b=qOVTXwjhhbFcWHldx4iX4SXbD/+lcndF/tnSPiUnfQdU6cYcA8ZNf3pcqp25aC5tmEOxuoV6gPtIntj0MMETQiPeMZ7ShActK6ZrB2pOzVR93wW9LI+xwlKsw/Pc9/0EUCq2aCUr9DVTnZQCDfb1YgHPuODEg+FcrNqwKG+tTkRB6PMu7TFj79WLF2G7ey4o/CgR62rxHkNJnlP7VHbvmPWnwtJN+BP3xIqU3Z16yIK4aSnmrA23EOa7vvMQEApQQnYab1x9JtmiP5T+GjaZocYImiUo5FmzHIWNG4/M/cSoomB16ksjDpF9TvNYqvdcLkmFrlPP/YgNaIfRaJuDYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 13:24:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 13:23:59 +0000
Message-ID: <627d3dbf-65ba-45b6-9ba1-e58a004802cb@siemens.com>
Date: Tue, 5 Aug 2025 15:23:56 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Secure_Boot_=26_Initramfs_=C3=A2_GPLv3_Compatibilit?=
 =?UTF-8?Q?y_Concerns?=
To: david.kauschke.ext@zeiss.com, cip-dev@lists.cip-project.org
References: <izPt.1754287361385416033.LPEa@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <izPt.1754287361385416033.LPEa@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:610:cd::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 666c1ab6-e000-41d8-cb8e-08ddd4235671
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8eAY8gDjlngNGjAfPGQ0RtS7JreuvO4U6gmJZS9zbaR4EuC1aPCA68w+abBv?=
 =?us-ascii?Q?SRDGQzNn3+V/hFw1/RqJYlJk5hAjxdkaJAp464nlp0h9pYXisQMUOCsrN+8v?=
 =?us-ascii?Q?fZQRJHD0WeOoT6zFaBqRDZdKgUWv+b9h1e2TxzL1ePDB1RbJUu9SsLqSoDYC?=
 =?us-ascii?Q?cjnEHOAVT6XsYKb/cfJOmqfdgkSKzIL13DgCx6ViCbGtWfvt6GLg7r7FliCM?=
 =?us-ascii?Q?fl7EXm/tCASFtCh6IrCzRQokAj0Edm0o6nGm7Z1NfKLMmcqjzoN5GzeR4N91?=
 =?us-ascii?Q?kx+ItyoFWDArnUhyXOpEST0qiYOK1d63aq+XnJshAtlOBn9KX+sJ44MDlU8K?=
 =?us-ascii?Q?NgOyk28RMGf1Pi87G0FYu+2DwMspr5rY5APE+MtG6/Kzudtk/Acrbaz8J18I?=
 =?us-ascii?Q?sgPOtlt/Of34hjj7qqKmeySfqqWuPDoivwdvq4rFO2NqtjA2KQXTxea1J2qx?=
 =?us-ascii?Q?oal2ZCdzg4AktAqj9l9aZTUauj1qqGsgkykAP8W5RnRJfPx66hrnIrz370S3?=
 =?us-ascii?Q?qxM2mZQr/c5RxAygNQTabm26qHGJlpG0d+Q29TV0kLibH2lq7OQlfSu//vHf?=
 =?us-ascii?Q?y7m+bmWlaTZkXD3fdHnmb0iIlJUuVvAzGIPCrGbN8pgtaLdKTfyn4IFgkn7R?=
 =?us-ascii?Q?vEfwxD8eL57G5bMkCSEvl433zPLgCpgYWYeX5Nu57S/o3CREQEJLdt05KVzD?=
 =?us-ascii?Q?NDdlGYgM8eI24ne/CFBO9jBJYwhoSB2v3psJJTiFe1UgbKMRHcsl9zAdeFTg?=
 =?us-ascii?Q?r+GGTY7jUsg8k2kKsgKMQGzbD69QDq7LS+NTHxUEBInkT3NQK4bacEG13hqY?=
 =?us-ascii?Q?HJe+TeUssD94VyMV0BysCPMqIlZl9itwVsbENvsl7IrbFsJyhdYZOZwe0XAC?=
 =?us-ascii?Q?SfllJU6VFYmyusehQnD2lmrzXsmJGUFYDtBgUP+K08iHWXRfiDN9TOX8osqQ?=
 =?us-ascii?Q?oiQFD4sm5LHBChT5Cs7TaTLhHteSe91kR4OFiO4r35UFXrLzzAFQ0JzINgoZ?=
 =?us-ascii?Q?aOHw/eZ7/wdxpKwMeaJQlv4mckOiSjvKGMLvUOO9itM7XyMOS2o3ey6H9H+f?=
 =?us-ascii?Q?df1lNBvAHmzPlzAwqoOKx/ACzFYCE/kv85mxx3crdbq0x7IR4jUWNURrp0NJ?=
 =?us-ascii?Q?YmUVw+Q3TzLblmkgsvMskj494I4jKPBl5E/M1WbpVIqahcQ57AJzevg/0yn/?=
 =?us-ascii?Q?FSnFDbbvFGjNMNVEP/fEh4jypD70O8TIHN4CvHUACYcd0zIkdJ8oD59bL1jm?=
 =?us-ascii?Q?UD9RwB+QxyygvQ+AUumDTtMe7vh4CAHOwR/VCOuJTSdd6hdMwR7Y9ajBwFjN?=
 =?us-ascii?Q?yLjz2qfqJVl3ieK65fvC2Uew0rrWtqoT3jNndHdwmTi0mJPw+/UhhWUYDXLq?=
 =?us-ascii?Q?XvMWf2A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?35X/gKMlLsTgaN7L/pGsBHEbgrSyU17qoCvZYRg8xxpsVNOKeK//2+mM46Y6?=
 =?us-ascii?Q?p5FKGUEBbJFPZf0z25wLjkd5OQHSBo+CtxmqHhTdlMlefFwOoIIzuWKdQLO2?=
 =?us-ascii?Q?58MhYekSzloZ40sXjUp02m46V0EdKuQynygzBVR/ZwGtx2v06PUEsdZI6cm+?=
 =?us-ascii?Q?g4HLcBpvaZj4ZPYeTMGJh9bLvyjeD4miiByFUhMYYBcMDVR1yVUzyitooOU6?=
 =?us-ascii?Q?OBsqD6r469Urf7ICBv/lgNJP4wxNoD0wc3wuvJbV//FVCwHR42V2ydbiCKPY?=
 =?us-ascii?Q?cwVqOgLGlWKN7YrcMQKnClwMfgtNs/BszSTKe5Ag1Cif/Z5xMDD39T9R+mUb?=
 =?us-ascii?Q?iLMEthRawImbG0C3/9+rs3O+m2vZEd3fd3QdBuTyHppICN+DM+paHf7Td+dj?=
 =?us-ascii?Q?N+1quxhWjNMAYozQll332n+o+iu88rgJeF7OeuUjKWdpJZAEXpUZIUIQZMmA?=
 =?us-ascii?Q?zPYDcfea2F6/3iV/IGtzMexF9s9DINqDIGpYpv+F6JWdPUc0gBrPoKpB07pK?=
 =?us-ascii?Q?vjk98xk+GI4/J7z9C6u+m8s01spF5C2LL1sWPxPEVoo8Ex5TAEAq5o2rfEh7?=
 =?us-ascii?Q?itnbkWCWAEkeCyZjYWQRCSwbqqu366c6plNKBWJULXLcVyWKXc5WkOCc+Bbe?=
 =?us-ascii?Q?/JKbI2ocX8Iq1O4WQWnBEJpIjjRcWvDdw+2Z7q+qtBQFiXObMIo5RLOeI5xz?=
 =?us-ascii?Q?kB7umRMQ68KUVzz4LDXkJc0qeGZbmI9omozbwnAeePqvR1MSvecFxLkgTHXN?=
 =?us-ascii?Q?dlCQ2nzgBA8KlnRquY4hiowG0wl+aVRZ1srrFc4iFo5BaWkUCLpndl0WlGhR?=
 =?us-ascii?Q?OdtHwNwxGHnc61kFGABSBONysaJYIy/4AW2Qs4oXHKKjdwMqHGBcu8mXnrZw?=
 =?us-ascii?Q?fZsEgJ2ysZO5SazMs2/UMvBvv5D5i22NME7a8UItdu6zSK4E0dG5Tqppf3Jd?=
 =?us-ascii?Q?RAv5ADWDi1Od9i7wNYFsKQTVCJlsMdiZgqZcOP+vQpH+pSE93gs/aRfCiTLa?=
 =?us-ascii?Q?A+nMKtYu1dq6/WK81Cp5SgYMUhNakdAQBn6iFDdX9B3161km9q9X+VEZzQpE?=
 =?us-ascii?Q?GweSaDOTxrxD9xvARvgmK3XfZXQj/T1KPUQ0pplcdjTGZ9RmnaN6oOkU0Sbw?=
 =?us-ascii?Q?+Hcb34vpXkf4e6ntVve0Zy7Ny5PQPn2zjzI7nKlWdgywpQy4EQk7SH51Y2x0?=
 =?us-ascii?Q?ol44RPO7Mb2U3kpq9EORZgj2JlVeLA9bkxHGJq8Lnk5GKbwrEX8Afmwq60u6?=
 =?us-ascii?Q?HVh2AKuVVa1R0OhjMJguZVn6aro+rWDTXwfj0QiqjcZkaVLA0NhsNWXxthz1?=
 =?us-ascii?Q?vflmgKg5+Nr2USi9VobTtuENxvJo2wSWwT02yC6kQCBX80emGBhWUTzGOcGK?=
 =?us-ascii?Q?CRxE71OumqI1BshqUt9q8aIEdJoSk6ERQxUdltlaWg3U1/xbxBy5Fbt/GEs9?=
 =?us-ascii?Q?nElqsDuZr5DBq8G7rBzt3xXfLp/MYtay61Qm8sl/PhuJbPJ6VY9CBtFq7P6S?=
 =?us-ascii?Q?q+Dt1i5yu3OnNFroknqmw2wkgo5hQglfVxthNS+fIWLY4WHsE4iNehfvN/uw?=
 =?us-ascii?Q?Cxnr1nKn+QsgZ4mtyI2EXHeLdUE5BijAVaIvFoEErJy4obBVzknpAiFr5heC?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666c1ab6-e000-41d8-cb8e-08ddd4235671
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 13:23:59.8463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGra3mDwkVUtzbmkqYBSH31eAjb2Qe62MOhRx11UVHOtnKMJhVodECxBOyMC5gUDPNB7nPb5wXVTPbvTdB4vng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6935
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 13:24:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19672

Hi David,

On 04.08.25 08:02, david.kauschke.ext@zeiss.com wrote:
> Hello CIP-members,
> =C2=A0
> I'm currently evaluating the use of an initramfs (as part of the unified
> kernel image, loaded by Efibootguard)
> within a Secure Boot chain on a Linux-based system,
> and I have some questions regarding potential GPLv3 licensing implication=
s.

That topic is surely not "just" affecting the initramfs. In
isar-cip-core (and not only there), we are further locking down the
rootfs via dm-verity & Co. We have to, for security reasons.

> =C2=A0
> Specifically, I've noticed that certain initramfs components, such as
> coreutils or awk are licensed under GPLv3.
> =C2=A0
> Since Secure Boot typically restricts the ability to modify or replace
> signed binaries,
> this raises potential concerns with GPLv3's "Installation Information"
> requirement.
> =C2=A0
> I would appreciate your insights on the following:
> 1)) Has this issue been previously discussed or addressed in the context
> of CIP-based Linux systems?
> 2)) Are there recommended approaches for avoiding GPLv3 components in
> initramfs, or for maintaining compliance with Secure Boot policies?
> For example, substituting GPLv3 tools with alternatives like BusyBox?
> =C2=A0

This topic was briefly discussed in CIP as potential common interest and
activity. However, it did not materialize into something concrete back then=
.

One reason for this might be that the question can be more complex than
"avoid GPLv3". It is something that first of all needs assessments by
your lawyer in your context, possibly also considering recent
developments like [1].

In some cases, doing measured boot can be an answer. In other cases
(though I haven't seen many yet), using device-specific keys that could
be handed out on request may work. In any case, we would need some
legally and economically common patterns with concrete todos to work on
something in CIP or with our supplying OSS communities.

Jan

[1]
https://fosdem.org/2025/schedule/event/fosdem-2025-6169-lgpl-enforced-in-ge=
rmany-how-we-helped-a-purchaser-use-the-courts-to-compel-compliance/

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

