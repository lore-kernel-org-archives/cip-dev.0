Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDF5C19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 04:24:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.6248.1741148678116070651
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 20:24:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=bk0piznk;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1741148676;x=1742358276;bh=9/J1ffS6hlMhYy7NtbM3A5WcFeMAhJge2rQD5GR
	xiLI=;b=bk0piznkhrvYZOa5/gY1Y1iQKxin53+kzwpjB2I5x4cuT6eRIio+DH22TabaiGQFJKriT
	RddR350gsps7+9m64DdHhL4IswVbTWWsnMW66keZRFwPfQnIjR1uGR32vw/tr2xv70uxqNcMVlXtR
	a8R7gYdvaUtgNW3p7QdrIHeicbFs/0Prmt3tN+sL3HOVrozvz3lvsoBEbvuMrL2jDnv0lVkXNWOGi
	23zQIp/JEd09z/Y4sRiE+jVtqlyu9SQ4QPSS7otb2Iw6+yYonTdcLF6h8fHBZY+T+2kW0EHMJLx2+
	1dvB4bwb2f9g7/9aGUdRAUFOx9uiEAVTIxp+UuQERg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5254OZXk2499000; Wed, 5 Mar 2025 13:24:36 +0900
X-Iguazu-Qid: 2yAb5TJlfVmJ8INdHU
X-Iguazu-QSIG: v=2; s=0; t=1741148675; q=2yAb5TJlfVmJ8INdHU; m=IP94u9HbF8Ah/mL6pGSSsDnGuHq829eqH1Vjje4g3yg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 5254OYJ83563313
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 13:24:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urRcm3sMzac72KOInwR6OdUZB8NGy+ZXheG56j+ZJomUCc1lGuuHtVt0FzspLOkynPGO7h2iYuExRYoASSJkvgqmGbsOgjJHkO973l4B6fGHDP1qBZZzcxoEE8eV5DWyM37PK2vWnkFaXEYULqJP6snn9nQoWpM1GnojioabPjrCSMeuHlS0vv7cuh7OUpQJSPtGseDciLzF35qerSS0D8tWw77zXr/x95Nhjsai1nu50WXfkn/uWydWSaMC0dTuFYJFC3jE+p2K18VQFQf6qBxC2DxFjSnkYEKBWvEXKpmDxCpyXn5K6Z08Epki3JJe7vCX51cSBKi54X6L0t/tXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/J1ffS6hlMhYy7NtbM3A5WcFeMAhJge2rQD5GRxiLI=;
 b=TDP6zF/Q73Me+UdBqSkLv4MtGbvIcQypQEZmdwBkCBmy0vJ0Fp0lMmNZ9aSFo6tBtXokG3h9irsZCqT/tHJtoOajjv4qBKogSLdDzFXI4b4u1psvbopjCdueSS+kvJUBMaQDURtZFr7Y65UjG31b01cK1fN8pWhvAT3UTjFFLRquFzid3bi/zfRoEPzfYqnBH7VO+NuqUsqfukNBabpn7GJn2M2OAaZcHqEutJ58EDiCMi4+cD68IOH55atkKR7IQewdBWCeEfT4KxF69PrI+OicSlV8cBvtOvimTqYENfjGe/RYphbT3V9F224CuIDNy4N64XN+irXNulAsVDI+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH 1/2] scripts: Add automated recipe updates
 for LTP
Thread-Topic: [isar-cip-core][PATCH 1/2] scripts: Add automated recipe updates
 for LTP
