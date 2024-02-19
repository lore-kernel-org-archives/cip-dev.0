Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45BEC48BC3
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 13:54:41 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.86])
 by mx.groups.io with SMTP id smtpd.web11.39324.1708341574736127997
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Feb 2024 03:19:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NByt78Vc;
 spf=pass (domain: siemens.com, ip: 40.107.6.86, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mro30TIRMaXSDT3syND7rUaRQ8vhItupP4dz9Ai4QKeGp0SPaXx2UM7KmLQZooAdyGQYX+zOb4Q3RdWigHNtJ3ZnP+S+ZXs+DIllqG14Bo3lHszBtuTaAeg6WbT1TN+NqBWzsPhAVfQxt+qg9ANz/rkEcEyBhSjCSFp7leg1Pmu6HJzAsU5OnNEvpU4rv3xXZY8IPuvrsFKlGv5EdPxuJo94ZsNPdZqKDMoeNiM88H1irlhhSgy9NFx1trd+dES+JkLRri9ZopSUBdLIqico28x44++PQB/ZiNqBnH13BDh5E9VmzGeWr3lLGE5zw6h1XKXl9zeZP82QF7goyHHjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaPo6gSva/sHJDubCEHGrZlQ+DPaq3boaHIvggxOSmg=;
 b=oAmcaeAQxLE4+Ry5XfDIsWoYJg2VTSpXj8YnEOeHF0ZwfLg9fWzig+zat1PDL1DPcyWMgeMNJwMdk99O6win8x47WTIBBDI/jBSHGt7L25MRgYSMZaiaLfYyDB8ph/LSQbrarDqzj0LHLQbLAgQYcysPTGwXIqie/CoqwYu72c96bqnVcnv6vWfKmRRFeo2uJzrMvdbeqpvSZviUZ9IbQUUzjdFcMjFthZizzuJIU9kWscinvtim8wvuKn8/zzJSjs/DrSW6//aBF7j0HujJjArKv8o+dcQS9KSQpuaKmmueUq4Y9GpCmTpK+5LVgIpTprPv09mKUhCRdVEAymWn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaPo6gSva/sHJDubCEHGrZlQ+DPaq3boaHIvggxOSmg=;
 b=NByt78Vc9eyVNlo2XBWAX8zAqF+Zm5N9/PkxJuO+2KdNeF/Oi02oslo5Z5iVt+2/s7rGoHxtYXmhUS6RLHNWK7bvsMOgIUycPN/4im0RjAumnQI56LB0aqvSezE9YIwCRb7Cui8unAr/CkbGDGxDTMfhIYbGy2RhOIrYDTWVLIPia52aavTOVhe45qVDhXEwkfgPhBcCbAeDg7vsalyPo9zS7u2VTmuxs9AN50fSAONSUjMre/Ez4bGvF/ugQsGIWOzayt9PY6seLLtCqCXnUc1ckITbbA1hi4CSAh0GisC5jSBzMO9KnPr18OAiJ6ono40lPFMPc4oZKwFsJdSbBg==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB4PR10MB7037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 11:19:31 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 11:19:31 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "shivanand.kunijadar@toshiba-tsip.com"
	<shivanand.kunijadar@toshiba-tsip.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "isar-users@googlegroups.com"
	<isar-users@googlegroups.com>
Subject: Re: [isar-cip-core][RFC 1/2] copy and symlink dpkg db to ro-rootfs
Thread-Topic: [isar-cip-core][RFC 1/2] copy and symlink dpkg db to ro-rootfs
Thread-Index: AQHaU3N2l6KjJYrAaEGInKVEOq7P/bEHGDsAgAEOmoCAAAJhAIAJeuYA
Date: Mon, 19 Feb 2024 11:19:31 +0000
Message-ID: <aa3c14c1ba63829ed2ca07a600777498b0e7e1c7.camel@siemens.com>
References: <20240130115648.311177-1-felix.moessbauer@siemens.com>
	 <20240130115648.311177-2-felix.moessbauer@siemens.com>
	 <29de90aa-1a30-4f17-9538-e6a2334bc343@siemens.com>
	 <cd3b8b6b9d762cda263489202a5c16ecbb3fe68a.camel@siemens.com>
	 <464bd7dc-85a8-4fd5-8452-256c02f60ff4@siemens.com>
In-Reply-To: <464bd7dc-85a8-4fd5-8452-256c02f60ff4@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB4PR10MB7037:EE_
x-ms-office365-filtering-correlation-id: 22f57077-8e8e-425a-78c7-08dc313ca503
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cgfP0NwHQeCWHl0ZEJD93qlZ1zJINXQ1i+yLfVrHfAvmTKeWauwNzCUHuj5hrhrDlSwi66rDjFV5hRqhy92i2sn3bGZRxeLxVRTeQCGWuABQx4nFY7MCVZFJdf3AiAtf67xGMKfIH3Fb/Sm/oALVj5ZL8CeRF6oZTiv8XDbiudSDIF+8UfSlmqHu9XA6RGKZQKfKXMucrJQPpJYqDpcTquhYEhkOAYyjpxc8zmzKrcH+cQsMzo5ogtZCqebBQ2jOCkcroPtKE118e+DaANKF7Z13uNIuSIa949fQ/S0/yPp9u4vmwc2VZaB05ULGKKoDR+ZbdFXGOzOIWmJdoQY48UFQhdUp9ealYef25J9Fut2KSeu8qv1Fv4TwMs+RmxLLXKdjOtv4Nvy/TyWbTVwJ2UHUBIKR+VKa35IlYtWueJL77aWykEc9O1Iv244GhYwr8oWdazDGPGPT00RCl7e5E0CPfprccPwnzPcZ1lAiXDEFNCKrwTHM53o3pA3Y/MkTsNSxItoqSt9/o/370IZOrxCQ23cKDK7zwY/z7HWvQJfOKQg7H/ClxS4PBWl2Nxhf/qguS3GTkXeMZX6KoTT0BDIQEqkFon1FD32b0jJr5s0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UUx4Q0FqTkNNbmtGUTlvVzNjb0hjVzFkZ0VTUGYxbGhXUnBoRkt3ckVSSmQx?=
 =?utf-8?B?RjFZSExRQ2Rmckxwalp1dDNsWU1TYXp4UGgyall1ZHl4eGc2YUZLemVJK3cz?=
 =?utf-8?B?YjRRKy9EZjJxUHYwQkp4K0VCWFhOaGs0MGEwVVl0N3dIZThJaWpnL1dWOTJG?=
 =?utf-8?B?c3REbHN4NnBSTkY4djdaRk5Jc0pzM3FEOFhLSFNneFVxcHM3MHJraHJlSjNI?=
 =?utf-8?B?NmtoNVd2VHlaQ3p3UkxvNm5sa1F1ejVPVDFIdTZTSXZjRlNjNUxlYWtyU3lY?=
 =?utf-8?B?VzVLcjRERE9UVk41bzhaazUyd2E1K3M4NGswZWFGN1Z4RlgwQW9zQjFhNEE4?=
 =?utf-8?B?ZjZoM2J2N1I0SkY3bzc4LzlVejRmT2l3cFJieUREcmw3eUNFUXRFWGtyQU9U?=
 =?utf-8?B?ZG02Um1NQlE5ODBwckVjSktzRmFCRHIxNGo5djZTSXBlRkFnSkl5S3BzZzJL?=
 =?utf-8?B?bVBzblljR3JabDhpcHpMQS9QQzZSWUt5T0pDRUdEb3hPOCtKSVB5NDNleUFq?=
 =?utf-8?B?TjE1S2EwdVNVYVhZdkxUWEtIVml1REZhYjUrdEUyQjlhTXo5TFBFZ3hEaGx6?=
 =?utf-8?B?MnVsb3cwSXU5cXd4UlRlaTd6RlpxUXpPQmRld1p1MmY2dWk4TlZvYkQ1T0Rs?=
 =?utf-8?B?M3IvUVdhRTBIblExTnlDaExTM1lUZW8rb1oyZ1J5aktJRHpOYnpkdEx3WnpI?=
 =?utf-8?B?TldDTnRLN3M3UVBVQ0dEWFp3RzJSdkNkZUI1bnhDYURTLzFJSm1VaVFSREN1?=
 =?utf-8?B?WTd5c3RGM2IzOGh3K2UyQllGNGJaUHhhVjIxQ3NFNHNZUUpVakFpMzNmb2cx?=
 =?utf-8?B?U0tBSnBXbTVTUlI5cXRxblBRZENSdGJvd1V1aXIrdmQ1dUZDT3F2SHBtUG9u?=
 =?utf-8?B?TGpZRDQ5bFFtQllJaDEzYjZRRlltQThxblM0VE40eFFnbFhKZWNPcFRXK3ZB?=
 =?utf-8?B?VEJET0haV2liSWFWZFI5UzVUK1NVMmxaUlFkdGVzYnJYYVdsQTVXY0JPcUpp?=
 =?utf-8?B?dW5hRGVYUHEwWk9uVkxCSWM2NUNoV1hZZEIydE5jM2RuZUo2dmZEQkdjOEZl?=
 =?utf-8?B?RCtJd2k3b1lPbVhCaDdEcFZxODFqa0JidnREbGFMZjRKM3cvcEdoOXhIc1Ro?=
 =?utf-8?B?Mm5JLzc0SVhHRGhDa3NDbU51djJZdUtpSllaRTM3VDRTT1YxWXlHMWdxcFk4?=
 =?utf-8?B?amNMN2FvbWs5dnZ5RW9ucjE5M3VsNE9lNTVmUGJkeW1ZU2pmSmJjd1VxTUdm?=
 =?utf-8?B?R0QraVduYVN3bWdyWWV3QmgrRjVjV05DTEhPdjd3M2IvclZPT203ZUwzS3RS?=
 =?utf-8?B?eVhJRVBGODFwWEpSSzZxT21xUmIvZEU5cUJBN1dkVkxSZFIvUXZvbkhhYlhy?=
 =?utf-8?B?UkxUbVpjZnd4aFcxOWRvVkI4b0k4STRuVFZCSUJ2bnpGajZWTGVnY25CandK?=
 =?utf-8?B?VXFwNlFCSDBwVG8rOGNBajJyUlVRK2ZYMjNmcGxGaHlhVFg4TU10ZlVKNDVh?=
 =?utf-8?B?TFRDTTl3cktPMkNaRVZqNDVQL2l2WVdrb0hpSWYrMk5RS3lJQVBvTjh6bWFS?=
 =?utf-8?B?bTZNYXZQb0ZMc2YwSlBvOG14U2FQRk9qeE5WSnRBTUNDQjZTcUlYVDlRVVFL?=
 =?utf-8?B?bG51ckY5SGtQLzBlelBYb1MvLzBaYWZQdldwQ0M0NW1IOVVIRDUvSUtmU3pR?=
 =?utf-8?B?NjdkZEJQOVErVlpldDFVekVDc29ZNGpIclJyV09kL21UNnlrSFRUd2VseVNt?=
 =?utf-8?B?QlFGR2VSS2tjZnBkb2RHdVp2SkFTUGl0QkN4MGQycm9iNEZjdjlLc2FiUi9B?=
 =?utf-8?B?c2ZPVWRJS0pDaUpUVkx4eHFUWDVhMzFIUWphM1dsdUFmaE00d2FpVGwvQitE?=
 =?utf-8?B?UnZ2Q281U1Arc1ZFR3YzTytMeFFyWUllOTFIRWlPV2tXYUFoR1dSYXVyM2dm?=
 =?utf-8?B?Zlprd3pYR3Y2UVk0SExRK2Q0UzZST0ovclBBRWp5ZEpKVGdFV1VCTlBMc05M?=
 =?utf-8?B?eDVmb2tmZWFMMmFJTGxJY2VSMHdqYTZCQWc4a1MvYlpnNlhKalFRRkwzLytV?=
 =?utf-8?B?MFlFMkZLdTBieTFONUgvaHE0cjV4YTVoWTA2ZUVrUitHbEtsUE0vdVRaalcz?=
 =?utf-8?B?ajR0a240ZzF5YW9Tb2tESUdBZ3Q5YXZXMDNwNERiMkhGdDFXUHRINzErUzhh?=
 =?utf-8?B?d1NlR1A2MTEvK0pSNzVnUGwzc1lTbHZ2WkVlQ1dzaGp0Sk1HMy9qYlUxR3p4?=
 =?utf-8?B?WVJwRERyZjB6WGNwT0l4ZThnUkV3PT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f57077-8e8e-425a-78c7-08dc313ca503
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 11:19:31.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOWKqhHZUSA2kKU12/f5Ce39Rr50XZVUtsg8JlEXkXdQ1NGMKnifknNlLmoCsDFkTxBqw25iLYXHPmp+Y88Jn9Uw9g2PQLjUEX7HjE/IK1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7037
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAF99DAA88C1D842BF50E8763FE6FF4B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 13:54:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15034

T24gVHVlLCAyMDI0LTAyLTEzIGF0IDExOjMzICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiA+
ID4gPiDCoGltYWdlX2NvbmZpZ3VyZV9mc3RhYigpIHsNCj4gPiA+ID4gwqDCoMKgwqAgc3VkbyB0
ZWUgJyR7SU1BR0VfUk9PVEZTfS9ldGMvZnN0YWInIDw8IEVPRg0KPiA+ID4gPiDCoCMgQmVnaW4g
L2V0Yy9mc3RhYg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2NpcC1yZWFkLW9u
bHktcm9vdGZzL2NpcC1yZWFkLW9ubHktDQo+ID4gPiA+IHJvb3Rmc18wLjEuYmIgYi9yZWNpcGVz
LWNvcmUvY2lwLXJlYWQtb25seS1yb290ZnMvY2lwLXJlYWQtDQo+ID4gPiA+IG9ubHktDQo+ID4g
PiA+IHJvb3Rmc18wLjEuYmINCj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4g
aW5kZXggMDAwMDAwMC4uNzY0NTNhYg0KPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ICsr
KyBiL3JlY2lwZXMtY29yZS9jaXAtcmVhZC1vbmx5LXJvb3Rmcy9jaXAtcmVhZC1vbmx5LQ0KPiA+
ID4gPiByb290ZnNfMC4xLmJiDQo+ID4gPiA+IEBAIC0wLDAgKzEsMjYgQEANCj4gPiA+ID4gKyMN
Cj4gPiA+ID4gKyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiA+ID4gPiArIw0KPiA+ID4g
PiArIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMjQNCj4gPiA+ID4gKyMNCj4gPiA+ID4g
KyMgQXV0aG9yczoNCj4gPiA+ID4gKyPCoCBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2Jh
dWVyQHNpZW1lbnMuY29tPg0KPiA+ID4gPiArIw0KPiA+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogTUlUDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyMgTm90ZTogVGhpcyByZXF1aXJlcyBk
ZWJoZWxwZXItY29tcGF0IDEzLCB3aGljaCBsaW1pdHMgaXQgdG8NCj4gPiA+ID4gYm9va3dvcm0N
Cj4gPiA+ID4gKw0KPiA+ID4gPiAraW5oZXJpdCBkcGtnDQo+ID4gPiA+ICsNCj4gPiA+ID4gK1NS
Q19VUkkgPSAiIFwNCj4gPiA+ID4gK8KgwqDCoCBmaWxlOi8vJHtCUE59LnRtcGZpbGVzIFwNCj4g
PiA+ID4gK8KgwqDCoCBmaWxlOi8vY29udHJvbCINCj4gPiA+ID4gKw0KPiA+ID4gPiArZG9fcHJl
cGFyZV9idWlsZFtjbGVhbmRpcnNdICs9ICIke1N9L2RlYmlhbiINCj4gPiA+ID4gK2RvX3ByZXBh
cmVfYnVpbGQoKSB7DQo+ID4gPiA+ICvCoMKgwqAgZGViX2RlYmlhbml6ZQ0KPiA+ID4gPiArwqDC
oMKgIHJtIC1mICR7U30vZGViaWFuL2NvbXBhdA0KPiA+ID4gPiArwqDCoMKgIGNwICR7V09SS0RJ
Un0vY29udHJvbCBcDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgJHtXT1JLRElSfS8ke0JQTn0udG1w
ZmlsZXMgXA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgICR7U30vZGViaWFuLw0KPiA+ID4gDQo+ID4g
PiBkcGtnLXJhdyB3b3VsZG4ndCBoYXZlIHNpbXBsaWZpZWQgdGhpcz8gSSB0aGluayBldmVuIGNv
bXBhdCBpcw0KPiA+ID4gbm90DQo+ID4gPiBjdXN0b21pemFibGUuDQo+ID4gDQo+ID4gRFBLRyBy
YXcgaW4gZ2VuZXJhbCBpcyBvbmx5IHVzZWZ1bCBmb3IgYSB0cml2aWFsIGNvcHkgb2YgZmlsZXMg
aW50bw0KPiA+IHRoZQ0KPiA+IHJvb3Rmcy4gSGVyZSwgd2UgbmVlZCB0aGUgZGViaGVscGVyIGxv
Z2ljIHRvIHByb2Nlc3MgdGhlDQo+ID4gdG1wZmlsZXMuZC4NCj4gPiBBbHNvLCB3ZSBuZWVkIHRv
IHVwZGF0ZSB0aGUgY29tcGF0IG1vZGUgc28gdGhhdCB0aGVzZSBkZWJoZWxwZXJzDQo+ID4gYmVj
b21lDQo+ID4gYWN0aXZlLiBJIGRvbid0IHNlZSBhbnkgdmFsdWUgaW4gbWl4aW5nIHRoaXMgd2l0
aCBkcGtnLXJhdywgYXMgbW9zdA0KPiA+IHBhcnRzIHdvdWxkIG5lZWQgdG8gYmUgd3JpdHRlbiBt
YW51YWxseSBhbnl3YXlzLg0KPiA+IA0KPiANCj4gV2l0aCBbMV0gKGdyYW50ZWQsIG5vdCB5ZXQg
dXBzdHJlYW0pLCB0aGlzIHdvdWxkIHNpbXBseSBiZQ0KDQpUaGlzIGlzIGFscmVhZHkgbWVyZ2Vk
IGludG8gSVNBUi1uZXh0IChhcyBmMWI4Njc5KSwgYnV0IGFzIHdlIG9ubHkNCnJlZmVyZW5jZSBJ
U0FSLW1hc3RlciBpbiBDSVAsIHdlIG5lZWQgdG8gd2FpdCBmb3IgdGhhdCB0byBnZXQNCmludGVn
cmF0ZWQgdGhlcmUgYXMgd2VsbC4gSSBjYW4gcHJlcGFyZSBldmVyeXRoaW5nLCBidXQgc3RpbGwg
d2UgbmVlZA0KdG8gd2FpdCBmb3IgdGhlIElTQVIgdXBkYXRlLg0KDQpQdXR0aW5nIHRoZSBJU0FS
IGxpc3QgaW4gQ0MuDQoNCkZlbGl4DQoNCg0KPiANCj4gaW5oZXJpdCBkcGtnLXJhdw0KPiANCj4g
RFBLR19BUkNIID0gImFsbCINCj4gDQo+IFNSQ19VUkkgPSAiZmlsZTovLyR7QlBOfS50bXBmaWxl
cyINCj4gDQo+IGRvX2luc3RhbGwoKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqBjcCAke1dPUktESVJ9
LyR7QlBOfS50bXBmaWxlcyAke1N9L2RlYmlhbi8NCj4gfQ0KPiANCj4gDQo+IFRoZSB3aG9sZSBj
b250cm9sIGZpbGUgd291bGQgYmVjb21lIG9ic29sZXRlLg0KPiANCj4gSmFuDQo+IA0KPiBbMV0N
Cj4gaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL21zZ2lkL2lzYXItdXNlcnMvMjAyNDAyMDEx
MDEyMzYuMzU1NTY4MS0xLVF1aXJpbi5HeWxzdG9yZmYlNDBzaWVtZW5zLmNvbQ0KPiANCg0KLS0g
DQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

