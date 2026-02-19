Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE8AE9A048
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 14:13:45 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14694.1771510422349312947
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Feb 2026 06:13:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HaDld+N+;
 spf=pass (domain: siemens.com, ip: 52.101.72.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHNWLkTJywYBWp5ZCF4bOHDP8jh5+l6BDhi80yIqzitnktzrltkRSAqG6S6dtrO/4i3D2a0CyerFGHu1Ltl3TxqsLpvYHJI035kPZW7umtnffz1XqdzpFQlKGXIWyyG6eLvpIlCTs6X6+ygty2IYS7HRaXGaIAogTBb8kA4hK/wMzbLX2mu0fixukgUr90ddeFuSbigo1uh6h9DOxiT+AMaoJH3dytMtk0NKKduqawm4NYjib7zt2ydchmEGpsE/Yy8vvSvwxpRE+x36k7x2fUWgC/nWqavE5//ZyuyLlcZeqvEvQhGsDHg/IDOWDFERP88KZUpyTeuyMPMTazJdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I1eMERPMviSFOvPKhqETNJtH0mP73VlUUUHi7AzsfY=;
 b=Zla0AU7I9kq8RR8Yiu83+ew+T8/w8vCvNcVf4W9/YJRuuIRI0NiL+9mnEjNzb4jKWuQKA6iTzpdC5IyEMs7KldbnBddmHVjwUZ7LknO1mv8IQVGIopYo70odGG894Z74SIUMr/DEIdIlWr2EM0hwMRXxYG+phAND/oh793AVkHU0HwxCjx59HkWRZqmelIKONpl6G2WiOqpyHnmX87CRAp07tIfZRV3gahKND5rfmi415auNpsHuQpUK2hVrB9OTJWTHXEqSFLkW4XajobOhZ+fvJjvTpHTtWsXg9kF6pKxWaQcyh0Bq28AnMbbDnT2IamInaaH7BZpDwsjBTa5GDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I1eMERPMviSFOvPKhqETNJtH0mP73VlUUUHi7AzsfY=;
 b=HaDld+N+K7vB9XBiYbR2KTP6SInaZZNlV7e7YDdQvXRPok6Lli3jQwk+JRCEZxZJ7KqTSJhS3pLyJ+5WPdKAsCFvNvPiLpTFM4dsJVz2YacRZc+0b6+fhMQCgeUdK3kGE9aZqzKQtIFrY6k+1VOEyG+noc6cD7yIfPYhFUMq4HRdBgHzOl/+h43l013ZX6tHEzECRa340zavBVT+g89Jmeb0x17L4AF6lAtAseuphnmEyTXlylaxQq69ssqCLBOStcbTRIEJY0ReJlHNnpc0fIJ61+O37t/PYImbFrbqNGTESf69vb/TiUZHKO2CeHYTIftLKEW4uxleBDoWfB7bTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 14:13:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 14:13:38 +0000
Message-ID: <a4984743-adbc-4df0-888b-acb9d7d86655@siemens.com>
Date: Thu, 19 Feb 2026 15:13:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] fix: Disable bootloader
 interaction in case of ebg only updates
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org,
 "Storm, Christian (FT RPD CED)" <christian.storm@siemens.com>
