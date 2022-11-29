Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6882DC4332F
	for <webhook@archiver.kernel.org>; Tue, 29 Nov 2022 08:24:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.144139.1669710241358656401
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Nov 2022 00:24:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 2AT8Nfjh004731; Tue, 29 Nov 2022 17:23:42 +0900
X-Iguazu-Qid: 34trW0L3m2xaZRGBZF
X-Iguazu-QSIG: v=2; s=0; t=1669710221; q=34trW0L3m2xaZRGBZF; m=vhWGsa6jPvT58IQrFKrhL5yA/yVB5c/msHYL634QGMI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 2AT8Nd9w026352
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 29 Nov 2022 17:23:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzquUfTHOH77xfxGHvTspxeYtop983LRdiWCwQITLww65hNDukKU3LQWXsRqa8XRUZI+08I9ye+6HKw1t5UJGYD4TeDSei+AYafXWy4h5ZboB1frNIkQUwpJUxLV6CEtiIFYZzO2td9YIVX042F4ypYXeu2MXVcNNf6HRdA+a3pqadFPJU6f+Ib2KECr+7xmgQBeoviXurw9Bovdu5jPl8Q1HvIeSQXR4US9CdvXDQLdTljhzqr2E9USiE/AF5BTYbs4acNHB/5ATdr4KexxwZAp5/2rdToikeUnyjf/SjoHf9B1xvxx7ewwV8xrbqMOW2pTqdoYpBNezOqMu85xhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKmTrVO27I22fFRTF7EFdvcVj6cw0ufxhlKOOaHbiog=;
 b=Yec9fcqIkcTzlhmPodqvvTh73WQATktm99K/+/VWZUUU+WWLMK8M0nQqvdL3wXhLyOnRhTYROL6NQuENemszipsnpsuD7JF00V6JlHG2/MUCXSQkoBymA4Z+7fgIWqSjPaT3na+YoyVFPSFYYXZkwJseth2SJKlil1kgKRiPSCu44p8/dmMEVaww4Rl6+qo5wdAycjVwmEtMID6HLIRcvnWJ8MvsxSpYnnkNVlXgFMbFOAWb1brm3TjaWnkgt9P937umAGXpaoJkP8U3drH9SRfQXnet8K3Z43KEO1+fEO6nCsRBEcSXsl4KsRHwGW90BNLkL0ALjfWPhQx/5hwSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: RE: [ANNOUNCE] Release v4.19.266-cip86 and v5.10.155-cip21
Thread-Topic: [ANNOUNCE] Release v4.19.266-cip86 and v5.10.155-cip21
Thread-Index: AQHZA7/ltVt0VHIqKkmA5IF/Kxe5ZK5VjwhA
Date: Tue, 29 Nov 2022 08:23:34 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420765700C67F1A308C499A92129@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <TYWPR01MB9420817574A7EE194819701E92119@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <Y4T0kfkdeWj/UmF4@duo.ucw.cz>
 <c8dcd413-8d1a-b6b6-2c39-2c340a5c23e3@siemens.com>
