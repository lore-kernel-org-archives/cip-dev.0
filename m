Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E315CC433FE
	for <webhook@archiver.kernel.org>; Mon,  3 Oct 2022 20:12:52 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.133])
 by mx.groups.io with SMTP id smtpd.web11.2486.1664827961694424440
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Oct 2022 13:12:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=p46Bn6Dv;
 spf=pass (domain: renesas.com, ip: 40.107.113.133,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/qAnkwCgRIfn0fH1/9WY6l6WXI0QkkVgmBRG5AmJGCWfKdCfKAH0at43Eqkv1dyMSZeUXSEkD5wCmk81jVxLCQ3dBhT6huL0f6rkyBXIFC4UsCwMIsO6vMwCsw40BEYmnX04gThJ410lhC0H2Tn0lWgWNPg+X79n2SewPUR0ioKVy0DejV5lZVj1e0U3vZiJsHx0iCpt7LRu9G0qnjOPeVqaFhmXotV3Y54L3liQXN0HqGPWscveil5NMLafrpBOmz+3u3ljEdyfEz5urEy/0j8BBCa59SYcEPJwAPcL4CRChhiFfSf7tkYWv9MceJHH3ArPxzkPAuuC7VwgG5Fbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8PwKJuxWCd1oeq4u5PsCbnkTzX0sLPibymZLVWerJg=;
 b=LpIcuILbhlICjwxBI95M8C6DuBUre3sA1jHdJHc5K1PRZrOK0rI58hjlWHlPiJuKhfIewilyjPtMcNJ4T6vw1cGWRb1zJYL626axYFiS/vZ2rKxDgyp/F4ZfScgOK8/6SWlC5wffw/aQ+ahJ+DOLMFjUY2bXTM1wGqEfz3nPYmHIzyCH5CpN0bFZvPUjUx01aZ2VvSXLRixDOgQHkZGoCNHz5G1vcE+QuIGmPTGP6CzXO85b1Aus/JI6WZN/ZBfI8U/eZyPg48q9F+vgNzT5EZ8k6hmQedDW2fy3ZEE5px3wKVYvmaavt90MrAksW4Jhhkp7OVudncqogdopvGgnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8PwKJuxWCd1oeq4u5PsCbnkTzX0sLPibymZLVWerJg=;
 b=p46Bn6DvBnm38S5dH6fbC+JEP9L8B6tVe4bX0vilnSJbZ8Qc+/5WF61HoFsQnR4RuODUvExLPvOVaJi6HzwlVqFQ9joqwPMGlgwXPm2sQHrxLjYU9MJMu1husJQ9D1gjouStLJ/XTlK5m9TiX8ZKuc3voFS02Gf/IT1jv0hCp3c=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by OS0PR01MB5491.jpnprd01.prod.outlook.com (2603:1096:604:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 20:12:37 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab%6]) with mapi id 15.20.5676.031; Mon, 3 Oct 2022
 20:12:37 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: Preparing isar-cip-core for RZ/Five
