Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B8BC28B2E
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 09:28:36 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.50])
 by mx.groups.io with SMTP id smtpd.web10.33650.1741598909298357386
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 02:28:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=OUCHAVv5;
 spf=pass (domain: siemens.com, ip: 40.107.21.50, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2SzueuyB0W5Zzpru3H9aX/b2ItnfaeGEJ46R91Xbn+KAk9PMtn6QyGDSQSEXEZxC3GFGJScwnzelDTIg6qaWDHhjFN5PKN7lP6T3Ij29rBf+2jBKGEYPrK4njbCF8M9cDqpNk+l6og8uWm+PQ07W+MU7kqcUwRFg+cZqt1quHvKonD5yk+4bFvy6/0S2c+YcQugAtY/kESnd9OSA1l9I0D3PPaQBATMxm1IkvdeL1HnZ2kJ3rOEZ3kyCfoh4Mz07VuAY5F89tKbOBdsAZKW5tZK4O55yUZ0Ln1T1I+TuAQzsIkEDNFJZc985pS4TX1aYrS7Z/BHKq94e47BDh+Vaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9VkIWYC5hPDifloU4UdEYuW5bKafuv1ro42vvgNnQ8=;
 b=ventLeogBH6QdgWrVQb22PGQY4vj0m+G0QhUkKg8R4x/MFcRTZ2BDdmvbTLLz/F5CStiyN2FXMn2LLR5Pe0D4SeHCvUjaDwTTv2SwIVp3yKj0E24dcyeV08QunB51VOaauWHqWNNEAcsosPaYjM0LXqivfWmN/BaWS4hOllPrf11QpBY8xGhg0GxkABHvy7Vmnjn5RKunsmOUlKuYuGFf/fjDD6IJqulozOj/W8aNiVro2yWOv/n0PBHvj0F91Ic/CgknLi4I/jMnbv52g7u12ifgFlaIw6l2JRB1h3FdVuW8sQHtxYR+I3Vf5z51qpZlvZQDJUMbGV3Y/xfxW1wmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9VkIWYC5hPDifloU4UdEYuW5bKafuv1ro42vvgNnQ8=;
 b=OUCHAVv5T78n2O+k0wYGKkt5kisV9rUX7PJ9hTbuQRVAWVTnWuK0vaIdDM9NyPBgYzQ0IiKquSBMjVt1G/pWmlm95NieWZQczMkc283UEoNFgTOEn4AX/YCtt9HkdxlbzicaEpjIJTCMjkXIP1cg/uyfPRdjNd2anjyDe7ZvG3h78FU2V+oCd2Q2Kt/6s5YzgkzfcJqVfwXmCOZcm1JHuaE7L9gBr36MZmBocZaU7oN7FAxh4HUDhMmm0qABwqNq+8SdJ6qfRcPUU8CXANPgQ8wf/Vo0+cLsPdON4RFLYdL7dZPF9Y/F/U/Y8t7mCEKREuqTiYmw9xqjELOgY9nWbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI0PR10MB9055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 09:28:25 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%2]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 09:28:25 +0000
