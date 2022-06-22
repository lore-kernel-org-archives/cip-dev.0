X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web08.3865.1655875870638968705
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jun 2022 22:31:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157, mailfrom: shreyas.karmahe@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 25M5V7hu015435; Wed, 22 Jun 2022 14:31:07 +0900
X-Iguazu-Qid: 2wHHdmOs3mH9xeu6qm
X-Iguazu-QSIG: v=2; s=0; t=1655875867; q=2wHHdmOs3mH9xeu6qm; m=CjAicCSbkNQeKPQB6Air5JKymHQDFXy3nIdPZmw5954=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 25M5V5lt009078
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Jun 2022 14:31:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIdG+56xNGRvBu0RIZkc9XVtzTXPZGI+PF9IimqktRDo0QATQY77rFiMMhHT1uP0oEOQe3Ak19EUUbf6wExZZlJGHaPMtGJfsLVu0kjgpGI2hr8lCnqMCcOm2hq3GTwX1ea32PUS4pNHwvahwCmbqDWqY9GOpHaskKjRhcAFbAtcrfrwopKsGp2e+6yX/kxPQNTgWb/smgAYTwicm21zNNKmc0rNGwOa4swQPY2Mk+m7YVZK46hEstQZXKvQYGgEdNgcbYN8J3+CrTHVqSTMHBynfZrrYtv9TzXfem8Dy8k3rYkK0m7Bw4c++cyRdMUDD8QZVG30FycClyNSzkk4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFvtEyVRG43Ieoj7T/jeNG2waGszsAfBTE3Er506rR8=;
 b=KYGsQLuCAXiUr0tOI57iyZBph31C3SEwuz8G9OD/3edo2lvDxWFc8KR1okzVlOcTvIxBCtO2qBWZGDoM0G6305ikTfdB4F1M+okHQbf1+bYoVjvuzKI35SV/fqXnA9UGu1jIicLKpM5KJEC4Xbz60mDBgQlqd+il3kd4zpSjs6TbfBS7QPb7RuJoUp0o3ocRNCRESAKfUNpTRoDWp5vd/KJwGdu/Bn5yOtwDmmvEsasSp5ARb6Z9arPyKtoZFqUlwMDUUwGm8DAqf6Np8hIpgKaSOIbmb6PYoYwmNHvjfNKUQnMXi3uSLGlEu8ezxrclUw6W5bi9dM+//7Q87pn9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shreyas.Karmahe@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Venkata.Pyla@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core] cip-core-image-security.bb:libpm-google-authenticator debian package
Thread-Topic: [isar-cip-core]
 cip-core-image-security.bb:libpm-google-authenticator debian package
Thread-Index: AQHYgljIf13Dld520USYg4tDfKXqua1Tse+AgAc6jvA=
Date: Wed, 22 Jun 2022 05:31:02 +0000
X-TSB-HOP2: ON
Message-ID: <OSZPR01MB88777681FCA17016AB061AE7DCB29@OSZPR01MB8877.jpnprd01.prod.outlook.com>
References: <20220617144440.1846381-1-Shreyas.Karmahe@toshiba-tsip.com>
 <36fc490e-dd45-2922-e7cb-6adb5f675877@siemens.com>
