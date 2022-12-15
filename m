Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F088C25B04
	for <webhook@archiver.kernel.org>; Thu, 15 Dec 2022 16:52:23 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.135])
 by mx.groups.io with SMTP id smtpd.web10.138540.1671123131320803946
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Dec 2022 08:52:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=cW8rnUrt;
 spf=pass (domain: renesas.com, ip: 40.107.113.135, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaXUc920/EkEEHIOpBFuq5SAkFKRLnZxJ5ZA2FmM8f8o74LNcfnFKLNgodEEMDQsCyJ93obA5gjKgVRctWLXWIvY4UlwFjGG7nRTTLWRMvHEocF6SYKInUFnICZF3+eYi9PeVBN06Mf7CXtzJwUAV7lt8hcnQQnyITzDvh22AK3MAjdc0W1pulItJVIZ+zTbBViLHEeTHexoj06kTSTwc72JZ+L33ShPBzXEZOfjow85Ol/FEgcdoIglmYQxWuBBjXH3yhDdsrhkBGWU1u7mEI+bKiqygGeqB2NRPoIkJrTfQFhqrt5wBJiUpwbA4h+6CyfwkdLYa67ji68BFfwCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+sazJrdBEthY+FsoNBo7NZXrBisXBf9kI4bGPx9feM=;
 b=Flmfn/a9rC/sSXNlUM/tuxhlnwG2bjIXQj3yQstCGIZDOVZ+/vvv/lCdvsD9LZXRg8VSHLCtCMte1q15Q2l/OpY5k80ay4pBLnCArJSYrUL0o86dJ/8h8NBfwiA91k8feQfi9yFG6mD47JB9EORtIws3jH+zAAbquXru3fDVEAbFIyStdgBdVaQdHePgM5bcCATDKMwLizKwC8CYtdC8ro89+ZmoG/5va76Ie0Y5Xb8/b5lDHNta8ZSKGboL00qXLn1FUaibE8Yt27eLFu38HVG/JR3lfJgXVCOP/GNWGl4rs6k5yzfsQhLzeN7Od1aXG/x0krJBPTlHPCwY3D5FYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+sazJrdBEthY+FsoNBo7NZXrBisXBf9kI4bGPx9feM=;
 b=cW8rnUrtGZU1Ro4JzOT9HHiIbN66hBu707uSnQtrQez3tXjctEVCBumTlOkg/rMtqFrxS8rkqtOyEuo0tEl94CNSbbwCEcsyjfe+BjIMiW4qChk2kbCxn2e4wUpFhTLmE+xcI9SBLshh8k0+DVKrVhWG5CWjMY081k2uuMMikNg=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TY3PR01MB10337.jpnprd01.prod.outlook.com (2603:1096:400:251::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 16:52:07 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::a71c:a2bb:affd:2293]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::a71c:a2bb:affd:2293%9]) with mapi id 15.20.5924.015; Thu, 15 Dec 2022
 16:52:05 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Kernel WG IRC meeting updates
Thread-Topic: [cip-dev] Kernel WG IRC meeting updates
Thread-Index: AQHZEINIpA37ra4/UkeL4hc0/hq5T65vKfEg
Date: Thu, 15 Dec 2022 16:52:04 +0000
Message-ID: 
 <TYCPR01MB10588E06BFD27850638290C36B7E19@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <1363a53b-d301-4974-31e4-6b855cdc3027@siemens.com>