Message-ID: <b50285e6-d615-4add-b84a-1a8e05b80542@siemens.com>
Date: Mon, 10 Mar 2025 10:28:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
To: =?UTF-8?B?w4dldGluLCBHw7ZraGFuIChGVCBEIEVVIFRSIEMmRSk=?=
 <gokhan.cetin@siemens.com>, "Kiszka, Jan (FT RPD CED)"
 <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
 <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
 <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI0PR10MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8da7a7-cbc3-426a-3d6f-08dd5fb5e8cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JWT4Ypp/nMAGMN1sInO2Rd8Twbo2IcdtM9yAFXp+5uy30RMHXrOzpet59DwZ?=
 =?us-ascii?Q?fq4kipZ9vhucJUUz7ypfVJRynbgRMvE+oQy6p76bWtcSvAu1dBgGywGaDNPa?=
 =?us-ascii?Q?/aoDjQqLp0aKPI0V/lrPJiFv6fl2h32TVctqle9UvGG4NYeOiVImWXk2IenI?=
 =?us-ascii?Q?u7ik/UdWBQuibqmv8qkhQCniGefXCh2KsAB+C/aiVpgHRvpDIK6UkDrytNfI?=
 =?us-ascii?Q?7HfSK6vM9s9CruH9d/SzBLMl+WIUKM+NaquB4UShSwvLuesPT0i5KF/JEQzo?=
 =?us-ascii?Q?uA1rxRhdA2UkCg3V4uTRwBIK8pa7ZgG3dk7EgLPZGV7g6MKTYd7jzDEoTtu9?=
 =?us-ascii?Q?dGK2RnEwSUjwMNOfEQxHCmPxPeUIs9THKxh8fiYt+cHl78Gq8XF7I8s1vVJ3?=
 =?us-ascii?Q?zslBWXQkZ1Xy4V3qo+B7bcym68ouul7yLDDY7BH7vxOuEM9b5ri+U2GoNxmJ?=
 =?us-ascii?Q?G80aNRpBZraR3SkjIT5lK7AAArSyITvFftIIP5Bz52oR6AdHX9hZXkfqDFPK?=
 =?us-ascii?Q?F0q3cKI1oveAWkZq4h/o1sx9avfFXn0ru92tEbWM6Dvaprm98Jn3DwPcRv00?=
 =?us-ascii?Q?kzi8N+1E0wcQhNrxofRGl9NTTSG/o3MLvPY4/aUPFoO2NNT2rtGuhOIFMQ34?=
 =?us-ascii?Q?XC23/FUEA1cjitGmsedZTUe+Zg+qN2H/UmYAKh1NixBhWPVjMZSfYzMLXqW+?=
 =?us-ascii?Q?a4FFwlhSrAEvAsQzR40Munr9JtntZcaNBmVmTSzUY2gBmVd17IT48b31AiPw?=
 =?us-ascii?Q?/mDko3r6MLKAidvmZKZARol67yVA7BMpn1tc6ELieLey7LwxGIwC9i1X0qtP?=
 =?us-ascii?Q?LYxlBw1ec/0vrXIKHin+ilZ8qov9VEj3ajDGR8pgu5bkGOnisHJQwa7HybWf?=
 =?us-ascii?Q?BZB//Eigl2FaGNqTrfDA0XhsX0NJYOIha4GXAfABUzWRxA9kEfzMGmQq6M0S?=
 =?us-ascii?Q?5vDLdKYwueRfzpXDfJbjGROE+Sqk2CYrKRa44KOk6JsJcV9irjLa7S+9ejj6?=
 =?us-ascii?Q?dCGz++7qEHRD8W4x8itLRsBw/ytuiq30V1WPkKXPljATUtibqrrMsueK4Ilg?=
 =?us-ascii?Q?NkCYF/MjtvOgYgPBxvjuoxCTEYpTsJsYwZBpU0PEQ24Dvw4HeVtikzKaqeOi?=
 =?us-ascii?Q?nqJ2R0zJPEL+Xuh6lTG65sKLV8YhQe/fJ96urosLe46qc9jtkK88jFZwtCYY?=
 =?us-ascii?Q?91EvX2UWqo5ZDdmQmBolCQtluJWMXua4CjA6zItpNBqkNxGHb4d7aQ472zoq?=
 =?us-ascii?Q?kLGAZs5o08UlwAsUjcN52fSg4F+d9aJQvrhmO2Gtst6SCmDqBJc6hiRjtYNu?=
 =?us-ascii?Q?vGuKcTIGOF3lPAU9e5zOTYk6xUUtmRflg1jn0z+kYB/lLKAVOV/WFy63sfij?=
 =?us-ascii?Q?BV6GU7Oi1MLNzZZSWT/V78X31Iy6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RcfE+3Ju6Z9FwxZvMUPHfF06/qO6NraS7UfJoUelAr0zzALAZEqKBmM5EXe8?=
 =?us-ascii?Q?/+84qHAQ4s0sVPHLb+v4mZU8kHRTS0pOithAufag9dIHHd8X5qfF9rDuJwaS?=
 =?us-ascii?Q?d/VcDN7hEbJ0DBVyDTRcMxXFuzlNHUzh0+dX3aWcbH8I3a7e4mh7Al5lrV2z?=
 =?us-ascii?Q?CWkDLMXcEBWECL0SxV+CUmSWuo2Q+u1CGdHZWntBxxuE6WzrUy/GyPOVGdN6?=
 =?us-ascii?Q?0xh5LoSLUUbTrRUDr6QIi4UkZAegkkEH/3jMQhwHfG2SM+CdqfH/lEsooNwJ?=
 =?us-ascii?Q?//vM0gQo53e3VDiJzVfl6QGLEnOUXHYnQZnEUVBm7HSlI6/M1IECxJq1ENic?=
 =?us-ascii?Q?n3nXkdsXrks+ad1yC/D4FQ8qMfesjXQjFXR9IaTbSmQWxuK0rNx9qAQBEpN4?=
 =?us-ascii?Q?ckGogkQIaSCJcYcKckUsEp5Cw57kTIYJcNB4tBJdrotEvrBTebReSGMBpIz2?=
 =?us-ascii?Q?UCpV/+Mg1MApo+WWdGGHtWxjh7lTKU+PHYmh3mIPTPwfPSTIkpZxQ9kM1gkj?=
 =?us-ascii?Q?vKl6ZxJnsj2UxJpFemvCGSjr+EmTDxy7cay6urHGHiJIcuyNsTkvEaSR0oPF?=
 =?us-ascii?Q?a4y7kc964MDp/t1qnBI1UnRVwbrrnC8eNl4BmdH3CiD12Njc3BAazeLDByDI?=
 =?us-ascii?Q?ISqjfMpFNqWKI1OeJDaz3gteQ7NdfMajf1c3O37owZRdPwK/SDjvSWAHCuip?=
 =?us-ascii?Q?BO54cvSrqghHp/SVrJgkGf2gb1GcehUk/YlYiFsuyuMX4cBu+cLwHuNlhVdj?=
 =?us-ascii?Q?odgN4HjJplWoAAlUv2qxyki5rIToYJ5dkx8YG9O5XcIhZbqjo/tHf3mtzA5z?=
 =?us-ascii?Q?zwVSvXP5RnykKOJvjrJ7VHam0u+aGIdOsbbDDyo9ws3KGbwcyJXgOPqXpoj9?=
 =?us-ascii?Q?+Uss1GDr/DsEaPoN5YN23b+CZT+Wv1IM4rMHedUbyAfckYI2gCPSd/We3qKL?=
 =?us-ascii?Q?BRpFYVK7pyjmHSXDg60sLEgMu1U/5jKToo+vC9RfLIW+/9hyQliiFPrlzoMv?=
 =?us-ascii?Q?GqwSEQwN3lwiKS2k314SlSoOCfzcRqYG6Jln4pniCIOF/TeDQvufvSTDsrNQ?=
 =?us-ascii?Q?utwO0KPjAdveh27rXxEMHTDaxFWZUSERjEe3A5tUfc7btHFLjMlJ/CDGvGv8?=
 =?us-ascii?Q?GnOpiON+UXIKXspJaTLkTHo472Wh3yq62pJTScZdhg8szQtoLAK6zS6NW7f2?=
 =?us-ascii?Q?eo9sClWJTMeqW+zuWcyd7k98nPvlo3u7v/z4pFrXZuPAbK9+wKPGxuO92fL3?=
 =?us-ascii?Q?DTX0AS+IptaisFp5wcLlrBlIiKFQ5AnOQqPIP3JFr8C2lmK9c+SETG0SP+pk?=
 =?us-ascii?Q?qFES8LIr6CLavsjytezfBdb32s8UwIybUwK6OWmAYJ6WGTkMRCFYXoalC+Xr?=
 =?us-ascii?Q?cc5ClNm0ndyBe/EvetZ2DgDGKw+038pxtWitPySWmqJEiLVTovHXQwW5CN9/?=
 =?us-ascii?Q?bMXcjGUZ+/x64A9Z9b0y/I9JzVKxe7lp2zgyMbmgaILi29aa/Ukw7HHTOUTh?=
 =?us-ascii?Q?YgNX/kia4EJyyPwoZpvKcG3y4pYQwQ1mUGFfOH6GxGt4e+mtKRkBxBu4fMhS?=
 =?us-ascii?Q?dQEVgBZwOM7iMWxkLTqb/2OSbFk1ccXlaDIs7tphZ6/FOe6PGi3BAKH0PvcC?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8da7a7-cbc3-426a-3d6f-08dd5fb5e8cc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 09:28:25.7292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFlIV0sK7prmhxV4E/WeE5WYZ0cpVIPGz3CzGVrP8B7sjgEbrADDVBLK2rKL6yq+c6a9yteiDwO5AHTeutIFTSCKiF9LtSmyUUoNTfRs7JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9055
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Mar 2025 09:28:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18074



