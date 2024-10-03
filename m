Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ECFCF855A
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 06:16:01 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.25])
 by mx.groups.io with SMTP id smtpd.web11.5266.1727936156779946239
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 23:15:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=NqG5RLQR;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.25, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLr70kWBp1fyb/jKCZ7+B4M5J8il4sPDwMA2gKbUD3NHm9PP3yvbSwOeVXtYwKCC+EtfiTkb8F25IvE1Rut0c+ha1RtGt0JIQSLRfvrhCC9H0LmsOhkEtIJICyaWW5nW/MrIGBblH/1O4GIr+ZSeW7brROzuBH14UjyyB4NxYEA6TS0nCQvighfX/MxFtq8UTmAP/hO0rjvaFisEhaaiZ01UPFMh+hOQQ7C1GjNXENYuPwg8WFdKdMFKqlfitBvnSfSp4fAVMZEUzCoctQvaOcrmxid5PQcJWcS7EJNB+VXrbpnIT9mebJy0gNKaKzweTlvSUIFSMsU7CKZLsxitUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKVH0NP3DrtzrzzfSUewHmXHNtBTw4YX3ZsXwPcRCYM=;
 b=S1nw3Z33dmgqUXQRLggrpX9Di8awqlmONO5roq2QWWeF1+IMMEAsTL+wqJpFQ1KXswvmXp91qUOvWdhkLVy9ppiKoeoX/gx3qDwNG+fgrxwU7By/n1uOigxd9lLNdexvMk1bGPDuz5lr0IEqMYHDRiPytNbdtuLpz69VwOHcdKurds8EF4VcsgPDUHGsPYjwnj0kV3BZi1wkUIHydLdKBXRCp/vi+37b7bJs/dHKHsl7lXG0dVWbEKVcj+6ulvdAnit2OgtK4pPrksq3fORLqb94nfKJhqN/J1dUYhYOS+1BAADOHZ+33tMy2MiLSRYXHZDqO66j1UF6JhvURmq2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKVH0NP3DrtzrzzfSUewHmXHNtBTw4YX3ZsXwPcRCYM=;
 b=NqG5RLQRr8JE6dKDIN2QC/WVCjNfvtYHVxQexJXrj9UgT6EJ3w1RNUc61G3UyJpYHvHKn26X0JE1Q4MOv6JevE8MNTI+MDl8St/PiQ+uZMF6F+G1XLzhDCAh6u1DTxermBqStmhqwwT2Tnary7lM/vlwigy2C8egydcYMv69fGU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB8461.jpnprd01.prod.outlook.com (2603:1096:400:176::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 06:15:52 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 06:15:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 02/16] pinctrl: renesas: rzg2l: Use
 dev_err_probe()
Thread-Topic: [PATCH 6.1.y-cip 02/16] pinctrl: renesas: rzg2l: Use
 dev_err_probe()
Thread-Index: AQHbFO0oFhZ4e4Daa0moi4dWCw9YgbJ0fs8QgAAON8A=
Date: Thu, 3 Oct 2024 06:15:48 +0000
Message-ID: 
 <TY3PR01MB11346B82A77D4896757114AD486712@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
 <20241002170417.655339-3-biju.das.jz@bp.renesas.com>
 <OS0PR01MB63884F86BC0E7A6D2E3F980092712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB63884F86BC0E7A6D2E3F980092712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB8461:EE_