Thread-Index: AQHbibEq6Af10fvnTUmYsxfwfzaWXrNc28WAgAcdnXA=
Date: Wed, 5 Mar 2025 04:24:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818E3190C7627930154D27092CB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1740727183-24538-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <e0ede60b-105a-41bc-85e1-2b58c14eaee1@siemens.com>
In-Reply-To: <e0ede60b-105a-41bc-85e1-2b58c14eaee1@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB11509:EE_
x-ms-office365-filtering-correlation-id: 12bd9e1e-f42a-401e-3a2d-08dd5b9da0df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NUw2Um90U1dBNHJrZTlMY3VRajNnR3lOa0hwVHpBeW41U2N0ak1ZNHZxV1E2?=
 =?utf-8?B?cERtS2JVTzE2cnRLMXFzZ3p2NkJhZTltTWhTMkpqUTlhalNid041NVI2dmhz?=
 =?utf-8?B?MFNLcmF0b0pYeXl4d3VMLzRLTnFJZW1OUEp1VFRrUWZpTGlWNFNCMjhGaXVS?=
 =?utf-8?B?UW1QT01YUmgzRi9HWkhXMEFRbFV0TitoR1BxSTBFc00zOTRuRzZ5K09TSXVi?=
 =?utf-8?B?eTVzdklUZzRkbklxdHJPV0FDbFc0bGpiRTNlMllrekFhTVQ1UmkwSkxjZ0tj?=
 =?utf-8?B?MkpBNTVNajFsdVozTnFnU3U2VkhGS0h5enVkVElOR1pyTWRnM2dQa05UN2Zy?=
 =?utf-8?B?a2VycTliMWtrcUhob3Q1TWdYbktVUFUwUy9HMjhXTGhJUW4wZGl3Wkx4c1RJ?=
 =?utf-8?B?VDFwSnA0YmkrYzdON0RSZGxNTGZrbW9FRUMyUzNqVXkzRkRPTlZuRFdsZXF3?=
 =?utf-8?B?dU8vSDREb0NXVE9wbjhQMFJmRFJjUHlCWWxpSWwzOXg2dHBxWU9LYUVtVnIx?=
 =?utf-8?B?UkpCczZLZVNHb3Z0UG5Zd3JGT1pmRzlsMGswaWVvQTVubjhtMlVGeWdNV3Vu?=
 =?utf-8?B?aFpwZ2x5Rm9uakJYVnBvLzg3L2dJOURvREltN1JoaTRPYnRYNUVXaFRKOHlS?=
 =?utf-8?B?L2RlRitNNmxLUEdSVmQ0V3VhQXI5U2pHSFZOR2JaNW5tS1dpMjR1eCthemQy?=
 =?utf-8?B?SzdFQm5XMVdjbm1XbjFLalAwQ0hzb1ZEMFl5QWwrdWZxUW8xWlVHWUpIK3o2?=
 =?utf-8?B?VWtIMGhhQXRyRlRyVEViQVFYYXp1WDNpSzZJU1J2bzdzOU9aWmd3UWppVHVT?=
 =?utf-8?B?VXUrRFFjRjdDSWZIb05qem9CMjVOVUZFU3FoeXh0dktydlZIc2didDJENHNN?=
 =?utf-8?B?a1JXeUJVcmlGMDIwVThrU0gvK3FuVjRzSGN0NTBqbXcxNHdDYWQxekp1c2Ir?=
 =?utf-8?B?U1J2cC9PSGMwV2tlM0o3Zk1iTnJtRUNIZGVXcitrUHJ3NG5YZEZMVE95c1Nl?=
 =?utf-8?B?UU54QjQxOExmYlBXYkV2MVBVUmRwNlE2T29uUGRRT0JWek13a1ltdnlmYkNH?=
 =?utf-8?B?eVZ1dVc0RDh5eTk4UFpneWxjV1JRamxncUI5ZUhoVE5ITDlYYXJpSEVScmpq?=
 =?utf-8?B?Ulh4Uk43V1NnRWM0N0RkU253alVvdHp0b0NoMVpoRTlrT24yTzkzQjF3OGpL?=
 =?utf-8?B?RDc3N1dRbitSdUZsSG5RdEw2ei9rRFJ5MU1aT2NySDl5TlVCUXZzWkQ2SzRX?=
 =?utf-8?B?Y2VYdW1YNk9PRVZZMDhibXlKV2QzeVNFM3RicFVwRGxiMkYwYXYxQnRZUitQ?=
 =?utf-8?B?dkdsdTBMcjZFYWc1NlNKdDZmY01SbXVxdGpDbEFhYlJsTnpSb3BIaTAxa1dq?=
 =?utf-8?B?U3o2akw3ZEdSdmN6c2Y4TUtGbGd1TmdqU0orcHZqaWlTL240Nk1iZlBPT0lh?=
 =?utf-8?B?aXhZVjRhNmp4L1pjNFV1M0pRMTRsSUhmV1hYNUloTWNlSStxVUpXQm9CT0Ja?=
 =?utf-8?B?SnlkaWc1dWUwc09qdXk3M3dBSEVBUUMvRTgyTEk1YVk5NEg5U1NGUnRPOEV2?=
 =?utf-8?B?L2Zja3BObzVrTkFJWW5UKysyanNQeTZSbnB6eTJrTDk0aFhwRGFlREM1ZGwv?=
 =?utf-8?B?bHRDdVY2WklwTFNlZkFhMTFLTDIzRG5TL0YrcnRGcTV5N0FWRUFaS1I0SGM1?=
 =?utf-8?B?eDMyWU9jeEsxQlo0MmJENFl2VlVkbTZ0eE9ISmEyem1CUnhBSHJ0R2xNMlJM?=
 =?utf-8?B?M1NYZlNVbGRKOU5MSG9DUGtMOXdmSk9Idm5pVjNpdzFQd3kvVVRXZkw0RGt1?=
 =?utf-8?B?blkrdS9Hdy8yNlNWMVBYUzJNaHdSQSsrdTFPU0VPbktGYi9ZRFZnWisyL04z?=
 =?utf-8?B?ak5qTjFCNXFmZE5CQm1OTWsvQ1ppZkdxU3dhcCs0ZG9vcGRjZGVkRjNyVTJB?=
 =?utf-8?Q?hp9TKnwOQA+O0INQesXOKx9SelS7M4it?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dWtMM2hiWFBUS0JaZGxES2g4c1l5WWlKZ0wwRzNuTTVFenFSZ3F2TG0wOS9Y?=
 =?utf-8?B?YjR3d0d4OGt5VEtSUHFnbUpnMDRFck1JL29KNFF6NjZpZFZQYTFtU2V4UzJu?=
 =?utf-8?B?ZVpUOUg0L2xxbnRaNEljaUw1V0xDd1FvREh4ZkVTS2RGdW9JWEo1LysrbC9z?=
 =?utf-8?B?Wkt1K3JBLzRUQW5ZVXI1TXl5d3YvckFjN3k2YnY4OEI5RlgvMktoVjl5T2Zl?=
 =?utf-8?B?NEVPR3huQkQzSm9aS3VhWVBUYUQvNm1UNk5Tb0N2dGlDK3U3bWg1TFZRemlm?=
 =?utf-8?B?YlRFcUtlZGVKOC9WWUNxbUtVRlBZemQvRE1SZzI3TVRnQzhuOUVtdmdPNDZP?=
 =?utf-8?B?UkMyM1pKcVFvOS9tYkNHbERVSkdDa2JWbzFjd3hTQ0s5RWM3TllyZDNaempa?=
 =?utf-8?B?bXIyTk5EWGpGaElhMDJLYXVNdTkxczFuTFc4NDVCREZDVGhMZ0ovKy8yalZI?=
 =?utf-8?B?VHhtZlRCWUJ2aitWbG9UVnVkbnpvR2o5THkrQXJQMG1RVjQwYTN2WUcyRGVs?=
 =?utf-8?B?K2ptVGErMUkrZXJTaDlwRVRlS1JQbHN1azlnN2xZSG1QOXVsMDZ2TXF1b2l4?=
 =?utf-8?B?RjZCckpTNTRTYktEbXBzVEFlZHB0NHF2WFNmSmM0NEtuUHpPUVhGYkdvOERC?=
 =?utf-8?B?V0xJNGZtMUFNb3BhYTRsZmN1Y0xOb3ZjbXg0NVcxdlRwNFphZHVNN1FKZHVw?=
 =?utf-8?B?TXFyQm5haXBZZVpsUExZRDkzRFlNd0JUTzdmTmRIMVdnb2p4Qyt6ckhINitn?=
 =?utf-8?B?ME4rU2lSRklQWkhiYzl5QVd3UzRvellMcVlQZDJDcSsySVVnUExRdCt0WmJL?=
 =?utf-8?B?Y3RhVk84VkNkWE5IQjB4MGFDcGQ0QWNEb0Y1WlZqVjlFeFFyS0J5LzBudk1Z?=
 =?utf-8?B?WHJVL2k5cTl5V1pGRlpVL2p1cEhHN1gvdG1BTm1VOVh6d3VvcWpJeldIWndM?=
 =?utf-8?B?UzcxY1FEZ2VsUGtqTXpMRmJBeFJXbFFtaVJ3aWJTMlBscXA0d3VjMng0cjFJ?=
 =?utf-8?B?V2EycHZDVWhBV1liNlA2SlczQmZ6a1FQTlVwRUxTQzVOa0pXeGlkaWJ4WEtE?=
 =?utf-8?B?enhDWnhOTGdOaDFGcXo2VFRrMVZEQU9ZNFJoSU56QklYWE1wV1R1T05zZTBW?=
 =?utf-8?B?RENBejVLV0xWRU10ZkhCTWp2Vll6OTFMeEoxam1MWmdVMnRmdmVpY1JrOWNq?=
 =?utf-8?B?ckNRL1c3UXRDVjdQbUErOE1yeTVkb2pNMmwxM3FZVEFqaWpJc1ZXUlM2OHdT?=
 =?utf-8?B?M01rTzQ3UEtlN2ozVWlUcmhPRk9oZFN4UEE4bHZYdVQ2TzdyOXJBSHFldUhP?=
 =?utf-8?B?TE96TDBiYXo2VmJSZy9hV3MwUVkwMTEvR2dlcVZtaUJtaE00RDZZOHh2WVUr?=
 =?utf-8?B?NVQ2MlNHUHYzSERPL0p0QXRKelYwTVFtOXlkbEVrVUx0YVdxVWxNU0cra2E5?=
 =?utf-8?B?NElkcjUyeXo5WUt6Q3A0anRWL05QeUdxNDFmRHhZaERWOHRUVjNuTndXdGZz?=
 =?utf-8?B?cFlkUFllSGJ0d0VVK2ZBdWZRNnhiNW5lODQ5RUczU1hrMEo1WnIvdXV6bTdm?=
 =?utf-8?B?RFJhWk5lOEVPaTV3bHlodDBFK2FGSVhSY2w5RkJCcEU2U0hxTVlrN1hLWVp5?=
 =?utf-8?B?bHk5MkU4UmZYaS9YR1NzaG90Q0F5TEVkSmVlSVlHL3c4UjdEVDFZR1VlVzZt?=
 =?utf-8?B?TTQ0QkdsM0FMVDRFSFhodjQ4V0pLQTVERkl0WXJHWnlGZ1Z1S2FrMWRvQ21l?=
 =?utf-8?B?RWlJVmpOcFMzQmNIMEdES2EvdFBtVDNHZ3I1bEhMTXIrTDc1cEp6SC9iR2w5?=
 =?utf-8?B?RXlqWmoxcW5RcmpnQmFxVmt1cm55QWxYYy8raGNLOXBNUE9FOW9IVlh2UW9Q?=
 =?utf-8?B?TGFPdTNMbHBYVDVVOGJ1WkNVS3dDRG5jR3hzdVgwTXY3alNGQ24xdzNxTjds?=
 =?utf-8?B?WmxSbm9mWm03QTdRaGFCR0kxTlVrU085NHhYVVJIL2RXTlUwRlZidy9XV1Fw?=
 =?utf-8?B?SmtaVWlZSEV0dEdTOHZJUjVCU3lxTlVMdjNVSnl5TklBNzhsUUxJR2dYTHFs?=
 =?utf-8?B?UDB0YlNqcUhUek9pdGp6WWorWnpqeXJPOWdJQjlpclg1bFdNY3ljSWFXdFE5?=
 =?utf-8?B?RGpqR094aUtPYkx2RldIL2pENVcwbEtleVZ3NW5IY3lsaEtTbW1LRGZSVERH?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd9e1e-f42a-401e-3a2d-08dd5b9da0df
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 04:24:32.3037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46JMQQb/i+icHbdfB04qmvIN8sBLKAa2JQi4sMW8fEw8QH10+2A22avv9FSWadUTz+9VjFGgBLghRRfMNLFvtMYqRiF+UM4n52iBsLU2eC8V02CthtIltpc/HeLsCf+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11509
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 04:24:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18026

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAxLCAy
MDI1IDEyOjQ0IEFNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8
pO+8qe+8tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVj
dDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSCAxLzJdIHNjcmlwdHM6IEFkZCBhdXRvbWF0ZWQg
cmVjaXBlDQo+IHVwZGF0ZXMgZm9yIExUUA0KPiANCj4gT24gMjguMDIuMjUgMDg6MTksIE5vYnVo
aXJvIEl3YW1hdHN1IHdyb3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5vYnVoaXJvIEl3YW1hdHN1
IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPiAtLS0NCj4gPiAgc2NyaXB0
cy91cGRhdGUtbHRwLnNoIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNzU1
IHNjcmlwdHMvdXBkYXRlLWx0cC5zaA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvdXBk
YXRlLWx0cC5zaCBiL3NjcmlwdHMvdXBkYXRlLWx0cC5zaCBuZXcgZmlsZQ0KPiA+IG1vZGUgMTAw
NzU1IGluZGV4IDAwMDAwMDAuLjk5Yjc1YjANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
c2NyaXB0cy91cGRhdGUtbHRwLnNoDQo+ID4gQEAgLTAsMCArMSwyOSBAQA0KPiA+ICsjIS9iaW4v
YmFzaA0KPiA+ICsNCj4gPiArUkVQT19ST09UPSQoZ2l0IHJldi1wYXJzZSAtLXNob3ctdG9wbGV2
ZWwpIHB1c2hkDQo+ID4gKyR7UkVQT19ST09UfS9yZWNpcGVzLWNvcmUvbHRwID4gL2Rldi9udWxs
DQo+ID4gKw0KPiA+ICtMQVRFU1RfVkVSPSQoZ2l0IGxzLXJlbW90ZSAtLXJlZnMgLS10YWdzDQo+
IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwLmdpdCB8IFwNCj4gPiAr
CWN1dCAtLWRlbGltaXRlcj0nLycgLS1maWVsZHM9MyB8IFwNCj4gPiArCXNvcnQgLS12ZXJzaW9u
LXNvcnQgfCB0YWlsIC0tbGluZXM9MSkNCj4gPiArDQo+ID4gK1NIQTI1NkZJTEU9Imx0cC1mdWxs
LSR7TEFURVNUX1ZFUn0udGFyLnh6LnNoYTI1NiINCj4gPiArcm0gLXJmICR7U0hBMjU2RklMRX0N
Cj4gPiArDQo+ID4gK3dnZXQgLXENCj4gPiAraHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3Qt
cHJvamVjdC9sdHAvcmVsZWFzZXMvZG93bmxvYWQvJHtMQVRFU1RfDQo+ID4gK1ZFUn0vJHtTSEEy
NTZGSUxFfQ0KPiA+ICsNCj4gPiArU0hBMjU2U1VNPSQoY3V0IC1mIDEgLWQgIiAiICR7U0hBMjU2
RklMRX0pDQo+ID4gK1JFQ0lQRT0ibHRwLWZ1bGxfJHtMQVRFU1RfVkVSfS5iYiINCj4gPiArDQo+
ID4gK2lmIFsgISAtZiAke1JFQ0lQRX0gXTsgdGhlbg0KPiA+ICsJZ2l0IG12IGx0cC1mdWxsKi5i
YiAke1JFQ0lQRX0NCj4gPiArDQo+ID4gKwlzZWQgLWkgJ3MvXChTUkNfVVJJXFtzaGEyNTZzdW1c
XSA9ICJcKS4qL1wxJyR7U0hBMjU2U1VNfSciJy8NCj4gJHtSRUNJUEV9DQo+ID4gKwlnaXQgYWRk
ICR7UkVDSVBFfQ0KPiA+ICsNCj4gPiArCWdpdCBjb21taXQgLWFzbSAicmVjaXBlcy1jb3JlOiBs
dHA6IFVwZGF0ZSB0byAke0xBVEVTVF9WRVJ9Ig0KPiA+ICtmaQ0KPiA+ICsNCj4gPiArcm0gLXJm
ICR7U0hBMjU2RklMRX0NCj4gPiArDQo+ID4gK3BvcGQgPiAvZGV2L251bGwNCj4gDQo+IFBsZWFz
ZSBoYXZlIGEgbG9vayBhdCB3aGF0IHNoZWxsY2hlY2sgaXMgZmluZGluZy4gU2VlbXMgaXQncyBt
b3N0bHkgcXVvdGluZywgYnV0DQo+IGlmIHdlIGRvbid0IGdvIHRvIHplcm8gd2FybmluZ3MsIHRo
ZSBuZXh0IGNoYW5nZSB3aXRoIGEgcmVhbCBpc3N1ZSB3aWxsIG5vdCBiZQ0KPiBlYXN5IHRvIHNw
b3QuDQoNCk9LLCBJIHdpbGwgY2hlY2sgd2l0aCBzaGVsbGNoZWNrLg0KPiANCj4gVGhhbmtzLA0K
PiBKYW4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQoNCg==


