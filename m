Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3670DC282EC
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 11:20:22 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.77])
 by mx.groups.io with SMTP id smtpd.web10.10689.1741260014269825850
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 03:20:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=yeFMGMIM;
 spf=pass (domain: siemens.com, ip: 40.107.247.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bShojtpdhOQQdW7CwgNRI7gd3o3Rr9+7oAGuADy6kVpBqz4Cgh2ylWVzDXTm0Z0L1EkMlWAx9FNuIasPOpjtVtC/w8U3texvjYYoMf8uumvjG4l/l/H75d4i8aYSaftL+UZRLZkCOK4xQzLt/ZCUpgoRPXko3uY0bvk9LCGjrFZn9FBraHr94heQdi1mBZQJ8eGNIjLSnXo86wuPPNemvXIxITTLH5mgJA/MMicREHhY6OpPK/y6KTY7UqfwgMT3t33Cy7wFWqWDVoNwQ8t4WV4EnKf59ZXiq4zlGun9vlILtlaTeto9w2Krm9QVEHk/2G+4AVG8io0Y2eoyOqN4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxj8W7fbRxMWS571cbu4UMomZQQFdA0OwuV/Tk7BYBw=;
 b=uogF9uf7CBX47MdmEsRdSVDyFZlpVBnn31z0dO0YAy02urcxBz4bRkhF87t4vxomn7OTu8bccUQG/3GI2pz356IHrKHCpDIX4iCsEw8+YvtjGCIizgk8jTsuzha9rrVI3CsohQSA3sGibBfNBWZ/hV8jIrkwJnfE5nw2qOukNpbnuXfhMXJSoMnW3F0VBp3vpgmTXEKA01uJuImicBOB9ncHuCpKLn2pFtYd2bkL/ifkzErOUnzWtNmZNjgQwNH1+1G1pRdb6KBOf98A2e+Uu8mOLpOBmCR0xxBNH1Kmb0SiFIBD/HPkHndyJmiTKnbbR1BM1gdv7kgZdcn6bTCxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxj8W7fbRxMWS571cbu4UMomZQQFdA0OwuV/Tk7BYBw=;
 b=yeFMGMIMpXPKROToHE+axY/YDlBaJ1lZtD5gBm+2GyUolKECjVtF6Gz94aiMCRcpadOZs5OBEpe41ijTla0A/lNni4tCfFrbtXQBi3sHGyPK1fi2aktm9qx2tjNBA6t6FDzYgu3yp5suRk/HtmGihsdWtnC500BzGkjgL7TBcmtFGPqFzr8h0x+aLnpknsVW7ucVUU3YWIJ4OA+PwRIX6EPfv7+XCgL8KixMGvv1nYV9a78Cq5wUWCQ2+d3eFoVdUKs/mLkUSDXPHmPjOkQ7iaLqAtlxwHCdxOx5IUD6ZOpNB5zWM1+kiexhZtiEVrfg9Ir6RD/gg38ns8uELQgBVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8449.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:425::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 11:20:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 11:20:11 +0000
Message-ID: <cf030a84-ccb9-4cba-b5c6-d117ebc66620@siemens.com>
Date: Thu, 6 Mar 2025 12:20:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH v4 2/5] initramfs-crypt-hook: use static
 temporary encryption key
To: Claudius Heine <ch@denx.de>,
 "Heinisch, Alexander" <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
