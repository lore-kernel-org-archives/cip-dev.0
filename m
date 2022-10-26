Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F345C433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 09:20:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web09.5567.1666775996173994262
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 02:19:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 29Q9Ji1P001263; Wed, 26 Oct 2022 18:19:44 +0900
X-Iguazu-Qid: 34tMQ8l8RQeX8VB0PS
X-Iguazu-QSIG: v=2; s=0; t=1666775984; q=34tMQ8l8RQeX8VB0PS; m=JKK5auMZD52NUhEx5MCAEMmLLH2SogRhD3Iv48Xodl0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 29Q9Jhdo023934
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 26 Oct 2022 18:19:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvxUjoliiAzY8L5Yick3Fwzump/RKGgUWrsMafAn4W2N5hOYnhvhJyZvzeTelUxB6VV/xnKnEFi5BI81J2t1CMkPVwE09g6VN+vOWnmHaxfI5ap/EkBQ5+P1vq8YAs6nYP0zuFB3UBXGhjok/i7q4hqoX21g95IG1v6ZxP39XnA1UXtyGphS9iPJUGUI9pzBDLyaC7V8oLPwQWICSRFFuhz3Tl28u8wDQC79FCEKWSkze20GuFrNLa4JSd6hMUKKVgJ8DFF6OLy+gTX1vdQYp23R2HLSED8B3ahuOlxiYJCZ+m3lKC3KjhLc5cIB4atU+1O0qSAXfzVSZHEU1DdPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH+sBFwKXkoNCt6xFrCcJw376q6afBM6LvUAD6sFaBM=;
 b=bkYtO1soVbnNcpNdPIQBt3iJL2bcg29mn750ykq1JUq8tnLWG9nb3Dazi4ZRO2dR7PJRZl6gQVVlCiJLtklJVlyQopyp8xB3LqT74ERuMMpD81x8LIrLfQvkSHhaldSnBsYrwu3eCQZU8C3focU2Kktpp0cXfGDXcY1GfUCanuS3crunIyoKMJ8Yv2zXF5SSPDA8WEjurOGnkOQV6K2lXIOJD8bt42QpD6xj6CH0VGxg3rGXFCU/TpcicsbpPcp2Ze07/aYqocX+mfx6M1ODkpboeYOE8yb5xMwix76HHrmp3tmIhGPJgvsh35qfBetdojPjT4IwoSRmnbIVm58Sbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <biju.das@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/12] RZ/G2{L,LC,UL}/RZ/V2L improvements
