Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303FDC43334
	for <webhook@archiver.kernel.org>; Sun, 24 Jul 2022 17:48:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.18892.1658684874294565150
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Jul 2022 10:47:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 26OHlpRo020356;
 Mon, 25 Jul 2022 02:47:51 +0900
X-Iguazu-Qid: 34trLFpplJNU8YWnjs
X-Iguazu-QSIG: v=2; s=0; t=1658684870; q=34trLFpplJNU8YWnjs;
 m=+qF9BHWI0yDDD+I3NOp515G7pejjHmkrkbH/A5ZTtTo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 26OHlnKG037728
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 25 Jul 2022 02:47:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RakZ8RW43n3GrLwaM73O0yvGc8C19jBDEG2IBk4SV+8vRukw9OAQHKQwNx3n0o2yoNZrmPvu71tQ8c30lbZE090WUWIfOR5+anKuBsw8gPoj/mV9YsEdhtr5LWRyrmaoX/+FlVP38bJAgscEOMpDMCozM9yNu0mu/YKzc+TKb2tdwnKOKK3e1vB77WYXtsSL5p0Kdi7gdehBW4mTHV0FBYCkYw9H73ZquOVWU+eddxnlxc3PSK2N/uyBAjUG45CLFcz+uG99aMxWhZrYgGYuORj4rujGjyjb8XseJXar6rIXsiAyljjt22iuXXZplVbrzSRLoKiaRg1PS6A/jMoHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCje6F1qEJQqPaMaw1atXYOFiLP7tEZpUpFLO/qpo8Q=;
 b=F8xh56jY4cMRIGjg4olxFbAM9V+8X07Hvn/p5o9Ze2FlJue/NU8URuf2jdXHuD0dmNHsAhJN6ar3dkoD2MXNLtCUWh5IW0nAng7NoZ9768WWqwWXDcUaiC19qVtMHGQT5Kzb9+mrIqtmnYC2xy699qoDdo2kyVz7seNmY7kyvCB8LmYALSmT/CgeOLRwaqDbZVATe/y6t0kZse8UfdiCyYXO7oGxMKe26ZsS1SjZY2jov6GsayhMXEoKIAil1R0dWjKBNVfTGFckrfYd6A1SFY8doNAYwuOAEmTITb6pSKhhEw1Bybm53WkXWPmn/qRki7QTfK2WAqmArVuH8wSfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core] security-customizations: Fix pam_tally2
 deprecation
Thread-Topic: [cip-dev] [isar-cip-core] security-customizations: Fix
 pam_tally2 deprecation
Thread-Index: AQHYnrkdjZwX9558tUywHnkiCTXWz62M+utAgAChaYCAACv5AA==
Date: Sun, 24 Jul 2022 17:47:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYBPR01MB55490F6AC6864938CE246CB9A4929@TYBPR01MB5549.jpnprd01.prod.outlook.com>
References: <20220721065917.11637-1-venkata.pyla@toshiba-tsip.com>
 <c63a7711-155a-7b0f-2109-1ffc4513954d@siemens.com>
 <OSYPR01MB5542DB553157E82974F75F53A4929@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <ef1fa74c-7366-24cb-f2c0-69f9a0e09d4d@siemens.com>
