Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC31C4345F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 12:13:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.15340.1714047179249512386
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 05:12:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 43PCCv6h1102534; Thu, 25 Apr 2024 21:12:57 +0900
X-Iguazu-Qid: 2rWhAUbYiqAcyzzHSE
X-Iguazu-QSIG: v=2; s=0; t=1714047176; q=2rWhAUbYiqAcyzzHSE; m=95CIwjeNGOvxr9ah38ZNKFf61AP0tlZc5eAX8A85QYA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 43PCCtqc3543417
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:12:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz2cSJ7tzgnKBKZRmIK9IXkV1AiapiNoGhqAMNK8CjC+EYNrxrj2fuNCbSEZxmzE26u29yPOWQKzwSMluvuI8uG/ieBXYF+iggbDvPHGdqSJH86el3O0ljtcW88ze0C15Ky2i1V8fZe51f4D+GbtP/XTcD+b9blYAcXnOn/CGgnfR4N+mfs8qGhAMVDMQb7OaiYl7zcbzM3xRnt8hUDM9EglrJY+VLb1buFQxJ08XxVR54cIqg0Q3Kj2kBYRUtwaqvyK0rOWmWzluOhApsVeFpL5nq2/Ax7DLirCGIaCb5vlDsu4FpOucM6mM40k1SSYR02pplCDzTTwmszB76kltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx5jQNUJd0qjSl/F/fkmiXJGgSSviPJyMqkO0D8smOE=;
 b=Uqx+0qKSw5tkdb2xXUbgccvvOaTWyxw+Dgqmb1N/C5TcdoQRilPRc8lbFv9DuQYL+1VNW73rUX1U711UrpViDJnGVq/Hx3q2r/IzIQVI2Y4iQqCQUduvshMNoTohgaOD/tXquW3LH3O5M1iUCQlih0enH6menO84lWQb9H+rU/I97J2KVTWIIRuhIOyGsO6Ph6jzAHm91Gw/NwhfJ7jphnLI3dWJpXSa5qiYANPgzO6sHPXy7rFELxPS3cE0zYOoadkHUkxk+kLkFWVol9198q7PRD/W664imOOiieivNSLM29EfJk1PSw8R+Duc8rFoJXWdBwCswZ2hZtrQHsypzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHaltugORAuhft2LkqHP5uNtaPcH7F45Nxw
