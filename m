Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19B8C43334
	for <webhook@archiver.kernel.org>; Sat, 16 Jul 2022 14:36:58 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.96])
 by mx.groups.io with SMTP id smtpd.web12.6023.1657982208616090802
 for <cip-dev@lists.cip-project.org>;
 Sat, 16 Jul 2022 07:36:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=e3aW3LeV;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.96,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMPPRBXdB7RI+B6nm2cF5QVk1cmYEg6EyTtsglRf161CS53nokhHbGdiMnARo3zdIpwiFVPMZDW/aqlb4fsiYTmdW5rciIplrEUTuG+SyrPXAJGNfLZqUh6g2zNjIdhyzV0y5yxbM/paowZsbSl3FSiM3aE2fAesbEGH4Ip1hZSN4Bo9ST4hTC8euEpE4ZfSeRqJ2FDpD5XTiOBDsIUp4ybBvgn0bKedxy5SdK56Cerh+LoxcXbYGZiCLvQaUSm5nQl4yO1Nsc7xSXr69bD913pb68pkTyk4Orm7/Nw62F+3eaYA9T9HOUrdCOuKZ3Cd3tCITQqEQxarU1+6fFUDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEobjEAx2uKpNQG8qZ62RCx4pacvl8NqSl05+4fxed8=;
 b=ZEYHmLHDS6i3kG+FtLYpw+lMgodiPYPC4l/gkma5uZAE56uSOt8fHxdISSL0hjgaleJtig3pul/jJK+idffR11lSYNb6z3i1VzCDNuIVei5riyGzN94gSm0SVxIc0sao+I/Xf0+W11Gb7yC6ln7wz/PYZWff2X5cE8AftX/LZcfFY0lJK7bWAeuH5qQmGmO3CTGlrM15dvR1NOvRYAsgKuXL9nFjc1JpkM1GJocA3dZXrelKKlTH2k8KA9xYqWAfIiasqvsE6OzH0LLlAsPp/LaaTfccEPkY8SUNi8j28jYdrYaS4ajRY8HDaIGQd3bR4KsV1DZPmHhGBXgAsv6ijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEobjEAx2uKpNQG8qZ62RCx4pacvl8NqSl05+4fxed8=;
 b=e3aW3LeVoS3Xp1f4nGUl8+pIXhGA+k/6B6eEhrTOET8YIjNRxU5urJPrrmcCwoEvg2xhIeSedx/pWfVIyNVBglLlbQel0unS9D4Zu3MlMC8ldxYrLMhEn71i+1CjkjOafH9mBI+iwUnoaJrS1k9eHjMzV7GmsPiCNIPvVrWq40g=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OSYPR01MB5413.jpnprd01.prod.outlook.com (2603:1096:604:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sat, 16 Jul
 2022 14:36:43 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::440d:b27b:6bbb:3d27]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::440d:b27b:6bbb:3d27%3]) with mapi id 15.20.5438.020; Sat, 16 Jul 2022
 14:36:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH RESEND 5.10.y-cip 03/13] thermal/drivers: Add
 TSU driver for RZ/G2L
Thread-Topic: [cip-dev] [PATCH RESEND 5.10.y-cip 03/13] thermal/drivers: Add
 TSU driver for RZ/G2L
Thread-Index: AQHYmB4DoFtie5laUESOxGXECxlswK2A1G6AgAA7jkA=
Date: Sat, 16 Jul 2022 14:36:41 +0000
Message-ID: 
 <TYCPR01MB5933D3A6DA16E05E80D87DBE868A9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
 <20220715073916.2321319-4-biju.das.jz@bp.renesas.com>
 <20220716105351.GB18467@duo.ucw.cz>
