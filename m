Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B11EC47258
	for <webhook@archiver.kernel.org>; Thu, 25 Jan 2024 16:17:06 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.43])
 by mx.groups.io with SMTP id smtpd.web11.20481.1706196211992429415
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jan 2024 07:23:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=n2Jvp5eR;
 spf=pass (domain: siemens.com, ip: 40.107.6.43, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwyvQ+OB8TkbpLQLya8+dmQQzHiOgic6vaZshoNNlwbIl9r2HJhLLuOEX/tFJxmX8bNze5qh2mH13cbFi215JVJS43Ohmyt/DiTEyOjVyvikrp4AXQYoiv4MSfNt4wTpjO5ORQTz8DIz9zy1qbYMstWcnP1nmI2j6tWIOgMMfs/OiJgQ9fJOJfulMR2gA6IAc4vlGa4tNMiqmP08oYxILCar1maCtrbMlNOeTKjORx3HJW1BTXdadmQtfYgPb7XBaIfR861acVw2hmGnCuafb5ykyS1+cVJP578iXfqT+WNzIZAwxbKmC7gBwZNIiYOfzWfJ+iBxwWWUt1Nx1SyNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhJ/svQS9eFyoJ98pNdWNyZC16Sw48GNWGM7t6qJtRQ=;
 b=cohRg7kwqbK/qes2dsHR72AZ6fHE5BmtkB6861+5lNR+kJOH2ZpIpUqaWYLF0h16Ezfyfhi0PwD+E2m+vSSfDlmR44/HIqV31gJFSOINeIAyzDD8LXwuF6zBHt9CeH88LNeeWxuHux5lQ5qQ/fMwNgKDZXVohmef1J39Q0sOF/NsTZLb4TJ/1DB4GdJlpnV6YzGfwa5F8MpIFfp5EQBFzgz0eIaQOrayAiupNBI85Q5ekO06tAmeKZxmKiAkiLyXlHYW+DQB8LXbFsH14v/AzyjmUraI3njbF9OLODihlauLqexhQM+bL7JuvR6mJqKn0s59ApmfK9YyTEqBxLfPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhJ/svQS9eFyoJ98pNdWNyZC16Sw48GNWGM7t6qJtRQ=;
 b=n2Jvp5eRLqDoXrr7A+LDC5TwAVY9ijnmjgMeXz5ISN5Lpfcb/DdJTZny8rtpoNVxF6Ki9h5jp64j929uFBt4KiET0EGCxdceRR27wDcOHh4+agjbZ7RnjOaS3CH8BZxQrgoymdLkSoLy+zpH0kDMaVqcY8vcd38WsaIJsXuLT4fIFsu70SaF5uUFFF+LGBcx5HGxSTmhhP2l5mXTq0qUU/wWP9/ppdEKKeFl9kS4LCXWMS9rYTvPmwQcaw6R0TuyclfhifvDs4PNtfEP/+jWSK+odYaTUaDRu5fesZqfHR4mQTiM7wi4ASKpdlI2katC2csMFDNPXfh9NlmnVU4pnA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS8PR10MB7066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 15:23:27 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 15:23:27 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 1/6] Move efibootguard specific settings from include to class file
Thread-Topic: [cip-dev][isar-cip-core][PATCH v4 1/6] Move efibootguard
 specific settings from include to class file
Thread-Index: AQHaQh0rLpUfNCRYqkuFTLc3kwJoq7DP8EIAgBrQZIA=
Date: Thu, 25 Jan 2024 15:23:27 +0000
Message-ID: <45352732c1605060d1cb630cff5e75c2fa6cd54c.camel@siemens.com>
References: <20240108102638.2966221-1-Quirin.Gylstorff@siemens.com>
	 <20240108102638.2966221-2-Quirin.Gylstorff@siemens.com>
	 <13e760a0-bbc7-4ec5-8639-80c862aa387d@siemens.com>
