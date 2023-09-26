Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8328AE7E629
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 11:51:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.17100.1695729104693231579
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Sep 2023 04:51:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38QBpgtZ1486093; Tue, 26 Sep 2023 20:51:43 +0900
X-Iguazu-Qid: 2yAaansOwvtwvR5IHp
X-Iguazu-QSIG: v=2; s=0; t=1695729102; q=2yAaansOwvtwvR5IHp; m=nIlbUja11IKqKlTsdftFupiZcbml2Q+j/Pey+KAKDzo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 38QBpfGA1839037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Sep 2023 20:51:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW+ToY+pIYQceEE5kYwOb3hduYI+jRJ4J1e65wBvtgWD0Ozhap44XmNr76Dk96rXLb9eD+Uq6ItGjJj1kJS6EYZEkJlZkd+6zFNPHjLbC3oHwf7sAu7e56mBQucw1Qn9YAAJQgK40ToASyR3knqdWAfN7tsS2O2j1+lN1fNX8xAI7XSahti3LphrtlL116bGq5dq36mMia0HTiQu+O0JJA/OWARGa7orhxCKXFrZiAMKVpfKUTIM3Lsgkfi62jM958Nb2m9Cddgbm5UcBX8DOagQq8Tp4uvmEcdO/hk05JUlshWBjE4ro8zUHgTJX+yMBdDReqgDmGu43EOMwK8uHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9+AlJB1QKCwy9Bgba56OlZlhZuYQujjixX5C5TEXFs=;
 b=RkOEjbP9Ch1DbilK0JMLkyHBmjA/jpkf6nkCnc/fX5AjPwzoMv4LnyxqI0Hsh243DHdIXPPmBY9fzQR/Mx5gR3QOBl2zuLbE4z9909tnI+8qq+3qWODbFFxzcZO8K2Cdpre5aL+sxqP/LejusajxrqZe1mQgJcyfVFUsVSsQ52RoqkivaticrwLm9yytVClcRNot19S0xqxCCkIiKWpHymxoVus77S9oYwsmRcHjV8kzovhokL6Pl16gSbqQkvnWZYgDsJ4onnvMH5t2YHOnPP79LWTTF9h2SmMicBibGl9048B+JiewobFyIriQwkPp0ECxGqNbEUeJO9ZZMVgIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools as
 DEPENDENCY to all images
Thread-Topic: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools as
 DEPENDENCY to all images
Thread-Index: 
 AQHZ79GGhLKVE9lXv0qVxVfC45Iv2bArx3YAgACLvPCAAF5dAIAAAhpggAAhzoCAACaZAA==
Date: Tue, 26 Sep 2023 11:51:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542E955DB8A07738DE87DD8A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
 <20230925165833.2696-3-venkata.pyla@toshiba-tsip.com>
 <ce684bce-a09d-4313-b231-132737797f21@siemens.com>
 <OSYPR01MB55424C7B8414E7DC51BA0B72A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <ccb993fd-4053-4d6c-96e2-1d182a9b765b@siemens.com>
 <OSYPR01MB5542F6668A8E93B4E2A1E290A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <e59db07f-58e9-40d9-bc8c-1d9d5c530749@siemens.com>