In-Reply-To: <20220716105351.GB18467@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0addd197-c92e-42e8-35bf-08da6738996e
x-ms-traffictypediagnostic: OSYPR01MB5413:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UhUnsAteie4QD5NB2EAoh74yGrvZQnNiuIPfrx+tK8NNtIlkkfDAIB2IL68bgxxwTH+9EVzA5SHCRGH2LCsDKNj7IxGUvEELHrSjxfO/wb38daLhklONlZ7ugBIRnSFmAtE0alwvzpOjVYw3Y0QtTRhTMP/kjSkSZZcAiMmnKa1fm2nNHYzBe83bwqLNHYn2Qw8hs6XCKEBcS6jIcip+dSaiu4kuudhBz234UpYGX5Ua6X8lEMfeJkL8H03Ev11cQandewapDPnDPQ4j6At/IiaSK/r5OKtmOqlhqutTKJRF69l7NLRLUcKvebvrfhrGt5B+YsMwXYAYf53Ja5ys+Brbtse1vPPBApFZ4ExvwWbvU099xD3LOxMM4lfY2dWND+4u3dNUrREB7+2MIfEqjSJ9J7ScSxMpYbH9V71GAwF0Xo/YRgcfL6cCG8250V+sP7nCX1cZCMCY2pIY2qtfszomkQ4JuvHYpf0P3w0QFAItPmDOsiY0RvEHH4ylaLirl2o8Q1dbFbQPk02Mde4kdI+rwtpiI1Vsk4laFRxm/8wdB+BbFK1JRHUMCSL82HXW5KlK6+XkVuUQTNRRf1vGKS3I8ssEYlQnL1XXww/dpEN9Fmz7mx1sfeKrWogMWt/MIyWGL6PAwXFXw7cQyhXpJzqLsnearPgDQ99hr4yb2AemPR1H2ZLloUlTzQMigBHNWgYNJILLssgrW3rQl0g/DxMXJGkgVMFLN6cAho7O+UdDi+jyQudzs/N1t+sgG0m5tC+mHq2M9n1Hpr0JqAIzs69Qt59SpL3fqSG1F16sUImPWtmEp1t/zu7ClaOTL336
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(86362001)(64756008)(76116006)(66946007)(66446008)(8676002)(4326008)(83380400001)(6506007)(7696005)(66556008)(186003)(2906002)(66476007)(107886003)(41300700001)(5660300002)(9686003)(26005)(8936002)(38070700005)(55016003)(478600001)(33656002)(52536014)(71200400001)(316002)(122000001)(38100700002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MXIwam9UK1ZIcXNEVDlWbnprWGV6dVlLSG9UZmQrRTVXUmZZS3hta2Q3Q0ZS?=
 =?utf-8?B?anlwNEpzVFlnVFRJN1BSMkgzMXU2QTc3NlFPNzQ4K0VNaTEreTB6Q2RSVU1X?=
 =?utf-8?B?VjhycGduZG96Y0pla3JUczhKMmFSZTBJRWVNN1FIVWIyWlMrV2o4QUsxT1Vj?=
 =?utf-8?B?R2F4OE1mdGxIRWMwak4wTVdPYjVQdnRLYk42anNGTmhzNHNGdVZTQi9sTVFw?=
 =?utf-8?B?Q1ZTT0N3N0tDUDBxZU1uSy9aallyMW9KVjdYNXMxblgzdm9LK0NiUWpLWEVa?=
 =?utf-8?B?a0Y0V0xhQS9LaGdydHN6QzlCZlVBM0VpdjlzZUNLMmtEVmE1MlIvTStWa0t6?=
 =?utf-8?B?NTJoZWljY3VJR3BXbHV2RGdwVktQN0s0TjRLL0pncHE4a2RlYzhLdlRTL0Fo?=
 =?utf-8?B?dWJaU256K3NqMWxsRzF6VVlUNHNqTUVJOUs5OWdtOHRCbHNZcEdvRjFyeW5B?=
 =?utf-8?B?WjVMK2xlUjRGaG81KzMzYkF5UjVlK2hrRWJKbTRrSXBXRUgvUWlMZ01sN3V0?=
 =?utf-8?B?Qm9zcTJ5RzhlUlpsa0ZnYVp2RVdzQmVJOC9RbmRvcjFHZkgvZlJDcDBVOHc3?=
 =?utf-8?B?OGdJUThJQVJaYlJwNUdmeDNzd2RsVDlmU1BvUVhTcXFoWjRILys3SEdEODBB?=
 =?utf-8?B?RSsyVHhKME5xWmR6bnJHeE9HSkFzc0dYU3hEQ09aZjNYRlgzLzBFUUpkbWRj?=
 =?utf-8?B?ZEYyWFBMQmlQb3pBUkozRXpDL0ZaejBxZFRxVEpWTyt4RnBHaDB5NldKaEp2?=
 =?utf-8?B?bVppaldXNHlkMWlYK0J2M2hjS3hIK2J2N0llWDI2OUV6MWFXNFBwbllna1NE?=
 =?utf-8?B?ZkJvOHZ3VStjR3JRK3h5Q1BkbEVGU0Y3djhjRE1tUUkxU2FpYXV5N3VXRFV4?=
 =?utf-8?B?RytUTmRDY1hVK1FFYjE3WCtOOFV2YjY3dGc2b3RUd2pCWS8wTlhTbG5FSU41?=
 =?utf-8?B?M2tqRzdVNkw0bWFZeGRuRVFUckk3Nm5hY0NzL3AyTzcwVkhsVFgyVTZveDJY?=
 =?utf-8?B?b3JOZThXL1V0TXhodlN6ZU9MWmFDTG92ZGYyZENKYmVrZ0tZenBZNXJmT05a?=
 =?utf-8?B?RnNDaDZWb2JERWRyb1phUmZTYldBNU9TZWNFdmhUS2M4bStmaGRWR05LVms5?=
 =?utf-8?B?bDhRcTdCb25JWmJDTElyV3lvNkp6Rys0N29Jem5Vbk8xSjdiWVVFZm1QU2lB?=
 =?utf-8?B?RzBlU2wzYkp4MXZiY1dKY2ZObHA4WS9qSTFCbFF4NFk2KytiNlpIdHB4ckJz?=
 =?utf-8?B?NlNscldodmRvbHJJU3RPYVA5UjZGOWlORHIzempwZXNKYlN6SXFuZHV4alhP?=
 =?utf-8?B?TWZWQnQyTDVGT2R2SUdsUTBrSHF3NzJKRlpTYmltU1lEQnJlbU9YUUt6dWdm?=
 =?utf-8?B?M2xock9LQmUva0Vwa2JNWnYrTnc5UWhJREtTbEMrdlpRcWpHTTNFQXUrR2p1?=
 =?utf-8?B?YkdMME5IZHdlRXpGVGxXT2RGYkdTOUNzTjRaNHJsbXBvRHBEWmVEVnR1ZXYx?=
 =?utf-8?B?aGlJWWRaVFE1dWFJclk4cFdJeWZkYWxPQjc0aFFrNlBlakRzalhaWXNoWDNx?=
 =?utf-8?B?V2ExM2QyU0dXdWRCbzdhL3JpSHlaZ1c2KzVFSW51WVhjODJaU2pNYnM0ZHJR?=
 =?utf-8?B?QlJmUzVWTFFKeS9RbmxRSHFvY3VLbVZhUGYzMFZZeUtEeFZQQ1pJVFFBZENy?=
 =?utf-8?B?UW1TeXJIYVhXNlBuamM2TTJVQ0FPS3NpUVNsSHlzalBuZFFDRTZUQ1YvNFlS?=
 =?utf-8?B?TjBzNnBWWko1T3pzcFVGd21YUk1qMmtkRGlpTS9NbXFzZkFFOVk1T1lFN1hr?=
 =?utf-8?B?aGNqbkVBeWlRd2tRWGxiZTYyVENMVkpIVHBvcnZsNEFSaHhFMWJwSFd4OGs3?=
 =?utf-8?B?Q1Zjbm5sM2VTTXJjVHJ0NEx6OVJOZEU0QkdSNUFaRDd0MjBwcEJDQmxza255?=
 =?utf-8?B?Y2EvY2tQZkZ1dUpDbzZkUEFHcVhNdzg3bDlQbGtsMThZbkhlOFo2ZnRpZE0y?=
 =?utf-8?B?NDFmeDZ5TVJBckdjVVJaN1RlbWF1YVJkZitUN0ZwV0VhQTR0TmV3UnBXYkM5?=
 =?utf-8?B?ZWN0akQ4OHNjS2F0K1dnTytzSjNWWElybUYxOEhYOUIvZU5GL1BHZWVadnQy?=
 =?utf-8?B?Sng2Mm4zbW1OOVFkU3UvbS91N01FZWFBYUFYNEVRUStVOHpKQlRvVWRtZlNR?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0addd197-c92e-42e8-35bf-08da6738996e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 14:36:41.6156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Wg+qX3qmJaQhaXOKzoySujBEawz+r6JMx33Dkpa+LLqALUqGckDoFw3OoK8HoNMsAh90/JyUq/oGtPT4P97YHax1iuK1EjDd7utH8cVpH2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5413
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 16 Jul 2022 14:36:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8841

SGkgUGF2ZWwsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
Y2lwLWRldl0gW1BBVENIIFJFU0VORCA1LjEwLnktY2lwIDAzLzEzXSB0aGVybWFsL2RyaXZlcnM6
DQo+IEFkZCBUU1UgZHJpdmVyIGZvciBSWi9HMkwNCj4gDQo+IEhpIQ0KPiANCj4gPiBjb21taXQg
NjczYzY4YmQ0ODM5MGRhZDAxZjdkMTc2NzBkZTNlMzNiNjA4NjBhYyB1cHN0cmVhbS4NCj4gPg0K
PiA+IFRoZSBSWi9HMkwgU29DIGluY29ycG9yYXRlcyBhIHRoZXJtYWwgc2Vuc29yIHVuaXQgKFRT
VSkgdGhhdCBtZWFzdXJlcw0KPiA+IHRoZSB0ZW1wZXJhdHVyZSBpbnNpZGUgdGhlIExTSS4NCj4g
Pg0KPiA+IFRoZSB0aGVybWFsIHNlbnNvciBpbiB0aGlzIHVuaXQgbWVhc3VyZXMgdGVtcGVyYXR1
cmVzIGluIHRoZSByYW5nZQ0KPiA+IGZyb20NCj4gPiDiiJI0MCBkZWdyZWUgQ2Vsc2l1cyB0byAx
MjUgZGVncmVlIENlbHNpdXMgd2l0aCBhbiBhY2N1cmFjeSBvZiDCsTPCsEMuIFRoZQ0KPiA+IFRT
VSByZXBlYXRzIG1lYXN1cmVtZW50IGF0IDIwIG1pY3Jvc2Vjb25kcyBpbnRlcnZhbHMgYW5kIGF1
dG9tYXRpY2FsbHkNCj4gPiB1cGRhdGVzIHRoZSByZXN1bHRzIG9mIG1lYXN1cmVtZW50Lg0KPiA+
DQo+ID4gVGhlIFRTVSBoYXMgbm8gaW50ZXJydXB0cyBhcyB3ZWxsIGFzIG5vIGV4dGVybmFsIHBp
bnMuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgVGhlcm1hbCBTZW5zb3IgVW5pdChUU1UpIGRy
aXZlciBmb3IgUlovRzJMIFNvQy4NCj4gDQo+ID4gKyNkZWZpbmUgVFNVX1NTX0NPTlZfUlVOTklO
RwlCSVQoMCkNCj4gPiArDQo+ID4gKyNkZWZpbmUgVFNfQ09ERV9BVkVfU0NBTEUoeCkJKCh4KSAq
IDEwMDAwMDApDQo+ID4gKyNkZWZpbmUgTUNFTFNJVVModGVtcCkJCSgodGVtcCkgKiBNSUxMSURF
R1JFRV9QRVJfREVHUkVFKQ0KPiA+ICsjZGVmaW5lIFRTX0NPREVfQ0FQX1RJTUVTCTgJLyogQ2Fw
dHVyZSAgdGltZXMgKi8NCj4gDQo+IFR3byBzcGFjZXMsIHBsdXMgImNhcHR1cmUgdGltZXMiIGRv
ZXMgbm90IHJlYWxseSBleHBsYWluIG11Y2guDQoNCk9LLCB3aWxsIGZpeCB0aGUgMiBzcGFjZXMu
IEZvciAiIGNhcHR1cmUgdGltZXMiIEJhc2ljYWxseSB3ZSBuZWVkIHRvIHJlYWQNClRTVV9TQUQg
cmVnaXN0ZXIgZWlnaHQgdGltZXMgY29uc2VjdXRpdmVseSBhdCAyMCBtaWNyb3NlY29uZHMgaW50
ZXJ2YWwuDQoNCkkgd2lsbCB0cnkgdG8gZHJvcCB0aGUgY29tbWVudCAvKiBDYXB0dXJlICB0aW1l
cyAqLyBmcm9tIG1haW5saW5lLCBpZiBpdCBkb2VzDQpub3QgcmVhbGx5IGV4cGxhaW4gdGhlIGlu
dGVudGlvbi4NCg0KPiANCj4gPiArc3RhdGljIGludCByemcybF90aGVybWFsX2dldF90ZW1wKHZv
aWQgKmRldmRhdGEsIGludCAqdGVtcCkgew0KPiA+ICsJc3RydWN0IHJ6ZzJsX3RoZXJtYWxfcHJp
diAqcHJpdiA9IGRldmRhdGE7DQo+ID4gKwl1MzIgcmVzdWx0ID0gMCwgZHNlbnNvciwgdHNfY29k
ZV9hdmU7DQo+ID4gKwlpbnQgdmFsLCBpOw0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBU
U19DT0RFX0NBUF9USU1FUyA7IGkrKykgew0KPiA+ICsJCS8qIFRTVSByZXBlYXRzIG1lYXN1cmVt
ZW50IGF0IDIwIG1pY3Jvc2Vjb25kcyBpbnRlcnZhbHMgYW5kDQo+ID4gKwkJICogYXV0b21hdGlj
YWxseSB1cGRhdGVzIHRoZSByZXN1bHRzIG9mDQo+IA0KPiBBY2NvcmRpbmcgdG8gQ29kaW5nU3R5
bGUsIC8qIHNob3VsZCBiZSBvbiBzZXBhcmF0ZSBsaW5lLg0KDQpNeSBiYWQsIHdpbGwgZml4IHRo
aXMuDQoNCj4gDQo+ID4gKwlkZXZfZGJnKGRldiwgIlRTVSBwcm9iZWQgd2l0aCAlcyBjYWxpYmVy
YXRpb24gdmFsdWVzIiwNCj4gPiArCQlyemcybF90aGVybWFsX3JlYWQocHJpdiwgT1RQVFNVVFJJ
TV9SRUcoMCkpID8gICJodyIgOiAic3ciKTsNCj4gDQo+IFR5cG8sIHNob3VsZCBiZSAiY2FsaWJy
YXRpb24iIEkgZ3Vlc3MuDQoNCk9LLCB3aWxsIGZpeCB0aGlzLg0KDQpDaGVlcnMsDQpCaWp1DQo=