Thread-Topic: Preparing isar-cip-core for RZ/Five
Thread-Index: AQHY11cJoewOp1WASEW0Kp6f8UBCvK39Ec3A
Date: Mon, 3 Oct 2022 20:12:37 +0000
Message-ID: 
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
In-Reply-To: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-Mentions: prabhakar.mahadev-lad.rj@bp.renesas.com,hung.tran.jy@renesas.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|OS0PR01MB5491:EE_
x-ms-office365-filtering-correlation-id: 6cc24df1-841b-4c18-e4c6-08daa57b9dde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KW9GCF5LIJKrAHUnZXtM/GIqRvCQxOImITkh8qktoAQ6zf0IOiVA+W9OoFjduGlU/QfJEOp4HIx1qfaCq5pm8lGTC8v2pltu9kmR01Qr3zha1en6cE58/yrw9cLc8Ri1m2y8+6l8QmejWT9qZYw9rk5d3Ur4AAJSD0KfRZMaKhtfZF7QmXp983QcAgsEh8iyOWermmokKTJ1ZuxIZPyq20Obz5e8e0xramtk7HpMhV0rrGlZLtbNye1jxet7MrhwHLVTYQteJQ1RwYC7xijHEhwxPv9T3aZfRyF7T9DOg9gxMikEjzm/wcD06XR/N3SyW/oK9+AY89UkyJf0jIr8vOBofOm1z1p0K9XGSWDv3iXPijLXEng5GXtz73ZJ0zzFoEczX8Q5Zpk/29JoNSAI943GkxCQ9U0Vzns+bUKHe3Ocqdx+H6dRaX1UwO1jjejcqhMVMucbN7C1V9R+ZNKhfrvogZeAfaW8/bPSVn1M/0QhaRgqgxq8gubBjEebAFxVpdvahtnbunKZFYCXQThgi71GRcfdTWwVsMeYx/oH0Sfqyx3WN/PPnDDNkbxdLGzUWLp/1PCiuva7KNVMUudcs0LulnXYU9yA54MlAencCA5eRPSdOMdcQ2Y/dWImDzdFRKa8EN0zOX+jBepv9VoTyS2n/x2u/AfQh9S/lhJw4vRChE6oQTykbcGFIjkvM+wf3V+BOJ/ebIfPOYbgigch45m5rZElcl9p/i8Kvvj7zYVZV/DFI0H57+RuglImJmlindy6VTqmmVCrZ2JOaTOmTjcqQNwaJQU13qDgu6JAuDEmK5JrCsVCKpbF9AUDgN6Zv8Qq1Y4olYAnIC8QDmRfUw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(2906002)(5660300002)(66899015)(41300700001)(8936002)(52536014)(66946007)(26005)(6506007)(71200400001)(316002)(76116006)(478600001)(38100700002)(122000001)(86362001)(55016003)(9686003)(66476007)(64756008)(7696005)(4326008)(66446008)(66556008)(6636002)(8676002)(110136005)(966005)(38070700005)(33656002)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K0Y2bkplZ24xa0pRUGpIcnhBMlYzRG5vTi9MUjdhS011bUV0bmVoK0JIaGhW?=
 =?utf-8?B?ODF1OW5aNysvV2JBSFB3VDl4enNqKzVlWS8zSGxpMzRCallqZlhYUlA3ZDR4?=
 =?utf-8?B?WHEyeC9rNy9BNUNmUGh2dUk3c3RxNkFXejMxaTV6NDI4S21rQXc0b2lEbXBV?=
 =?utf-8?B?VWpoRFYrUnJhRkVhbEtreGdpaUZtSm9YdWh5YzM3SnM1RjVITkc1TTVtaE00?=
 =?utf-8?B?T2gveFJaRkE2Zkh4STdDb2hiYm5nd0FyNEJnTzlwY2dFM29NNDZVaVJ2NmdE?=
 =?utf-8?B?cXBralV5eFBIR01jVzB3ZEtsRVdJcFlHelVSUDhQZVN3K0lkYkJDenVSc3Fr?=
 =?utf-8?B?ODhHV2pTUmtteUs3bXBJR0tWVWpkSGlmbW9KUGk0dXhEM3Q4c2dXTmJKTDIz?=
 =?utf-8?B?VzlKcTIvbUEvWjlDajl4V1gyVmtXRTdPMjZSK1JZQ29RbnZvQTFqZjJ2VUZM?=
 =?utf-8?B?cDdxWGVMc09XS3BQQ3piancrM2pVejN2KzY3cGhPUVFnSDlYa3RHM2hOODlq?=
 =?utf-8?B?aW9zUG9kcDZmTHBOYXp6OE1sOFVVWVU2RGtoSHFacG5NWVZOZjN6Tml4OFVy?=
 =?utf-8?B?VUt1dUExTWtWVE8rR0hVMlBjbEg1ZUdOWnJZMzczNmJDU2xBSThWSkVDRFFn?=
 =?utf-8?B?Zm1LaXFVdzIvMDcxQndtcm1BY1JOQnN4VDB5SDJ5MHNtNnRHV1dBT0d5L2hY?=
 =?utf-8?B?UksrMUJ6WnQ5VzdsYklrT0hQb1dSSDhYMXV4TmtSY2h3TEhZMm1MUGVBclRp?=
 =?utf-8?B?RUd6SlR3a1MrK3hGV3p1Z1E5bklnRklhT3RpRy9aYktJSXZVSElLSXNzY21i?=
 =?utf-8?B?NjhvWC9ZWnloTXVIaGEzUkVjMEViU3NSeFg2MFVLYko0am4xOUVCNkZ1NkRU?=
 =?utf-8?B?WGVxd2hESWJ3dGZKVUk2VW1iSTQ1clBmVGdKQW90YVhqdnQ5SDl1ZzUxelB2?=
 =?utf-8?B?Z2lYQXp0MU91L1QvQkRtdWhJeWZWZUNRdUtDdlMxMVZxenhCcm10RS9RdW10?=
 =?utf-8?B?WHZTM2ZyRTVGTzlvMWhFMG9BaHV3eWlNU2RWdjBybXBBQkpZMDZicXk3L3Bw?=
 =?utf-8?B?SVo0LzZvWm9jYm9zU3cxOWhkWDg5V1hNMEczUFBBNzlma0cwdHorbUhYV1BU?=
 =?utf-8?B?azVUcW1KbW9yeHVYOE0wT3BGTWtpYW5hRlluWlBzWG8xR2RjSnYraUgvTm5R?=
 =?utf-8?B?bzdLeStBYUVRdXJRUVc5b292OU9sRHd0SDlpYnBIVkdBTnh6bm1Hdnp5WE4x?=
 =?utf-8?B?S3lZb2lXcEQ0WUltclQ0cDlsd2g2RWxWMllFVUFpcGZBaWRiMXBueXRoWmlS?=
 =?utf-8?B?NkxxUjJKSC96bFFQMW1Eb0VxTm5RUWVkcDQ3bmNVTkVMSFdhTTJFbFdMeE9z?=
 =?utf-8?B?MHhBenlkZ1BXeGVIZHJZbWI4L3BPL1dnNGo1ZktpTlNqejAzZDZoZWdBQzNT?=
 =?utf-8?B?TDJMUktlNm9ScFVaQ21qYlVjbGxCN0FxSXFITTRVWFlySDc0ZWdzblJVMDJZ?=
 =?utf-8?B?b0kzclVIbGJOWFFoVjgxUDE5VGhCTktuczJaRzlSSUk2a0dUUnZBbEpzTWt3?=
 =?utf-8?B?ek91MXZxeUxpLzcvczBJNEdCeHU2NmJaLy96bjJBR09qcjlmc3FkNUxUemFa?=
 =?utf-8?B?aElwNUdQWElnOExDeUx6OVZhVTFKbDViaUZXSWkxWUdyVTVEQUFmZ1ZaT2Zq?=
 =?utf-8?B?Uld0bWpwNVJZUlJENDBJakVucWhpVTZJa0EzZFlGNzBhbGxZVWhnTisvb2xt?=
 =?utf-8?B?bjVmSzB3Zy9JWGl6WWcyTlpnVWJTSHB0eFYzeWpqTDdYaEJ4a1NBOHFIZktk?=
 =?utf-8?B?LzhSYnpuSHcvRFBiNjJld0pZalV4ZUZwRFI4T1FJNDE3S2FkT0Q5anBsT2tH?=
 =?utf-8?B?UzVQRDlvb1NtNThCVzYvT21RdTRRQzlTbE5uaXpJRGFwdk1tQlN3WEwyTTlo?=
 =?utf-8?B?T3g3UkRrM2hOamx6Mllod2hsWFNrY0pkSjdDMjRFWUhsUG1id0tuc3ZFSG1i?=
 =?utf-8?B?dEdwNDhpbCt2N3lPRXYzeGR3TGg0MjRnUlpqTUNnT2swcUJVckJIMEFRZm9r?=
 =?utf-8?B?azkzeUF3UGdmMFRxS20vbUhaOW10cGJMV0V1YzBocFdVZXhpd2kvb3RqRitv?=
 =?utf-8?B?L2xQRElPK1ZRUFRMZXNZUVhvSWFIaHlUdVFEaUNUbE9Dc3RZcithVXJRUnZm?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6cc24df1-841b-4c18-e4c6-08daa57b9dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 20:12:37.4224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 5+Ywm6cFC96ijPxEmc4T5rSSH09RmQbdSbEyob34hcuF762srMGcTQkqZGYUAvZcS5JMKw6jlcSh0i2G/GhNwlt1NEvdt4rpduXkyvQp5So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5491
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Oct 2022 20:12:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9617

