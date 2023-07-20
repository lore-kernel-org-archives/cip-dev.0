Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BF8EB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 11:05:35 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.99])
 by mx.groups.io with SMTP id smtpd.web10.10321.1689851129216274304
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 04:05:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Q/LGjKSe;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.99, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYLrD3hUdQCsH16ICaUDIkcquK/Tt+Zg5oWRHpKDdYd1dZJia+yEunTzAfSRwUYAOs470WWixbFaOLuTuA7YHvsa1RYLT1C2GPTxu0yWrBZxQ4HBY2NX9wG5eT9zFHBqny6hX9uTmQwfP1rZZBP2Vn4za7BwmFXOXfmM2hGXGhBcmeXRYPwcFIw+h8v1k09sapW/hLMFfujZLatQ/XW9xeqZDeyNkyOMZftpEGaHNhQowyIhgy01S6qly1AKAZ4Ugibu1Rd97K7HQESzmsxaO13AAeMVFb5Nse78PPmCBm8uI8cSzKiHDF/JhKhYl4ix8XKrGRjt9KMm5x4Doh0hYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CEeE23s13Yo05XdlI7DjOqJ27NSbP615jZLi6LNP6E=;
 b=ZnSO+YWSlOLwc5rkvEAC056qiIlImZEiDOWjHgT5n81imcA8cB2Am51vcG4TuVvNQZby4Rrxz3cGS27YF5SqCVkzL5a+fOxDuJCBFkF2ffDliLoNlQOC+GPTz9QvgfKtzrFnnEmaZR8R1rAGb4fXvhut8KTVbKOk6bUcPQYneran/DEHWgy3HGaKE2n6oGK1H3bZ4+nh476hFKaH6m6Mq/7Vs0xgITrixyXSXoxM27ybBNqY3EwWGViq2ihCZBU9XWvx2QcJf1DK7ZtToESyg8AfKJtBknJER/MZJoFMCp8MJClhF0MuMZbgeJovCqIFWGqLEI/djNjXDPuUor5P/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CEeE23s13Yo05XdlI7DjOqJ27NSbP615jZLi6LNP6E=;
 b=Q/LGjKSegTAWX59KzInBV8wCK8wiFY7EhRBxaNRGjepaCGJudky4wguCJxCBpN4uHHCzZUGax9GSZcMNJ1NLC4DGfWSUsQoNPDGSmZsbnQRRVXB/Q2lCms8zP3lDy17fv7dyrSG7MrMfdgEOt8pZmePwz3qnHmPj0n4CFCQL/9o=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 11:05:25 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 11:05:25 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/13] Add RZ/{G2L,G2LC,V2L} MTU3 support.
Thread-Topic: [PATCH 5.10.y-cip 00/13] Add RZ/{G2L,G2LC,V2L} MTU3 support.
Thread-Index: AQHZuYEJEuNG+IqLRUKp+plQmyo6Y6/CbmCQgAASrpA=
Date: Thu, 20 Jul 2023 11:05:24 +0000
Message-ID: 
 <OS0PR01MB5922B9D8B80CDD4FFDAA7E30863EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420FA83C5CFA534288D54EB923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9420FA83C5CFA534288D54EB923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8124:EE_
