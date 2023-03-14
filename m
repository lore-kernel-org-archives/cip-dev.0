Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1A9C6FD1C
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 13:50:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.9152.1678801836257081276
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Mar 2023 06:50:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 32EDoW5g008372; Tue, 14 Mar 2023 22:50:32 +0900
X-Iguazu-Qid: 2wHHaIQr8oUm32rwrh
X-Iguazu-QSIG: v=2; s=0; t=1678801832; q=2wHHaIQr8oUm32rwrh; m=qd9DnToqkNepNfBRwZo733rZeJsKp/Rk2+xpQlsHVM4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1113) id 32EDoU9M038626
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 14 Mar 2023 22:50:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXB+qoeCPO/9BXKH/6w1YA3fm15yQhp++9ymI90XjBAJcM73cUkmGuEULSBFTGxuprG0Q5JcRG3ZuQ9ch31544ki446y/iwIGRpIu3dSKqCFz0AgPgikk1ldQthMz85EvYHZGGuczc9jmjGf697iW9Y4pfm+QUlxeGTLBqHSnws5FNpa/GoQTXEh/y3uQoJf/R4kEbnQlTUPCO9M1BVaO+pYnid+Igp2yCXycO5WnvOIofO/0YSAgAgXgEToR0k6OaDz/46itxTFBiUL+CQss2PLcU+xLS6f0CWXrb51FK1ygBW/qmD4Q/bvI46/fWIfAnLZW3CALeYmAYyXhCszNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zfwanboIwlbMm0CA4FN/+vamDmanjpAgOqE9VNQsrU=;
 b=i/QEE/9uQLQb0yGt4LQAaHpRNAiFpFWMiSkROdjYOhXXYXpHwPyB1I78pnfdGan6k+xl9tLaioV5xyeaEZTDxq/nVDO8tSJAaukQMIGjJUjikyReI7TOrpLi70iP112O/x99cOLNuWeHirSRIVa8/pxSI6UZpHbn8s5qEsdTXXDN5A1QJcUCShK0XMh2PwWrBzesuEJo5n0bC5A/1g/kKY2COHvMtUysKm4q22ZtioVZ5EsKFKgzfpfx6Qz0A8yz+xoJmQ79F/YfytJy3n60PWzInRdPPmv/DtSgKSRVxjRituW0c82vtXfkPh4iT5lrfyoa4eLmM4O+4+5ZViw+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <quirin.gylstorff@siemens.com>,
        <christian.storm@siemens.com>
CC: <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Subject: RE: FYI: efibootguard is available in bullseye-backports
Thread-Topic: FYI: efibootguard is available in bullseye-backports
Thread-Index: AdlWRyXxmxuTXKC0TIiQE9BuVT231wAAvaSAAAsli4A=
Date: Tue, 14 Mar 2023 13:50:28 +0000
X-TSB-HOP2: ON
Message-ID: <TYCPR01MB8295E794C248138155A47B9DE1BE9@TYCPR01MB8295.jpnprd01.prod.outlook.com>
References: <TYCPR01MB8295463B41D4D1D9317FD779E1BE9@TYCPR01MB8295.jpnprd01.prod.outlook.com>
 <29b3a6b2-1988-0470-45fd-12ed7ab14262@siemens.com>