In-Reply-To: <36fc490e-dd45-2922-e7cb-6adb5f675877@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8a25588-fde7-4777-cbef-08da541065c7
x-ms-traffictypediagnostic: OSBPR01MB3205:EE_
x-microsoft-antispam-prvs: <OSBPR01MB32056D7C5EF3239CCBC06CBDDCB29@OSBPR01MB3205.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IDUO7fRNvkFho0J6CZ6AHMPAX8a6KemNScQAllkN0Vsp4w3yU9ld+nrfWLYHhwBa3dA2Sl0MGZ+aMlGmWZ3mFSieI1l/oaAc01UsnTJjJPwULjEVqKd1Re/tqy+s5WDyKpblCi0AjpLXp0wCT8x3+2os3OUhBfE7SIm1Uuk/uTzK9SqjOyClE0feSkf986n/bXNpUziZxGJbR09HB6WBtDNWuX/Tp5VyHw2c3Az+srzYKYvDEPi3PN7OK6a1IwfYTeJ1DVw94pvHJCsVtM4QH7EOiBdGAcoWb4oYgr6unb/00kbpBC7icdzsha1vWM0UpVRJ65Avw0q/tlPVspPA7ziP0/mQI81A7MmIiI17g3wlV5+P+VbBqV+0UK0LjgmSGcuAotMNIH2fF5Rh5TYvvnF+wB2AuV71xfe76TzgJ0IURPacKOQl7rKu+mFFzkYSslmzOYxa4kNZxnvRCbfRdMnRji85CA79fXHM8NDIk//kBetmRvM/6d8r8XqTSq9KmXqU+meR4/ut+24ovfQWjVLc7J1qOzrz3F9PhLAnQ1oPVgLnci8TiMN47P+sVYjuBiUP8t/BqtbJsLKSZphKn6AkBDqZT7HMFez+fl++iQMJhMZVZPf17fdkFZhOrxGkMB2wnvgt/NZpyqMjshq7tF3RbT+FesgJFBxJjNRXy4X+SZqBGw+TdIEhTC+nRVY4oMwuSpSpKtDV7BkDmSzNTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(122000001)(83380400001)(53546011)(5660300002)(9686003)(6506007)(76116006)(7696005)(55016003)(66446008)(52536014)(66946007)(4326008)(66556008)(8676002)(38100700002)(85182001)(66476007)(41300700001)(186003)(110136005)(26005)(107886003)(8936002)(71200400001)(64756008)(316002)(2906002)(54906003)(15650500001)(86362001)(38070700005)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWsrTkQ1SGErQzdhenBXL042TFEray9yNS9tMnovc29mYTZTSUJCcjhSUWYy?=
 =?utf-8?B?M001ek1Jcnd5a1FkN0FNUzlsLzY0THZ5aUdlMVhKNFNWVzJCWjRuQ2ZCMXI3?=
 =?utf-8?B?Z1NkSXhrMkhWVm1FYWxxWlhFU2x2L1Y4eTNLdkhHNU5TbGN5VmlsR2QrczZn?=
 =?utf-8?B?QmppdzFTWW4wK290bnlSUmtyN1Z2Y3pCcUVSNFRvalBHU1dMVWFIdWhOem1i?=
 =?utf-8?B?bkhEdlNSbmdaYlFzcXIwZ29tKy9NanY4MGdQRnhCVkU1Z2llczJmem43Slh2?=
 =?utf-8?B?S0R3UGVYKzlSbTBnQmpQYnA4Y1NFVXpKRHZzSXFvZUZYRHNVeDAwUTFQakNG?=
 =?utf-8?B?UVhWNnB1MG1wWFJIUk16ZTFRYTRGODZoTXRuTHdWb0dacWx2bkkwUzZyL0lF?=
 =?utf-8?B?WXB4bkRZSUo2eFkzdXI2TkhsaUJVUS95M3V1SWI4eGxXbC9hTHN6Z1IxOExS?=
 =?utf-8?B?TVdYZDhDQWNlMEZzMDFLak5MT1BaL1h0bTJuRm0wSGY2WGo4WjFJMmV2bHgr?=
 =?utf-8?B?M01Ka1hJY2dvVnduUlMyOXd2U1pJdGM0bUE4VnFlRloxQzR4bWtMNU9FRTk5?=
 =?utf-8?B?cUlzQWFEUitiZlYrREJBK0FUZm93TVhNdmMxeG1YK3RHZmhaN1lZTTRJbEt1?=
 =?utf-8?B?b3NwcWcxdTdHaUt3dFpYS081U1dJclY1SVhHYksyMlF5ZmpVUGNXamFhUHhu?=
 =?utf-8?B?eTdSRFBTVFVPakFmTHFtTnJZWWx6akc5TWxjOFhGd3d2RUhocWRKN0dSK0Qv?=
 =?utf-8?B?bTZiTmdNNGRBUUw3ZzNvbFVxU0NQSUI4MjBkbEYzbHYvQ0pEVXIxSlR5Nyts?=
 =?utf-8?B?c2NXeVF3NzMxMVc1cnE0RUZYNWR1SVgrMEhPNDdjUGtNWXRvcU1Ob0RZR2Jj?=
 =?utf-8?B?ZDl5N1hweENxMGNuRUVQZ214RXViUjlVdUpVQWd5NHVpMytFY0p1eUcrNVZu?=
 =?utf-8?B?MllwWTNBMVEyVHNVeVN0bkxnNUoyU2lwODBPL3E3RC85R3BBSzJCTFQ0YnNF?=
 =?utf-8?B?Tkd4Ykt2ZVlvMmE1bENOMkx0Y1dxbmtLZzlLZnRsQnhzL1Z0L0RHT2FxTFJN?=
 =?utf-8?B?VTFwbkhIbU5CNE1UdXV4NnUxV0FqVUVjaXdJTWdUMGN4MlpuWlhKelZkcXFw?=
 =?utf-8?B?bkxFd01jdlZORzdpWWZ0OWFjaDBqMFJxd2Nrdldrb0NhRUpmeURvVVRjSGhs?=
 =?utf-8?B?b1ZoTjE3d0FwZVAyb3hwYVFDSjVYa3M4cE9ST1lwS3YybThIQUQ2aFRlb2N6?=
 =?utf-8?B?QStxbmVnSGZ1SGhwSW43S01MbmtqYTJUcEN3NXhsWnhhOFZkUHBIeGhhVXcr?=
 =?utf-8?B?Q1NDdE5XdkNzeG9vTmh3Qyt6Z3czMzZkOGM0dFdBQVJsbko1WGNrVmxNSHRu?=
 =?utf-8?B?OS9vcDhmblFRWFRzU2VibTROSHYybTZzUjh5UTNoUW5JR0FpSzRHclI0czJy?=
 =?utf-8?B?VU5UTkJRMjVma2cxdlBHUkpIWHArL0d6ZDd4YzlLczBMNHBKcmovRHdHU0tM?=
 =?utf-8?B?K0lrN29wSERtaGJWYjdCYXRka0daOUFNQStZUy8xVU1qanY2QmdKYWJtVHJC?=
 =?utf-8?B?aDQ5d2hzS2pLTFh2aVltZEt5MGxHTEVLbXRsNmJzcUh1U09wTFZZelVYQTdz?=
 =?utf-8?B?SHFqeFhpVmd1N1lTVUd3V3NRSlRhSmdHdFZMZzNYTXQxMjRvMkc2S0FBV04y?=
 =?utf-8?B?Rjd6enRFNnRVeUtIWTFWMUs0OEtZSlRDN05oanNBWmlKNnRGR09DSnJaMWVw?=
 =?utf-8?B?a09oT2hFUmJNSnZRUEpUWGZ1RWRIbVZLMlN5MW84bk1KaUViVjU2QVlGUkpM?=
 =?utf-8?B?Zm5OU050M3FzRWZZTGdhWGlScHdOWVdjL3dHUTRia29ESzh6ZmtJb255SXBy?=
 =?utf-8?B?bEhpTGlXNng2UnRJajJqWkpsOUdURW1DeEpnUlZmdGlQTmpBUVdVZTlzWG5r?=
 =?utf-8?B?cnBhTXJoT1VEbHh4RmkyclNoaCs0MjFiZHV5SE1hTTAxV1RzUUljTnRLaVY0?=
 =?utf-8?B?eHJmbCtjZFNPRTkzSHVHajBLSTVJVktnV2JyV0drZE1RVTlITkpWUmI4N2Jq?=
 =?utf-8?B?a1dSZVd3aEZ3UmdMRDJBM2VKVHJDV1diMGlkKzc2aithMlhnUjJ4YzVzV0hJ?=
 =?utf-8?B?NzFOMjd4eDhsQnZ3dHZ2aGdvN2JlY0hKZXRuVUdjR1E4ZlBIODBTZkh1aFdn?=
 =?utf-8?B?OVlhcTllYXFqNVA0VkN4WTIwcDBtUnRqeDQ1QmlGdERKY0FjVjZDOHlQeThZ?=
 =?utf-8?B?MXlFWmNmSVpLbWdGaVEvcVJyZkxkT3JHZzlWb3dlVnNOWitYMGhMTlFXSjNG?=
 =?utf-8?B?ZGhwVisrT1BRc2o1RFhVaDZIemhXZFZLZ2dnckUyd1RuWDhyZ0ZOZFdlbTBN?=
 =?utf-8?Q?CxxlXbimeD0TicPo=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a25588-fde7-4777-cbef-08da541065c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 05:31:02.9524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWZlrBF47+rCYi4FYgRdU6WceJqBQ/zTcwt7eFF7MxZ+gE1emvl42qDhzAtUr/njGquzsVhKo8KOQUS/c2W33fMk+zZVw90E4TSeEUIpCz/47Q0AeyGM2/gv3Jc1gKnL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3205
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>

