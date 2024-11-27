Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A474D6555E
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 05:28:48 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.89])
 by mx.groups.io with SMTP id smtpd.web10.65527.1732685319239652241
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Nov 2024 21:28:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qtFHVu/P;
 spf=pass (domain: siemens.com, ip: 40.107.22.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVSFwC8FJ61Hj8uvWiSVa9r9ucGOfRiNvk8r1Vyvi+gtT7DGiyap6ttm31d7Ltg1xwncFIYtk6QUr9HGqrscfnehQHwDGeT2mBVpwIotzqrH18nquJYAGTSEV9AhAXuMneQ0H11HJY8QaUO72KU3fnTMQyciJt+AT6pxkeDmNf0asbIPwDgTDJnFM0hwOVZmSk43rSFAQeeClHfrFwJEZv7v3df3UE8+Wq5xD/b1CjVPWGmQA0nlWCnKRg9D2etGcesxkp/RqmC3uD3VSGvFo0A2oelr1bEWMWG3QzANbJt2euLn9FBbb34YhGcJ02hGIHo0sILyWjxFOoH+6Ur2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2socWHW4dNtfZ43xNCNQDtg7OLJRUMYl5fCakCosZAs=;
 b=hb0qo/SgUjLUaWJrXav0/Aox/Xu0TXqU/IbKHXYQW94B1GwmKMbcXVzk65Ndxn41dshbGjUKT/WyQwaBtC/tV9a5PzSahlyGdG1U/qW5Jly8+lLQ9TYa3HANrjai4z6wXeiyNtLNs2fxM3Cr+EjDPYda69917R/cMALgui8Li8wnfNNv9+7NAnXiszqA9eYZ4+12VFiHxHoRSY61L7RoDowHLHcWT8SlP9TS+N9+QnvSmzC8JXVRzFtR7Nl+mtdZ7couQtrSBo/k7kf+mDhG3bUecY64xHsr1ykYFX4ODe++CJaVXxzz1I6myrdoNqo46p+F+kWIHd537tI2IC0R2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2socWHW4dNtfZ43xNCNQDtg7OLJRUMYl5fCakCosZAs=;
 b=qtFHVu/PRew9MY6XCF6x9TYfuCSh1c22oi0SOxYdlsVizpbxY4qGk0nywcW8cx/Zz6MJTpJ7CXSRl1jzcijF9s/FcfMPiY28iiwohf2M10wEdMNd0ek/jHRNjX647VHfYSthzmn2GLtrkxYan3gozUCyJZy11528wGoqw0NJ9tjI/R0tNvhAMWNL1XWM4tW+af39ppmPasn9akumUcqWLoJ2TyuZsNNYIIPVa3VavaoDiq5UK/TK/gxyPSyg1pSzVhgm3Cohb4+zq9pft1LaFqFIXLKxyIaiO8wLvJgm1OiYWR7jgAA/4rrR1iSkRRt1FgtI8tjaZyZKXOSuVx3HSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:420::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 05:28:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8207.009; Wed, 27 Nov 2024
 05:28:35 +0000
Message-ID: <84b98953-0729-45bd-9715-7c177464813c@siemens.com>
Date: Wed, 27 Nov 2024 13:28:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Hardware Support for Raspberry Pi 4
To: d.kauschke154@googlemail.com, cip-dev@lists.cip-project.org
References: <Ubf8.1732521612032277054.npTn@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Ubf8.1732521612032277054.npTn@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7b2473-d8fe-434f-2bd8-08dd0ea456d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7T41tR2sJM57z5+tvVIeUlCjc7b+FyL2/8NIFWcirr2WtRztty/Y6XKPSeSx?=
 =?us-ascii?Q?muQfgsrGqEBrBm+X1z/LYFWSNBryeMPUwk0RtlMG67U1nk/LauDyItbLE256?=
 =?us-ascii?Q?Sefv6+M5n5qnUN/jFpM6JxsTYI+BFcSVCZIvNarbuasDK59HKU7kdPYHCtkO?=
 =?us-ascii?Q?bpWd8Sf4JHpdDib0XYJG6hwrEnaMeVSykGa/TgR7kaQmEeKdKn3xp548594e?=
 =?us-ascii?Q?HQyQMHFczz9bzvjFkWj/1knLfpBwaWdT5rwbtU6yvCpVq6BdP9sxSuG3H+nH?=
 =?us-ascii?Q?D2qJgzIkC9SyQo1UVoWLPfZ0xn1uftOIHTcAs6NvtefIoybpmMH4OmPSL3Hr?=
 =?us-ascii?Q?Luccx7CI34+FfIxg7EuN9f6jLmGyYuGZKzDoN7Gw3mbdnX5pVyqSiKc3YHht?=
 =?us-ascii?Q?pZs7kNrGIzJEIGpXdPNW3dA+6gR+RaR61/RDoCdNy6t+JKY68VOPYhDdGRDr?=
 =?us-ascii?Q?Y0Mgv4EeWK9iK2DwzwJK4PBV3FJaLCECjREP32YDuH2LCClshlmcv2VBLjev?=
 =?us-ascii?Q?4KNBsEn7FwXte//F0qL3soXYDkHBN1I8FMABJg4mH+4sckCe9AHoqHmNvvSH?=
 =?us-ascii?Q?G2bZycVutmpqS6ULD3rlu4nz9Xfl3k1CIo78OL/2C3xgCPjI6Bd8kQSDyTZg?=
 =?us-ascii?Q?XnWD0AK6iU6rnPT0bRl4xODRHOyEwJKr11kVwDVm3lfdaJbLBPCheO3lnX3Z?=
 =?us-ascii?Q?MoRgzGeGBQ+04eOpxYHmjtdx/eufUhuwZgxbQSEuBigFktd0nSU3NHS0eA90?=
 =?us-ascii?Q?vU+FK4MyVZs4AqQltQiZSQUZJAeaQyN8ElFi2zEyfuUSf3S84AB0Zaz1Gtm1?=
 =?us-ascii?Q?I+ewS90pAJurBkvw0ilcrzmvWlNY7jodwqmOVa28BYlXYWS9dKSc0H/7u4Tg?=
 =?us-ascii?Q?facSd+tR8UXZ76da00ib/2k35YLfAEtwgbhG1cu8U+uB+RnjgtvOJjwRGZEp?=
 =?us-ascii?Q?TV8OZ87OOgeFSZE9T6QieXZ8EqdiXFVAapKU9WZmZ0OP9Z/8KeB9fom1LPPP?=
 =?us-ascii?Q?5ovfnfYCrJ93Q7Zu6pC+S2hm1Z8tob+RoQLpAnjSRr1vNFedlQJ1Y/WDXv3L?=
 =?us-ascii?Q?w/8FKkPA0DtyRz1ZIiRabboOVLD1bGftFhTk8vqe4D736G3kTKMqKpsQvvxR?=
 =?us-ascii?Q?bU29znvsZ+a1EK8WkN5UDtguU+4IOO7cgdHhHsTpXyjVmXK2xEeMWcWrjlVY?=
 =?us-ascii?Q?CQ14ga9LeqvIm3SaCfqNakvLAvWQtthiDAdhQTybb6lfcRJ7ngwxeYpR74OX?=
 =?us-ascii?Q?GcmzYN7SaWt0f1RB2QWVf66/pmjhepkMMoyrUtIiv6b2H118mfxOI0fJtHOj?=
 =?us-ascii?Q?tx9bgHT+iqUJECCkD10LyAPiepwlgcny5LD6xaqQWWTVsA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0bxbIe04fKx23HJg6gnKgQ3zP5Ysx0417rgPt9eWga/ndw6dVJke8Si/EC/T?=
 =?us-ascii?Q?nfr4kDkvdAOOySSaWF9TASheo51T3hLcOtWmdIUDdsCUWr+SqLIoUV+57p2z?=
 =?us-ascii?Q?EWfmwbJVuAEdRWDbJyu2vACgvCugxqhmKxTf4hbypZt1fbg3PC3KeHwiKMtP?=
 =?us-ascii?Q?yooqIlhaMYMoc2Ov9vR3xQeUehjAqWz3kHeNEKyjELP4klA27NlZWPiO+r6u?=
 =?us-ascii?Q?KEGDYsPy1VbdmGCcRlz/le27BKem7Bma9ZQDTfo1oAoafhIdkBLqkQ5JP/MG?=
 =?us-ascii?Q?1vHYVe3IdxhRUX5w8ktPR7E/mWx/xRBRuvbBcMhZWLe9rwxQsqx5j4Ij08Xu?=
 =?us-ascii?Q?o5Fx8TuilrQHzza2EwunmRjuRi/KvMByA3P7w/TId5OQ/vzUPuwmc9perbB/?=
 =?us-ascii?Q?liK5aGTmMM5xrkEdhKT8OFmEv/az8CzanMLJU5zzYfV9N6aUfysmRfBWyhO0?=
 =?us-ascii?Q?44bCBKbKyiWLB45ZFuvOJEW0MWugMlfGLJb0x2BFMbwwTjVhMlIFLN2Q5awz?=
 =?us-ascii?Q?e0nadowOx6ZulFUMST9cnpZpk5PjSfM9nqVcMckyF0NFAYV4kFQ2hpfl9K+K?=
 =?us-ascii?Q?HnIEAfdLNqYuwV4s1VhrfDmSaiMMkxEy0of8AVN1sbvOXvfZ9PhmK9/RU2rF?=
 =?us-ascii?Q?jsIS213+Z/YCch0japFep/CMWDvKLKJYeFWnDQoSf0cBEXLBj3wOErQaZ3cK?=
 =?us-ascii?Q?iWwSGhABrLF9MCaH3eKIiRiV5Ge3ExYj6weZXxaFZXXjVRscfFb/Axw5GdrX?=
 =?us-ascii?Q?RcPfVX9Wl4RXLFGzJzGBC7iREvY3t/r7eEnwd0t8GQjUE3FtYE5BOXR8pMBU?=
 =?us-ascii?Q?a9RHPE2L+bhoardP8C4tHDAknlBVioV1YDLHmVI+U6lv+jlTZojxDEi/A0PX?=
 =?us-ascii?Q?1QrVU6nHTwTgkaRQ9S3aXUGrAaoZypmXyZNQ++oTM7GXt5kAoXIFU3Tg6JzT?=
 =?us-ascii?Q?ilKrSm1te5sj1x7bboeW5tapVVRIq8tPPFM8KEFPW3RZlCOV7l43vofY0IlX?=
 =?us-ascii?Q?6h8I1sFuZW/Nf1YBszS83aOyh2qe6r8j18nBTAL5DVA+qOklZSUDadaJprDj?=
 =?us-ascii?Q?HGSWrUQrBv1PvbGFMOzsz2aRDGjm9MpkukMh98J56dfNlA23acoaVjcSR9el?=
 =?us-ascii?Q?2PWdJ4iPS/ej089WophlpFtxTPw0X25f7QvJmMnpOYTGUir9YqV+dNjRuDVT?=
 =?us-ascii?Q?ltI4uj4v1KKo4je5uqyoY0WtvQ5vtgCdyMyT22stXZ8BpSOUWZudYfEZlR5I?=
 =?us-ascii?Q?6Xhv5EvVhZfDdXK931V6rArC/vutdAp+0vmH6q6M+LSJIEK6D+meSZN9SAou?=
 =?us-ascii?Q?cfvazWkuG/lddlypAxSlLW6YGidMSXDCGTkKAeUrq5y9Du8HAJa+k3Kh7pZl?=
 =?us-ascii?Q?mozzUKw1vzMsLovz8rlzZNCP5InE20Vj+kXmKoITEmQ3qcflPFuTuY0tDr1l?=
 =?us-ascii?Q?0KNKfGiJFVLYThD3va6XbtULmQQWqcv0acHAgC+jWY7ax+ORE3aJqRBYoOli?=
 =?us-ascii?Q?TixMoAQPsht4PQpDPl3pa7Z3HQ/f00HpMfhNUpwyelY578BswKcne0uiB6Nv?=
 =?us-ascii?Q?dpgFMmOq3lLasaFbd+OfL2xbwNMMMkikr1vo0Z1ujTVjCkr7AQYQfkWfdcss?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7b2473-d8fe-434f-2bd8-08dd0ea456d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 05:28:35.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hms2QkzfSc8R1csdjJAdqgKNaorzGeyyVqVG7PJHYXFVPsDaUY/ZbtSHBBhzuTbAqHY6XQes2wkowV+skIKEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7073
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 05:28:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17282

Hi David,

On 25.11.24 16:00, d.kauschke154@googlemail.com wrote:
> Hello everyone,
> =C2=A0
> I am interested in understanding the current state of hardware support
> for the Raspberry Pi 4 within the cip project.
> My goal is to use the Raspberry Pi 4 with secure boot and secure update
> mechanisms based on the cip project.
> =C2=A0
> 1)) What progress has been made so far in supporting the Raspberry Pi 4
> hardware in the cip project?
> 2)) How can any remaining gaps or challenges be addressed to achieve
> full support?

IIRC, Quirin once had a prototype for that, just not public. He may
answer best what was need or what would still be missing.

> 3)) What steps or contributions would be most valuable in advancing this
> effort?

Baseline would be a booting image with a compatible CIP kernel. From
there, we would need to see what is missing for SWUpdate and Secure Boot
(both via UEFI). Probably just the integration of a chain-loaded recent
U-Boot as UEFI provider.

But note that no CIP member has so far expressed demand for officially
supporting that hardware and its SoC. So you may have to bring an
RPi-specific recipe rule to add potentially disabled (and not officially
supported) kernel features via a config snippet.

Jan

--=20
Siemens AG, Technology
Linux Expert Center

