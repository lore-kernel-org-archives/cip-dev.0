Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DAAC433FE
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 09:42:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.26580.1643276527056439020
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 01:42:08 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 20R9g5iB025510;
 Thu, 27 Jan 2022 18:42:05 +0900
X-Iguazu-Qid: 34tKDZwjjFjWxQqQxl
X-Iguazu-QSIG: v=2; s=0; t=1643276525; q=34tKDZwjjFjWxQqQxl;
 m=5e33axqxrwjFxEleM8MYvhBOltAorya4mvjyKTyMrcg=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1511) id 20R9g4jP011582
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 27 Jan 2022 18:42:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ6ulRwBTgO8hM8sr9NJ8iNOaa1YqvILMywTNL2bPTwQuy2hUYShhnCGZH0AKddiT5n2SVpGoGKzjTRvLN7KW7hKR3tJikvuCoA6kKx2JDS8WjeB0THVfinZqi7e4HxvvOEbKZEb9h5miTm3JxaUvwS1n5ULbVkn0VWHWGe8L/BxcrN3gwIi8ULdHobtQudA/vUdqVFUMoCmm+C4074O64axCWBOYgFfWSDURoIjyJavTr9gNSYsHozqkSCxO/VaWmbhPp62/b9viSgrk2WakEtPdERg4nWCxVkrL00fNvJtT8hnr7etFcF05mW/0OAQxAS3ObjuT1KUPFM+IJ9/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D1RT8Ld2WsEvH7nWLbLNYsdjnshjLB29h1aLWf8+tQ=;
 b=D2ZyrtqIDgPj4BcZ6WKfPHclNNmROslTumm+m3d71DerRq8Ao0aQhzhB9sgkqhPvniifcDvVRwcIxdTzoDPw+4Pk/HxArRamSSlVLPOHWbw4+n1aJNiFYvXgHosVgmZ3XB8UvfxbOVfSKPwkhDHy1y1xXHcKeLTumeAjUseF+/oIb5A+HwRqxGOk9cfuY8nxl8RWd2xKve6f7/R2pI3Ki9YGu+zBpNodjLut/+jwQ3xSi/aJKmISgC/fauFQhoMAxNMpizLj6tH0Q+K9e1r1e7VyX2nnecjFB+iOdeesX87Q+vT49kxSS872oWloRP52gst2+5UyLHXOwgeQZd27nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat External
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat External
Thread-Index: AQHYE1G1fbj13t6PCk6FFgEbVzpz06x2nPkw
Date: Thu, 27 Jan 2022 09:41:52 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB62525270B3D8156BCCAD05DF92219@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <b8e3378f-ccb8-0be3-fa09-0f8bdda671e9@siemens.com>
In-Reply-To: <b8e3378f-ccb8-0be3-fa09-0f8bdda671e9@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66131c62-0c5c-46c3-12ef-08d9e1793f7d
x-ms-traffictypediagnostic: OSBPR01MB1510:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB151014D791E15613A1959E9C92219@OSBPR01MB1510.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 B7cQxrVoUReDdLunwVe3CiMcLTsZRucYjW8T12zvIYQ1fK8v+N2WUso1E1zpA9oopXJlGDraLX1KPBn6F8Jrlx2/mK24q7/vzVzlRxeb2laNcQAvMQQ9hevefi01HZIRMVDlrk9w9fjzGNPVjyMQYF0RgbIN2U1GmZqaBxG9Akvlj6OUehBtK3VYYtC9zNCgJD6oPP4XG5hoNrE3RnuZpoSvI3BAboqCCgwl+19xYox17WXsYuhrRcvFRUlhZZ777XYWM91NEbmTRY3m1UWtSp+Y0qEx3oEQN6lqvMA8AGFdhBGEol5/utx8S7Ys7gEhvdU9aj7oOMP8YdI6obYZooJqI1tUAW4KDxCJs5KkIKYukCOGGUj92JaKahslkMintt1+8rIb2Mmlxl4/UXV4+j3oyT25CCz8MIQEsm48LmQLO4iuz62k1DACchCjqgPFf4XiVZASyLW3X662WHCImtydVY3nfbCdpW4MiWxpSWsEeYckDU8d7tr+7BerXDdJ+oR8cYoovCL2yS433F2+0MjmqemVlhsKHCCMWF8c4qIOopLpkjRcjHka0TZDedOSVZ0rPaUMkOBJk7Um7sG6F4o4AlIqyDaQx2fmikcHt8KNE+qNKjQGk0QqclmPOxXc//jh7Ssm9NWazFYDhweOsoNVNOOt5W2+BgVFIsYG3L5kv6Mym5/gc6kQdFtcP3rKqEyge8TdTUzT4wvTyU80qKwoXehuvceFE5TWCF80FPKpZEQVQEi6i4bGv9gDi66sTTENjJgT5x0jM8Xrt50fog0Mi3mmSD5OWgRYLqh8jdM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(33656002)(83380400001)(38070700005)(966005)(52536014)(7696005)(186003)(9686003)(53546011)(26005)(2906002)(6916009)(316002)(86362001)(55016003)(508600001)(71200400001)(8936002)(122000001)(8676002)(66556008)(38100700002)(66476007)(66446008)(66946007)(76116006)(64756008)(5660300002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dVZPanVKRmJCb2tnK3l0OHdzTFdiMnlTTDZwZ3hrV01odHBwRVJMdG5BNFg4?=
 =?utf-8?B?bUM0RGU3bnBjaWpxbUdreENGOHdVNkZGUCs2WHNNY2tWOGVhS0VsUjRvRXBw?=
 =?utf-8?B?ay80TlJ1OE5DekYwWDU4SkhKZFp5dGZCNlM3R2E2M2MyckRUeUdkemRSSTM1?=
 =?utf-8?B?c1RyUURCVURzR3lGVUFsbGpIL3N1L0d0c2FkNW9FZWxaWGJCczVuR1dCQUhF?=
 =?utf-8?B?amdjQ3hOcDBIZTVhS0d3ajFUQTJsOUNIaWFHNlJPVEV0S2FhQkhRbTVoYldm?=
 =?utf-8?B?a1dNNVFXVjBnQmc5cTR1N0Q4ZXhXUitqMXErVFJONFNaNjAxb3AxQkJDS3Fz?=
 =?utf-8?B?alRQbTB0NmRQV2FlbVNldEJDT3VKOGEyZkdlWTYrYzI2MG9jeVk1SjVNNmdS?=
 =?utf-8?B?NDU0b0Q1YmZTcXc0VmNuYWR3RkMzSmczSVpmMUxPaUFnVTFlczVWQ3FDSzMz?=
 =?utf-8?B?U1lzNVBuR3lJN0szd3NxQzU5U1pUSmRRQURMbTBBSzRraWxsRmRUd05qbzNY?=
 =?utf-8?B?OUJQemtmT2dYYTZJSGVkbm1GZ2FvMXhuaTdUQzNxN2xKYVRBeGxPTzlhOG9V?=
 =?utf-8?B?dCtYQTNWT1o4WDA4MVJjcWtlQ3ZVK2tqSE5GUmVoTUVZRTZpcmhVTGZNdVNT?=
 =?utf-8?B?d0ptQmhIcFZ5OE81WjVURmQ3Njd6L1MzUHRLb0ZXM2doN2JvMkhyMFE0TC9W?=
 =?utf-8?B?bDM5RnhmZThJY3RWMldsa25rMVRCWVZHcE5OZGlhYVdNZVkzd3FnYllXZGRR?=
 =?utf-8?B?c1VZNWVlRE0vdzM2TnEzMmtzNWJTNXpiVThNSlFIaW5xWUVpeDl3TWNvRDla?=
 =?utf-8?B?czJPUE9DTlhlR2RlLzZkQzFRNi82ekVwNkQ0cUpEUW0xRXBxODFoVWdPMmQv?=
 =?utf-8?B?ZnZaOTBFak96NTh3eWNTSUh3OVV5ZkNFeXZpK2d0dGU3QVF2MzdNSGpwNFdz?=
 =?utf-8?B?RytxcmZyNTE1UDFvbHJLZkV2K3MyYWxyREhoOS9VUGRqTjVEVUVINUFCSUtR?=
 =?utf-8?B?clhCZCs3K1YzcXdKUjZ6SDVFd1FhZzBiblovSG0rWXBRRk1NZUJ5U2dhWXVn?=
 =?utf-8?B?T3ExS2Juc3pWbE1OeTlDaERSeW9kd2NoZTJmbkdHSUJxODdYeGlCcG5FbkVI?=
 =?utf-8?B?aCtIY0htK01OSUswRjlXMGdvb2hHVlExZlV2OGFaeXdhVlR0dkMxYmRWVmhX?=
 =?utf-8?B?Qlhjem05SkpIZ29FR2RCOFdGN2pVRDdTVFJFQ00xL0JON0xpMDVMdGpvUXhW?=
 =?utf-8?B?clFkemc0RkJFUlh4M2Q2OFhGeEhJdklVQUJiN0QvYXVyRGxPL01qQzl4U0tT?=
 =?utf-8?B?c2Y3R0tsWndhNXk3M011M2s0Mk9WN3N3eXNrcEF0WHA2ck1aUUpWOXVUWWhi?=
 =?utf-8?B?TWg0OVFJL1JCa3dBTG1hQVQxdmZBczJuN2dEMlhwR0dUeE82cmxpMFlVZGly?=
 =?utf-8?B?cnVMT29CRm1Db054NUVIb3JDWU5vSHlxQm1EWW1URnQxbS9WazdEYUpqQ0pr?=
 =?utf-8?B?b0xSZmxqdndFeEZ2WmdNa3h3QzZDMlNxWHNuakJLaHZ3c2w4VWhkQjViWHJn?=
 =?utf-8?B?UXEvdlc3bGJyblkvLytITENQNVFTRjFCeS9ZT282ejZHV2lMSUc0NnRzRmVq?=
 =?utf-8?B?clJLWFpyRXZCc21jNWVDNkoxdzZBcS9WdFV3Z1NUUVVWQTJweGpuaFQ2eHdu?=
 =?utf-8?B?WGJzbkMwcGpRZkZpVlE2UjYyeXBaTzZRVGtPcTBPVktNNW1Fd0tKRi9QK1dn?=
 =?utf-8?B?OGd3YW9jM2ZFa2I4b2FySjFubUo3dHdjcllyS2Yzakk5aS9ZNGE4cEdXdHNj?=
 =?utf-8?B?bTl2cU5zWVVTd2h0eFBwNG9tMzcyT1lBQk85dUk4NHJQcnpRTTM1eW5VSmVI?=
 =?utf-8?B?VDFOZitnRUlxeUcyQTIzL0FpV1F3bHUyMWdMSGkrR3ViWTdWSFdCRVAwSXYx?=
 =?utf-8?B?YkwrRXNSRkFCVTZkZFBJakNITlFwTlpXL0xMTzUwK2ZvODJOR3MxKzBkTEVI?=
 =?utf-8?B?bVJnbEpCemIxbzdLTE83aTRzdlB0R3dqRnNLamdVam1iM2tQUjUwM2ovWlhY?=
 =?utf-8?B?QWtPSytERFZINEdpQlRLS0tuVStJVTMvVnQ3ck1pbmZYdnpxZjlQUWhnMzhF?=
 =?utf-8?B?TXc2WTBlUE5YRnZRd05yNmx4OE53YnpIeWY2cTJmVjNSNUl2OGJrQlJvRmV0?=
 =?utf-8?B?SnV6dExsSmkzQW9RVWQ0YXgzRHpwcU1pSGZjT0Z6bHZ1UzBCdms4dmY0RmxI?=
 =?utf-8?B?cm52ZmYrcUR5UGpLaEh2bmFhZGxIczBicDJ2aGN4cWFwTFZxS3R5Vy94WGlp?=
 =?utf-8?Q?Y1wJTPNqB2xKorpKVX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 66131c62-0c5c-46c3-12ef-08d9e1793f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 09:41:52.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 QdIsf7I0P6GW3cS0wSPrp01+5ScFcBlcHUmwjgRX6a34Gc//R+wgP8rpTI1NvNYShzPRDb5KrEB2WEExVh9iWsD6uYB4mWmm8UptdyjcaRsXFbBzxhZAIsQ3FGln5OS+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1510
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 09:42:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7499