In-Reply-To: <1363a53b-d301-4974-31e4-6b855cdc3027@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TY3PR01MB10337:EE_
x-ms-office365-filtering-correlation-id: e99fa01a-9fde-49de-3a4d-08dadebcb21f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 giWXfkdsTWM2BGn93J7nSidTr2FuROW/EJ74g0cynnpjSfx9LsmY0t0Kyo+1sMrw7HwcWPFb4BztJgrdjRUcuo8IlqcaqZl0rArQSoKOhZ/2joa1Rn0C8ccPan0SL0AHW1dQeR9hSzIHBlhNP+5DD3iYo7ZX28dZq8tkdH4CskWnDBqX1bdqIMt5AisnEaW5fMHojA2AjYLaUy2/5bdunikbrArS47tLcmywSpanwiE/DUdv08BlPlSIooauARCE9BxFLhYszS103CiPb7auW2OrrqmIfZWbQ2lS7JK44pYhL56uD1zunKYB2xSJE4dVfw6erHbE0nwx1FIjggmNmc8RyaiRH9fSRe7H1aU1eIfN3ApjaAO3ZZycZZOwzbKkpkhtZBYj5Cm41oVYFxFxFvJ68nt+IwVI3fTWQYGhKPkQ97Jdv7TOIQUJsiskzBf9Fe1OYbhtyBxwEo1A5qZaXoD/Kwh6ZCo+iLI37P8GZ4Ce3Qhjw0WiXx/E/KxV4dwsdxIE+ZOrV8AriuL/tQz2RgbzrXMoYA1/M3YJ9NMcCznB9dnYayf01MAGRMy9o+YAicYYzubnccNlQWxju5/oOQFzXiH53iH15HPOA2K5l/sh0DI4XP+H2ZLXxBoW1JTRgcHpGfbBxxyDq4jRHlOkSejWOds3tyNDi/dnqhorUd1+JymoEl+61nlbc5hbwCjSOvT40H7dAExLELuBLABlPhlVXinkwJgh0HM096GIZYfTineWge52rERiBkbEaJ9A
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199015)(41300700001)(86362001)(8936002)(52536014)(76116006)(64756008)(8676002)(66946007)(66476007)(66446008)(66556008)(478600001)(4744005)(38070700005)(33656002)(6916009)(2906002)(122000001)(5660300002)(55016003)(9686003)(38100700002)(316002)(186003)(26005)(6506007)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?LzVxUW0wRjV2WFVtOEdDdGtiaVhHU3RCOGxwR0E0M2hWVzFKVUQ3NGtsemg1?=
 =?utf-8?B?M1k4eFRhY1Q5NGhhQXg3dHZWUjBmS3VEbHcyTFlWMnZXWTRQNkVmWHduUE50?=
 =?utf-8?B?K09lNUwyOWRDU2R4OGhjdG9wbXdmcjAxZmdtemFrZmp5dGZQZVE2aFJ5U0dz?=
 =?utf-8?B?TlNWTzh3MUtwWmVwQ0dodHJqTWVSOEJtb1BFZ2hySHRZejBqMGRjeFQvVUdD?=
 =?utf-8?B?RDZEakFlTHA1d0x4S0hzZ0cyL0tjSitqa0ZteDhMNDJGdnkxeHIwOFZqVUpE?=
 =?utf-8?B?eng5d3V6KytsVEZxdERLRGMzMVlLUC8wWHBSVW45N21XS0NEbTB3Z0NucG4y?=
 =?utf-8?B?eU9uMTZha3AvNFdqRjBoY2N2ZHZlbkxZQUl4UVBwZng2Ym9nengvdG5HZWhR?=
 =?utf-8?B?SmdxWk5wMnh1emtKeEgvZ2lRQW9aSDNBWmQ3QnlsWnQ1RThLLzRSakNlTWpa?=
 =?utf-8?B?anJOeEQzK1ZhQThacC9VVTZpdHFwZWdBbTRkdm52bjdFZjl4TWdITmJiTzly?=
 =?utf-8?B?NHpETUFRL3k3b3FSM0ZXb3ZUWGZRTW12UUNpNlVveTIzWnZoT1pKZGFWTDhN?=
 =?utf-8?B?eGMxZmlGdVdJNkphMGhudU5aaURnVUpKY1Vxc1ZxZlFYYXJxdmZ2QXpWOVVE?=
 =?utf-8?B?UW9HYVBLTHlRWHlVdklNdDZxdmJQODNNcnhuN05tYXM1MU5GSWJ3cTVNM29D?=
 =?utf-8?B?UFVhME9EY1kyV0xrRys3N1F0M2dvUTJCcGhZOURJQlJuVm9KZ0dRbm9ScFdR?=
 =?utf-8?B?aUJpd1paRHo4eGV4VGY4YnNYelpNK2Y2Q01BYTJDTitiRVZFczdTOFdNVnJa?=
 =?utf-8?B?b2cwVmwvSUF1WFdkbkNZTlZVU2J4dVBKZ0cxbkx1MWRyZmlqV01lYTNUd1U3?=
 =?utf-8?B?ZDVTN3ljY081aHdIcGVVelVWdVF5M3RCd3l6WUY1L05zN3dZOHZ5dGVrRzZk?=
 =?utf-8?B?cnBSeXdNMUcwYzdnV1ZUTk1zZWxGVXl0alhiMzI4NG82WXJheTJvQ1RUN2hM?=
 =?utf-8?B?MmxEVkZwYjUxTVZyZ1lybWhsTkpNZjVMVlVZV3RVZm05OVhuUVpQSDR1UGFZ?=
 =?utf-8?B?RTFDdFNncGRRZXpjTGV1OE5nYWIvV2lqRUJoSmJMMUpBUjBxc0VJelZTSmdj?=
 =?utf-8?B?NFcwQVhaM25UM2hCa2pFZFVhOGJiYkgvcCtvM2ZrbWtXRThqNU1jeGNTOGIx?=
 =?utf-8?B?dm1XOERpZEljcXdLc0lZb0hFTmt2NS83NFM3SkRXMEJpY2dLS2FjYU9sUTR2?=
 =?utf-8?B?QlhXOHlITXRrU3NVWW11QXNCbmhhd1VGb2NLU3J4Uno2b0Mvd2J1OUdIVUxh?=
 =?utf-8?B?clo1blN5ZDJmSVlaekU0NVJ0emY5a2pQamJSUktCNFdOLzZjYzZ1cjRMTGt4?=
 =?utf-8?B?aGRQaVkwUGJqRTJBWU9CcG9jeVhHeFo0ZHQzdTBQaVR4K1ArdC8wMDhRamRm?=
 =?utf-8?B?ZGlZR051bDFaeUFhRDRSbW81b0R1ZUg1UlAzbTZZVXFHeHcyNUNhdTJ5U05I?=
 =?utf-8?B?NkQyaDVJbFp4RmZxdFl3WS9UV1Y4RVZQM1FybXpxaU9zNFBOSnJ0ZGVHa0xL?=
 =?utf-8?B?R1doR3krbDVOTHlEbXJNNWI2NE4wcGdFUXMybEtFVUdIUTd5R0ZoaHI3Qnd0?=
 =?utf-8?B?cmVhRCtwWkg1S3lMazJuMjlTa0FMQVBSQk1ZME9FUVlRNFF5QnBJT3FWZ1I5?=
 =?utf-8?B?bGhlM1Z1WThSRzlObTZ3ZDRUNmlUZFY0cWt6eTlCNng5RXlyRjhOV29GNzds?=
 =?utf-8?B?elM0OHVmdHZ5RXVXTjhvMkdMbEg5QjB6SzBBcS9LelZwd2RyVFlHZTJha1hX?=
 =?utf-8?B?OGNlL09rWWowK2J6cXFJMEpvNGZLdkVjUlIvZDVyajdvd1BPcldKcXBFRkhW?=
 =?utf-8?B?TjNhSDJKS2pITFNvTnJnV2xhRHhPU3Nva1g1V0RuZVdXVENKalV3M3FVcGVJ?=
 =?utf-8?B?azJ2b0lzVHBLN3R3R3ZQemY4RkhHdlhYT0hwdVg2RTdHODZRYlA5WFU3ZU5p?=
 =?utf-8?B?SjJyMjhnUDRCVmxtSThUWVY2NjNQTTdScTVxTjBHL25EOTNZQjVnZlh5RUxM?=
 =?utf-8?B?bWNpMkR3bk9LQmh5Sy9hYnY4cFprTUo2Q1ExMXkwY3lYektKMWQ0UjR2Y2ZU?=
 =?utf-8?B?OW5taDd1M1FsQVE4MW5OU2R6bW1NM05JTHkxbTlKckZmYUZnSUJJSkhIZ2pv?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99fa01a-9fde-49de-3a4d-08dadebcb21f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 16:52:04.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nKhbHSXDrmP1tB1HTbmeaDrLsu/zkGTH96nH/bCIQcqNrjsxnwnDue677E8g/PLhrKnDBKe7l5/fdZJWWPhupJ39/IHb1RBMPtcJ9l1RKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10337
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Dec 2022 16:52:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10234

PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+IE9uDQo+IEJlaGFsZiBPZiBKYW4gS2lzemthIHZpYSBsaXN0cy5jaXAtcHJv
amVjdC5vcmcNCj4gU2VudDogMTUgRGVjZW1iZXIgMjAyMiAxMjo0Ng0KPiANCj4gSGkgYWxsLA0K
PiANCj4gYXMgb25lIG9mIG91ciByZWd1bGFyIHBhcnRpY2lwYW50cyBoYXMgYSByZWd1bGFyIGNv
bmZsaWN0IGluIG91ciBjdXJyZW50DQo+IHNsb3QsIHdlIC0gb25jZSBhZ2FpbiA7KSAtIHNoaWZ0
IGl0IGJ5IG9uZSBob3VyLiBOZXcgdGltZSBmcm9tIG5leHQgd2Vlaw0KPiBvbndhcmQNCg0KVGhh
bmsgeW91ISBTb3JyeSBpZiBpdCdzIGEgYml0IGxhdGUgZm9yIHNvbWUuDQoNCkNocmlzDQoNCj4g
DQo+IFVUQyAoR01UKSAxMzowMDoNCj4gDQo+IFVTV2VzdCAgICBVU0Vhc3QgICAgVUsgICAgICAg
IERFICAgICAgICBUVyAgICAgICAgSlANCj4gMDY6MDAgICAgIDA5OjAwICAgICAxMzowMCAgICAg
MTQ6MDAgICAgIDIxOjAwICAgICAyMjowMA0KPiANCj4gUExFQVNFIE5PVEUgdGhhdCB0aGlzIHdp
bGwgbWVhbiArMSBob3VyIGR1cmluZyBkYXlsaWdodCBzYXZpbmcgdGltZXMgZm9yDQo+IFVTIGFu
ZCBFdXJvcGUuDQo+IA0KPiBBbmQgbmV4dC1idXQtb25lIHdlZWsgKERlYyAyOXRoKSB3ZSB3aWxs
IHNraXAgdGhlIG1lZXRpbmcgZHVlIHRvDQo+IGhvbGlkYXlzIGluIG1vc3QgcmVnaW9ucy4NCj4g
DQo+IEhhcHB5IGhvbGlkYXlzLCBNZXJyeSBDaHJpc3RtYXMsIGFsbCB0aGUgYmVzdCBmb3IgMjAy
MyENCj4gSmFuDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+IENvbXBldGVu
Y2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=