In-Reply-To: <ef1fa74c-7366-24cb-f2c0-69f9a0e09d4d@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99a3e4a8-48d6-4e4c-077e-08da6d9c9882
x-ms-traffictypediagnostic: TYAPR01MB3648:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 uKW+TrG8+JLA+2qKt63qoCsRr0vLFyhe3RWAjcTsOdzkbd/8p17WFve67HVOALsCoRAHfyCc66SMsHs7tNg9x9he2yvhYyjm8Mz4LyeVQ5hPo18cK0t/MnptGb6zm6/hunpNj0jANBLlvqnX1RJ+oKSFn0HEdIewS9jOeUyi4DhULuRVBJNjkaFObkpWTgvHM2jZY7NGhnJuIPZwgNcEAlASvSjpnGw9vdOqTa2NNU2oxLlt0EZU1gXvLpqQ7nkinUmlux6Qk1zotkKpQ4+WTthfsK4u+1A/8qYX33/xjnp0FM3o1Q/Jlm0JYxNwz11+GgTAQ9FocpPY0KypedoYdJM9t5RCfFnjM/JxjfAkqwWbw5SsXN427KrOAQhXDOAOb0f3ujuDrsWXZk8ZrSQhDZCQTYPRoHdngzwhZ8Zch44VcRGSw5lSqb04CooznE/4vL1h6XJIWIXFp+FgkQoJ+j6XpxxsP54JKRbDppEZjkCgY5TBKZXnkaiYvAL+iNIsM4qoaNns+HDaw7fJQ5rIIlLAdzZM+AZ3hkhb3AEjwCsdtTK1QjX5iNsCqmLz1R5knF8Lb3soJomgEC+tunQH0UrHz6bZk91h+f6ZFYXZF2ZSLcsDraRZFJipHraPq4RBZruN2Xieu1KXrwL6CM03tsvNrx02VXJUNoVgTzfvkl1s7cgzg5JM0l1YoYh49tDrktE8TeeCE+lIWLS+oKr850wbXITDSDUpZLc0S2aIxcko4wX3j/FlsLjf4RIKQ563xWFTCj/Lm5bnXGVIH7ycrllo+3xrFc9pn5kX8HD64CYL7F5T42loXF5cvrcvUHW6qBToQGKTsfTadFxCKaWmdA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5549.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(186003)(107886003)(55016003)(83380400001)(8676002)(4326008)(71200400001)(66476007)(66946007)(76116006)(54906003)(66556008)(66446008)(64756008)(110136005)(15650500001)(85182001)(7696005)(6506007)(53546011)(41300700001)(26005)(2906002)(33656002)(38070700005)(86362001)(38100700002)(9686003)(122000001)(8936002)(5660300002)(316002)(52536014)(966005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SVF5OVJSaFdWV000WS81Z0dVL1BlV0kvV0FVVXg5WXJXWHdpQW5oOC93WERx?=
 =?utf-8?B?NFJTOTVVemJSeVF1NkhieDB5OGhCRDJJcWlpSjRaZno0d0treVFzWUU0dHdR?=
 =?utf-8?B?QnFrTVFQVnpkbXRiOSs4Z0hZWkJ2Wk1ZZWg0YURTeDB6Z2NhS2pZWkNiY3Iw?=
 =?utf-8?B?ait5blVQdENlWnd1NDBpYzF3ZGdnNlo4S2h1S0hIYS9kWHB5OGFJRk5IaGxl?=
 =?utf-8?B?b0V2dU1MM0p1dUgwOGxQYmZQYjRJL3pibFdWcUtWdW1vMHljQzhwS3p6MG1F?=
 =?utf-8?B?YlNuaHB5Y2xFOVRjRW8vMkZDSDI1SHRYN1N0eVNnYUhTcG1UWUlsekhtYjI1?=
 =?utf-8?B?VDNSTnVmSk9NVTRCNWxPWnRKeHlSenlBcG1iU3BkK3VhOW5lTGlYNFNQYXpN?=
 =?utf-8?B?N2h3S0dZRnNXZnREclJ2QTZIeXpTMzZyZDhkNVBaSVZBYS94ZjB1UmlGSXEv?=
 =?utf-8?B?MGtuR2N5SkRYcHBRRVhFQ3ByaGJZT3JKUkI1QUFGbWkvejVqVGJkSEo5dFpJ?=
 =?utf-8?B?TVZEWW9Nd3VGWCsxUDBNdkN1SW9tbWc5TTVEbW56MU1ZbTViL05TaWMzZjY5?=
 =?utf-8?B?N3JiNkdNS2RHeHVaRmF5S1Q1OVNqNEU2RHFBZDN1S04zSmdSeFArVC80Qkxw?=
 =?utf-8?B?dG5hOGJPdGdmb2sxM205Z2pIOVVyOHdMU1lheklPS2E1Z1FhTjZ6KzVGaWNV?=
 =?utf-8?B?T2hORENqYkcvQkhFZ3ZCYWxlTitRcU9vL0d4RnZZZDVLT1FueHc2MHhldm0y?=
 =?utf-8?B?MWhJN0NQT0VOSW5pM1RvM0wwMEVWTCtVUmpvNjhueUxWVzQvV0tYekRuZjlq?=
 =?utf-8?B?ZDRFaTl4ZjVkZHRNQlNJcm5PV2MyeE5qUmdKSTBjWEcyNGxxcldxQmdRZXpO?=
 =?utf-8?B?S3ZBcnFYbytiV1hHQ0lZbGR0MFJzOCtaYUJOejFTQUtOVXJjdXJiL3FvUGVD?=
 =?utf-8?B?V1RSeG5DZjlDeWJjcEgza21BckxEaE93ZldhOG1mT2d0bU1Cc1lrZElpNlFq?=
 =?utf-8?B?dnV1d0Y4RTZ4N04rZldZVFg5Z2REMWRjZytMdHVWOGttdmFURHRtZVZUaUxv?=
 =?utf-8?B?Ylc1cVZrMzdzRHNWZmxUYkZ5dzVHQmQxTE9GM0kxakU1TGs1OUJUUXRmbk1E?=
 =?utf-8?B?WEpXTGVSZEpQUUtJSCtlaHp5SXdOTUt1dThHaXFzZk4xVXBtYk9pc2lrdWZu?=
 =?utf-8?B?bm5UQ3NadHo3bzFvS1YzODFXRWd0QlhvMkZiTS9NVDhaMjVTcjl3R3R4SHQ3?=
 =?utf-8?B?MlpJcWFhU3hTWC9pQUN3c1JkeEllM2VjRUF6WFVpdWV4UGVRZG5WSlh5Y21a?=
 =?utf-8?B?Yklzd2ZXU3RSYVhNc0t3VHpJWU02K0VaT1R5dEIyTnB2YmJQQWhhVDZvUlM5?=
 =?utf-8?B?YVpBcmVEQnUzMTlJeDVQZDRZMGkzSEVUREZIWTdjamthSXg2VnJWZHpCUzhB?=
 =?utf-8?B?Sll3ZTMyaFBjWDRodTNOZHhBWThuWFYvR1pqZ1FBME0vNkx6bVlqT1psSHFn?=
 =?utf-8?B?MVEwajRtVWU2Y3hDZG9hTlZ2cnpLcWg1NGVVVGRsU0I4dDQ3ZjRVcDRrN0dH?=
 =?utf-8?B?Y2hGZzNWUmF1NXpuQkhLbGR3WWU1VFN0Ri9sKzVXcFhQK2I3aTM4UllGR1d1?=
 =?utf-8?B?ZUlrNXJQdk5yQ0VtWStLWlhmZkUxMm1IcGZoZ2gwRDh2V0ZRZUZhUTF4VGNx?=
 =?utf-8?B?OXYxbzZCdWZEK2pvd1VUbFBFRVE4aEZyU2VQNGxWb1AzeWw1akx6K0hza2N6?=
 =?utf-8?B?SStxUnVTTXhZOHZaVHkyT3BLMGlQZTVMNU9YTzVzOGZEV0F4VmpmWTBKeTQy?=
 =?utf-8?B?YU4xRXlWUkhHSjErQjFKZE5EZTMxdjdzV2t4Q1crZUZ1OVdnQmp0U3BBU3VN?=
 =?utf-8?B?RFZBSG40RXdtalJhVHFDclkrdTV2QTBuU0htUGZrTkhZNU8vVjZ6elNycTRs?=
 =?utf-8?B?eGxaTTFIUTVoYSszU0RYTzRNQWpTUTcycnZobzVlVlcyanlRVi9lTGtzWEM1?=
 =?utf-8?B?dS9nNjE1Q0gwZHlSVWFkdUdvNlhuRUNEekIwRkVta1lGL0FUS09XZU5sL0s0?=
 =?utf-8?B?ODRlTnpWWkRPT1Jxd0lXRXkyMC9PeUVraWtkd0xTZHZNenlhQ3NSMHVvS0Ev?=
 =?utf-8?B?eCs2NDJKUXFNbVgwNjZEY0Vvd2IwVERVWTErOXlub0krREFQUVpldXo4b01W?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5549.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 99a3e4a8-48d6-4e4c-077e-08da6d9c9882
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 17:47:36.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 ZnQE5tUSKpFhexnP8/GX8pWcN55U7ANPj8GygrBm8XNNqPJRHULK+0xiZxxy7Xzi8iH9xB6PzTap0KlnSyOTENN1bKgsev779L+M0AU9z/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3648
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Jul 2022 17:48:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8898

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
DQo+SmFuIEtpc3prYQ0KPlNlbnQ6IDI0IEp1bHkgMjAyMiAyMDoyMg0KPlRvOiBweWxhIHZlbmth
dGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEt
DQo+dHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPkNjOiBkaW5lc2gg
a3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hp
YmEtDQo+dHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yz77y377yj
4pev77yh77yj77y0KQ0KPjxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KPlN1Ympl
Y3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmVdIHNlY3VyaXR5LWN1c3RvbWl6YXRpb25z
OiBGaXggcGFtX3RhbGx5Mg0KPmRlcHJlY2F0aW9uDQo+DQo+T24gMjQuMDcuMjIgMDc6NDAsIFZl
bmthdGEuUHlsYUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1l
bnMuY29tPg0KPj4+IFNlbnQ6IDIzIEp1bHkgMjAyMiAyMjo1NA0KPj4+IFRvOiBweWxhIHZlbmth
dGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEt
DQo+Pj4gdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPj4+IENjOiBk
aW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFy
QHRvc2hpYmEtDQo+Pj4gdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah
77yz77y377yj4pev77yh77yj77y0KQ0KPj4+IDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNv
LmpwPg0KPj4+IFN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZV0gc2VjdXJpdHktY3VzdG9taXph
dGlvbnM6IEZpeCBwYW1fdGFsbHkyDQo+Pj4gZGVwcmVjYXRpb24NCj4+Pg0KPj4+IE9uIDIxLjA3
LjIyIDA4OjU5LCB2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4+Pj4gRnJv
bTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4+Pj4NCj4+
Pj4gcGFtX3RhbGx5MiBpcyBkZXByZWNhdGVkIGZyb20gUEFNIHZlcnNpb24gMS40LjAgdGhhdCBp
cyBmcm9tIERlYmlhbg0KPj4+PiBCdWxsc2V5ZSwgYW5kIGludHJvZHVjZWQgcGFtX2ZhaWxsb2Nr
IGFzIHJlcGxhY2VtZW50IFsxXS4NCj4+Pj4NCj4+Pj4gTW9kaWZpZWQgdGhlIHNlY3VyaXR5IGN1
c3RvbWl6YXRpb25zIHRvIGNoZWNrIGZpcnN0IHBhbV90YWxseTINCj4+Pj4gZXhpc3RlbmNlIGZv
ciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGFuZCBpZiBub3QgZm91bmQgdXNlIHRoZQ0KPj4+PiBw
YW1fZmFpbGxvY2sgdG8gYWNoaWV2ZSB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5Lg0KPj4+Pg0KPj4+
PiBGaXhlcyAjMzMNCj4+Pj4NCj4+Pj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1wYW0v
bGludXgtcGFtL3JlbGVhc2VzL3RhZy92MS40LjANCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
dmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4+Pj4gLS0tDQo+
Pj4+ICAuLi4vc2VjdXJpdHktY3VzdG9taXphdGlvbnMvZmlsZXMvcG9zdGluc3QgICAgfCAxOSAr
KysrKysrKysrKysrKystLS0tDQo+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9z
ZWN1cml0eS1jdXN0b21pemF0aW9ucy9maWxlcy9wb3N0aW5zdA0KPj4+PiBiL3JlY2lwZXMtY29y
ZS9zZWN1cml0eS1jdXN0b21pemF0aW9ucy9maWxlcy9wb3N0aW5zdA0KPj4+PiBpbmRleCA5YmE4
NTQwLi5hZTA2YWI3IDEwMDY0NA0KPj4+PiAtLS0gYS9yZWNpcGVzLWNvcmUvc2VjdXJpdHktY3Vz
dG9taXphdGlvbnMvZmlsZXMvcG9zdGluc3QNCj4+Pj4gKysrIGIvcmVjaXBlcy1jb3JlL3NlY3Vy
aXR5LWN1c3RvbWl6YXRpb25zL2ZpbGVzL3Bvc3RpbnN0DQo+Pj4+IEBAIC0yMiwxMSArMjIsMjIg
QEAgc2VkIC1pDQo+Pj4+ICIwLC9ecGFzc3dvcmQuKi9zL15wYXNzd29yZC4qLyR7cGFtX2NyYWNr
bGliX2NvbmZpZ31cbiYvIg0KPj4+PiAiJHtQQU1fUFdEX0ZJTEUgICMgQ1IxLjExOiBVbnN1Y2Nl
c3NmdWwgbG9naW4gYXR0ZW1wdHMgICMgTG9jayB1c2VyDQo+Pj4+IGFjY291bnQgYWZ0ZXIgdW5z
dWNjZXNzZnVsIGxvZ2luIGF0dGVtcHRzDQo+Pj4gUEFNX0FVVEhfRklMRT0iL2V0Yy9wYW0uZC9j
b21tb24tYXV0aCINCj4+Pj4gLXBhbV90YWxseT0iYXV0aCAgIHJlcXVpcmVkICBwYW1fdGFsbHky
LnNvICBkZW55PTMgZXZlbl9kZW55X3Jvb3QNCj4+PiB1bmxvY2tfdGltZT02MCByb290X3VubG9j
a190aW1lPTYwIg0KPj4+PiAtaWYgZ3JlcCAtYyAicGFtX3RhbGx5Mi5zbyIgIiR7UEFNX0FVVEhf
RklMRX0iO3RoZW4NCj4+Pj4gLSAgICAgICAgc2VkIC1pICcvcGFtX3RhbGx5Mi8gcy9eIyovIy8n
ICAiJHtQQU1fQVVUSF9GSUxFfSINCj4+Pj4gKyMgcGFtX3RhbGx5MiBpcyBkZXByZWNhdGVkIGZy
b20gcGFtIHZlcnNpb24gMS40LjAtNyBpZiBbIC1mDQo+Pj4+ICsvbGliLyotbGludXgtZ251Ki9z
ZWN1cml0eS9wYW1fdGFsbHkyLnNvIF07IHRoZW4NCj4+Pj4gKyAgICAgICBQQU1fTU9EVUxFPSJw
YW1fdGFsbHkyLnNvIg0KPj4+PiArICAgICAgIFBBTV9DT05GSUc9ImF1dGggICByZXF1aXJlZCAg
cGFtX3RhbGx5Mi5zbyAgZGVueT0zIGV2ZW5fZGVueV9yb290DQo+Pj4gdW5sb2NrX3RpbWU9NjAg
cm9vdF91bmxvY2tfdGltZT02MCINCj4+Pj4gK2VsaWYgWyAtZiAvbGliLyotbGludXgtZ251Ki9z
ZWN1cml0eS9wYW1fZmFpbGxvY2suc28gXTsgdGhlbg0KPj4+PiArICAgICAgIFBBTV9NT0RVTEU9
InBhbV9mYWlsbG9jay5zbyINCj4+Pj4gKyAgICAgICBQQU1fQ09ORklHPSJhdXRoICAgcmVxdWly
ZWQgIHBhbV9mYWlsbG9jay5zbyBwcmVhdXRoIHNpbGVudCAgZGVueT0zDQo+Pj4gZXZlbl9kZW55
X3Jvb3QgdW5sb2NrX3RpbWU9NjAgcm9vdF91bmxvY2tfdGltZT02MCBcDQo+Pj4+ICsgICAgICAg
ICAgICAgICBcbmF1dGggICByZXF1aXJlZCAgcGFtX2ZhaWxsb2NrLnNvIC5zbyBhdXRoZmFpbCBk
ZW55PTMNCj4+PiBldmVuX2Rlbnlfcm9vdCB1bmxvY2tfdGltZT02MCByb290X3VubG9ja190aW1l
PTYwIg0KPj4+PiArZWxzZQ0KPj4+PiArICAgICAgIGVjaG8gIk5vIHN1aXRhYmxlIHBhbSBtb2R1
bGUgZm91bmQgdG8gbG9jayBmYWlsZWQgbG9naW4gYXR0ZW1wdHMiDQo+Pj4NCj4+PiBTaG91bGRu
J3Qgd2UgcmF0aGVyIGZhaWwgKGV4aXQgMSkgaW4gdGhpcyBjYXNlPw0KPj4gSSB0cmllZCBub3Qg
dG8gZmFpbCBpbiB0aGUgbWlkZGxlIG9mIGFwcGx5aW5nIHNlY3VyaXR5IGNvbmZpZ3VyYXRpb25z
LA0KPj4gcmF0aGVyIGdpdmluZyB3YXJuaW5nIHRvIHRoZSB1c2VyIGFuZCBvbmUgY2FuIGNoZWNr
IGxhdGVyIHdoeSB0aGlzDQo+Y29uZmlndXJhdGlvbiBpcyBub3QgYXBwbGllZC4NCj4+DQo+DQo+
V2lsbCB0aGF0IG5vdCBtYWtlIGl0IGhhcmQgdG8gdHJhY2sgcmVncmVzc2lvbnM/IEtlZXAgaW4g
bWluZCB0aGF0IHdlIGdlbmVyYWxseQ0KPmhhdmUgbm8gaW50ZXJhY3RpdmUgdXNlcnMgaGVyZSwg
cmF0aGVyIGF1dG9tYXRlZCBpbWFnaW5nIHN0ZXBzLiBJbnNpZGUgSXNhciwgdGhpcw0KPm1lc3Nh
Z2Ugd2lsbCBub3QgYmUgc2hvd24gdG8gYW55d2F5IGJ1dCBhIGxvZyBmaWxlIG5vIG9uZSBsb29r
cyBhdCB3aGVuIHRoZQ0KPmluc3RhbGxhdGlvbiBzdWNjZWVkcy4NCg0KVGhhbmtzIGZvciB0aGUg
ZXhwbGFuYXRpb24sIEkgdW5kZXJzdG9vZCBub3csIHRoZSBlY2hvIG1lc3NhZ2VzIGFyZSBub3Qg
c2hvd2luZyB1cCBkdXJpbmcgdGhlIGJ1aWxkIHRpbWUgYW5kIGl0IGlzIGRpZmZpY3VsdCB0byBr
bm93IHRvIHRoZSB1c2VyIGlmIHRoZSBjb25maWd1cmF0aW9uIGlzIG5vdCBhcHBsaWVkIGR1ZSB0
byBmYWlsdXJlLg0KDQpJIHdpbGwgY29ycmVjdCB0aGlzIHBhdGNoIGFuZCByZXNlbmQgdjIuDQoN
Cj4NCj5KYW4NCj4NCj4tLQ0KPlNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj5Db21wZXRlbmNlIENl
bnRlciBFbWJlZGRlZCBMaW51eA0K


