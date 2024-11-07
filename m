Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE2D43356
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 12:11:44 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.65])
 by mx.groups.io with SMTP id smtpd.web10.70505.1730981496088123684
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 04:11:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bn2LXCKS;
 spf=pass (domain: siemens.com, ip: 40.107.103.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3Vljz7k5F1vCpg96ZHS6t0wZxDaaIq14eVZR+aXLGwhg1f+rLQ4TpgVKJ4qL+Xv+OOagKGuANqU/X+FalEaXaplJJG2/9BP9gak7vJwjlv+yDbvX37XClHEYyC1LFlCcavNvCL3GAUGOiQ3YC+qwRD93+zRP7RCjmuXay1kMJIn3FedA0oBHgaJgJlWQv+3wQoQY9j+dQTrnuDiEFLcS4Pgy/iHk1oYrC55d4ZnRNN5AkBFqE5nUdgmXYf/uln4TTqxH0DcBC8sOOdyeT8zJXRWd4JCKhY7iFaOJlbFrf47szXxobDFhq8SiPukPgR+vK7c0wmhLEZStpd4ZAQKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrNcxgYPUdsV7Rj2qKWufcFhCQA9W21WS9+ob9Dgtps=;
 b=AXLvqWKteMPVNAZC3mohXkQ5rNjytBz4R6YmflQtoh3YKisFxm8jgDR3AmtU52dLd6OzKOAoZUIwaQAX13CCJnYVJTk12Aqp9Y7ZyLvPCA2Z8O92q5X+KFaWfwwoQq73G3ja7cfhwSPOYZtXwOF/+zU4SUr+Kw6P/O5VgeLiCjGN4z9nmHXDMFJLGU1KAP/rVsWJiKPykqUZ3Rfe0w73wLpMDiCsvtMHWnmcOTSqLf2YBtTcrNonZOumb23N4GDRM2Q2mt/Gu2BzZyHmHTgamUiUpH8C3TiUry3eQVeVVe5ilSvbaYclfiiWYxVN1+68zQ7tC6CmhOhA3JfCroPe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrNcxgYPUdsV7Rj2qKWufcFhCQA9W21WS9+ob9Dgtps=;
 b=bn2LXCKSLTDRjdunsKH6kLqBgwKJk9IrYJt9SO16kkxjnrTYgM8d3Q7YqIIS5cNSu5YFlhdBj3EmqZUoaw2ftXPE0y7F0DwH9pikQLyw9gykocsHIYswRVlhbNDAxJ0KrI81EjaQJsDpfNb32YChAQYlq7UTCuqpe1qqNCia+uqT/pbyMr42zeI3dOEUYVIgU0AEUVNUD1pkKiwu0u5LyogEkhIh4G5W+kg4Le+II7wtrqvjcmp//kUwPalYD8ozOUo8fs7G+luC3DU4UdAgUa8lhlSkwTEhAG9ha0nVCz3iLSQAmRXJLRiD4b0KUzw0f/IDFb+0pqRqsVXVYZs+Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8175.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:652::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 12:11:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 12:11:32 +0000
Message-ID: <e5081064-f132-4d95-9254-e2962ae7bcc9@siemens.com>
Date: Thu, 7 Nov 2024 13:11:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/9] swupdate: Control self-building via
 boolean var
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
CC: Cedric Hombourger <cedric.hombourger@siemens.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
 <c6ab307ddf903298d2fe23ad93b1e6a251ecc6b1.1730977077.git.jan.kiszka@siemens.com>
 <af85d99b-c02f-462d-b668-7a41ca966dd9@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <af85d99b-c02f-462d-b668-7a41ca966dd9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:610:e6::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af3ed16-8e22-48e1-aab8-08dcff255122
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MjZUReRxhfofJVZa/RPyUktEACG5d6mGBEiVZVOInkuzFlk576379XVPh6Xo?=
 =?us-ascii?Q?/JUWl3jPJ70WCYzj1xAS0hvnE7spSxS9a49tEbPXi2UatYdmT9urLV+dwr3q?=
 =?us-ascii?Q?UIxSO7T8TU2Obz5K5HKJWqa6GFl5b5EyiVDsOazeIAe0tOGGEkDXfYD+ANJ0?=
 =?us-ascii?Q?aHy0qSTUMk0rvyohLsyUB6VcXrqpZG7D8SfBjEmcGJG+4zTerHm/0L73uEo1?=
 =?us-ascii?Q?STwbCnny98EBhfgInRhp2aHT3b09+HbkZhjPy9fjh3CzFDRBel0sRwoyJEEA?=
 =?us-ascii?Q?em5IiTRBHGls8h0JqiCTdiW2q5L3P6ahq2BQAWACAVdDzGMCvLQl52dQFe4H?=
 =?us-ascii?Q?qwjOfzyMYusFqW5ca7piz4hElAYen2tLqtRjwgUWXeuF/1ShffYbEubLkF5g?=
 =?us-ascii?Q?Vh2RTut7IxewTj6QpTtp98RNVxU798vt8cXS9Y9HGzKyNlqIRxPAFd/nM8oB?=
 =?us-ascii?Q?iB6V7zojhiAhIwAOGWyFR/KqLkgkc9wFcylM3w1ZLusSlE3nLN6An+Tu+h7U?=
 =?us-ascii?Q?y/iw2xCq7OyYGJ9yUcko9vPSNVWRq0d9xw+1njzGoEAVkGUJhelOCXGsw58C?=
 =?us-ascii?Q?Y/JcCJQz0g+JG8+Gpeoxh7OxwIfc0fyAA7ZGBOiTFAV8nnZV17IRS1YifZMq?=
 =?us-ascii?Q?2fiYaHnG/+oiYB7bz9p3Y1EmTzBtHKx/zF2ehhed0V5A+c9MSFF+UplwYSM7?=
 =?us-ascii?Q?JNljCMk+9QyUnbaOIidjgDA9IT7pVMoY6dhg4Fwv+tTyhSC5mc6kVrwIAzV+?=
 =?us-ascii?Q?ZfL2AGFC6Xiu7oSP/a4ZYNWCszZJ3rqZF5AsG8Sgj7qsvNZnUrxYbGwAObit?=
 =?us-ascii?Q?Mg1gF3AJdbYX9rJwDfQBFefJI2UIKieStxRcbN6foqhHKUJmAxXHX2XZMVXe?=
 =?us-ascii?Q?/y0mJdi8l6LZwOWtNPgxQOJ7XMVxSTrORUoBpEQ+1IpdU7O7C9582HgEuKea?=
 =?us-ascii?Q?GdfVw4EizfCfHdIod7pz9LMPwXhMJ9suXwqVzzqBHFuFFZ4wHvIJBNHZ24HR?=
 =?us-ascii?Q?SdZhauEs9zSZp8VghazVeS7rLufnXUz41KT5ECKFMvU3TmLRDXRANrJ99rYg?=
 =?us-ascii?Q?kaFQOfFq3Bvsyba6VRjiV8q3AdVjNn7thsZq+ogZLbNYKXYnN2r5LWuT4ifp?=
 =?us-ascii?Q?921owTGd84V12uHyeZnbPlIALVSMFC83+oqcV/RK/FgzHyfdpzUqZC/MX0Za?=
 =?us-ascii?Q?Uf9KfrXnpcUW5h0k8MJ4LdSt8RYu2jEjCkb336dZgzySj7qFnB9zsOOYgZkY?=
 =?us-ascii?Q?arFiUjXZIDZMenmtcLdDYEHOU5T0eeuH9dysEJqD087CshEBdi8PJHQ8sHIu?=
 =?us-ascii?Q?4b8y9LjkKvNeMfWTepNYBjj4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qpFqC/cwlVgUz1WrDvdD0/1HhSShiZWgmbM3wLU1Z2fmE9l4tktWd3BA8G6c?=
 =?us-ascii?Q?+oi9uAvJj+McGi5D8abvEE1EiByYT4kLnadg36SU9ReFv+eDAygrU96y111b?=
 =?us-ascii?Q?GcetP19PeY7nO403I9RbueYY6ljVZKaZRp8G/Pb+S8jdiQEO6jYSoR0gmhNK?=
 =?us-ascii?Q?w20QwB0FzChA16aAdUtAKv5b9wbZRjqpLFg8++Gx6Y7NhW9VeehVxNPStz0E?=
 =?us-ascii?Q?ihenembQaE6t7UsTvkl+Q0sdGhUH2LXcJ38e+DkRSty+N1XFOsji7dRCUrdz?=
 =?us-ascii?Q?CLo5fwMihZ15Gy4pi16Sfxf0i9hyNUZkfTOGYyj01Nvudja9ZkTrqKc2nJKI?=
 =?us-ascii?Q?tzJSIds0nu2K2rxFirIxeiPDPiXZXZGit6SL5fmLMa8b2VpjMbtVFb5WoGnY?=
 =?us-ascii?Q?CJbi7GXVG6C1PlccV9ajr0zCa9y6paNZel3ZlQE79BP4W8xSH2EWAmFzzKT4?=
 =?us-ascii?Q?k1krpD9WXybdJV6+ti1IDP6hhJipp+UyCQp4TzMw+R8v0mUUb6uF5l3x18ih?=
 =?us-ascii?Q?wPIagDL7TlSSTV8eUsS9eyzDt27KlB3kP1Y1DdGxqeW7k74pW9BNvVokLwhX?=
 =?us-ascii?Q?o2dLp20aOawIV3Z8yAaNt4qWCPiaL6gdpCVPPiQcsvR0eby/FqpYVRRGDTVn?=
 =?us-ascii?Q?ZvVKNg/IrNmCDdR3HOnjLZ5arh/ExymAqRDOAdsNXzoinlfXzJ3MH70lefwk?=
 =?us-ascii?Q?1S5u9h1svGuY3eBFtZO1x/Q/x+hXQSMXkxlHagIMu+IywjRvf3gIQ8saVnDC?=
 =?us-ascii?Q?8lZ5apmjgAYA+pc82J9Y/y8L67an3UKLmcl8/8WJG813AWQkPFD7uTE8uGrb?=
 =?us-ascii?Q?OtXr/ZF+TiIrbFMUNuOhQ1Zz+KiNLHhFnUoKg4wjFx9d/Bht9GfXRztYcv9i?=
 =?us-ascii?Q?Iqae7IWC8g1mnNe2Yy3BFq1LlZ6Yf/TQTdvarJoCUgzFe4m8yhAwmBn0G+SX?=
 =?us-ascii?Q?Kb5RSQd9Du7ffyU1MwIMC5qL+eZ5IdazEdFjFXh9/8mBKoysO1Ss85HVS3nf?=
 =?us-ascii?Q?Z74X+bhYBWCdqB07xHtMv1Ii7XCYC6Z6og/JhiypumNqRd9bYMTi/94JXJtB?=
 =?us-ascii?Q?AB0bP/rqq4fMwjMT6+Jv+kYIvgjGFrituHMYHd8GiWZHce1YH8a989VLSeqV?=
 =?us-ascii?Q?xVvuLK8C6HPfMJJimWvqCNfHCy2N+tjU0Gh4F1UVBo68/6Cld7N0MAx5MWFs?=
 =?us-ascii?Q?KwHhb8KgHRtwR2caqBy2h3kC5K1d2tgq2xumPuX/xM1whLv/oM5nNxeQWqn+?=
 =?us-ascii?Q?/dJ9Wz+LZ79KMPRgjfTzGYZr5Q3VeIsmZUyHeRg1DnyuAnv0f49mJQmmYrn5?=
 =?us-ascii?Q?9GScj/JIm9AwbfxT6DjD/xkSorZCgRiY+6nv+PnkXDfPA/S9fgrtFSCAyqgd?=
 =?us-ascii?Q?Yt8p9houe45P3SIf2T3J/ZksvZg1C8YV2rGkEA/Et5KJjVOBtVO4l7sbpfXc?=
 =?us-ascii?Q?Y8lqpU77TBqHP4BWHf5MkU9ujZ8qAsAGItYzLrSIu57LSpsC6kKEXb6eKL8i?=
 =?us-ascii?Q?j0ajt1d/HMJAf9IuCObSxZBQRQj9I9fJDcHDWePz5GfxFinC1x56N799j5Ce?=
 =?us-ascii?Q?O7F/oFTI12DV9vfGywmbDN6mpg0p4oGw7jwg82FjSTfd3fw2WhYkcRUOvCk/?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af3ed16-8e22-48e1-aab8-08dcff255122
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:11:32.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vugKrLvrDOTz/PI/+XHJLdSlRW9nDNDLTzHe95LbWGBqOF6fi4wGgu2i17LsVu+ibXjslkeRlryEI9PrDi+e6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8175
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 12:11:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17216