References: <20260219123726.922484-1-Quirin.Gylstorff@siemens.com>
 <3bd31e51-cdb7-41b7-9c7a-c65146d28cb2@siemens.com>
 <4b5233f9-bc65-4cff-840b-226e45a98dcc@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4b5233f9-bc65-4cff-840b-226e45a98dcc@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 50af0d6c-f094-4c3a-7f50-08de6fc1136b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RMawF19SIC873kwmnvy2thJ5DjdpQAt59Y4+zbvonzZElOCmPBHNAXx0FP7j?=
 =?us-ascii?Q?+StSA3d+3bVTdTFFRDAa/wu8WoHGFJfzQ0tz1DmUJRHwm/HpK5OPYOp7UAwy?=
 =?us-ascii?Q?N5lqiplOPkoINcO9j6l8Wcx3afmLjQag1uWOxSNY+3Mwptf60KoihrlAFIap?=
 =?us-ascii?Q?c7cYGFcWyswT7N7R9HiVQqtHi/V1WZVFv7/Af9cDBmF0RyxVoE8lvDQDXb+n?=
 =?us-ascii?Q?JcTvAPcCSbeVz4nsLK9moRYITzDrXmyxSltzVezrU9ETCe59mWP61+mWFkip?=
 =?us-ascii?Q?iCVSIyrI5HIRt6J7uFNrkDCq3saBA1tjzhcftg/5dMc6aQ0+fUHVGwGXTxvf?=
 =?us-ascii?Q?rCTKo2c6wdRowO66d2M9H6t/9rYLhmOiKRtuogcaPpcI8sqwLZ417NPeUa8R?=
 =?us-ascii?Q?eHtBGAMynXVROmIRG9Xc37AXvveF3/Oxlp1PtNp6n098Pev4ntuMPXBnt4rS?=
 =?us-ascii?Q?9WUrO6r5MK6gRAymn5O7Vi2FNP70bf/dl+adG/9kRD0R6hePXTZlgLT4kRZv?=
 =?us-ascii?Q?SOE9S2pgmxfudgwfcc9AMx8YjECWV0P8VmGJeJR6D115YZ3G5bJghhD5DIxt?=
 =?us-ascii?Q?c9S3JXMyZeYnk2WScwPhNQ6xuwfhRRwlUfp1GW9YraBXhvm4MGX2sEX8GvLq?=
 =?us-ascii?Q?vT7/oNSI6tbo0/Dyzpk4dacm5RR/GNmMM/QVYR/xLuOr3FYoeg+81EX4UFs3?=
 =?us-ascii?Q?xV95qeWCiKeYxPYWhVTiDuqUx0PNnN95jQG7Ja166uNtN5u1T/SjNYMi5MQx?=
 =?us-ascii?Q?jl4Em4nNVWc5yzfcZRkmb06i628coCOerP+a5kiEePdnTwXt708TqhL9mYwY?=
 =?us-ascii?Q?/M7VNoXMmA30YxRY5rZVJ7qIdhcWlxAlbTUNyowDWfp6EUTV9mafApmqI3pX?=
 =?us-ascii?Q?I7FHWUbSeIeHNrX32QBc1AWNC6V4SsIoGeTWIMdS0Pq/9U5xoC8uHtwMQns+?=
 =?us-ascii?Q?ue5s9K89a9LATLBweJuQ/uGKvlZ1t+8co2wMwXv1vHybb5RPnLQQ7Ibrz4Cg?=
 =?us-ascii?Q?DuPlPgOnhzshXXZFGvjAU+QJBtnt7hfGfCQdWnkGO/PT2D4usFYGZCgN1L3l?=
 =?us-ascii?Q?z9gna61dFiVvxn4pms/73AliojW2qB3SdumsF1/ibjX1sUMsKUsd7n9uTc7l?=
 =?us-ascii?Q?WVeVtL7gg3c1AaeaUfm3AD8ZCNpUPG1bcBIpOUEbW8H9LRuFNHQ5o5Ec6pQp?=
 =?us-ascii?Q?6hJ/5eChGjOEoqJyj3YGnmCqPh12GvCzNNbyZp9hF6akVdXmYAnwIIu8QyJO?=
 =?us-ascii?Q?ZWu9XsajXDWoM1MzRrUjBv20A8scqPSCSoPMwshwn6wO+FB3dZvY6Hd+1KRC?=
 =?us-ascii?Q?3au3QSONtgFsGnM+udeble8dFd9gM5Em8c6bZkjlwUdqDxSIogmLoAzYpdd6?=
 =?us-ascii?Q?JT+mCF2klEjGkuAhpqeSVaLxhG9gwFaZgnsEIYROY4FpWspZozGjsI+0MrFm?=
 =?us-ascii?Q?IE7W8A4KLTIY4cjwdI9orGJhcDtejoKLPx+GiyXQ3v76JE2/ax6MMwhqGsAE?=
 =?us-ascii?Q?ZofNPYCDxBB6Telc/muq3fqzv5nUhmmVt5Ld?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KoBLBy40hLe/n+jhf+F7FDHBrUWJxIrUXcENkPfz4+LqQb/GRlLHSIfFjUaF?=
 =?us-ascii?Q?vUaNv4JchOs58s4JtTUHTIZ0I121ZNPhXzy4YxDWKu0L/SiCmK1xwBq9SUZE?=
 =?us-ascii?Q?IMiY4na7l5mnMP+qVmLmwNHEk7kbqA3WSDVsD9Ty5VupSV9XHBMTVHxJKe+S?=
 =?us-ascii?Q?0QVT2R6YvIp4zKgAsfd+7jhzCOH0oQL9F3PIk2JSYgFtuutqv8vAPEPN4kvs?=
 =?us-ascii?Q?11+Mk8HyaEgtxs6Z7lW0xiq4+uj28RHVnYs1rM+RLR9bD4A3lwAwKWoFZCQu?=
 =?us-ascii?Q?U8R3sX7v1jfqvT/jHL5dTtvapxpZbPM0lt6QytMOCZbrbuCNmxZvWY/43N0T?=
 =?us-ascii?Q?qjHQFoU57CuWZo3m9UbbnazYMCV7ko5RNwv0wlV5P1YaHVNbHIk95Zq55mMc?=
 =?us-ascii?Q?iJ74FKaGw0Dp8P2sfcoH/WTzF+8nuDtSLVSNzd3IEeVWbNb29qSPrCeh6M08?=
 =?us-ascii?Q?VepGbIoC//r4rS3r6e75s3nPXS4T7Zv2c3cu0MsB+/ns+755G3Gn0q85ODGj?=
 =?us-ascii?Q?2mmJ+3cjDKqEPOB4PCCgqnvwmDscXM8tzR6RbXZuexK/tMsEeukgK1MARITr?=
 =?us-ascii?Q?KEIgznB0KMSjPWsEDZUBwIn2yhP08Ej4HqOe3a0M3KMhQHeOKMeZdVj9yLzY?=
 =?us-ascii?Q?1H6sOGpfrOtIbiNMDqndPdFuJX6yMguUzNG23VbhRSb/a1qS73pGMVatTBkg?=
 =?us-ascii?Q?BnkS3mVgBV1lrWsN9P8QcJO2T2yNMwt+gSd/6D+u15KXGmz4mHoHR8g7YCXk?=
 =?us-ascii?Q?+Gk+iV5rNU+pIjHFzS7sqYYF7tNwBVy6lK76CB/LV27pfvijIVWqq6AGPsqB?=
 =?us-ascii?Q?+Vs1VDI6QhUbr+8vjxfT14KiXembT06E10/9PN5r9nGyBrt5SLJ/p/7Fjyz1?=
 =?us-ascii?Q?TUOnu4LeAJDvAGcGA/YfOe63gIRyyTFSLeT1nfmdzj7DKm4+nOEwVNy2YxZW?=
 =?us-ascii?Q?FcYG+2ZyqtdjdLkDE3kGshleOLtbzSCw3drOpxMEJa2I5CFJ9YWBeWwn/ONd?=
 =?us-ascii?Q?ZFhRZBc97VY7DO9PjMxACbEecVvD8syNGZu1x9PhuSnlec7k73XbROYvGS1U?=
 =?us-ascii?Q?PUgsDphDRxNgxL5x8JXYjag8kY8IfoRQe4+NiyOhr1WQCBmNYXNlkMROGR4a?=
 =?us-ascii?Q?0PyywTdPnKuF6/3akotfJYffSemc1NJky8J/isUOgy+lL/GH9FukkSKtdH66?=
 =?us-ascii?Q?u2EjYgCnoGxG0quz15ZfwuVDDmvQvALc6ryZSoKzh3PsEXnzv7vZtJn0kYm5?=
 =?us-ascii?Q?m+4hmYBp5hsLTYN9x/+/TMV/Av8pRZ7zDLmlNHoMUm+KdHtu4phxVVRa1mub?=
 =?us-ascii?Q?Egf/6q3RWT8c1KFlLEDX9k6rmS/llLyhSBrJIdQE/peAfADE/2wS7GXgZT7W?=
 =?us-ascii?Q?4BeWI+B19ZG83pCgf86nRJxeJGLqe8Dq0vvBQq6NxeyucxZE82zSUqSucEd8?=
 =?us-ascii?Q?g+LZVzB1Wtdb1sRh4SeuVu2oZ1XZQc8MQ35DM7gsXmdNaRmsGdeT4om2nzrH?=
 =?us-ascii?Q?DxqlT2qaKyFDCHzUTQeKJIGvzbCmP47lwWpa0cL+oKNb8zFVJu84kLVVR8Cu?=
 =?us-ascii?Q?VwLipmtZeJWkQuLy0PigkiXk/XxJ6kFAnQd2bUR+LZ1diIPXGY5OPZFO5VF6?=
 =?us-ascii?Q?YMWK28GsokQgDTjqRvUeMZlzaX+BB8bRN/2/+Qkx5eV1ccSnSMEbWjVDMiWv?=
 =?us-ascii?Q?DGMceOl8CS6/Og80tgOZRCFK474c66/xWTAYwcSz7g6h5z7rPYujovFk0ooZ?=
 =?us-ascii?Q?FSAo5RLGMw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50af0d6c-f094-4c3a-7f50-08de6fc1136b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:13:37.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGEIkcxSJJ4yVYp2pzxFOv1CkFWBcDoWJh+KSgR2/g3m9DuUoOzbQhs2oXE0Ztz2vvQAeMbjEnHD3mezFtMkCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7776
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Feb 2026 14:13:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21900