In-Reply-To: <29b3a6b2-1988-0470-45fd-12ed7ab14262@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8295:EE_|TYCPR01MB8678:EE_
x-ms-office365-filtering-correlation-id: f92b23bd-1005-46ea-911a-08db249311e0
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CTTf1s729/0LhGzZDMlOVuRNbo6iMrTUiMsLE9cg2P5W3+crKGEjFGuhjKGdpCoaDFvLpBpdp3xBr0f0AsASw4G4YCV4nnkJX50mzHi9ansOhMqxnyh2DEFleBhWFLiZhGggdwyGWeQp7Px5Lo8aG8l9RaiGfsirrPDG51SSqf0MQ0XGYdqpLXyV6LV69qZbF47tzta1XeQTe9UvNuR+EPKqx83dwDrl9q6k9ytRuBbjo7RCgtHdcPI8iWtR/BK94PsREqcgd4T4Hp+i/g4vmYjKJvhlMlM7D2wXY0rhmaSBLbSJJ9BZMI/eMBAx29MK9uesbnfNr2tvl9qZcCCO7pfou0NECUKiQjdl332A1T0KrX9ujynYRoA4l1TctXAU5whs2VPLwWT4a1W8pGvqfhtNCT//BncplJOJ1lkXyek5uuAqhtrrvRrpQzNSZuZOLvh700niNDHTtzoD0Jr/VaQGo5/4vRVnl0LCOofLiYYdWu5+sqtwNdTpnVnKbSw911Qd2Qz5rt40cpX2ZlmXDRrTO3cRuy02UWLrQNJaW6QmAu221hAJc6oT6ob936jRswT4JandMA25wDxTwwAZE9QpapSOD25L4fkDazkbNAKHwTMqm3aUQ8r8E9Jh1NLrsRWxBWOvZv7OJwDpTC5CQcCXC4AACv7oeERLQzswT2HW1lB6J3AVARSYwilUO0CBYGZA3cpy5rbb6p/KkMcXcFuCJwqP4hZu+xcO7itAj8k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8295.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(86362001)(38070700005)(122000001)(33656002)(55016003)(316002)(8676002)(66556008)(54906003)(64756008)(66446008)(66946007)(8936002)(4326008)(76116006)(41300700001)(110136005)(38100700002)(52536014)(478600001)(66476007)(2906002)(5660300002)(83380400001)(26005)(71200400001)(7696005)(9686003)(966005)(55236004)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWZxM212ZUFTVW9TU013RXNzSW5qVTdDWEZyK3pia2F3bkhFbXVJZ3ovSXN3?=
 =?utf-8?B?WFQ1RlVxWFFzQnp2N09FNDVyMjVKTGtQSllhQnM3SmdSdEZiMHdaTEJVSllm?=
 =?utf-8?B?b21pMDdkWDhKMC9XanVtT2hXcGYyMXRPOVdtNGRLWksxVms5MDE2c2N1SUk3?=
 =?utf-8?B?czZ1dXNWdEtXYk05b3dxRTVWU2t4VTEzcW5CS3hJNGV4YkdNUTFMV3VlLzdE?=
 =?utf-8?B?VlZCK3hCbHI4WEo1eUl3MXZMNk5uK2RsNFg4NTNhRDVHTHlPKzEzK1pkdm1U?=
 =?utf-8?B?cnhQeFc0RG5yTk11a2Q5WFZOWmVBMW9uMHgxdzFJOEkxeE9vL3dPWFJYWDFL?=
 =?utf-8?B?RHVsSVlLbG1vcE4yNS9EbmdsMHFaTmo2dEN5Y1ZUTlN6SVBIQUEyR0lIaE1j?=
 =?utf-8?B?K3FnbFpERWdaTE93b0grUWx1SUR4elVIbnVLYjVhRE5LemNJbkkzRUxIVE9V?=
 =?utf-8?B?Tm5hUXpaUW9wVXdQbkdkbVVNTXRwUmsydnVCSHY0K2Z6dktoRXh5U0xFdFBN?=
 =?utf-8?B?UGNoODc1MWd3VkJjSkNhbEY4dzBaNW9ZYWo1NWhhSWtISmVRM0lGZVV5bU1k?=
 =?utf-8?B?am5lR1FTMG1JMjFVb3lkN2RCa1dDSUhlOXA4bWZhdjhaSm1vdUFTVFE5bnVl?=
 =?utf-8?B?ZTI0aWZseCthMGtsWnNoWjZKTDJKTlVOWXZhZUQxOExmdWlNcUdBSWkwc3Z3?=
 =?utf-8?B?cDR6YzFvcmk0TzUzT01SM0JCK1dkREpqMTl0c3V1WGt2dGlyWkpqMGxqWmJW?=
 =?utf-8?B?YnkyRy9ldDRjQ1BGcWlMMENYeHVBdDBkNzR2bG9MU3VKRGJyRjA1cnFXZlQv?=
 =?utf-8?B?QVAraDhIYnR5LzFIeUFwYXNVdXA3OGRQVXlVRW5zaU5NYUp2RVF6RzNDdFVP?=
 =?utf-8?B?NnNJY0c0U1h5VHNJeFJrMnZkNlZraWNhL2U1c05wM1dLQUdscDcweENYQzNv?=
 =?utf-8?B?NjhFaE1GUWZqWmNWTWsrN0QyR0ZNN21tcGpyNm9uYkppTGZBUnVxQWk1TTVU?=
 =?utf-8?B?Rk1Ma0JxVGVDcE5DUFhaVlBoODI0ZURSeWRRUXIxNURiMWtvWFRRSlptdVoy?=
 =?utf-8?B?TUJ0UEt3ZitDdUx1aGU4MG1hQ1FUMlJ1anVlZHJBWXV6TENpT3BWMlVQTmQ2?=
 =?utf-8?B?V1kveHd1SXJraFI4QWpLYlNXZURKYlZyVk5BQUQ5NGlqNDFua3V2bUZUbWZB?=
 =?utf-8?B?eE5vQVQ5NDFyWXd2VzJSYTBkVDBnY3UvZVNDMlNnQSt5MUUycXo1b0ZadkdX?=
 =?utf-8?B?WU10SGJreXhDK1FaT1FTYS9kTG4xTW8xaHl4YlFRaGxiUGpQRkpoS1pDcmYr?=
 =?utf-8?B?SWNNRmY3TUFZczkzOXd0d3hVSGpKTEk1UDlWQytTbHNKRmVvSElHeEJRdjVU?=
 =?utf-8?B?dUVaditCUWE1a1V2L2wxcG1aVGZjb1FxQVpkQzVab2RRVFFoVEdYUXBGa0N6?=
 =?utf-8?B?M2FoWjhoajFDcjUxL05tS3ZUL0VpYzVnd21VenhWZEZ2dDUyTlAyem94YnBn?=
 =?utf-8?B?TThKbmgvVjM0dC9UeGtKUEp4OUZoeGdPYkl1SnBHdUxsUmFqR3VhTXZlV21U?=
 =?utf-8?B?ajBUSmdsbnNhclQxSS9KRFhQMmNERGU2VDdJZ1pwdUZVQlNPRlBEOHVUWXhJ?=
 =?utf-8?B?S1NQdlpiT3RobDEvdDBVci9KOVE3dFN2cVBFUFRqRmx1eTQ5QnZXL01ObytJ?=
 =?utf-8?B?TFVLVVFoUmE0cnJJQTYwcnNuazhlZy9WajQxZmdsYnFxYUFiOHg5RE9iQ2lv?=
 =?utf-8?B?NWtBOG1Ud25jUTF2ZmhKTEM4emN5ZVpRSlRqOFdNZmd6QjNkM2dtWWEyYmg3?=
 =?utf-8?B?SDV2VU5URTM1cHRnQzhlYUV5OUc5TE1lR2dYb1ZUSUdLN1B2c3pOUVJkWENH?=
 =?utf-8?B?MjJuL0xaeEVpQkZPYTI2ZjIvNzZWNzVtZGt1QXBxc2FjSUhPNkMzc0diVHk4?=
 =?utf-8?B?cU5rQjM4R1A2KzBCM3JyQ3NhZ2hkU0pSbm5HUEVzdmRkYnJSTitKSFB3ZDVJ?=
 =?utf-8?B?SDdDSEFIcEM0dG9zT1NKckQ1MjNZVFZ5eGhiOWZmb1M2ck1taitwNUZ1RDJp?=
 =?utf-8?B?cm5rYklLZ3VFWmxhVWRxaUtBcXFSdStrdFM0aldqK3NYNHRTNXZXSWhkYzFI?=
 =?utf-8?B?UWltbld3VHN5cEYwSDB2SlJ5RG9qK2ZTbFc4TExiS09TM0tNZ01jMWlwdkFQ?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8295.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92b23bd-1005-46ea-911a-08db249311e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 13:50:28.1154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1myeUaxOEeO7XftB6kdi2YiCWBsFVSeEWLy7UPJ2/eO2IWgOBp5HLNDP2wqPuIEqW8CjD2XLhiiti4MhfQTA2Xzs16RmaCIR5yBVsoFVZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8678
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Mar 2023 13:50:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11026

