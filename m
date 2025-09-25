Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C25DCAC5A5
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 13:41:20 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.58])
 by mx.groups.io with SMTP id smtpd.web10.11866.1758807673278807721
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 06:41:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=oNBslh8x;
 spf=pass (domain: siemens.com, ip: 52.101.70.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMpyr1vniwRNELsuIH3ZxCNFW/XZjn22o+Y5ic/0xIFbdGcciHeYrRpT+La+1PaPqRevGUupGqkDTfPXZbE8twKWV406j4w4zVHJr+N95CbYfpKhXn6biR5J8nVt5Fjfeao43qifZCYEbmIlXnfa4y4+yQv3NajRIUP2RMLlp8LCqkuxpPVRdNkzXVmunVKhTcs8ahR35e3bDSbSrUz2HnbyD3GasKorBGvjQHscEUhRpE1czip8Oc3EcN6O+V41Gi0ccrw8gjv8yBLmnyYRXlQLeWPHr56B7x+VYuAj7NI3h/CU+9ykAESl8SvooHAuAp3iUdMYj87GMpiGN1ySeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mscbEhHJlsdiwDTzofAy2cwEu5qDos0MUXbL14Iyi4=;
 b=jYkupIH+m+bE8B4GkXl9geGWz5RftipTa+cCYuz0VS7wplfUK75Lr5irWeBVYaLxVWYtgk3ktuwbEy9reZq2pp4EbstALOHO2sQwH9u2IYrSRYHYRn+7xjowgkOypLgkJY+WkAeDFjVbJo3/FLUsEHkw549uOtJAIFUoHiMHCdq6PnDPmj14p83HlRMWO5Y8qIFJK0faygUG/v3xEPFnjTFt/SdVJEMkn/xHpbs1et+jl6aRB7TcMaCAjdQWflSm5M9Tp3aZ0BwNi1eHkU7vTljpyNOc38RL7qgyeA0bYmxsakDgHIYR7B6qMkDAIfPTq3i5Ejr231JH0b5VbfJipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mscbEhHJlsdiwDTzofAy2cwEu5qDos0MUXbL14Iyi4=;
 b=oNBslh8x2UZc3cr7eWwok/8FXO9osNpGRBLOQa6RqLWpn3LJKPDkxM4LzrLhIwRl4sGJSxmq4AaBtd8GS4fuEvu4eYZHkIBIjvt8HQ0NwMmtUiOqvx5lVoBm6gD4Lg4ZQc/7SCDcxXuP8ydRpp63JTXmTjs7S+H7igeI/6PWeS7yEYmrmJgsiegsyXC2s6VN1LWhYdHAcKldJ/ef15TMLK7+7XyjVVOsP+/IRdMXc/dPLrFlgbwJzj6/p+eMbBZ3PUA1fHNFVO1KimCTt5yJqOhNm7pkG2zP2sbspUSo4sX/1/sGo17JrU4wzA0U+hTdbO6dxkBAAn0/4DCYq2pjQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 13:41:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:41:09 +0000
Message-ID: <af2bbe30-06eb-4c0c-bbeb-736f72d87f8f@siemens.com>
Date: Thu, 25 Sep 2025 15:41:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3a2cead3-c3ba-4426-a4f0-0f29f609a38d@siemens.com>
 <TY3PR01MB110755F0332B8DBE3C7653B3EC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB110755F0332B8DBE3C7653B3EC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:610:b2::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3606:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fbec38-e73e-49f8-ecef-08ddfc392f1b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BTxEzxQ+xsBoBu08xNiJVQvUMCsumlqEXh0qfSvCgU64cKa+K+/69TSqSNbk?=
 =?us-ascii?Q?O+irzv4VgxQYx/oSk0WtH7vNt4CkL1o7yzSGV36SjVBnElO8F00paKkLxSVY?=
 =?us-ascii?Q?+mJO4zsnPzkwJ5mj/hxdBDYc2w38G3OBqxtmfqimHdemZ6TJgt1M78KGWbhL?=
 =?us-ascii?Q?rc+DfTf0ObmCnMRh8gFWnycYoZv/caEYvPR3qcbdR6H9oEK1NAl5CmkaKKH9?=
 =?us-ascii?Q?1CGI0/1Pozbi84nyb0QTIGrdcd1NOIsDz5NuiiSS0CsKF/vCxQx4Lw+UcCpk?=
 =?us-ascii?Q?84+AOzBI42APfbfFO1h0cnTAoK42OaBTYS4HEyWqpakPaAOSatvAJXK9TK38?=
 =?us-ascii?Q?Nf4edjg+fgmQbPUdI2e+98NwbehVRAH+NHpHsZqKDMpFpevTHrNprUaDr70R?=
 =?us-ascii?Q?LQXEbR+Zn2RCpohM2Lowtfq4lDTXyNp7kctvdLL0KzPHmmugJ9xGaEk+di4i?=
 =?us-ascii?Q?cqTMLD5IVxJVwurQqe1Uui+wFSM16e9PV8KbrA666VgLId2Pl4Zg5zcXZkMe?=
 =?us-ascii?Q?j33Xl6ofAk4fuKqZw+QTnT2Nxft6uuYZ8xuMTAcEu9juIOsBux3XmOS+l4nW?=
 =?us-ascii?Q?cGsUKk0XpKNda+ywNVjb2/Cly5uvdAvvaUvEHDyNSY1MulKSt5ArONSRbMPa?=
 =?us-ascii?Q?yH7zL8jCW0q0ba4eSCoDm5tAO20+9QiSQ0maVyO4J1+RRu5n+gFQAxyVKzBJ?=
 =?us-ascii?Q?V8MpkM+6kDTb+NT7VvkzdA+35jk0ZOGE1glJQFCGUTBGj5ap7XkxfqAbCRYN?=
 =?us-ascii?Q?uMdHgz65oPmOvqF4DNLk9M5hdx8xdHTAGCAcAtro0P/qvVXCCHJm8jSWFmtR?=
 =?us-ascii?Q?IDM0EFlO0ywmAR4jDfObHdEDLPK38BB0NcbrgmSx2M+H8PJQNKJ4gTe/RLF9?=
 =?us-ascii?Q?ygeFxfiCj4cHfV6aCYE7H3/yAugghiqyM5ijT2qzIOoXTm+qOO/3k91M9R36?=
 =?us-ascii?Q?5Vd6KKfPXMDaVxB8MNj52TcJneQbotujvM/wh/Ne2bVsuwSdEAWwQvdMxYK0?=
 =?us-ascii?Q?z3oNs6Vvr7dBLSDxI7QE5fLmKb7uG5W3RnuNcQnE4xe056e4Fkxfg2aT4xwe?=
 =?us-ascii?Q?U7Tf4ebo5DahG4lH84zKMEOhTv/eIkSSrlG7RPA6Dshwmflo3YhpuCkHQtpY?=
 =?us-ascii?Q?e10QNF2EIZQJjp6vX5pR//29gPUX9Z+fUJZyhlHbLORa97JdCtckFiK8Tf5J?=
 =?us-ascii?Q?SsccrKj5m3sVEDT+sLix62GOIaydUPyoznvJDGdvRXZZ0mqE1x7r/CmIgrKT?=
 =?us-ascii?Q?3KlkyFz1HFTOA4WrkHjqbyiAIIni9JvEUhI5888GViD6sm7wNd/gj7ZkVert?=
 =?us-ascii?Q?2Nx68dxlwmf9KId4NrwGUavE6PqnG4tN94WLPIecCXACGrom053V23HnRvk5?=
 =?us-ascii?Q?KVOycioIb1q/YlJKaTHC9LIaOLirYcNzvZ3IL3uSVpyuolzw0Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UPlxA/jH9lBxqY0jEFji8vXTJxOdzr1V9ZOlMTPxJ30mve1ZBpZGicZcKSle?=
 =?us-ascii?Q?1IfgB5PxewnX3d5c0nJFX0lhzdXA6nDavLzIQGH7whEnOsgmYINgwIP04H7c?=
 =?us-ascii?Q?QmbrsykY65eGz4JwkGklvzVX6YpVlSGgBbS0BQaY1l85FmwlBvbGhVnT9AAF?=
 =?us-ascii?Q?dn71GHzRayn96h2o8tNW0o/tR/uylxe2BHigMcdKIP9zSWkHdXgQ1G3WfOtv?=
 =?us-ascii?Q?lvyAgXqaEIjiz16mOY90KYiD/rZ63mJ+1c57XBnAlVqBDdBj7xS/CgtjBmn+?=
 =?us-ascii?Q?VnwJSIqSlxvuepRx2KRxPfOGgnlHsspLYQHG1fOspP7nkQIhvHz5GYhREA8o?=
 =?us-ascii?Q?gZMMzTpaSJuEqhxxejIZCaOtB6y1bKLvnqLtI+TeKF+FSIk2e4ZecNxr0fDD?=
 =?us-ascii?Q?8NJ6B7hhJuWMml/NgkfPfb1k9eRxbQvOUGBn7E2mRkOPUmgopFU/pb4JNNgY?=
 =?us-ascii?Q?aImfR0hyd0jT9KyidTaEEM59g3x6u0K4CqFGCaKH2B0kb4pq0WbCAEiZZ7vO?=
 =?us-ascii?Q?G7y2DhywtxXjDFBqzbC1I/fubSzaYZg5QDoQBWnHmaA5I+UgRW9OKNffkw99?=
 =?us-ascii?Q?EAL8z/QLfgQ0Tjdcy1IMRsytjsdX3AacIw0/mhA2x5tVPu+7oGYCOU+fhHo2?=
 =?us-ascii?Q?07JY7IxvgTHWUDOrJxDcMUD1YiKe4qojwD/LTZ+GDfYGpkXh7IgtfbGzqop6?=
 =?us-ascii?Q?AP4WYmrB+HZ1BBIBPZAcbrrz8yY+5tknE72NkX9jRowlRelcssob+xRcvFr3?=
 =?us-ascii?Q?kEGJSqRXLACmdbVVUgy9WrqkPi+higvtCTWFZCFCi7xfHNTI247E95cMvXKQ?=
 =?us-ascii?Q?UcvBmLDKIaPoUmsfMCoY3/mbg/YU+OTg/L9ycP/iqgsI0404CMPd3zerd3jw?=
 =?us-ascii?Q?MfifKSwUGfKyCxzFZpM5VpdiLD6nueHinZ/7nBKphN/86iPZpEGgUVuUrFjG?=
 =?us-ascii?Q?u+sDCk7PMkI+uQcO3bvQpjwaES8c/B8eI4JvTw7zjnUBhWwqhvXDI0l80t0K?=
 =?us-ascii?Q?KEDLdnN2wRDBB1wvBUqsw5SvK3uN2WpSNEm30Zk6mnzx+GmxECDvvcSbcjJB?=
 =?us-ascii?Q?qt04QMptU68q4OWe3qfmTNV+jsMLET41f5iYmh9BXgscUIMZYLgs2pfmGgVp?=
 =?us-ascii?Q?sugci3O7LrnAisXhu8tlacVzFMeAV6fGXXCtjW8OYLbdaMv1wLSkYsz+Ronu?=
 =?us-ascii?Q?qjFSF9pJrhjfMpTbEaZk2s7tOTd5Jfpsidww+hflMdJNB7yrJEHHFuRpwsht?=
 =?us-ascii?Q?YiYX+PHxlEcMv+K5VgAiqDhnLJvAlX4HFcPUP5VE+S2jjTAgU5WVceQswNBL?=
 =?us-ascii?Q?QCXmXc+yOUKB//VQt1c990LfA2fAFTko8s0yE2I1IvH+juXJa2BdP65XlIKF?=
 =?us-ascii?Q?gk1OJPw2gKNyjmhDYnY0vJKZOGuYWKBNwgRY+AJTFfMKXRmvhJv6sBCbu9PD?=
 =?us-ascii?Q?L8sLxeDXozRXYSc8tZoauqaAlz98HnL3MhzMTs4jClwPjHGT3GOwDO/BBCRI?=
 =?us-ascii?Q?S2p5FoLWtyFr1FwfXs6Eg1jwwFzaVY51ltfch1KIO0wAAPwIMgeQx1T/bMwv?=
 =?us-ascii?Q?V+u/Nx3JVTrm4YV6IA4CRiOg1PEjTGOclqRUQLhcpkyjdIaSG7mc4oVMsO4j?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fbec38-e73e-49f8-ecef-08ddfc392f1b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:41:09.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KQlp2L0GSrY0rgPjVEaQuMyWIOeF15oqNU2wdSZ3+FQM6sW15fyg3VP2DwFYbvSGcuTPnQCrpea4hy1F2oRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3606
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 13:41:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20141

On 25.09.25 15:38, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan,=20
>=20
>> Is the underlying reason for that resolved now?
>=20
> Yes it=E2=80=99s already resolved by MR https://gitlab.com/cip-project/ci=
p-testing/cip-security-tests/-/merge_requests/35 so separate /home partitio=
n is not necessary. aide can identify the symlinks and test case is already=
 to updated accordingly in the above MR. =20
>=20

Happy to take a patch from you then ;)

Jan

> Thanks & Regards
> Shivanand K
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: 25 September 2025 18:29
> To: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST=
) <Shivanand.Kunijadar@toshiba-tsip.com>; cip-dev@lists.cip-project.org; Ch=
ris.Paterson2@renesas.com; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=
=B0 DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>
> Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
>=20
> On 25.09.25 13:34, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> Hi Jan,=20
>>
>>> I'm already running a test with
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/e4cf7170=
1983e3cb12f19efe9c217f500b9b0868
>>
>> Ah, ok. Thanks. Hope it solves the current timeout issue.
>>
>>> In the current image /home partition is deployed as separate partition,=
 so during the boot process the partitions /home and /var are   >encrypted =
which will usually take more time (even in QEMU) to complete so, we can con=
sider to remove deploying /home partition >separately for CI images and it =
saves some time. Data encryption can still be verified with /var partition
>>
>> IMO, we should also consider this, basically revert the patch " https://=
gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/2ff73188f261196da4e4=
cb60b8eacef7d6565b3e" + targets with "separate_home_partition: enable".=20
>> I believe it saves lot of time in CI considering multiple test targets. =
=20
>>
>=20
> Is the underlying reason for that resolved now?
>=20
> Jan
>=20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

