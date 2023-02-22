Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628E6C61DA4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 10:56:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.5975.1677063413467396198
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 02:56:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 31MAuoTT006785; Wed, 22 Feb 2023 19:56:50 +0900
X-Iguazu-Qid: 2wHHJG9eLZ4wkNPEgq
X-Iguazu-QSIG: v=2; s=0; t=1677063410; q=2wHHJG9eLZ4wkNPEgq; m=7aT7iZpVU+A1pvyl/ubZ8iCrNKk+FaMmIQllPIRnLWQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 31MAulXk012153
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 19:56:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpvclbtVLptjPWy/U54mlmHIaeuKxxP/y6vTCw3AMZbQjJWGFo+YhDo6COr/3ww0nK7//eCQNZTUqIzhOFPSIvKyucMopWb2BypctNA8IA8v4GU2zbv9l+CJCcIFyC8ZAEb0nEXMmf92komf9j1Q33wfebiZEpwnF5Lhzi4Tj8yNeGdsNFvGkGX+MLItfk/EEIfqZOAhXLU63MVboVvR6bhI1ggX+WeihunXxfEnKe1OkR6474rwjNZAu1ckTehbCmFn1du4fynE6C912Axc1l2c6EYCc+vSozUCb9fewqcUk5cqTbJXiktLJOx6i12V7rL2FIOENIABleulEJZFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TiRKWTYcMD3NQidUNqgQygeWEXr3cEtoDYFfnWAYuc=;
 b=lBELij9dfclR9GacnwHvlaYX3mS2DWKj/76TVsm85ZtaTeWKolwKzBwhhCQ3ea5+inH87B/4BkjVJPvMYiw8AT9iG2IuOPvgEUreKdG6zj5bt2v4x00GHFuhEeqwR37Qiz/cFagCgi2zTpiYtrT055v4yA1Fm4GN3cU6eVoji/VhX/vZZTLeXyej8J9LIlu0X2VdtxpSbUFFvYrrgxqyVJ6fbeoEtSWr9to8hpeFkBpF5vaxzvZd8/FyTUF7RyZeefHheG3bntzivWOZpDIgkzC76sQn4y++/195uSBp30C13vT1B9xkbJgXOuMyByN7wuT8Nl0ZP3kBhwiACbvNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core 1/2] kas/opt/reproducible.yml: Add kas
 file for reproducible builds target
Thread-Topic: [cip-dev] [isar-cip-core 1/2] kas/opt/reproducible.yml: Add kas
 file for reproducible builds target
Thread-Index: AQHZRp2rF0QRyQ5zJkW1ZgCY+yQ+ga7ar/aAgAAZzcA=
Date: Wed, 22 Feb 2023 10:56:45 +0000
X-TSB-HOP2: ON
Message-ID: <OSYPR01MB5542F87939C4E07105C52A2AA4AA9@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230222091159.18216-1-venkata.pyla@toshiba-tsip.com>
	 <20230222091159.18216-2-venkata.pyla@toshiba-tsip.com>
 <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