On 07.11.24 12:30, Quirin Gylstorff wrote:
>=20
>=20
> On 11/7/24 11:57, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Under the assumption that future versions of Debian will deliver us the
>> needed versions of SWUpdate, this eases to opt-in for self-building.
>>
> Do we need some additional logic for SWU_SIGNED =3D 0? As swupdate from
> trixie requires signed updates?

You mean we must enforce SWU_SIGNED =3D 1 from trixie onward?

Jan

>=20
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 recipes-core/images/swupdate.inc | 10 +++++++---
>> =C2=A0 1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/
>> swupdate.inc
>> index 96994b5c..b1cad439 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -17,9 +17,13 @@ SWU_HW_COMPAT ?=3D "cip-core-1.0"
>> =C2=A0 IMAGER_BUILD_DEPS:swu +=3D "${@'swupdate-signer' if
>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> =C2=A0 IMAGER_INSTALL:swu +=3D "${@'swupdate-signer' if
>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> =C2=A0 IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> -IMAGE_INSTALL +=3D " swupdate"
>> =C2=A0 -IMAGE_INSTALL:remove:sid =3D "swupdate"
>> -IMAGE_PREINSTALL:append:sid =3D " swupdate"
>> +SWUPDATE_SELFBUILT ?=3D "0"
>> +SWUPDATE_SELFBUILT:buster =3D "1"
>> +SWUPDATE_SELFBUILT:bullseye =3D "1"
>> +SWUPDATE_SELFBUILT:bookworm =3D "1"
>> +
>> +IMAGE_INSTALL:append =3D "${@' swupdate' if
>> bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
>> +IMAGE_PREINSTALL:append =3D "${@'' if
>> bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
>> =C2=A0 =C2=A0 IMAGE_INSTALL +=3D " swupdate-handler-roundrobin"
>=20

--=20
Siemens AG, Technology
Linux Expert Center

