Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68883CE7A88
	for <webhook@archiver.kernel.org>; Sun, 24 Sep 2023 15:28:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.41464.1695569295800425372
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Sep 2023 08:28:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 38OFSBCS288954; Mon, 25 Sep 2023 00:28:12 +0900
X-Iguazu-Qid: 2rWgLYQMfRJJ6AQGxc
X-Iguazu-QSIG: v=2; s=0; t=1695569291; q=2rWgLYQMfRJJ6AQGxc; m=QzBUkMvPdXRJsJJafnkpn6F2WOlm84AlYGhUoaqbITw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 38OFS91R1810210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 25 Sep 2023 00:28:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAdUr9t6DRDNeLIGu+bJTdj0Li7QOi6nf8S+SfsBHlOd/tUL1HPumhp6xY7JerEJsC/zT24AprkjtqUZKAttfB7w6ZzENFubNY/tLdGBETmeyyOagGHdlwdHMNhIKsdGI20fRy5+0g2mEOFoF0jom/tYwshWYjaC30L0fGpowz1cabqjxXThs7YLioHoSg0BmDHI/BEDNTVQ5XdG/v2P/pcjdd0ciqPPPJSv43RvaH2RhqkURsa7SSCvj+h1DZvPpvMjHFrqDQdeRHPPAQs235UOSsw20v5kKw0TLSFaayELeq5LdpT+ocim9HelNWCuhAFqU6Lu0FRNG5nJSUjnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mc+YEZAW8M5je5cU/wlhCc3IbBo9aC+GBNtTv76CYzs=;
 b=ao5dwgZJ02MBVIzIOK0rbdCnS64CJxGMjrBEmdi1XfQT6kJxC15Aud6WOHAKrfk+L7FoVB29Ozr9LVIiWxf7ZzgctTM0f2+6y/LfhvDGwH8RaFEfzx8+m5Bx5llUVjkEiISJV4qlSq9ScCc0tTX8O56PQeoF+TDPFuJAZSQ1noJ9dN026u3zAcZwVi5uRxgxp6DAz6Gl7gKokRHJCa6RH2keuE+1Jvh4nccQbiLd/5dn8lA0Z/P9maXWqz8E3KRgLbT6yH34nvoSE7hGjKJPp2pcQfndCo6g8bDHLh8fJnNNMnpjj3BDq+P7U8gwaUPQLaEmjpXnOfXww8LfUbSU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core] dosfstools: Add recipe to build it locally
Thread-Topic: [isar-cip-core] dosfstools: Add recipe to build it locally
Thread-Index: AQHZ7T1WLoozsIfAZUSALT6vWkKkfbAm5wmAgAMi27A=
Date: Sun, 24 Sep 2023 15:28:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB55429CB5CEC8D326A392DCCCA4FDA@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230922101245.3219-1-venkata.pyla@toshiba-tsip.com>
 <5a7868c2-edd4-488f-81c2-3bd94944c7ab@siemens.com>