SGkgSmFuIEtpc3prYSwNCg0KSSBoYXZlIGFkZGVkIGxpYnBtLWdvb2dsZS1hdXRoZW50aWNhdG9y
IGRlYmlhbiBwYWNrYWdlIGRlYmlhbiBwYWNrYWdlIHRvIHZlcmlmeSBMb2NhbCBhbmQgUmVtb3Rl
IG11bHRpLWZhY3RvciBhdXRoZW50aWNhdGlvbi4NCkkgd2lsbCBjcmVhdGUgbmV3IE1SIHJlZ2Fy
ZGluZyBjb25maWd1cmF0aW9uIGNoYW5nZXMgYW5kIHJlY2lwZSBjdXN0b21pemF0aW9uLg0KDQpU
aGFua3MgJiBSZWdhcmRzLCANClNocmV5YXMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IA0KU2VudDogRnJpZGF5
LCBKdW5lIDE3LCAyMDIyIDg6MzMgUE0NClRvOiBrYXJtYWhlIHNocmV5YXMo77y077yz77yp77yw
KSA8U2hyZXlhcy5LYXJtYWhlQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLApIDxkaW5lc2gua3VtYXJA
dG9zaGliYS10c2lwLmNvbT47IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBv
cnRpbmcpIDxWZW5rYXRhLlB5bGFAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o
5p6XIOWSjOWujyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxrYXp1aGlybzMuaGF5YXNoaUB0
b3NoaWJhLmNvLmpwPg0KU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXSBjaXAtY29yZS1pbWFn
ZS1zZWN1cml0eS5iYjpsaWJwbS1nb29nbGUtYXV0aGVudGljYXRvciBkZWJpYW4gcGFja2FnZQ0K
DQpPbiAxNy4wNi4yMiAxNjo0NCwgU2hyZXlhcy5LYXJtYWhlQHRvc2hpYmEtdHNpcC5jb20gd3Jv
dGU6DQo+IEZyb206IFNocmV5YXMgS2FybWFoZSA8U2hyZXlhcy5LYXJtYWhlQHRvc2hpYmEtdHNp
cC5jb20+DQo+IA0KPiBBZGRlZCBsaWJwbS1nb29nbGUtYXV0aGVudGljYXRvciBmb3IgTUZBIGF1
dGhldGljYXRpb24gZm9yIHJlbW90ZSBhbmQgDQo+IGxvY2FsIHNlc3Npb24NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFNocmV5YXMgS2FybWFoZSA8U2hyZXlhcy5LYXJtYWhlQHRvc2hpYmEtdHNpcC5j
b20+DQo+IC0tLQ0KPiAgcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1cml0
eS5iYiB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1cml0eS5iYiAN
Cj4gYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLXNlY3VyaXR5LmJiDQo+IGlu
ZGV4IDNlYTU0NGEuLmU1NmQyNzkgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtY29yZS9pbWFnZXMv
Y2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmINCj4gKysrIGIvcmVjaXBlcy1jb3JlL2ltYWdlcy9j
aXAtY29yZS1pbWFnZS1zZWN1cml0eS5iYg0KPiBAQCAtMzIsNiArMzIsNyBAQCBJTUFHRV9QUkVJ
TlNUQUxMICs9ICIgXA0KPiAgCWF1ZGlzcGQtcGx1Z2lucyBhdWRpdGQgXA0KPiAgCXV1aWQtcnVu
dGltZSBcDQo+ICAJc3VkbyBcDQo+ICsJbGlicGFtLWdvb2dsZS1hdXRoZW50aWNhdG9yIFwNCj4g
ICINCj4gIA0KPiAgT1ZFUlJJREVTX2FwcGVuZCA9ICI6JHtCQVNFX0RJU1RST19DT0RFTkFNRX0i
DQoNCklzIHRoYXQgdGhpbmcgY29uZmlndXJhdGlvbi1mcmVlPyBPciB3aWxsIHRoZSBjdXN0b21p
emF0aW9uIHJlY2lwZSBuZWVkIHNvbWUgdHVuaW5nIGFzIHdlbGw/DQoNCkphbg0KDQotLQ0KU2ll
bWVucyBBRywgVGVjaG5vbG9neQ0KQ29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg==


