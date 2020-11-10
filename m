Return-Path: <SRS0=lEpm=EQ=lists.cip-project.org=bounce+64572+5788+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA19AC388F7
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 12:24:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D729E206B6
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 12:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="inZveZF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D729E206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5788+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RKkGYY4521723xabacXs2f1b; Tue, 10 Nov 2020 04:24:34 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.105])
 by mx.groups.io with SMTP id smtpd.web12.26672.1605011073016967425
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Nov 2020 04:24:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DICjzRKda8qDNl4rdlSQ5wwbpKR5oSPgD6YDs57VX6UG6fenfbkYd7nUGc7K1DviWf02qHSgdT26NY13qtJAl1VCp2cUi7wQEDf8l+L/ETmnthFpINTbmDDb2bZeUJXz8F1YcMZGEVrjP+XdHyTdKA7TGAiCUZ1BDeeKmBhtxnLm3Qz1nsHZ9guGq4TAq9PvF35nQccDrZyNhz2SyI9Mb75nHND7w5fCoPaYsBmFsPPJ8mk8uELKYbeR7MmcjS2hBKaXT69zJeP8+xePsArug0rpKsc07ULuSvEK+D2ym0Yw5VqiTRH9cKWTSWPsgD8+trICNWNs6nMJNxc3cPhmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJf8R25Cpuyq+INHtvPyZW2v5Z9wD0jQV69YZdKTAzs=;
 b=kaWxkuA+7zDlwpOB3NLhGwAPSkXBk2p0owSEO6x+MsNdkU2whr10bApHN5aNRxSQTxRxBRVaR7QSbd59ZWC6/WJ7Q8FxK2ENLdDFICipOsgdEEo4v2UQtQYXx+nNAmtJv1+7E27LyW5sf9X6Fivx4bDUZ5pz9eDjZp/q1zNYLJn0Hx0huzIWF4EKXFHS5aPlv8voLvjl02fKEV5aB66MJ9xiH1DFJeEqWKiBQVfJCwicm7DLQzusrqkWMhH6hoPiAMA4cfVsYth0UOBxgU+T9SSW7pyOXkdQNHMiqXAcb9Bo4TNHfDdwfQdB9wq6n0sGSciHvXmYs/iTsMQ2sVH8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSAPR01MB3732.jpnprd01.prod.outlook.com (2603:1096:604:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 12:24:30 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3541.023; Tue, 10 Nov 2020
 12:24:30 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/14] Renesas RZ/G1H add support for CAN, IPMMU, QSPI, RTC
Thread-Topic: [PATCH 4.4.y-cip 00/14] Renesas RZ/G1H add support for CAN,
 IPMMU, QSPI, RTC
Thread-Index: AQHWtrAIwObsHxvcdUqdstTA37mDuqnAxM/ggAA7QoCAAEkDgIAAAhdw
Date: Tue, 10 Nov 2020 12:24:30 +0000
Message-ID: 
 <OSBPR01MB5048621BD4CA6F26C7E9F39EAAE90@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB2983D2D88A4E9CE78F41627692E90@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20201110075431.GA1029@amd>
 <OSBPR01MB298369540C0DAD8004C1D06A92E90@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB298369540C0DAD8004C1D06A92E90@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2713edad-dd91-465c-3e9e-08d8857392b4
x-ms-traffictypediagnostic: OSAPR01MB3732:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB3732638D0F4D1FA2A2EBE4D2AAE90@OSAPR01MB3732.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 WmiCKgq8bL9XmONyQshYjzZ0aRJDf0Rxw6KjNGrHb0doJwHbbgdARu3RSKBEUOVfGSayf7LGTdZJCTJ9/cqsmUGrM/e5JZgQD9te5P8b/qBmCx0bZCMSRCLqYX1jQL4BiQEL9UzXrCnbnKSV5D1BdOFyRssGRHFUp1hquRS4Fp5/9DQThIn0858/AJOmELjD8QESkMzMzfNn6+PeLPxt+rjKcb6kUysnYX7vxPrueottpDS08KAKPd/fST/RStqi1kWH0RH8KjYiC9jjTjW/7qzUXVCSw4USh2HjuBCq3R4wL6lw9/SG2F4zU8u9wej4
x-ms-exchange-antispam-messagedata: 
 +FGUAuuVyDyAzaxRT9P0Mogt9Jnt40LYxXnbXm6ruu2Hrbz83NySv6NZeNex/WzjVKFfZueDLsFcYyr/s+UxTpxB0t0CxbKq1ZmsyWiPUM2z5Nd5lpD25r1EKs/lOIlNP5+BYtw1QPX4nipwSvOY67sD06gKqn6f89sqNQu+EU9VNdGxtSFsc3nLhEzyQZAlDKih3ZfDzmx6d+XhuVdwDpXz1MP+UtpAR0Rw2rlKbEk1a2Wf5MKK6EJ1wSF/Zi6weXG226TGOYSWeXOURD+sIG2JsiWaI4+nqHCr80aoo7ul8zeS/BO6NQTh+mL3dyvDOFc527qiJc7Of5XwSGSvCgOVqNmPrJys2c4V68/FAbMOerLcoSBvPLdClzXFBzdF4/lQTPiEweybAAk2FqgPj5Ab+YblIDm+XwWCk4xMf/4nsVD6RwXeLrA3QZCN+quiJzQKv2TFd/GWVmYD8rggrFhkit9ZqTUhHEgY/uKk0tp+s2cBCzkzngowOaUU0Q3T7E6zS0NZRZdpBz54Ta5S0xLDHYQZ7mI8iLYEtzK5GcgFXCALSagqNjfcvpRc9x/dhrICmxQlmNEJSsM2MiqNtpJTrmC3qDwbKhBpbhZIRn0VZF2ltgRuUUJvyhIIwDYyUThAzC/Rt9jt96g2OUuakQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2713edad-dd91-465c-3e9e-08d8857392b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 12:24:30.1114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jliMgApwCsPJWQ9mut4kJsVpTRRCYZCJ0nQFofO8OIPXhosbVMV8SPgXaL1D4Xy2gFdqCUxIQlhlZgSUT1F2KjfLxFsK+38hH7vFGwcn99lg7ZxaEF9Jqvr3HdRmHMwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3732
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CerN67E80PZ7AngEixgWreU4x4520388AA=
Content-Type: multipart/mixed; boundary="YlvSJD6RHpprsV1D25nk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605011074;
 bh=7aJOmA4f2o/hZMU5GFiHuG/9SH7stBY1yV2TIHwCpf0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=inZveZF4Cn6AIOIXtfcNU4NPW1BElUiqlRVSnl9Wsb8oJfooqSTgEMuRlfDeo6ZK0Ot
 tNx4sJ00x1zgtaA3gBu+5c0xFQLRfLrrFxPO57Weavcj4xoyDuOpo8AlWcPbCiJxMr5o1
 zIBKk7/U8zcUY8TBkJ86yHCqYTQCr9uw18I=