In-Reply-To: <13e760a0-bbc7-4ec5-8639-80c862aa387d@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS8PR10MB7066:EE_
x-ms-office365-filtering-correlation-id: ed41814f-4114-4a35-0003-08dc1db99428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 P3SUWdCV/0Y9HxYdG9jS5AfwTaqGTdoY1Cmez/j+mMhQ+DZWMd91h9w3TeipaWjcxIi4Sh4Fm4KRVOy7aY82hdZx6hMZ3yj8aM42drGVTbtMiaFWMutBoIbAYYWtquUO+PBJt3rdCg7PElKILa1FpF+inLPVCi31A0oAcUGyEec8wo5fqmhUodgf60MsMU+US+Hqezes5CB7MwXadLpyvMrX0+UhgNEEP14fvPBLfhIKlKchb3SHApfTUUn4RKk8lwd3ltu1ZlxOCmjX77Yd0k9ciibF8zdKJcdYjwWBpdZUKdB8TVWzDFG4QliZIU05MBvxek3XrFpFA51Ay4xCtFumpciEpXBrlKVrEtA4b5BcZCD+yjJ7/2Q17W4/HQOVMoM7nTDQ1Xuu357eEzk0qFzogF44Tk7obMR6BWrLvdAoEhcL8XoxuJOcIA8Yabmgtp55tSKCfiqSGPklgNVF1upfj+ZZnR8OwK6BAKNTC9oXbsgGt6hrtifAT52CRIPb3TIddsriyZb5pn/KkbfkLhgBq2CQ2ynoCRmdYB+idt0FJG3HxE4TCG7/Pt2IK+kScqzJwH+M8ag9BdyQmowL67bBod4g77e7jXrX+Tsl3Y+TEzbw26z22k/7Dg+y3la2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(2616005)(38070700009)(316002)(6636002)(36756003)(64756008)(53546011)(6506007)(71200400001)(478600001)(6486002)(83380400001)(6512007)(38100700002)(66476007)(82960400001)(122000001)(5660300002)(2906002)(66556008)(76116006)(66946007)(86362001)(66446008)(110136005)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UG03QnlTT1ZKWUo1N0hGTXRLK3lMUzRQUS8ydjBIVjZJRENhZjRiYis5cDhQ?=
 =?utf-8?B?bXBaTThDK1ZHMUphZTZueUxxN3pqbTlDODZyZTFGZFM5d1EzUzZ6TnBucm1D?=
 =?utf-8?B?a0ZiemNLNW1XeTlYNkp0N2JUWEJJTmhhQVdCbWZYc2NFSDJSU0tDM0MyTlVx?=
 =?utf-8?B?WU5SaXcrZkRDc3lETXR3bCtnSGRwNmIvc1NMVnJON0RteENSSmNoUkQwM1V4?=
 =?utf-8?B?Q3V2QjZsOE9JbzcybkxQZ2pwcG9vZlBRSlZLUis3Z2c2SHRVT0F2VHg5RFAz?=
 =?utf-8?B?ZlN0MXF3aCs3V0NHVklhUkFkZFJqUDloWTdjb0xXa2N3WE5JZzFDbmxOdVEy?=
 =?utf-8?B?K3BBUXh5ZmR4c0lkejBDTzh3V3NseXRUc1VTU3VNMjRFVm1scldvMTYxSW16?=
 =?utf-8?B?QmFWNmc5d05La01XbHNwWHlSdVJWakFWb3RCZzRZTHRBcGhQalJiWFF6Tjc2?=
 =?utf-8?B?UlRCZkFhN0FMZVdFSHo2SDB2aC95WmE3RlVPajJRNTBkSWNHU1plRitacTNR?=
 =?utf-8?B?TlloaGpwZGhUYlZ4RUtXYkNQUk02cU5oSFlNOVNPVDlSY3VEeHNvbUdIS2lz?=
 =?utf-8?B?NmQ3OHM2NDJtdkpkRk9jeHF3TWVuWTBJTlE1czRJM0pzWTdlUVZ0NkZRNTgx?=
 =?utf-8?B?bUNpdWU1WStUZlhmcnUxM0ZWZUlnODMrZjVkSDRlbXNZeHRNaStvWWVGVGQ5?=
 =?utf-8?B?K056anMxL3RmN1o3WFhTK1VEZk90ZlRkenhLd0tDK0JZSHcwcklzbllhSzly?=
 =?utf-8?B?TngxOWx6Y0VYU296RTF2M01TL0dmZFpUamYzNG9IVE0zRWlMeHhGSXhpUEQy?=
 =?utf-8?B?c2xrSHlTakt5K2VhRGtjYTJVL2JMdW1sZVluQkwzdkE1SVBQR0dxbm1zTm8w?=
 =?utf-8?B?RGtaZVk0NE1IT3liNjd3MkNDYVU2NzF5bFQvSFdnRDZGeEpXd1p0cWdKUzlv?=
 =?utf-8?B?RDBMYlFCS3gxSnpOc21nc1JDT2lOL1JrL2hkb2dvbytkSlFEbTRXbVFsRDUw?=
 =?utf-8?B?VVlqZ3E5ZGRZQ050T21DRVU4SXQ4cEFORWpaSUk3YWROSm5MeHBZOThaWm9T?=
 =?utf-8?B?OS9OZjVqVlhMcjJMSlBNZEdINFVpU1c3aW9YanFsTGJZR29mclprcHF6WklV?=
 =?utf-8?B?QXU0SkRnNVhoRUFOSU10RUwvUEoxd0pmMDllRWZ6a2ptckh5dkIwa0wvZ3hx?=
 =?utf-8?B?QWVUUC9OVzgzVnRJdXZ2cm92ZnlBVFNmanJnZHB5U0tLMGxDZmhNeTQvc0hO?=
 =?utf-8?B?UmhFR0xpSWloMkE1UHRZei95WllmK2s2UXdKeTZ4aXlyazE1cWE5Z0lQUURK?=
 =?utf-8?B?T2hORzdGSUViR0pyT0FMSm56TzV6MGJFRVlFQ2tiMWlYV3NBY1UvOUdEa0d4?=
 =?utf-8?B?UHVGeks0Qm9UOGlYQm54MTRtRUF3S3dqQzMrd3daTjdyZGI1Mk5DWWhZcWVH?=
 =?utf-8?B?WUpiL2VvSVZYQTFzTlNubmJ5cGxTMTRHNnpQRDRlOGt5bDhGVWx3Wm1wQW5n?=
 =?utf-8?B?Wm9WVGx5cDhmU3BYaDFtY0cwUnY0MXFSdHRNWHQ5eHozRDZ2WWEvaGVQMU1Y?=
 =?utf-8?B?ZHYrZzFLSEp6REhodDNqUGE0dGlnay9rZ1diNTA2b01ySHlqTEFTckM3ZUFL?=
 =?utf-8?B?bWVJdlhoNHphRHNJWHIyQXJVaS94eEtJOFp6K3FLMS9WbFlYWXVmVjhqRyt4?=
 =?utf-8?B?azc3WGFuNzNaMWE3VHpsSlBNbXZNWUZ6RDJYZmdVNUpVeWE5bHN6d2FjMjUr?=
 =?utf-8?B?d1Q1WUtYakx5dW1FZjJ4Z29EaldieElqR1JUaVN6OGxFTUM1Y0lvbGJEbHQr?=
 =?utf-8?B?Y0QvdnhlK2MvZ3ovVzZHQlJJTVZjdG5udjVjc3dSUmVRNDJoZGhPS3RNK3pw?=
 =?utf-8?B?S2pDREx6V21Nd0NSdHQycTVURmNDRWE3a3BaVVNlaXBUd1l0clBCL0k0L0xn?=
 =?utf-8?B?cXRxNWxoL1ZjOVR5Tmd5YU8xbTVOYStBakxNcWQyS3V4Wi93c2lvWGhsK0xp?=
 =?utf-8?B?TU9QVjE5WVFSeERRMG5KUExJUDRBODlJdnl1aXdhVFZSZmRITXRXdm9aRnZE?=
 =?utf-8?B?N1RyOFFQMlRqWmNhSFcycW5pdjd2cFdMOFQ5UnN0UG11MU5Melo4cjI4RUFl?=
 =?utf-8?B?cXA1L0RzcXJneStlcldNUzYveUY2bmtLRWlLcEVJZVc4R0o5eXBEYVNCaXpM?=
 =?utf-8?B?MnRxWTA4UTBQdDVMYWxKRVVyWk9xVjNCZG9aTzM3Y3pBdGJvbWtJK1MrWGwx?=
 =?utf-8?B?RUpaSFJnblBLUXlkaEtTQmpoKzJnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ed41814f-4114-4a35-0003-08dc1db99428
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 15:23:27.1254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLtgioWI0O6LL0WTvPJw0lOvquruET+KrXm1AadlRoC8Fkn+ISFQtvjBSh/EdeHE3QNg/dPZE06T0ppagRBo0Te/dXI0ISw/ugDIs4eUnsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7066
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC5E0B6D1F357F4FBB3B5EDA0007A867@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jan 2024 16:17:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14461