SGVsbG8gSmFuLA0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+
DQo+IFNlbnQ6IDAzIE9jdG9iZXIgMjAyMiAxOTozNg0KPiANCj4gSGkgQ2hyaXMsDQo+IA0KPiBh
ZnRlciBnZXR0aW5nIHFlbXUtcmlzY3Y2NCByZWFkeSAocGF0Y2hlcyB3aWxsIGNvbWUgdG9tb3Jy
b3cpLCBJIGFsc28NCg0KSHV6emFoDQoNCj4gaGFkIGEgcXVpY2sgbG9vayBhdCB0aGUgUlovRml2
ZSBldmFsIGJvYXJkIHlvdSBzaGFyZWQgd2l0aCB1cy4gQnV0IHRoYXQNCj4gcmFpc2VkIGEgY291
cGxlIG9mIHF1ZXN0aW9ucywgbWF5YmUgeW91IGNhbiBoZWxwOg0KDQpJIGNhbiB0cnkgOikNCg0K
PiANCj4gIC0gV2h5IGlzIHRoZSBkZWZhdWx0IFUtQm9vdCBoYXJkLXdpcmVkIHRvIGEgdmVyeSBz
cGVjaWFsIGJvb3QgbW9kZT8gSSdtDQo+ICAgIG1pc3Npbmcgc3RhbmRhcmQgZGlzdHJvIGJvb3Qg
LSB3aGljaCB3b3VsZCBpbmNsdWRlIFVFRkkgYXMgd2VsbC4NCg0KR29vZCBxdWVzdGlvbi4NCkBQ
cmFiaGFrYXIgTWFoYWRldiBMYWQgb3IgQEh1bmcgVHJhbiwgY291bGQgeW91IGhlbHAgYW5zd2Vy
IHRoaXM/DQoNCj4gDQo+ICAtIFdoZXJlIGlzIHRoZSBVLUJvb3QgdHJlZSAodXBzdHJlYW0gc3Vw
cG9ydCBpcyBhcHBhcmVudGx5IG1pc3NpbmcpPw0KPiAgICBJJ20gc3RpbGwgdHJ5aW5nIHRvIHVu
ZGVyc3RhbmQgdGhlIGluc3RydWN0aW9ucyBob3cgdG8gcmVwbGFjZSBpdCBpbg0KPiAgICBRU1BJ
LCBidXQgZmlyc3QgSSBuZWVkIGEgZml4YWJsZSBzb3VyY2UgdHJlZS4NCg0KVGhlIFlvY3RvIEJT
UCBpcyBoZXJlOiBodHRwczovL2dpdGh1Yi5jb20vcmVuZXNhcy1yei9tZXRhLXJ6ZzIvdHJlZS9k
dW5mZWxsL3J6Zml2ZQ0KVGhlIFUtQm9vdCByZWNpcGUgcG9pbnRzIHRvIGh0dHBzOi8vZ2l0aHVi
LmNvbS9yZW5lc2FzLXJ6L3JlbmVzYXMtdS1ib290LWNpcC90cmVlL3YyMDIxLjEyL3J6Zi1zbWFy
Yw0KDQpZb3UncmUgb2J2aW91c2x5IHdlbGNvbWUgdG8gZm9yay9maXh1cCBhcyB5b3UgbGlrZS4N
Cg0KPiANCj4gIC0gV2hlcmUgaXMgdGhlIGtlcm5lbCB0cmVlIChhbHNvIG5vIHVwc3RyZWFtIHN1
cHBvcnQgeWV0KT8NCg0KS2VybmVsIHRyZWUgdXNlZCBieSB0aGUgY3VycmVudCBCU1AgaXMgaGVy
ZTogaHR0cHM6Ly9naXRodWIuY29tL3JlbmVzYXMtcnovcnpfbGludXgtY2lwL3RyZWUvcnpmaXZl
LTUuMTAtY2lwMQ0KDQpVcHN0cmVhbWluZyBpcyBzdGlsbCBpbiBwcm9ncmVzcy4NCldlJ3JlIGhh
dmluZyBzb21lIGZ1biBzaGFyaW5nIHRoaW5ncyBiZXR3ZWVuIGFybTY0IGFuZCByaXNjdiwgYnV0
IHdlJ3JlIGdldHRpbmcgdGhlcmUuDQpJJ20gaG9waW5nIHdlJ2xsIGhhdmUgc29tZXRoaW5nIGJv
b3RhYmxlIGluIHY2LjIuIA0KDQo+IA0KPiAgLSBDYW4gSSByZWNvbmZpZ3VyZSB0aGUgY2Fycmll
ciBib2FyZCB0byBhdXRvbWF0aWNhbGx5IHBvd2VyLW9uIGFmdGVyIGENCj4gICAgcG93ZXIgY3lj
bGU/IFdpdGhvdXQgdGhhdCwgaXQgd291bGQgYmUgaW1wb3NzaWJsZSB0byBhZGQgdGhlIGJvYXJk
IHRvDQo+ICAgIGEgcmVtb3RlIGxhYi4NCg0KWWVhIGl0J3MgYSBiaXQgb2YgYSBwYWluLg0KVHdv
IGNoYW5nZXMgYXJlIGFjdHVhbGx5IG5lZWRlZCB0byBnZXQgdGhlc2Ugc21hcmMgcGxhdGZvcm1z
IGludG8gYSByZW1vdGUgbGFiLg0KMSkgQ2hhbmdlIHRoZSBwb3dlciB3aXJpbmcgc28gdGhhdCBl
dmVyeXRoaW5nIHBvd2VycyBvbiBhcyBzb29uIGFzIHRoZSBBQyBjb25uZWN0b3IgaXMgcG93ZXJl
ZA0KMikgUG93ZXIgdGhlIFVTQiBzZXJpYWwgY29ubmVjdGlvbiBmcm9tIHRoZSBVU0Igc28gaXQn
cyBhbHdheXMgb24NCg0KTGV0IG1lIGtub3cgaWYgeW91IHdhbnQgdGhlIGluc3RydWN0aW9ucyBm
b3IgbWFraW5nIHRoZXNlIG1vZHMgdG8gdGhlIGJvYXJkLg0KTm90ZSB0aGF0IHdlJ2xsIHByb3Zp
ZGUgcHJlLW1vZGlmaWVkIGJvYXJkcyBmb3IgdGhlIENJUCBsYWJzIHdoZW4gdGhlIHRpbWUgY29t
ZXMuDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiANCj4gVGhhbmtzLA0KPiBKYW4NCj4gDQo+
IC0tDQo+IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gQ29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRk
ZWQgTGludXgNCg==

