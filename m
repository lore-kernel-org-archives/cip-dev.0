Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4DFC87FD2
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 12:47:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.21382.1754657276390769664
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Aug 2025 05:47:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=SEDOsupj;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1754657248;x=1755866848;bh=1D
	nybdT5u7Gco1InuGe9WDcs3IOGfBnu0A6RdYwT0bA=;b=SEDOsupj3NbLVSgBtecohF/p+kFWn9ya
	+pclWOZ/FkXNkhgwSd4I3B42mZiRu+hq/EetGTVTnVaOo0bf5ayyj80Ur7z7DV23j6DpNYkcfqVsG
	HS92sTx78biLo6XyLVAqEfJGoYzGqqXlFZlYKI6dWort6CPNtdrQPRgwy10iekCAgYDd3FdVgsDwH
	rAVChWze33/mhpikqd69+z+HPQJRakantcsSDAU3pfHEDy8aPX/G4eY8QCOaaADyHhevC9sueCp08
	f/I9/Wjpb2eBXaiw5ikAKzLBSzBTC3ZRe9UeA6PLVBnolVA6ZakzXfh3iTvkyAyp6iBNLRtOT+np+
	YA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 578ClRQd190173; Fri, 8 Aug 2025 21:47:27 +0900
X-Iguazu-Qid: 2yAbAvUQQGrYhy0ejR
X-Iguazu-QSIG: v=2; s=0; t=1754657246; q=2yAbAvUQQGrYhy0ejR; m=6hKfvNLPouO/ROiilNHXP97v7HF65MBq98IL07dOM1A=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 578ClO3P2059626
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 8 Aug 2025 21:47:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLeFbjUOSG4H2wY47FuK+dRzo4yfEVOR/H4fCpb0NV4Fs+3w5Wt4a0YDOtnQQ6SwmWj3MGFQUlVEU5s5qOsWkUfn4wCD66j9KMFsHRnMhSQgFO4E1hlInFMwSfWG8dYPL/EyydA/eCkuzPboG7L/6jXLWod/basMQt9voooY+iVFT7N+PPmB6UntkLLsJiisGsU688Eg9+SHyd1op1x4bdWy4ILOJAh+l0X4DT6YzdwSzssJVQCO4lG1cbu42BqMWi7n4GF58QeQ6aeQeVWYvfxGBYRTrt2/wdpSyzSY4YDbxzB8a2zpYuXSQwy2xG3g7gtckIXxMH4HpDEjtYigRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5tpiUFHnKPNbVzrtorcFzOZmqk8QKwMnfD+hpLSLIk=;
 b=s5TZGE+IRv29pCct0km9XawEPY5O77PZM0Kv8Vd0V7DJVBW7rAUsFlCeRYYgOmZQzpYx1jN7//rpBJOXSoBgVeQ7+0dZqvlh3n1OujkhjsYL9+EVVDGkiGBJqTMMiLSsonvRvqdS5fR/KSQe4YPSTfQa/0fFMj/zrBMD0a9XqGL0QYmVSp+6X1Ejp74aGikZOz2j20IBUow7RNemCRCD4W6OZOtHHP5a436AzfAWGXtpKXRTn+uL88nrTBjOLiS8YOGDQwWpI0OXMpWxfd0yjiCsihMHTzOXUpIKVX0FZnzHU4blbR8inxTIz36nyyvLoLYH50o4bSpH6EE0pRkUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <uli@fpond.eu>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.41-cip6
