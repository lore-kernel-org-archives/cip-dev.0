Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F669C61DA4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 04:00:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.1051.1677038428923366402
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 20:00:29 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 31M40Q9J010756; Wed, 22 Feb 2023 13:00:26 +0900
X-Iguazu-Qid: 2wHHFCEuxd4EH1UxIz
X-Iguazu-QSIG: v=2; s=0; t=1677038426; q=2wHHFCEuxd4EH1UxIz; m=w3cvkum1uwoK9sVt77ufrg7K0VT41iR5a5gOTLFq0NM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1113) id 31M40PU7024704
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 13:00:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iynEhRHHSkeAb+UK9bUgWnSy/W1qJXutstHDPrlSpMscJ0EnX0/2y1ucw3EkK0YhLn0AYOZTRqKcKMFK0V3s9pPrzjx6PLpykaokYKywSF3UuQN3WNECQBKre1B5NoqUVPdth+ymv2jFeEptn9PiaAm5dOZOZ2ibLn3RkaE1PiDZcrkGufIsSmWCOVB/hp9t7DSimyIFvej+1Hc42mfxMqxufyIfqZH7h5d3visPTMmy/rAY+a50oIbHHR6jc8SM+qrdZWH/WEYLyuGzKXz4cldgBPbiXqp7YPPoZOJQ2en6xKsu0W78ik5rSgL7wzETizko5LM4HpS6uZqbvRcH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWU4PsbS2gLDD/u2aPrXLU8exbjCwecKdiMC0q48eTU=;
 b=TBaza5ty3Vl+d7BFzegrlce/DBTa2/8STpCsTDwvhaTyPs6Ect7enzn1rIREgUcVIwkkSJ14D4dZEQ+FJ9LQRkZ6lienJj/1xNo/DLc2lH82OrkSx5XbvLxgcsq9vd9d2l3hIgi2tvv1b6i2/e5osju/1LIhzw9sZT9QuC/IhDIYc1f0nYokOL0Q+hsEqhYlCEBhs85/6Vl+DXLa57b5xsijPAJgp6GowhFWIpw/TwJqIpKzHgthXtYYv0Bv5zYbTE4dXNKz/dIo156sbwhGEx34pM84YEPiuatspEPhdtK7c94sxN9OnxazhHFF14bo0zuAoJ6ewDt0O1imElWm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core 2/2] .gitlab-ci.yml: Add ci for reproducible build
 checks
Thread-Topic: [isar-cip-core 2/2] .gitlab-ci.yml: Add ci for reproducible
 build checks
Thread-Index: AQHZRgr30edlur38p0yPf02vX5mVXK7Z3eeAgAB5iTA=
Date: Wed, 22 Feb 2023 04:00:23 +0000
X-TSB-HOP2: ON
Message-ID: <OSYPR01MB5542AAF1A673B38641150D44A4AA9@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230221154138.15146-1-venkata.pyla@toshiba-tsip.com>
 <20230221154138.15146-3-venkata.pyla@toshiba-tsip.com>
 <77701639-f705-5b20-f7e6-197cfdf5ee05@siemens.com>