x-ms-office365-filtering-correlation-id: fba7a98c-6486-42da-425a-08db8911380f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DzH+MtR/zVtMyeBe6Lv7Q7kXwNBm4D7QeDhVqnpSVt2cGCkUaUoE9N/p8VfXotD7byg3KG8zZ2xXW9GHllsDl0GOC1OqqNgt3Y5Cz2SE4UVhV4P3v+mSHYa4VBX5HQYP3bXbl3E6M8jyBdPy2iPjJdcjesn4rPXyS4c0RXTghadljw0N78d57tc54yMVAie/eHPTgUzcWTomLVzb/AP1vUo1ZuCRYHcjcNWKCHpORJFARq+YTdW8jdtYz/y2vxPpl5vM0+CvkYDjIrz49Lzo8cY709+ci+DPV+7V++7U1uT3u+jzW8FzXGrCmcMPwaxwyIBHGEHfQpY/+EOseH5+pOHb04Nlw/GFCi7kmkFROIH1hZPOWejTm0rYViPCkA0i9sL91IKlAtX6m4CbJIF6bMb1QB4+inJiee+gVfom0EhjLdTIfPzxj7LwOP5Uerac8NGKtUNEcxsS68qbpozoFJjBzWBMp0MxzNbKBvLmaf38o9A/6j3uhGYZXaAWLCkzWFehvhRdjh/zz/TDfdxoD3eg/pvCalJ/b3NR6HDMrA5K9rF/KHAVFKceLWYLEYA9vOCcMf5g4dHVQFJudhkRUkQkB85mnktkwO66Xebv3HfWzEZ14W7y63RH8O7pCjCT
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(53546011)(107886003)(478600001)(110136005)(7696005)(9686003)(55016003)(186003)(6506007)(26005)(86362001)(71200400001)(122000001)(4326008)(66446008)(66946007)(66556008)(64756008)(76116006)(316002)(66476007)(8936002)(52536014)(8676002)(38100700002)(38070700005)(5660300002)(2906002)(41300700001)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c0RHMFdYaGh5Qml1c2k4RHJqVEpIdk9wSHIrWmZXQTVkanVHOHBuU01tOXpq?=
 =?utf-8?B?VnJpYVJYUXdid0lnbHpwTVBqVDhxbCtFN2VzWGZVZXBVeGZTRUQvcVRmbk5v?=
 =?utf-8?B?L0V2OUdiM0traXVzbnB1cElLSGJ1YXl5YW9Cc3NiajE5eVlyRks4MzZhczhh?=
 =?utf-8?B?MEdEMmtxUUdlblBidmZrL29VU05MVFpFdS8vaVRxK3dDeTRqN1NuNzZxQkxY?=
 =?utf-8?B?ZDlnVFRoQ1hNOFg1VWUyUjBPL1Q3N2RJNjVzeGt5ME9mVDQ2enlQeUhjT2JZ?=
 =?utf-8?B?S0tCRmwvUkQzaElPMEkzditwVG1IdVF6L2ZXeS9oSnNpQ3dnbmJMUUhLdzJE?=
 =?utf-8?B?ZXdTbXNTckdOejlRVHFINmQ5cjVueCtCdWVKNnJCY3BJRnFYYVNrS1FaV3NT?=
 =?utf-8?B?V1kyckhjK1UyeFE3OG9qYytuS2hSTndrczA5UFNlRXVIYWJGcE83VlBOUUpr?=
 =?utf-8?B?c1lDM1N1Z0Y0SHhGQ1VwYlRleGhYRytkcEZ4SnZIOHZibGUyNExmNnN2QlBl?=
 =?utf-8?B?SXNmTlFHT1ZBUFAvdWNuQnhvb1ZadHhsdWhaOFJidlNUNExDWldPajZXK0Rp?=
 =?utf-8?B?NWVTUndBdEo3Ti9UN0xzUWxXS1haNm5XR3MxTUx2NVJ2S2ZjN2czb1l1NHR1?=
 =?utf-8?B?SDR2azNSNkUxZjdSTDZRQ3RrQzgrZW5NdWM5YlprVU0wZ010bDUzQVNhYXJq?=
 =?utf-8?B?alRWTzMrZWxISFgwMWkwZ3JSeFdSdDUvNFNLNGo1OTVGQVFXc0ViOVMzTjFy?=
 =?utf-8?B?MlFrNVU0UFJrWm9uUnQ2TGZpV2gzb3ZCTmJyOHJPNS9Wd05ERnVGcFl1ZURl?=
 =?utf-8?B?S3RBak45U2VJOS9pZVUwd3BDQ3N1bC9PWHVJOFhLRW8walRBM01iWUgzb2Nv?=
 =?utf-8?B?WXNMOXJrSTZ2UWgzaG1WU3lNYS9DT1A2T2VGa3ZnMlB4MWh6L1VEYkF0dmhR?=
 =?utf-8?B?RDJNNkIyUkthN3pnZ0hHZmdkQWxNYmg1T011cTNxVUdlRk1yL0lSRkJlUzJP?=
 =?utf-8?B?RlN5Q2hMWk5GNzFLZVF1RjNkOTBZYXRoQjl5bGE3WGRDVk85NjVZK2hvTE1v?=
 =?utf-8?B?am1nejl4R01sNThXc200YkdEbVJGbk5rZXoxMG9lTk1KVEVkaFRneVBQZ0FO?=
 =?utf-8?B?MTgwNHVwU2hDeWJGVGp5TFBDdm4wbHZncEpzQlFRaldxR1o2S1FLdjdSdUJt?=
 =?utf-8?B?Y0JRRzgyNDE1TWZ4TU5DMEVuRW1MZDhOR25neXNoZmdLVUZMV3hLRVljblV1?=
 =?utf-8?B?SHhpOEhDQUd2VTVtRW1wUkZIb2dxcVlJUElMZUJFQStzQUUyNitIWDU5bG1x?=
 =?utf-8?B?QUxJeno3anB1WmE3NUoyVEtnS3RJdHBPc3ZpSnpGS2pxTnR5WmhMNlE5NEVV?=
 =?utf-8?B?NmNIeXpTb2hGS1Fkd21vRXBiTHgzdXFLUjdIcDNWbmtsN0VSVi9vSER4MGxV?=
 =?utf-8?B?ZXBvSnNIZ0tES1NwTm5GSEd5azhGNGdoTGZqdWtjUlp1a2ZzRXlEcU5DYTlE?=
 =?utf-8?B?QzA2SlVkRCtMbmZVSFB1a2lSUVNNMHhvL05mQUpyVnZtYjFSc05VTkpIcHh3?=
 =?utf-8?B?ZmxxL2F0OWxnQXZCRFNkbTZOS3JuVWVEdzV1cEhjbTg2QXpuWW1kRUJDanNW?=
 =?utf-8?B?V1RERC85MWxjREI5Z04vOE16S1gwT0haYmo0TnEyQ0lFUEpxRU9zWnBEa212?=
 =?utf-8?B?Q3BSY0lvWlU4dmZFMGU0b1BRd1pVT24yZzkwL25TdDROZWkvRStnOXloTU1x?=
 =?utf-8?B?bEhJN0ZIbk5LNVQySmpPQ3ZFVmJsWHNSMUY1NHk3eGYvelRFRnhuNEZieGlG?=
 =?utf-8?B?OHJ2QzFTWVkxZEJJS0FST3I1eG5lY1dWVjZqeUNHb1hNV3FtUVB1RGFRYnRI?=
 =?utf-8?B?OGdzSGZsVzNnay82MVRqNnpxam5QYUI5bHoxZS84QXo2MXVSSldwbEdESDRF?=
 =?utf-8?B?dDBGL1luRGdPNFVhSVlXVnRGNS9EeW5WN05OVjd2N0svYXY1cndvY1h4MDNG?=
 =?utf-8?B?Y0hoempZNEVoZllIVkR2UVJ2b3NvV01DdTlGMjBQdEZ6WVhuK0lLM3ZROTkw?=
 =?utf-8?B?d1o3ejFFV1p6UXkrV2RFTVV3V3pnR0dOT0taMjh3V2dodEFJNStoRE5leXox?=
 =?utf-8?Q?w9MoUi/qUJsXQ9Ba29vJzRapY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba7a98c-6486-42da-425a-08db8911380f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 11:05:25.0454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3Llm55vC8psSSn8VjANMN3MgUpejtMUL55U+DA7UTnu0+Sr7JeTYDy+c60GCv6RXBROZ4cCK6sn+ZQ173Qy2+rs6O+g5yLnGkgMAMHD4ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8124
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 11:05:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12462

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4g
U2VudDogVGh1cnNkYXksIEp1bHkgMjAsIDIwMjMgMTA6NTkgQU0NCj4gVG86IEJpanUgRGFzIDxi
aWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLQ0KPiBwcm9qZWN0
Lm9yZzsgcGF2ZWxAZGVueC5kZQ0KPiBDYzogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0
cm8uanpAcmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggNS4xMC55LWNpcCAwMC8x
M10gQWRkIFJaL3tHMkwsRzJMQyxWMkx9IE1UVTMNCj4gc3VwcG9ydC4NCj4gDQo+IEhpIGFsbCwN
Cj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gU2VudDogVHVlc2RheSwgSnVseSAxOCwg
MjAyMyAxMTowNiBQTQ0KPiA+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdh
bWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqENCj4gPiDvvKTv
vKnvvLTil4vvvK/vvLPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBh
dmVsIE1hY2hlaw0KPiA+IDxwYXZlbEBkZW54LmRlPg0KPiA+IENjOiBCaWp1IERhcyA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+OyBGYWJyaXppbyBDYXN0cm8NCj4gPiA8ZmFicml6aW8uY2Fz
dHJvLmp6QHJlbmVzYXMuY29tPg0KPiA+IFN1YmplY3Q6IFtQQVRDSCA1LjEwLnktY2lwIDAwLzEz
XSBBZGQgUlove0cyTCxHMkxDLFYyTH0gTVRVMyBzdXBwb3J0Lg0KPiA+DQo+ID4gVGhpcyBwYXRj
aCBzZXJpZXMgYWltcyB0byBhZGQgc3VwcG9ydCBmb3IgUlove0cyTCxHMkxDLFYyTH0NCj4gPiBN
VFUzIGNvcmUgYW5kIFBXTSBkcml2ZXIuDQo+ID4NCj4gPiBBbGwgdGhlIHBhdGNoZXMgYXJlIGNo
ZXJyeS1waWNrZWQgZnJvbSB0aGUgbWFpbmxpbmUgZXhjZXB0IHBhdGNoIzExLQ0KPiBwYXRjaCMx
My4NCj4gPiBUaGUgdHJpdmlhbCBwYXRjaGVzIzExLSMxMyBhcmUgY2hlcnJ5LXBpY2tlZCBmcm9t
IG5leHQuDQo+ID4NCj4gPiBCaWp1IERhcyAoMTApOg0KPiA+ICAgY2xrOiByZW5lc2FzOiByOWEw
N2cwNDQ6IEFkZCBNVFUzYSBjbG9jayBhbmQgcmVzZXQgZW50cnkNCj4gPiAgIGR0LWJpbmRpbmdz
OiB0aW1lcjogRG9jdW1lbnQgUlovRzJMIE1UVTNhIGJpbmRpbmdzDQo+ID4gICBtZmQ6IEFkZCBS
ZW5lc2FzIFJaL0cyTCBNVFUzYSBjb3JlIGRyaXZlcg0KPiA+ICAgYXJtNjQ6IGRlZmNvbmZpZzog
RW5hYmxlIFJlbmVzYXMgTVRVM2EgY291bnRlciBjb25maWcNCj4gPiAgIHB3bTogQWRkIFJlbmVz
YXMgUlovRzJMIE1UVTNhIFBXTSBkcml2ZXINCj4gPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI5
YTA3ZzA0NDogQWRkIE1UVTNhIG5vZGUNCj4gPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI5YTA3
ZzA1NDogQWRkIE1UVTNhIG5vZGUNCj4gPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzJsLXNt
YXJjOiBBZGQgc3VwcG9ydCBmb3IgZW5hYmxpbmcgTVRVMw0KPiA+ICAgYXJtNjQ6IGR0czogcmVu
ZXNhczogcnpnMmxjLXNtYXJjOiBBZGQgc3VwcG9ydCBmb3IgZW5hYmxpbmcgTVRVMw0KPiA+ICAg
YXJtNjQ6IGRlZmNvbmZpZzogRW5hYmxlIFJlbmVzYXMgTVRVM2EgUFdNIGNvbmZpZw0KPiA+DQo+
ID4gTGFkIFByYWJoYWthciAoMSk6DQo+ID4gICBhcm02NDogZHRzOiByZW5lc2FzOiByemcybGMt
c21hcmM6IEluY2x1ZGUgU29NIERUU0kgaW50byBib2FyZCBEVFMNCj4gPg0KPiA+IFV3ZSBLbGVp
bmUtS8O2bmlnICgxKToNCj4gPiAgIHB3bTogQWRkIGEgZGV2aWNlLW1hbmFnZWQgZnVuY3Rpb24g
dG8gYWRkIFBXTSBjaGlwcw0KPiA+DQo+ID4gV29sZnJhbSBTYW5nICgxKToNCj4gPiAgIGFybTY0
OiBkdHM6IHJlbmVzYXM6IHJ6ZzJsLXNtYXJjOiBVc2UgcHJvcGVyIGJvb2wgb3BlcmF0b3INCj4g
Pg0KPiANCj4gSSByZXZpZXdlZCB0aGlzIHNlcmllcywgTEdUTS4gSSBjYW4gYXBwbHkgaWYgdGhl
cmUgYXJlIG5vIGNvbW1lbnRzLg0KDQpUaGFuayB5b3UhDQoNCkNoZWVycywNCkJpanUNCg0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0c3VAdG9z
aGliYS5jby5qcD4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gICBOb2J1aGlybw0K