Thread-Topic: [ANNOUNCE] Release v6.12.41-cip6
Thread-Index: AdwIYoOGDIQMZD7kSki34XrH5kznsw==
Date: Fri, 8 Aug 2025 12:47:21 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481822FF2F50EF975D1040D7922FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB10631:EE_
x-ms-office365-filtering-correlation-id: 0e210d92-c939-4815-3da5-08ddd679b7b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?b2R1eFZubTNmVEZqbUU2b2IvcVpvRzFUVWdrVjl4b0JoQjkwaGY2N2tO?=
 =?iso-2022-jp?B?cmM5R0hXYU9zdzhRL2RyZU9jS0FLUXZxZTg0Zm0raGEzVks3T0RrQXZw?=
 =?iso-2022-jp?B?d0JodlpFK0FiajVDSzdPQi9xdmhrb2NVanJ0ZWt3K1JQSjlKZUtEaGhU?=
 =?iso-2022-jp?B?TnMySWtkQTFZS0prWFNLYWVzaU81NUdGcW9LOVNjQVFJMGdoNEkwL0xR?=
 =?iso-2022-jp?B?amhkRWdtL3BPOGZINVhncGh5K2M2VHh0RU1FdGx1LzRYM3dNd3YyN2Ux?=
 =?iso-2022-jp?B?VlV0d2crc3V1NDFmYk96TGVRVzVTWG1NYjJyZGtKdkZxdG5DK3RRdnpq?=
 =?iso-2022-jp?B?QU16WTVqSUhOYWc0QTl5cWkrSHErbmdoUG5aQmIwUVJSakdHRzNDN04z?=
 =?iso-2022-jp?B?V2dWN2dsQm5pcHNWTmZWOW5yNFdPRVhzMGR5a0JGMHE2bWFKdzJ0OWdB?=
 =?iso-2022-jp?B?ZDNRcWFmVkxXTUhIdFpBK0Z0SEh5VHF2eDRNSFlxZGdBV1JCRVNSbWpE?=
 =?iso-2022-jp?B?a05QWUxtclNQOXFPa3UyeFdDTVZxRkIxbjR6d2lhQTk4amxHakp3c1Ni?=
 =?iso-2022-jp?B?dTZJZzRNVi8xN1hxa2R4dXdUUWFFZmlONjdsaU52SlBUNDRFSXRIby9Q?=
 =?iso-2022-jp?B?VkpuTmhUcjBXV1lneG05UDF1WkZUMG5taTROT29VUUZJQjluNVRjdEdi?=
 =?iso-2022-jp?B?VFV5Qno0cXhlRk16dGVMeURwQUFkRmlIUmtSUStSamZIdEI4ZXIrNmQw?=
 =?iso-2022-jp?B?ZTV1a0pnKzFvbWUyR1ZhTHhWekthTUZ6a3A0OEluMEJ4UWh3ejZsYXh5?=
 =?iso-2022-jp?B?K2c2amVHQzRDemx4TksxMmZkUyt3ejNLNDdTTXB5OEJ6MGJENXhQaU5y?=
 =?iso-2022-jp?B?ZkNMYmQxbTZDZGFUVTBNUTdWYXM0U1lrNXNtWE8wUy9iV1FIRW0wQTNy?=
 =?iso-2022-jp?B?MTc5N3N4cWVza3R1Z29weVVGbnNDZ1g3Nk5rZTV3end6SUl3ZEZ3T3pI?=
 =?iso-2022-jp?B?aTdkRkhkNlNONkFIZVh4UXRYRmRLYVlLR2JUVTc3RFJub29jdm1Rai9j?=
 =?iso-2022-jp?B?bmdtcFhVN3E1RFUvMkJ1NmNXTHNTUy93UmgzZ0gxNVg3ZjlwNit6ZDM0?=
 =?iso-2022-jp?B?M1pjNTVBdExpRXZuWjlLNlZNLzdyTWtzTUZkM0tzUEw5dlE2Q2xpSisw?=
 =?iso-2022-jp?B?VWZJUnBKYURheFpJRUlSd0VYaEFtS29JdTFvRFg1cHIxM1VpYUZJcUM1?=
 =?iso-2022-jp?B?SW9LTnAwd0xTY3RSTUNJaWtmNFpyQkdCUURLTTlLTGcxTEw3c1ZxbXQy?=
 =?iso-2022-jp?B?M2VmbXg2WXVpdmdpajd0a0JKbGloZC9LUG15SjFJVjBacWlRZGNDQjFO?=
 =?iso-2022-jp?B?T1hrdFltMTlNS0V4Q09Ra2ZqVXB6UWhwVEpTRWQ2U2VIYW00cWNkbmdh?=
 =?iso-2022-jp?B?eGdnczNrbXh0SHNRYUIrS256Y1BNN0RUVG9tNVRrNlFIOFB4ZmJJRjR1?=
 =?iso-2022-jp?B?ODBoMW9GMG1ybmU1UjhUQTdoblVsay94Zy9HUDlWSk9jYW9Fa2twSmJ4?=
 =?iso-2022-jp?B?RElqUTFNQjFlNVlJaWdQZ3RJRlp0YTI4UERIRVltNUpVWjdXTGhWYVZi?=
 =?iso-2022-jp?B?ZDVyc2NSbTExZXcrR1JzQ1haWk93azQrOWNYaTZ0bktCbHZyZ0ljWDZp?=
 =?iso-2022-jp?B?cE83dWthVjI5T09XM1VMcDlqVVNmangyVTF1bU9jRGVMZFAvOFYySi9q?=
 =?iso-2022-jp?B?dEpLQmMvNXpUNUJUQzdRK3Q5NGw3RmtNOTBrRHJ2dU1iUHVRTG1MMXJC?=
 =?iso-2022-jp?B?UXpjWTRONFhyaFU1S0NCYlNacnVXRGh3dW55a0haY2dBM1BmOWNWV0Fj?=
 =?iso-2022-jp?B?cUVCdlJOTzhTMmwrZXkwY1BSSjY0cXpzRWxaUzRMZG1CYVhaM3hPa2Jq?=
 =?iso-2022-jp?B?Um1Ddml4Z2FseHhZOHJTK29tTi9kdmZsT0VMbDJVVG4vemJpdCtmbytS?=
 =?iso-2022-jp?B?S2d5VHBWL3QxOHlLeGp3WFJPWnU4UG1XN2J4TldQdmZIR2h5NU56L2xm?=
 =?iso-2022-jp?B?ZEg1a1VvRGhUcFhIOEFCZE1FeXliekRBZFRycGEvakt2SGNSYWtRRkQ2?=
 =?iso-2022-jp?B?QkphUDBEeERFV3RNUDhzdU14OVBxMXg3MWt3OU5uSnVpU3FIZGZYdjRS?=
 =?iso-2022-jp?B?b2NNPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NDJ5cnNWaURnTFBrUUJESWFFMVpjK3BnRUJSNG02Q2JwYmVQUE9BdGth?=
 =?iso-2022-jp?B?VklnbVpjYUl4ejBHS0J0UkRXWlBFZXdMRExVcDhrNUNwc2RlY24zcVpq?=
 =?iso-2022-jp?B?YTljYWJVQklqeXJVdnZoSjM4bktQL01BZlYwUWNBMVBYLzZKR2V0YlFC?=
 =?iso-2022-jp?B?VXEwcVJVQVE3bHNmZzA1dWNydDdFaVZCMHdUdnloT2tudHR5VDc2N2FN?=
 =?iso-2022-jp?B?OC8yQ3EvSW0xaWdHUVR4YXhBUHoyM25xcGFxR2tMaG0yOWVRS0NQM2pz?=
 =?iso-2022-jp?B?UGs4a01sYmptNVVkTks0a0gyNGRkbXhiTXdoL3V5R3JCc2dIV2VrVlpO?=
 =?iso-2022-jp?B?YVZwMEFGQ3kvWit5ZTk4cEYrSEd6a2dIeDVYNkpPVnFvMmJtQ3NSWGZl?=
 =?iso-2022-jp?B?aTdYL05qVDhqaE1TbXVpVUlLZ3FCTzdCdTkwaGNFbGo4QjViVGFUR2lu?=
 =?iso-2022-jp?B?cnluWGpzTW1RNHB6akV5enE1cEtLSnBUUmFJQmV1SUN5VmFGQ0tzWW8w?=
 =?iso-2022-jp?B?YldjU3E3SnVEbzBlTWJIdWVDclF2Sm14SllMbGRxZkVkWGQ4Zk41RWhL?=
 =?iso-2022-jp?B?QjIwZVNVUVRFcll6MTYrdnFBNUw5UCtGUnhmTmNOemtrQVJZT2MrZi8x?=
 =?iso-2022-jp?B?VmR0L0h3RVRBVjRXa2YyY2RLQnIzeDhnS2xKMjFwN2x4T29qRmNSZ2lz?=
 =?iso-2022-jp?B?QWVkSndMUlFNc1E2V2lCZE0zQ0ZvZkRZVVRIZnQvcnBYWlNadEo5TmN5?=
 =?iso-2022-jp?B?UzYybUo3Ty9HUEZBSm9zeTRId2lCb3poN0EvVzdxRjd6Rm5RdSs5dmVY?=
 =?iso-2022-jp?B?MTdBT0E1QS9Oc0lNNUhobUljZ2p6dzNmMXhPSVdnRGpNVm44TkZSNFRW?=
 =?iso-2022-jp?B?Mmk3ZDAyUWJPd0pyZFJIWmk5ajFpMzM0Y1RZckdRZDJreHRUVEo4NUN6?=
 =?iso-2022-jp?B?bEV4UThiL1pndndDLzJHMFlCVmlQRytGU2tSVk1RWDBNb1NrSFNvOWgr?=
 =?iso-2022-jp?B?MFNpS3V1NnpmTzRiU0d3Wnh3Uzg1VEkxc3R1RW9aVW15Um91S3BjemhH?=
 =?iso-2022-jp?B?WDFBQmxZTnk1ZmxVN2w2VUROdjhwZXVWSHozb1ZVcHFkcktKYkdhN2tm?=
 =?iso-2022-jp?B?d243ZUliYWJHS0RYY2dWWFo4S3RSYnIxNG9nL3k0RmJQUGhmU1RpeUhp?=
 =?iso-2022-jp?B?Y3NRQnhPSkVYSzFuWWd1dGJNSThIQnRPTUFzTHNsUnhWb2NVd2JtcVRS?=
 =?iso-2022-jp?B?YS9pS1lIbWFNd1JwMUJoWXBEZWd4SlNPNWdMdk5FZFZXWHJ4WUtwZDh1?=
 =?iso-2022-jp?B?bTZyZUV2bE5DVnNwY3ZrdVdSTzFHQkt6VGZDeFNuOFY4WE52MUJabmJK?=
 =?iso-2022-jp?B?OE1FU3MraVRxSlZtU0k4QVg4bHBLemFxOUdqbXV1ODlORE5BS2NjTVhG?=
 =?iso-2022-jp?B?RnJTb2RzY2xjUzYrYVdidkJJeWcwaHlZaDE5d2piU212QXhvUlNCaTM5?=
 =?iso-2022-jp?B?bmpTbVFkUW5vSERSSXIybVlJTjEwRTl1MzZpSVFqU2piaGxjU1lUTzhS?=
 =?iso-2022-jp?B?RmVyZmtJQldnUUt6RTVlbk9zWTFaVkpxTXgvV3BwQ3NmbHFGWjRlZU5S?=
 =?iso-2022-jp?B?azgvcXc2ZkU4WjlHdHFnNStieXVmWWdyQTFwV2ZJWmIzeUhuZTZRaTVS?=
 =?iso-2022-jp?B?ZFFYdzBJeW8vQ2ZSalpXOEpka01jYTJpeFRxSVVlWjhVOXpXVTh6Z2NB?=
 =?iso-2022-jp?B?cFJKTUI1QUdEMHVYeXZMWFNtWmIrMUJmUjlRK2tUUGVjTnlzeWcrdEY2?=
 =?iso-2022-jp?B?K0FIVWhTZU0wZmNRV0xlMWY0a1VKeldxb3VRQ3U4VXhtZ1gzVk14M0lZ?=
 =?iso-2022-jp?B?YzJnZDlvb1hvTmZYOGN3WFBXc1gxSHRCM3BLSEh4WDl2bGRKOWFaRnR3?=
 =?iso-2022-jp?B?b01Mb3hkOGozOHYxRDJOMXZlV0xMZVhmQ05tR1J5VFJFY1F3ME1NdTVB?=
 =?iso-2022-jp?B?QXRTSUVNNkpoYkxHWVVxUGd6ODlhRXJPOU1xV3A3aERiZzU0NXQ2TERr?=
 =?iso-2022-jp?B?N0F0V2d6MWRwNUdHMjRaa1hYUVBEb2svNGxTY3ZZa2w0NU9GNmFYcDh3?=
 =?iso-2022-jp?B?aDg4aEJqekJKQnkySlFWbGtnZmlITklGOElIZDIrdGpFWU9KejdlRnpL?=
 =?iso-2022-jp?B?NzE5WGU4R283MSt0UytwN3NQc0VOdXRqODFMV2dQN0NBaEllZEVFREVa?=
 =?iso-2022-jp?B?MTFiOHl2UDZMazZreDZXRTNFOHhVUkVJRWVZMGcrYit6ZHU1UnpkWWtz?=
 =?iso-2022-jp?B?MlRjbzZseWVZTnhWMzQxeXg0cFQrbkxqbmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e210d92-c939-4815-3da5-08ddd679b7b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 12:47:21.7036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDgYKYKax2bMYloXFXxg7PQ7z6qM/I2YhQkzk43fqCvsHrGtR7195UF4T9c/X+khT1CwfKe20BpkYd80r2FgB+u/xJGdaJmpKPRtkVHUV3f5hZGjda4GVrwgvcUjlEiE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10631
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Aug 2025 12:47:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19714

