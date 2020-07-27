Return-Path: <SRS0=zw98=BG=lists.cip-project.org=bounce+64572+5027+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0743BC433E3
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 13:40:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7954E2074F
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 13:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pMu81tOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7954E2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5027+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NtN0YY4521723x5ZTQVLvE2Z; Mon, 27 Jul 2020 06:40:36 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.55670.1595857232992606774
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2020 06:40:34 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 06RDeTpB021388; Mon, 27 Jul 2020 22:40:30 +0900
X-Iguazu-Qid: 34trcFcTUj58ypskJl
X-Iguazu-QSIG: v=2; s=0; t=1595857229; q=34trcFcTUj58ypskJl; m=5oQrCeeDp54txKzfQ3214WMw/PU1Q0h0lMD3GIG27i8=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 06RDeSWx027745;
	Mon, 27 Jul 2020 22:40:29 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06RDeSgH016064
	for <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2020 22:40:28 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06RDeSVD006144
	for <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2020 22:40:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh9IOI4sL7/1/6A4fZhQL+QWzgjni5s419wNfPyARZsxPk9dmqm8WYc0dOm7wn41CXfUYN/5BnWPo/DjOwrKkoupQzYl2428pfNLE5f6EkCGDR34lBthqlm5ANeyw02cHij25ou+LdGPgF9Wg6IqS3UxfnbdkCqLCfqNAuGkMlIHuAbNgHvKO9dFw30JiTz0eNYKhOneAjXxgcuZTKn28L0Ja+AxOVs/l1Z+CP5Rcp93afTtd+2X6xjMCATmiG4v2DslktEmcC95Qw0VK7kMYSHh3+XFaugjp8BfMuxKtekrG04AN3NJUJdwvQ3bOt/5RLEvoXZzXycvtQgCtAXv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM26YBuCbbAM3dIaT8eksIG0RphVIIiEPoHy46PISxQ=;
 b=J/m6Bx7drlF+d+dMt4IYdxXxs2bqEiWCO3SFvGfn7lAacz8JjOpqYkgEk9kCfea8jrtljLeuaxLonQzFxNwx8UJI3R8n5cvEK1JNJZuaRhuGUYBu2Z24a2f00xvT8i+qaT43kKm8TFsewtaw3ftdoqNbD5hA9YSNBY8eW2cIrMoIra+UlSru+SqK7TcAqDN4QogEd5JtDfhk6dfnb5HhGuaNi1JSLGlhwHUGpP6aR3S8JGQETaZ8mpexyXFJxlq8HNlk0zvNiWJg0vBB+mTimMrTJg4TJs36EBeoWYt49hzgTLdKdITGgSi+oIIC/i1P7ovs67UjcegwmdBlM1vTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] The security of NTP
Thread-Topic: [cip-dev] The security of NTP
Thread-Index: AdZjtVn+GEKdZ28XRvayTupQL0QETAAVEF8AAAG2C0AAASlUgAABYrsQ
Date: Mon, 27 Jul 2020 13:40:25 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053E68E6BB520655A3C7362D0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2053682B08257AC2230531FDD0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <7438.1595849548430257093@lists.cip-project.org>
 <OSBPR01MB20538C134703474587A50658D0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <CALkjhPqeTJQkuz3RPmm0W-xcZBS+xvofWq9R2RYxCpSMZNFVSQ@mail.gmail.com>