In-Reply-To: <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYCPR01MB11494:EE_
x-ms-office365-filtering-correlation-id: 64d44020-0e03-44bd-370b-08db14c37d03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udRb50ICKQeIjrQfgzBK1r5LO9BZ2ij4zlJXyyP3D6fEpSw3v/J1hhKS19+jyzUZ145G1nhDOfkV+wKSHxkAIEsM/FwhhkF5+nipYN3hqHVLRjMBZrmtx9tERi5oBRHnpncM19jS4NQJHrv3wMfssFkE0qvFkLlSIFM5cqh4rq+uCkQdtUM/iqpbXYTiL5pWOl/rdYOYy/WWEmRADHMmLbetfh2of3HHsKwq92zEqdA3SRYe81H3lZJ2np+EUEBhAq0KGLffvAZU/X21UM8nAnLtOT1e79q2F4uVWIDjOVO52kVRrSYOzegrqLtg2Y8o0/tyH7vG4/Dd2CU91r2+1uUdPjTM4vsnhiZV6N74s6/GJXxMKWdcPOkrkXGraEF7jKShiqHiZnY4kvi8adbxOORgnosv+taTxTAzkFfBeVUDrdpCdUoG2n+/TFwJWtdDMNyfd1pvWENEYOLqBXDwZqXTiPRvR7S31PXyIuaBVAhTcwPUjGOsN+GwYYDcZHjBwo6lbksAgs7gKIByLsb5SWC4+tqzWC6gzNUbTUuGv9YFa6V7FSAHAoSuDbEPgNIPFMLfS7J1lQ4U00qcRG3lhsXto7F2nkTfnPKPUm6uSFIS0WLcVYPAuqjOgSzfy2SivP2NJHkst9+BEfAZdNrArVWlRxWgWRPBqcqLnDHU4Cl92C0qUbua9/P3CfGDhbpAq51dENj1lcwfoDpwioEgcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(9686003)(38100700002)(122000001)(83380400001)(38070700005)(8936002)(52536014)(66446008)(64756008)(5660300002)(8676002)(4326008)(41300700001)(66946007)(76116006)(2906002)(66556008)(66476007)(7696005)(71200400001)(85182001)(55016003)(478600001)(6506007)(107886003)(186003)(26005)(316002)(86362001)(110136005)(33656002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGJDdzc1dkRDYTFFemNtWE05U0V6eUk1dVUxRGNZZkcxQTh0RlI0Wkt5ZFhq?=
 =?utf-8?B?OGIybVFkRUNKSElraU1GZ0h4Ly9yS1NUc3QyS3phTkhlQlBkR0hDM09sd1JU?=
 =?utf-8?B?dFhoMGhxcE10OWZpVnhUTXkvV3BiWVVvTkF5V1hxRTVsWUhzWDZSVmxvRllJ?=
 =?utf-8?B?TnJ5eVhQc1NpMUIvSE9ZVml6eFJFNndrQkNmUXR0Wk1IT1g0SjFmeXFVVG5C?=
 =?utf-8?B?MFN4WCtBcjNJTTdkRGVqaDN2cVdYOU5wcXJiekZJVUg5RjdPaWN2dmllQy9D?=
 =?utf-8?B?NktMWGVta2hXSU9tUzVEQkt5S1FyZ1ZhRUFpV0k4ZldPejVBYmdTYUtsVXdY?=
 =?utf-8?B?NnVrL0NSYk85SEpUWHVVOXlnclBlOXdDK0lFRmxnSG5MT3puV3orNzRCTTRY?=
 =?utf-8?B?Q2tZUlJnMXVzQlMwTTFTbEV3MjlITTBqbjlzTFo2N21NQk5KSzNFNlhRM1h4?=
 =?utf-8?B?U3lOYXRuWVFobnFjZE11K2N6Y1RnemdtMTVEb0JTQjRJYVlCMEF6RWtkVUFN?=
 =?utf-8?B?TStoNUVVZzAvR2FCMXZzQmx6TTFPcnN3TjlPdTdmcm15OXZiZENld1d0LzND?=
 =?utf-8?B?eDZlNUd6MmlHSkk1a1p2UXMreXNmdWxRQy9uTnpiMXRqb1BKZkJvWTY4YzhZ?=
 =?utf-8?B?M1VGUzUxNWwrYVJrK0hoM20zQ1BXMzkrSFFJMDhva0dZcGJELy9YNUlDTkVj?=
 =?utf-8?B?Z0hWcmNHRHV5aHlTYUJ4OEZHVG81ZjVYRDZweVNGZUxGcGlvUmlaenJ0Q055?=
 =?utf-8?B?TEVINmpaVWtFYXhlUTcyMnpweHZRUWRsR29NankyWmJTVDVqSzFKd3c5SFhQ?=
 =?utf-8?B?bW9iR05tdU9MeEZZVVg4NVljNEpWUm81a1NxL1paV2tHc0R6MGV5OGh2ZVEv?=
 =?utf-8?B?YlpJQldFRFFXVjEvSzdYekFWU2RRM05ZRzhWZjd3RmtUNWcwclhUbzk1UTBF?=
 =?utf-8?B?RDJvUk9FQkZteExJZ1dpRGJFai9RN2I1SXgzL3VKeVhmSE4wUm1QcFpFNC9s?=
 =?utf-8?B?aVNwZGdLL3lBYksxNk1QR1lyQXFvVjFDL0JXaVRkVDVlMU9QT3ZpakpTeURk?=
 =?utf-8?B?VXJURTRpVnpsYlZGTmpWZUlIT3RDNDh5YjRjejlYWVZmVGxYRUxFY2k2K1Bw?=
 =?utf-8?B?Ky82SVlRRGxxMVlJVEY1eU5OSmF4WDZhdHU5K29XRFFYRUJQcnVWaUtjcTJi?=
 =?utf-8?B?NTVXVUt6dmRPMVJYSHJWenpWWnErZGlTRzJGLzVmMFFFYjBXQm5ZcUxJbFdr?=
 =?utf-8?B?WGVCblNucFgvYVV1TWVZSmpxQWZkVEVmVGY5RHppREtJelQzdEs0RkZDcWRJ?=
 =?utf-8?B?WDVicDVXL0t2VEpWZ0hJZjcrUnNUa3JwdmJlR2phOVdySEVDOUJIaWl4UDlS?=
 =?utf-8?B?TnpYeGxScisveGhnL093OFNKQVExb1dYVlJNbXpORko3UE12NzVmaFV0VzlO?=
 =?utf-8?B?eUtkclJQRkNpSElNVmtTZDBHazFpL0d4MmlEaHJxaVNsU1Vsay9YSEN1LzFh?=
 =?utf-8?B?ZGV3L01WbjlETkFzeWpJUE1CRm5hZlJtd2dvMzJ3NFlEQ3k0aHFMbHpkakFv?=
 =?utf-8?B?L1h4MmRtek84ZXg4YWJnOHZQOXhRdXpiVVRLRWM2SmMxb2RPQkRNVitEK3Fi?=
 =?utf-8?B?SDQ3TndPd2ViMlIrTGZJSGxabitrQWd3dGk4Q0NFL1pOeUJZT3FtOEJESktO?=
 =?utf-8?B?N1RrYk12amNnWUNXazl6dk1KK0M5RWxPajBzT1Jjb2c4djNMcUpoQ2duZ2Rz?=
 =?utf-8?B?WUI5enNSNVdoTWlyUjFDSXhiRnpZdDlqbkxRM1dqdHBiK2JKUkRHKzBEZlV4?=
 =?utf-8?B?OHFNeUVUNVkyVXdKL3ZNN1cxK3pRdCtqYjVqdzMwVVhCVHQ4bXJCVDlSeDNM?=
 =?utf-8?B?cFBaZjk4MXc1MTI1YVE5VTVzd0xpdlVYR3NqMzFNWGplYXNGS2F0WlZNTFhl?=
 =?utf-8?B?KzQ4T3VtZnNobHZqbDdlUUxkelFaRFRENDFpSmsxeUNXWXB3Q3J3M0VQY3Ir?=
 =?utf-8?B?NVlPV08yenc5blkwL0dPSEF3UzI1ZndCS1I5UC9iVWVSK1J2QUFuSzN6alg2?=
 =?utf-8?B?eHRkSUFsRUxhSlJxc2gxOUVlMUI4WDlERmdRWDVZZGp6QVZ4NFdEcDB1NlhL?=
 =?utf-8?B?d0ZlZW5tSUxDbVFCUjlBdW1aUjU1WS95aGp3Tnh2Q2VBd1RSUTNGYjNaU1hx?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d44020-0e03-44bd-370b-08db14c37d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 10:56:45.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoKyFThE739BGE4rrTUw4rEW6KNM6LEpNw4VPSSizmhUiCBuzMVXmWwcIoUXht0VpGyqgFiOOjsf8eUBGjD2zIx8AIT5qYLIW3e8nD19Sog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11494
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 10:56:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10777

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmDQo+
T2YgRmVsaXggTW9lc3NiYXVlcg0KPlNlbnQ6IDIyIEZlYnJ1YXJ5IDIwMjMgMTQ6NDgNCj5Ubzog
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IEtpc3prYSwgSmFuIDxqYW4ua2lzemthQHNp
ZW1lbnMuY29tPg0KPkNjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0
aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+dHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJv
KOaelyDlkozlro8g4pah77yz77y377yj4pev77yh77yj77y0KQ0KPjxrYXp1aGlybzMuaGF5YXNo
aUB0b3NoaWJhLmNvLmpwPjsgcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlFQyBPREcNCj5Q
b3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+U3ViamVjdDogUmU6IFtj
aXAtZGV2XSBbaXNhci1jaXAtY29yZSAxLzJdIGthcy9vcHQvcmVwcm9kdWNpYmxlLnltbDogQWRk
IGthcyBmaWxlDQo+Zm9yIHJlcHJvZHVjaWJsZSBidWlsZHMgdGFyZ2V0DQo+DQo+T24gV2VkLCAy
MDIzLTAyLTIyIGF0IDE0OjQxICswNTMwLCBWZW5rYXRhIFB5bGEgdmlhIGxpc3RzLmNpcC0gcHJv
amVjdC5vcmcNCj53cm90ZToNCj4+IEZyb206IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRv
c2hpYmEtdHNpcC5jb20+DQo+Pg0KPj4gVGhpcyBrYXMgZmlsZSBzZXQgdGhlICdTT1VSQ0VfREFU
RV9FUE9DSCcgdmFyaWFibGUgdG8gbGFzdCBjb21taXQNCj4+IHRpbWVzdGFtcCByZXF1aXJlZCBm
b3IgYnVpbGRpbmcgcmVwcm9kdWNpYmxlIGltYWdlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IHZl
bmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+IMKg
a2FzL29wdC9yZXByb2R1Y2libGUueW1sIHwgMTcgKysrKysrKysrKysrKysrKysNCj4+IMKgMSBm
aWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGth
cy9vcHQvcmVwcm9kdWNpYmxlLnltbA0KPj4NCj4+IGRpZmYgLS1naXQgYS9rYXMvb3B0L3JlcHJv
ZHVjaWJsZS55bWwgYi9rYXMvb3B0L3JlcHJvZHVjaWJsZS55bWwgbmV3DQo+PiBmaWxlIG1vZGUg
MTAwNjQ0IGluZGV4IDAwMDAwMDAuLjE3M2MwMTgNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBi
L2thcy9vcHQvcmVwcm9kdWNpYmxlLnltbA0KPj4gQEAgLTAsMCArMSwxNyBAQA0KPj4gKyMNCj4+
ICsjIENJUCBDb3JlLCBnZW5lcmljIHByb2ZpbGUNCj4+ICsjDQo+PiArIyBDb3B5cmlnaHQgKGMp
IFRvc2hpYmEgQ29ycG9yYXRpb24sIDIwMjMgIyAjIEF1dGhvcnM6DQo+PiArI8KgIFZlbmthdGEg
UHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+ICMgIw0KPj4gK1NQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBNSVQgIw0KPj4gK2hlYWRlcjoNCj4+ICvCoCB2ZXJzaW9uOiAxMg0KPj4g
Kw0KPj4gK2xvY2FsX2NvbmZfaGVhZGVyOg0KPj4gK8KgIHJlcHJvZHVjaWJsZS1idWlsZHM6IHwN
Cj4+ICvCoMKgwqAgU09VUkNFX0RBVEVfRVBPQ0ggPSAiJHtAYmIucHJvY2Vzcy5ydW4oImdpdCAt
Qw0KPiAgICAgICAgICAgICAgICAgICAgICAgIF5eXg0KPlBsZWFzZSB1c2UgaW1tZWRpYXRlIGFz
c2lnbm1lbnQgaGVyZTogIjo9Ii4gQnkgdGhhdCwgd2UgY2FuIGVuc3VyZSB0aGF0IHRoaXMgaXMN
Cj5pbW1lZGlhdGVseSBleGVjdXRlZCB3aGVuIGJpdGJha2UgcmVhZHMgdGhpcyBmaWxlcywgbm90
IG9uY2UgdGhlIHZhcmlhYmxlDQo+bmVlZHMgdG8gYmUgZXhwYW5kZWQuDQoNCmhhYSBjb3JyZWN0
LCB0aGFua3MgZm9yIHBvaW50aW5nIG91dCBpdCBzaG91bGQgYmUgaW1tZWRpYXRlIGFzc2lnbm1l
bnQsIEkgd2lsbCBjb3JyZWN0IGl0Lg0KDQo+DQo+QmVzdCByZWdhcmRzLA0KPkZlbGl4DQo+DQo+
PiAke0xBWUVSRElSX2NpcC1jb3JlfSBsb2cgLTEgLS1wcmV0dHk9JWN0IHwgdHIgLWQgJ1xuJyIp
WzBdfSINCj4+ICsNCj4+DQo+Pg0KPj4NCg0K