Hi all,

CIP kernel team has released Linux kernel v6.12.41-cip6.
The linux-6.12.y-cip tree has been updated base version from v6.12.39 to v6=
.12.41.
This release updates the DTS for Renesas ARM64 SoCs.

Information about this release is as follows:

  v6.12.41-cip6:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      90d753ffff95206265b517c1e36880510c03c2cb
    fixed CVEs:
      CVE-2025-38491: mptcp: make fallback action and fallback decision ato=
mic
      CVE-2025-38488: smb: client: fix use-after-free in crypt_message when=
 using async crypto
      CVE-2025-38490: net: libwx: remove duplicate page_pool_put_full_page(=
)
      CVE-2025-38469: KVM: x86/xen: Fix cleanup logic in emulation of Xen s=
chedop poll hypercalls
      CVE-2025-38493: tracing/osnoise: Fix crash in timerlat_dump_stack()
      CVE-2025-38481: comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too =
large
      CVE-2025-38475: smc: Fix various oops due to inet_sock type confusion=
.
      CVE-2025-38489: s390/bpf: Fix bpf_arch_text_poke() with new_addr =3D=
=3D NULL again
      CVE-2025-38468: net/sched: Return NULL when htb_lookup_leaf encounter=
s an empty rbtree
      CVE-2025-38480: comedi: Fix use of uninitialized data in insn_rw_emul=