In-Reply-To: <CALkjhPqeTJQkuz3RPmm0W-xcZBS+xvofWq9R2RYxCpSMZNFVSQ@mail.gmail.com>
Accept-Language: en-US
x-originating-ip: [126.194.221.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c123714b-0fca-42e7-4c55-08d832329e1a
x-ms-traffictypediagnostic: OSAPR01MB3378:
x-microsoft-antispam-prvs: <OSAPR01MB33785FCAB854648D510C9477D0720@OSAPR01MB3378.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tbOXLwX9pMW1I3OHmHuQ9doJgX4fD4A8n1RnwGOsPBfOJpqsuBAz9+Pn7lJu0DZhWxgBJefSYf+ixcEUGQ+IQOXIUZQku2tB24L/VbQkba+qGtN1t7W6c6YMQe2ReHvh5sWLzL8/iIEsh26gakWhhR6M2Ydam5bmldcHJl2jRCzBgOkPi09y6igTuRIKvf5yPoXVO9qfpRY+fl7cy7bfAF4UX6BAAHtGKt8hVeVaH578fvRsrztYfcHZg3wbRnCcP3y0e6M37H3FPD3/wXMKPY9Xif2LpUQTLljxaHgjwuAU1R+/jIX+MPO1iX1tUiFjKZl/nmryC38wpXDs9wKbVs7t2k4WnhRABSAb+bw9CRYuFfEqD/4okRVazhzW2HmAs0h6ttv1g+juDqGLLZI0XHyX1JN0HWxVvgkDiWmWX6cL9RVhUDEFYgh65z33o7Jvc9yblrhmu53owl5V4ONf8A==
x-ms-exchange-antispam-messagedata: mk85Y4lGNp0GNbMYzgQE/vxu7OrJHFbla8nyCUBbqZKAcukXG5QBm0f7idfu2mi/JImgB+VOl2qQFyfOxPzZdmBk0hnTYh6aUGafCE5MHsCBHrIveu2oJ+Yo/Ue8ehbM03+lb52ucI5G5zbVvKtnaQAonxHTUK9me2RSLF1Bsrzga4DkZokDcVlausleq5CM9d56IXh/TE7NEB6h1xWZ5xlgEkFlE4RlmgeAGyoOQi5wQZvuEnDcwYi03wKhZaavgE8uh4lVTiAzj753FK41NNf8TxdTw9F3v5mp+RSVO0GSvbqw11+7GZK7Nnoga7jPFJmCdnrupvahzmnlk9KqlOhgW4xag0TL36EohCUxOyUmhHcaFAT9jwYUs52xgAe6WARDm8MltwrCHXemDP5in6u+q0Q/1LvUFTW3qQbitHnduQ2jJXNEHPty0b35YF58OAsf1KDXOCdMivwDGzxf6GSPhHGOlMxs/u/eOIac/59kByy2rIMXW9weAUdOPsqi
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c123714b-0fca-42e7-4c55-08d832329e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 13:40:25.4812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOA10YKyELigchFqU9F62amcO2TM9/wh2YE+y+HRCVZlEHVr/WhWd6PHHW2nUHL1a3JmbU+VjOzKf3Y66om4B8hzIBMLw+faEfMUQq9nLY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3378
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UN0OzzYXlLkugd34wuN1ObzVx4520388AA=
Content-Type: multipart/mixed; boundary="g80ajOtlmS68hr1dWzQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595857236;
 bh=kPGz62rFEPver5W84ZiDAJM6s7gBDkIvIJsnuFWu/Nk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=pMu81tOHspdlKNkayauBZwKd52mgsRaGz781QOKYWU4YR8frx3FFE+94dcWxxXT/SBk
 +Tfu4emMRnWTTp7h40xUXZIHSawTBywOYMej+tiv1T6oKKuiGlwLEhXEW8P1u0yHXt7IU
 u25J5HKq6WG2tPZ0XjocgGr4nDooubGStB8=

--g80ajOtlmS68hr1dWzQr
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTW9oYW1tZWQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+
IE9uIEJlaGFsZiBPZiBNb2hhbW1lZCBCaWxsb28NCj4gU2VudDogTW9uZGF5LCBKdWx5IDI3LCAy
MDIwIDk6NTUgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbY2lwLWRldl0gVGhlIHNlY3VyaXR5IG9mIE5UUA0KPiANCj4gRGFuaWVsLA0KPiAN
Cj4gVGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dC4gU2luY2UgQ0lQIGlzIHJlbGlhbnQgb24g
YXZhaWxhYmxlIHBhY2thZ2VzIG9uIHBhcnRpY3VsYXIgdmVyc2lvbnMgb2YgRGViaWFuLCB3b3Vs
ZCB0aGUgcHJvY2Vzcy93b3JrZmxvdyB0aGVuDQo+IGJlIHRvIHdhaXQgZm9yIHRsc2RhdGUgdG8g
YmUgYXZhaWxhYmxlIGluIEJ1c3RlciBhbmQgdGhlbiBwdWxsIGl0IGludG8gQ0lQIGFuZCBjb250
aW51ZSB3b3JraW5nIG9uIHRoaXMgaXNzdWU/IE9yLCBzaG91bGQgSSBqdXN0IGdvIGFoZWFkIGFu
ZCB0cnkNCj4gdG8gZ2V0IHRsc2RhdGUgaW5jb3Jwb3JhdGVkIGludG8gQnVzdGVyIGJ5IGZvbGxv
d2luZyB0aGUgY29udHJpYnV0aW9uIGd1aWRlbGluZXMgaW4gRGViaWFuPw0KDQpUaGF0IHdvdWxk
IGJlIHNvbWV0aGluZyB0aGF0IG5lZWRzIHRvIGJlIGRlY2lkZWQgYnkgdGhlIHdob2xlIENJUCBw
cm9qZWN0LCBidXQgSSByZWFkIHRoYXQgdGxzZGF0ZSBkZXBlbmRzIG9uIGEgdGltZXN0YW1wIHRo
YXQgaGFzIGJlZW4gcmVtb3ZlZCBvbiBUTFMgMS4zLg0KaHR0cHM6Ly93d3cuZmVpc3R5ZHVjay5j
b20vYnVsbGV0cHJvb2YtdGxzLW5ld3NsZXR0ZXIvaXNzdWVfNTRfbmV0d29ya190aW1lX3NlY3Vy
aXR5X250c19jb3VsZF9maW5hbGx5X2JyaW5nX3N1cHBvcnRfZm9yX2F1dGhlbnRpY2F0ZWRfbmV0
d29ya190aW1lDQoNClBlcnNvbmFsbHksIEkgdGhpbmsgdGhhdCBDSVAgc2hvdWxkIGZvY3VzIG9u
IE5UUyAoYWxyZWFkeSBpbmNsdWRlZCBpbiBjaHJvbnkgZm9yIGV4YW1wbGUpDQpodHRwczovL3d3
dy5pYW5hLm9yZy9hc3NpZ25tZW50cy9udHMvbnRzLnhodG1sDQoNClRoYW5rcywNCkRhbmllbA0K
DQo+IE9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0IDg6NDEgQU0gRGFuaWVsIFNhbmdvcnJpbiA8ZGFu
aWVsLnNhbmdvcnJpbkB0b3NoaWJhLmNvLmpwIDxtYWlsdG86ZGFuaWVsLnNhbmdvcnJpbkB0b3No
aWJhLmNvLmpwPiA+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiAJPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiAJPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8bWFpbHRv
OmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiAgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnIDxtYWlsdG86Y2lwLQ0KPiBkZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiA+IE9uIEJl
aGFsZiBPZiBNb2hhbW1lZCBCaWxsb28NCj4gCT4gU2VudDogTW9uZGF5LCBKdWx5IDI3LCAyMDIw
IDg6MzIgUE0NCj4gCT4gRGFuaWVsLCBQYXZlbDoNCj4gCT4NCj4gCT4gVGhhbmtzIGZvciB0aGUg
ZmVlZGJhY2suIElzIHRsc2RhdGUgYSBiZXR0ZXIgYWx0ZXJuYXRpdmUgKGh0dHBzOi8vZ2l0aHVi
LmNvbS9pb2Vycm9yL3Rsc2RhdGUvKT8gVGhlIG9ubHkgY2F2ZWF0IGlmIHVzaW5nIHRsc2RhdGUg
KG9yDQo+IGFueSBzb3J0IG9mDQo+IAk+IHRpbWUgbWVjaGFuaXNtIHRoYXQgcmVsaWVzIG9uIGEg
IndlbGwta25vd24iIHNlcnZlcikgaXMgdGhhdCBhbiBJbnRlcm5ldCBjb25uZWN0aW9uIGlzIG5l
Y2Vzc2FyeS4gSXQgaXNuJ3Qgb2J2aW91cyB0byBtZSB3aGV0aGVyDQo+IHRoaXMgaXMNCj4gCT4g
YWNjZXB0YWJsZSBvciBub3QuIENhbiBzb21lb25lIGNoaW1lIGluPw0KPiANCj4gCUl0IHNlZW1z
IHRoYXQgdGhhdCBwcm9qZWN0IGlzIGRlYWQsIGJ1dCB0aGVyZSBpcyBhIGZvcmsgZm9yIENocm9t
aXVtT1MgcmVtYWluaW5nIHRoYXQgc2VlbXMgdG8gYmUgd2VsbCBtYWludGFpbmVkIChmb3INCj4g
Q2hyb21pdW1PUykNCj4gCWh0dHBzOi8vZ2l0aHViLmNvbS9pb2Vycm9yL3Rsc2RhdGUvaXNzdWVz
LzE5OQ0KPiAJaHR0cHM6Ly9jaHJvbWl1bS5nb29nbGVzb3VyY2UuY29tL2Nocm9taXVtb3MvdGhp
cmRfcGFydHkvdGxzZGF0ZQ0KPiANCj4gCVRoZXJlIGFyZSBzb21lIHBhY2thZ2VzIGluIERlYmlh
bg0KPiAJaHR0cHM6Ly9wYWNrYWdlcy5kZWJpYW4ub3JnL3NlYXJjaD9rZXl3b3Jkcz10bHNkYXRl
DQo+IAlidXQgbm90IGZvciBCdXN0ZXIuDQo+IA0KPiAJVGhhbmtzLA0KPiAJRGFuaWVsDQo+IA0K
PiANCj4gDQo+IAk+DQo+IAk+IFRoYW5rcw0KPiAJPiAtLQ0KPiAJPiBNb2hhbW1lZCBCaWxsb28N
Cj4gCT4gTUFCIExhYnMsIExMQw0KPiAJPiB3d3cubWFiLWxhYnMuY29tIDxodHRwOi8vd3d3Lm1h
Yi1sYWJzLmNvbT4NCj4gDQo+IA0KPiANCj4gDQo+IA0KPiAtLQ0KPiANCj4gTW9oYW1tZWQgQSBC
aWxsb28NCj4gRm91bmRlcg0KPiBNQUIgTGFicywgTExDDQo+IHd3dy5tYWItbGFicy5jb20gPGh0
dHA6Ly93d3cubWFiLWxhYnMuY29tPg0KPiAyMDEtMzM4LTIwMjINCj4gDQo+IA0KPiAtLQ0KPiBN
b2hhbW1lZCBCaWxsb28NCj4gTUFCIExhYnMsIExMQw0KPiB3d3cubWFiLWxhYnMuY29tDQo=

--g80ajOtlmS68hr1dWzQr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5027): https://lists.cip-project.org/g/cip-dev/message=
/5027
Mute This Topic: https://lists.cip-project.org/mt/75814887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--g80ajOtlmS68hr1dWzQr--
