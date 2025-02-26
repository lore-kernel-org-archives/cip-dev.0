Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6DAC19776
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 09:48:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.2360.1740563333710464767
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 01:48:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 51Q9morp902776; Wed, 26 Feb 2025 18:48:51 +0900
X-Iguazu-Qid: 2rWh5b6vF4DwrHaNDm
X-Iguazu-QSIG: v=2; s=0; t=1740563330; q=2rWh5b6vF4DwrHaNDm; m=BZdMnh1ut5wJ4nTsOSAlBSJCbl9WKisCsJdIb0OUZA8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 51Q9mmP33022877
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 18:48:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouVSRuHzC7SX+Zblc0AMUwn4nxf4iJFzrxF7v+LIpg+lq9pYirJF9/mnwZg2u2jAg1OZLS9kET+I3QHue9cQFEW2mBf2zmhOKXKvol7r1oCQmY83TNZWbYPp0tj4MgCvi8P0gGT0n7xqzCLPcb/8tLWyojdx9ztob6JiBYLk2ukUFHn5GMtKYrbiOqnUQBEz/bpo6eQsi8AKbxOaWBEZCrfmGpRJmtzXnYWg2Bpsh+mZiiFKdvlgeYZVqEfzzWyUrl9u+tWQ92nRBkjlIS5EX4Ql3SIFTUF3eosOUE4IKeFB4zBwkLwrGm1oQk4MaJ01Jg7bP7NjgcX3kWyBP7my4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKSCwDTMK0dO6CiZJkfNsdYdqhu+PaUYUGil4U/YKPk=;
 b=QoW3HbYPufZYQaP830ZUumFZSzGVQkYjra63fAwDhg2Q0SxSeTPA91Wors/eWAN/hDyOv84phDYX/X+mcf1+LYH8hDQN/UcVq9eh/HrcfgFGJevrsk7RPNhdEYl/lfGJ3kXSZeJPbPqSlUFpPes1KaLrWpC+iPN50zH53cFOw3X2296Lv+BY8SSYv+UhXLcCYRyxJ2Q2Q1v44wHp0mjWZx2kw9+Mve0A+3QHJZ8DB9USxtQW76cNN9ikkww4WkQuu68LX4F0Sb8gLNTx0Svkr4waQ6YCEEGhpZ0M0KLiyqqOid7R3+AOu7wOUJiSr0mlT6kI/OZ3IohEpxJQwZmKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <michael.adler@siemens.com>
CC: <christian.storm@siemens.com>, <dinesh.kumar@toshiba-tsip.com>,
        <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <jan.kiszka@siemens.com>, <koshiro1.onuki@toshiba.co.jp>
Subject: Re: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Topic: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Index: 
 AdrC1ksCFU48h0ptQR+cT3Q7rfn9dAALvlaAAS1PbFAAEtUdAAERYfYQAAUzvoAm6f/SaQAJBZyAAMLxhqwAAQOJgAAvIecYAANnSYAAkGJ7QACYSs0ABFMNNNsBW3atAAAzYLjB
Date: Wed, 26 Feb 2025 09:48:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669B5BACA105E35620DD593C4C22@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <5A591B53-A5CA-4F84-B055-1C9843037F36@siemens.com>
 <TYCPR01MB9669FD137BC7D188F1D7558EC41A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <0D555EDC-271E-4EAE-A67B-7A02D9CF021B@siemens.com>
 <TYCPR01MB966913481F3B849D736C277BC4E72@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <2DD2AE26-2C5E-4E33-8832-9B402C9F7C4A@siemens.com>
 <TYCPR01MB9669C7FCF2D0CAE6A4492DE3C4E62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <EBB0F642-B8AC-4E50-BEE7-8459AD267118@siemens.com>
 <TYCPR01MB9669A771E067BAC3460FC708C4E32@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <228C2800-9DB8-4708-A0BD-1AA393187323@siemens.com>
 <TYCPR01MB9669234D93FE29A364E394F5C4FA2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <3lsy2jedcdwosdv6kfdykjadid44hnxcef3jqkqyhlgwydiqwk@i2iqb7hd2pfi>
