Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD73CD68EC
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 04:59:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.84177.1696913958016182660
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 21:59:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 39A4xFtD2185644; Tue, 10 Oct 2023 13:59:15 +0900
X-Iguazu-Qid: 2yAbXiQ0tK3823Y8pn
X-Iguazu-QSIG: v=2; s=0; t=1696913955; q=2yAbXiQ0tK3823Y8pn; m=gWgkqqhpILQRaus7Npd8V+Iqv4CniVe7cgTY9sspY2Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 39A4xDkZ1500621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Oct 2023 13:59:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bImdxJdnCkSJSqgmZmxGNZOW1LfIof/dXTylA2Tq3nhp+hYhRHFUTCvqJWG5LXPrvt7TqIk1jMfNKGl8r/b17kc5OwJYreUJFR8HS15nNcxTYeIqoXz/064KQPtuusovUaPD52oMHzPLbV13MJNLxRXl5anDbL0nKtgiMx4HTIn+q0XQL2GRrJ9gax225pDW67LOiojzy9n5kA3sFosjjdlWj3eDbzxS+H6/k1oSO8lsMkB37P/wEEzZwFQGewwYs1R5hguLquZHo59X43XmBV0Ns8tMiqFc4ujmA1zWyrx4SiwQUv4hiC0SOfYmALvNV72gDn9Xz+78RCD4mMxo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYGodM5zHZDxbKYwV3HZ1NWT1TbV2dCg5B6bV3v2HQo=;
 b=RQlaiggNthqh24QAJiOMDih54n+tFwiRV2B2lV1rz1BdRDxyTPbGY1Bqw/zAQDe1LSzAR5JtWXgFs+jZbku5bdSSvTT3M0vhaTLiSfdRDk9QfOQ2Z3IIua6CchGtpLw+kd3SUv90GTizoE40+8JtRpE+dvG7jjuaLO5QPNBWlWFPJHWu5ooXQi+75TM0SsHYkpFhLilIh2CT6wQ3IUo0u1ae+hhcZb5BdHsoUbgeYnUQcS01NZWvKzMfkABZjRYJnoRfouT6IQsx2s83csYpQuK2+pZwGQpX4TcGBB1XDJOY9SwHXzbCEox9iy5KNSKbYkPPU/h8/Qo+EYctuoWZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <quirin.gylstorff@siemens.com>, <christian.storm@siemens.com>
Subject: RE: [cip-dev] [isar-cip-core 2/2] reproducible.yml: Disable signed
 swupdate in reproducible tests
Thread-Topic: [cip-dev] [isar-cip-core 2/2] reproducible.yml: Disable signed
 swupdate in reproducible tests
Thread-Index: AQHZ+FTYiiZdDXhZKUqacI+rzfyK9LA8uqqAgAFkiGCABFwT8A==
Date: Tue, 10 Oct 2023 04:59:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB685635BA1CFBAC30375EAE11A4CDA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
References: <20231006125845.2661-1-venkata.pyla@toshiba-tsip.com>
 <20231006125845.2661-3-venkata.pyla@toshiba-tsip.com>
 <c6612b4c-b17d-484f-8cab-1f204567a456@siemens.com>
 <178BDEF1D76FA0E8.24994@lists.cip-project.org>