In-Reply-To: <c8dcd413-8d1a-b6b6-2c39-2c340a5c23e3@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB10122:EE_
x-ms-office365-filtering-correlation-id: 90c41cd8-f747-431c-1944-08dad1e3022c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HirmAZfTlSweyUXR3YiGe790mGzmjTCXxOpFyleQp3YjuQNadaxF23hQ448tJlkeYvk9XVXQL45+cpiohfHn7ChNb06CeUwldsreNMV85fbcIDMbSFVc7LVl4wDlUMM2+bJY3BxzEhpaRPZjzRbew2ydvpbh+/vaDydPZZA9qyF7yuRk690LfozE4HbWvAJLVte2ljPxUAJwpVlmXGOsvTcOoNvfxkJaK4XsGOFKNYb7oUdoQaSvIPxDPA0nK1V1FPUhdJexVyBh4OHWmTSfVDMV6RLKUblC/F6meozIvbzFtZ1Kbzi0BkpBLN8c0bNmTSCSkRZHhtxRtRF3vbo9vNwkTmhf0gPKxtdiFt3c1Ub0YwYd7YHncH76xlwtv2vfzOyYdYcXzJQ9pnte1/ZJ5OA3mGsfGvT3A9+jmEqABMU8AhBjqIBsWY1CyWBFa3VhikRhRMnvRXEl2gGT5ATCypR8/+EJka/JwcFrJTmbippv8+59Oix+npRj+HaiLPxf2BJfU3naeTzfa7eeM+Y80OGZhnJmcOgfY4aEzHoElOD4BNGpY5n0BsWhSrMBcrIjC6U9hxcGKqPELJdxD2Fwm2S3zTqVO5HxX58Evomk+WtCKjv4bXzypJq7Es/8WrqOG3HyGEKt7NEKMcah+jkomPpkJvp5OgSYe7Wt/6Lp+/8v5/p4Rca8s5YqNikOg4FR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(26005)(316002)(33656002)(9686003)(71200400001)(55016003)(54906003)(110136005)(6506007)(122000001)(7696005)(38100700002)(83380400001)(2906002)(66556008)(4326008)(8676002)(66446008)(64756008)(86362001)(66946007)(66476007)(53546011)(8936002)(5660300002)(76116006)(41300700001)(186003)(478600001)(52536014)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2ZEVjNXT085WC9ZVTVRNDY5VGFsZGhpMERlTStxS0IvNjQwdFp3cjdLNEZk?=
 =?utf-8?B?RDNiaEtCa2lTNXQxYTVLYWV1enA2bHZxOEpzR0U3ZnpqajlsUTV2RVlpQnNm?=
 =?utf-8?B?b2liSXJjanl6SmRkRXZ4Nk8yTzJZVzNtUGE0YzVCR3hVTENCUkw5UnZJMkpn?=
 =?utf-8?B?OHhJNDQ1WWFTbkFhVmVwdGtwR2NtMDZYY2NPYzVGZlB3WXBKckdudjBDREsy?=
 =?utf-8?B?ZTRRcmtnSUtPNWxicTlwRWwxZlllV3E4dXdmdzluUll2OW82VEtMWnJQT25Q?=
 =?utf-8?B?YnZNQkU2QTFqeFV5WVB5RnhveTFCakVPNmxyZnR2bnR5Mm9mVDZHczIrZzUr?=
 =?utf-8?B?WHNvWmw2Y1VKT3VGdTBDcDI0QjNCZ3NuejJxWE9RMHR1eWZiMXlsTGJKNUhS?=
 =?utf-8?B?NkI5MEtYMUlnRW5WV0E4ZzJoOVlQQ3FjUnZWWDczUUZNY3dqTGdzR2VJTk5H?=
 =?utf-8?B?SDRkYmd2R0hXRmN5RGZmS2tBMnh1eU5uaitScDk1MFZlbVBBS0pBR3dKME11?=
 =?utf-8?B?K2tDdmdqZlhycGp4WnNxeTJZZmo4T3NCckxJU3hGelZDRng1S0N3UUtDSGV2?=
 =?utf-8?B?Zjdad1VXMU5mWk5SaHI3cmtYbThtWVNZdkd4c2pjZEYzQVNleTZyMGNKYVNQ?=
 =?utf-8?B?WXAwMDhNdjd0SVorNkY4Z2hCZ3BzS1doQlRPeFIyaGFCZzMxeWFaTWozdTRw?=
 =?utf-8?B?QWNGUXJPMVYrb1IwMlR3WjBvdVVMdHpVemFYdThzcDA4R3JSTEovUFRrVWxw?=
 =?utf-8?B?NmtNd0d3Zjd3TnNZVkxKclF5cUVWUlNKd1RrZ201OUJKUXNVdytMWmFWOFVQ?=
 =?utf-8?B?clp6WURjTG40RU14d3lZNEhjWnZGaDJtUHhtVGtOZy9zblZIdC9TMkl4WXVY?=
 =?utf-8?B?WnI3MDc0ai8yaDhJMXA2aERMckMwVjFRSVp4eFUwcU9rREk1MndmNitjZVdp?=
 =?utf-8?B?cG1HdG1HSmlrS1VMWjAzRWVXVkhGWFAwT2swK0ZLRVpoRWk0azc4UWlPUHFq?=
 =?utf-8?B?TlZPTFZnb0tYaEJicExNSlRjNUNMbStlak9lYjV4dmRoQmwxWXpwbTQrL0Jo?=
 =?utf-8?B?eXFQR0J5d0tIc2dOVDRESGJNSW5XL1gyOXc3MEtnWkxkb0lFVG54RVZHWndh?=
 =?utf-8?B?Mm9sMzlFbGRkdUYrNXpZdSt1K25ZWC9jRy91ME43NTk5cVZyeGs4S1FhVGFi?=
 =?utf-8?B?cjE2MU9MeTRPVWJRK2xvODJxQ1paK1Q5c2ZkVkxlZFZJaVZqSCtRWEtEVlNR?=
 =?utf-8?B?YUFhTVg4RFhKUXVLM29zRWw2c0VTdklkRUJjZUlnc0pjZGpyVnI4TEdpZHJK?=
 =?utf-8?B?UWk5YitoMlVwNllNVkRYNUVCSVhvb2k2RFFwVW9aOVZKY1Y1K2RnOXFmZDRJ?=
 =?utf-8?B?Q2FOcWhSNjJDbE9NRTFmODRjQ2pkbUJHR0paRndNaUZjdnFmSTBNTStORHdI?=
 =?utf-8?B?MTRRTlJSRVIzdmRqWFVrR1NYZ2huY0VrMUFkdHFIaUFVeHJ4RnJockgzRWhO?=
 =?utf-8?B?bWJnN3Jxak5jT1RBckR5QitLRm9BV1J4TnpLR2xBVTBTek55V0pBRnpId2Ez?=
 =?utf-8?B?NEd0S2dJc04vSk9ZZE9TV0pKRFNjS0VKc2ljNVlTbWVVL1FXYnFwUWpZSlFp?=
 =?utf-8?B?bDRHSFJRR2QrVkE2ODNWQjdQbW1VKy90cXpQZHRJZi93d0o3Z2duVmQrWWxI?=
 =?utf-8?B?NmM4NjZlcVhwZmZqK1gvOEt2MVVoOW1ZajFzSGVMVW9hQS9vTUN5bG4xa1Yy?=
 =?utf-8?B?WURNMktWN3phUFYrSnFYTTV1Ym9KWWc5Qmx1UENyNk5WUnBtK3N3WTdvVVdz?=
 =?utf-8?B?SURRWFVWc0tBN243dEJTNFFXNDdURmxXcHJWQkRxamxDeC8xaUhqWXZISG1S?=
 =?utf-8?B?eHhJTnNVTFhmd1ZnNGhiNDZoWDNnYTV0bGVLdXFwV2hVVjhOc0ZLS21oZHk5?=
 =?utf-8?B?QXRmU1dkOUM3UmxzajVMQzgyN012R3A0cWJiT0o2WHpWdG1ZbkVxbGtSUllW?=
 =?utf-8?B?c3NmdSt1MlphZE40MVpMQnBmNHV2enF5MkozdEFWa0NvVllwU1VEWVhWNXpF?=
 =?utf-8?B?R1RMaVRJVDlDZDJwRjZYVE5LQW9BY0FSZTNmTUNiTDdhUXcxVWUyaE9QUnZ2?=
 =?utf-8?B?am1sTmVUcEIzSENmNVBZbmp1K1JEVjhWVjdmQUcyK3kxeTBkL0s2R1QrazNO?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c41cd8-f747-431c-1944-08dad1e3022c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 08:23:35.0416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNTYzYRvAtCAj0HDPmtfRYKs3ynzJpREhQpkoPEFlJbtYH8Ncj5hD5pR5Ty3cTmd8J3/kAh2RpcaeOihXfef1izGoVbILSa6tIIRhbOCdLJLCGwrA0JonlhRLlPBg0fV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10122
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Nov 2022 08:24:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10128