In-Reply-To: <77701639-f705-5b20-f7e6-197cfdf5ee05@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYCPR01MB11270:EE_
x-ms-office365-filtering-correlation-id: 4fca7eba-3f72-4158-953c-08db14895297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0QuR2C1A/Qu1TkHvCQ/EhoMNZMGAcA6oSZe348tBj8nMxNuflXB3IwG1XMCeLYtKGYMIsPIJNM2PIQjS+Qy03Vjym02qlRvEh6LSrdlKHXCwWogdZgIzMD+EzeMhb/VbRERjf1F08aZCJFl1UYSMWeMgjjCRcEX0pPPhdns3w2Rg5fSW/StPZjDhxmHxstDKXJ7pJPUiRN6C5vGv4UdlnT5HMzOCiLIVRabTS2cFeVKn2Maf2vX3JyT9xXrDclA6kZaLEDcKAYJlZP4r9Uz9+qukBsAedg1yJvgkWl+DDCuwAwEa+lD4tU6c2kXcQayt4mL13B1Iapqr3ck4L/dM3H19CmGOP//Y4tGVaTlapmeIUbY9XT12PZl8Q9yL7PKWX/40D97imiKF7PUZCe+4d8ZDRjeEoQAEvIFNCGaFZtFLhd/346DRAUMnVLVYHh1TQeNprXO2jz3XJBsKgbugaACAJhfnZK7ICnLnyck/bnkZIT+1tBXZAfP5epPWtiLyB2CdlTZukbL7xTikOoBPQqW491uWnRpcykFQ8WoOYFrgDndncdZvCAUtCLqYnvjO3VVF4jTPcJ5t64Z5SLPdhXnuNQsfAGEsb/+1yISBFZeesee06dXdApzesIdHltRxQDOdmoMZGTrxOJWkQvMxHHjTW5j0B8cNtDXoQ89U6j3VJPSNF0Bo13SWA+YpbivPt1RHifrJq7v1ribv3PEFQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199018)(478600001)(71200400001)(7696005)(122000001)(38100700002)(86362001)(2906002)(33656002)(38070700005)(316002)(110136005)(54906003)(41300700001)(85182001)(5660300002)(52536014)(8936002)(83380400001)(55016003)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(66446008)(4326008)(26005)(186003)(9686003)(107886003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHlSQXZXUGQwZ2ZEN1JlVkxZUU4xMCt6T3hHRGMrUEJOeklVb1ZrMDY1Yitz?=
 =?utf-8?B?bkordTk3Z3o4OUxhelpVYURWTmpRYnkvWTIyRzhKTXFMYktMdW5idzAzWlVv?=
 =?utf-8?B?UTA4M2RtSXd4RzN3T1k2QWZEYUR2YVY4bS9sc0ZaZElVaGdkeEc5dHFoSm14?=
 =?utf-8?B?VjBnRXNUOHVYdGpXcXloZUk1OVBUZmNHOVdpUUx0NkdrQVF6WVdRRU1GK05p?=
 =?utf-8?B?RzBMMHc1TGpJVDY4VEVqdFJVOVZjSzlub3lNdHphQlNYRlI5VTVhbUh1V3Ew?=
 =?utf-8?B?MnczVXl4VE9NOEhWYXErcWJraU55cmpXMlVGY0pQTUYzeEJON1JnNXRjV0Q3?=
 =?utf-8?B?aURhYkhpSk4wbGg2SHV6cmFzcFN4d0JZR09jV3Q1ZWRhejBOa2dzMENHa3Bn?=
 =?utf-8?B?UzVrNE5CQnNsOG0vV2NqbXB2bGtSZXMwWDZDQS9JNm4rUmFWQ2E3aGFwSlNC?=
 =?utf-8?B?L0JFUHlWNWxPdXFnYTAvbHdOVnNuSklaTVV2dGNyeG1POEtiSlg0SzZ0ZGZx?=
 =?utf-8?B?ZnAydmthWDY5Z3JIQTduN3RVQ1RzYUZOd1lnNFFFYzlyQ1RqdXZ3UWw5eU1O?=
 =?utf-8?B?VnM2YWpFZzkvQXpweGtKOUpEVTZvbDdDM3VLSTdKaWdPQmllR0UwZUsxY1Vt?=
 =?utf-8?B?b3lnL3o5NS9aMWtSZy8wc1hzeWhWcjFlU1V2WkpPZ1B5WW5wSXFPUFlQeHRw?=
 =?utf-8?B?bFRxSjFRMk5MbDNpclgrbWVUMmZid2pDSzBNdDl2M1ZkbTdqOGxRRDh6Skx0?=
 =?utf-8?B?RzVwNjI3TmxsSmhucEdwMW4zdXhvWlVNTkcwZ3dEMGtrc29veElLaWNCYzVU?=
 =?utf-8?B?MVU5QnpzNGVrVWk3c0FDTzVpaEc3bXR5NmpPazZibm53aXpkL2lXTk0rZ2NJ?=
 =?utf-8?B?VHFjYnNZVDA0bjV6WmsxaTFPL245NjJvQzkwc3pKLzQyZ2lFWVRVY1d3dXkx?=
 =?utf-8?B?em1VQzNkQ1BVODRjUFpxdW5tVkVwTnYwNk9jMXAwMXRuMWVMVjdBS2RnTU1X?=
 =?utf-8?B?TlBJcGlvSUxUVlhVQXArbTNvREVJalB2Y2VMNElHS21oVEtyaUxDTi9IZkJF?=
 =?utf-8?B?UUpSV2kvbTBCSTdKRFliU2hGQ0VhM0tZb1hxVzd1bWYwT1NGOWc4RVFDcWhl?=
 =?utf-8?B?WHdjMHUxNWlTQldBUjRCTS81SVMzQUN1dllLeTZEdUhZWFUrTEdkSUd6TXVi?=
 =?utf-8?B?L2FldnpMTTd4UGlGWUhRMjQ4YkFxOEJYbkhuMTFjNVF2c284OVoxRE1mcmp2?=
 =?utf-8?B?MURtOWdEeFhUanNHcTZPWnh3TGd0UTl5Vndvci9vWkVDQjJWZDg1c3g1Q0dY?=
 =?utf-8?B?Y3RJYTN6d2FROWF1d2FHV3VKeHpnMzNpdHNFUmE5UGhHQ2FhdVVaVzI2TlF6?=
 =?utf-8?B?QjROWGt2NStVZVFLV2tlamtvTWduTkI4Qm9tMHlhSTZOcFU2VHZWR1RoVWRW?=
 =?utf-8?B?MWhOWGZaTytBblYxd3hFZVBRZkJCMndBend5STlvOGJJWVJXdm5HMDc3dkhD?=
 =?utf-8?B?YThjNlEvbDVTVnk2enFJenNKV3orcXBCZTJLMzJKSzk5NmpKQVpPbi91czUr?=
 =?utf-8?B?TGgvZloySEQrZWoxY0VGVVptZnh0Y0F5ZkZFcUhhVFRZbnM0YnFSYTROWUhF?=
 =?utf-8?B?U29GcUxKMldEVUc5ZmFIMjgwNkQxcER2MlJLVmxYKzViWGV6VngyV01MaDF5?=
 =?utf-8?B?ZTNPSWVwYmlBa2I5aVZxNDUzZk9zUkNKZEFYNEQrRnRyRlBUKy9wRzlvdlp4?=
 =?utf-8?B?Sk45UlNWZS90Vm1lM04vVWppQ1ppQWpJQTdiMUdCcUN2eGFRVjJSSWtsWFhm?=
 =?utf-8?B?VHVjbUJIY1R5K1ZOcHRMeXVjZyt1QWdxdDN2b3RLMWpJaHc2RlJWN3E0WkMz?=
 =?utf-8?B?ZDdnSWdiMHkwR2IwMHJvRWR3Z1hjYjRIZEoxdjhhZkRFcDI5YnBmWVBtVlF6?=
 =?utf-8?B?cUt2Mmh4czFwcHpkK3JVMWkxRFptbDc0MVhyNE1VdlVoSys0Mkd5SmZGei9x?=
 =?utf-8?B?bTl1R0FlSjJBRGQ5c2c5UThPRGdNcy9zVjNSaGcxNlhwWUZVTDV4UUpiQmdh?=
 =?utf-8?B?SG5PdGpPeFZxRW44cWJJWWIzR3BDL2RraGZyZGlJMGdqVnlZY2dGcDdrZlM1?=
 =?utf-8?B?ZVNiM2d0cEtxUUFTeEhoZWdRSU40L2lWRHZpekRIY0VJV0xVcFhFQTlKeTdh?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fca7eba-3f72-4158-953c-08db14895297
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 04:00:23.1641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0NvqdHX4tbGMnaK6hwpLrs2zMdTE09H5WdJnzz79w56arXPABChKZ3/R9E22H5F/3Cl1SXHr2+SSCKaiYch04arm7ai8RXEytx9uxh+Qyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11270
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 04:00:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10767

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogMjIgRmVicnVhcnkgMjAyMyAwMjoxMg0KPlRvOiBw
eWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxh
QHRvc2hpYmEtDQo+dHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPkNj
OiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1
bWFyQHRvc2hpYmEtDQo+dHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah
77yz77y377yj4pev77yh77yj77y0KQ0KPjxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpw
Pg0KPlN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZSAyLzJdIC5naXRsYWItY2kueW1sOiBBZGQg
Y2kgZm9yIHJlcHJvZHVjaWJsZSBidWlsZA0KPmNoZWNrcw0KPg0KPk9uIDIxLjAyLjIzIDE2OjQx
LCB2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4+IEZyb206IHZlbmthdGEg
cHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+Pg0KPg0KPlF1aXRlIGEgYml0
IG9mIHlvdXIgZXhwbGFuYXRpb24gZnJvbSB0aGUgY292ZXIgbGV0dGVyIHNob3VsZCBhY3R1YWxs
eSBnbyBoZXJlDQo+aW5zdGVhZC4gVGhpcyBoZXJlIHdpbGwgYmUgYXJjaGl2ZWQgaW4gZ2l0LCB0
aGUgY292ZXIgb25seSBpbiB0aGUgZW1haWwgYXJjaGl2ZS4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6
IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+
ICAuZ2l0bGFiLWNpLnltbCB8IDkzDQo+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA5MyBpbnNlcnRpb25zKCsp
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhLy5naXRsYWItY2kueW1sIGIvLmdpdGxhYi1jaS55bWwgaW5k
ZXggZjdjOGM4OC4uMzQ1OGEyZg0KPj4gMTAwNjQ0DQo+PiAtLS0gYS8uZ2l0bGFiLWNpLnltbA0K
Pj4gKysrIGIvLmdpdGxhYi1jaS55bWwNCj4+IEBAIC0xMyw2ICsxMyw3IEBAIHZhcmlhYmxlczoN
Cj4+DQo+PiAgc3RhZ2VzOg0KPj4gICAgLSBidWlsZA0KPj4gKyAgLSB0ZXN0DQo+Pg0KPj4gIGRl
ZmF1bHQ6DQo+PiAgICBiZWZvcmVfc2NyaXB0Og0KPj4gQEAgLTI2LDYgKzI3LDggQEAgZGVmYXVs
dDoNCj4+DQo+PiAgLmJ1aWxkX2Jhc2U6DQo+PiAgICBzdGFnZTogYnVpbGQNCj4+ICsgIGV4Y2Vw
dDoNCj4+ICsgICAgLSBzY2hlZHVsZXMNCj4+ICAgIHRhZ3M6DQo+PiAgICAgIC0gbGFyZ2UNCj4+
ICAgIHZhcmlhYmxlczoNCj4+IEBAIC00Miw2ICs0NSw1NyBAQCBkZWZhdWx0Og0KPj4gICAgICAt
IGlmIFsgIiR7ZGVwbG95fSIgPSAiZW5hYmxlIiBdOyB0aGVuIHNjcmlwdHMvZGVwbG95LWNpcC1j
b3JlLnNoICR7cmVsZWFzZX0NCj4ke3RhcmdldH0gJHtleHRlbnNpb259ICR7ZHRifSAke0NJX0NP
TU1JVF9SRUZfU0xVR307IGZpDQo+PiAgICAgIC0gaWYgWyAiJHtkZXBsb3lfa2VybmVsY2l9IiA9
ICJlbmFibGUiIF07IHRoZW4NCj4+IHNjcmlwdHMvZGVwbG95LWtlcm5lbGNpLnB5ICR7cmVsZWFz
ZX0gJHt0YXJnZXR9ICR7ZXh0ZW5zaW9ufSAke2R0Yn07DQo+PiBmaQ0KPj4NCj4+ICsucmVwcm8t
YnVpbGQ6DQo+PiArICB2YXJpYWJsZXM6DQo+PiArICAgIHVzZV9ydDogZGlzYWJsZQ0KPj4gKyAg
ICB3aWNfdGFyZ3o6IGRpc2FibGUNCj4+ICsgICAgdGFyZ3o6IGVuYWJsZQ0KPj4gKyAgICBkZXBs
b3k6IGRpc2FibGUNCj4+ICsgICAgZGVwbG95X2tlcm5lbGNpOiBkaXNhYmxlDQo+PiArICAgIGFy
dGlmYWN0X3N1ZmZpeDogIi50YXIuZ3oiDQo+PiArICAgIGJhc2VfeWFtbDogImthcy1jaXAueW1s
Omthcy9ib2FyZC8ke3RhcmdldH0ueW1sIg0KPj4gKyAgc3RhZ2U6IGJ1aWxkDQo+PiArICB0YWdz
Og0KPj4gKyAgICAtIGxhcmdlDQo+PiArICBvbmx5Og0KPj4gKyAgICAtIHNjaGVkdWxlcw0KPj4g
KyAgc2NyaXB0Og0KPj4gKyAgICAtIGlmIFsgLWYga2FzL29wdC9yZXByb2R1Y2libGUueW1sIF07
IHRoZW4NCj5iYXNlX3lhbWw9IiR7YmFzZV95YW1sfTprYXMvb3B0L3JlcHJvZHVjaWJsZS55bWwi
OyBmaQ0KPj4gKyAgICAjIEJ1aWxkIDFzdCB0aW1lDQo+PiArICAgIC0gIXJlZmVyZW5jZSBbLmJ1
aWxkX2Jhc2UsIHNjcmlwdF0NCj4+ICsgICAgLSBtdiBidWlsZC90bXAvZGVwbG95L2ltYWdlcy8k
e3RhcmdldH0vY2lwLWNvcmUtaW1hZ2UtY2lwLWNvcmUtDQo+JHtyZWxlYXNlfS0ke3RhcmdldH0k
e2FydGlmYWN0X3N1ZmZpeH0gaW1hZ2UxDQo+PiArICAgICMgY2xlYW4NCj4+ICsgICAgLSBzdWRv
IHJtIC1yZiBidWlsZC90bXANCj4+ICsgICAgLSBzdWRvIHJtIC1yZiBidWlsZC9zc3RhdGUtY2Fj
aGUNCj4+ICsgICAgIyBCdWlsZCAybmQgdGltZQ0KPj4gKyAgICAtICFyZWZlcmVuY2UgWy5idWls
ZF9iYXNlLCBzY3JpcHRdDQo+PiArICAgIC0gbXYNCj4+ICtidWlsZC90bXAvZGVwbG95L2ltYWdl
cy8ke3RhcmdldH0vY2lwLWNvcmUtaW1hZ2UtY2lwLWNvcmUtJHtyZWxlYXNlfS0NCj4+ICske3Rh
cmdldH0ke2FydGlmYWN0X3N1ZmZpeH0gaW1hZ2UyDQo+PiArICBhcnRpZmFjdHM6DQo+PiArICAg
IGV4cGlyZV9pbjogMSBkYXkNCj4+ICsgICAgcGF0aHM6DQo+PiArICAgICAgLSBpbWFnZTENCj4+
ICsgICAgICAtIGltYWdlMg0KPj4gKw0KPj4gKy5yZXByby10ZXN0Og0KPj4gKyAgaW1hZ2U6DQo+
PiArICAgIG5hbWU6IGRlYmlhbjpidWxsc2V5ZQ0KPj4gKyAgdGFnczoNCj4+ICsgICAgLSBsYXJn
ZQ0KPj4gKyAgc3RhZ2U6IHRlc3QNCj4+ICsgIG9ubHk6DQo+PiArICAgIC0gc2NoZWR1bGVzDQo+
PiArICB2YXJpYWJsZXM6DQo+PiArICAgIEdJVF9TVFJBVEVHWTogbm9uZQ0KPj4gKyAgYmVmb3Jl
X3NjcmlwdDoNCj4+ICsgICAgLSBhcHQgdXBkYXRlICYmIERFQklBTl9GUk9OVEVORD1ub25pbnRl
cmFjdGl2ZSBhcHQgaW5zdGFsbCAteQ0KPj4gK2RpZmZvc2NvcGUNCj4+ICsgIHNjcmlwdDoNCj4+
ICsgICAgLSBkaWZmb3Njb3BlIC0tdGV4dCBkaWZmb3Njb3BlX291dHB1dC50eHQgaW1hZ2UxIGlt
YWdlMg0KPj4gKyAgYXJ0aWZhY3RzOg0KPj4gKyAgICB3aGVuOiBhbHdheXMNCj4+ICsgICAgZXhw
aXJlX2luOiAxIGRheQ0KPj4gKyAgICBwYXRoczoNCj4+ICsgICAgICAtIGRpZmZvc2NvcGVfb3V0
cHV0LnR4dA0KPj4gKw0KPj4gICMgYmFzZSBpbWFnZQ0KPj4gIGJ1aWxkOnNpbWF0aWMtaXBjMjI3
ZS1iYXNlOg0KPj4gICAgZXh0ZW5kczoNCj4+IEBAIC0yODEsMyArMzM1LDQyIEBAIGJ1aWxkOnFl
bXUtYW1kNjQtc2VjdXJlLWJvb3QtYnVzdGVyOg0KPj4gICAgICB1c2VfcnQ6IGRpc2FibGUNCj4+
ICAgICAgd2ljX3Rhcmd6OiBkaXNhYmxlDQo+PiAgICAgIGRlcGxveTogZGlzYWJsZQ0KPj4gKw0K
Pj4gKyMgcmVwcm8gYnVpbGQNCj4+ICtidWlsZDpxZW11LWFtZDY0LWJhc2UtcmVwcm8tYnVpbGQ6
DQo+PiArICBleHRlbmRzOg0KPj4gKyAgICAtIC5yZXByby1idWlsZA0KPj4gKyAgdmFyaWFibGVz
Og0KPj4gKyAgICB0YXJnZXQ6IHFlbXUtYW1kNjQNCj4+ICsNCj4+ICtidWlsZDpxZW11LWFybTY0
LWJhc2UtcmVwcm8tYnVpbGQ6DQo+PiArICBleHRlbmRzOg0KPj4gKyAgICAtIC5yZXByby1idWls
ZA0KPj4gKyAgdmFyaWFibGVzOg0KPj4gKyAgICB0YXJnZXQ6IHFlbXUtYXJtNjQNCj4+ICsNCj4+
ICtidWlsZDpxZW11LWFybS1iYXNlLXJlcHJvLWJ1aWxkOg0KPj4gKyAgZXh0ZW5kczoNCj4+ICsg
ICAgLSAucmVwcm8tYnVpbGQNCj4+ICsgIHZhcmlhYmxlczoNCj4+ICsgICAgdGFyZ2V0OiBxZW11
LWFybQ0KPj4gKw0KPj4gKyMgcmVwcm8gYnVpbGQgdGVzdA0KPj4gK3Rlc3Q6cWVtdS1hbWQ2NC1i
YXNlLXJlcHJvLXRlc3Q6DQo+PiArICBleHRlbmRzOg0KPj4gKyAgICAtIC5yZXByby10ZXN0DQo+
PiArICBkZXBlbmRlbmNpZXM6DQo+PiArICAgIC0gYnVpbGQ6cWVtdS1hbWQ2NC1iYXNlLXJlcHJv
LWJ1aWxkDQo+PiArDQo+PiArdGVzdDpxZW11LWFybTY0LWJhc2UtcmVwcm8tdGVzdDoNCj4+ICsg
IGV4dGVuZHM6DQo+PiArICAgIC0gLnJlcHJvLXRlc3QNCj4+ICsgIGRlcGVuZGVuY2llczoNCj4+
ICsgICAgLSBidWlsZDpxZW11LWFybTY0LWJhc2UtcmVwcm8tYnVpbGQNCj4+ICsNCj4+ICt0ZXN0
OnFlbXUtYXJtLWJhc2UtcmVwcm8tdGVzdDoNCj4+ICsgIGV4dGVuZHM6DQo+PiArICAgIC0gLnJl
cHJvLXRlc3QNCj4+ICsgIGRlcGVuZGVuY2llczoNCj4+ICsgICAgLSBidWlsZDpxZW11LWFybS1i
YXNlLXJlcHJvLWJ1aWxkDQo+PiArDQo+DQo+T3VyIGdpdGxhYi1jaSBmaWxlIGJlY29tZXMgbGFy
Z2VyIGFuZCBsYXJnZXIuIEhvdyBhYm91dCBzcGxpdHRpbmcgaXQgaW50bw0KPmRpZmZlcmVudCB0
b3BpY3MgYW5kIGluY2x1ZGUgdGhvc2Ugc3BsaXQtdXAgZmlsZXM/DQoNClRoYW5rcyBmb3IgcG9p
bnRpbmcgb3V0LCBJIHdpbGwgZG8gc3BsaXQtdXAgYW5kIHNlbmQgdGhlIHBhdGNoIGFnYWluLg0K
DQo+DQo+SmFuDQo+DQo+LS0NCj5TaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+Q29tcGV0ZW5jZSBD
ZW50ZXIgRW1iZWRkZWQgTGludXgNCg==