T24gTW9uLCAyMDI0LTAxLTA4IGF0IDE0OjU0ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwOC4wMS4yNCAxMToyNSwgUXVpcmluIEd5bHN0b3JmZiB3cm90ZToNCj4gPiBGcm9tOiBRdWly
aW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+IFRo
aXMgaXMgZG9uZSBpbiBwcmVwYXJhdGlvbnMgdG8gcmVkdWNlIHNpbWlsYXIgY29kZS4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNp
ZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+IMKgY2xhc3Nlcy9lZmlib290Z3VhcmQuYmJjbGFzc8Kg
wqDCoMKgwqDCoMKgwqAgfCAxNyArKysrKysrKysrKysrKysrKw0KPiA+IMKgcmVjaXBlcy1jb3Jl
L2ltYWdlcy9lZmlib290Z3VhcmQuaW5jIHzCoCA5ICsrLS0tLS0tLQ0KPiA+IMKgMiBmaWxlcyBj
aGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+IMKgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGNsYXNzZXMvZWZpYm9vdGd1YXJkLmJiY2xhc3MNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvY2xhc3Nlcy9lZmlib290Z3VhcmQuYmJjbGFzcw0KPiA+IGIvY2xhc3Nlcy9lZmlib290
Z3VhcmQuYmJjbGFzcw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAw
MC4uYmM5OWQzYQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9jbGFzc2VzL2VmaWJvb3Rn
dWFyZC5iYmNsYXNzDQo+ID4gQEAgLTAsMCArMSwxNyBAQA0KPiA+ICsjDQo+ID4gKyMgQ0lQIENv
cmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiA+ICsjDQo+ID4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5z
IEFHLCAyMDI0DQo+ID4gKyMNCj4gPiArIyBBdXRob3JzOg0KPiA+ICsjwqAgUXVpcmluIEd5bHN0
b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gPiArIw0KPiA+ICsjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gPiArIw0KPiA+ICsNCj4gPiArSU1BR0VfSU5TVEFM
TDphcHBlbmQgPSAiIGVmaWJvb3RndWFyZCBsaWJlYmdlbnYwIg0KPiA+ICtJTUFHRVJfSU5TVEFM
TDp3aWM6YXBwZW5kID0gIiBlZmlib290Z3VhcmQ6JHtESVNUUk9fQVJDSH0iDQoNClRoaXMgcGF0
Y2ggbmVlZHMgdG8gYmUgcmV2ZXJ0ZWQuDQoNCldlIGNhbm5vdCBzaW1wbHkgYWRkIHRoaW5ncyB0
byBJTUFHRShFUilfSU5TVEFMTCBpbiBhIGNsYXNzLCBhcyB0aGlzDQpsb2dpYyBpcyBleGVjdXRl
ZCB3aGVuZXZlciB0aGUgY2xhc3MgaXMgaW5oZXJpdGVkLiBBcyB3ZSBpbmhlcml0IHRoaXMNCmNs
YXNzIHRyYW5zaXRpdmVseSB2aWEgc3d1cGRhdGUuYmJjbGFzcywgd2hpY2ggaXMgYWRkZWQgdG8N
CklNQUdFX0NMQVNTRVMsIGFsbCBpbWFnZXMgbm93IHdpbGwgZGVwZW5kIG9uIGFuZCBpbnN0YWxs
IGVmaWJvb3RndWFyZC4NCg0KSW5oZXJpdGluZyB0aGUgb3RoZXIgY2xhc3NlcyB3YXMgZmluZSBi
ZWZvcmUsIGFzIHRoZXkgZGlkIG5vdCBjaGFuZ2UNCmFueSBpbWFnZSBwcm9wZXJ0aWVzIGV4Y2Vw
dCBpZiByZXF1ZXN0ZWQuDQoNCk1heWJlIHdlIHNob3VsZCBhbHNvIHJlbW92ZSB0aGUgSU1BR0Vf
Q0xBU1NFUyBwYXJ0IGZyb20gdGhlIGxheWVyLmNvbmYNCmFnYWluLCBhcyBpdCBpcyB0b28gaW50
cnVzaXZlLg0KDQpGZWxpeA0KDQo+ID4gK1dET0dfVElNRU9VVCA/PSAiNjAiDQo+ID4gK1dJQ1ZB
UlMgKz0gIldET0dfVElNRU9VVCBLRVJORUxfSU1BR0UgSU5JVFJEX0RFUExPWV9GSUxFIERUQl9G
SUxFUw0KPiA+IEVGSV9BUkNIIEVGSV9MSUJfQVJDSCINCj4gDQo+IEVGSV8qIHZhcnMgYXJlIGxp
a2VseSB0b3BpYyBmb3IgcGF0Y2ggMiwgcmlnaHQ/DQo+IA0KPiA+ICtJTUFHRV9UWVBFREVQOnN3
dTphcHBlbmQgPSAiIHdpYyINCj4gPiArDQo+IA0KPiBFeHRyYSBuZXdsaW5lIGFuZCBFT0YuLi4N
Cj4gDQo+ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9pbWFnZXMvZWZpYm9vdGd1YXJkLmlu
YyBiL3JlY2lwZXMtDQo+ID4gY29yZS9pbWFnZXMvZWZpYm9vdGd1YXJkLmluYw0KPiA+IGluZGV4
IDBmMjZiN2QuLmY1MTJiM2MgMTAwNjQ0DQo+ID4gLS0tIGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9l
Zmlib290Z3VhcmQuaW5jDQo+ID4gKysrIGIvcmVjaXBlcy1jb3JlL2ltYWdlcy9lZmlib290Z3Vh
cmQuaW5jDQo+ID4gQEAgLTEsNyArMSw3IEBADQo+ID4gwqAjDQo+ID4gwqAjIENJUCBDb3JlLCBn
ZW5lcmljIHByb2ZpbGUNCj4gPiDCoCMNCj4gPiAtIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcs
IDIwMjANCj4gPiArIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMjAsIDIwMjQNCj4gPiDC
oCMNCj4gPiDCoCMgQXV0aG9yczoNCj4gPiDCoCPCoCBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4u
Z3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+IEBAIC05LDkgKzksNCBAQA0KPiA+IMKgIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ID4gwqAjDQo+ID4gwqANCj4gPiAtSU1BR0VfSU5T
VEFMTDphcHBlbmQgPSAiIGVmaWJvb3RndWFyZCBsaWJlYmdlbnYwIg0KPiA+IC1JTUFHRVJfSU5T
VEFMTDp3aWM6YXBwZW5kID0gIiBlZmlib290Z3VhcmQ6JHtESVNUUk9fQVJDSH0iDQo+ID4gLVdE
T0dfVElNRU9VVCA/PSAiNjAiDQo+ID4gLVdJQ1ZBUlMgKz0gIldET0dfVElNRU9VVCBLRVJORUxf
SU1BR0UgSU5JVFJEX0RFUExPWV9GSUxFDQo+ID4gRFRCX0ZJTEVTIg0KPiA+IC1JTUFHRV9GU1RZ
UEVTOmFwcGVuZCA9ICIgd2ljIg0KPiA+IC1JTUFHRV9UWVBFREVQOnN3dTphcHBlbmQgPSAiIHdp
YyINCj4gPiAraW5oZXJpdCBlZmlib290Z3VhcmQNCj4gDQo+IEphbg0KPiANCg0KLS0gDQpTaWVt
ZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