ate_bits()
      CVE-2025-38484: iio: backend: fix out-of-bound write
      CVE-2025-38495: HID: core: ensure the allocated report buffer can con=
tain the reserved report ID
      CVE-2025-38487: soc: aspeed: lpc-snoop: Don't disable channels that a=
ren't enabled
      CVE-2025-38474: usb: net: sierra: check for no status endpoint
      CVE-2025-38477: net/sched: sch_qfq: Fix race condition on qfq_aggrega=
te
      CVE-2025-38494: HID: core: do not bypass hid_hw_raw_request
      CVE-2025-38470: net: vlan: fix VLAN 0 refcount imbalance of toggling =
filtering during runtime
      CVE-2025-38483: comedi: das16m1: Fix bit shift out of bounds
      CVE-2025-38472: netfilter: nf_conntrack: fix crash due to removal of =
uninitialised entry
      CVE-2025-22115: btrfs: fix block group refcount race in btrfs_create_=
pending_block_groups()
      CVE-2025-38473: Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb=
()
      CVE-2025-38478: comedi: Fix initialization of data for instructions t=
hat write to subdevice
      CVE-2025-38485: iio: accel: fxls8962af: Fix use after free in fxls896=
2af_fifo_flush
      CVE-2025-38497: usb: gadget: configfs: Fix OOB read on empty string w=
rite
      CVE-2025-38476: rpl: Fix use-after-free in rpl_do_srh_inline().
      CVE-2025-38496: dm-bufio: fix sched in atomic context
      CVE-2025-38471: tls: always refresh the queue when reading sock
      CVE-2025-38482: comedi: das6402: Fix bit shift out of bounds
      CVE-2025-37925: jfs: reject on-disk inodes of an unsupported type
      CVE-2025-38221: ext4: fix out of bounds punch offset
      CVE-2025-38351: KVM: x86/hyper-v: Skip non-canonical addresses during=
 PV TLB flush
      CVE-2025-38335: Input: gpio-keys - fix a sleep while atomic with PREE=
MPT_RT
    added commits:
      CIP: Bump version suffix to -cip6 after merge from stable
      arm64: dts: renesas: rzg3e-smarc-som: Add RAA215300 pmic support
      arm64: dts: renesas: rzg3e-smarc-som: Add I2C2 device pincontrol

Best regards,
  Nobuhiro


