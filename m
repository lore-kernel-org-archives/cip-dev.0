Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2201CA0EC3
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 06:52:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.19566.1694501567590640211
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 23:52:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 38C6qjdV2135771; Tue, 12 Sep 2023 15:52:45 +0900
X-Iguazu-Qid: 2yAaOS3aF5YV79Ck11
X-Iguazu-QSIG: v=2; s=0; t=1694501564; q=2yAaOS3aF5YV79Ck11; m=bIew4bCaAZFM1sVyTdfkknKXRYRrPcNGWOazPda2An8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 38C6qhpS3811676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Sep 2023 15:52:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jK1e6ky/v4vHUA7R2iRRIGparql72uZdtzHh4JSBn+XVj2sTjkfjFpMclX2nE209FvPwgHtfBqrQYluw7dgFtWPHrQF1sivst4nQs9ls01fTfCzXgo2rTgUYDBc0uX/kJaLmHFdaTMgkVj6Uw7gz9eG7QRi35w9duaF+q6c9UPgL0aavzPbT64Bavtl1Q+mt4Czj+35ieTyxpPVOAWSiWWUA/LWAfufJAQRMMEQXhu5NAQt0OB/nI1YYJQRbPy0vENJ3SyvQyhrpcCGkfaVbjshVpsH+Zgox9JwWQg4y0IESkmzScMMi1KexAivri5PTWymL9bcJqgp36XKajQud8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbcGzek78jxPl6SUMYzxiNbTTMDoKP6KcMBmXMegVpo=;
 b=CZNZxfB0HVA8TybP8kFfyxWNsTmAklIqV3Yw+P+/PSd+iB4+E9xpaL6uzpcGpq4NfB0guOgVlU/VCzORfEyn+rALfcEBI8XWo6i2aVUmmFJhITWzAKuN5jz6Tj3xsLAN4esPp0loYJOEt6m7ghrPNNBMs9/CrhNWZPSlilI5TOyKpZHATZDjRGvgKRVElL8XCzVSPv1oOpTaMb8U2zt8oPMtJuMAcCiL6fhBeXaGpnfGqPZCFsp26A4v7BH1YOd8cKJqi/NP0MpOaa7HOxWiMYww4YuWVpQWIRqvK58B0LBjRssVTnNeoM6VyTl/Kh3r0x7w3VhJV+gVDHpAHAy+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Thread-Topic: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Thread-Index: AQHZ5LRS2vrHBLDxKEy6tSmaozITarAWg3oAgAAnPhA=
Date: Tue, 12 Sep 2023 06:52:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB55422F888CB0CFC373E89496A4F1A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
 <20230911133147.3164-5-venkata.pyla@toshiba-tsip.com>
 <0d30d88f-ee82-4b56-9453-85a7e1832242@siemens.com>