x-ms-office365-filtering-correlation-id: fe230340-a9c0-4cec-abee-08dce372d345
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZmdGMmJsRWtDRWk1bndleUlzV2dEMEZCWXVDSitVYm4vSmlnY0dyWTl5?=
 =?iso-2022-jp?B?MW1MUVF6THdFbVM4VytwMTVYRGhCZWlHamhvNHpaSFgrM0c5ZndNMDBu?=
 =?iso-2022-jp?B?S1laWHFTbzBtbzVndjcvRCtxZEYvVmhpY2M1L1RqRWc4ZG9yWWlIa1FK?=
 =?iso-2022-jp?B?aUhNNkZ6b0JtSUtuM2kvc2cvQi9UQkNaeHI0K2dyUzZ4ODM1bitkVTFO?=
 =?iso-2022-jp?B?dDRERTdpSEo3TzNjN1BZWlppYmpCWXJKNS9MQ0I1cTR3VGFoSmFuanB5?=
 =?iso-2022-jp?B?YklSOVZ5cExCcHhVWGdabC9Ja1B4U0xjNzVva3VibDF5cmJkVWxpcFBZ?=
 =?iso-2022-jp?B?dTY0bmdTb0xpTU5LNU9ZV0d3bllRa1dobXE4NGhhZk85UWEwNjVvRjR2?=
 =?iso-2022-jp?B?WnZWdjRmMXZMaVRpUDhoNFRmT0dFQTVyRHoxelhIamxtMkhSWmxQNDBW?=
 =?iso-2022-jp?B?SStsMGl0R1FDS00ybE1RRmRYMlZwV3hTOTVOZjRLUTQ4b2hUOThrUW9E?=
 =?iso-2022-jp?B?VWQ4OFhOU2tIMFk5cndUdUlJYjRaUitHeFlaYzNuY2ZNYitzN3M3azJj?=
 =?iso-2022-jp?B?ZXR0RDNUYkZ5ZUp3SGd6ZWlhVmhwTjBXbFVTbGM1eGFhK0xtL2ZUZ3F5?=
 =?iso-2022-jp?B?UnpZdFJSL2ZVUDdPQm01SExBV0tEbyt1Y2RZZytmVnRTblNmZk5hZDBo?=
 =?iso-2022-jp?B?R29rUTJpSXUwVW96VmhneWlPL09IY2dkK1F3TFV0UmR0WGlkU095cHkx?=
 =?iso-2022-jp?B?am9QKzNBT0p0S1BwUndOajMxOVVuWUk2T2V6ZHZtU3NQOGtDNVR5YXBK?=
 =?iso-2022-jp?B?SHl0MU52b3dKTTBQTXBBUWNsUjRZcXkyZ1BTSFVZVjRKTy9MWks2TkN0?=
 =?iso-2022-jp?B?MmN4dEFNTzhtM0VEL1JFVnFpSkFWOGNUdW9YZ254WEZQSGpFbEFTN3FX?=
 =?iso-2022-jp?B?ZVJGbWtKdVpHZTF5RnFLZ3hYY0R5VGRPbW52RmhheWc1T1ZGVHlMSFJh?=
 =?iso-2022-jp?B?OHlKK0F1SDBPd0N5RTVXMlVpQW1zUjlnT3BkbUU3ZEV5Y0IwaU1BZHBU?=
 =?iso-2022-jp?B?Y28xeVcxK3dUcmVVUWZUT2ppVnN5S292blk5TCtCckpKdVUzMW1POEpu?=
 =?iso-2022-jp?B?Sk45aVJGQkgvSXovSDE1VXdlVVh0b3R0KzVGckhpeGdyUFdlL0RUSHow?=
 =?iso-2022-jp?B?dmFQd3FFSnYzRFlLdks1cVpyZE10RUlKQm5RTjQ0OVR4aUxmTUhaMDRr?=
 =?iso-2022-jp?B?ZlZSdFh1NXZub2dRYmxPMWRBOXN5TjI5VmhyVGF4N2IrK1BYZlY1UnVn?=
 =?iso-2022-jp?B?ZktiblFOeEJVN3pkY0k4aWlYcUMwcGI1dW5jRE5ESDBDQlhFbGVLSzhU?=
 =?iso-2022-jp?B?dDdRajIvMWUvc3hRQUUvNlBvQjBBNzFMZURyS1BLTWJLc01HQ3ZKZ1Bj?=
 =?iso-2022-jp?B?aDdXNEhDZ3J5M2hiam9oRVR1V05pVmtGNGJaWnN2Z2dtWGZqbGV5VW0v?=
 =?iso-2022-jp?B?RTdMdGduU2tRdkJSWFJUT3l1VTNQZG56eHdYSGFFZm12UGVmSGNXL2gv?=
 =?iso-2022-jp?B?LzN1M3JvSGQxRFN2TWhjWmtRQmFMZWZyUytGcmZmWWpOOHNLL2VoWG5O?=
 =?iso-2022-jp?B?QTh5TlZrR3AvOVJaQzRRK01tUWlZaVpYM1RkaEdNZjMzZHArNWhvNjZH?=
 =?iso-2022-jp?B?UU5OWlVlNGxWaWIzVXFVaGZBRXF5U3d4YWRpNW1HU2ZzMVNnZ0JvRjlD?=
 =?iso-2022-jp?B?YjBsMDRTTE5TMW10QndsYVR6dDhwd0pDaTRhclVxUGgrRFpiRHE1VzRL?=
 =?iso-2022-jp?B?bXR1aDhNblJjUnM1eWlyOHhOb3I0S2owT0JuVldSR01aVE1HZFM5bGht?=
 =?iso-2022-jp?B?SjNxSUNLM2ZEb0dFM2t4V09xOUJ5TlVZbVFtV21CbkJiRDRVRGFBcjlK?=
 =?iso-2022-jp?B?SWFSN0lpM1B4ZXpva09EcEZ3cURZdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Ny9RNmVaQnRDNkpXVlUyMFAwV0ZkMkZKK055Ry9ZMlY4OFpFUWZUQUgz?=
 =?iso-2022-jp?B?V3ErUEhCSjZQMFJyUm9wNHdRbTdUdmRBMmZoM2xEWVROYUNwSmNydTEx?=
 =?iso-2022-jp?B?RFpnenNrenVDYXRFMENKbHVobllyVWZNVkFmWUVXYzNCR3RTUndwNlEw?=
 =?iso-2022-jp?B?Sk9wYS9RNmNldVd4K2JIZXJESnJsMjNmSDY2UFJ1eGF4V0Y4T1ZRdmVj?=
 =?iso-2022-jp?B?eDk0bzUxTnVMSzBIcWVTbHFIbGNXd1VlNXcxUUE5d1NnY2M2dGRGSHBy?=
 =?iso-2022-jp?B?azJPclQvUzg2bTJJdjY5SVJFVzMxdjhHTUdrM1ZHRW1jRmxoZ0dqRVJV?=
 =?iso-2022-jp?B?UEM2cDhvUlIyQUpxMjRCSkQwM2dGc3ZNejNYVUN6MTNWYm1jZ21mVEdL?=
 =?iso-2022-jp?B?WFdJNzdsekI4Y1BHS0JETFByd1dzMHYrenV4YS90aHJ0MytCR2NadnpV?=
 =?iso-2022-jp?B?TElSSlo3TjNsZllWMG1QTVpJeUtIWVZlU0M2dnk0QXp2c2piS1B4MVd0?=
 =?iso-2022-jp?B?N0tMT25BSHVsZFlydENYL01BdEg3UFRaVE9hMklTSzhxa2pzY1Q0TGFj?=
 =?iso-2022-jp?B?SGpvcWdTRjBjNmlCcWNhMlQ3b2RSdWdjUEZKQkNoUW5nQzEwYndTdExM?=
 =?iso-2022-jp?B?aERKREFnL2tCL3htSm9MdFpxSmhCZFVoTzN5b2tpeXpaUUxmY2pTMjRa?=
 =?iso-2022-jp?B?L05Eb3pZK1g0YWdhOGdGZUZvaTdkQjdGdkUyS3JTMVBEUEl1MCtQc2Zk?=
 =?iso-2022-jp?B?Y05JZkwxYncyRk1MRno5VFhLdWNNSEdDeFRZMENDSWhuRmRGL3NwVXBZ?=
 =?iso-2022-jp?B?R3hsd2dydE51ellRdFZUcXFzalNCWjNjVUNpanZJaU9icnc0cTl0ZDMv?=
 =?iso-2022-jp?B?UG1kOVJ4R012NkRWR2RNYkRiZ0I4ZCtOUmZnWk5paGx1aHp5VmszeFY4?=
 =?iso-2022-jp?B?VFdWaTNadDJSWjFlTS9IM1k1UmdZR2pyRk92Zk1vVmJKRHBjYnh0Vmtp?=
 =?iso-2022-jp?B?ZWNBZHpXaThwaTZSQlBhTDFNRUt0U2JreEFBOXNnYzdpZFFsV0loZHo4?=
 =?iso-2022-jp?B?OENKNVZVQ29aWEdud2ZFMUI0OFo0d3BwSGxUY3J3T3ZVV0tVY0ZXNkRK?=
 =?iso-2022-jp?B?VE8wbGwzcy9TRVc2VXV5RVhIK3E2UXpHZDNuTy9EUVdoQjRLcC9zbFJm?=
 =?iso-2022-jp?B?WkkyQUo3NVpnbUU4Qk5ML0dvR09XRlhuK25xK2laU2VIaFN5bTlhK01C?=
 =?iso-2022-jp?B?YWFKSzV0OXFrRWtwdHBKU2hVdzNwaXROOUxxQS8rT0s0dkowb1QydWky?=
 =?iso-2022-jp?B?cDlpUisrRVY1dE9VczI0OUFncFBhVnN2dDRnN2M2SjcvOERwdGQyZUlk?=
 =?iso-2022-jp?B?SFVNVWtBcEovT21BbEFIUWxMZStqcTkzZmpJM1d4K0EzRGt3SWd2b1Fo?=
 =?iso-2022-jp?B?Y2lESEdqYnU4dFU0dFRMY05hZFl6endpVnFiQWVlUGJZOEF3UXBLMUJi?=
 =?iso-2022-jp?B?NXVqQjNtUlVvMHB5TkNWb1ZNUFlreVBxdGI4MThzc3BRMFNmMTlNSFZs?=
 =?iso-2022-jp?B?dTRQcWJBd2lMZ3ZmYWZtZDNkYldiMUFJcGVXR2ZVdzgwZ0htOENzV1ll?=
 =?iso-2022-jp?B?V1l2d3BJUW1RYXZ2dm5OOGwzbzhiOElYYUZvTUY0OEJIZlZDOSsyMm1Q?=
 =?iso-2022-jp?B?QUREbXdKK29NdEgrYXNJUzRlRGxGSmMyOStKeUNxZjVoNEpvUTA0czVD?=
 =?iso-2022-jp?B?NXpIczkvMmdFNWlIOHdwdWZ0WkVDaHlvbWxjblJCT0FEOGVQUnlIV0wv?=
 =?iso-2022-jp?B?M09NUDJmbWdCbFgrb1VRUlBBZjBBMnhQWVNIUnBiaFBlMStFV09hS1NL?=
 =?iso-2022-jp?B?WUwyZGxPWGtqa2lXN00vbDI0OWpoVk5zcEhORWJDbjlQZlBSTVpzdnJo?=
 =?iso-2022-jp?B?SkRzYkg1b25jUUJ4QUdObmY5VjBMVzcvU0UwNVhrS0tNWTlQRXdCVldt?=
 =?iso-2022-jp?B?N2ZHSzVHcFdtbW1JS3M2eWxRVVRDTUV2MUZuaUswRXh4OHIzWlB4Q3l0?=
 =?iso-2022-jp?B?dS9zbm9ZYjZiUnVEdTlEN0pabllHejlyNGFlamtTMlRnYnVUZ0dwbDBH?=
 =?iso-2022-jp?B?OENFZjBvUHZsNVliSjlLODVuNXZsaThQVW5Fc05Zdm9VUVVIQTVIMzY1?=
 =?iso-2022-jp?B?Q080bWp4WVRZRzBkcUlFQjkwZFFReVY4dkhDcFNMODJVV1c4OVIrdDBj?=
 =?iso-2022-jp?B?MG8zOXN0amxUcXdLS0d0dEpUcHdPVnNNdW9DU2xmaUdtOEZhS3lyTEY4?=
 =?iso-2022-jp?B?eFQ1NDdkcW9Kbk83aE9kcjMrU21LUE01L2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe230340-a9c0-4cec-abee-08dce372d345
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 06:15:48.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Xci43O49PbdlnNARXEQkTF2j9Hk+rPgU5TKqlfUOrFRyU+G4cqzFFzBpvxx8pJ7RM0Lg1e2UhDwrREVvfwKFKtaCsqa2Bwq9GN1vN74QKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8461
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 06:16:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16985