Date: Thu, 25 Apr 2024 12:12:53 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388A0EC11DAEA9A56B5891792172@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <3283c176-3ed8-4808-92af-b5e16af941f2@siemens.com>
In-Reply-To: <3283c176-3ed8-4808-92af-b5e16af941f2@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS3PR01MB5608:EE_
x-ms-office365-filtering-correlation-id: 97cb4a6a-8d08-4cb9-0274-08dc6521089c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WitTRFpvV3IyYWVhZG40b2RVYmJianRCaUgrRWcvVHVUSVpJMTg1eStyUldU?=
 =?utf-8?B?VWdvcU9sZ0xRaEFPTzY3anhwbTIwQVZqVjFaYVkzdm9jSWxBdE1Sd2k0a2hW?=
 =?utf-8?B?MU1saEFVTnFnU1ZtclZLenFIa0VoRVgrdDU0RVlTWlhlcC93aDR1UXJETVk5?=
 =?utf-8?B?TytSVnJZZTYwRkp5ZmYzbTA3TUk5Ui9MSjFpYzNwS094V0VxeEFvUTRJVjhK?=
 =?utf-8?B?L0tkQ0M5T3NyVnBxNjdqRUkrTUI4OGpYc1lseGZ5YUZ3K3lTVmp3cVdJNFdW?=
 =?utf-8?B?SFh0ZldEeXR1dmppTXpuQmRZUnYyTVVhQVo5WXJxODNCY0FCZVVWUkVHcVV5?=
 =?utf-8?B?TzF0dy9RMTM0aXhkZU1lK1hoVHpKSWtuZ2hiUmx0MHVUSitEN2lWSzAyaUdu?=
 =?utf-8?B?aGpZNDhyeHdkWnVFcUM1NU16QkFKek51dHlQQXIxeEhCNTVwL1FxL3NPdVlP?=
 =?utf-8?B?SXVpUjliL0pxYUVaTmJHMXRoVFEvRnJvcnovQ3pkSG93TTJURjFFTFRYOElG?=
 =?utf-8?B?dG9wa3BjTlNJdjNwYndETDhuZEluWmFyaFBiWjRRci9LMHJBQ2lFRDN1dXZ3?=
 =?utf-8?B?TkZPN2xOSllYWDM4WEY0ZmpqWXdhMjREUTlMcFgzSC9KdlpTcG05Y1poc29j?=
 =?utf-8?B?clgwSXJZT0pFQkJXL3J0c0I2ditldzRtT1NrSkxza09sS1EyQ1paNm9sM1Jz?=
 =?utf-8?B?azQ3QTh3U1REWFNhT2ZpNDlyRitnQXJDTyt2RkIyNUVremlCUU9FSnVxV1Fi?=
 =?utf-8?B?eEYzbytnRjlZTCtPNDl2NDNWdHd6RXJzcFFjOExHUkN2K3pHWUM0bjlmWURR?=
 =?utf-8?B?czM0K0Y2cWplZDBuWWlxTVJkQjJ6T0wzWU9tZkpjRUhNbFRPVUtuMUVsZXdP?=
 =?utf-8?B?bHpTbWxtUlNjTThIeENSOExuSW5RSjVycHJGV01OWTNiN2p4RTgzTkUwQ3Nk?=
 =?utf-8?B?a3oyZzFOd3dNRjRYYzBwU2habWFETU9rUnVnQ0RKeElROXpyZytYNitRa0th?=
 =?utf-8?B?REhadExxRjZxcWo3TjFLUHRVLzBBSWtCb3NHeU5sZjhtZ0xLNUlPczJDMm1M?=
 =?utf-8?B?ZThTanlGQ2VpTTZqdzc3N01nTmRWYjA4ZlBKVUpxUkVWbC9TL3FDdFlwb1lQ?=
 =?utf-8?B?MUtvWTlsZjR2YXI4WTJRTmRha1h3Wm00NXltRXFNVzlRU1V4QW41QkR0M1J0?=
 =?utf-8?B?Rno0Q3c3UnBEa3lhWkxEczlIanhQWVFwZW1Xd0JmUE5YajJjMXp3NkJPejRN?=
 =?utf-8?B?cjhMQWtNNzhPRDErYkhKMzV6UCt4QmZKaTVDZ3Urd2FKNGw0WTJvMEpYdjhz?=
 =?utf-8?B?MEE1WnVqd3pkUElNMUpIdHdleWIzL0s5RGxvSThhc0xYRE1qOW9ZUFgyY3A3?=
 =?utf-8?B?MFE4bVUvRHlpK3NvQ3orSXUvaHZKUnUvYTBKMjRvcitqRURqYWMxUTg5eENS?=
 =?utf-8?B?TjB4bm4ybmFvSHo2UmNwaU9oemxtMmVDQVRiN01uRjk0K3ByUFhwakM1a3U0?=
 =?utf-8?B?RVAvQlFSU28yRnlobWNkTWpXN1p0RnhqMnBzVGFMVVhKb0NjUloxb3h2RUwr?=
 =?utf-8?B?SHhZUFZuMkhaQU02eFBKS3Qwa3JaUlhiZlJ0R2V5bkRUMjhUdmtEWkhUemZW?=
 =?utf-8?B?Y0tIL3ZQU1hoTkZpRGg2UmFQODE2b3R3a3krUGo4Zmp4NFZ2d0tZY2xUUnJZ?=
 =?utf-8?B?YWlZMHdQZlRLY0JMVTVyajZMM2RsN25TaEVnSGRaRTdmWnk1Y2ttRzlBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UWdzd1NBYk5jT2d3TFY0M3BGT1IrRDBkQkRyNnJWcitTeStsbG9ta2szbHc2?=
 =?utf-8?B?MlIwM2EvcFhEOC9aVXNWUkJoc2VTcjJDdXl6UFlINnhlU2NuK2laeWNFdWcx?=
 =?utf-8?B?WGlzVUowU280aEhRUDlHWlJSMXlHVExZa2tZaCtoeHJQNnJhYVoyZFI4QzVB?=
 =?utf-8?B?a1I3a0tnZERZRWM3ZytQQWF2NjJwQzB0QkpIMXdVOXFGc3VEQ2pXeW52Qm9T?=
 =?utf-8?B?SkxzYitkdHB6Sm15UWZDWGJabERUazlIbW8vUWVxYnVBdFR6Vit2SEtiZ0Fa?=
 =?utf-8?B?Q2dDS3NYc290Z21aMmpPOUd0WTV2Z24wMlRPTU01N0pDMWhiNENnVkdmY2VO?=
 =?utf-8?B?SGhRZ2Rxa0wvQmI0SHJ0QjI1bVV6Rzd2cXhDU2dZK3o1MkpBQURVNXhpck9x?=
 =?utf-8?B?VWdUU2R5bGtSeHQ2Uzl2c2RkQVBiOTFRYnlDanhDbnZ2d3JNWEN6ejdoNTBG?=
 =?utf-8?B?bGVEZXJlaXVyZ1kzblNSV2w2UFN1NGp5bUs2b3krTEhoT3V1elBRKzlJNTRt?=
 =?utf-8?B?WWFtV3JidU1NaGJVSmtrbitkRXMvZGVJbllzMG93TGp5ZTlNc1RwU3JmZDlF?=
 =?utf-8?B?aGhRUGpiZ0VvVzZaUGkvZ3Y5ak45dDNJL3UrQkMyVmRJWkZJSW55bnF0T0J5?=
 =?utf-8?B?bDFlWk9XT3FwNHdCYVRtN1ZZb2ZyY21XdlBZakN6Y0lrRzh1TDcvUDlha3BL?=
 =?utf-8?B?OE9NMkM3aWQrWURWd21kVVNuTkFWSW9zZFA5VlNqcTNNWDJoNk11MHR0bU1F?=
 =?utf-8?B?ZW54ejZ0aGRKN3lsUjU1alZBNmtHakp0aHlDMG9pWXpYZTN3RGdxMytiQk9i?=
 =?utf-8?B?TFFob2tVaFpRaVgxYVhLSnAzZFFrMXFRY05MOW9yemFzL0lBbVI2VDVuRld1?=
 =?utf-8?B?azM2ZEVFTUk3Q0cvQ0ZtQksyZS9yZWxadmNjclh5S2w3K3YrUE5HVFFjMUdm?=
 =?utf-8?B?Y3hmcGpXdG5tdkFhRHowdzZxUzVQYTBtUjRYWmk2UFg4akNoSmcrV3pZZVk1?=
 =?utf-8?B?NnJCQlNYdjZidHVZTFBsL0ZiYnA5Uk5FdnZ4eUdUbGdhYTN4WkUzb1Y2ckVJ?=
 =?utf-8?B?SGc4cjFvMVJscFgrN2RaOUlTOVNvcVlXa0cwTWhMRG9BakxXM1U1cEYzRW9B?=
 =?utf-8?B?cUVHM2hRNzVIYmVZZXQ0K2NNMXN6YlBGYzB2K3o3Uk5GU0V1Y1plV2hoSWty?=
 =?utf-8?B?OTFiVkw2NHVHVGs4QnNoY2JoVmxDdzJ6amd0ZGtKWGl1eWhnczMxVkszY1J5?=
 =?utf-8?B?aFAxUkFBcC9jd3k5S1BGZ2ZUMFVyTmZHRm1pY21yU2pmd2NlOXJXRGI3ekxt?=
 =?utf-8?B?NlV6emUxWWZMaXljdlRjbmNyaFV0VVF2VkFaTVcrcXBCZ1JHczJvYXFHSTg5?=
 =?utf-8?B?VUFyOUtzUHVQLzVKWGhMeVBjb2l6d3VzZGFzMC81WGgyczFKdDE3U29XOUJW?=
 =?utf-8?B?YVFsZDV3NFYzNEhlK0dKTmlhWkpQcDkydjBDeHgvQ0l3bFlidkxid0Raakd3?=
 =?utf-8?B?TFRhZEQzQWZTT0RUUUVjVk44cHVhUHBXck4zYmpIS2xVOGE0aHl3RGFmYVhO?=
 =?utf-8?B?czVWeWlobFdZZXVFQzRIZVR3TWZCN21YZ1N2dGVrUHlMVzE4MnRZb09QY1gz?=
 =?utf-8?B?OWxNY3pzcVFtdWJxZkhoRXdhd29maEx1UHkzVkVpcmVVN3FzTzJIT0hmc3Nr?=
 =?utf-8?B?VkV4cS9RS1BlL2NYUStQWGdobWFldzVCOE1neE02R0FLaFc2dEtRME1BeWpz?=
 =?utf-8?B?a2N3b2M5bExvNkRncTBIK3lBaTdpUTN2QndXaFdQTjZoTFBPdkV4V2ZRVUtW?=
 =?utf-8?B?WFVENHR0RTIvVWNiSllKQkU3Y2V1UlVqNS93YzB2NkpNTTNVb1pXZ0xnOHh5?=
 =?utf-8?B?RkN4b2tFb3BYZXpWM0M3dWEwcFZvckJQWldqWXludzJvL2UreHlWbFhYVlJl?=
 =?utf-8?B?RG5vSCtKNmU1OFF1MTllSTF4cHRaZUhYdE5ScHNlMTQxRURmd0F5TzBSNEtn?=
 =?utf-8?B?U0RrZiswOC9ROVZBdHNtMncrM0syRnE5QkFRTDZORkV1VTByMjVkWnUxL3ow?=
 =?utf-8?B?alR6NGdwcXJWbW00L3p4VXZzc3VNUjFrQ3lnWVd2ZTBRQzJkL09vWU9BUGpX?=
 =?utf-8?B?U2VnaEFEM3BBQ0Y1L281N0Jvakt1NHVKUDBXNkpmcEFGc0RoaWUvc3E3MkIz?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cb4a6a-8d08-4cb9-0274-08dc6521089c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 12:12:53.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSmZN4p8sx8tvjJg+uK5m6LmascBNK1nOdLnnK7BlWjNSNlayR3sFDLrXHjISGDvpuKxncbwbxJLbsT8jMskpyEhyvCfiXv+mgT1t4ktzRzcRbDfDmkpKjsGyQzkGWdT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5608
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 12:13:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15766