In-Reply-To: <5a7868c2-edd4-488f-81c2-3bd94944c7ab@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYWPR01MB10709:EE_
x-ms-office365-filtering-correlation-id: c718e568-ea1a-4c75-7db4-08dbbd12da63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mMeNA0Kn7E1aFeSWJ/f8LjxaaaFKE03FblJmEbSPOHzhOZccmY9jRjWeM90LRLLwr7vy9aY3GQGes4NwrRbQS/SpYjdWqXhUJ21OOzdpQ4W8W8qxvF3wJdAd7r9T9C0K6gFK4MSFlJhrMH95nwG3f7+OsTOJXK2WUFgj4GNjfg2iUdILx+D6FaKRGv2i5jnBOzVA81NyNCMvzNgvu//SobXefrX4ZyQuUqy983ratFV0KJquTOKa9ofHazfljtwPBSXiP0hcdskhoD6z5eB1UPcj3V5YBbZ7J7AUosH6NN5+0uG9Du+/PX0YvWfSs42NLsm8375/Z3lN1Ru+qqaY7zYzzj+upjncecKaI5IhCKSS2aJLmZcYcilditnJlKhbumLoF+aIxAelNeUDA20vJtL8yl1e6Q+COc0PAxQsQ7Lm9KQ4LUgp5g+nltsKyyBK0OdpWUv+IEOX/VzhksRLnC868aqtWGMiXWqRoDr7tk+3tXX431fZorll3AgCMLcnEYRRECnB0/C7v8LZN7q/iy6pG//8xbpXKsyWZy/ssIg26GVQhu43Nyh+L11iFcY8XgdwkG94BDWEG7Iwvr8+hd7DYb5TCBtoragbSSoCrE9V650vuUr2tsbkxPfHZWd8BYr1oFL0bqh8BLE7WjNM4Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(55016003)(83380400001)(107886003)(26005)(8936002)(8676002)(4326008)(478600001)(66476007)(52536014)(41300700001)(66446008)(64756008)(54906003)(66946007)(110136005)(66556008)(76116006)(966005)(316002)(9686003)(5660300002)(53546011)(2906002)(7696005)(6506007)(71200400001)(85182001)(33656002)(38070700005)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dzI1ck1SQVlUZWJMRnpGQVJiSnVTY2FFQUV6dndjT2ZMNEY3bndOeG1YMlNw?=
 =?utf-8?B?c213cmF6NitYY3VrWnZJUVo3czgwRDdIVDZFdlZFZlVINHdBdEtwa1hWQUI5?=
 =?utf-8?B?WVkwd1hqNno1dDZBWTZxcmpxUzVLQU1YLzJKSmhyUlZWT0FrT2ZoZ0puYkRq?=
 =?utf-8?B?NGhBYXVFVUlrQjZvRFNtWWxHQmpGS3o1aGRndEZSaWx2Vi9qa3lIQVJmVjVB?=
 =?utf-8?B?aHhPbmJzcUJZS2JqODl3OWZXcVBXRjkrSEozWk92UDhLa2hqcmZ4ckdmdm1y?=
 =?utf-8?B?SGNsK3huTnhiMjVhQXRMREVjd2w4UXlVNWhRWVdHTWF4UVVndURMM3J1TGZp?=
 =?utf-8?B?MVZac1dJdUVZL3hsNHB1TnJjUVE0RnQwMENqajZDck5pRmo4SjdFNG5NeExM?=
 =?utf-8?B?dUovdUpReFJLMEoxNnJ0elV5MU5rUDd5NFZGRGFVVW14bCszY0FuS2o5elJD?=
 =?utf-8?B?cHVkU012SEh6dkp4Z2wvQkZtckYzUnZWU2Q4aGdzeEpjYnhjZ3ZjN3pRMGF6?=
 =?utf-8?B?NnZmdHFRV1NnbzFjdExHeGJIVWI5dGo4a1VveXFqM3NVSGRNc1NoS28vRmdv?=
 =?utf-8?B?KzdzOGVvZW5RRjk2RHRyQnk3bncvOTNJTDJPdVRhN0l4RGxXZDczWEpVSmpD?=
 =?utf-8?B?MVBUMWJJcms4NkF6N2lXTWhZVG5WeHFsUHpNRFk3ckRSNlhRRzZ2c08xTEVB?=
 =?utf-8?B?bnJKaVhmNUJOV3JaUEt5c1d6VC9IcUlQOXdTRGhkdHB4NW5qekI5dWhXcXJS?=
 =?utf-8?B?NTJ0TUdoQXZma1JDczh5TXE0REo1ZGtvNGNRaW5BL1ZnNXp0VSthcm82WEtX?=
 =?utf-8?B?Qnh0ZTcvMlcvZkpGYm5FdWtZamtOeEtTeFlWcDZZRnVoVnFKWnhETkNndDh2?=
 =?utf-8?B?VThrN29JWk40bnhQUnUxQ0FZbEVTZUJVdS9leWU0YXhsdVpQRVlFRDFIaTc5?=
 =?utf-8?B?Ulk2MGloYjBlWDRld2VURGMvMnBoN0Z4ZXo3M0s5NUxvUDZaaC8rbUx2bTgx?=
 =?utf-8?B?SGhRRm1Xdk1GNEJsdHA0MjF5amtUSEtlQnlDZUlyQXBIaE1nVnlFb2ZqTjRM?=
 =?utf-8?B?SHVhRi9GbFB0R2JLQkl1RzA5OHBnRFhhY1JnSyt4ZEhkaE9ORmZITDN0UHpD?=
 =?utf-8?B?QU5iUHJBN21GZnRicEErR3JGRVJ3OVNVZExwdFI5Qm9aUTIyNVpUclg2c05J?=
 =?utf-8?B?NzdPdXhEQzdZQlRDR2dSZGVpWmg4ai8rdG14dW12cUZQdFZJZk9PU01DaGho?=
 =?utf-8?B?bFZTcHFFd0VPRFgyMk04TmcyNjNlWndXclg4VTU5Z3hBd2pGRDA3ZmR6eHIx?=
 =?utf-8?B?K2lPK1I5d0c4ZTNHKzllaExkb3NPbS9tRE1ROFcwVzBQTlB0U0M5VXRKUTNs?=
 =?utf-8?B?OTE5Y3ZkRWRtZ3dTUmFkaFU1M1p2WWhMV0N0OGswYnBjTE5vYldOb1pnSEQ4?=
 =?utf-8?B?YUhqZ3ZkTnlhSjFaNWZyWnhaRVR4ODRoOWJaMkMyWDAzYy8wa1NpQVhXc0VG?=
 =?utf-8?B?MWdMa3NTUXBzVzliVkx5Vm1DaVZFTXlnTFh2WHo2c1lZQWNaajR3UnR2dXFT?=
 =?utf-8?B?emF4Z3NMQ2tJQkJud0svbHhFVmtJR0xXV3ZiNFBtbWRlVUx6Z2N3MkNKcGhJ?=
 =?utf-8?B?TE9zUnJUTGJEZTg2Y09qQm96RE9raVVzRXlTL0NsUnlpYlRKY3VmMGFSdWFG?=
 =?utf-8?B?QWw0VFBtTi9XcmRZWDlPajdvVmIwZXZZYzdPQkpOQkRNbHpubDMvcStZb0pS?=
 =?utf-8?B?alVFYmlNS1BUWmxjcXhtNiswNFNTazllME5SK3UxUDQwOHVjZHdCNUwwNTZi?=
 =?utf-8?B?V1Z0ZFRSQjMwN2lZTGJ6akFmSUtuU0JxSVRtajRxc21INGdBVG8xT3YwZjVO?=
 =?utf-8?B?M0Vwd0prMzFMR1BlNU9KR2FyNzFpTllCVTNBbEhQckhEZHU0dTdKZ2xETjlx?=
 =?utf-8?B?K0ZqV08yamFHVkhPR29sejlUWUNNdmdxOHk4MzZ0Wk9oRGRnVWJTek90andt?=
 =?utf-8?B?NnAzTmtDTVpUU3QrSUVVNmdIV0VDVGU4VlhvOHFvWmxjQUllS1d3L016aWxN?=
 =?utf-8?B?cS8vRWJxekZ1OHVJZVdEdmNYK0RCZVBKNGVXNWs0UCtMUk42REFWRlVFUy95?=
 =?utf-8?B?ODdycFBOT2Nlc3Q2bk5CK2lpeERLbGphYXdzakxVQUFuSkE1RmM0ekdrcjE4?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c718e568-ea1a-4c75-7db4-08dbbd12da63
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2023 15:28:07.3851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YizpyuSDvwHqF6LJx7/0EAiRw8xxxKAAoKoTawq+b+m/ItQsPeqX+VbEfhY3l6PH2iP+HnCqOkaUGTeaglR3fviFbNT5u04Zjfzea1zw1yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10709
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Sep 2023 15:28:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13216

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjMg
Nzo1NiBQTQ0KPiBUbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGlu
ZykgPFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPiB0c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnDQo+IENjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQ
b3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+IHRzaXAuY29tPjsgaGF5YXNoaSBrYXp1
aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vvvK3v
vLDvvJQpDQo+IDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KPiBTdWJqZWN0OiBS
ZTogW2lzYXItY2lwLWNvcmVdIGRvc2ZzdG9vbHM6IEFkZCByZWNpcGUgdG8gYnVpbGQgaXQgbG9j
YWxseQ0KPiANCj4gT24gMjIuMDkuMjMgMTI6MTIsIHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAu
Y29tIHdyb3RlOg0KPiA+IEZyb206IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEt
dHNpcC5jb20+DQo+ID4NCj4gPiBta2Rvc2ZzIGRvZXNuJ3QgZ2VuZXJhdGUgZmF0IGZpbGUtc3lz
dGVtcyByZXByb2R1Y2libHksIGR1ZSB0byB0aGUNCj4gPiByZWFzb24gdGhhdCB0aGUgdXRpbGl0
eSBta2ZzLmZhdCBpcyBub3QgaG9ub3JpbmcgdGhlIHZhcmlhYmxlDQo+ID4gU09VUkNFX0RBVEVf
RVBPQ0ggYW5kIGluY2x1ZGluZyBidWlsZCB0aW1lIHN0YW1wcyBpbiB0aGUgZmlsZSBzeXN0ZW0N
Cj4gPiBoZWFkZXJzLCB0aGlzIGlzc3VlIGhhcyBiZWVuIGZpeGVkIGluIHVwc3RyZWFtIG1hc3Rl
ciBicmFuY2ggYnV0IG5vdA0KPiA+IHJlbGVhc2UgeWV0LCBzbyBidWlsZGluZyBpdCBsb2NhbGx5
IHdpdGggdGhlIHBhdGNoLg0KPiA+DQo+ID4gVGhpcyBsb2NhbCBidWlsZCBjYW4gYmUgZHJvcHBl
ZCB3aGVuIHRoaXMgcGF0Y2hbMV0gaXMgYXZhaWxhYmxlIGluDQo+ID4gRGViaWFuIHJlbGVhc2Vz
LCB0aGlzIHRpY2tldCBbMl0gbW9uaXRvcnMgZm9yIGNyZWF0aW5nIHJlbGVhc2Ugd2l0aA0KPiA+
IHRoaXMgcGF0Y2guDQo+ID4NCj4gPiBbMV0NCj4gPg0KPiBodHRwczovL2dpdGh1Yi5jb20vZG9z
ZnN0b29scy9kb3Nmc3Rvb2xzL2NvbW1pdC84ZGE3YmM5MzMxNWNiMGMzMmFkODY4DQo+ID4gZjE3
ODA4NDY4YjgxZmE3NmVjIFsyXQ0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9kb3Nmc3Rvb2xzL2Rv
c2ZzdG9vbHMvaXNzdWVzLzE3OQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogdmVua2F0YSBweWxh
IDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4gPiAtLS0NCj4gPiAga2FzL29wdC9y
ZXByb2R1Y2libGUueW1sICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgLi4uL2Rv
c2ZzdG9vbHMvZG9zZnN0b29sc180LjItMS5iYiAgICAgICAgICAgIHwgIDE3ICsrDQo+ID4gIC4u
LnJlYW0tZml4LWZvci1ob25vcmluZy1TT1VSQ0VfREFURV9FUC5wYXRjaCB8IDE4OQ0KPiA+ICsr
KysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDIwNyBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWRldnRvb2xzL2Rvc2ZzdG9vbHMvZG9z
ZnN0b29sc180LjItMS5iYg0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiByZWNpcGVzLWRl
dnRvb2xzL2Rvc2ZzdG9vbHMvZmlsZXMvMDAwMS1wYXRjaGVzLUFkZC11cHN0cmVhbS1maXgtZm9y
LWhvDQo+ID4gbm9yaW5nLVNPVVJDRV9EQVRFX0VQLnBhdGNoDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEva2FzL29wdC9yZXByb2R1Y2libGUueW1sIGIva2FzL29wdC9yZXByb2R1Y2libGUueW1sIGlu
ZGV4DQo+ID4gOWI1NmIyOC4uZmFkYTIzMiAxMDA2NDQNCj4gPiAtLS0gYS9rYXMvb3B0L3JlcHJv
ZHVjaWJsZS55bWwNCj4gPiArKysgYi9rYXMvb3B0L3JlcHJvZHVjaWJsZS55bWwNCj4gPiBAQCAt
MTUsMyArMTUsNCBAQCBsb2NhbF9jb25mX2hlYWRlcjoNCj4gPiAgICByZXByb2R1Y2libGUtYnVp
bGRzOiB8DQo+ID4gICAgICBTT1VSQ0VfREFURV9FUE9DSCA6PSAiJHtAYmIucHJvY2Vzcy5ydW4o
ImdpdCAtQyAke0xBWUVSRElSX2NpcC0NCj4gY29yZX0gbG9nIC0xIC0tcHJldHR5PSVjdCB8IHRy
IC1kICdcbiciKVswXX0iDQo+ID4gICAgICBXSUNfREVQTE9ZX1BBUlRJVElPTlMgPSAiMSINCj4g
PiArICAgIElNQUdFUl9CVUlMRF9ERVBTICs9ICJkb3Nmc3Rvb2xzIg0KPiANCj4gVGhpcyB3aWxs
IGxlYWQgdG8gZnVubnkgZWZmZWN0cyB3aGVuIGFsc28gdGhlIGltYWdlIHJlcXVlc3RzIGRvc2Zz
dG9vbHMgYW5kDQo+IEhPU1RfQVJDSCwgdGh1cyBQQUNLQUdFX0FSQ0ggPT0gRElTVFJPX0FSQ0g6
IElmIHRoZSBwYWNrYWdlIGlzIGJ1aWx0DQo+IGVhcmx5IGVub3VnaCwgdGhlIHRhcmdldCBpbWFn
ZSB3aWxsIGdldCBvdXIgY3VzdG9tIHZlcnNpb24uIElmIGl0IGlzIGJ1aWx0ICJ0b28NCj4gbGF0
ZSIsIHRoZSBkaXN0cm8gdmVyc2lvbiBpcyB1c2VkLiBBbGwgdGhhdCB3b3VsZCBiZSBub24tcmVw
cm9kdWNpYmxlLg0KPiANCj4gSSB3b3VsZCByZWNvbW1lbmQgdG8gZGVjbGFyZSBkb3Nmc3Rvb2xz
IGFsc28gYXMgZGVwZW5kZW5jeSBvZiBvdXIgaW1hZ2VzDQo+IChERVBFTkRTLCBub3QgSU1BR0Vf
SU5TVEFMTCkuDQpEb2VzIGl0IG5vdCBzYW1lLCBhZGRpbmcgaXQgdG8gSU1BR0VSX0JVSUxEX0RF
UFMgKz0gImRvc2ZzdG9vbHMiIHdoaWNoIHdpbGwgZXZlbnR1YWxseSBhZGQgaXQgdG8gdGhlIERF
UEVORFMgKz0gIiR7SU1BR0VSX0JVSUxEX0RFUFN9IiBpbiBpbWFnZS5iYmNsYXNzIHRodXMgdGhl
IHBhY2thZ2UgZG9zZnN0b29scyB3aWxsIGJ1aWxkIHByaW9yIHRvIHRoZSBpbnN0YWxsaW5nIGl0
IHRvIHRoZSBpbWFnPw0KDQpDb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcuDQoNClsxXSBodHRwczov
L2dpdGh1Yi5jb20vaWxiZXJzL2lzYXIvYmxvYi8wNTcxMDY0N2RiNjIyN2JlMDRiZDZkYjk1ZmE0
ZTQwMDBiNTA4NDEyL21ldGEvY2xhc3Nlcy9pbWFnZS10b29scy1leHRlbnNpb24uYmJjbGFzcyNM
MTINCg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1kZXZ0b29scy9kb3Nmc3Rvb2xzL2Rv
c2ZzdG9vbHNfNC4yLTEuYmINCj4gPiBiL3JlY2lwZXMtZGV2dG9vbHMvZG9zZnN0b29scy9kb3Nm
c3Rvb2xzXzQuMi0xLmJiDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAw
MDAwLi4wMDlkOTlkDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL3JlY2lwZXMtZGV2dG9v
bHMvZG9zZnN0b29scy9kb3Nmc3Rvb2xzXzQuMi0xLmJiDQo+ID4gQEAgLTAsMCArMSwxNyBAQA0K
PiA+ICsjDQo+ID4gKyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiA+ICsjDQo+ID4gKyMg
Q29weXJpZ2h0IChjKSBUb3NoaWJhIENvcnBvcmF0aW9uIDIwMjMgIyAjIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOg0KPiA+ICtNSVQgIw0KPiA+ICsNCj4gPiAraW5oZXJpdCBkcGtnLWdicA0KPiA+
ICsNCj4gPiArU1JDX1VSSSA9DQo+ICJnaXQ6Ly9zYWxzYS5kZWJpYW4ub3JnL2RlYmlhbi9kb3Nm
c3Rvb2xzLmdpdDtwcm90b2NvbD1odHRwczticmFuY2g9bWFzdGVyIg0KPiA+ICtTUkNfVVJJICs9
ICJmaWxlOi8vMDAwMS1wYXRjaGVzLUFkZC11cHN0cmVhbS1maXgtZm9yLWhvbm9yaW5nLQ0KPiBT
T1VSQ0VfREFURV9FUC5wYXRjaCINCj4gPiArU1JDUkVWID0gImY1OWY0ODUwNTg2ZTg4Yzk0NWE5
MjJmNWY5Y2M0OGI1ZGE2YzU0ZmEiDQo+ID4gKw0KPiA+ICsjIHRoaXMgaXMgYSBob3N0IHRvb2wN
Cj4gPiArUEFDS0FHRV9BUkNIID0gIiR7SE9TVF9BUkNIfSINCj4gPiArDQo+IA0KPiBMZXQncyB0
cnkgdG8gcmlkZSBEZWJpYW4gdXBkYXRlczoNCj4gDQo+IFtyZWNpcGVzLWRldnRvb2xzL2Rvc2Zz
dG9vbHMvZG9zZnN0b29sc19sYXRlc3QuYmJdDQo+IC4uLg0KPiANCj4gaW5oZXJpdCBkcGtnDQo+
IA0KPiBDSEFOR0VMT0dfVj0iPG9yaWctdmVyc2lvbj4rc2llbWVucyINCj4gDQo+IFNSQ19VUkkg
PSAiYXB0Oi8vJHtQTn0iDQo+IFNSQ19VUkkgKz0gImZpbGU6Ly8wMDAxLUhvbm9yLXRoZS1TT1VS
Q0VfREFURV9FUE9DSC0NCj4gdmFyaWFibGUucGF0Y2g7YXBwbHk9bm8iDQo+IA0KPiAjIHRoaXMg
aXMgYSBob3N0IHRvb2wNCj4gUEFDS0FHRV9BUkNIID0gIiR7SE9TVF9BUkNIfSINCj4gDQo+IGRv
X3ByZXBhcmVfYnVpbGQoKSB7DQo+IAlkZWJfYWRkX2NoYW5nZWxvZw0KPiANCj4gCWNkICR7U30N
Cj4gCXF1aWx0IGltcG9ydCAke1dPUktESVJ9LyoucGF0Y2gNCj4gCXF1aWx0IHB1c2ggLWENCj4g
fQ0KPiANCj4gDQo+IFRoYXQgcGF0Y2ggZmlsZSBpcyBub3cgdGhlIHVwc3RyZWFtIHBhdGNoLCBu
b3QgdGhlIHBhdGNoLWFkZGluZyBwYXRjaC4NCj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVu
cyBBRywgVGVjaG5vbG9neQ0KPiBMaW51eCBFeHBlcnQgQ2VudGVyDQo=