Hi Nobuhiro-San,

Thanks for the feedback.

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: RE: [PATCH 6.1.y-cip 02/16] pinctrl: renesas: rzg2l: Use dev_err=
_probe()
>=20
> Hi Biju Das,
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Thursday, October 3, 2024 2:04 AM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: [PATCH 6.1.y-cip 02/16] pinctrl: renesas: rzg2l: Use
> > dev_err_probe()
> >
> > commit f73f63b24491fa43641daf3b6162d2a451bd8481 upstream.
> >
> > Replace dev_err()->dev_err_probe() to simpilfy probe helper functions.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link:
> > https://lore.kernel.org/20240728090421.7136-1-biju.das.jz@bp.renesas.c
> > om
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 37
> > +++++++++----------------
> >  1 file changed, 13 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > index 6f49da4bd327..0cae3e75b26a 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -2200,16 +2200,13 @@ static int rzg2l_gpio_register(struct
> > rzg2l_pinctrl
> > *pctrl)
> >  		return -EPROBE_DEFER;
> >
> >  	ret =3D of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0,
> > &of_args);
> > -	if (ret) {
> > -		dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(pctrl->dev, ret, "Unable to parse
> > +gpio-ranges\n");
> >
> >  	if (of_args.args[0] !=3D 0 || of_args.args[1] !=3D 0 ||
> > -	    of_args.args[2] !=3D pctrl->data->n_port_pins) {
> > -		dev_err(pctrl->dev, "gpio-ranges does not match selected
> > SOC\n");
> > -		return -EINVAL;
> > -	}
> > +	    of_args.args[2] !=3D pctrl->data->n_port_pins)
> > +		return dev_err_probe(pctrl->dev, -EINVAL,
> > +				     "gpio-ranges does not match selected
> > SOC\n");
> >
> >  	chip->names =3D pctrl->data->port_pins;
> >  	chip->request =3D rzg2l_gpio_request;
> > @@ -2241,10 +2238,8 @@ static int rzg2l_gpio_register(struct
> > rzg2l_pinctrl
> > *pctrl)
> >  	pctrl->gpio_range.name =3D chip->label;
> >  	pctrl->gpio_range.gc =3D chip;
> >  	ret =3D devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
> > -	if (ret) {
> > -		dev_err(pctrl->dev, "failed to add GPIO controller\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(pctrl->dev, ret, "failed to add GPIO
> > +controller\n");
> >
> >  	dev_dbg(pctrl->dev, "Registered gpio controller\n");
> >
> > @@ -2325,22 +2320,16 @@ static int rzg2l_pinctrl_register(struct
> > rzg2l_pinctrl
> > *pctrl)
> >
> >  	ret =3D devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctr=
l,
> >  					     &pctrl->pctl);
> > -	if (ret) {
> > -		dev_err(pctrl->dev, "pinctrl registration failed\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(pctrl->dev, ret, "pinctrl registration
> > +failed\n");
> >
> >  	ret =3D pinctrl_enable(pctrl->pctl);
> > -	if (ret) {
> > -		dev_err(pctrl->dev, "pinctrl enable failed\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		dev_err_probe(pctrl->dev, ret, "pinctrl enable failed\n");
>=20
> return dev_err_probe ?

Good catch. Please drop this patch. I will fix it in mainline and then back=
port.

Cheers,
Biju

