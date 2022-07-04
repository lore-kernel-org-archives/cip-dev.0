X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.74325.1656953469128765503
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jul 2022 09:51:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shreyas.karmahe@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 264Gp69Y019717; Tue, 5 Jul 2022 01:51:06 +0900
X-Iguazu-Qid: 2wGrayp4pA4VnCUriK
X-Iguazu-QSIG: v=2; s=0; t=1656953466; q=2wGrayp4pA4VnCUriK; m=Z4Q0EtnyfGR+hhpGSZ0bCLV38f2F5rg7/x4KmzxkhbE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 264Gp5EY031196
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 5 Jul 2022 01:51:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6q6SYayXqAge4Osatqa5FxZf5nsrO85jpWCWNijP/ND8OpDqDXwGNBN8a93FSdzfnDBJHxpmR5vwfn3Zfi5bHN0vNVlRW7cS0A4KoWfED7buokZmqvyFdjgBT0F6uidUZa2VNZ39G01HupX/EgDELX+BUsHkNVHItZqlXdeuXgq/ySX2Lle38zDklzj0hIVSayXIZv7mbM9g6nFMFthJ+XUCMNwd++nBpFYRw0Bbr7KZ4jerH0fkfIjAr28mStONBAUY8lwNFZdn2vDHHKEVbKQW7QdJtJRsJuGrP5KEm+kmUV75lksYM6Vpr7Gmss6xlQLndZyb/VZFYngRBcAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW2HTM0Yy9NHoMciR8V/gcvpaUS38o7Ywyv+jfBix1I=;
 b=TmumiRWaqJK/+iPQbFA330gPs1Xs4nYMpuP/G3XS/ANo/Qoika52in1AU20iC20/ILnhCtb+ZpahbaE5wWOLqTmtUeMpicweYLQfg4PdtlRlfEzAjyS84oM8U+oj3pfwflKOnMaeyKnwG8llm45ACszp4bHsqINkEzXcXgRb2N3LDhzIvPsOA/iny03ch9dz0ivf6yBPuWgYICaYcCWD7W0QC2x0ne/YBY/z4+zik+As1wrzHcBP3aq5Yae5mf7Eg3rCD164dFPsOLDHjSzKUqGUnXr+HrRTQWQa0ukkhrbmVb3Ot5FYO492Ss+F2ml8xrpwN+EcmWHVp8V/E2Hxeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shreyas.Karmahe@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <yes@arc11.toshiba.co.jp>,
        <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Venkata.Pyla@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core] postinst:Added lines to verify Local and Remote Multi-factor Authentication
Thread-Topic: [isar-cip-core] postinst:Added lines to verify Local and Remote
 Multi-factor Authentication
Thread-Index: AQHYjHRNCmGSCLrHB02oFJoqydEjeK1pY7AAgAAAUICABQ3DYA==
Date: Mon, 4 Jul 2022 16:51:01 +0000
X-TSB-HOP2: ON
Message-ID: <OSZPR01MB88776F17082E85E3FB3A57ABDCBE9@OSZPR01MB8877.jpnprd01.prod.outlook.com>
References: <yes> <20220630112644.3682066-1-Shreyas.Karmahe@toshiba-tsip.com>
 <446fe1e4-eaca-f920-3750-cbea068a8347@siemens.com>
 <00a35fff-97ff-e94a-2b6e-b2bda6231f90@siemens.com>