In-Reply-To: <178BDEF1D76FA0E8.24994@lists.cip-project.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6856:EE_|OS3PR01MB8286:EE_
x-ms-office365-filtering-correlation-id: c5f294ed-c378-45bd-810c-08dbc94da38c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jTpi0Kh4wN/3ZThLvfvZSLr22M5hkcrrqcI3p64tH/0gQXiEna+JmgQN5MXKn1a9jyK3uD8uGeUlxSIz36AUQ/zd/Pw8DhhZY1MWOjI4FQR7bQOSMleul0zbMrn9Z0yTu/CS5AoekHPHeSUVL1eLpRr0u5UrrbzfeOOBZRgjZVl7kQSW5pWmKc58JRwmBlmWzkxM9k2y5ADa/PtqAT2PSsLhxUO1g/Xy4qVSaghH5e0U9UHZDFISiPiUvlk1JELFtbmHVAWYxJvtZp4DdEx0SxVDMt2gtTHzsczEJssqja+6UYKbMc+rgR5iTqsDDq5Y43Ps5rwLFcATMIzORrNuE82BQMirNYLx9OoI9gNsg6dFEv4oRkC50aiU/OP1jjyuSFLAPilxu4FbArkTy5gqlfjDXvkI/zFVVzd6KeReIYrSyfEpqZ2mxaGbagXPFlQPFz99RGaAqGPgWF9tWC6fCly/AWArR7lz0C5JqMEPH+Z3T0lJEosdhnNqqV96nE2ckoPtFcy3J3b8GnPmQ8ctMaes4QGfYPuY7LcAH0QVOoNgA2jim+TP3VUP6y29HiYqnVbEJsdaGUnxUsyBYq/tA9acHop0LakmjqnhxCBjDAaTN9Qf1tOURxQJNl0bwkkw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6856.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(33656002)(7696005)(9686003)(53546011)(478600001)(6506007)(71200400001)(83380400001)(2906002)(64756008)(66446008)(66476007)(66556008)(110136005)(76116006)(66946007)(54906003)(5660300002)(8676002)(8936002)(4326008)(52536014)(41300700001)(316002)(26005)(122000001)(85182001)(38070700005)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bU9GSjBUZmJuU1NoeThsUFdteklTUlB3ak1wWmtHWTFCc09PNnhTVTI3NGE2?=
 =?utf-8?B?YzdDMHFUdTVkbWtOWXZLMlAxcDBqbjlrYTdTSFAzRWxFbU9vd04xYkZUQjBa?=
 =?utf-8?B?RmRvekZQTU1wbDVJQTVYK0hTc05RRkQ4VHI1c0Z4c3JWeUgvR1FNcEVoS2NE?=
 =?utf-8?B?VTkzTCtwWnlPYXJIVDIxZGx1d0RMVVp6RldxTEpWc2tVZUhmcGh6d200QTQv?=
 =?utf-8?B?ZWptejVNK3owQjd4UmYrdmwvWEQzUm85bWhYSGJ2WmpKRlNRVFpRcldLenlT?=
 =?utf-8?B?Z3NJODE1ZU5PWER1cHRtMEpiZlpmcVZJUWtQTFZyZzgvTVUwRWwyZHhocThS?=
 =?utf-8?B?MHhCcFRRaU9KMExEbnVpai9DMksxczh6UEF4UlBxSkh4M3hua3BzMUtQT3VY?=
 =?utf-8?B?b2xvVnhyQTgrcjV3V3NEdlFXcUJ5a2xzazVRM2UxSG43Y0N3WUV6bzNsemJH?=
 =?utf-8?B?N041V2xJVVlWZ2U4bTk5UnQvUDF3K0JpSG4wSm5qRXcxc3hSTktGWjExeFN1?=
 =?utf-8?B?QWJKQ1pRWEtLcitvb1FoM3dPa2JYS2ZDWm1wU1JsZm93WCtPTms3UUxGaWRy?=
 =?utf-8?B?Tnl5azNnMEZPUENMdWVPbEV1Q0xqbmYvdHpKcUhWYm1PbldOV3NzdjU2UU4w?=
 =?utf-8?B?ak9MaWlWTzU2Nm5sc1dzbGhkd1dnMVJ5SmIxbTZQcGI2ZEhmN1A4UlJOSVp1?=
 =?utf-8?B?MG40dDdWOWZ6OVpkWG1PNkJaZjFPRlVVQXN2VWFKNXNlNVlpaU83b3I5TU5n?=
 =?utf-8?B?SkFSUGtBbk96bll6c3JWemNQRTBkTzBvR3BMYWZrUVZBYTUwc2ZVTTYwdUtq?=
 =?utf-8?B?RkVkUU84UTlOUGJmK0gzYWJGVjV3Um1CS0M4YlNNOXN6T28zU1lMbVdkOTRv?=
 =?utf-8?B?OENibTZic2NHVUp5S21zTFlHaVRJTFlTbis4Yi96cGZnRDRyY1pKZEYrNEJk?=
 =?utf-8?B?M3BZcXRDU1dpQTBiR0llL2c4emw3MUJIQWl4b1JmTEl1d1RZZVpXZHR5OEFB?=
 =?utf-8?B?YU5ZcWtUTUZ4VW9iUEdLWFVRSEhpcDAxNHhGSjdvVzZOeW5BcVV0TjBCWU9y?=
 =?utf-8?B?RlpIaFlZZ2kvWWkxTGQwMGVNVkUrWnBZRFVYODBGWGthSUxSMUpsR0ZiVnJn?=
 =?utf-8?B?Smg1VisvOEVRUUNFU0xVZ3lHK1dPNGl5RXdSdFpYQ1QwV1EybndKUXlUOVFN?=
 =?utf-8?B?MU9YRnYrWENWNFVuNzBmdHRFZm41SFFjaW1aczE1cTUvWkg1Q1I5RWh1SzUx?=
 =?utf-8?B?SERCRmdGWm1RSkREU0EwRmIzaE0yd3pXdVFMQ3dMbWJkR3dpVmNjUmlOc1FC?=
 =?utf-8?B?VnVGTGM4RVMxSHRGOERXdlhhVTNrNlJqbE1yUHJnK0QxRzQ5ajJ5am1GNzBm?=
 =?utf-8?B?RjVFL25DMllOdERZRUtja0gvNkJ0a01YYVE0dXJUejlnbW1BOWtuNFFJRDdI?=
 =?utf-8?B?aWhlZjZRUHRaY2o0L3MyaExLZGdsZ3psTmoyNEhVTlUrUndTMis2ajlweXVJ?=
 =?utf-8?B?TUIyRmsrclVUNlpkejRqeDgxRTY2MzFZS3pHMFJlNGRjbnBUUlczWkRNOFhi?=
 =?utf-8?B?b2xVeWdwNU1nMjRmOHRGeXNVRGhLNkVtVmRwWE5RdlhMdFlQY0tzOVRLYnJq?=
 =?utf-8?B?OENyblZpaHpOeS9zTTVtRkU2WGRUNU5ZMUYvaG1lSzIwVFZ5RXJXRGlHTytk?=
 =?utf-8?B?QjN1U001SXF1Vm12SGZyNWhqK0FmYVFKUXBtZXVGMGtxM0kzUXA3SXJQa2hz?=
 =?utf-8?B?akgvRTdWVFRxK1ZXUW9BcW5kZCtORjdEUWwxaElXVlh2bXJBRDBqZmdsNWhF?=
 =?utf-8?B?TzdVK3dFdlpmc3B5S0RpNVlHMkQwdk5TMEVTNEhJeGcxUVI2TlBaZ0ZvekRF?=
 =?utf-8?B?bGtwZ2JMWDNENUpGN1R1djErSUplejh3VjNTL3F0djFSVWJ0dC8yR2tvRlY1?=
 =?utf-8?B?dlUyU2hrN1RvMXk4eTNrQy9tS3Rzay9EeU5NVC9IV29WenpyUWd5cXlwR0hX?=
 =?utf-8?B?MEpHSGYyUE16Nm9rY0JOaStZbHJIenNSYk00Y2RSWXZncUg2Mi9PSHYxdkZM?=
 =?utf-8?B?cnp5aTBGWitMR3FlVHpWV2J1NVY5TXJVdVB5enRraUkrUlV0MXplR3hqQ0p6?=
 =?utf-8?B?OEZudzB1VkoxYmxEMnRzQk9qVllxQ1FuSHFhTFpITEZuenc4QWZhUHR6bGNP?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6856.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f294ed-c378-45bd-810c-08dbc94da38c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 04:59:09.6174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xMxNVR8oYEhilvq28g1nkq/HRYSHg7S+Uo5ncPplZvR+Himdv46u6aAXBXhAMTSFP9gEF5I6zskSvgwjJ53cpdoWoB3pLSHkzqimD386Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8286
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 04:59:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13337

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYg
T2YNCj4gVmVua2F0YSBQeWxhDQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDcsIDIwMjMgOToz
NyBQTQ0KPiBUbzogamFuLmtpc3prYUBzaWVtZW5zLmNvbTsgY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcNCj4gQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRp
bmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS0NCj4gdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJv
KOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8
lCkNCj4gPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+OyBxdWlyaW4uZ3lsc3RvcmZm
QHNpZW1lbnMuY29tOw0KPiBjaHJpc3RpYW4uc3Rvcm1Ac2llbWVucy5jb20NCj4gU3ViamVjdDog
UmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZSAyLzJdIHJlcHJvZHVjaWJsZS55bWw6IERpc2Fi
bGUgc2lnbmVkDQo+IHN3dXBkYXRlIGluIHJlcHJvZHVjaWJsZSB0ZXN0cw0KPiANCj4gDQo+IA0K
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgNiwgMjAyMyA2
OjM1IFBNDQo+ID4gVG86IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRp
bmcpIDxWZW5rYXRhLlB5bGFAdG9zaGliYS0NCj4gPiB0c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnDQo+ID4gQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMg
T0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS0NCj4gPiB0c2lwLmNvbT47IGhheWFz
aGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw77yz
4peL77yt77yw77yUKQ0KPiA+IDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPjsgUXVp
cmluIEd5bHN0b3JmZg0KPiA+IDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPjsgQ2hyaXN0
aWFuIFN0b3JtDQo+ID4gPGNocmlzdGlhbi5zdG9ybUBzaWVtZW5zLmNvbT4NCj4gPiBTdWJqZWN0
OiBSZTogW2lzYXItY2lwLWNvcmUgMi8yXSByZXByb2R1Y2libGUueW1sOiBEaXNhYmxlIHNpZ25l
ZA0KPiA+IHN3dXBkYXRlIGluIHJlcHJvZHVjaWJsZSB0ZXN0cw0KPiA+DQo+ID4gT24gMDYuMTAu
MjMgMTQ6NTgsIHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPiA+ID4gRnJv
bTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4gPiA+DQo+
ID4gPiBzaWduZWQgYXJ0aWZhY3RzIGFyZSBub3QgcmVwcm9kdWNpYmxlIGR1ZSB0byBmYWN0IHRo
YXQgdGhlIHNpZ25hdHVyZQ0KPiA+ID4gY2FuIGluY2x1ZGUgc29tZSByYW5kb21uZXNzIGZvciBz
ZWN1cml0eSByZWFzb25zLCBzbyBza2lwIHNpZ25hdHVyZQ0KPiA+ID4gdmVyaWZpY2F0aW9ucyBp
biByZXByb2R1Y2libGUgdGVzdHMuDQo+ID4gPg0KPiA+ID4gRml4ZXMgIzgwDQo+ID4gPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lw
LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGthcy9vcHQvcmVwcm9kdWNpYmxlLnltbCB8IDEgKw0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4NCj4gPiA+IGRpZmYg
LS1naXQgYS9rYXMvb3B0L3JlcHJvZHVjaWJsZS55bWwgYi9rYXMvb3B0L3JlcHJvZHVjaWJsZS55
bWwNCj4gPiA+IGluZGV4DQo+ID4gPiA1ZDZhODk2Li43M2RkNGQ1IDEwMDY0NA0KPiA+ID4gLS0t
IGEva2FzL29wdC9yZXByb2R1Y2libGUueW1sDQo+ID4gPiArKysgYi9rYXMvb3B0L3JlcHJvZHVj
aWJsZS55bWwNCj4gPiA+IEBAIC0xNSwzICsxNSw0IEBAIGxvY2FsX2NvbmZfaGVhZGVyOg0KPiA+
ID4gICAgcmVwcm9kdWNpYmxlLWJ1aWxkczogfA0KPiA+ID4gICAgICBTT1VSQ0VfREFURV9FUE9D
SCA6PSAiJHtAYmIucHJvY2Vzcy5ydW4oImdpdCAtQw0KPiA+ID4gJHtMQVlFUkRJUl9jaXAtY29y
ZX0NCj4gPiBsb2cgLTEgLS1wcmV0dHk9JWN0IHwgdHIgLWQgJ1xuJyIpWzBdfSINCj4gPiA+ICAg
ICAgV0lDX0RFUExPWV9QQVJUSVRJT05TID0gIjEiDQo+ID4gPiArICAgIFNXVV9TSUdORUQgPSAi
MCINCj4gPg0KPiA+IFNob3VsZG4ndCB3ZSByYXRoZXIgb3IgYWxzbyBjaGVjayBpZiBldmVyeXRo
aW5nIGV4Y2VwdCBmb3IgdGhlIC5zaWcNCj4gPiBlbGVtZW50IGluIGEgc2lnbmVkIFNXVSBpcyBp
ZGVudGljYWw/DQo+IA0KPiBJZiB3ZSBoYXZlIHRvIHNraXAgdGhlICJzdy1kZXNjcmlwdGlvbi5z
aWciIGZpbGUgdGhlbiBpdCB3aWxsIGFsc28gc2tpcCBzdy1kZXNjcmlwdGlvbg0KPiBmaWxlIGZy
b20gcmVwcm9kdWNpYmxlIHZlcmlmaWNhdGlvbi4NCj4gDQo+IElmIEkgdW5kZXJzdGFuZCBjb3Jy
ZWN0bHksIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gc2lnbmVkIGFuZCB1bnNpZ25lZCBzd3VwZGF0
ZSBpcw0KPiB0aGUgc3ctZGlzY3JpcHRpb24gZmlsZSBhbmQgaXQgd2lsbCBiZSBzaWduZWQgaW4g
Y2FzZSBvZiBTV1VfU0lHTkVEPSIxIiwNCj4gb3RoZXJ3aXNlIGl0IGlzIHVuc2lnbmVkIGZpbGUu
DQo+IFNvLCBpZiB3ZSBkaXNhYmxlIFNXVV9TSUdORUQgdGhhdCB3aWxsIGRpc2NhcmQgdGhlIHNp
Z25hdHVyZS4NCj4gDQoNCihTb3JyeSB0byBqdW1wIGluKQ0KQW55IGNvbW1lbnRzIG9uIHRoaXMg
YXBwcm9hY2ggKGRpc2FibGluZyBzaWduZWQgc3d1cGRhdGUpPw0KDQo+ID4NCj4gPiBKYW4NCj4g
Pg0KPiA+IC0tDQo+ID4gU2llbWVucyBBRywgVGVjaG5vbG9neQ0KPiA+IExpbnV4IEV4cGVydCBD
ZW50ZXINCg==