SGkgYWxsLA0KDQpJIGNhbiBub3QgcGFydGljaXBhdGUgdG9kYXkncyBtZWV0aW5nLg0KDQo+IGxp
bnV4LTQuMTkueS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVh
c2UgZGF0ZTogRnJpIDIyIE1hciAyMDI0IDA4OjUyOjAxIEFNIFVUQw0KPiAgIGxpbWl0IGRhdGU6
IFN1biAyMSBBcHIgMjAyNCAwODo1MjowMSBBTSBVVEMNCj4gICBTdGF0dXM6ICpMYXRlKg0KDQpJ
IHVwZGF0ZSBsaW51eC00LjE5LnktY2lwIHdpdGggdjQuMTkuMzEyLg0KDQpSZWdhcmRpbmcgdGhl
IGdlbmVyaWMgbGludXgga2VybmVsIGNvbmZpZywgSSdtIGN1cnJlbnRseSB3b3JraW5nIG9uIGNv
bXBhcmlzb24uDQpJIGFtIGdvaW5nIHRvIHJlcG9ydCBvbiBNTCB3aGVuIGl0IGlzIGNvbXBsZXRl
ZC4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjUsIDIwMjQgMzo0MSBQ
TQ0KPiBUbzogY2lwLWRldiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQo+IFN1Ympl
Y3Q6IFtjaXAtZGV2XSBDSVAgSVJDIHdlZWtseSBtZWV0aW5nIHRvZGF5IG9uIGxpYmVyYS5jaGF0
DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3
ZWVrbHkgbWVldGluZyB0aHJvdWdoIElSQyB0byBkaXNjdXNzDQo+IHRlY2huaWNhbCB0b3BpY3Mg
d2l0aCBDSVAga2VybmVsIHRvZGF5LiBPdXIgY2hhbm5lbCBpcyB0aGUgZm9sbG93aW5nOg0KPiAN
Cj4gICAgIGlyYzppcmMubGliZXJhLmNoYXQ6NjY2Ny9jaXANCj4gDQo+IFRoZSBJUkMgbWVldGlu
ZyBpcyBzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDEzOjAwOg0KPiANCj4gaHR0cHM6Ly93d3cudGlt
ZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjQmDQo+
IG1vbnRoPTQmZGF5PTI1JmhvdXI9MTMmbWluPTAmc2VjPTAmcDE9MjI0JnAyPTE3OSZwMz0xMzYm
cDQNCj4gPTM3JnA1PTI0MSZwNj0yNDgNCj4gDQo+IFVTV2VzdCAgICBVU0Vhc3QgICAgVUsgICAg
ICAgIERFICAgICAgICBUVyAgICAgICAgSlANCj4gMDY6MDAgICAgIDA5OjAwICAgICAxNDowMCAg
ICAgMTU6MDAgICAgIDIxOjAwICAgICAyMjowMA0KPiANCj4gTGFzdCBtZWV0aW5nIG1pbnV0ZXM6
DQo+IGh0dHBzOi8vaXJjYm90LndsLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWVldGluZ3MvY2lwLzIw
MjQvMDQvY2lwLjIwMjQtMDQtMTgtDQo+IDEzLjA3LmxvZy5odG1sDQo+IA0KPiAqIEFjdGlvbiBp
dGVtcw0KPiAgIC0gcHJlcGFyZSBibG9nIGVudHJ5IG9uIFNMVFMga2VybmVsIHN0YXRlIGFuZCBj
aGFsbGVuZ2VzIFtKYW5dDQo+ICogS2VybmVsIG1haW50ZW5hbmNlIHVwZGF0ZXMNCj4gKiBLZXJu
ZWwgcmVsZWFzZSBzdGF0dXMgWypdDQo+ICogS2VybmVsIHRlc3RpbmcNCj4gKiBBT0INCj4gDQo+
IEphbg0KPiANCj4gWypdDQo+IGxpbnV4LTQuNC55LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQo+ICAg
bGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBXZWQgMTAgQXByIDIwMjQgMDg6MTQ6MjAgQU0g
VVRDDQo+ICAgbGltaXQgZGF0ZTogRnJpIDEwIE1heSAyMDI0IDA4OjE0OjIwIEFNIFVUQw0KPiAg
IFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNC40LnktY2lwLXJ0OiBpbnRlcnZhbCA2MCBkYXkN
Cj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IE1vbiAxOCBNYXIgMjAyNCAxMDoyMTow
NCBBTSBVVEMNCj4gICBsaW1pdCBkYXRlOiBGcmkgMTcgTWF5IDIwMjQgMTA6MjE6MDQgQU0gVVRD
DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51eC00LjE5LnktY2lwOiBpbnRlcnZhbCAzMCBk
YXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IEZyaSAyMiBNYXIgMjAyNCAwODo1
MjowMSBBTSBVVEMNCj4gICBsaW1pdCBkYXRlOiBTdW4gMjEgQXByIDIwMjQgMDg6NTI6MDEgQU0g
VVRDDQo+ICAgU3RhdHVzOiAqTGF0ZSoNCj4gbGludXgtNC4xOS55LWNpcC1ydDogaW50ZXJ2YWwg
NjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBGcmkgMDEgTWFyIDIwMjQg
MDg6NDk6MjMgUE0gVVRDDQo+ICAgbGltaXQgZGF0ZTogVHVlIDMwIEFwciAyMDI0IDA4OjQ5OjIz
IFBNIFVUQw0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNS4xMC55LWNpcDogaW50ZXJ2
YWwgMzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBXZWQgMDMgQXByIDIw
MjQgMDQ6NDU6MzUgQU0gVVRDDQo+ICAgbGltaXQgZGF0ZTogRnJpIDAzIE1heSAyMDI0IDA0OjQ1
OjM1IEFNIFVUQw0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNS4xMC55LWNpcC1ydDog
aW50ZXJ2YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBNb24gMDUg
RmViIDIwMjQgMDU6MjE6NDUgUE0gVVRDDQo+ICAgbGltaXQgZGF0ZTogRnJpIDA1IEFwciAyMDI0
IDA1OjIxOjQ1IFBNIFVUQw0KPiAgIFN0YXR1czogTGF0ZQ0KPiBsaW51eC02LjEueS1jaXA6IGlu
dGVydmFsIDE1IGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVHVlIDAyIEFw
ciAyMDI0IDA3OjU5OjI2IFBNIFVUQw0KPiAgIGxpbWl0IGRhdGU6IFdlZCAxNyBBcHIgMjAyNCAw
Nzo1OToyNiBQTSBVVEMNCj4gICBTdGF0dXM6IExhdGUNCj4gbGludXgtNi4xLnktY2lwLXJ0OiBp
bnRlcnZhbCAzMCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFdlZCAwMyBB
cHIgMjAyNCAwOToyOToxNCBBTSBVVEMNCj4gICBsaW1pdCBkYXRlOiBGcmkgMDMgTWF5IDIwMjQg
MDk6Mjk6MTQgQU0gVVRDDQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0K