On 3/6/25 14:46, =C3=87etin, G=C3=B6khan (FT D EU TR C&E) wrote:
> Hi Jan,
>=20
> I haven't had a chance to try it directly, but past complaints about usin=
g OpenSSL provider/engine together with sbsign's OpenSSL3 support have held=
 us back from maintaining/implementing an custom OpenSSL provider for serve=
r side signing.
>=20
> In this scenario, pesign is used only for import/export of attributes/sig=
nature and this feature makes integration with other tools much easier.

sbsign should replicate that with the option `--detached`.

Quirin
>=20
> Since I observed similar signing patterns and toolsets being repeated in =
different projects, I thought we could upstream it. It is still possible ho=
ok different signer recipes/scripts in downstream layers by configuring it =
on partition's source parameters or installing a different signer recipe so=
 this is not blocker for us and could stay in downstream.
>=20
> Thanks,
> Gokhan
>=20
> -----Original Message-----
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
> Sent: Thursday, March 6, 2025 14:48
> To: Gylstorff, Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>;=
 =C3=87etin, G=C3=B6khan (FT D EU TR C&E) <gokhan.cetin@siemens.com>; cip-d=
ev@lists.cip-project.org
> Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to si=
gner provider that hooks sign-secure-image
>=20
> On 06.03.25 12:44, Quirin Gylstorff wrote:
>>
>>
>> On 3/6/25 10:35, Gokhan Cetin wrote:
>>> These changes split the signing process into two stages.
>>> In the first stage, the `sign-secure-image` script called by the
>>> efibootguard wic plugin now uses a hook to create a detached
>>> signature.
>>>
>>> This allows downstream layers to provide their own signer scripts in
>>> a similar manner for the second stage, without having to overwrite
>>> signer script or partition's source parameter.
>>>
>>
>> This patch does two steps at once:
>> - switch to pesign
>> - split the signing process
>>
>> Please separate this steps into two patchsets. Also you need justify
>> the switch to pesign.
>=20
> We went for sbsign for very strong reasons like its broad usage in distro=
s and the support for OpenSSL which enables e.g. HSM-backed signing.
>=20
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


