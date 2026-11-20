Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4227.1795174652529244895
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 03:37:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=GfjvnrMx;
 spf=pass (domain: siemens.com, ip: 52.101.65.53, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWjZRosXcpb3nGw7wbFI68zmpqzw01py0Ln9ljDvFg+6W3iHG3V0YZboMXveATkuKBiE8pC40YUisk5eA7Ys6SoXRzobqSPQdR0STQeYQ3KlYPyFlh7aF81iMIqxsVYxLaeAk6N1Q9xr4Y5wzrutQrnvw1E8LLOwaP3BNXBqCo+4BjVxj4qoMBTvaTVrIh3SZzsKIHuLYvqCUcKeVoGAKem6Vr4/JvUlG1/8tyrwfnqXdbZy7ibM9GQrYZeFZJyhLUUo0YWGThptRg8eVQpef3yD21EHHoAR3i69CxhONx964O3fCyZlTfIbXO2TWoNZgtc1TIUwMVxOz4FwGqiOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyNoyy6owl44QaAmeE/B3WYSDCM8VLPmYp434/8me3g=;
 b=XG0nAx9Fbt0FJ4rao+lNw4z9Omr+9zC233/aTYsBCmekQZtoM/tpYe2QjA+Onud9e6mGGKDriPyn7ENUcoRiLQMzkSXFyZNap5Ye7LtGk1cODDLm4fIJDq5JpnPbqlDyNoXGIYEbU1a/bXK71I3gXa9QlIN1ieaIS17qXclhpxygaRD47ZKwBoql3TaFDYqLb7JVz2FFRaodAalFbrXIi4heKn0Mc7lkTAo/PKjwEWaDeP45/7igzeAxveF9nrhVjS8Hvt2DS6AY8IFAWlkAQ7NEA6+TOD3LoSkWaGXL0ltu8lmGZyV0ZKNQEZak9hr5I2i5Oi2tBhirHd8fbJGGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyNoyy6owl44QaAmeE/B3WYSDCM8VLPmYp434/8me3g=;
 b=GfjvnrMxAPN+hFqpo7/D64PcmNE9cvMdz0LAoCS08Rt9FcrSYroXA37uGVjzc5r650Zkjsojnsx+hN1PVmqw7xazc81u5sGTwUdDlPK/8e6AfUvyPS+D1jEK8vHvwuNLZBS17ZYig9fSBYHlyrQuPx/AKHW0AzpMD6vBQysLZ8VmJwneN47JwdMeOy9Vu+jWlDk0Reghv+5+7LCjQArZVXfkY7DehNxd7nUD9SsX34MsrPS6ORvTieX5FFgcPfwIfu0MdBmTRNqw1ZS6xJ+C3pSDyKANLFTa7CecqCNjTQ77QZLO0gVIKUFEyZth1udo5iYXKuOn3wg9mLZ3i3Rd9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAWPR10MB7269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Fri, 20 Nov
 2026 11:37:25 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 11:37:25 +0000
Message-ID: <58d306a3-6002-430f-a9cf-1ebb388b0c83@siemens.com>
Date: Fri, 20 Nov 2026 12:37:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC PATCH 3/8] ci: deploy zstd
 compressed wic images