SGkgSmFuLA0KDQo+IEtpbmRseSBiZSByZW1pbmRlZCB0byBhdHRlbmQgdGhlIHdlZWtseSBtZWV0
aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1c3MNCj4gdGVjaG5pY2FsIHRvcGljcyB3aXRoIENJUCBr
ZXJuZWwgdG9kYXkuIE91ciBjaGFubmVsIGlzIHRoZSBmb2xsb3dpbmc6DQoNCkkgY2FuIG5vdCBw
YXJ0aWNpcGF0ZSB0b2RheSwgc29ycnkuDQoNCk15IHVwZGF0ZSBpcy4uLg0KPiAqIEtlcm5lbCBt
YWludGVuYW5jZSB1cGRhdGVzDQogIEkgYW0gcmV2aWV3aW5nIDUuMTAuOTQtcmMuDQoNCkJlc3Qg
cmVnYXJkcywNCiAgTm9idWhpcm8NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZz4gT24NCj4gQmVoYWxmIE9mIEphbiBLaXN6a2ENCj4gU2VudDogVGh1cnNkYXks
IEphbnVhcnkgMjcsIDIwMjIgNDo0NCBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmcNCj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJUkMgd2Vla2x5IG1lZXRpbmcgdG9kYXkg
b24gbGliZXJhLmNoYXQgRXh0ZXJuYWwNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEtpbmRseSBiZSBy
ZW1pbmRlZCB0byBhdHRlbmQgdGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1
c3MNCj4gdGVjaG5pY2FsIHRvcGljcyB3aXRoIENJUCBrZXJuZWwgdG9kYXkuIE91ciBjaGFubmVs
IGlzIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiAgICAgIGlyYzppcmMubGliZXJhLmNoYXQ6NjY2Ny9j
aXANCj4gDQo+IFRoZSBJUkMgbWVldGluZyBpcyBzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDEzOjAw
Og0KPiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2Rl
dGFpbHMuaHRtbD95ZWFyPTIwMjImDQo+IG1vbnRoPTEmZGF5PTI3JmhvdXI9MTMmbWluPTAmc2Vj
PTAmcDE9MjI0JnAyPTE3OSZwMz0xMzYmcDQNCj4gPTM3JnA1PTI0MSZwNj0yNDgNCj4gDQo+IFVT
V2VzdCAgICBVU0Vhc3QgICAgVUsgICAgICAgIERFICAgICAgICBUVyAgICAgICAgSlANCj4gMDY6
MDAgICAgIDA5OjAwICAgICAxMzowMCAgICAgMTQ6MDAgICAgIDIxOjAwICAgICAyMjowMA0KPiAN
Cj4gTGFzdCBtZWV0aW5nIG1pbnV0ZXM6DQo+IGh0dHBzOi8vaXJjbG9ncy5iYXNlcm9jay5vcmcv
bWVldGluZ3MvY2lwLzIwMjIvMDEvY2lwLjIwMjItMDEtMjAtMTMuMDIubG9nLg0KPiBodG1sDQo+
IA0KPiAqIEFjdGlvbiBpdGVtcw0KPiAgICAxLiBNZXJnZSBrZXJuZWxjaSBzdXBwb3J0IGluIGlz
YXItY2lwLWNvcmUgLSBqYW4NCj4gICAgMi4gQ2xhcmlmeSB3aXRoIEtlcm5lbENJIHdoZXRoZXIg
Q0lQIG1haW50YWluZXJzIGNhbiBnZXQgYWNjb3VudHMgLSBhbGljZWYNCj4gKiBLZXJuZWwgbWFp
bnRlbmFuY2UgdXBkYXRlcw0KPiAqIEtlcm5lbCB0ZXN0aW5nDQo+ICogQU9CDQo+IA0KPiBKYW4N
Cj4gDQoNCg==