SGkgYWxsLA0KDQo+ID4gVGhhbmsgeW91LiBJcyB0aGVyZSBwbGFuIGZvciA0LjQsIHRvbz8NCj4g
Pg0KPiANCj4gV291bGQgYmUgZ3JlYXQgdG8gaGF2ZSB0aGF0IHJlbGVhc2VkIHJlYWxseSBzb29u
IG5vdywgdW5sZXNzIHRoZXJlIGFyZSB0ZWNobmljYWwNCj4gYmxvY2tlcnMgcmVtYWluaW5nLg0K
DQpPdXIgTEFWQSB3YXMgc3RvcHBlZCB1bnRpbCB0aGUgb3RoZXIgZGF5Lg0KU28gSSBzdG9wcGVk
IHJlbGVhc2luZy4gTEFWQSBpcyBub3cgd29ya2luZywgc28gcHVzaCBpdCBhbmQgb3VyIHRlc3Rz
IHNob3VsZCB3b3JrLg0KQW5kIEkgdGhpbmsgd2UgY2FuIHJlbGVhc2UgaXQuDQoNCkJlc3QgcmVn
YXJkcywNCiAgTm9idWhpcm8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBO
b3ZlbWJlciAyOSwgMjAyMiAzOjU3IFBNDQo+IFRvOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbngu
ZGU+OyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8ow0KPiDil6/v
vKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gQ2M6IGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyB1bGlAZnBvbmQuZXU7DQo+IENocmlzLlBhdGVyc29u
MkByZW5lc2FzLmNvbTsgbWFzYW1pLmljaGlrYXdhQGN5YmVydHJ1c3QuY28uanANCj4gU3ViamVj
dDogUmU6IFtBTk5PVU5DRV0gUmVsZWFzZSB2NC4xOS4yNjYtY2lwODYgYW5kIHY1LjEwLjE1NS1j
aXAyMQ0KPiANCj4gT24gMjguMTEuMjIgMTg6NDksIFBhdmVsIE1hY2hlayB3cm90ZToNCj4gPiBI
aSENCj4gPg0KPiA+PiBDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2
NC4xOS4yNjYtY2lwODYgYW5kDQo+IHY1LjEwLjE1NS1jaXAyMS4NCj4gPj4gVGhlIGxpbnV4LTQu
MTkueS1jaXAgdHJlZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lvbiBmcm9tDQo+ID4+IHY0
LjE5LjI2NSB0byB2NC4xOS4yNjYsIGFuZCB0aGUgbGludXgtNS4xMC55LWNpcCB0cmVlIGhhcyBi
ZWVuDQo+ID4+IHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIGZyb20NCj4gPj4gdjUuMTAuMTU0IHRvIHY1
LjEwLjE1NS4NCj4gPg0KPiA+IFRoYW5rIHlvdS4gSXMgdGhlcmUgcGxhbiBmb3IgNC40LCB0b28/
DQo+ID4NCj4gDQo+IFdvdWxkIGJlIGdyZWF0IHRvIGhhdmUgdGhhdCByZWxlYXNlZCByZWFsbHkg
c29vbiBub3csIHVubGVzcyB0aGVyZSBhcmUgdGVjaG5pY2FsDQo+IGJsb2NrZXJzIHJlbWFpbmlu
Zy4NCj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgVGVjaG5vbG9neQ0KPiBDb21w
ZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K


