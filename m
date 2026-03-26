Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFBA10A1E63
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 10:44:50 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45182.1774521884713865682
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Mar 2026 03:44:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=naNP/bkl;
 spf=pass (domain: renesas.com, ip: 52.101.125.31, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onGUE6ZihNH/NHBVaSPzFaFAChBOChx1TBnPGrcnmK/yzeFX9iQhbX8kKM0aFWJ4zmscFh+ZgUc4FJgMlJeDxSZTkQf68eIDz2BOzm33XNrz0CKxci0IV53tGv4vfQWjjPVS4nF9vwBjq8xg9KA93fprHr6SWlR1OqwQQN6nflRa+vRwghUuRx1TEtDxMI8/ovX2Wewxa+PXQ+PNrIyv/5lRhDHAZeNU/HEWANlSNtQVBEw2bESmkd/zzRZN6BdvO/28HNrh50q2oXq0mqVIR3344tCtGGQccVWhjcVPTXobn5rF0c8ib3nYqtbeIQuHfd0z6VO/Km6Qp9MYyjzqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGQIJODzd/nSWxcMF3ZwlYogBnDwIEzocH9z0h60ZTo=;
 b=XA5KLOqHdtTYATK8i/RlDgNVJu00SYXSFpoXJW40VMV0B+Jqx4Gfn4WsexFfJoIg4g/MWicseM25BeBEOAT65DRLXOvNhE9SDa3/XV9Dg1XZDLXUkQOWin1G4/tSIkxJXUChl4gJmpCoQZTbHHUKQUtnnHJcTB6bFuW6Y84zQu3MXWAUqNpgXo9BBi1DKcddPAbk5vg5ud8UJvoZuQVBUQKp9mIJ4MEkDMVWJ0UqtHT0ep0ES9tnb2+C5YM3Qo+udR3PH+uFDnVP7jAyX8LPiHSv/fKiHF0CKgWOuLHspHhlNYAysHkj7szDFxd42HpCsVnlPVLdJMiN3Mh9DTTWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGQIJODzd/nSWxcMF3ZwlYogBnDwIEzocH9z0h60ZTo=;
 b=naNP/bklS+2N+FvJEYufeKNKUs+knAG4Jg21OOoYfX2ZewA8Gk1LvfDMsR547B/CPXaenSRSNxd/PkXOlYo2Ub4KQmo1yaMk2BKRMeyVS2PwBg1jylLYcflqxl0yq0ESSrb71PuAfN4pp9ugPgYel9gWaqRwGTVJfAreF1k2nJo=
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 by OS7PR01MB13792.jpnprd01.prod.outlook.com (2603:1096:604:368::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 10:44:41 +0000
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a]) by OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a%3]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 10:44:40 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>, Jan Kiszka
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [RFC cip-dev][isar-cip-core][PATCH] Use pipeline id instead of
 CI_COMMIT_REF_SLUG
Thread-Topic: [RFC cip-dev][isar-cip-core][PATCH] Use pipeline id instead of
 CI_COMMIT_REF_SLUG
Thread-Index: AQHcvFKdSyMTKooIOE+kLVF07q+qA7W/UfWAgAE8FYCAABPkgA==
Date: Thu, 26 Mar 2026 10:44:40 +0000
Message-ID: 
 <OSZPR01MB8123DFCB21843C088103B7F2B756A@OSZPR01MB8123.jpnprd01.prod.outlook.com>
References: <20260325122615.424136-1-Quirin.Gylstorff@siemens.com>
 <100318a9-325d-4d1d-a2b4-36ba664ae048@siemens.com>
 <ace242be-8c6f-4b99-a1a7-20fabb20edae@siemens.com>