In-Reply-To: <3lsy2jedcdwosdv6kfdykjadid44hnxcef3jqkqyhlgwydiqwk@i2iqb7hd2pfi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYCPR01MB6221:EE_
x-ms-office365-filtering-correlation-id: d9612f62-ce53-4c34-e06e-08dd564ac3db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VWdBOHkwYUZyWEFFZVhEYTRhQmY3YjlyQXVmSURieTVpN05jSkFGbXB3?=
 =?iso-2022-jp?B?K20xMzVORmxFeDQyU3RqMlBJRzdnNXFSNTNnTHhMcHo3TGFrR1kvOHFi?=
 =?iso-2022-jp?B?M2RMLzhRL3ZXcVFLRjZYTW1pVWVoZ2pEbEttdE50bkhoTUFOYUpIWm54?=
 =?iso-2022-jp?B?M3l1d0VHTEJMTWxTOTMyOWp6T1BiUm12Rm13cmFQcnRtNXcwL3QvYUtm?=
 =?iso-2022-jp?B?SEhVQnREaWRSbEdGbFVIQUphMmJYNDJzNUQwUGhVbjFRaU1pSGpwa0No?=
 =?iso-2022-jp?B?ejhMcWZQM0Nkdzh6WG5kN0tpRDZBUEZTK1Y2dlllYUtCZjA1WGJvQU1Y?=
 =?iso-2022-jp?B?UCtzV3c5dWRMcFFEUUhJMmlNZXd4UHNVNEk3clc3VE9QQWw3cCt4eDlH?=
 =?iso-2022-jp?B?VGc5SjkxekhiOXZvMHJSTG50T2VURjdzMWRpRWQ0ejIyL0lob3UyUzVK?=
 =?iso-2022-jp?B?bTBBWldxNGdTSURHKzJWdEZZRnMrQ2xib2xOVnJrS21CRWU1UEhTb3pC?=
 =?iso-2022-jp?B?M2VZR1h3M1E2alZySldCSStJM1NaZmFRTCt4bm8yeVh1VDRMWW00S1Qy?=
 =?iso-2022-jp?B?U3JvWTEyRXVvUlI0SEhMajBwV2RrMjFReE80dFM5a1l1OUVoaWVBNVJC?=
 =?iso-2022-jp?B?b2pMTFl5T0YyU3FOMFBPeUdGeGV3Y2RhTjM4Y1VZY0VlT3BZNGJIQkNr?=
 =?iso-2022-jp?B?ZnU2S0VPMzNCL2tvNzhoRnM0UzhRdCswckZqNW5ld0xMZGpuQVBUVnBv?=
 =?iso-2022-jp?B?enBxTkxybm5Lb0U0R3dpaFJ2MW52VWpzcTIraVYyMXl0YlVaaTZMYlZQ?=
 =?iso-2022-jp?B?Ukx3Vm0vQ1N1TTZhVHNwUHJ3bGpFY0ZKaVVQM1RaNXc2bDQvdnVkb1lO?=
 =?iso-2022-jp?B?cVJIblhRSGZkS2dKV1c3eW1QdE1QMTY1R3BuZWxoaHhHc1VrQzlqVHhK?=
 =?iso-2022-jp?B?S3hjQ3JDUG5wajRXaUg0Rnc4clJsYlc3WXFNLzhJZnBOenA2QWJaL250?=
 =?iso-2022-jp?B?eEVuWTE2UTQrcFJwNHNVd1F0MkJMcXRRR0ppM1RsSVNKMnc1WkFSSEV2?=
 =?iso-2022-jp?B?NUxBSFA0YmFNeFZQR1Z2aDc4UUsrQ0ZrT21XVjNJbmtVbzc0K2wwaEhh?=
 =?iso-2022-jp?B?TjFKTloxMDZnZk1qb0tmR0R4RXdHVC9lc2IzdmI1YjdaWnhEK1VVc1NX?=
 =?iso-2022-jp?B?L21DUDYxOTBYSmF6eVB2M3NpR0c1Q2JPbk4weUxINTRITXRGZWVWQk9z?=
 =?iso-2022-jp?B?K0ViaGxZQXpwYjdKSkNZVndZSU8yamNNd0kwTkt3emtZeVVyM3BSMWg5?=
 =?iso-2022-jp?B?cFhiYWZUeWF6N2JpWmlGZ0hENWhUazVMZFZlZlM0R2JqWjNPYXM1anJo?=
 =?iso-2022-jp?B?czF4N2FuTE1nc3F5UUQ1Z1AzMUYvQTRDdjdZVzlHcU1QZXRNSVBHdGhS?=
 =?iso-2022-jp?B?N0hXSVY2SkJZdlo5dWRWZ05MR08yVWcyVkFHL2FORE14a1E5U1VQdlRK?=
 =?iso-2022-jp?B?b0lpbFdGRk96QkxJZjM3STlpUWdnMEIyTCtWd3VBVkJUZUdFUlFEYTJy?=
 =?iso-2022-jp?B?SmpMbG9Ga2FMZkV3KzVCQXZsQm13S3M0SmJDTTY5a1FIRTJVL2FQYWQy?=
 =?iso-2022-jp?B?bkdqWmJrd0ltdVhYSzFMWGp2RlpaZDZoZTBBUHh1bmZFNllFMDRnR24r?=
 =?iso-2022-jp?B?TmxHYk0xNlZrUFpKSThDU3h1NmJpb0hQVXd5eVRXcUZaTXVOaEo4NFl5?=
 =?iso-2022-jp?B?WFJOOEozNHlPeWlWc2VJckFLdDgzZWdhc3UycEdsV3NjL0FDUHFoMThO?=
 =?iso-2022-jp?B?NnZwNmFNTDFsQnpsYTh5Ykg2TjJLbWxQMWU3U2NkUEdkMzY1K28yUXFK?=
 =?iso-2022-jp?B?MG03ZG4vUWRHVUNxNE95UHlOMXhSd3AyWE1nYnRJVm1xbUtUVW5MRjRP?=
 =?iso-2022-jp?B?KzJUNFJmd2JyeWNDVXpmNkQvRXZYK2JqMEtVdnAzWlhTSXNpRExRYzNV?=
 =?iso-2022-jp?B?V2dCYkhEK1BaSTU3aG43Q0lFYnk1Ky9lRzdKTnRJNzg1eHQ0MzBjNlZZ?=
 =?iso-2022-jp?B?Q3BBNXl4M1VnL0U2L040WHVwcVdxdzJsWnVCMnc2ai9ZQmxZTXVCZ0NR?=
 =?iso-2022-jp?B?ZUw=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UE5Vc3hBM05JT0pJaGlhekd0cnVRaXp5MHdzMWlrRUVQLzV1a1JJMXJT?=
 =?iso-2022-jp?B?WFNLUTNqRmhkZnltRG82MzhIOXlhb0NXbkVKV21yalNyUE52OUxIT0pS?=
 =?iso-2022-jp?B?anJ6ZjNWV0dRck5vdjVjZE56a0paemRnemRKWklLbS9uREZISjJYNGJX?=
 =?iso-2022-jp?B?OHRPVFdTOE9qSmtYelA2K2ZjTDRXaVBSQTRZZjZia3MyT0tvTGh5ako1?=
 =?iso-2022-jp?B?RjJpemMvbUZNZitDQjVLUnNHUFo0RUlZWXdaZFdVR2xxaUpTanRQTU8r?=
 =?iso-2022-jp?B?QmoydHZRK2I0enVTZ05EN2dmc2MxcHZkUkY1RXZjQjNhMHJsbXhkZ2NT?=
 =?iso-2022-jp?B?czlmWHZ4OHdYMG9nN3FxWE1hWU5GSVk2SEs3amM0dXlMaUZ1VHZtNGow?=
 =?iso-2022-jp?B?UmRGejBQN1h6aXJZdHpvTSs0Rjlpb1l1cE1yU2tWaHY3cUNUMmxNYXBq?=
 =?iso-2022-jp?B?ck1rK1ZmeE5ZZmthRFROa2xsMzdKZERzcndnTmNpTUNucG1LR2RiYlg1?=
 =?iso-2022-jp?B?SlNpNEN3TitncEd2WnJKL2dCY0tMV2tEaDZhcTI5NVJlak16NUs3Vlha?=
 =?iso-2022-jp?B?YmNTRzZBTU83Nm5sSG9KOVFGUUU0RjlCclFGZWswVzFWS0NnWW9jc1ZM?=
 =?iso-2022-jp?B?NFM2WmhRbUZISThLV0EvN0FXYUhCeElTS1U5cVBOYk9pSms0TXMwMkdW?=
 =?iso-2022-jp?B?TVVWa3VTRzlpajEwcGxkUDBIK0d6cHhGWS9hMXFvd0lzOC8zcm9NOFZm?=
 =?iso-2022-jp?B?bXppalpnVHBGQXJXeDBiT3JBdksrM2ZXdU1JKzJwclhEaHVlL3RucEZ6?=
 =?iso-2022-jp?B?K2NvQjNhRUNnMVczOWtnaUlKRzFwZVVrb2Z3QURGYXhqWitiL1VLcDRm?=
 =?iso-2022-jp?B?dmNlbXhKZlRlL0RoRVJvVW1BcTdiZGJ0N2cwYVNyOGF1bVBqMXdFMzRG?=
 =?iso-2022-jp?B?Y0d6TU5VbEQzM0k3V0dTM3AxOVA3ZkN3M3VyUXluTlZzSlBQY3pYTzJD?=
 =?iso-2022-jp?B?bXY1VmR2a3BnMDJkek5pOVQwQVFwb05lL09yU2IxeVBFQ283dWp6OHNQ?=
 =?iso-2022-jp?B?NExPekhkMEEwM0FEdEZnb2JkZm1pRFduYldyM0xQSExoTmN6blpVc25o?=
 =?iso-2022-jp?B?V1lWc3h3dDFkYmROYTFLUDd0UHhzcHI3SmVtL1gxTEtQZ1h5c3dxTjlm?=
 =?iso-2022-jp?B?cHZ4b2h6WVRtdWNGZG9QTVRoL3lXekVLY3J1aWQzVkZwTkptNXZ2Zldl?=
 =?iso-2022-jp?B?Yjl5bHlTalRuS1pIbDN2OHNGb1NMem85YW1tRmpWWS9KRmxHQkFiMUp5?=
 =?iso-2022-jp?B?dDduUkRqWmRuaVNxalgvaUwyZ1hxYVB6Z2tQNnB6OE9FaVpqQWFONEdD?=
 =?iso-2022-jp?B?K0tZZkZQNFg5dVBYS3Y2UFpwaDBwcTFTek5pbExlbm42eTYwRGRMRUlT?=
 =?iso-2022-jp?B?VFpWeGZpNUhMTDJYdm0yY3BBclhUYy9NUDdMN0hUSmpuMkFWLzJZSXlv?=
 =?iso-2022-jp?B?S1lsaXFpejZLSncwbnZGdXU4WjlWS0xXQzF1cE4xL2dvbEJrM2pZeFpq?=
 =?iso-2022-jp?B?MU1KSHE2TWxVbEFTcE0wRXZ1YnlseHBoaEZzbHN3M0hVRkJjaHVRVkhy?=
 =?iso-2022-jp?B?MTBtQ3ZwQ0M3L1ZJVVM2SXRXRlgyR0ZYd1A0SUo4MEdHSml1M3AwVjZr?=
 =?iso-2022-jp?B?bGpGL0g0UkcxcXBaTjJPcFExR2ZnYWVhNWxVM0NDT0JyU0NFTVIvVnRW?=
 =?iso-2022-jp?B?Z3pUS25rcGhXKytISFlCTllrN0RRUldWUGV1RG1NbkY0RU9qaXdzTkcz?=
 =?iso-2022-jp?B?KzhPd3lRc01DNnJCMWlpTjM2S1dVYTFxR3NCUm9uWjNMUDJwZVFoT3Bx?=
 =?iso-2022-jp?B?VUQ5T0lDcTZmQlZOMTJ3RXpHY0RVK09WbXI3ajVqbG8xSW4xMTRxRWZS?=
 =?iso-2022-jp?B?azNDZFIzeExlMkYyMEFDcysyWEpPS2Z4N2pRMFYzTFY0emNMdElZbVhW?=
 =?iso-2022-jp?B?dW9BMkhNa2h0d212NEtrb1lFZkdqTy9qRVFEMGtxYkU1VkphVzVoa3NW?=
 =?iso-2022-jp?B?VGpWMFh0Wkg2Ry93K0FpNnNPR01GTVZYRXpZWHNrVCt2cUpVWk1zTnUr?=
 =?iso-2022-jp?B?Y0w4WjUxRnZySTUzQ1dBM01kWlQxRHR1RzFpbFNVaDVmWTRzb2J4a1ZF?=
 =?iso-2022-jp?B?OVg4VGJIVjRzdE1wUE1VckM5VjNqMDE2cmxQQlpTTEJKakt5bnVUZG1l?=
 =?iso-2022-jp?B?L09QMTJIeWRpK3V0MjZwaHo5K1p0NnZHWnZNODFaTldnWkNUQzBWTDYx?=
 =?iso-2022-jp?B?bmVoR3RhckVCK0ZhaGV3cGhaVzBydHJpUUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9612f62-ce53-4c34-e06e-08dd564ac3db
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 09:48:46.9376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feafnyj8V25DCfSxl8Ea5TKX/fOk8i2MoMFSoOdmwH/EzuVOGkfCmkaHbNwr9pbd0g1eMvHb4czVKHG/0OxOvHxH9GzS0tjCoBNXbYr04NU/HYzDjGJgP+dbJWtkvfHL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6221
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 09:48:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17917