In-Reply-To: <e59db07f-58e9-40d9-bc8c-1d9d5c530749@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYWPR01MB11308:EE_
x-ms-office365-filtering-correlation-id: befb74f3-7c22-4099-93f2-08dbbe86f188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nFc1QTj+hS0la1/oy2z7qwGMevo9wZuz4MIUps5zSbg7bVlSCUG2MtWjhc/vZmVp7V5fk7MWxCAONkIGCclFEqj0Tchf+h2gODW1HALiNGx6gXl24Q8nyomcqgqeJlJcBozhVlyGxuihI+q5yFZcqSXrAQymkHLTKjHAH40g4IAFNDxhwoM98FOIr37evObBzgPZY7dsOJf+KCfTlqtizfkJt10FP+fV3HktiA/T5WTmcGx/aI2pjhwbjNSYqjZdL+iT1nPbauaFN9bFgem4ZimTOAjBmvvuiWXwOcE+VpPP5GW572FASIvrMsv9hGAKJMBXS9s6sb/wCWjL1P2XjtRUrX/63jDUmst/5iNgNXksLhDGAN2V0CaI7MtvGUeFchKXk4obzQ8DMuYBPtC4/z6Xz8yvzPhF/IejEtqjHF79MVJHaTvVw28OUbf+nkhbg+VfQjL8dwuoxEsNqYidUqk+C9OsTaKD7k0Gm2qUufdziDz8EOCj+CI0sU6tyiEupbhVRVfTiZcI6jujOBKui7KYBlchq4GMM4wG5cGD4Mglo5BRpc5K+6rkmH4vDKxi43uHknbYMECr7GoudgLMelvPHJ8FxdkgRA7GxAIs+iY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799009)(76116006)(55016003)(107886003)(26005)(4326008)(8936002)(8676002)(316002)(966005)(66556008)(52536014)(478600001)(41300700001)(110136005)(83380400001)(66946007)(66446008)(64756008)(54906003)(5660300002)(9686003)(53546011)(2906002)(66476007)(6506007)(71200400001)(7696005)(86362001)(85182001)(33656002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cDRXVWtEZmxlT1g0ejdjMm5xUU9FWFpmRXdicmFwdEdBV1YxQzU5Y0sxd1J2?=
 =?utf-8?B?aUhTQWFBejNEMU1BbUpobG9QZlZNN1ZwbEhwSFVpeE1nM2tHMFViRzVMcUVY?=
 =?utf-8?B?TjY3ZHpoV1FiQ1NkK21qaGZUQ2hEcE40VWxnd29nN1BLWHVibW83U1ZKb2Fy?=
 =?utf-8?B?OStBdGoyTHUwM0I2Ni9XUzc4eUpRaDMralA3dnp3NjVmZlNGbnhlVGJndFJS?=
 =?utf-8?B?VVhpelhiazlOcm1GZHRBeTA5MVhqbWtFZ0huUnVveUNrZFdMMytrSk9oRy9D?=
 =?utf-8?B?Y0ZPNWFOVXZYZFp2YlJiYlhnWkJES2YwZlZ6QXZqd0U0TjRKeHJwc014SitF?=
 =?utf-8?B?eTZaemZBWlZUb2RGWDdFVkI2S2ltT1ZBMDZsRlYxZkJjT0JHV3dIbmh2a3Jm?=
 =?utf-8?B?Vk5qNU9PTmlRQ0c3Y2dDQnZQMGo0Y3NGR0pQakU5VWFCU2MvaHBDSTNvR1dz?=
 =?utf-8?B?OUYyTFVXQkhsN21vZkhHU3hvM0FZUFRxQzJtUkFQc2xzYkppQ2hubFQ3dnlL?=
 =?utf-8?B?TXhDUm5lb01LK0ZjSjUzL3RjWm94dVlaU1QvaHkvM0JvWUcrWkhWOStoand0?=
 =?utf-8?B?TmVyTTZKSis5M04wUEgvUENBOXI3bW4vUE5PNzEyR3VoUzF6MWFxSWt3OVZn?=
 =?utf-8?B?VzU4RzlQamZldldjQm1hMGdueWkyTm9lSTRvSG9uell5Z08wSTNqVXZqNm9M?=
 =?utf-8?B?U25zaG5RRTVTVTJhRUJHNnhZTithNkJZZzc3eXJvTWRFbFEzRlRYUHllZnA0?=
 =?utf-8?B?Tk5pNDc2Ly9zak9CWjlhVEZYUXhZZXFOcmtYWnNqVVVYR0FWK3BiVUtCRThC?=
 =?utf-8?B?cTVFbzcvSjdmZUIvWGUvYlpLVlFHU1liTjRRUWNSa2J4am1pSnhxMHU4Q2tv?=
 =?utf-8?B?b1RIZitKeHpST3o2QU5rM1h3L0NiUkJMVlRVcUM0Q3JweW9UNTJLaTRxM2Fp?=
 =?utf-8?B?eklvMGdRQnhGMUJpKzc2WFBJdnZFTk0rZENWZmluNHplMk5uNkRLcHRJb3Fa?=
 =?utf-8?B?c3QrMWJFNjdKcG9zYys3M2dES3p2aXE5OGJ5UWlrZ1RjQUpjOWNpMHRrZllS?=
 =?utf-8?B?UVA2emVraXo2VS9jNm5TbmVEM2wzcGZwajZnSkNyNjVaMUdGdEFIdUV3MVdC?=
 =?utf-8?B?Ulk2TTdUcWlaV1ZRamYvUU5PUUN5R0tqbTFFck10Nkh6MzE2bllrVDNlOVVW?=
 =?utf-8?B?S2FkZzl3NDlicDNIa0ZFaEJKMmZ6TC96N2oyQ25uR0lCaXRRaENyQ0UzS0F1?=
 =?utf-8?B?aDZoTWpaNE40RmdGMkNFOXJ3STlBY3dHK2JRUDFxTHBJdTIwOExZaEdMSzQ0?=
 =?utf-8?B?TElLWE9XWjlDQ3o1SmxTRjVVT3NyT1BXU2RIT0VKM0NHQjhQQWFDQkFiN3A3?=
 =?utf-8?B?YUREWW9YS3FZVE15ZTJHTEl5VGMzbmdJazVUZFpNREhKSm43TFlVTzFvaDI5?=
 =?utf-8?B?ZjErZzdFYStJdFhESjB5amMxMEVvYldmaThxRkNPM3F6YklOL0hPVWI5aWRI?=
 =?utf-8?B?Tnd6Tkd6RklacUo0ZXFkNmhSSk9wU3gxSEpEMGFMc0NxcDRpZW0vWTJMemtq?=
 =?utf-8?B?UHcraytCa3hWSEZjNkZaV0VZMVdEdW1UUEsvajhERXAySytPMmlZT3dadzFD?=
 =?utf-8?B?NGY1d05mSHZxdmVuTXVKdlAxR3pmQ3dqYVJPY25UNjdLUGNqbVBYSTJiUVcv?=
 =?utf-8?B?dW1iL1BBR0xFcHgxRitPeHgrNEJMMHVPN0dJdWY0TVpyWmFpcXZuU3l6cytw?=
 =?utf-8?B?elI4eGJGZ1BqUzQvakxoZU5seXdUS3lVK3V0RDF4bXdtNS8ydkREZnA5YWJX?=
 =?utf-8?B?SExFUmpBYTF1WEQvMzNTZkFyRDNhaXBZZFdzMXd3eGEyQ1d5cWlpNEduU0hZ?=
 =?utf-8?B?aDlTSDV1ZUdNdDlVQmdTNDdHdGRSWm9ldjRHQ0JaY3JqOUtoeVNoWVV4N1Jr?=
 =?utf-8?B?aFZUVkNlekFFYzJOSisrVEQxc3JiS0NBa1pJeEZmRUx0V0xPdDRZQmE5a0lz?=
 =?utf-8?B?OWpKbndzZTZxSGdmazdSMWhHK0RuSnAzTjk3QzJjWndQUUZlZFM0WFhaektt?=
 =?utf-8?B?QXU3cHM3anJLcThvSTRnRmhsNWdQYVA1YWNSaW0waC9mWERVMlFFZ1lOZFAx?=
 =?utf-8?B?cUFkQUdnZzZqWHMzT3c3RzBlZVlEc2pOaDhOcS95R3J4ZStWRkdyOEw3ejBn?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befb74f3-7c22-4099-93f2-08dbbe86f188
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 11:51:39.0083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GsGgaSbDN2BO/E/AAIkVoWfIfCdwDmME0z0jDg2a3b7Byp7HVP87BtFoEkDzI8uD1zRdUH7s07G1bUu2Mg6bOHZ1bdi0gYfmpUPRPYyEX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11308
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Sep 2023 11:51:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13227

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI2LCAyMDIz
IDI6NDkgUE0NCj4gVG86IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRp
bmcpIDxWZW5rYXRhLlB5bGFAdG9zaGliYS0NCj4gdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZw0KPiBDYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlFQyBPREcg
UG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLQ0KPiB0c2lwLmNvbT47IGhheWFzaGkga2F6
dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw77yz4peL77yt
77yw77yUKQ0KPiA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NCj4gU3ViamVjdDog
UmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZSB2MiAyLzJdIGltYWdlczogQWRkIGRvc2ZzdG9v
bHMgYXMNCj4gREVQRU5ERU5DWSB0byBhbGwgaW1hZ2VzDQo+IA0KPiBPbiAyNi4wOS4yMyAwOTo0
MSwgVmVua2F0YS5QeWxhQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lz
emthQHNpZW1lbnMuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjMg
MTI6NDEgUE0NCj4gPj4gVG86IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBv
cnRpbmcpIDxWZW5rYXRhLlB5bGFAdG9zaGliYS0NCj4gPj4gdHNpcC5jb20+OyBjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+PiBDYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBU
TUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLQ0KPiA+PiB0c2lwLmNvbT47
IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt
77yw77yz4peL77yt77yw77yUKQ0KPiA+PiA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5q
cD4NCj4gPj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZSB2MiAyLzJdIGlt
YWdlczogQWRkIGRvc2ZzdG9vbHMNCj4gPj4gYXMgREVQRU5ERU5DWSB0byBhbGwgaW1hZ2VzDQo+
ID4+DQo+ID4+IE9uIDI2LjA5LjIzIDAzOjM5LCBWZW5rYXRhLlB5bGFAdG9zaGliYS10c2lwLmNv
bSB3cm90ZToNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4+Pj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnPg0KPiA+Pj4+IE9uIEJlaGFsZiBPZiBKYW4gS2lzemthIHZpYSBs
aXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPj4+PiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAyNSwg
MjAyMyAxMDo0MyBQTQ0KPiA+Pj4+IFRvOiBweWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVD
IE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtDQo+ID4+Pj4gdHNpcC5jb20+OyBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+Pj4+IENjOiBkaW5lc2gga3VtYXIo77y0
77yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKQ0KPiA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+
ID4+Pj4gdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKX
i++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8lCkNCj4gPj4+PiA8a2F6dWhpcm8zLmhh
eWFzaGlAdG9zaGliYS5jby5qcD4NCj4gPj4+PiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2Fy
LWNpcC1jb3JlIHYyIDIvMl0gaW1hZ2VzOiBBZGQNCj4gPj4+PiBkb3Nmc3Rvb2xzIGFzIERFUEVO
REVOQ1kgdG8gYWxsIGltYWdlcw0KPiA+Pj4+DQo+ID4+Pj4gT24gMjUuMDkuMjMgMTg6NTgsIHZl
bmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPiA+Pj4+PiBGcm9tOiB2ZW5rYXRh
IHB5bGEgPHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPiA+Pj4+Pg0KPiA+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiB2ZW5rYXRhIHB5bGEgPHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29t
Pg0KPiA+Pj4+PiAtLS0NCj4gPj4+Pj4gIHJlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1h
Z2Uta2VybmVsY2kuYmIgfCAgMSArDQo+ID4+Pj4+IHJlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNv
cmUtaW1hZ2Utc2VjdXJpdHkuYmIgfCAgMSArDQo+ID4+Pj4+ICByZWNpcGVzLWNvcmUvaW1hZ2Vz
L2NpcC1jb3JlLWltYWdlLmJiICAgICAgICAgIHwgIDEgKw0KPiA+Pj4+PiAgcmVjaXBlcy1jb3Jl
L2ltYWdlcy9jb21tb24taW1hZ2UuaW5jICAgICAgICAgICB8IDEzICsrKysrKysrKysrKysNCj4g
Pj4+Pj4gIDQgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSAgY3JlYXRlIG1vZGUgMTAw
NjQ0DQo+ID4+Pj4+IHJlY2lwZXMtY29yZS9pbWFnZXMvY29tbW9uLWltYWdlLmluYw0KPiA+Pj4+
Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFn
ZS1rZXJuZWxjaS5iYg0KPiA+Pj4+PiBiL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1h
Z2Uta2VybmVsY2kuYmINCj4gPj4+Pj4gaW5kZXggNDc5YzE0Yy4uOGE1OGU3YiAxMDA2NDQNCj4g
Pj4+Pj4gLS0tIGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1rZXJuZWxjaS5i
Yg0KPiA+Pj4+PiArKysgYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLWtlcm5l
bGNpLmJiDQo+ID4+Pj4+IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4+Pj4+ICAjDQo+ID4+Pj4+DQo+
ID4+Pj4+ICBpbmhlcml0IGltYWdlDQo+ID4+Pj4+ICtyZXF1aXJlIGNvbW1vbi1pbWFnZS5pbmMN
Cj4gPj4+Pj4NCj4gPj4+Pj4gIERFU0NSSVBUSU9OID0gIkNJUCBDb3JlIGltYWdlIGZvciBLZXJu
ZWxDSSINCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9pbWFnZXMv
Y2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmINCj4gPj4+Pj4gYi9yZWNpcGVzLWNvcmUvaW1hZ2Vz
L2NpcC1jb3JlLWltYWdlLXNlY3VyaXR5LmJiDQo+ID4+Pj4+IGluZGV4IDM0MjFjZTUuLmYxMTQ5
NzQgMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1h
Z2Utc2VjdXJpdHkuYmINCj4gPj4+Pj4gKysrIGIvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29y
ZS1pbWFnZS1zZWN1cml0eS5iYg0KPiA+Pj4+PiBAQCAtMTAsNiArMTAsNyBAQA0KPiA+Pj4+PiAg
Iw0KPiA+Pj4+Pg0KPiA+Pj4+PiAgaW5oZXJpdCBpbWFnZQ0KPiA+Pj4+PiArcmVxdWlyZSBjb21t
b24taW1hZ2UuaW5jDQo+ID4+Pj4+DQo+ID4+Pj4+ICBERVNDUklQVElPTiA9ICJDSVAgQ29yZSBp
bWFnZSBpbmNsdWRpbmcgc2VjdXJpdHkgcGFja2FnZXMiDQo+ID4+Pj4+DQo+ID4+Pj4+IGRpZmYg
LS1naXQgYS9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLmJiDQo+ID4+Pj4+IGIv
cmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS5iYg0KPiA+Pj4+PiBpbmRleCAwZWM3
MjIwLi43MTFkM2QzIDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9yZWNpcGVzLWNvcmUvaW1hZ2VzL2Np
cC1jb3JlLWltYWdlLmJiDQo+ID4+Pj4+ICsrKyBiL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNv
cmUtaW1hZ2UuYmINCj4gPj4+Pj4gQEAgLTEwLDYgKzEwLDcgQEANCj4gPj4+Pj4gICMNCj4gPj4+
Pj4NCj4gPj4+Pj4gIGluaGVyaXQgaW1hZ2UNCj4gPj4+Pj4gK3JlcXVpcmUgY29tbW9uLWltYWdl
LmluYw0KPiA+Pj4+Pg0KPiA+Pj4+PiAgSVNBUl9SRUxFQVNFX0NNRCA9ICJnaXQgLUMgJHtMQVlF
UkRJUl9jaXAtY29yZX0gZGVzY3JpYmUgLS10YWdzDQo+ID4+Pj4+IC0tZGlydHkgLS0NCj4gPj4+
PiBhbHdheXMgLS1tYXRjaCAndlswLTldLlswLTldKiciDQo+ID4+Pj4+ICBERVNDUklQVElPTiA9
ICJDSVAgQ29yZSBpbWFnZSINCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9pbWFn
ZXMvY29tbW9uLWltYWdlLmluYw0KPiA+Pj4+PiBiL3JlY2lwZXMtY29yZS9pbWFnZXMvY29tbW9u
LWltYWdlLmluYw0KPiA+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+Pj4+PiBpbmRleCAw
MDAwMDAwLi44NjNmODE3DQo+ID4+Pj4+IC0tLSAvZGV2L251bGwNCj4gPj4+Pj4gKysrIGIvcmVj
aXBlcy1jb3JlL2ltYWdlcy9jb21tb24taW1hZ2UuaW5jDQo+ID4+Pj4+IEBAIC0wLDAgKzEsMTMg
QEANCj4gPj4+Pj4gKyMNCj4gPj4+Pj4gKyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiA+
Pj4+PiArIw0KPiA+Pj4+PiArIyBDb3B5cmlnaHQgKGMpIFRvc2hpYmEgQ29ycG9yYXRpb24gMjAy
MyAjICMgQXV0aG9yczoNCj4gPj4+Pj4gKyMgIFZlbmthdGEgUHlsYSA8dmVua2F0YS5weWxhQHRv
c2hpYmEtdHNpcC5jb20+ICMgIw0KPiA+Pj4+PiArU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1J
VCAjDQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKyMgSW5zdGFsbCBpbiBidWlsZCBzeXN0ZW0gZm9yIGNy
ZWF0aW5nIHJlcHJvZHVjaWJsZSBET1MNCj4gPj4+Pj4gK2ZpbGVzeXN0ZW1zIERFUEVORFMgKz0g
ImRvc2ZzdG9vbHMiDQo+ID4+Pj4NCj4gPj4+PiBXaHkgdGhpcyBub3c/IFBhdGNoIDEgaXMgYWRk
aW5nIGl0IGFzIElNQUdFU19CVUlMRF9ERVBTLCBhbmQgdGhhdA0KPiA+Pj4+IHNob3VsZCBiZSBl
bm91Z2ggYXMgeW91IGNvcnJlY3RseSBhbmFseXplZC4gRG8gd2Ugd2FudCB0aGF0IGNoYW5nZQ0K
PiA+Pj4+IHJhdGhlciBpbiBjb25mL2Rpc3Ryby9jaXAtY29yZS1jb21tb24uaW5jPw0KPiA+Pj4N
Cj4gPj4+IEl0IGlzIG5vdCByZXF1aXJlZDsgSSB3YXMgY29uZnVzZWQgdGhlbiB3aXRoIHlvdXIg
Y29tbWVudCBJIHRob3VnaHQNCj4gPj4+IHlvdSBhcmUNCj4gPj4gZXhwZWN0aW5nIHRoaXMgY2hh
bmdlIGZvciBzb21lIHJlYXNvbi4NCj4gPj4+DQo+ID4+PiBJZiB5b3UgYWdyZWUgeW91IGNhbiBk
aXNjYXJkIHRoZSBQYXRjaCAyLg0KPiA+Pg0KPiA+PiBPSywgYnV0IHRoZSBxdWVzdGlvbiByZW1h
aW5zIG9uIHBhdGNoIDEgaWYgd2Ugb25seSB3YW50IHRvIGluY2x1ZGUNCj4gPj4gdGhlIHRvb2wg
aW4gdGhlIHJlcHJvZHVjaWJsZSBtb2RlIG9yIHVuY29uZGl0aW9uYWxseS4gSW4gdGhlIGxhdHRl
cg0KPiA+PiBjYXNlLCBteSBzdWdnZXN0aW9uIGFib3ZlIHdvdWxkIGNvbWUgaW50byBwbGF5Lg0K
PiA+DQo+ID4gSSBkaWRu4oCZdCB1bmRlcnN0YW5kIHlvdXIgcXVlc3Rpb24gcHJvcGVybHkgdGhl
biwgSSBhbSBwYXN0aW5nIHlvdXIgY29tbWVudA0KPiBhZ2FpbiBhcyBiZWxvdy4NCj4gDQo+IFlv
dXIgcGF0Y2ggb25lIGN1cnJlbnRseSBvbmx5IGFkZHMgdGhlIHNlbGYtYnVpbHQgZG9zZnN0b29s
cyB3aGVuIHRoZSB1c2VyDQo+IGV4cGxpY2l0bHkgc2VsZWN0cyByZXByb2R1Y2libGUgYnVpbGRp
bmcuIEluIG90aGVyIGNhc2VzIC0gc2ltcGxlciBvbmVzLCBncmFudGVkIC0NCj4gd2UgYXBwbHkg
cmVwcm9kdWNpYmlsaXR5IGZpeGVzIHVuY29uZGl0aW9uYWxseS4gU2hvdWxkIHdlIGRvIHRoYXQg
Zm9yDQo+IGRvc2ZzdG9vbHMgYXMgd2VsbD8gVGhhdCBpcyBteSBvbmx5IHF1ZXN0aW9uLg0KDQpJ
IHVuZGVyc3RhbmQgbm93LCB3ZSBjYW4gZW5hYmxlIGRvc2ZzdG9vbHMgdW5jb25kaXRpb25hbGx5
IGFsc28sIG1heWJlIHdlIGNhbiBkbyB0aGF0IGluIGRpc3RybyBjb25maWd1cmF0aW9uLCANCmhl
cmUgaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUv
LS9ibG9iL21hc3Rlci9jb25mL2Rpc3Ryby9jaXAtY29yZS1jb21tb24uaW5jPw0KDQpJIHdpbGwg
c2VuZCB2MyBwYXRjaCB3aXRoIHRoaXMgbW9kaWZpY2F0aW9uLg0KDQoNCj4gDQo+IEphbg0KPiAN
Cj4gLS0NCj4gU2llbWVucyBBRywgVGVjaG5vbG9neQ0KPiBMaW51eCBFeHBlcnQgQ2VudGVyDQo=