In-Reply-To: <ace242be-8c6f-4b99-a1a7-20fabb20edae@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8123:EE_|OS7PR01MB13792:EE_
x-ms-office365-filtering-correlation-id: b160ce2f-0a49-4d98-9824-08de8b24af44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 WLYyiVkuYH+tIaNBMVnORfud8AAtKserP6tMxuD2r6K+u52QKRotO6Ys1VoQcPvkw2oK/AcYbb9zpAL0XPtsz3xM4QS4fp/DeWVwVS8DuIGXyErilTXa3jhFUCLFqdxpRlSV9kWk9ICc4OtulAiMVrnNMePMapHvdOkcqnKn1+UBbfCRCD8j0U1zztQwsZRj06eZEVaEVsulGwy2eJadG14ZGALRlI7tXNzMBrLm7yQtoWe6aswq7U+BLsBUKe8BlY8MbGzEaUQcI5LBG7zXXOqN6EffK8DTZHuU8mJ9zoXOFkMatYu9dNPV4TQ8Ha5APClwXui8pWFCp104gwux7zH7J1GPst4IOvTT57go+3cAEF0vLPB4VveG88OPZe5Ms3sXBmzNS4aAQJpFNhuDqYDZHEVtDHn2pveckoBLSEQMMRGIm5QgSQCD40HM+1CF1YjhEL8iGIhUbL7wYN+XB7SKWK05EuixY6YyPNlIfagp0Crp3YlQt9pa+5kskab8vY+jCHr4gzFqo8CRmbYaixkbj4tDmIWUQLM20Wucehxjiv/4/bla5we/4/Bl1wIp5bwuWZXJ3R6ODfuwGcvVZrjYWaB7BTIlBZfPNd9Bmyw5hQvd+IaftCkt5QMdv1iSpYmTXdFNXR834Lf5gJTieT/cJ5HvNpogx8ynxaOaj12jBNdZlflzTyzycAOjE4NgI2bBk45/N2bgg7Kbxxd0fDuUrTJ84iynh56S/uTVzf6woEKSI+QEK/Lhn+2eYJ6yVFs66bnlxd9vWK18ngckl1MBoefO2TdteauzIIvOBks=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8123.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VGNKbUlESWNDOHpLampvdnZ2K2x0M2E5dTRJWlptdDRNNEQwQjdhaGtJQmRu?=
 =?utf-8?B?cnRmMTB6SWNxQ2MxeEtDT213U0I5anJCL1BmNktUd3J6aXpQbkRPeUZ0SVRI?=
 =?utf-8?B?bXY3UUU4Ni9YUjRLMjA1dzk3amkyN0xhQkFkdHM2aGhkUE9XMGRWODJ3bHIx?=
 =?utf-8?B?eGl6TnBlaVFCdWJuN0RNZ0tzbk1ZcS9wOStZSVZwaUtacHk0OFA5OThlWWV2?=
 =?utf-8?B?Q0xGNldnNHdLZEg1L1lHc3djdXNwQ0ZuU2pqKzlkQXhDUXV3enR6eFpiR0Yx?=
 =?utf-8?B?S3UzYjRhWjJ0MlBJL1BSeTdPUWRrSFdNTjhwUWNSU0ZKS2FaczR2dUFuRWFo?=
 =?utf-8?B?L2xReGEvV3B1YlcrVUk2TGhYNmp2VDN3OGZPUThvNWJReWZpVjdFUXQwTmt2?=
 =?utf-8?B?aDNGL2M0SXRjMXZkRkgrUmRsazEwS2ZqM05jYmpNOTVFZ1dNMnFnZWl0Z08x?=
 =?utf-8?B?ZjdBVXg0MExERWk4V3BEYjRrc29RWHg4bjA1SmVtZTFWeEZDbTZwY1hpL3B3?=
 =?utf-8?B?Tm9DaTFsbkhFSmJSelpjL2N5bEFjTWRhQ2JBUGVqUGRmK1VGdHRSZzVVZmJ2?=
 =?utf-8?B?ZU51dm5XaHQ1NU5oSTBtbnVMYm1VbTlYTU43cHdPNGZvdE5zbG1EeEV5Y3FM?=
 =?utf-8?B?M1F0VEFBejlKMHNxRnMvSjNwNGRTdGF5K3JQOC9WNE4xUGtGalFBQTUvVmpM?=
 =?utf-8?B?cVhTMCtONVVNRDlXdjVxSkptT2NFZ1YxQnJmeHR3MStiK1MyMEFKU1RvOURT?=
 =?utf-8?B?a0dVY1h6YUNha0U4WnB4Sm01MDdlVW5RUFFObmw2VVgwKzdwNXNnc2doNVZv?=
 =?utf-8?B?cWYvQTZZTkpYSDJ3alB2YThQTUN6NWdVN29CaEZ6bC9zY3ZKQlBZT1FITkF3?=
 =?utf-8?B?U3ZSajc5ZlRjbXc1WWtyREZnMEZvLzFFbVVwU3pBSHB2N2tEZktCSDdSMDlk?=
 =?utf-8?B?V3IwY2hvSWYyQlZpT05hUEppNzBHRmN6Wmdjd2orUkZQdWZHMlY1TFV4c1JB?=
 =?utf-8?B?TlFIK1k0Tk1RaTRUR3NVdkNPak9DUC9saDh5SmZjVldWdERBalRoRDVyRVpY?=
 =?utf-8?B?QmJOL0FwTHZJa3A2Y2g2ZzBEZ1UzUWlvakw2R1RSYm44blFhTUdkK0FaMWRM?=
 =?utf-8?B?eWZ2NlI4ZTJUeDlqUWhBYTdnVGdBUnRHMzExbTNUVGhFYmdpS0lNaTRieEZx?=
 =?utf-8?B?SVpkYXRLU1hJc09nSXdmNzEvcUdTTWtyZ2drZDllaXpPK3NnUnh1cE1xaTNI?=
 =?utf-8?B?em1yeCtiWGlnV1ZaTUVVQktTVXlhL1plQXVDNDZNNUZxUUw5QTVkc2FUeXNY?=
 =?utf-8?B?clg3ZEdWTDRhazNtNlc2RjFtblpNdVNQQ0FuVXRyRktsKzdnMGFxRmo0bzY5?=
 =?utf-8?B?aUxXL2xma3NyMlFlRG9EUm04NnFtdFJWK1VoSVpHVjJzMjhhcHRKTGNWTHJm?=
 =?utf-8?B?SGM0RCs5akI5WnIwYTJpdTZBWmZyUHkzb3ZlQkQ4a2p2ZVU1MzdZUFBCRmNh?=
 =?utf-8?B?UVR4QW5KQjhIbFczL01YZ29uVUl3a2dWaW10amFFSFZadFdLVXR4TjBnVmFO?=
 =?utf-8?B?SUNxajR4R2F5NHErTUlwbDdveTF3TTJQSjlSVXJTdnpBQlNONUllR21xclZV?=
 =?utf-8?B?VFE3ZVo0dzRJN3JiaUx2bFVQaEF3ZHNuK1huRnRwbWhtNHNQbEhyNjBlQmp1?=
 =?utf-8?B?aVpEaFQrV2EvQzgrUk45VjRMclZtZmZweWozcGFvd0dxdFZSYy85bmxVYUcy?=
 =?utf-8?B?UGZtdzdscVU5Zm1DMC8xQWwwREYxQVBUNndzWCtsQXVMQUMvN04xQ2ZUUlYz?=
 =?utf-8?B?SU00cmNXWWxMWUJocTFRdVpDUDNoa2FxY3d6ZWNvSFlWMWFlOWR6MW1wcXVo?=
 =?utf-8?B?NXRFZkFoQlk5cUZBNC8wQlE5VVV1QXBXY1lTNm5ETzNNWkpqbEttNlVOL0Mx?=
 =?utf-8?B?NmtvYjF2NWpWNVE4M3JuaFVYeS9vTXh3Wm5WODlBbnUwZGhXM0lpQ21FMjBa?=
 =?utf-8?B?bCs2NEg4SGxtL01XcFRMSm5CZEZ5bzRvcEJ1ZUY3YWdVdHdYMFUyK3F3bXFv?=
 =?utf-8?B?ekgyNy9QWHR6QjBKemVPSGNoVEQxbU9tQ3ljdGd2bWQ1cytRVnhqTUhwSVQ0?=
 =?utf-8?B?cEtNNXg0NU05eE1aZ2toeDdxMERyb0FaODRsanBGQW9YWGN6Ym1kaTYrc0t4?=
 =?utf-8?B?bTAyVTBDTGJidWhkUmVLcmVHWG0vTUFBNms0VU5iKzA4N1hZQWgyQ3Q5MXR6?=
 =?utf-8?B?NngxaHZQeUxza3hEVTdQNUEwMTRubXB3L0tPZHV6OGJOZDVPNDlFN2VoUGZx?=
 =?utf-8?B?SUNyNms5cnZLTUhUOUJNZnhLQkZYcmNocVFVU00vZDBvM0xJN3NTZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8123.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b160ce2f-0a49-4d98-9824-08de8b24af44
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 10:44:40.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXjSFbcQnxnSQwUGetm7PJFHEkj+QFJnrKxfRYMmot3e0/PV9PrVLqcdy4tWQO3WusbCV4Tr52LDGlRzbYE2Lv+OAbTSml8gbkp1xHiInxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13792
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 10:44:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22580

