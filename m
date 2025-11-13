Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DEBCD5BA5
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 09:04:17 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19660.1763024646726929536
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 01:04:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=SnV4ypZz;
 spf=pass (domain: renesas.com, ip: 52.101.229.27, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBeXm5uRIg2Hycc/L34NZVFXlw6iw3FldSJMjVf+o/MC2WLhcrFsWhso4MhOmfcGt5OEPvUjiTcNFjP9VF7akoykKP5Twft46uO9kj6BYcZCpr5hLCIBmJAzvLBeNirYsJUrwJtOSCmKR6n2zXpndVBZBQdBELcZZTz7sYcYsLOS4dCqE44fAFM/DIcUM8XYY2XdaBOwsfHuh1ORMkT5zcJkJN8NX1R3TzS6k00w5IM50YfQLG/AlfJQe3vJyYegolwqFVjfVLynHG7lq8u8LMGjhmpfOqbZ9juQw1t8Exf7wpLxmCNRL45OyN24o5tKqtki+9/aeosxPy43HI5w0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad0pJmbh4rI51r6e1VKPi88nZNjhuG96U5+XqjcCitw=;
 b=HkpwCQFIsj18k7PYbDKT6HlmQfH9Xh/ThZN23NMAWZoYJrZ16VorNi2Xy3Tn2Bh0DguEO2DxSLJIA5lqrnsreUrWpyAVPP0V4bjZISp50+UM0GrR35dNmzWX1A/402cVPw/c2+gTlsTvGHUXJxABPcRmGeZS2QXQ1ihSxwm6/SXrzU1xXqiUGxslkerTiU86wda69iyahiJ4YRn7TqjG7tbE3RXEGPul/t4rfVDo+rEg1LMp/mSSfeiHMjCfs7/+QHTDYh0ozw0ehWXYmabPkELoddhwx9cgeR/d+jRFpXAaE4UXOeileJ7a3pXWbKlx3/lGdlyAdG5Taq3gIfj3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad0pJmbh4rI51r6e1VKPi88nZNjhuG96U5+XqjcCitw=;
 b=SnV4ypZzLLH6uC754q7T6hJjffTakEyDTW4/JkPRRrb+ZuA9ag8jZiGD38QG2eD3cCh/oDvgwZ509J7RxkeMrCAgvTZjSYyyAbPFV98t9aeOLQjJ4ZTRMnYK1Rotv8lpIT7rCcL5APxTSAo7bcWljjNoWMFwsMiVEfP+SmQKDms=
Received: from TY7PR01MB14910.jpnprd01.prod.outlook.com
 (2603:1096:405:253::12) by TYVPR01MB10877.jpnprd01.prod.outlook.com
 (2603:1096:400:299::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:04:02 +0000
Received: from TY7PR01MB14910.jpnprd01.prod.outlook.com
 ([fe80::c78:8e4f:a976:9941]) by TY7PR01MB14910.jpnprd01.prod.outlook.com
 ([fe80::c78:8e4f:a976:9941%2]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:04:01 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
Thread-Topic: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
Thread-Index: AQHcSXohAN8na7gZ1UiuF/m8YRQGZbTbeywwgBTkMcA=
Date: Thu, 13 Nov 2025 09:04:01 +0000
Message-ID: 
 <TY7PR01MB14910BC4525FB7ADD0057D7B2D3CDA@TY7PR01MB14910.jpnprd01.prod.outlook.com>
References: <20251030084927.47505-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB148188796779012A1BC1EDA69CDF8A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148188796779012A1BC1EDA69CDF8A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14910:EE_|TYVPR01MB10877:EE_
x-ms-office365-filtering-correlation-id: 8d25f00b-f478-4e25-75fb-08de229396bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?N3JSeXZwY1hRMEdGS21OVlFNZy93OHRDR01HRENWM05pTGVOTkFDaHRv?=
 =?iso-2022-jp?B?NEFicC8yVjJGcUQrZnBaRGFNMlVyczh6TDYwWkVtcng4SCtSZjZCd2Fi?=
 =?iso-2022-jp?B?YVozb3V3NFNxczRZTkRtT3hiU015cEhJVEFlNTZMZ1JHZjJGUHp6YUJD?=
 =?iso-2022-jp?B?bkVNVWNJVjNhZHBPQUxJVDM0RzdLaUJZNitxaDBDcmhoTlVaY1F5ZE9H?=
 =?iso-2022-jp?B?Q3Bmc092bzNtT0NhWjFFZUU4YmxtYnJFMUFZUWRmb2txS3k1bkViOEpu?=
 =?iso-2022-jp?B?Y2NnbFZZU0EySUZIUlhCVlVYKys2K1RIMjgwam1RL3pLSEpOUFcycWs2?=
 =?iso-2022-jp?B?dkgxUDN6V1RQTUNqM0JMTXRLTk1rQUxOL0V2Vlh1YWFxcUhHcjVZOTdX?=
 =?iso-2022-jp?B?aEtERkR0NXpPc05sV1BFaEJqeFM0WTRqN2RiRGVoWmc3ZEtoYWhsajk4?=
 =?iso-2022-jp?B?Y0t4OGtGODluc1lsSWwrd3BsMGR0ZzZlWTdrSHBPZEZDcUdNKysxTmVE?=
 =?iso-2022-jp?B?cFdOd1pnTW4yZU41dXoyYzNvRUE5VTdvazlLdWU1bk1WZ28yUXBnZk1B?=
 =?iso-2022-jp?B?c09GanZ5dDB6TmlFTGZBZWNRR0pEUm5OTzBheUsyYnlkS2JKWm56RC95?=
 =?iso-2022-jp?B?QkYrTURtU1lqWWFOQ2g2bzdlT2NSSTlrLytIbjJJemFxM1lWQ0I4Tjln?=
 =?iso-2022-jp?B?WHFMM1hwd2p2ZzZ4NklySGhpSUFGai91eStQMTRnSnZZVnNkK2lZSllW?=
 =?iso-2022-jp?B?ZkMvdVNKMHRBL2I1TUJNNzNQaFBIbFNVbUFNUllIa3g2VVZ2UTNpdGNZ?=
 =?iso-2022-jp?B?dUtuQjNIZHRXcTZPYkZWSFVKdG5tUXpuNDhvRDRFYkJYL2VsN3hpQXFT?=
 =?iso-2022-jp?B?WENwQ1B3UUFodjdaR0xlbXdDaUhZaDdOTnE1L29MSkFTSVJvT1dMcmdU?=
 =?iso-2022-jp?B?ZGh3Zm9yUVo0aGd2NWExbXZ4SGFMdE1mTW9OSlBHWTlVNmFYTXV3VTlI?=
 =?iso-2022-jp?B?M21UcGZBa291TTFQNStsQzZKUE1EVi9kQTlERFdBM2dvYkN0ZjlOV2dD?=
 =?iso-2022-jp?B?YjRTOGRIUVZnM0pKNnlHVzBIbUg1eU5IWEdJalRYV1VPbkw2UzR2RzlM?=
 =?iso-2022-jp?B?OTJlOHR1NnZzbGZzMnVwUExkOEVlK25BcUwrSExnQnJDZ0tuSWMxa1FT?=
 =?iso-2022-jp?B?M0o5bnYydVNHYWpXQ3p1bUc0cmdPTkFqRDZjeUlmYnI3UVBwc2pCZG9J?=
 =?iso-2022-jp?B?THhhZUtKMytydS83bDFOalpQK0hNSnhWN0h2YW40R0JDK05XNUdHeDY5?=
 =?iso-2022-jp?B?ZjJHdUFPa1pDNnlGQU05NkxlUVZYZys4M3FObko2QnlQTUxRTVpsUFVX?=
 =?iso-2022-jp?B?Z2xaSk12dnBBSkdiNTBMb2xuUnk4anNTaVkyeFRzVWxNVTJ0Tkp4eWpN?=
 =?iso-2022-jp?B?c08za1ZURkw4YUhiWEczcTRMOTFmc2UyWHoydXBiWmlPcnpJUU9JSEZB?=
 =?iso-2022-jp?B?Z1YyeXZkdlEzTlRHT3hQS1VjZnB1SGkwSHRYL1Zxd1ZnOWVXOU5vT1F4?=
 =?iso-2022-jp?B?SWZTaFlzb1gySk0xZHBqUW1FSE4zWndQYU12WXk4VHRoL3NrMHR5OEEy?=
 =?iso-2022-jp?B?Wnp0QmhGOW41c043aHpvYUxSVHI2NnFUclByaFJnZEoxaFVtZWlIS1Nj?=
 =?iso-2022-jp?B?Uzg3WXk1Zkovb09lSHlNSzh6cEdkVk9aWlJza2ZrYzk4Q29MUHNvT1RY?=
 =?iso-2022-jp?B?US9qTmdZK1JmdENXYVVWYmttb0pDZU5EajhyK1RKZEVQK3IyVlQyaTh5?=
 =?iso-2022-jp?B?QTAxVy95Skt0Z05Hc3IwdWNId21PODVGcDljN1BIOWkxODYrQTFOakxS?=
 =?iso-2022-jp?B?eDJnSXFhWDhlUSs0blRiM2JsOXhkbDhvMGo3d1JTa3BrUG4xTlYxWlFH?=
 =?iso-2022-jp?B?TGdsU2F4QWpoUHppSnpKd1dWekdEQXVVRHZCRHJCWk00cENWUVBDZ3Zs?=
 =?iso-2022-jp?B?c0ZTWlNjWE51TzlCVXltV2cxQWtDd0gxZzlkaXM0UGt6emtnZGhCUUpO?=
 =?iso-2022-jp?B?QlVCdDRHWDdsWjF6c0FnMHFqVjhoa1VrZmpMMU1FRGw0a1I5ZzJnb0U3?=
 =?iso-2022-jp?B?d1M4SVZ3TlJaYzlEK2tHM0JmNTBVbm9nPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14910.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UFRiRENWUUtvRXo1RjJCSTNlbEVuZ3BFTEpRbnh5MkozMnlLM3kyaFQw?=
 =?iso-2022-jp?B?UUVydHh3YVFiYzZUbEh4Zm5zaE5abU96U3cycUJ4WG5aTk44Q1VpVHRP?=
 =?iso-2022-jp?B?NGRtMjJBSGQzbjhReU0zK0lZbU83dlZrandXRlA1MnVqeFFTUUJ4aTkz?=
 =?iso-2022-jp?B?dEY3cVpaNThsdWNIaDN1V3pVNzE2am85aEtUWUd3YncwMTBONGt0aDA1?=
 =?iso-2022-jp?B?QXV6NitWZHhZcUoyVi9FQitHOU8wdU5LSlFrQWlDc0E0VlppUEwrSkto?=
 =?iso-2022-jp?B?ZFhYUmVHWkdYWHdNN0VnWnhpNlU0N1BzbmJvRk1RaVRxZUJiUW4zbmdC?=
 =?iso-2022-jp?B?QlhJZ1k2R2dPZUF6a1RmTnh0MnM1cHZpQnlKQjBYUmtycy9FUWIrdHhG?=
 =?iso-2022-jp?B?MHo4WnV0c0dIYzFjQnRpSGlpc2pmTU02Mlp1YitZV3JmZWdSZGoyWHBs?=
 =?iso-2022-jp?B?enhCL1hVeGZIRUdCcGRIdGp5a0hpdXZoK0NocXZBdnd4YlZlVE1JTFY4?=
 =?iso-2022-jp?B?azdvUXEvVzZ3d3QydHFyYzBhVzFXWnlpYzhjcllTQjVhTEVLbkhPWVJX?=
 =?iso-2022-jp?B?dEd3ZThPelRMRGpLYW5XZU9ob2pBdy9ZTnowUEliY3ZqL3grQ081b1dE?=
 =?iso-2022-jp?B?UFJNTzljQ1kyby8xbjZKRWZoWDcxdnNZdXhkS2hQSUhBN1NMWXlnRmgz?=
 =?iso-2022-jp?B?VTlreEV5TXp4dzNQd2xyaE1JcCtlOVROc1F3M1hsb2JDeStRMTUxTUtC?=
 =?iso-2022-jp?B?cXFKUHdIU1B5Q1djNHJsTjNTNnZJY0F4cFA1RG9MT2NxSUlkTFZrNFl3?=
 =?iso-2022-jp?B?OWlhd09aWnM3K3c5aVhaYVdtU1c3Y1FPeHJEWkcweGtVeWY5ZFo5VXRE?=
 =?iso-2022-jp?B?T3BLajkvcGhRYU1SRVpGYmRqMVgzNktpbXFvOWpsK2J1OHZpNWlCUGNE?=
 =?iso-2022-jp?B?MHB0Tnprd3BQb0Q4cytJZUYvZzdzYXZNMUtFeHJWcW5JK3dxakhBbDdJ?=
 =?iso-2022-jp?B?cHRWcWwyVFhYUXBmMnM3cFRHVjh3OG1TeVdnK0JNV3RZdElWWGMxTDhR?=
 =?iso-2022-jp?B?SnVXbkxwbW1HTkd5anNsSDZEaFdWei9xRERpbWNhZWM3bERqMWRCcTFL?=
 =?iso-2022-jp?B?TVpMeXNNb0lZYndYbFViR0VnYS9CdElCOHlwbGc2c0FMR1dqZHRBdjhu?=
 =?iso-2022-jp?B?akNZVkVUMndtbWMxYWRURmV4ZUNpZDY5U2ZlVHJVSzN6Tis5SlVtbEl3?=
 =?iso-2022-jp?B?aVVuWGF4Lzhib3V1MTcrekR0V0lZRHFGRGFqYjltMjJISDBseWh5QW91?=
 =?iso-2022-jp?B?SThYTUJ4bnZwR0dqbHN0RERnTTNoaXJPR0RQc2F0cVZGc21JUWJkTk9m?=
 =?iso-2022-jp?B?R0JPbS9HcytFeDRpenliQ3NkWU9MTXJLWG91OWJRWlFFNDFZQUtsbFRV?=
 =?iso-2022-jp?B?c1hiNzRUREVhYURONUtzREwzbXpSSDhPNG4vUTlWTUpLY0lNR3dMbmd0?=
 =?iso-2022-jp?B?R3ZraVIxb0hYV2ZhNzlxK08ySkNnTFd4aGpZOVJJWGFGbEtoVUxmNXZG?=
 =?iso-2022-jp?B?T0RYVXc3Y0JWUkRMVDB5Q2JwYmo5d3ZVbk5pc0U0WEdGcE1nbW4zaHpJ?=
 =?iso-2022-jp?B?ZG42MDJQSnlUbVVsbXl2V3pvcXpOazNMNm8ySk1Ec2VpNlAyWGFJN284?=
 =?iso-2022-jp?B?SE5WSU1sckxPa2pwSXduQnZqVFpiYm5BcFo5TUZESi81TVJvclpkZkRs?=
 =?iso-2022-jp?B?SDVHaTZSeklENmY2eWNPcTVKa0U4TTJqTXJWUm8xZlFBMHZHNUdNU3M1?=
 =?iso-2022-jp?B?QmQ1L3Vkb3JDOW9Nbkd1bWdkdE13SDhWVW1UUTVOSVhta29XUFpsQ3lS?=
 =?iso-2022-jp?B?RGpoRmtaeDhDaE5IVysyQk4wS2NWc1hlUTA2Mi8zS0dLM1c4c2c0a3E4?=
 =?iso-2022-jp?B?Kzl3b3lpMzliUm44U0J3ei8zUTNLNFM5b3BUTXdtRzl6V25YQVdKVGta?=
 =?iso-2022-jp?B?M3dkTitpNk83Y3dIVmt1UjI2dEVTdFJleEdKZjRpaTl5Ris5YU1VS2xL?=
 =?iso-2022-jp?B?Y0dZWUt5dllMYTdRZ1FreFkxNzZNTDVNUXIwM012djl6eEdBdFd2alVv?=
 =?iso-2022-jp?B?c0VIS1Y5Z1ZxeWhzZlYzN2EvaUpQVlB2bnlldlFaTzl1RnB0cmNLQzBR?=
 =?iso-2022-jp?B?U1lZODRGRnZvdTB3Y2xTRTM0clZHRkd6YWFkeWJuSDJvdVpDWStnMzNS?=
 =?iso-2022-jp?B?cXJoL2xKQkgyZ215cmkzWTB3OU93TkNmRWxCTzArdndzTm8ybW5lZTU3?=
 =?iso-2022-jp?B?OWFKVU1nR3VORmE3NVh0d1JYN084NDNuL2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14910.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d25f00b-f478-4e25-75fb-08de229396bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 09:04:01.7325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LS7YJx5PD8RISIRs+4WqCpcxggKa9QqEMqJzKCJpwYz1JDkkjSlazH9MScu+J5RXpxJ/hlrV0+CoDVbbhtHesfTZrpyHwprps2c3VtmWrLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10877
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 09:04:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20519

Hi,

> -----Original Message-----
> From: nobuhiro.iwamatsu.x90@mail.toshiba
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Sent: Friday, October 31, 2025 3:39 AM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>; cip-dev@lists.cip-
> project.org; pavel@denx.de
> Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> > Sent: Thursday, October 30, 2025 5:49 PM
> > To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B=
$B4d>>=1B(B
> =1B$B?.=1B(B
> > =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.=
toshiba>
> > Subject: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
> >
> > Hi,
> >
> > This series adds the ICU dts node for the Renesas RZ/V2H SoC, to the
> > linux-6.12.y-cip kernel.
> >
> > The ICU driver and its dependencies are already present in the 6.12.y-
> cip
> > branch, having been included earlier as part of the RZ/G3E backporting
> work.
> >
> > For reference, see the related commits:
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/commit/?h
> > =3Dlinux-6.12.y-cip&id=3D3d3a549e2fb073619507de56be14aab242f87b7b
> > [2]
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/commit/?h
> > =3Dlinux-6.12.y-cip&id=3Dae9102da607f85ba0831c6b5af0c0d52d5166f7d
> > [3]
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/commit/?h
> > =3Dlinux-6.12.y-cip&id=3D69c328745d39318be83b84a7f379009cc574d072
> > [4]
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/commit/?h
> > =3Dlinux-6.12.y-cip&id=3D9fc198d9b2c292fb089eaaa2a5b679b24d26f072
> > [5]
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/commit/?h
> > =3Dlinux-6.12.y-cip&id=3D2e7375bcebd154ccf175eed1982d11b8b3c4cb8a
> > [6]
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/commit/?h
> > =3Dlinux-6.12.y-cip&id=3D1fe131fc74f7fa9d0753fbfb7dbb92483a10ba01
> >
> > The patch was cherry-picked from mainline kernel.
> >
> > Best regards,
> > Ovidiu
> >
> > Fabrizio Castro (1):
> >   arm64: dts: renesas: r9a09g057: Add ICU node
> >
> >  arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 90
> > ++++++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> >
>=20
> Thanks for your patch.
> Looks good to me. I can apply this patch if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20

I noticed that a new 6.12 release was published (v6.12.57-cip12). Looks
like this patch wasn't included in the release, whereas the RZ/V2H
Ethernet series [1], which was sent later, was.

Same for 6.1.

Just wanted to check whether this patch might have slipped through the
cracks. If there is anything needed from my side, please let me know.

[1] https://lore.kernel.org/all/20251106104024.28947-1-ovidiu.panait.rb@ren=
esas.com/

Thanks!
Ovidiu

> Best regards,
>   Nobuhiro


