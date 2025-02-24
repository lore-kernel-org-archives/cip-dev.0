Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D69C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 13:03:36 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.84])
 by mx.groups.io with SMTP id smtpd.web11.88737.1740402207445646149
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 05:03:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vCa4Yi15;
 spf=pass (domain: siemens.com, ip: 40.107.105.84, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW7dyQNAMTdtrCX20HldQnvm0Gv2FTBrNlUxeWDq2xBDnFN7j9+8ekEO7jLC3F6E4Mo+CC0C8f9RWdbZayNm4E95dQ1qAmep9Akvu0PZwsa0FcBlJyYsEk8eYIDMxCEwH4wbK67NtzMZe1DV5VzhPJJb7ctjkXrlNl1/Qh5WKMMDJWvKu/Lt/xOpDmnsnelKAf/T0TguysndcwS9h54MKS7ZRAYOf20ym5ey2PB63PWHO+xyuf31lRRlhRmPgRMeqcYp6uzMhOIo1kX+kjFA7ZPzvYi4LzJKAjMjdLMR5idNKeapz64sfPvVwndPusYXUZBk0Zfi/TkuEyyyYfrBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UlT+GIiKgciovVLposMo8YIdQu9HYdqd4mbDwjFq8c=;
 b=Fa1dW4BB91yYZ+0ERDcxipyAgI1cS21APPl0nihzsHJjUXMVO4YhzesWj81EnS5RLgnEBN667Boc8Jh+EvE8QAFbwMiKIpevqG8WAAqShj79R/cv0Givko+sbc0ZJZqgyZycbBljLo78Bv4Ig0Xf6kmgFITW2l/l/1UKorGhqxuox2o30xbowG3MqF/cwqUIcfiYxDJiO59xHRdKe1uv+DljTsh93faSgoJKXQLkZW/PGjcPo9rLBsBRx9KvCgw8TaHRaeSq+p8D0uysFVdt8DgePmL39Q+/XW1XPxgNwA0WuoxOh0Lc6HFFeF8pVS0oblXPaRGYh7ECfk1lzT5tag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UlT+GIiKgciovVLposMo8YIdQu9HYdqd4mbDwjFq8c=;
 b=vCa4Yi15YmbAR2Z4Kl3SCNO/wgAMdag7hev3ueCKrnWC0XsUUAOwwtTmUblnA8YX3JgATJ4ArZUf04N0wnROdDvw4Sxl2hLeThHcrx4u0Sub3uC0jQ0GE1Dc38vPCxaWcK4qXM3R32a9Zv2ZLDnzKRztiS6tqYCgi3fyj3Qyu5KNh680V907Qn4QMkCg1DbBL2DtqIcEBl3F+Q8T9ux2G8768UzzFqtLOk1KSj9x4ub3D9PKnO+LXyMpGf72Kd0EEgE3wrc9tX4inPlrMfpo9FHTKvapZ7EgagDIYN0zWhOyva7+3fKJUBuNDjGSHXQMYgSsisl/ze2orBDmmdbToQ==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by VI1PR10MB7782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 13:03:23 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:03:23 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from
 read-only-rootfs's fstab.
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from
 read-only-rootfs's fstab.
Thread-Index: AQHbgSMFS4oMVoV72Emqa3dVE8borLNRsACwgARTFICAAGbbgIAABtoAgAAFZWA=
Date: Mon, 24 Feb 2025 13:03:23 +0000
Message-ID: 
 <AM7PR10MB3320A04B717DF98709A7F9C086C02@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <1824F69F112B9158.31881@lists.cip-project.org>
 <AM7PR10MB33205157A04B7C1290C1B6CB86C72@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <6fce5303-59b6-4aee-b60d-d0d25c8a3a2a@siemens.com>
 <2010c1c9-c33d-48fe-911c-4d4dfdf46d0f@siemens.com>
 <f05430e8-0a36-42bb-9c67-d6ccf60c0ddc@siemens.com>
In-Reply-To: <f05430e8-0a36-42bb-9c67-d6ccf60c0ddc@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=13715c89-f371-4306-a614-3d703a16a141;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-02-24T13:01:32Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|VI1PR10MB7782:EE_
x-ms-office365-filtering-correlation-id: eda98959-2425-465c-e9d1-08dd54d39ea2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RUJaTWMwejZjT2k1TUJvWS9IaVZNdE8rOTVWakkva3ZXRjJrdG5kd3h3?=
 =?iso-2022-jp?B?d2I2bm9zVGU0RkZ2Z3pMZ1BBUHV1VnRQYytXNXBPekMzRDRzNy9yeDlo?=
 =?iso-2022-jp?B?UkkzY0JxdHE5QlNDRVEvZDN6L1U5WVRqc3lFNjE4WDVYSFFDSXB5ZWVv?=
 =?iso-2022-jp?B?NDJCZWxMejdtSWwxVkVYL2t1RWk3R2JMZWZWMWpXd0E4dVI3Rktqc3F3?=
 =?iso-2022-jp?B?VkwyUjlLWThjOG1yTm9oQnl3NTIxM2VMekZzL3dRdHlkdm4yYlZzT3NF?=
 =?iso-2022-jp?B?UmNsdGpBWXB0aTgyZ3JJVDYxOER4Z0FzZW9mRWUrM1hwUWJWaExlSVVs?=
 =?iso-2022-jp?B?L3FSN25Zd0hndGVqMm10MDdqUkdFNEJ5cmw0VFI0bjRWQmJwbnpDdWdC?=
 =?iso-2022-jp?B?YTZuRC92NXdPZjZtYVFkUzA5a1lCcWNUSEZWZlI2MFNZYnc4WHM4YlFn?=
 =?iso-2022-jp?B?YVZsZFA1UTFHQkhabThwSHFUVmhTaW1CYmYxMjNPclNWSVY1cHBZVUZC?=
 =?iso-2022-jp?B?ZitWL2wyWVUzak0vbHBGeFBFVjlCaTlEUEsvVU5QeTRad2cwSEJKYUoz?=
 =?iso-2022-jp?B?RUQ2MW13WXYyTldld05KNHVManE2SHBPcVNnaHVRakJMbVdSWnp4bTlq?=
 =?iso-2022-jp?B?c1VZdWdnTDJGRUxreHBuQWV2Z042cU1KZFdZWjNoa1BjeGlzN0xhMXhn?=
 =?iso-2022-jp?B?d2lsbS9LYmw4QmZXc042bDVJd2VtS3BjWGxQMVQ4MmdiRGFvdmFIV2dS?=
 =?iso-2022-jp?B?K293TVhZUFpSNmRiSDdXaFRsalc0eTFDRkZtZUx2RUdTU3krVWllc2Qr?=
 =?iso-2022-jp?B?TjB2Y3hyMzZUZGdTTmxoQTZSY2hWNUlrMnBwdG9WMXdmUDdLNmdTRWNr?=
 =?iso-2022-jp?B?LzBFMzJlc1dQYm90U3BiZkQxNWluVGhMdDFTT3Jjb0FHYy93MXhYREE0?=
 =?iso-2022-jp?B?Tk5hVW40SzhqRlgzVzZMTWQzdkZpbE1GRjN3WTllVHB1R09WRTM4aVVp?=
 =?iso-2022-jp?B?SG5tS3hIa3Vqc2QrRVhzSTlpcDdOek96SW1oWTNnNldiZHNXM1g4VWNX?=
 =?iso-2022-jp?B?cUxqekJpOGU4Lyt2bUFQSlJZNVJSQWxVVmRNL0ROdmlUYjNJYm5oVlFy?=
 =?iso-2022-jp?B?d3poRGFSS2NjWCtpWlIwZW1nRndRMkhmL2tscHppempZNTV3dTlEVHdr?=
 =?iso-2022-jp?B?b3RvcnpVTWVHUHhQTm1lWlAyR2NobjMvOExYSENVaVlhMDZ2cklSMUpV?=
 =?iso-2022-jp?B?RUJBYUVDVVpFbVNaY2lqMVI5YnB4cWVyTUhLNkpUSDVrM2xXVGpEbGhs?=
 =?iso-2022-jp?B?L3JJVjVlZlBneHNhRm1qY3FsMHVhcUVnWm84djZoMEpya2ZSdlkzaTBi?=
 =?iso-2022-jp?B?aFlnMnd5NUVhQ1c1MEtleldGdnBFL1JmNEZkakJCSFVOVXZHbHkrc0N1?=
 =?iso-2022-jp?B?dDNaS05uOVIvemdNb0FUYmtjaEhpMHJYUGYzUFhDbE1US1E5ZTZsZ1pI?=
 =?iso-2022-jp?B?RVRvWXczVUxxcWFDcFBmQjFYeDFyQ0JTK3hjdTdmV2pNdjZtS0NYWUxZ?=
 =?iso-2022-jp?B?eXNyV3drR1RROUJ2dlFmYVFYRHpsdFIvMUFRb01JU084ZC84VTA3MVVq?=
 =?iso-2022-jp?B?OVowUStIRlJXd0kxcWt0YmE0TWlHS3BjaU9NT25rMk8vMCtJdjBMQkl5?=
 =?iso-2022-jp?B?eGpZaDRrTStaRU5nWVJBUk10UmIrblRaTHJZU3pCQ29TczlUaDd6RzUx?=
 =?iso-2022-jp?B?WnB0ZEdWTkRLZFRsTFhDQmlmK1Y3NGRYUWhMSWhxNTZMYVpmdkRzOGpn?=
 =?iso-2022-jp?B?NTdjT25oeDFWS3pLd3J5QUs1d0Vub2hsejFua0pGS3pzZXpvZWNPcVdJ?=
 =?iso-2022-jp?B?VXYyMWFHejljSXpYVy9mQUVoTkJocUphN1VLY05MdDZOVlBZWGZDV3lP?=
 =?iso-2022-jp?B?b1JmTXErOVBHeWMzMnBNZVVzM2twVXZkYkZ1cVRvZEhaSFJENEpIS29J?=
 =?iso-2022-jp?B?K2RqS1BUbkZTN0l4dVZoc3IxOEI4Ng==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NHJ5TXJqcEpHenNBTDY5cTg5VzgxN0tZOW9td1J6SW1od2o2ZHRHQmp1?=
 =?iso-2022-jp?B?d1QzdmFaZW42bWg0OGR1UUZYYXFKdXBidWN3RVZjWWhJQzhMTmRhZkdx?=
 =?iso-2022-jp?B?a21JdStNay90dFhJL3Q2OTVScDFocDRyYjZ5T0Foc0x6Njh3TC9hQ0hT?=
 =?iso-2022-jp?B?RXVKaWxyNXE4enNmQ2tFK2tTdG5KM1N0YS9oTHhUSFB0Z0VUUE1iQU5Q?=
 =?iso-2022-jp?B?TjNPQjllN1ZKaFFUeVJOZXhJblJQRmN1dWtKL2NZRXlISnU4emNrTlhR?=
 =?iso-2022-jp?B?dGNuS0huSmxlU3ZsbXhhd2tuNk1HY04yaW5NeG9TYjhYMzdvOTQ2a3Z6?=
 =?iso-2022-jp?B?R0RTU0JucmM0dkhRNCsvenF4ZlVyWVVIVDFDM0RHZXRMZjJvK0h4UURq?=
 =?iso-2022-jp?B?WFV6aThhUU5PWmdBVXRYRHZpZnBGNllFUHZsNHVHbEYwMUhhT04wUXQ0?=
 =?iso-2022-jp?B?cHlnVmlvc0NJRFpYZHJjeXJmcDBRY1JBUWFwL3BzZGVXVm5JYWJRNEVI?=
 =?iso-2022-jp?B?WUhyRzVmRVhTd1creGZpaEtLT2dETlV0KzVrWTgreEJxdzducDE3akRa?=
 =?iso-2022-jp?B?YzNGcjRIa3ZoTHEzYStreVhmemZYR3JwbGt0Yy9WVFRNQWJ4QXJwQ0Vl?=
 =?iso-2022-jp?B?bGhHTkpxcWpUdVJvMlFpVGpXWUR3K1RlTG1XMldoT25IMEM2SXNBVVlQ?=
 =?iso-2022-jp?B?bDJvM3doVytxdkl2aDlHRGpKaVE4M2E4MCsvaTIzR1R2dGhqZ1VFZSta?=
 =?iso-2022-jp?B?Y2xpUTYwaExENkxtK0swMHdsckxXVDQzYXlYZU5LcElpcXNUayszYUxT?=
 =?iso-2022-jp?B?dlVGV056Q0kyTm90OXhBV2dlOUZqYXpWa0xNdHhkZUpublV2K2Fra3dh?=
 =?iso-2022-jp?B?UjkxQVozenZsRFVrNWxkcGRGeGdEeFdTeEMxY1doQXNaUGpSWUUzd0Q4?=
 =?iso-2022-jp?B?WE8zUnlVbFRQMFNaNmtoR0hlSW5zTzlKMXRRYVRCdlh2T2Q2Qmk0NElL?=
 =?iso-2022-jp?B?WFN3S2J1aCs3aXViNzBqNUM1VlNxYVZ1TU5qcUo4enJVZlFqR3gzQXFl?=
 =?iso-2022-jp?B?d0pNYUxDS25WL3Z3SExRQ0VERmw5SzhxS0l2NHhnUUUrSzgyY2srM2dh?=
 =?iso-2022-jp?B?L28rNG0wL1BXVUo1dktVNTQ0NnVYZG5MYU5GYnFoMkdjNlN2V2hEYWoz?=
 =?iso-2022-jp?B?SVZjMDRiK1lpd0J1cFpTUU11Kzd5ZENDOG1lZEJyWUUzZEVjNVVnb29k?=
 =?iso-2022-jp?B?cm9YL2p0MUY5SGxDYUpoWGN6RWxFRkhVOVlkMFloN2VsZU5UVUovSU5B?=
 =?iso-2022-jp?B?K1p3dS83KzdMVXA5QzJMY2ZuMjdPTnhyak55WWtQWHZPc21pRmszemRs?=
 =?iso-2022-jp?B?S1QyNmNDVWpNSkt6UjJQdjVFa05FODZBSVhXQ3NuWit4UGVLYjF2Nlo1?=
 =?iso-2022-jp?B?OElmekc5Zk5DKzNZUVdLZlBQQ0Z5Slpnc3lHQWlVc2tKY0NPSFFjRGpa?=
 =?iso-2022-jp?B?NVdIa0xXdjlnQkkrTXdpY3N2TzhVU3RwbkF5cGY2OTRNTGdBMFV3UTQ2?=
 =?iso-2022-jp?B?bldDK2JsLzNlY0hYME0wazNhT3BvZlZjK3FMcTNGVXlqMCs4MTZGeWJr?=
 =?iso-2022-jp?B?b01hRWkwM2VFaktSZ3NZSjVZZG1KUzNpcGhZc2tGcUpGajZKS25ReHQx?=
 =?iso-2022-jp?B?T2FFaGhMVlhva3hLeThLd3JQcnEwMlpvSEtvU3F0Um5RUVg1bXY4Yjls?=
 =?iso-2022-jp?B?emRmZmhHdTBZb2VRcVVuWUkrZU44allhRnJlQ2REQXBldDBScmR4cU5X?=
 =?iso-2022-jp?B?WXBBSDdaVXZMV25PSVRteUNzR2UxUTc3YzhLNzZvTnBSUTA2ZGdyNXhX?=
 =?iso-2022-jp?B?WldDS0ZLUzhkb0ZaQmhnNmVvZWR1cFdYNDRTZFFraEFRd05hZXFLZ01U?=
 =?iso-2022-jp?B?cVd6MFRLYXo1ZkFVS3hEb0EyMGZLam15MkVFc3FPb3lsUkdWZzJUS2lM?=
 =?iso-2022-jp?B?L2RUWWFqcDN3MVphR3U3Ky9nakFYQW0wbDc0NUhXMVMxUFVIRHBQMEdq?=
 =?iso-2022-jp?B?a2hScjFxY1FOMUpTSnl1b0ZqQndQOFQxQy80dG14QWVOc0JIN0M2VzZj?=
 =?iso-2022-jp?B?Mk9qK2lUMklybUJTTWJIRGQ4M3FXdmlGTnpjbzYvcldRRmtTV2U5OWMy?=
 =?iso-2022-jp?B?VmN6NXBBQzdUZzVhQTBqTktvcFFlenNKR1FXN1ozVXVMazFUUHJlNS9q?=
 =?iso-2022-jp?B?U1Q1alZicnJsaVYvWGFKSUFCTnRMOVFSRWYyUGY0Q1BSUlJKNHlKKzZJ?=
 =?iso-2022-jp?B?LzYyeWpGTExBaVQ3b0lHSVpIVnlRbGVPMGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eda98959-2425-465c-e9d1-08dd54d39ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 13:03:23.2455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pn5y6BUa48b78siV91BKYF/i4M/VFcESOMF6oH8sdiXaw+cq1Abl3jC0VI8h9ohq+sh319BTg80y/l41V68PzNYZ8gytrM8QpRYcnrRZv7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7782
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 13:03:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17896

>On 24.02.25 13:17, Quirin Gylstorff wrote:
>>=20
>>=20
>> On 2/24/25 07:09, Jan Kiszka wrote:
>>> On 21.02.25 13:31, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>=20
>>>>> On Behalf Of Heinisch, Alexander via lists.cip-project.org
>>>>> Sent: Montag, 17. Februar 2025 11:00
>>>>> To: cip-dev@lists.cip-project.org
>>>>> Cc: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>; Gylstorff,=20
>>>>> Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>;=20
>>>>> Heinisch, Alexander (FT RPD CED SES-AT)=20
>>>>> <alexander.heinisch@siemens.com>
>>>>> Subject: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option=20
>>>>> from read-only-rootfs's fstab.
>>>>>
>>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>>
>>>>> Since we only support erofs and squashfs this option is not needed=20
>>>>> any more. Further, it causes potential overlay rootfs variants to=20
>>>>> be remounted read-only.
>>>>>
>>>>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>> ---
>>>>>   classes/read-only-rootfs.bbclass | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-=20
>>>>> rootfs.bbclass index 35a3ab3..83ddc33 100644
>>>>> --- a/classes/read-only-rootfs.bbclass
>>>>> +++ b/classes/read-only-rootfs.bbclass
>>>>> @@ -41,7 +41,7 @@ SQUASHFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS=
}"
>>>>>   image_configure_fstab() {
>>>>>       sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF  # Begin=20
>>>>> /etc/fstab -/dev/root    /        auto        defaults,ro           =
=20
>>>>> 0    0
>>>>> +/dev/root    /        auto        defaults            0    0
>>>>>   LABEL=3Dvar    /var        auto        defaults            0    0
>>>>>   proc        /proc        proc        nosuid,noexec,nodev
>>>>> 0    0
>>>>>   sysfs        /sys        sysfs        nosuid,noexec,nodev
>>>>> 0    0
>>>>> --
>>>>> 2.39.5
>>>>
>>>> We observed `systemd-remount-fs` failing in a downstream layer.
>>>> (using a ro squashfs and apply full disk encryption on top)=20
>>>> Although, the service is executed in isar-cip-core as well,=20
>>>> upstream, the service can be executed successfully.
>>>>
>>>> In essence what happens is that, the `systemd-remount-fs` remounts=20
>>>> various mountpoints based on their settings in `/etc/fstab`
>>>>
>>>> ```
>>>> root@device-mgmt:~# cat /etc/fstab
>>>> # Begin /etc/fstab
>>>> /dev/root    /        auto        defaults            0    0=20
>>>> LABEL=3Dvar    /var        auto        defaults            0    0 proc=
       =20
>>>> /proc        proc        nosuid,noexec,nodev        0    0 sysfs      =
 =20
>>>> /sys        sysfs        nosuid,noexec,nodev        0    0 devpts     =
  =20
>>>> /dev/pts    devpts        gid=3D5,mode=3D620            0    0 tmpfs  =
     =20
>>>> /run        tmpfs
>>>> nodev,nosuid,size=3D500M,mode=3D755    0    0 devtmpfs    /dev       =
=20
>>>> devtmpfs    mode=3D0755,nosuid        0    0 # End /etc/fstab ```
>>>>
>>>> Since `defaults` in fstab renders to:
>>>> `rw,suid,dev,exec,auto,nouser,async`
>>>> the service fails trying to remount the `squashfs` as `rw` as shown
>>>> below:
>>>>
>>>> ```
>>>> root@device-mgmt:~# systemctl status systemd-remount-fs =1B$B!_=1B(B=20
>>>> systemd-remount-fs.service - Remount Root and Kernel File Systems
>>>>       Loaded: loaded=20
>>>> (/lib/systemd/system/systemd-remount-fs.service;
>>>> enabled-ru>
>>>>       Active: failed (Result: exit-code) since Fri 2025-02-21
>>>> 08:55:39 UTC; 5min>
>>>>         Docs: man:systemd-remount-fs.service(8)
>>>>              =20
>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
>>>> w.freedesktop.org%2Fwiki%2FSoftware%2Fsystemd%2F&data=3D05%7C02%7Calex
>>>> ander.heinisch%40siemens.com%7Cde0b4a7d3b494f87bd1a08dd54d0ac65%7C38
>>>> ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638759977392750433%7CUnknow
>>>> n%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJX
>>>> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DX5%2BBYi
>>>> WGiccJJ8qUcawdQ40DExa71H3avr0h15jJaU4%3D&reserved=3D0
>>>> APIFileSystems
>>>>      Process: 7530 ExecStart=3D/lib/systemd/systemd-remount-fs
>>>> (code=3Dexited, statu>
>>>>     Main PID: 7530 (code=3Dexited, status=3D1/FAILURE)
>>>>          CPU: 15ms
>>>> ```
>>>>
>>>> ```
>>>> root@device-mgmt:~# journalctl --no-pager -u systemd-remount-fs Feb=20
>>>> 21 08:55:39 device-mgmt.local systemd[1]: Starting systemd-=20
>>>> remount-fs.service - Remount Root and Kernel File Systems...
>>>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]: mount: /:
>>>> cannot remount /dev/root read-write, is write-protected.
>>>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]:
>>>> dmesg(1) may have more information after failed mount system call.
>>>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7530]: /bin/=20
>>>> mount for / exited with exit status 32.
>>>> Feb 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-
>>>> fs.service: Main process exited, code=3Dexited, status=3D1/FAILURE Feb=
=20
>>>> 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-
>>>> fs.service: Failed with result 'exit-code'.
>>>> Feb 21 08:55:39 device-mgmt.local systemd[1]: Failed to start=20
>>>> systemd-remount-fs.service - Remount Root and Kernel File Systems.
>>>> ```
>>>>
>>>> The rootfs is mounted as follows:
>>>>
>>>> ```
>>>> root@device-mgmt:~# mount | grep " / "
>>>> /dev/mapper/verityroot on / type squashfs=20
>>>> (ro,relatime,errors=3Dcontinue) ```
>>>>
>>>> I understand why this happens on our system, but could not clarify=20
>>>> why it does not happen upstream! So any idea, welcome!
>>>>
>>>
>>> The same issue happens in upstream: secure boot on, data partition
>>> encrypted, remount-fs fails. Which makes me wonder if our boot tests
>>> should check for failing system services...

Such check for failing services definitely makes sense!

The good thing, I could reproduce using the config you described.
The bad news, it still works with a slightly different config.

TLDR:
In the failing setup we use dm-verity and in
the working setup we use the A/B-rootfs.

In both cases the filesystem is a squashfs=20
(once mounted directly and once via dm-verity mapping)
Thus, in both cases it cannot be mounted rw.
Options used to remount are similar.


Details:

In my isar-cip-core setup this does not happen!

I did a clean build using ./kas-container build using following config:

```
$ cat .config.yaml
#
# Automatically generated by kas 4.7
#
_source_dir: /repo
build_system: isar
header:
  includes:
  - kas-cip.yml
  - kas/board/qemu-amd64.yml
  - kas/opt/6.1.yml
  - kas/opt/bookworm.yml
  - kas/opt/expand-on-first-boot.yml
  - kas/opt/ebg-swu.yml
  - kas/opt/encrypt-data.yml
  - kas/opt/encrypt-all.yml
  version: 18
local_conf_header:
  __menu_config_vars: WDOG_TIMEOUT =3D "60"
menu_configuration:
  DEBIAN_BOOKWORM: true
  DEBIAN_BULLSEYE: false
  DEBIAN_BUSTER: false
  DEBIAN_TRIXIE: false
  EXPAND_ON_FIRST_BOOT: true
  IMAGE_COMPLETE_SWUPDATE: true
  IMAGE_DATA_ENCRYPTION: true
  IMAGE_DELTA_SWUPDATE: false
  IMAGE_FULL_ENCRYPTION: true
  IMAGE_RO_ROOTFS_EROFS: false
  IMAGE_RO_ROOTFS_SQUASHFS: true
  IMAGE_SECURE_BOOT: false
  IMAGE_SECURITY: false
  IMAGE_SWUPDATE: true
  IMAGE_TESTING: false
  KERNEL_4_19: false
  KERNEL_4_4: false
  KERNEL_5_10: false
  KERNEL_6_1: true
  KERNEL_RT: false
  TARGET_BBB: false
  TARGET_HIHOPE_RZG2M: false
  TARGET_IWG20D: false
  TARGET_QEMU_AMD64: true
  TARGET_QEMU_ARM: false
  TARGET_QEMU_ARM64: false
  TARGET_QEMU_RISCV64: false
  TARGET_X86_UEFI: false
  WDOG_TIMEOUT: 60
```

VM Setup: `./start-qemu.sh`

During bootup:
```
...
[  441.107438] systemd[1]: Finished systemd-remount-fs.service - Remount Ro=
ot and Kernel File Systems.
[  OK  ] Finished systemd-remount-f=1B$B!D=1B(Bount Root and Kernel File Sy=
stems.
...
```

```
# systemctl list-units --failed
  UNIT LOAD ACTIVE SUB DESCRIPTION
0 loaded units listed.

# systemctl status systemd-remount-fs
=1B$B!|=1B(B systemd-remount-fs.service - Remount Root and Kernel File Syst=
ems
     Loaded: loaded (/lib/systemd/system/systemd-remount-fs.service; enable=
d-runtime; preset: enabled)
     Active: active (exited) since Mon 2025-02-24 10:16:29 UTC; 3min 5s ago
       Docs: man:systemd-remount-fs.service(8)
             https://www.freedesktop.org/wiki/Software/systemd/APIFileSyste=
ms
    Process: 472 ExecStart=3D/lib/systemd/systemd-remount-fs (code=3Dexited=
, status=3D0/SUCCESS)
   Main PID: 472 (code=3Dexited, status=3D0/SUCCESS)
        CPU: 868ms
```

```
# cat /etc/fstab=20
# Begin /etc/fstab
/dev/root	/		auto		defaults			0	0
LABEL=3Dvar	/var		auto		defaults			0	0
proc		/proc		proc		nosuid,noexec,nodev		0	0
sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
devpts		/dev/pts	devpts		gid=3D5,mode=3D620			0	0
tmpfs		/run		tmpfs		nodev,nosuid,size=3D500M,mode=3D755	0	0
devtmpfs	/dev		devtmpfs	mode=3D0755,nosuid		0	0
# End /etc/fstab
```

```
# mount | grep " / "
/dev/mapper/fedcba98-7654-3210-cafe-5e0710000001 on / type squashfs (ro,rel=
atime,errors=3Dcontinue)
```

-------------
-------------
-------------

But I can confirm in a setup like you mentioned it is reproducible (for a r=
easons
I don't understand yet):

```
$ cat .config.yaml
#
# Automatically generated by kas 4.7
#
_source_dir: /repo
build_system: isar
header:
  includes:
  - kas-cip.yml
  - kas/board/qemu-amd64.yml
  - kas/opt/6.1.yml
  - kas/opt/bookworm.yml
  - kas/opt/expand-on-first-boot.yml
  - kas/opt/ebg-secure-boot-snakeoil.yml
  - kas/opt/encrypt-data.yml
  - kas/opt/encrypt-all.yml
  version: 18
local_conf_header:
  __menu_config_vars: WDOG_TIMEOUT =3D "60"
menu_configuration:
  DEBIAN_BOOKWORM: true
  DEBIAN_BULLSEYE: false
  DEBIAN_BUSTER: false
  DEBIAN_TRIXIE: false
  EXPAND_ON_FIRST_BOOT: true
  IMAGE_COMPLETE_SWUPDATE: true
  IMAGE_DATA_ENCRYPTION: true
  IMAGE_DELTA_SWUPDATE: false
  IMAGE_FULL_ENCRYPTION: true
  IMAGE_RO_ROOTFS_EROFS: false
  IMAGE_RO_ROOTFS_SQUASHFS: true
  IMAGE_SECURE_BOOT: true
  IMAGE_SECURITY: false
  IMAGE_SWUPDATE: true
  IMAGE_TESTING: false
  KERNEL_4_19: false
  KERNEL_4_4: false
  KERNEL_5_10: false
  KERNEL_6_1: true
  KERNEL_RT: false
  TARGET_BBB: false
  TARGET_HIHOPE_RZG2M: false
  TARGET_IWG20D: false
  TARGET_QEMU_AMD64: true
  TARGET_QEMU_ARM: false
  TARGET_QEMU_ARM64: false
  TARGET_QEMU_RISCV64: false
  TARGET_X86_UEFI: false
  WDOG_TIMEOUT: 60
```

```
[FAILED] Failed to start systemd-re=1B$B!D=1B(Bount Root and Kernel File Sy=
stems.
See 'systemctl status systemd-remount-fs.service' for details.
```

```
# systemctl list-units --failed
  UNIT                       LOAD   ACTIVE SUB    DESCRIPTION              =
          =20
=1B$B!|=1B(B systemd-remount-fs.service loaded failed failed Remount Root a=
nd Kernel File Systems

LOAD   =3D Reflects whether the unit definition was properly loaded.
ACTIVE =3D The high-level unit activation state, i.e. generalization of SUB=
.
SUB    =3D The low-level unit activation state, values depend on unit type.
1 loaded units listed.
```

```
# systemctl status systemd-remount-fs
=1B$B!_=1B(B systemd-remount-fs.service - Remount Root and Kernel File Syst=
ems
     Loaded: loaded (/lib/systemd/system/systemd-remount-fs.service; enable=
d-runtime; preset: enabled)
     Active: failed (Result: exit-code) since Mon 2025-02-24 11:47:05 UTC; =
1min 35s ago
       Docs: man:systemd-remount-fs.service(8)
             https://www.freedesktop.org/wiki/Software/systemd/APIFileSyste=
ms
    Process: 2665 ExecStart=3D/lib/systemd/systemd-remount-fs (code=3Dexite=
d, status=3D1/FAILURE)
   Main PID: 2665 (code=3Dexited, status=3D1/FAILURE)
        CPU: 794ms

Feb 24 11:47:05 demo systemd-remount-fs[2665]: /bin/mount for / exited with=
 exit status 32.
Feb 24 11:47:05 demo systemd-remount-fs[2668]: mount: /: cannot remount /de=
v/root read-write, is write-protected.
Feb 24 11:47:05 demo systemd-remount-fs[2668]:        dmesg(1) may have mor=
e information after failed mount system call.
Feb 24 11:47:05 demo systemd[1]: systemd-remount-fs.service: Main process e=
xited, code=3Dexited, status=3D1/FAILURE
Feb 24 11:47:05 demo systemd[1]: systemd-remount-fs.service: Failed with re=
sult 'exit-code'.
Feb 24 11:47:05 demo systemd[1]: Failed to start systemd-remount-fs.service=
 - Remount Root and Kernel File Systems.
Notice: journal has been rotated since unit was started, output may be inco=
mplete.

# journalctl -u systemd-remount-fs
Feb 24 11:47:05 demo systemd-remount-fs[2665]: /bin/mount for / exited with=
 exit status 32.
Feb 24 11:47:05 demo systemd-remount-fs[2668]: mount: /: cannot remount /de=
v/root read-write, is write-protected.
Feb 24 11:47:05 demo systemd-remount-fs[2668]:        dmesg(1) may have mor=
e information after failed mount system call.
Feb 24 11:47:05 demo systemd[1]: systemd-remount-fs.service: Main process e=
xited, code=3Dexited, status=3D1/FAILURE
Feb 24 11:47:05 demo systemd[1]: systemd-remount-fs.service: Failed with re=
sult 'exit-code'.
Feb 24 11:47:05 demo systemd[1]: Failed to start systemd-remount-fs.service=
 - Remount Root and Kernel File Systems.
```

```
# cat /etc/fstab=20
# Begin /etc/fstab
/dev/root	/		auto		defaults			0	0
LABEL=3Dvar	/var		auto		defaults			0	0
proc		/proc		proc		nosuid,noexec,nodev		0	0
sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
devpts		/dev/pts	devpts		gid=3D5,mode=3D620			0	0
tmpfs		/run		tmpfs		nodev,nosuid,size=3D500M,mode=3D755	0	0
devtmpfs	/dev		devtmpfs	mode=3D0755,nosuid		0	0
# End /etc/fstab
```

```
# mount | grep " / "
/dev/mapper/verityroot on / type squashfs (ro,relatime,errors=3Dcontinue)
```

>>>
>>>> Nevertheless, after rethinking this patch. Maybe it was advisible to
>>>> not use
>>>> `default` here and either use a options like
>>>> `suid,dev,exec,auto,nouser,async`
>>>> or drop the line for `/dev/root` at all, keeping the mounts as they
>>>> were setup
>>>> in the initramfs.
>>>>
>>>> Any opinions, recommendations, hints, ...?
>>>>
>>>
>>> According to the man pages, a left-out rw/ro means that mount will firs=
t
>>> try rw and then, if it fails, ro. That would give us the desired
>>> flexibility. Hard-coding the other values of "defaults" is the downside=
.
>>>
>> Will no also lead to error of systemd-remount?
>>=20
>
>It does not help, yes, just tried in vain.
>


From: https://man7.org/linux/man-pages/man8/mount.8.html
```
 Note that the real set of all default mount options depends on
           the kernel and filesystem type. See the beginning of this
           section for more details.
```

So having "defaults" kind of depends on multiple factors, so it seems to be
a better fit to specify the options we actually want leaving out the ro and=
 rw parts,
so fallback-behaviour as described above applies.


>>> On the other hand, what would be the mount options that the initramfs
>>> will use? We do not have direct control over them as well, do we?
>>=20
>> The initramfs in standard Debian contains the fstab - so it would/could
>> use the options from there.
>>>
>>> Quirin, other reasons why we want / in our fstab?
>>=20
>> The fstab of the readonly rootfs is an evolution of the original fstab
>> from ISAR. It is also there as we disabled the fstab generation from
>> wic.
>>=20
>>>
>>> Another option: "ro" a parameter of read-only-rootfs.bbclass so that
>>> your scenario can override the default.
>>=20
>> I would make it to option for all the fstab options.
>>=20
>
>Ok, let's go for some config variable then.

Would not like to set another option for something which is obvious by the =
filessystem type already.

Short term: Since fstab has no real use in most of the configurations=20
(except for mounting `/var` when using unencrypted data partitions)
I'd simply drop the `/` entry in fstab.

But before, I would like to understand, why this happens at all!



---
Offtopic: Long term we should reconsolidate usage of fstab / cryptab, but p=
robably that
goes along with a broader discussion on systemd based initramfs hooks / dra=
cut / ...:
For fstab there are primarily 2 options,
1.) rely on fstab, then we or some (systemd) generator tool should put ever=
ything=20
    we mount in fstab (incl. encryption setup via `/etc/crypttab`) or=20
2.) not rely on fstab at all, thus dropping the `/` entry and probably also
    put `/var` for unencrypted setups to initramfs (also with focus for A/B=
=20
	data partitions).
---

>
>Jan
>
>--=20
>Siemens AG, Foundational Technologies
>Linux Expert Center

Sry for the long post,

BR Alexander