References: <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
 <20250305-initramfs-crypt-hook-patches-2-v4-2-4170912e5261@denx.de>
 <AM7PR10MB3320E9FCB6FBE8D3FA69DA0686CA2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <602ce0bb-ada2-4eb4-87e8-e917a2388c65@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <602ce0bb-ada2-4eb4-87e8-e917a2388c65@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edfdb90-59a2-47c4-d05d-08dd5ca0dc0a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YECnijSpiPHBY05IlCiQprT2zftmuvIMUd18wWDakC+gw2kk+J+9wRDtPQUV?=
 =?us-ascii?Q?dlLzR5TPxjpNR6DCFR05fXD1YOx82xp/nKgGmrNmzvrDJwxSeoE7nM+gcJZB?=
 =?us-ascii?Q?BQ5+pDlPzCHFe2sBViTIufsHFy4/YOXJDZz6LMOlUepuH/glk98WKAImvcwy?=
 =?us-ascii?Q?/Wo8P0SpCattisrzhz5cQKxlDuF6qGzMRZu/GkapFRxSKoaQyaiEN6vvjsR6?=
 =?us-ascii?Q?oY/PR6nrXtZ5Ucah1NjriwK0BYfv1uDWHsSDAGPkPojTU7L8L5lNJDjkOmPy?=
 =?us-ascii?Q?8x32lsyoZGZcMCgW5ggpj4kenFG93sib/H+hAgr5IYTFZhSXBSr6vnX0PmoZ?=
 =?us-ascii?Q?xhQEEhL2lrwL59mQpP32aCHLB9Sp6oV5GyMJxt1GB8myh2UTTbKcXFfm86zw?=
 =?us-ascii?Q?jpSHB/wgkzmH0qg60l4l834ncS+ZmVosy3qk+93fuz+0k/aCElSOBLPJHFJL?=
 =?us-ascii?Q?YR1PGwNvVSSMMWRiqSR06X6tKUf7PwHrMq9T+4+NtaPC6iuuREUgFoBN5sKk?=
 =?us-ascii?Q?4F2i5P3jz2cSjJyUd7bjsrnAvCvP1aCoVr3/Zd7UOck1e7wFAuN82LpaKg2P?=
 =?us-ascii?Q?bpKUH4YMCRM3LRzZjF9ngNp56p0TGvvU8nSm3a3QQHsH30YVmaBzFdXHh9Cb?=
 =?us-ascii?Q?Bor1KDULONOT75cPr9uK8lpw3pfX2Hxud6dRKQP5WXOaKLADib4ys3aOO73P?=
 =?us-ascii?Q?x7Eb4IZWmipAXoW02ya/AC27lyHm89qpcU3vtFLjGQsLIDXUOonIgHYf0aPf?=
 =?us-ascii?Q?5/kUawZmnNmG/0d0X+7bDYEavjvYLUrCuvnzg0ulJvJxN9f7IHElBm0oPxeZ?=
 =?us-ascii?Q?KT7ZFS5R6xOIDLBjxCvc6drkjFGkfxRkFrD3uxMsPrxH+4bgZtvM4c6081+d?=
 =?us-ascii?Q?0igk+AP7eQhNe84ilqII4zbipnI3oiNtyWdZGnvfdf8pWLcesWAUOElkjvMd?=
 =?us-ascii?Q?ejdrY0Hl4DGG/d7ocMmP4Bi8wxmMyMQ1qsETgsfd5QrUbq1uVOTujKKjLxUC?=
 =?us-ascii?Q?nBNdcPNchpvR0RYbwQwpejm8pDpPLk5RMwawcFtfV73jI1MlEU303lGHr9EH?=
 =?us-ascii?Q?arVL2w3ALgn+8UP1YlgBlqcUYYfga4YAsuZsWUZ0Slsg9dg/3BhOnONafi/K?=
 =?us-ascii?Q?XCaCrXvsS+KaQ0HW/UsuBKtkmKrdgOdukJ0HAaOmIdDt671G/CoKgM3K0GiH?=
 =?us-ascii?Q?/xuR+o4rtemmUAl8pzcyG1p+KBGKFeYWO4n9VV5iqWlUwC+uV1NEmRiP7QwS?=
 =?us-ascii?Q?xgHNyZsK8R7ilVO5mrQW5iiR6lZmIXddYqOQtSIfnJ4Y9w4VKs85CGROx1jA?=
 =?us-ascii?Q?Yr5Y/hSq1AqEZZLG9yDvqrR145jbEBQTd1fTLffw8nOXH66k9LCvFQw7LeWl?=
 =?us-ascii?Q?2JjtI9jwXBQGcGQs1hkhh9VjWEOQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oFJWYzirVG/kSK6bSf/yUNRPVMdetzJw7jWA+4N1ktk5o2fr3SQl9hrRjfAW?=
 =?us-ascii?Q?Gfj2dhz3mymQC1s1XXoTcOh7i24gz8pQfEWiLMFJAp0x3IPxwfopzHulnsFx?=
 =?us-ascii?Q?LqYc84QclavdejqbCnRWHgoYsra+qIk6nbxGu3Onrk+qXETrF5iFZIe9VKGx?=
 =?us-ascii?Q?npN1F1pNpOCzDlca/CbFExxaRV75tc0B55Wy2IQQFOyJqdf00BX2jfns1Z0Q?=
 =?us-ascii?Q?32MNbaszMqJAqVvGVtOjBf7fTxTxczBBtY8bSDL1Y8ti72uHGd90XwMJxG4R?=
 =?us-ascii?Q?OHNQ0PnpciwPoO1/CniXEQu0ZV8kE5cciHcVRsENHnQMzyiTM9tnrmi5k/d0?=
 =?us-ascii?Q?uatPwJG/aOeQqPFJXkmdkMUBG+sDsk91Dx4y1Y32At95RyE1fFFwYB3202Y/?=
 =?us-ascii?Q?GZz6vQ1L3dGGTWzPobbcshe68i6aKOJA/XuxxsAgSrPf4ikLwYJRdZeGGHsl?=
 =?us-ascii?Q?Vfrlm9W4pN9tURGl5w9y849y/G4beSF2paAT9tFMa25Q5rGR6a/XJgPfcyNE?=
 =?us-ascii?Q?L2TekKWSsjxx7AnvMsCxU9CLmd5Sml/A1HuJHVelHK4YIwPxJF+yQrsqVJDo?=
 =?us-ascii?Q?H1+zXGR0AyiLPyzyeZ/kPsEV7lB6sSe1xmnJbD5ZZMeo7o4qb8dAaGIxBZvS?=
 =?us-ascii?Q?/Qk/ehONKjrcQ8j8ceC71qFKY62mHkk2wjUTMaKZBtPrZ9PLIWjH961mTS9m?=
 =?us-ascii?Q?Lu6ZKdH7tSq9ft4ITGT9kn3oWj63Zlc0HYeoPsi+LEcTWYvEtuh/K5A/lY4R?=
 =?us-ascii?Q?sxtlVImN0/YQUFAnzDC4W9cvfiWqo52ARmhxuUk49c0GaVjj5EJfLLr7Qfo2?=
 =?us-ascii?Q?romO8qWtUUujKz3ZNlbCdJD+Enmim14IPaeUZzL3mD7wh8/EXpGJ+eIpw//i?=
 =?us-ascii?Q?VTDmwl+SfvNCXsbVKEsqwmY3sbn8u2+PH7sHS/JFwqZezO5mS+Kg5emTAuH9?=
 =?us-ascii?Q?wrFTi9CcMteAXte+T34xY2EVtY5eplNtLzaCSIxISXsx84elqHRdQF29AmHq?=
 =?us-ascii?Q?4v+vPEuITKaXzzdpUKbJ9K3VbvxfNO2ZvbZzryUmawn1wA9Wsd7luik4Cq4F?=
 =?us-ascii?Q?4Fl6snlcWujhQJQv4FEIg93apaAzFqrFp7GcLEBDZCLAq+DlDMmWrPxtnyy9?=
 =?us-ascii?Q?G4+ZtGUb2HaKAamRvP7HQxOJeCyEa5xS4yZM5hwNSj+uHSyHucSSjjaL4jOw?=
 =?us-ascii?Q?D6yW1cV5JXCmiIQRc4FKiNJltPP2ibOp3tYyJvbCONmU6VfJLiG2CEmqKHOK?=
 =?us-ascii?Q?DSkUlmV09zN4sKzDrJ0zN2iDUZLTardCv1ML7epjgvHO82wzZsp9m/rOlHT6?=
 =?us-ascii?Q?Fg/BHm36c+tsfudlQ8k/QtqZy42XI5dfFp7lcuJNQSSw6s+T18Qz2a9sO8JN?=
 =?us-ascii?Q?sakW5V9oqrHh6noPYJldbyHF8Bm3ujzmdl971IPpmgLhQJMePErw5yNSTRUn?=
 =?us-ascii?Q?J13RGu1orCBhrFIDeq5mQOgQbXGfjN0+8I3VB3UxxnmFiBFp63t8K/veJgVX?=
 =?us-ascii?Q?qgOZbEEKxWjw9U0knt5+TATwbJUPkphsP/HLm43BhD/P+M1W2vgGUSufTBiq?=
 =?us-ascii?Q?MeoD+ZPWS4+h5UTTboOPUOtTOeU8R1FM6H+ogXarCEsjYowub4BCabRiYLls?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edfdb90-59a2-47c4-d05d-08dd5ca0dc0a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:20:11.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGYvw9g5Zk78gZp6faJ9uacqCVFdqhuyld71STa1v7jMWxj3Q21vi37OjPOUdWxg6l8jaau6G11l+BX72rCifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8449
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 11:20:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18054