On 19.02.26 14:20, Quirin Gylstorff wrote:
>=20
>=20
> On 2/19/26 1:50 PM, Jan Kiszka wrote:
>> On 19.02.26 13:36, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> During an update of the efibootguard binary the boot entries should
>>> not be changed. Therefore disable the boot-loader state and transition
>>> update.
>>>
>>> This was found during testing for issue #149.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 recipes-core/images/swu/sw-description-ebg.tmpl | 2 ++
>>> =C2=A0 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/recipes-core/images/swu/sw-description-ebg.tmpl b/
>>> recipes-core/images/swu/sw-description-ebg.tmpl
>>> index c19157c..a63e38a 100644
>>> --- a/recipes-core/images/swu/sw-description-ebg.tmpl
>>> +++ b/recipes-core/images/swu/sw-description-ebg.tmpl
>>> @@ -12,6 +12,8 @@ software =3D
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 version =3D "${SWU_VERSION}";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D "${SWU_NAME}";
>>> +=C2=A0=C2=A0=C2=A0 bootloader_transaction_marker =3D false;
>>> +=C2=A0=C2=A0=C2=A0 bootloader_state_marker =3D false;
>>
>> So we need to set both to false to avoid the SWUpdate talks to EBG, and
>> one does not influence the other (although there is only one state in
>> EBG)?
>=20
> According to https://sbabic.github.io/swupdate/suricatta.html#update-
> activation yes.
>=20

All that reads like someone only had U-Boot with its environment-based
update control in mind - not properly abstracted in SWUpdate.

Anyway, in case someone ever uses the above outside of our comfort zone,
let's follow this pattern.

Thanks, applied.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