In-Reply-To: <00a35fff-97ff-e94a-2b6e-b2bda6231f90@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69aa4e27-6a79-4c28-cd73-08da5ddd60b9
x-ms-traffictypediagnostic: OSAPR01MB1523:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7d8B1wgtwScprHgXElyLrlOgC4MJgG31c8D740WL5fqyb84isqWMm3OLCsBeDW3xrfDmZFb6BYDhAhmtWN4ZfE1vjs78rdrazW0WuLtwotjOZDW7oHECdvPSLY1IqCcUE/NZnD3tmiVvIQOP0jkxcm1eif4BIGqiedwQ/+1smP6aBoxRdoWdZE7j99ORa2NdFKCaByFsjo4v+76rn3+gkjcPBD9t0mAooiEAEhJdWfrXRyiuTfcnC2uSOMV6bnynIzV+JEin3SCtSzSKuH7sOJzzaLSr1gp8xFUe1jlQfi2aZ4kcUmhW4wBczhzdOtSj+XbBBGQqFSuYC2hYyHz0fTokRVlM5rs6oBy1dQgOnb8yD4YNkylosEws5rshqys6p0kPKD1Ca/GtO1AhQcsVGz7OaGWBAWEypoZv5CsYNgvvRet30+E89l4/lRB4nwZl/angOY333LFMCIh6gI85snHY9J46zXqIXdq54KddgkihbTv8ZaIpSGGxx3bkdP2k8fHj4Xt+XqEt52Igdg75Yej0R5iJ6rFoYMSib4L6kyS0U7nCbynXYGPVI0rWnbv1JhEfZ3dAec90Ysb9ATcdpXsnae3l186XgD9QTquyh/EL9Z9hedtF7SGtiarDCVMC6lKFx5EGr42qqXjOuSD6+cE6RlpWpB7AQLup+eU1+BPHm5X0mM25P5+swz5E7dXP/euHAh/Z8Qiy4zj73w2sZ5xodoM/Mgu58CEdtCHx8coEFjJDMdDUcebE2nW4ihNYIL/zPYDukRZlXgUoXPvzK7BoTrrLEGH/XgcJUjEnzrFAZsZ4SbuqOz7mAg6cJZ7a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(15650500001)(71200400001)(38070700005)(110136005)(2906002)(41300700001)(316002)(54906003)(7696005)(6506007)(53546011)(186003)(83380400001)(8676002)(38100700002)(86362001)(76116006)(4326008)(55016003)(9686003)(122000001)(26005)(52536014)(478600001)(8936002)(66476007)(66946007)(66446008)(64756008)(33656002)(66556008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHJGRFRzUWdZSzgwamxrRFZhWUJwcnVQQndNWVY3VG9zUjBVWk56aUlGeDZu?=
 =?utf-8?B?TUhValUweTBxWGo2UGNOUHJYRTdpa2k1bE1KUzAxUVp4TDZMWStXTDZENTRK?=
 =?utf-8?B?NWZCdlVveDZUcVpVSHR2eTF0ZFkwNUNPNDBWTWw5S3AyL1FKYThWWGh2SDBv?=
 =?utf-8?B?cHAvZVlLem5lUWRmNzQ0K2lnaThRRW1rdHRnbHFsL0hYL2JJcFk1c0JyMnlo?=
 =?utf-8?B?V0ZpdVZldlJlb1ZWNUFieGFYa0hleGlFYlRxc3k2eHgxMFNQYmJ2clpQYmJm?=
 =?utf-8?B?ZTFETUZwQy9aZjYyYUZ4aXliNG9ZOWRBYk96QTNqV2pJUnNtQ0pTWW9JU3lX?=
 =?utf-8?B?ZVZONzg3V3B2cWdOWU9JczFnODRvU1ZrZzlaNXBiOVpPRitjODJMdElsSjd3?=
 =?utf-8?B?UkVUbXhxWjhuK2c2eWVSUEZuMm5zdlpJK0JuVFlYK0JqaTFKMTJmRDFVaTll?=
 =?utf-8?B?OTZoWWlZQndLd0NRTkErZXVqRDJOVHhJTnl0RVZPNzlHZjRnUXVIT0xDbi92?=
 =?utf-8?B?cThVOTkyOTFSWmFYTHFFT1lrN3gxS3d0d0dTSUp0M2sxVnJJYTdOU1FrZG1R?=
 =?utf-8?B?Uy9LVmlsRDlzRTJ3elpRNERtSzN2Ym9QeDlxUVFqSVMwZDJXVHIyVUlMOElo?=
 =?utf-8?B?SEtaeTJpSzRNVkJuaWpBUzhJWGZHaCs5aVdiUDVRdmdGZHIxbUQwQmpwcHc0?=
 =?utf-8?B?cWtiWFNYKzEzZHdRNGFiZ3EvTVlEZzJ1dDFKcmxhdWR1cEhPVFo3MVZWeGlP?=
 =?utf-8?B?TC9SclF1YWNydnVzMEFZVW5NY2dwYlZXYnk5MllaemRQQUVnUWpWbXZjTEMr?=
 =?utf-8?B?QVFuWHArV1QxaVFGVll0TE9hdmhHa0ZVYjBIc3pONHFVdDhGalAyQ0QxOGRQ?=
 =?utf-8?B?ampMVUpySTAwN3ZOdE9USThGSmlGeGRvNU1qc1E3VVR5Z1JuQUduYmRvZE5V?=
 =?utf-8?B?RGt0SUw5NWlORjVDcmJUOWJMdEpvamJUaS9iTWdLZFZRSUVrbmdqd3NYSGVw?=
 =?utf-8?B?c0RxUSswaGd6WWJ6VjRydmZaL2MwWmRGbG9JTXhDVGpScjRtS0xMOGllN1c5?=
 =?utf-8?B?azlTK2c1enpIQU4rNmVzc0hoYjdiOVFsUzlEeTR0OFlBTVpCYk5vTVJmNXlw?=
 =?utf-8?B?cXZWRmlQQlZhOWlyVzlPcERxcXFBVXJ5L2NTcjBaRnlqSkwrdXZSK1J1NVNh?=
 =?utf-8?B?TlM4SDdxNGczZm5YaE8vZXNIL1NCMC9NR1NMQXp0OEJCQWlybzVaSHJHanJB?=
 =?utf-8?B?Ym92YmJIcG15cmk0WTdEQzN1Ulh1V25GUUFIdzZyOHh3bnE3RTI4Rm82OHhs?=
 =?utf-8?B?bHI2QXkvSkpqQkYvZFBIL3lsZ05GVXZONlg0V09tWE9GSmdnVmZXS3dYcTFI?=
 =?utf-8?B?SlVjdWRmb3FtSTRnSlNhV1l4dWFBRzZUb1dGeHlocWUycjVaT0pkdVJQOHY0?=
 =?utf-8?B?NzRpdXpqaHdaYllENzFBZWYxVFlPSW5janUzWXhybnhEYnRGWkcvWGhnb28r?=
 =?utf-8?B?am0xbUtEcjNXc1NjbWlzQW1XZDF1UW04eVhDV3FPL21VTERpSDcyS1VqVi9y?=
 =?utf-8?B?cFpkSEhObHB3SkpkVitKRDh1ZnZEYjc3MTM3NnJwQndPQi9JQ0dsbUVKQncw?=
 =?utf-8?B?QXVlU2o2dW1tZlFKdHpDT0h3cmttenlZU290NHRvUUpvYitSVDkxSklEQ2Ns?=
 =?utf-8?B?blV4UUxRT3dRZUJYUE9YenE0MzF0N1VrN1hrU3N5eDlEd3hUakNZSkxFai9a?=
 =?utf-8?B?S0pYRzN0TjErWXpJUGFObGFybGhRN3FtYzdXb1RKbUhyazByLzJLZk9zUDYy?=
 =?utf-8?B?d0tqbE9penJNTkxWa05xSnM2U2hmY09SaktwaFJMeXZDaDgraHROS0MwS3Y3?=
 =?utf-8?B?RVRZa0NJb3YwUUhtbHJxUVRwQ09iM2lMUFpBSmNHb1dlekNLOG9LSFp6ZkUw?=
 =?utf-8?B?dHQvTkFPWlZIenhIc2tVWVA3Q3I2Z004T2ZaRHl4YkhZMVZlTW9YNllHMFFw?=
 =?utf-8?B?c25jK0cxU1QzRnFLcjFFR3VTMHJTMXF2cEJST0c0aUVvbmtuZ0cxRVlTeUh3?=
 =?utf-8?B?WEMvY2g5cHN3OEYvZyt3bVJKK255Y2hiQnBVVVRNUkgzWEhMVWc5ekw2dktJ?=
 =?utf-8?B?MzhmOEhKaktpTmFscnpscFoyNnBGYk5YT2JSSDFFaENhc2llZFZhM00rVTIy?=
 =?utf-8?B?UlE9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aa4e27-6a79-4c28-cd73-08da5ddd60b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 16:51:01.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdH7lRUZni23ztSQ0mBszXDNUUU3CPV8fyJrnISkunKTzBCpuKxnoQXbgJWehO7o2eyQ6/y6jyDGjF2NWKO4+xM/5bpg2mg9qM/Y1rEuW8J/nAeASB3cPT/zTxwVPB+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1523
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>

SGkgSmFuLA0KDQpJIGhhdmUgcmVzZW5kIHRoZSBwYXRjaCBhZ2FpbiBieSByZW1vdmluZyB0aGUg
Y29tbWVudGVkIGxpbmUgZnJvbSBwb3N0aW5zdCBmaWxlIGZyb20gc2VjdXJpdHktY3VzdG9taXph
dGlvbnMuDQpUaGUgY29tbWVudGluZyBsaW5lIGlzIGRlYWQgY29kZSBvbmx5IGFuZCB1c2VkIGZv
ciBkZWJ1Z2dpbmcgcHVycG9zZS4NCktpbmRseSByZXZpZXcgdGhlIGZvbGxvd2luZyByZXNlbmQg
cGF0Y2ggDQoNCnYyLTAwMDEtc2VjdXJpdHktY3VzdG9taXphdGlvbnMtcG9zdGluc3QtQWRkLWNv
bmZpZ3VyYXRpby5wYXRjaA0KDQpLaW5kIFJlZ2FyZHMsIA0KU2hyZXlhcw0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+
IA0KU2VudDogRnJpZGF5LCBKdWx5IDEsIDIwMjIgNTowNCBQTQ0KVG86IGthcm1haGUgc2hyZXlh
cyjvvLTvvLPvvKnvvLApIDxTaHJleWFzLkthcm1haGVAdG9zaGliYS10c2lwLmNvbT47IHllc0Bh
cmMxMS50b3NoaWJhLmNvLmpwOyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGRp
bmVzaCBrdW1hcijvvLTvvLPvvKnvvLApIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47
IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxWZW5rYXRhLlB5
bGFAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDilqHvvLPv
vLfvvKPil6/vvKHvvKPvvLQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KU3Vi
amVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXSBwb3N0aW5zdDpBZGRlZCBsaW5lcyB0byB2ZXJpZnkg
TG9jYWwgYW5kIFJlbW90ZSBNdWx0aS1mYWN0b3IgQXV0aGVudGljYXRpb24NCg0KT24gMDEuMDcu
MjIgMTM6MzIsIEphbiBLaXN6a2Egd3JvdGU6DQo+IE9uIDMwLjA2LjIyIDEzOjI2LCBTaHJleWFz
Lkthcm1haGVAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4+IEZyb206IFNocmV5YXMgS2FybWFo
ZSA8U2hyZXlhcy5LYXJtYWhlQHRvc2hpYmEtdHNpcC5jb20+DQo+Pg0KPj4gVG8gZW5hYmxlIGFu
ZCBjb25maWd1cmUgUEFNIGZvciBSZW1vdGUgYW5kIExvY2FsIE1GQSBTZXNzaW9uIA0KPj4gVmVy
aWZpY2F0aW9uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2hyZXlhcyBLYXJtYWhlIDxTaHJleWFz
Lkthcm1haGVAdG9zaGliYS10c2lwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9zZWN1cml0eS1jdXN0
b21pemF0aW9ucy9maWxlcy9wb3N0aW5zdCAgICAgICAgfCAxNSArKysrKysrKysrKysrKy0NCj4+
ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvc2VjdXJpdHktY3VzdG9taXphdGlvbnMvZmlsZXMv
cG9zdGluc3QgDQo+PiBiL3JlY2lwZXMtY29yZS9zZWN1cml0eS1jdXN0b21pemF0aW9ucy9maWxl
cy9wb3N0aW5zdA0KPj4gaW5kZXggYmI3ZDE1Yi4uODQzY2UzYyAxMDA2NDQNCj4+IC0tLSBhL3Jl
Y2lwZXMtY29yZS9zZWN1cml0eS1jdXN0b21pemF0aW9ucy9maWxlcy9wb3N0aW5zdA0KPj4gKysr
IGIvcmVjaXBlcy1jb3JlL3NlY3VyaXR5LWN1c3RvbWl6YXRpb25zL2ZpbGVzL3Bvc3RpbnN0DQo+
PiBAQCAtMTUsNyArMTUsOCBAQCBlY2hvICIxMjcuMC4wLjEgJEhPU1ROQU1FIiA+PiAvZXRjL2hv
c3RzICANCj4+IFBBTV9QV0RfRklMRT0iL2V0Yy9wYW0uZC9jb21tb24tcGFzc3dvcmQiDQo+PiAg
cGFtX2NyYWNrbGliX2NvbmZpZz0icGFzc3dvcmQgIHJlcXVpc2l0ZSAgICBwYW1fY3JhY2tsaWIu
c28gcmV0cnk9MyBtaW5sZW49OCBtYXhyZXBlYXQ9MyB1Y3JlZGl0PS0xIGxjcmVkaXQ9LTEgZGNy
ZWRpdD0tMSBvY3JlZGl0PS0xICBkaWZvaz0zIGdlY29zY2hlY2s9MSByZWplY3RfdXNlcm5hbWUg
IGVuZm9yY2VfZm9yX3Jvb3QiDQo+PiAgaWYgZ3JlcCAtYyAicGFtX2NyYWNrbGliLnNvIiAiJHtQ
QU1fUFdEX0ZJTEV9Ijt0aGVuDQo+PiAtICAgICAgICBzZWQgLWkgJy9wYW1fY3JhY2tsaWIuc28v
IHMvXiMqLyMvJyAgIiR7UEFNX1BXRF9GSUxFfSINCj4+ICsgICAgICAgIA0KPj4gK3NlZCAtaSAn
L3BhbV9jcmFja2xpYi5zby8gcy9eIyovIy8nICAiJHtQQU1fUFdEX0ZJTEV9Ig0KDQpBbmQgYW4g
YWNjaWRlbnRhbCBjaGFuZ2UgaGVyZT8NCg0KPj4gIGZpDQo+PiAgc2VkIC1pICIwLC9ecGFzc3dv
cmQuKi9zL15wYXNzd29yZC4qLyR7cGFtX2NyYWNrbGliX2NvbmZpZ31cbiYvIiAiJHtQQU1fUFdE
X0ZJTEV9Ig0KPj4gIA0KPj4gQEAgLTQ5LDMgKzUwLDE1IEBAIHNlZCAtaSAncy9hZG1pbl9zcGFj
ZV9sZWZ0X2FjdGlvbiA9IA0KPj4gLiovYWRtaW5fc3BhY2VfbGVmdF9hY3Rpb24gPSBTWVNMT0cv
JyAkQVVESVQNCj4+ICANCj4+ICAjIENSMi4xMDogUmVzcG9uc2UgdG8gYXVkaXQgcHJvY2Vzc2lu
ZyBmYWlsdXJlcyAgc2VkIC1pIA0KPj4gJ3MvZGlza19lcnJvcl9hY3Rpb24gPSAuKi9kaXNrX2Vy
cm9yX2FjdGlvbiA9IFNZU0xPRy8nIA0KPj4gJEFVRElUX0NPTkZfRklMRQ0KPj4gKw0KPj4gKyMg
Q1IyLjExOiBFbmFibGUgTXV0bGkgRmFjdG9yIEF1dGhlbnRpY2F0aW9uIGZvciBMb2NhbCBhbmQg
UmVtb3RlIA0KPj4gK1Nlc3Npb24gU1NIRF9BVVRIX0NPTkZJRz0iL2V0Yy9wYW0uZC9jb21tb24t
YXV0aCINCj4+ICtnb29nbGVfYXV0aGVudGljYXRvcj0iYXV0aCByZXF1aXJlZCBwYW1fZ29vZ2xl
X2F1dGhlbnRpY2F0b3Iuc28gbnVsbG9rIg0KPj4gK2lmIGdyZXAgLWMgInBhbV9nb29nbGVfYXV0
aGVudGljYXRvci5zbyIgIiR7U1NIRF9BVVRIX0NPTkZJR30iO3RoZW4NCj4+ICsJCXNlZCAtaSAn
L3BhbV9nb29nbGVfYXV0aGVudGljYXRvci5zby8gcy9eIyovIy8nICAiJHtTU0hEX0FVVEhfQ09O
RklHfSINCj4+ICtmaQ0KPj4gKyNzZWQgLWkgIjAsL15hdXRoLiovcy9eYXV0aC4qLyR7Z29vZ2xl
X2F1dGhlbnRpY2F0b3J9XG4mLyIgIiR7U1NIRF9BVVRIX0NPTkZJR30iDQo+IA0KPiBEZWFkIGNv
ZGU/IE9yIGZvcmdvdHRlbiB0byBhY3RpdmF0ZT8NCj4gDQo+PiArZWNobyAiYXV0aCByZXF1aXJl
ZCBwYW1fZ29vZ2xlX2F1dGhlbnRpY2F0b3Iuc28gbnVsbG9rIiB8IHRlZSAtYSAiJHtTU0hEX0FV
VEhfQ09ORklHfSINCj4+ICsjIEVuYWJsZSBQQU0gY29uZmlndXJhdGlvbiBmb3IgUmVtb3RlIFNl
c3Npb24gc2VkIC1pIA0KPj4gKydzL0NoYWxsZW5nZVJlc3BvbnNlQXV0aGVudGljYXRpb24gbm8v
Q2hhbGxlbmdlUmVzcG9uc2VBdXRoZW50aWNhdGlvbiB5ZXMvZycgIiR7U1NIRF9DT05GSUd9Ig0K
Pj4gK2VjaG8gIkF1dGhlbnRpY2F0aW9uTWV0aG9kcyBrZXlib2FyZC1pbnRlcmFjdGl2ZSIgfCB0
ZWUgLWEgIiR7U1NIRF9DT05GSUd9Ig0KPiANCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBUZWNo
bm9sb2d5DQpDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K