Thread-Topic: [PATCH 5.10.y-cip 00/12] RZ/G2{L,LC,UL}/RZ/V2L improvements
Thread-Index: AQHY6H/nUMfh5NBnHkS/ODUYQDXWmK4gYdPw
Date: Wed, 26 Oct 2022 09:19:32 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94201E032FD08E985002D82392309@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB10296:EE_
x-ms-office365-filtering-correlation-id: 3fdb951e-6884-4a87-8ded-08dab7333160
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vbRrb/AlMBQYvaOLfEOdaLWAoJDJJc4Mzb3jZX8myB1pj63U2vG2yr76wrpOLLrVH69ICHmh+ymQFcIK+k7cowUxnx4x58p0rP0yqd8vfMMrlHmhIXZyaNGjiF666qKPjbBwdqOG/xjsSA5QCMxVnLdIArMxi4HJw+SSE+ZcA0IGoYIwf/oy8WGq+v5MsUjcEXxgwlsnOjLigW1nK5h2yuMYMd0CAWCa65+HyK6SdKcfsMaTFD9zewcObsyt0n7oepxk/x+7IRWQB0S9oDotx6Z9h/MXLBPsL38ckyI5uekHKbd0dFdKhD5KxgHifZCyZOn9e9rinb0G1o9DveLV9Uc3y4NHA2V1yKydVQlQKmBBBF21aNisFD1MSvj3ngICfqaXiYsGapDEUjj8K/YHE844nS0rOklqCCCi+k8M1bdrarNUud2sMWWVmC0DMTeqDStssdxmuXOo2oXIE3Y7euhCgChGveFdehuicJbZmyGVRLGo4SR6R8heoxfhS0mXKXXwMN9qUGYZNpSxHYtB3MdMUSYozpWS23W8L3sIAI2A3CEuZ5vueLe2a57J8WCABP2Tw5S2ONs92rkFmwS1HrX6/SLUavJh6RLwNM4uIh+hdkplx0p0VuqTyauJHPBetr14bPet2Bf8alKG85amhbXKNMNAPizd4PLh6JrP91aexdplDAkwQ1iPldd/P2+QPZ6ZFmMAJaraLyxt86a2H7xAdSmRI1UDAKtC/2uhyKZ8s0dvvygSfvnGaA3+lTn7v+IPAok7Ymcv1OgQabU/PKHSHo1F6l+DCYKbttlApnM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(186003)(2906002)(38070700005)(5660300002)(83380400001)(8676002)(122000001)(86362001)(8936002)(38100700002)(478600001)(41300700001)(55016003)(9686003)(71200400001)(966005)(26005)(6506007)(53546011)(76116006)(55236004)(66446008)(66476007)(4326008)(52536014)(66946007)(316002)(54906003)(64756008)(110136005)(7696005)(66556008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?citxS01saFY4K3E0WUNQZTRCdDdOTlYrbkFubkU0RXJHTWQvT0kycUUzcVhS?=
 =?utf-8?B?RDlnUWtNajFkVnBHcmg5bE9HVEYyNVlQNnRqMzFxSW5uTzhtdXh3SkNEazd4?=
 =?utf-8?B?MzY4Qkd4S0VvK3dmUkRDQkwzeUZYOCtLVWR6WkQxYU1jVXVCSHRGYWozb0tF?=
 =?utf-8?B?OEx4SGNzOWhPaDY3ZkRZdU5rY3J3MDA1VGlRY1VaZmJmSGVKQUZaNHFBWXdj?=
 =?utf-8?B?aTA5RWZMMU4yaVUwczlQRnUxN1AvK3dQTFVLZnlNcjNpRjdsUkdrU24xcGE0?=
 =?utf-8?B?U3lLaTloeFlMeFdJMlcwR0E5YzlKMFJJMlB0T1prMTUxVzI4TW1JV1UvZXIv?=
 =?utf-8?B?VjREU251Znp5dGRvdjg4NGdxM3hUNy9veUxjakQ4ZnZwajZnaHdFbzlRdGxh?=
 =?utf-8?B?UjN4ZjhsYisvdVJiV1A3R3dybklNMlE0OCtybTczaFRKTlBYQTJZc3ZZTE9X?=
 =?utf-8?B?Q0w5WGNiWXYwMFYwdEo4N3FYNlhqeWZ4U2dUK0lRMUJmazhNdzJZZWxHbHhm?=
 =?utf-8?B?eUVtVVJkV1BMenhSWm9TTFNuZ1dwLzJhZzFQUDFTUGJwSmpzRituL3ZuL3Vx?=
 =?utf-8?B?RWtMQVZIeUhxdzV0NjE5a0NScW5FSXhRWXl4dDl4M1FMQUZsaGRTcGFaQ2ts?=
 =?utf-8?B?eVpNZm8vdTE2MGw2WkZnQXVYVDNLVjVWWTVqNXBMS21lZ0MzUHJQNXBaYjBS?=
 =?utf-8?B?TjY4UUpkbktyUTBLU2NIUU1UVFYrMThJWVhpUU9OTzVXNnhlVFFqMVJUMVJD?=
 =?utf-8?B?ZVcvNDk5d0U2c0Q2dXB2LzJOU0NJTm1YdjA2VEMvSGt0YWM3WG12Qis2OU84?=
 =?utf-8?B?NGhOTktBZHNCMXByNUxNOS9SZUZVbDRDbGN2K3Z6VkdFYWNLb3I1TGRSbVgr?=
 =?utf-8?B?Q09ZYVZER1JtTHlOUndBWUpob3R6ODluL0RFc05iQnNRL2YvYVV1dm14NGNM?=
 =?utf-8?B?c1hGSUw3YzVLMEZ6SzQzaGlsYVA2YjBneGVpUkFQcmRNVHQ1Qk1NU01YQ0hl?=
 =?utf-8?B?c2ZNSFZBdGExU09zKzlPNmVSbUtBNll2dkREb3VZdmtQMFNsUWY5UDNad0Uz?=
 =?utf-8?B?ektNNmFxMDFaTGZvSnNIOUhCVHNqN1E2OG5WNERjbzdvckI3eTJUcDA5OEpp?=
 =?utf-8?B?aHFiNXE3L2haMlhLK2x5STVNeXNsMWMzSXUrbllCd1VrRWR4UytHYzN6bDhI?=
 =?utf-8?B?QU1uSmwzRnVveVFQd1ZFU1k0R24xRnZBcExva2pjS2lMeWlMYjRaZDFxeEdu?=
 =?utf-8?B?VU55NTRqZFpmWXpRZmlhSU1sWG1RQlNDbjlrS1RBSWlMYVlnNnROK1pHdklK?=
 =?utf-8?B?ckVyTUh6UkxaWkZaTXh2c2ZacW8yN2RLVnF1dDFhYytSZWM2dVFHRWNZUUk3?=
 =?utf-8?B?RVFiSXorN3RTaitqckgveE01Q1hac3U5bDloRXdGeVFYaEYzUWN4bUF2Mkx0?=
 =?utf-8?B?R2JhcHQ1bHRMblp1M0o0djVyS2pQVFlZWDNSWXlsaEFqUEJjQ3Z0YnJaRWJq?=
 =?utf-8?B?Tk0wSGZKS1l3Yk5reHd6aWNMQmo2eXRzV3NNazNoL01mL1BMcXdndzVJenFD?=
 =?utf-8?B?d1h4MEFPYmhSRlpyenpZYXc2VStzdkdaQzdPYTBRWENraDBMazlDb0xZYURS?=
 =?utf-8?B?S0QxcWZFeEo1WDNYczJjaWkwQ2VMOGc2RHhFY2RwL0tqMXF1Nlh5L1c4YW1I?=
 =?utf-8?B?RzE3djVpbDNvY2thbHJlZUliT3RQUk1wM3NTcTZyZGhzd3E4RG5Sb2psbDgx?=
 =?utf-8?B?eENGcUtEek9VTkNMTGZDQ2lIV2s5b2h4UHhjT3lTa2tuWFJwR2N0YUdFNnc4?=
 =?utf-8?B?YjNZLzRUQVRVTjdvbDdpalVBNDdxaHkvaXZQR3JSSmZlSStHdFZwRFNXMGYz?=
 =?utf-8?B?S1h4czZyMFRSQW43RjI4anBteTRYeFBZa2I5TmJ5Yk10YXVoRlA4NFBXRm5l?=
 =?utf-8?B?U1ZndWpOZngyUnVnQ25aS2VDUm9RVmRmYkFLVVpZSElHYWJXcXlBMGhndDlm?=
 =?utf-8?B?KyszcWFxL3pneEZmb3NLM0ZyUDd3amN2ZTZENm14d3dvQlZVQXdheTZNaHFY?=
 =?utf-8?B?U1l4ZXVFTXQ3VlVUVG5zc0lLRWFLN1hodFJrL0EyYytYOTJvUytya2VXY3pM?=
 =?utf-8?B?TFUzVjR1V1RWMTNSVWZZME56cnNrSzc0cWorckVNeFQ4ZDkxKytOaHVVN3lr?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdb951e-6884-4a87-8ded-08dab7333160
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 09:19:32.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hvtAjQfRlK2BKaQptI93MIsAkdxNhj+6CO9xd8tJ01TE8MTF0wFRnByth5VE2Xj27mfwFDdLX+OAOL8sE7eGMuFhY6oxkxXBt1PX32AVEE2nuPcowUZk8zzDhjnQELh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10296
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 09:20:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9850

SGkgQmlqdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIg
MjUsIDIwMjIgMTE6NDEgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBp
d2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oQ0KPiDvvKPv
vLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlaw0KPiA8
cGF2ZWxAZGVueC5kZT4NCj4gQ2M6IENocmlzIFBhdGVyc29uIDxjaHJpcy5wYXRlcnNvbjJAcmVu
ZXNhcy5jb20+OyBCaWp1IERhcw0KPiA8YmlqdS5kYXNAYnAucmVuZXNhcy5jb20+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCA1LjEwLnktY2lwIDAwLzEyXSBSWi9HMntMLExDLFVMfS9SWi9WMkwgaW1wcm92
ZW1lbnRzDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBhaW1zIHRvIGFkZCBETUEgc3VwcG9ydCB0
byBSU1BJIGFuZCBlbmhhbmNlbWVudHMgbGlrZQ0KPiBmaXhpbmcgaW50ZXJydXB0IHR5cGVzLCBN
SUkgc3VwcG9ydCBhbmQgZml4IFJQTSBpbWFiYWxhbmNlIGZvcg0KPiBSWi9HMntMLExDLFVMfS9S
Wi9WMkwgU29Dcw0KPiANCj4gQWxsIHRoZXNlIHBhdGNoZXMgYXJlIGNoZXJyeS1waWNrZWQgZnJv
bSB0aGUgbWFpbmxpbmUuDQo+IA0KPiBCaWp1IERhcyAoOSk6DQo+ICAgYXJtNjQ6IGR0czogcmVu
ZXNhczogcjlhMDdnMDQzOiBBZGQgRE1BIHN1cHBvcnQgdG8gUlNQSQ0KPiAgIGFybTY0OiBkdHM6
IHJlbmVzYXM6IHI5YTA3ZzA0NDogQWRkIERNQSBzdXBwb3J0IHRvIFJTUEkNCj4gICBhcm02NDog
ZHRzOiByZW5lc2FzOiByOWEwN2cwNTQ6IEFkZCBETUEgc3VwcG9ydCB0byBSU1BJDQo+ICAgYXJt
NjQ6IGR0czogcmVuZXNhczogcjlhMDdnMDQzOiBGaXggYXVkaW8gY2xrIG5vZGUgbmFtZXMNCj4g
ICBhcm02NDogZHRzOiByZW5lc2FzOiByOWEwN2cwNDQ6IEZpeCBTQ0l7UngsVHh9IGludGVycnVw
dCB0eXBlcw0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI5YTA3ZzA1NDogRml4IFNDSXtSeCxU
eH0gaW50ZXJydXB0IHR5cGVzDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjlhMDdnMDQzOiBG
aXggU0NJe1J4LFR4fSBpbnRlcnJ1cHQgdHlwZXMNCj4gICBjbGs6IHJlbmVzYXM6IHI5YTA3ZzA0
NDogQWRkIGNvbmRpdGlvbmFsIGNvbXBpbGF0aW9uIGZvcg0KPiAgICAgcjlhMDdnMDQ0X2NwZ19p
bmZvDQo+ICAgcmF2YjogQWRkIFJaL0cyTCBNSUkgaW50ZXJmYWNlIHN1cHBvcnQNCj4gDQo+IEdl
ZXJ0IFV5dHRlcmhvZXZlbiAoMSk6DQo+ICAgbXRkOiBoeXBlcmJ1czogcnBjLWlmOiBGaXggUlBN
IGltYmFsYW5jZSBpbiBwcm9iZSBlcnJvciBwYXRoDQo+IA0KPiBMYWQgUHJhYmhha2FyICgxKToN
Cj4gICBhcm02NDogZHRzOiByZW5lc2FzOiBBZGp1c3Qgd2hpdGVzcGFjZSBhcm91bmQgJ3snDQo+
IA0KPiBVd2UgS2xlaW5lLUvDtm5pZyAoMSk6DQo+ICAgbXRkOiBoeXBlcmJ1czogTWFrZSBoeXBl
cmJ1c191bnJlZ2lzdGVyX2RldmljZSgpIHJldHVybiB2b2lkDQo+IA0KPiAgYXJjaC9hcm02NC9i
b290L2R0cy9yZW5lc2FzL3I5YTA3ZzA0My5kdHNpIHwgMjANCj4gKysrKysrKysrKysrKy0tLS0t
LS0gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOWEwN2cwNDQuZHRzaSB8DQo+IDE2ICsr
KysrKysrKysrLS0tLS0gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOWEwN2cwNTQuZHRz
aSB8IDE2DQo+ICsrKysrKysrKysrLS0tLS0NCj4gIGRyaXZlcnMvY2xrL3JlbmVzYXMvcjlhMDdn
MDQ0LWNwZy5jICAgICAgICB8ICAyICsrDQo+ICBkcml2ZXJzL210ZC9oeXBlcmJ1cy9oYm1jLWFt
NjU0LmMgICAgICAgICAgfCAgNiArKystLS0NCj4gIGRyaXZlcnMvbXRkL2h5cGVyYnVzL2h5cGVy
YnVzLWNvcmUuYyAgICAgICB8ICA4ICsrLS0tLS0tDQo+ICBkcml2ZXJzL210ZC9oeXBlcmJ1cy9y
cGMtaWYuYyAgICAgICAgICAgICAgfCAxMyArKysrKysrKystLS0tDQo+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9yZW5lc2FzL3JhdmIuaCAgICAgICAgfCAgOCArKysrKysrKw0KPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvcmVuZXNhcy9yYXZiX21haW4uYyAgIHwgIDggKysrKysrKy0NCj4gIGluY2x1
ZGUvbGludXgvbXRkL2h5cGVyYnVzLmggICAgICAgICAgICAgICB8ICA0ICstLS0NCj4gIDEwIGZp
bGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPiANCkkgcmV2
aWV3ZWQgdGhpcyBzZXJpZXMsIElmIHRoZXJlIGFyZSBubyBvdGhlciBjb21tZW50cywgSSBjYW4g
YXBwbHkuDQpUZXN0IHBpcGVsaW5lczoNCiAgaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0
L2NpcC1rZXJuZWwvbGludXgtY2lwLy0vcGlwZWxpbmVzLzY3NzMxNDkwOA0KDQpCZXN0IHJlZ2Fy
ZHMsDQogIE5vYnVoaXJvIA0K


