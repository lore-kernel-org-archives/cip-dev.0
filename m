Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0832E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 15:39:09 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.54])
 by mx.groups.io with SMTP id smtpd.web11.51611.1736437142284886423
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 07:39:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=rendmsRS;
 spf=pass (domain: siemens.com, ip: 52.101.69.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8lWOru71QSXe8tB4yvszb9cOJuq2fckGbc7vehuArftVn8nDbanYl9eRtRljd3x5Ua/FaD0yMGIhSDd+fHIvvthhHuBR56vCAsFTbQNtE6Gn2t93y+jRnqOD9NG7O+iN93nbaIOwyH40yzjzG5qAqmzMifCx4/Ty52NKkq1P4mTj9bwPkFJIDG/nhy6EUSsVy3Hf3hmzFx60bR+XvlJDMJmUJF5Q+Sl9QNLrlSk4JqoRWW6rc6nyTldoqxTDo1/Yrq9aYpdb3AeomMKMuqdCopW4yf6Oa6oJF0yAunT0B4dSMG8OQmtw4Qn/1i59tjZyn12IRQeWh3qZ4eX9QfJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDYRCfXIaqZ2vxnuI6G5Pe5LcuYdUurRw5RN2BQ8LvA=;
 b=V2ugusUY+b3HSqReCUSUhL3ZDfZmkl8pkN3mvIOsp0030IUMOtPzb+6qtqnqaNCGaoj3HOL40SmSemgPguFYxUml/Z/yuq66GrcFmRFDHYD4tU5v4OJSJqAptYM7H6hSTp95SKMVMk/SdhAvSStE3a+nyh/wO7DH0VeB0OjlIuyfkeY8oPv1OMQTA8KfHzoX8hSPYQLKNJXwkpnY3LYHHJ+grOKke2wWZtwD/+yX8AFxn4Hy/27bw9ftbHqsLEML7Fz4aHQsRJW8MO1ntStbSJurJ0KFhwJndMLxntOl9QWgMA7qYaNI1ek48rgXl4PLuM9XfBS21tza9taEX1nXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDYRCfXIaqZ2vxnuI6G5Pe5LcuYdUurRw5RN2BQ8LvA=;
 b=rendmsRSYhTpy5dF2dUn/+RctX3Bm/q5Y/QSSXzkbgs8EOzVO4XhxJQ58jBXkHGrn7KcN1zjWV52oNDubZZkns6CrJDQ1D/6uA5Qzo4MY/dgX42MdyzrjADeno7ot1X0pS+zs1VYiwAUBcctOX65AdvfhiA717dymbusBRvKOLzHOai2Tv37VMQE3OarqdWRqN3RpKoiquOllA+0AAYR2TqLTJV/l6G1e13tuYNz0tOh9FMjCImsLTHgpOIHDaNEvf4vwbb7KkurkiHSs8/Hp9QBsAGZYRgR1xvDkAHz8YFiAUVnCTuEuCKfaKSVC0DkGhK51EcX5bl/vRAHKLdA2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6162.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 15:38:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 15:38:57 +0000
Message-ID: <fe44dc91-7eae-4dde-8efd-de636eadf9be@siemens.com>
Date: Thu, 9 Jan 2025 16:38:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs support in initramfs-crypt-hook
To: Stephen Ecker <stephenecker240@gmail.com>
CC: cip-dev@lists.cip-project.org
References: <CAK9C7GBuqQsWQahLo1pkpmSRGUr-Xi9ncPF6=ZNgkWOBZBaKNQ@mail.gmail.com>
 <52d71d4f-784d-4f8e-8d66-18fe2a912503@siemens.com>
 <CAK9C7GCBMs8awjxzw5iCy0xUbu+1LJmnSBSv9YR7YA5mKHVUJg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAK9C7GCBMs8awjxzw5iCy0xUbu+1LJmnSBSv9YR7YA5mKHVUJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 2963ded6-f39d-4c8d-92a3-08dd30c3bb03
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LVcM6R/cnvI1nnbSkiDL+OG6DTbDj47kpVPSWMFFbgyssKRaFJoTlJJf6e2i?=
 =?us-ascii?Q?YFnNwmAYbuXxpdcq3g3thdzSJVC9KxO6ypo/JbT6D9rVjwYQ23cCkBaCSazN?=
 =?us-ascii?Q?ZTBHeBM8GoqMk6/WkPsg2haaBzdmJzubZ6g1IXx1HqAdg4dT9qSe72YksE8O?=
 =?us-ascii?Q?M58e0paAFbBOcxPIPA3PVoa8EcnfGDDa5LDZ/l7Tax8cJDptTJYlWTAjE//E?=
 =?us-ascii?Q?Y1vUin1IAsvIPl8YH+XXO84k2yA7JMZE1ARjXp7h+IDpprAPmAqrghXcZqEM?=
 =?us-ascii?Q?QbWSz4MpIH2MNVA2NuddoODKkskOO3AttLwnph+G5iHgaVboXRf1y32zpJNC?=
 =?us-ascii?Q?GHwBw/9i3PWHQdKj3cMxxg3F8Dpc4L0cyJKhje8lkDFwpNGzBBhs3Izr01np?=
 =?us-ascii?Q?cNgUjYRfbqcbHwmXKPPKxNVomvXro7qR1mdfyxvsrea16WyDXUh1j1x1vQeI?=
 =?us-ascii?Q?1//7S/vI/0F0leHiW10QryMnPor5N0H1ULcpwRpUtEnJPQN4kdXT/G+1PeB2?=
 =?us-ascii?Q?uoJ71GMEv7dxIlEVxkUcakUfVNS6RDRnj1wq7ez4s3QmQAZX+e4XHLcuZLio?=
 =?us-ascii?Q?7CoC95pk8vro5y958AJAjvJ5FBm/nIRVl6sVW15cPsWpRBw9XtgREjbyAEPg?=
 =?us-ascii?Q?Qa2QJAp3yIG/a1UFFaUR48pXLNs01IrwtnxUGSozbHB8qIzABVGM1WNaG10x?=
 =?us-ascii?Q?kByqObj3PlsyRme+ERXe9J1w8EWhg7rnCFt2H2rxc4bgiRCAqV8XqeVSM3k7?=
 =?us-ascii?Q?o3P76qnNI5tQ3oAR7LfZh7VzfG4qdLvyJZuHhU9KIV9ogW6227OkKHQK4Ht4?=
 =?us-ascii?Q?0Axl/vLrIQXwpL7m6GHesQRs9M/nUaq31bVrJ+v/mXyU8t38rGCKASyLibkY?=
 =?us-ascii?Q?iVsnZzxBS7qBO/4SfU2Q83Y6rX67l8emqGonrwenA1z0mjIwLV6K0nImuhka?=
 =?us-ascii?Q?VBZzmViey5TcKDPK9UVq9rSxFQbP7p8JaAITxvVnvALzegl74ZAtYsR5iwzp?=
 =?us-ascii?Q?uBpAcaKvOfZ7EQm8c2Enay3LJEkJVkNBE3rYOHGEDcfQhRhXpHAMY+AJ4gJH?=
 =?us-ascii?Q?i95cefaPshDSTz0qaDZEUhxoaZ5CIBrUESVQUlwOWSV3ndp1s29Ox//W/5me?=
 =?us-ascii?Q?NVM3kYJNDHUI++LRIhQIav/v+EWHDXWR2NUOWk9pzD3uQnyp1G+QFpNgwvFw?=
 =?us-ascii?Q?9qjCLlyvJb9y6gdWUC4kLvzP0oqwNyxUseNYDqR+0u4Bu0dcCjTWWM68aNR7?=
 =?us-ascii?Q?FMLfBHn4gq9foU6BlQvf1uBqZc/wBeZFHPzIBeXwqH9ehkXSTN9+1tvrjupA?=
 =?us-ascii?Q?nVBLchtiQZlfzrEh3vpzMwmkH8wdKZ9uIivX4vUiVmTj6eniaq7nsV9VLktw?=
 =?us-ascii?Q?3Baj99H8CdyLAGexLvVIvjIW63nx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nWwwVhE2eFFyOQUNDpzqjqo+ogr/6QW3N/2HVdSRvMahnF4iRTHDEnO2OoCZ?=
 =?us-ascii?Q?AmN+HEJ1+osneGLTEKcuoW419tauvppaRZHqW3onTGUlZv73PZHB9X8tf2nk?=
 =?us-ascii?Q?m/4Afw/7u6AcXXmnStFTST87eemImrYU0LleHjL3FC+ciEr8e9inZEd/DM9X?=
 =?us-ascii?Q?USIv5bYwxoiBNu9YuLIjFnTT85E/tKdZNuSipbWsx4DZer+jgXmyT03YVmqC?=
 =?us-ascii?Q?zf4hD16mrANBd9MxazhB+/D2kd/A24glnJyQsqHK1U4vuoMYyjNGWQ1HfFDh?=
 =?us-ascii?Q?dEOw45AfY4JS0tpxRrCg44i0znfAlD6sgz9T64kWKp+kiOe9TutZrIq2Bh/V?=
 =?us-ascii?Q?MwgBIMPE2ClqmM3QPzZcWmJ2OcVxzrQ+IsKkt6GD9GV1pyFbVFu/4fmNHJ2B?=
 =?us-ascii?Q?IpciRLdySLzyohnfOkJyjq63F2fO4FT5HZE5PtWkOdAZPVPlmrpzFzUqKEap?=
 =?us-ascii?Q?qtuLIxj3N3ytfo8rifdVefrxaw342bQsNwdFv9dyjRmgrhfmlQXfvwb9MMxT?=
 =?us-ascii?Q?0u3VladvG67EUKeYuxs3FXGWjGWlFiV8qK5WNNnyyZ2taAHwRmFvqDl57p+M?=
 =?us-ascii?Q?cDQQSB0LPLugRVLqgLO4zBntmiFI9K1xsr5w8j//iQ96i51lmbfnyIWZ6eo2?=
 =?us-ascii?Q?UQc6rHiJYbvPZqzLrszsytrIP+JhteyN1AIaImMzH8+zhL6tH4wNHGTUXgjP?=
 =?us-ascii?Q?yO5mNw38M7J8IMseUtmXHJxmorJ5xtskVwPHAGZac7Kn1jryVmlCoTnZWyZl?=
 =?us-ascii?Q?dbvzQ9x3NOfc8ID5yb6nyEXrYkfJqFVI/60hBKu+bI9gyv6rBI/lVwBjEd7V?=
 =?us-ascii?Q?QAVGZTqGspkeuwJJyS60lcQXFNx/JpyGnJ4VF3FWsQej4v6lNLrVTbj+ynDQ?=
 =?us-ascii?Q?lv/UkJuxCmxDvUvsfbbHIRgYnrG960uPts6AhmNQK0VNm4HLvQXna6Ik5Jip?=
 =?us-ascii?Q?xC6e7UZK1/aiJlxnZnE/C5HkuMK4c0SXv/MP97f7ZXWIZPQOOU+fieGzJ30O?=
 =?us-ascii?Q?5MUxGsQe5NcCRl6UlrLBoXsHa1V99momdKxTskMCj2wiv1RdWhA118vJ56Tz?=
 =?us-ascii?Q?nkNGisklADuUUEQ8dSbkVZmRzEfhMTRrqvTbksT2YNfRWMRQsv5uQIK0ADqo?=
 =?us-ascii?Q?Xu4FMVeCLNcC2Rv2Fvp09HU+f7j3CEidKK4nqeNV63Zm4YQW7U4gHxW92Ehi?=
 =?us-ascii?Q?Up83IhfTNQJEZeKBK1A+avSepxdz1okpjiK/Gr7IRVsU9CBEBZnsIZOuB1v+?=
 =?us-ascii?Q?Qxam3HyQofRyfP8WWUX5o0dRLMtme3gY9v/E5E+rlkT9Fan2S445+iiKWJn4?=
 =?us-ascii?Q?iPNdtMlyzm6CFukiW+tXNf4tfoU6XRaaiYeRzp9k0/c5qPAP1mikiue5IAG9?=
 =?us-ascii?Q?6C1bsZwms0ermiG487D3NEEeNAVSKl8xCq6/aBH/vo1ID0pKU5GhLQosU2CO?=
 =?us-ascii?Q?kLTiE67Q2YkzDwD90iGUqOmHT/qdNc/OBs7qt6OdxEQaKdBfDgGIOwjmqWXk?=
 =?us-ascii?Q?SOj84bSwY7w4dIPg0rsQGXi6oPzIc+8CQ7Hs6RVVBmCg3PqMsBjJ+DcN3epJ?=
 =?us-ascii?Q?ke2f7tchDC5abHJtuc8VijBNCpbxUi6+PKb+zKei0diz+7GwuUccvPd09HMP?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2963ded6-f39d-4c8d-92a3-08dd30c3bb03
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 15:38:57.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzrmnX5WYI3TyMWPuAtz+Kbcg1DraMSaekWx7DYmt6kQ4ZCfCYdrhFRKxW+bIbcA5ZTy7Lw2WWXBK65vdZB6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6162
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 15:39:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17517

On 09.01.25 16:32, Stephen Ecker wrote:
> Because the upstream version requires a bunch of libs that would have to
> be added to the initramfs. I compiled the binaries static... The e2fs
> binaries added were from a static package... There was no static
> equivalent for btrfs.

We do maintain a few custom recipes for packages, primarily to handle
backports of patches that won't hit Debian (very-old-)stable anymore.
This one would be more of a feature recipe, and we would have to look at
that carefully because of extra maintenance efforts.

Please split up your patch queue, adding this as optimization on top
(unless that is already the case) while starting with regular
btrfs-progs. And please open a bug with btrfs-progs in Debian to trigger
a discussion there as well. If this optimization is important, it should
become an upstream feature eventually.

Jan

>=20
> On Thu, Jan 9, 2025, 9:27 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
>=20
>     On 09.01.25 13:37, Stephen Ecker wrote:
>     > Is the reason for lack of support here due to not having a package =
for
>     > btrfs-progs-static, or was there some other reason?
>     >
>     > I made my own recipe for building the btrfs-progs-static package.=
=C2=A0
>     Would
>     > this be worth submitting a PR to add this support?
>     >
>=20
>     Primarily lack of use case so far - there are some operational
>     challenges with btrfs for embedded and offline image building.
>=20
>     But adding btrfs support is imaginable. It would "just" require at le=
ast
>     some test coverage in-tree.
>=20
>     BTW, why an own btrfs packages, why not picking from upstream
>     btrfs-progs? That will need a strong reasoning.
>=20
>     Jan
>=20
>     --=20
>     Siemens AG, Foundational Technologies
>     Linux Expert Center
>=20


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