To: "Moessbauer, Felix (FT RPD CPC OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan (FT RPD CPC)" <jan.kiszka@siemens.com>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
 <20261120082554.375548-4-quirin.gylstorff@siemens.com>
 <6a1f155c52deb5d2e23196e13254be69e9221eea.camel@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <6a1f155c52deb5d2e23196e13254be69e9221eea.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAWPR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 095e972f-b758-4a43-b24d-08df46faa623
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|261009223027099003|55112099003|4143699003|11063799006|56012099006|261102123227099003|261026130827099003|261026135527099003|261026140227099003|261028144727099003|261026121527099003|261022113327099003|261022115727099003|261022075727099003|261021135927099003|261021133027099003|261021123027099003|261022105027099003|261021130227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: hXUN1qjFuuSJavorKO5sPXbMdjtxj4TFfuFJvVPL+svLNpaXC3no83LiJN0kTKSM6ERqpA5unHzHsaibDyC4JzLPXQmtLeZvJQVInchwu9fJVu6osdCEscLG5BYTRkd38mq+uVEMI4xnJ5AcfgKpBbXEyMJ+X5HDlkGJJi7UIxxNPSAqB+E6cBXfmxXd1EtTe7yFcUqDqhMpw0huqh76wInhTMZJ67ENZMsgjcsAi5dPJnmh4ps7ORFfn2YfjTMBrqgHN9bqhgUgcWrV7dg2+kLz/rvFr5IXwuT7v1kH0ozsAaLpupo5j72qc/3D6NJVG5xSxznNjA7ip5BwAI/ohDMwIPDcy0liNIWdEsY1zdWlSeKVgUQwYTnKc49cpm97PwvfmiLIJHz0f44t4ZqLOElehaQP0AK9iZA+IUEbgOjFj1ZXQPMblG+KUzdU7/VoGFmgcWAIJFLmuRzOjpL06aJkfL/yaCtvzKHL0J9iXlDn9s7MBt+BbXQgGR947ictEYs3pHbzOYwAyXrXkaAEu9d9qJKdxj79VTosZssHCA9J7hCW4ZXisb84F+cTFfnYcajjxE+qqeVdTDIbzY/vYrNrZg5qLEqzXJsCOSFz2T5CwhY8NLS6a3MgY2mPcVKRuNAX7tMymvnuAzekk9RjPquM4u8Qnp4V+SQONT7tnqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(55112099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261026130827099003)(261026135527099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022113327099003)(261022115727099003)(261022075727099003)(261021135927099003)(261021133027099003)(261021123027099003)(261022105027099003)(261021130227099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U7TPANwQcPkIJXuiU0Qsj/yJOZR/5N61dyVGKJOMfh19BvkLIbmzzQdUP8aI?=
 =?us-ascii?Q?WY5zZ8NjDXG5WpPNT9GEZNq46msZKaDqXmWJcVlT0CnXTLsmiIqKQs8Ny1Yj?=
 =?us-ascii?Q?phSj8SZZwGx5n8d6obrPhb7L18jhPBs74LSTkmigM/UA7oLOuLc3XCMqrWFc?=
 =?us-ascii?Q?vd2azawDQF1tabBtKyfA1cU3Y8m9aVADuCYbdde1FwS7/7QAwZudxrTQt2np?=
 =?us-ascii?Q?mO3EI7SgMGzrKmuW/PkvD8elqfhPBcJnox5zxeM0ii3gW9+oubV0lSpLlcbf?=
 =?us-ascii?Q?TBKk/wwZyUOh/pFy2vis/YmBzlKfbgSo13Ze2Mt/z+dvVWAHVS7+U3LdtVw5?=
 =?us-ascii?Q?B8feARye6CWR2muS4p61qaIhr7RvfQG97amuxRG2CJvLhFIV3zinNergds80?=
 =?us-ascii?Q?5AesyNP6BTEyp7z3Wig00/FOg2aCDeyhiP+jq7IIJK0lGTmnpqUUxvYHfqdb?=
 =?us-ascii?Q?dhYBUfFXHL58VoMWrvzaC2UNcm/HunD0d8SW09L2aj1WWIx+mWxoFaQUbslS?=
 =?us-ascii?Q?bYCJz4RBgBCT96xYs0qB39bP3sSUYT/3B5a+Kx4SC5dbACvfsyFiU5t98Jq1?=
 =?us-ascii?Q?3VIW0fjApDC/XZjArN+Xq5u6XycAj/Si/ZBwaIQOhgVmLlguJD160oEhADdR?=
 =?us-ascii?Q?g903ImLz9CLT8vMvCBPIifgqWK5f8z/qrTXiuXNxS2fP/M63HeV5xupjvrnx?=
 =?us-ascii?Q?UnagFJFtcG2ku83uKLeRlTQSHV5//dWYakKyb9+yi+lXX90ri/YB+ikw31fr?=
 =?us-ascii?Q?M1ssvIzRKt+ohChnlG1k816sFokVwD2bXEq9UuzDmNqa9yPs2XiZVxBbW9OR?=
 =?us-ascii?Q?VzEoqcz4Q4JRa9wGQ9dXQKKoiVEzX2IKalyMXuUlGXEaWyRmKOaHsmlFgVRu?=
 =?us-ascii?Q?rRto+Dcdzuqwj/rt4yHhdfFgdYVmFiSoZVQK7NDFc40yM2Kk5oGikpdj1y7/?=
 =?us-ascii?Q?02xuaErphhMhspWDcCgKw1Or+6sdreROuGFiULKAvNF9+TpJl62iyA4/eD6k?=
 =?us-ascii?Q?edmRAkSU7gxIlPIEG6usrv8zFsvH//X9MUvQGnqBfDrEeDXmUzPtebb6ONlk?=
 =?us-ascii?Q?gOOtNGrtyuEx7ZECF0qu2+4kw/VVMTNO9YAxIl6zjztz2dHXpZPDTsdYsKUc?=
 =?us-ascii?Q?JSKIO3vK6eSOIN6tPWbOvmbDA+MIzY2pTOJKQ7yNiDYFCpm2qvsuGJPzZ9AU?=
 =?us-ascii?Q?iNWNLWAYzky30TBevdzxw/umQXnquXklRW9/xgUPb0a7jzSkSv1l7xYoO4ya?=
 =?us-ascii?Q?AnKZ+ibRGYxVmWqrlbpa4x3kQtAl9cZq4nCgN2w4XoNyjsYnEpnABo26qy/z?=
 =?us-ascii?Q?5kR43OmPQtrlMIwyVNfOgzccbYxq5MCL2Csqcq/VytMTBIvtbn8V3FovAWpe?=
 =?us-ascii?Q?I39SuD1w1EvflWVQSag59DMxYSDPdDASybwkeOyoOpN0X5ZB6ICZSd8n1TB7?=
 =?us-ascii?Q?L9kwaDLVq+5zZpcBwmFqszLh2+6xXdJDxiUHLCoGxfSH2/k/gb2DCKlL4CG/?=
 =?us-ascii?Q?LNgm8Bc0iSm0mhBcXVpf1mUDOSsb8D93zXscTwxUDQeDd6HRVW3UaaJUcANb?=
 =?us-ascii?Q?+0ZpiZlXR7IPx+tz4Y4QECeRnhcv9VopOhH3xFNIFOB6eXGoHXMke+HpDjKt?=
 =?us-ascii?Q?AAZpcko2c+iLbA7igaAhkKT44aWDCy1AzWpBOOGhOqsetC7UKub8P03InfVJ?=
 =?us-ascii?Q?nHf9bd9z93tGD2oyyjfhogw2b0ORCHFPSzgcxZ9Vgd9tmlyAhBrR8XWl8P2j?=
 =?us-ascii?Q?r12L5tpXxrCwAq7DgLQBdNyysjm4JXs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095e972f-b758-4a43-b24d-08df46faa623
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:37:25.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcRCaOJ+LThTxfK6CKSp92215CMhPtSbVtkfS15e0Gz9rkPbFtkGCo0dw65hToKjdk2dfOU+bxq5vhyNlLIB7qD3+weSeRMw8cZE26A1i0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7269
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 11:37:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25041



On 11/20/26 11:40 AM, Moessbauer, Felix (FT RPD CPC OES-DE) wrote:
> On Fri, 2026-11-20 at 09:25 +0100, Quirin Gylstorff via cip-dev wrote:
>> The wic images were compressed with xz -9 in deploy-cip-core.sh after
>> the build, and the LAVA jobs decompress the image for every test run.
>>
>> Let Isar produce wic.zst images (IMAGE_FSTYPES) and deploy those
>> instead. The deploy step no longer compresses, and decompression is
>> about 4.5 times faster (qemu-arm: 2.2-2.8 s with xz, 0.5 s with zstd)
>> for almost the same size (qemu-amd64 +0.7 %, qemu-arm +0.5 %,
>> qemu-arm64 +7 %). Switch the wic-partitions archive, the reproducible
>> build check and the LAVA templates to zstd accordingly.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0.reproducible-check-ci.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 =
+++++-----
>>  =C2=A0conf/machine/bbb.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>  =C2=A0conf/machine/beaglev-fire.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
>>  =C2=A0conf/machine/de0-nano-soc.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>  =C2=A0conf/machine/hihope-rzg2m.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>  =C2=A0conf/machine/iwg20m.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 +-
>>  =C2=A0conf/machine/rzt2h-evk.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
2 +-
>>  =C2=A0conf/machine/ti-am62px-sk.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>  =C2=A0conf/machine/x86-uefi.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
>>  =C2=A0kas/opt/ebg-secure-boot-snakeoil.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>  =C2=A0scripts/deploy-cip-core.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 =
++++------
>>  =C2=A0tests/templates/IEC_template.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>>  =C2=A0tests/templates/M-COM-x86.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>  =C2=A0tests/templates/secureboot_negative_test.yml |=C2=A0 4 ++--
>>  =C2=A0tests/templates/secureboot_template.yml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++--
>>  =C2=A0tests/templates/swupdate_negative_test.yml=C2=A0=C2=A0 |=C2=A0 4 =
++--
>>  =C2=A0tests/templates/swupdate_template.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>>  =C2=A017 files changed, 29 insertions(+), 32 deletions(-)
>>
>> diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
>> index 72089685..a156efdc 100644
>> --- a/.reproducible-check-ci.yml
>> +++ b/.reproducible-check-ci.yml
>> @@ -76,12 +76,12 @@
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local base_url=3D"${BA=
SE_S3_URL}/${CI_COMMIT_REF_SLUG}/${target}/rb/build${build_num}";
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir -p "$dir";
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wget "${base_url}/${image_ba=
se}-${release}-${target}.wic.xz";
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xz -d ${image_base}-${releas=
e}-${target}.wic.xz && mv ${image_base}-${release}-${target}.wic "$dir";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wget "${base_url}/${image_ba=
se}-${release}-${target}.wic.zst";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd -d ${image_base}-${rele=
ase}-${target}.wic.zst && mv ${image_base}-${release}-${target}.wic "$dir";
>=20
> Why do we even decompress? The zstd images should be reproducible and
> diffoscope is able to handle .zstd files. Why not simply pass them as-
> is to diffoscope?

No Idea. I only ensured that it works with zstd :-D

Quirin
>=20
> Felix
>=20