SGVsbG8gSmFuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suDQoNClsuLi5dDQo+IFRo
YW5rcyBmb3IgdGhlIGluZm8gYW5kIGZvciBlbmFibGluZyB0aGlzLiBJdCdzIHN1cmVseSB2YWx1
YWJsZSBpbiBjYXNlDQo+IHRoZXJlIGFyZSBubyBuZWVkcyBmb3IgcGF0Y2hlcyBhZ2FpbnN0IEVC
Ry4gQ3VycmVudGx5LCB0aGUgb25seSByZWFzb24NCj4gZm9yIGEgc2VsZi1idWlsdCBFQkcgaXMg
UklTQy1WIHN1cHBvcnQuIFRoYXQgbWF5IGNoYW5nZSBhZ2FpbiwgdGhvdWdoLg0KPiANCj4gU28g
d2Ugd2lsbCBrZWVwIGJvdGggb3B0aW9ucywgdXNpbmcgdGhlIG9mZmljaWFsIHBhY2thZ2UgYnkg
ZGVmYXVsdCBidXQNCj4gcGVybWl0dGluZyB0byBzZWxlY3QgdGhlIHNlbGYtYnVpbHQgb25lIG9u
IHBlci1tYWNoaW5lIGJhc2lzLCBlLmcuDQoNCk1ha2Ugc2Vuc2UuDQpJbiBvcmRlciB0byBkaXJl
Y3RseSB1c2UgdGhlIGJpbmFyeSBwYWNrYWdlcywgSSdtIGd1ZXNzaW5nIHNvbWUNCnBhY2thZ2Ug
cHJvZmlsZSByZWxhdGVkIHNldHRpbmdzIGxpa2UgYmVsb3cgbmVlZCB0byBiZSB1cGRhdGVkDQpo
dHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL2Js
b2IvNmQzZTU3NDkvcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjEuMTEtMSUyQmRl
Ymlhbi1nYnAuYmIjTDMwLTMyDQpidXQgdGhleSBzaG91bGQgYmUgbm90IHNvIGNvbXBsaWNhdGVk
IHRvIGFkanVzdC4uDQoNCkJlc3QgcmVnYXJkcywNCkthenUNCg0KPiANCj4gSmFuDQo+IA0KPiA+
IFsxXSBodHRwczovL3BhY2thZ2VzLmRlYmlhbi5vcmcvYnVsbHNleWUtYmFja3BvcnRzL2VmaWJv
b3RndWFyZA0KPiA+IFsyXQ0KPiBodHRwczovL3NhbHNhLmRlYmlhbi5vcmcvZGViaWFuL3N3dXBk
YXRlLy0vY29tbWl0LzZiODMzZDkwOTE0NWM3NGMwNTANCj4gZTE5MzRjYzU3M2MzYjM4MGQ0ZjE5
DQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gS2F6dQ0KPiA+DQo+IA0KPiAtLQ0KPiBTaWVt
ZW5zIEFHLCBUZWNobm9sb2d5DQo+IENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=