In-Reply-To: <0d30d88f-ee82-4b56-9453-85a7e1832242@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYVPR01MB11213:EE_
x-ms-office365-filtering-correlation-id: 88b9afe4-8a0a-4e13-98fc-08dbb35cdc26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2Iz4AlYdDOfbRm0g7Ht58Wc1OwF2HLs8j7zCPUjeRz5kuQPL//q047+B4AtdlCXP/XPw3dc6BNeY5akCg19yI/sS7zY1aCWoXggkrsGmb69K+0k/u/6FAJLMCQRgdm1aau2Y1MP07qCHf3gvHUt9V68rb55FXsp+7rxed061GhAFvvV1b4vn0zIAWO64MSEU1XgeJAaqIfhxjOI5QC7YbvXSMUDG9qf2yHXkFhbjJwjh2KUNGmeNCs26s7vhdcdtG1oQ4OcT7Ab4iZq36CJdE7Y6sih9bX4J4eg4PuyWugRhb+PLG6tqGfYXA43DBnMzKhK4MKIi+GI9vHSmm/zkf0Jyw9KbtdoWD4oKN679JPopcn7a2zOjhAPsCBqZ5Ahx6GavLR5Rys2s/UEzPvlLeuzGpqUCOQRbeOkC1iaI1c73JmoMMIsJGY5MKW2wejegepuuetHx0Yu+/2mdc9tS1OXYQr2eW71Lyv7mbAEvIrVsYXJyk5qOYp4a5girwMEvqlZbBCWGpaa6c8O+dbkEANhVptMCD13NMy9RtnTmQ14CY9FS6RTyDTr/0sexmjdmt1+MajS0ygXka02FyJrHEucbMijVNt9EWQH6ujv3ofT1cr6qMJKpcUb80CNBqEoi
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(6506007)(7696005)(9686003)(71200400001)(83380400001)(122000001)(33656002)(86362001)(38100700002)(38070700005)(85182001)(107886003)(55016003)(26005)(66556008)(54906003)(66476007)(76116006)(64756008)(66946007)(110136005)(66446008)(316002)(41300700001)(2906002)(52536014)(5660300002)(8676002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVBveEJ0WUZDa0laeGk0MmFHN2FjSkw3cFIzbG42WTducGJ1dURtN0Y3OEpz?=
 =?utf-8?B?MjhhVE5QaFFEWVR1NkF2QXM2Rjh1Ui9GY2UweWpURDlHTG85NExOK09ESnlW?=
 =?utf-8?B?dUUvTU9qN0J3dDA0a1llTXppOFZBc0hzQTE5NXR0dzJobEhQOEZtc0VYeE9o?=
 =?utf-8?B?WGlkSEdXTGFNQzhaSW1DUVgxQjZ1OXpQV2k2ck1GQkVuWUJUWXp3MkFFTUlu?=
 =?utf-8?B?dVlJa2Y2VlBJcHJyYVhBSG5DVVVZVEwxREtMeEVUektxWk5JNmd4WlBxMTJP?=
 =?utf-8?B?WkE0UVF0RlpCWjkyUjZTakRmWHZ6TVo5Q3hCdHdQRHhQSWRkZnN6NnRLQ2pS?=
 =?utf-8?B?VWYxRzlEQlBYc0wvZ2thOXQrcCt0QmpRR3ZjMWpCZEhTb3JkbmIwMGNZY0FS?=
 =?utf-8?B?NTBnUlY1TDlGcXRIR1IrcWZYcUF1b0V3L1pBd3E4SlNiZlhjM0gvV3oyanZC?=
 =?utf-8?B?MzlSOC9hZ3R6ckttaFppNXNhWDgxNm90VVNqWnJ2SHhDYndFeDFWb1VpaTNS?=
 =?utf-8?B?b3NETkVqY1RLbW5KbjB5TGhVTFhyZktPR3A3eHVQTE5sWDlBOWFicExqVkp2?=
 =?utf-8?B?YjFaazVpZzJ4aU94OWkvZHhpREtMaVFZMU52N2hwZmF2Q1hQSVkxRFE3S0pj?=
 =?utf-8?B?RHp5RDZUNnJBTnFnbXZRbW9Xc2dZY0cvTzczOTVPYUFWSTZCdVBaa1NFN2Rz?=
 =?utf-8?B?OGh4QmZudWFRdUVyWExLcENmOGpzMXB3bk04cW1mQk12OUEvUUJZQU9BSVI4?=
 =?utf-8?B?S3VGUHloMFZCaWhmNmZWdnFGbTNWcmViZHU0WTBsZlkwcUE0dXp1VFNnZU51?=
 =?utf-8?B?bUtPQndmYVh5SWd3d3BqTlFrZUFaS0M0V1NUOTBESDJNNXdVWEVoTlR5eVNP?=
 =?utf-8?B?Ri9EbEpnR2JnK2NkR2hyb0RQbjBMcEFEQWViczh0dXAxNVErdmtNWlErdG5a?=
 =?utf-8?B?aUlqakJvOThFV3hUbkFvRmN2SlFGNzRjejNHcnAzazlleDhkelBDZ04zTCtX?=
 =?utf-8?B?SFpCQU5OYjVqZ2V3QmNHc01kZ2ljOTY5Um5PNXpNcmk3Q2ptTFBpc0FJd25I?=
 =?utf-8?B?anN5K2FhdnRzd2RZWmROaitTTUhFV3IwQ1M5WDFua2JIQzZiQUVEallHdytq?=
 =?utf-8?B?TkxLWHgwd1lleTQxQ0grbzFSYnkycmhYU3RQT1I2aGZmL2FDWUluOUpzbmRG?=
 =?utf-8?B?Qk9Td3dITmQrTGtXbFhZVHZXM0tQYURHYmlWb29VUGdiVTE5MFkwTUdZRnA5?=
 =?utf-8?B?UGN1aU1wU3QrMERJRitocEU5d3BKVktQUlFmNWZzS25kcktHamVzSCsxNEgr?=
 =?utf-8?B?dW5PYnE3SUloWFZ1QUxGeFZpRy9hM1BzaGIxYlVWNEJ1dWNGSjFqZDBTTGQv?=
 =?utf-8?B?dm9KQ0hFTk02KzUzeThuSWVjTnBMdDNSdytOMzB0NXN4aFRETlhMTThRRTRs?=
 =?utf-8?B?eTNuN2FZQ2Y3Y1diQnlnUEVJZ2U4VGswaTY3bU1KVHovL3dHNXpvWmFheXZZ?=
 =?utf-8?B?WWxuUlk5THU5Z21yM3Y0UnJub2VNbkNPY0hXaG91a2FmbkRYUDFNbGhxMFFC?=
 =?utf-8?B?YVo4T2dtWnVFVnRPSFBGQkM4TlcwRmMvQVZGT2w1OHFKeTJQMHVFMkRhRUh6?=
 =?utf-8?B?M0ZwMWFLWnVUV1lSSS93b2lYTW40YXhLRmVPRGJleVFjbTdJaW4yWG52ZkZu?=
 =?utf-8?B?Vi9OWHI3eWcxQmhnbFNUUlJDbURrdTJpOVU3Qm0rL0FUWEhuNEVmQ3JkSGtY?=
 =?utf-8?B?QmdWN2M0QVVhUkdPVUxVQ0FBNExIVzRNU25EbStqVG1rOTU4S3Ivb29wVTJ5?=
 =?utf-8?B?dFZOYnVUb3pCUGlnWkl3YkRoVGlrdUI1WlA5S1ZYUGtjMHI0R2RMbWVsRjBW?=
 =?utf-8?B?ZEpZT0VEV0c1UWlPZ01tNVowVklRTmlwb0h1U1VPdWgvdXBYakpjSGd5Tkhh?=
 =?utf-8?B?Q1hNa0N1NWFNYTlCeHpCM2lhUzB0OHY2dkNwWGxkVkhMVnVkMG9FeEl5R2dE?=
 =?utf-8?B?bEoyYUZ2azBrWGRWT2lpNWRxdDNzRnFWTWN4SE5Tb25iTUlZNkZXTlowbVFz?=
 =?utf-8?B?bldUYnhCUDBvMjlnckdkZktYTzVubWR4Z1dSQ2NQTjhOellIWVl6RE9EZ0V2?=
 =?utf-8?B?ZzdGV1JrUldtclJDTmVPUGR0Y2pQV2p1clN1NWVjVmQrM0NXTG8wWENTUHBM?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b9afe4-8a0a-4e13-98fc-08dbb35cdc26
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 06:52:41.4411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4nbulpYkK63cs1l0F67Q/dBr/xkVZa3j8Q1PAH/LZsnzv675gnytrxhdPQToUsHERexpiWsE7QaB1Ww5acMwqxZd3yqyr9GCJftDQ2SgeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11213
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 06:52:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13056

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEyLCAyMDIzIDg6
MzkgQU0NCj5UbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykg
PFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPnRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcNCj5DYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGlu
ZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLQ0KPnRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjm
npcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vvvK3vvLDvvJQp
DQo+PGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+U3ViamVjdDogUmU6IFtpc2Fy
LWNpcC1jb3JlIDQvNV0gLnJlcHJvZHVjaWJsZS1jaGVjay1jaS55bWw6IEFkZCBCQkIgdGFyZ2V0
DQo+DQo+T24gMTEuMDkuMjMgMTk6MDEsIHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tIHdy
b3RlOg0KPj4gRnJvbTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNv
bT4NCj4+DQo+DQo+V2hpY2ggYWRkaXRpb25hbCBhc3BlY3RzIG9mIHJlcHJvZHVjaWJpbGl0eSBk
b2VzIHRoaXMgdGFyZ2V0IHRlc3Q/DQoNCkl0IHdpbGwgdHJ5IHRvIHZlcmlmeSBhZGRpdGlvbmFs
bHkgYmVhZ2xlIGJvbmUgc3BlY2lmaWMgZmlsZXMgbGlrZSBNTE8sIHUtYm9vdCBhbmQgZHRiIGZp
bGVzLg0KDQoNCj4NCj5KYW4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IHZlbmthdGEgcHlsYSA8dmVu
a2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+ICAucmVwcm9kdWNpYmxlLWNo
ZWNrLWNpLnltbCB8IDE2ICsrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTYg
aW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS8ucmVwcm9kdWNpYmxlLWNoZWNrLWNp
LnltbCBiLy5yZXByb2R1Y2libGUtY2hlY2stY2kueW1sDQo+PiBpbmRleCBkZWMyOGUyLi42YmNj
MjE1IDEwMDY0NA0KPj4gLS0tIGEvLnJlcHJvZHVjaWJsZS1jaGVjay1jaS55bWwNCj4+ICsrKyBi
Ly5yZXByb2R1Y2libGUtY2hlY2stY2kueW1sDQo+PiBAQCAtODcsNiArODcsMTMgQEAgYnVpbGQ6
cWVtdS1hcm0tcmVwcm8tYnVpbGQ6DQo+PiAgICB2YXJpYWJsZXM6DQo+PiAgICAgIHRhcmdldDog
cWVtdS1hcm0NCj4+DQo+PiArYnVpbGQ6YmJiLXJlcHJvLWJ1aWxkOg0KPj4gKyAgZXh0ZW5kczoN
Cj4+ICsgICAgLSAucmVwcm8tYnVpbGQNCj4+ICsgIHZhcmlhYmxlczoNCj4+ICsgICAgdGFyZ2V0
OiBiYmINCj4+ICsgICAgZXh0ZW5zaW9uOiAibm9uZSINCj4+ICsNCj4+ICAjIHJlcHJvIGJ1aWxk
IHRlc3QNCj4+ICB0ZXN0OnFlbXUtYW1kNjQtcmVwcm8tdGVzdDoNCj4+ICAgIGV4dGVuZHM6DQo+
PiBAQCAtMTExLDMgKzExOCwxMiBAQCB0ZXN0OnFlbXUtYXJtLXJlcHJvLXRlc3Q6DQo+PiAgICAg
IHRhcmdldDogcWVtdS1hcm0NCj4+ICAgIGRlcGVuZGVuY2llczoNCj4+ICAgICAgLSBidWlsZDpx
ZW11LWFybS1yZXByby1idWlsZA0KPj4gKw0KPj4gK3Rlc3Q6YmJiLXJlcHJvLXRlc3Q6DQo+PiAr
ICBleHRlbmRzOg0KPj4gKyAgICAtIC5yZXByby10ZXN0DQo+PiArICB2YXJpYWJsZXM6DQo+PiAr
ICAgIHRhcmdldDogYmJiDQo+PiArICAgIGV4dGVuc2lvbjogIm5vbmUiDQo+PiArICBkZXBlbmRl
bmNpZXM6DQo+PiArICAgIC0gYnVpbGQ6YmJiLXJlcHJvLWJ1aWxkDQo+DQo+LS0NCj5TaWVtZW5z
IEFHLCBUZWNobm9sb2d5DQo+TGludXggRXhwZXJ0IENlbnRlcg0K