Hi Michael,=0A=
=0A=
>I hope you don't mind me sharing some feedback as well :)=0A=
=0A=
Thank you so much for the feedback. Apologies, I should have probably added=
 you to the mail thread for all the initial conversations as well.=0A=
=0A=
>By convention, custom HTTP headers should start with "X-". However, consid=
er removing these headers, as proxies might strip them. This would require =
a slightly different approach >for generating the clientID.=0A=
=0A=
Thank you for pointing this out. Apologies, I wasn't aware of this.=0A=
=0A=
>The onboarding client seems more complex than necessary. It looks like you=
 reached a similar conclusion when you started using external processes (li=
ke sed) for tasks that should be >handled in Go. A simple Bash script invok=
ing wfxctl might be more appropriate and result in fewer lines of code.=0A=
=0A=
Yes, towards the later stages I felt the onboarding-client was more complex=
 for the given simple use-case i.e =0A=
- get a client-Id to be used in swupdate suricatta for wfx=0A=
- put the client-Id in the swupdate.cfg file=0A=
- restart swupdate=0A=
=0A=
=0A=
>Upon reviewing your architectural diagram, I wonder if using a plugin is t=
he best approach. The diagram is slightly misleading, as the plugin sits be=
hind wfx. Requests from the client ?>always reach wfx first before reaching=
 the plugin. =0A=
=0A=
Apologies for the misrepresentation in the diagram. I will fix that.=0A=
=0A=
=0A=
>It seems you actually envisioned an additional (micro)service that communi=
cates with wfx to create the onboarding job. Ultimately, it comes down to w=
hether you want one service =0A=
>(wfx) or two services.=0A=
=0A=
The idea of having a service for onboarding did come up in an earlier conve=
rsation here. The plugin idea felt simpler given the use case.=0A=
=0A=
=0A=
>If you can significantly benefit from code reuse on the client side, such =
as leveraging the existing SWUpdate wfx binding without having to write any=
 new code, then opting for the >plugin approach is fine.=0A=
=0A=
Yes, this is the idea (currently atleast). I wanted to use the existing SWU=
pdate wfx binding as it is and show a simple integration with a wfx backend=
 for isar-cip-core images. All that I needed was to obtain a unique client-=
Id for wfx at run-time (to avoid rebuilding images with different client-Id=
).=0A=
=0A=
=0A=
Thanks and Regards,=0A=
Adithya Balakumar=0A=
=0A=