--YlvSJD6RHpprsV1D25nk
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sIFBhdmVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwIDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD4NCj4gU2VudDogMTAgTm92ZW1iZXIgMjAyMCAxMjoxNw0KPiBUbzogcGF2
ZWxAZGVueC5kZQ0KPiBDYzogUHJhYmhha2FyIE1haGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRl
di1sYWQucmpAYnAucmVuZXNhcy5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsN
Cj4gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSRTog
W1BBVENIIDQuNC55LWNpcCAwMC8xNF0gUmVuZXNhcyBSWi9HMUggYWRkIHN1cHBvcnQgZm9yIENB
TiwgSVBNTVUsIFFTUEksIFJUQw0KPiANCj4gSGkgYWxsLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBhdmVsIE1hY2hlayBbbWFpbHRvOnBhdmVsQGRlbngu
ZGVdDQo+ID4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTAsIDIwMjAgNDo1NSBQTQ0KPiA+IFRv
OiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8
tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiA+IENjOiBwcmFiaGFrYXIu
bWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb207IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnOyBwYXZlbEBkZW54LmRlOw0KPiA+IGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tDQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCA0LjQueS1jaXAgMDAvMTRdIFJlbmVzYXMgUlovRzFIIGFkZCBz
dXBwb3J0IGZvciBDQU4sIElQTU1VLCBRU1BJLCBSVEMNCj4gPg0KPiA+IEhpIQ0KPiA+DQo+ID4g
PiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3JjYXJfY2FuLnR4dCAgfCAgIDMg
Ky0NCj4gPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktcnNwaS50eHQgICAg
ICB8ICAgMSArDQo+ID4gPiA+ICAuLi4vYm9vdC9kdHMvcjhhNzc0Mi1pd2cyMWQtcTctZGJjbS1j
YS5kdHMgICAgfCAgMTEgKysNCj4gPiA+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDItaXdn
MjFkLXE3LmR0cyAgICAgICB8ICA1MiArKysrKysrKw0KPiA+ID4gPiAgYXJjaC9hcm0vYm9vdC9k
dHMvcjhhNzc0Mi1pd2cyMW0uZHRzaSAgICAgICAgIHwgIDc5ICsrKysrKysrKysrLQ0KPiA+ID4g
PiAgYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0Mi5kdHNpICAgICAgICAgICAgICAgIHwgIDkwICsr
KysrKysrKysrKysrDQo+ID4gPiA+ICBkcml2ZXJzL3BpbmN0cmwvc2gtcGZjL3BmYy1yOGE3Nzkw
LmMgICAgICAgICAgfCAxMTIgKysrKysrKysrKysrKysrKystDQo+ID4gPiA+ICBkcml2ZXJzL3Nw
aS9zcGktc2gtbXNpb2YuYyAgICAgICAgICAgICAgICAgICAgfCAgOTIgKysrKysrKysrKystLS0N
Cj4gPiA+ID4gIDggZmlsZXMgY2hhbmdlZCwgNDE4IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9u
cygtKQ0KPiA+ID4NCj4gPiA+IEkgcmV2aWV3ZWQgdGhpcyBwYXRjaCBzZXJpZXMsIHRoZXJlIGlz
IG5vdCBpc3N1ZS4NCj4gPiA+IEkgY2FuIGFwcGx5IGFuZCBwdXNoIGlmIHRoZXJlIGlzIG5vIG9i
amVjdGlvbi4NCj4gPg0KPiA+IEkgZG9uJ3Qgc2VlIGFueSBwcm9ibGVtcyBlaXRoZXIsIHNvIG5v
IG9iamVjdGlvbnMgZnJvbSBtZS4NCj4gPg0KPiANCj4gT0ssIEkgd2lsbCBwdXNoIHRoaXMgc2Vy
aWVzLg0KPiANClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyBhbmQgYWNjZXB0YW5jZS4NCg0KQ2hl
ZXJzLA0KUHJhYmhha2FyDQo=

--YlvSJD6RHpprsV1D25nk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5788): https://lists.cip-project.org/g/cip-dev/message=
/5788
Mute This Topic: https://lists.cip-project.org/mt/78138424/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YlvSJD6RHpprsV1D25nk--