On 06.03.25 11:11, Claudius Heine wrote:
> Hi Alexander,
>=20
> On 2025-03-06 10:35 am, Heinisch, Alexander wrote:
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>> On Behalf Of Claudius Heine via lists.cip-project.org
>>> Sent: Mittwoch, 5. M=C3=A4rz 2025 13:00
>>> To: cip-dev@lists.cip-project.org
>>> Cc: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>; Gylstorff,
>>> Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>; Claudius
>>> Heine <ch@denx.de>
>>> Subject: [cip-dev] [PATCH v4 2/5] initramfs-crypt-hook: use static
>>> temporary encryption key
>>>
>>> Using a temporary random value for the temporary encryption key makes
>>> it impossible to continue encryption if it was aborted at a later date.
>>>
>>> Instead a static key can be used, which will allow the continuation
>>> of the encryption process.
>>
>> During that phase, an attacker could derive the volume key using that
>> static key!
>> e.g. `cryptsetup luksDump --dump-volume-key`
>>

Good catch!

>>>
>>> Security wise the partially encrypted volume, with a static temporary
>>> encryption key can be considered the same as the un-encrypted
>>> partition that was there before the system has booted. So using a
>>> known temporary encryption key should not affect the system security
>>> in that way.
>>
>> For new devices, during device bootstrapping / setup that's probably
>> true,
>> but such assumption is not generalizable!
>> But even if it was, once the device is in the field, probably
>> sensitive data is
>> added during onboarding or gathered during operation.
>>
>> Thus, once the volume key is retrieved (as described above) attackers
>> could
>> potentially unencrypt content after years, getting access to sensitive
>> data which
>> wasn't there initially.
>=20
> That is true, I wasn't considering that.
>=20
> I guess the only real option would be to try to use the TPM2 to generate
> a static key... I will have to research how that works.
>=20

Exactly. The question is why we cannot generate the final key already
before the encryption starts, ie. eliminate any temporary keys.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