SGVsbG8sDQoNCj4gRnJvbTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVt
ZW5zLmNvbT4NCj4gU2VudDogMjYgTWFyY2ggMjAyNiAwOTozMg0KPiANCj4gDQo+IA0KPiBPbiAz
LzI1LzI2IDM6NDAgUE0sIEphbiBLaXN6a2Egd3JvdGU6DQo+ID4gT24gMjUuMDMuMjYgMTM6MjUs
IFF1aXJpbiBHeWxzdG9yZmYgd3JvdGU6DQo+ID4+IEZyb206IFF1aXJpbiBHeWxzdG9yZmYgPHF1
aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+ID4+DQo+ID4+IFRoaXMgYXZvaWRzIGVycm9y
cyBkdWUgdG8gb3ZlcndyaXRlcyBmcm9tIGZvbGxvd3VwIGpvYnMuDQo+ID4+DQo+ID4+IFRoaXMg
Y2hhbmdlIHJlcXVpcmVzIGEgY2xlYW4gdXAgaW4gdGhlIHN0b3JhZ2UgYmFja2VuZChlLmcuIFMz
KSB0bw0KPiBhdm9pZA0KPiA+PiBzdG9yaW5nIG91dGRhdGVkIGJ1aWxkIGFydGlmYWN0cy4NCj4g
Pj4NCj4gPg0KPiA+IFdobyBjb3VsZCBkbyB0aGF0LCBhbmQgaG93IHRvIGNvb3JkaW5hdGUgdGhh
dCBiZXN0IHdpdGggYXBwbHlpbmcgdGhpcw0KPiBwYXRjaD8NCj4gDQo+IFRoaXMgd291bGQgYmUg
dGhlIGFkbWluIG9mIHRoZSBBV1MgYWNjb3VudCwgYXMgZmFyIGFzIEkga25vdyB0aGlzIHdvdWxk
DQo+IGJlIENocmlzLg0KDQpKYW4gaXMgYWxzbyBhbiBhZG1pbiA6UA0KDQpRdWlyaW4gZG8geW91
IHdhbnQgYWNjZXNzIGZvciB0aGUgQ0lQIFMzIGJ1Y2tldHMgc28geW91IGNhbiBiZSBpbiBtb3Jl
IGNvbnRyb2w/DQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KDQo+IA0KPiANCj4gaHR0cHM6Ly9k
b2NzLmF3cy5hbWF6b24uY29tL0FtYXpvblMzL2xhdGVzdC91c2VyZ3VpZGUvaG93LXRvLXNldC0N
Cj4gbGlmZWN5Y2xlLWNvbmZpZ3VyYXRpb24taW50cm8uaHRtbA0KPiANCj4gUXVpcmluDQo+ID4N
Cj4gPiBKYW4NCj4gPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWly
aW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+PiAtLS0NCj4gPj4gICAuZ2l0bGFiLWNpLnlt
bCB8IDYgKysrLS0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhLy5naXRsYWItY2kueW1sIGIvLmdp
dGxhYi1jaS55bWwNCj4gPj4gaW5kZXggNjAyYzUwMy4uNzVmMDUwMiAxMDA2NDQNCj4gPj4gLS0t
IGEvLmdpdGxhYi1jaS55bWwNCj4gPj4gKysrIGIvLmdpdGxhYi1jaS55bWwNCj4gPj4gQEAgLTcx
LDcgKzcxLDcgQEAgZGVmYXVsdDoNCj4gPj4gICAgICAgLSBpZiBbICIke25vX2tlcm5lbH0iID0g
ImVuYWJsZSIgXTsgdGhlbg0KPiBiYXNlX3lhbWw9IiR7YmFzZV95YW1sfTprYXMvb3B0L25vX2tl
cm5lbC55bWw6a2FzL29wdC90YXJnei55bWwiOyBmaQ0KPiA+PiAgICAgICAtIGVjaG8gIkJ1aWxk
aW5nICR7YmFzZV95YW1sfSINCj4gPj4gICAgICAgLSBrYXMgYnVpbGQgJHtiYXNlX3lhbWx9DQo+
ID4+IC0gICAgLSBpZiBbICIke2RlcGxveX0iID0gImVuYWJsZSIgXTsgdGhlbiBzY3JpcHRzL2Rl
cGxveS1jaXAtY29yZS5zaA0KPiAke3JlbGVhc2V9ICR7dGFyZ2V0fSAke2V4dGVuc2lvbn0gJHtu
b19rZXJuZWx9ICR7ZHRifQ0KPiAke0NJX0NPTU1JVF9SRUZfU0xVR30gd2ljOyBmaQ0KPiA+PiAr
ICAgIC0gaWYgWyAiJHtkZXBsb3l9IiA9ICJlbmFibGUiIF07IHRoZW4gc2NyaXB0cy9kZXBsb3kt
Y2lwLWNvcmUuc2gNCj4gJHtyZWxlYXNlfSAke3RhcmdldH0gJHtleHRlbnNpb259ICR7bm9fa2Vy
bmVsfSAke2R0Yn0gJHtDSV9QSVBFTElORV9JRH0NCj4gd2ljOyBmaQ0KPiA+PiAgICAgICAtIGlm
IFsgIiR7YnVpbGRfdXBkYXRlc30iID0gImVuYWJsZSIgXTsgdGhlbg0KPiA+PiAgICAgICAgICAg
ICBta2RpciBidWlsZC9wcmV2aW91cy1pbWFnZTsNCj4gPj4gICAgICAgICAgICAgaWYgWyAiJHtl
eHRlbnNpb259IiA9ICJzZWN1cml0eSIgXSB8fCBbICIke2V4dGVuc2lvbn0iID0NCj4gImViZy1z
ZWN1cmUtYm9vdC1zbmFrZW9pbCIgXTsgdGhlbg0KPiA+PiBAQCAtOTAsNyArOTAsNyBAQCBkZWZh
dWx0Og0KPiA+PiAgICAgICAgICAgICBmb3Igc3d1IGluIGJ1aWxkL3ByZXZpb3VzLWltYWdlLyot
YnJva2VuLnN3dTsgZG8NCj4gPj4gICAgICAgICAgICAgICAgIG12ICIkc3d1IiBidWlsZC90bXAv
ZGVwbG95L2ltYWdlcy8ke3RhcmdldH07DQo+ID4+ICAgICAgICAgICAgIGRvbmU7DQo+ID4+IC0g
ICAgICAgICAgc2NyaXB0cy9kZXBsb3ktY2lwLWNvcmUuc2ggJHtyZWxlYXNlfSAke3RhcmdldH0g
JHtleHRlbnNpb259DQo+ICR7bm9fa2VybmVsfSAke2R0Yn0gJHtDSV9DT01NSVRfUkVGX1NMVUd9
IHN3dXM7DQo+ID4+ICsgICAgICAgICAgc2NyaXB0cy9kZXBsb3ktY2lwLWNvcmUuc2ggJHtyZWxl
YXNlfSAke3RhcmdldH0gJHtleHRlbnNpb259DQo+ICR7bm9fa2VybmVsfSAke2R0Yn0gJHtDSV9Q
SVBFTElORV9JRH0gc3d1czsNCj4gPj4gICAgICAgICBmaQ0KPiA+Pg0KPiA+PiAgICMgYmFzZSBp
bWFnZQ0KPiA+PiBAQCAtMzU5LDcgKzM1OSw3IEBAIGJ1aWxkOnFlbXUtYW1kNjQtc2VjdXJlLWJv
b3QtYnVzdGVyOg0KPiA+PiAgICAgdGFnczoNCj4gPj4gICAgICAgLSBzbWFsbA0KPiA+PiAgICAg
c2NyaXB0Og0KPiA+PiAtICAgIC0gc2NyaXB0cy9zdWJtaXRfbGF2YS5zaCAke3Rlc3RfZnVuY3Rp
b259ICR7dGFyZ2V0fQ0KPiAke0NJX0NPTU1JVF9TSE9SVF9TSEF9ICR7cmVsZWFzZX0gJHtDSV9D
T01NSVRfUkVGX1NMVUd9DQo+ICR7aWVjX3Rlc3RfdGltZW91dH0NCj4gPj4gKyAgICAtIHNjcmlw
dHMvc3VibWl0X2xhdmEuc2ggJHt0ZXN0X2Z1bmN0aW9ufSAke3RhcmdldH0NCj4gJHtDSV9DT01N
SVRfU0hPUlRfU0hBfSAke3JlbGVhc2V9ICR7Q0lfUElQRUxJTkVfSUR9ICR7aWVjX3Rlc3RfdGlt
ZW91dH0NCj4gPj4gICAgIGFydGlmYWN0czoNCj4gPj4gICAgICAgbmFtZTogIiRDSV9KT0JfTkFN
RSINCj4gPj4gICAgICAgd2hlbjogYWx3YXlzDQo+ID4NCg0K

