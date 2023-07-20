Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5343BEB64DD
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 09:59:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.9297.1689847154374890409
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 02:59:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 36K9x84H263880; Thu, 20 Jul 2023 18:59:08 +0900
X-Iguazu-Qid: 2rWhW3wiOaTi229GqQ
X-Iguazu-QSIG: v=2; s=0; t=1689847147; q=2rWhW3wiOaTi229GqQ; m=H6VTRtWrc7df1MTCqJi7nRnLqJLdCWnPJOSQRuOUNBA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 36K9x7Oe3561581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Jul 2023 18:59:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzFUGlrpJXyp3efa/ODiDR0mjM6wlV4yH39rHOu9Tf1BE4ve1Yf1gPLe8bguTsCWuePtmPAAuZfNYzFHnBlc46iFukHXwQ5T+MOPObHf+BlQwhmBuGM995cxUcqNQ4uhw3Kkn4DsjcjyZiCoJvrrZaGizEJnVq3kCMR0vF1dTImXKZiSQBSydvCu1UZdJGOZNKk4O5QFBPd20UaAX3Ti3G9WLrHfMRHf05s35YbIaOTyqsVBRc2YjxeIwOW4+K0m9CW+/VuSTy9Y2bXr1RM3CBGZ4PnRxchzy+UeQpSWFpR03uTQLY/9/6HeyJvsGBLEcmB11SU32163Nmsvx+oNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPzwEkxoDW6YBj009l3tFHzt9F7WmyqSDPYTfXimfbI=;
 b=nbBZkcE0xwUpFXFqT28kUBpIcSHx6wKPRlbmJn9/c1NVp/wUlHXQMQZnw9Zz3A7hBfVPoq/qGBbecvCuZ9ElWAW/amRyGj9DkjLBxIQdugLK+kgv4TbF6aNWTM1w5cuLsRUe78eoPrYnH0aa+BiwC4P3jkYoZPtUC2vzpGNVlHg70S0tBo/DaOUkuhqzyWhaCHI/4m8IKVH/yyHbQYkLdT+D5vLyVzVm+WlzboCzyBBLMEMFQ+gTpMJ5NotsvHPc2j/6olOazAhq9bjyzMf+731z5rjTmUl1Ep6Gd92+IK+1OmyLbyWvtAfaWPlBbBeHMYWumk9U2X4ltRZEI83nfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/13] Add RZ/{G2L,G2LC,V2L} MTU3 support.
Thread-Topic: [PATCH 5.10.y-cip 00/13] Add RZ/{G2L,G2LC,V2L} MTU3 support.
Thread-Index: AQHZuYEJEuNG+IqLRUKp+plQmyo6Y6/CbmCQ
Date: Thu, 20 Jul 2023 09:59:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420FA83C5CFA534288D54EB923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB9965:EE_
x-ms-office365-filtering-correlation-id: 013e4dbf-39cd-4ef3-4c13-08db8907f41e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DKZe3vNRxcCq42C+tbQYKS3Pz1Arh5G0BDvAntT7DB2nFgTQhvwmBfJzPRHXZ1gwbir8ayNsyEWutlrxd/unc+y8Zl1RjgH2+IefStIFWnQdFB1dDQxSZKrsHPJbq0iAr3jKbNZydY+kXBo4aJsc1HXYCE0OOn5akQ0obW0wapN7aEyaKi4FziOp7tvs1hg9r1g1zaNQfG3Z5SL5naTIv8bmM3bZ1jS2WfXODGZqgd3DXbKDA1o4ELB2og3FhqC75xpbJ8HbsQ9yRiNwgLvGWVVVjYFplTsusrZ9ENRmOSWl5Odc6pT6NB6UZ9X2yAF7/7JfNCqgXK1ZX2ZVS2Y0WTPrrAPs4FIdcCmULOuvoSa9PWSl2b4qEDAIFSBD6lECu2PeCoH5mZi9l7ngVFpoF85iniGBuhEjtFWx74isDZYdT5/h5iXLQ8eJ3JvlPrPvYYMDDx3s10RC1V+I3I5uBDspHicDOUFz8uoOyLV5A/HyABIW2lkgUJ6vNS98SEc+N7/QfNpRJBae+qeRHcRO119a/BknTrP7kdF9kgA2ivO47QPMxUhiHwzUNvvJIhTagzxX82Cj2LmxyQlKC190JtY2XvCttk1uRETn1uRzoNUbNeHioZWC1eivcByM4TqL
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(53546011)(186003)(83380400001)(26005)(6506007)(7696005)(122000001)(110136005)(38100700002)(8936002)(4326008)(64756008)(66476007)(66946007)(76116006)(9686003)(66556008)(66446008)(316002)(41300700001)(5660300002)(71200400001)(478600001)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dkdiYXhPMXdrbTdwN25BYWprVlc3dVZDdHNrOTRmdkRUaThLbzU3a1V3Z09a?=
 =?utf-8?B?NHJPOG11UlVXNHMrbVpER2Y0SkF2WVJrVERJMDVRZTc2T0lQOXpXcjFMdk5i?=
 =?utf-8?B?QUJUYitlZ0phV3ROem1JeHZPTDNza0djQ1NCSkRpWHhqb0NiRW9GdDI3T2Jp?=
 =?utf-8?B?SmpwS3k4TlpJRUFpV0N2VEttNjc2bzFzOWs5dkhLb2s2c2JBYTBPeGVRcS9G?=
 =?utf-8?B?UFg3M200OEVjKytPbk5LaythR3hEWmVUU0FETkZQemg3QVFTUFBYdmZxczEy?=
 =?utf-8?B?SXhTS0RHMklqbEZCczJYVmMyMlJRZnExeXBNSld4dy9GZ2ZSRDlzMDhzZkR6?=
 =?utf-8?B?MlRxWU1VY2FrdXZ6Zm9XMFZvQ0t0ZHJZcERhRFNpaC91YVdnQjd5cXlLbjB0?=
 =?utf-8?B?ckFjaldxM1NQRk1zMzh0K05nK2dWUmNKRysvYmV4SHNnZlFKSXdNNU8rYWhu?=
 =?utf-8?B?K3pMQXUyY2JpZFZ5M0ZHVjQyN2lRU1ZmT1ptMURNWHpDYXNZMXcwalAzUUUy?=
 =?utf-8?B?ZHZoUndDVkFFSjd3MHJ2cSs4cmtWeDJEeVpNSS9xODZaYVBBa0k4WEFzb1NV?=
 =?utf-8?B?cXJYY0ovT2FGOTExNkNaQXVxQzBjRTIzVDdwN1hrc2ViZjcycGkvZElGUjR2?=
 =?utf-8?B?cGNPMlhhdEpkRkgwNlN3cXFRSUp1MHFDSk5nejd5MlRCZFBxR3NrT3J2cWhq?=
 =?utf-8?B?ckJWd0J4bW5UVFo3RkVhMzIrR2ZTUHk3RHBwSVA4ckxnNkJLaVFSYUpxVGR3?=
 =?utf-8?B?WFMyNEpYdk4yZnZuK3N4TEh5U2RJK0h5ZzdadVZPVzBDRkFiOTdIb09nWU1q?=
 =?utf-8?B?Y3IrSVlaSytqbi9kOEFVT3dpY2NWaWJzdi9ybisySitNRkJlUWhoV29XT201?=
 =?utf-8?B?WHJ3eHVPZm4vcHIrazRFWFAreDBTdmppN1hCQTJ3T1F1M1ZyeXNmSUZKOUFX?=
 =?utf-8?B?WHNkMmhmTEZvRWZZRm4yTi9TUjlPN2s2Q1dxZk04NGlWNmoyeG02VW5VNTVr?=
 =?utf-8?B?WlBoSVlHYnhrSVdXY0ZGbWlFZGNTcFhKRE5uU2xHaUNUOVJnR3VGcm05bmt0?=
 =?utf-8?B?VHJJbkZ0ODRVMWQrRnNNeCtWaklOY2FsVTA1bGdnQzN2RTRzelRJbHRQeUdH?=
 =?utf-8?B?M25yRUN1WE1QL1ZoMXdtWUtKZWRiM1BaM0N6Wm92VitvVmVyd2NUcTR5QzM5?=
 =?utf-8?B?NndkR2dBUUp3VGw5QW1ETHIzVVRwekUvSVJqSVFiVTlndGpIUktuQzdLQU53?=
 =?utf-8?B?UWQ4UFZ0WXNIbWJPcHpObzNQcmJqVHF3cTdLeCtJQ1FwcHU3RVpwYWdhQmhF?=
 =?utf-8?B?S1lpNlZxc3pIS0xkQW1BWkdqVnJCZ01sWVE0SE1XRTIrV01RKzlXRWVpblRi?=
 =?utf-8?B?dTl3UDhuV0hDOW9jOE5JeGZ0SGIyUWxRNnlVTnBId1M3eTc5L3NETkxSLzZO?=
 =?utf-8?B?QzhqejZYRmUxazFtZmIvNmlZUEFqZy9SRnNnTm1xWWd5NzJyN2d5Y0dSTkhR?=
 =?utf-8?B?eFlTaCtCK3ZBc1lBTUgzRC9zUkdIYW4vMEI0Z2lYN0k2K2hYQlRxR1ZUTUxC?=
 =?utf-8?B?OVNNVmZsSndHUUZ2UzdiSnVtc0NKbUpEU21WVVFqUm1jdGYwenZwcW8zV3d5?=
 =?utf-8?B?RFY1YzlyV2pRM2NBT3Y1cnFGNUdTdk85Z1lBSkV3cjBIeUYzUVU2L09kZmxo?=
 =?utf-8?B?YTV1OG1hL2sxYWVGandBbDhtVEY0MmtNYjRrWGJHcVIxZnZ2Zk1pUnpFTjNn?=
 =?utf-8?B?eDNGR2NqNStNeWtZZTk4UlorS0VWZzBLQXA1T0ZlWVBtMHpEeHZBa1N3MkRa?=
 =?utf-8?B?SHpxL0JLTXpTS3NyNXo3U2JMSHZ0Y1o1WnFvY2RjMUFQV012YTRXb2JVeWxP?=
 =?utf-8?B?Y01UQmR0VGlSa2V1eFhaNCtTSjEyL1hNUzZyU0ZrTmVGUlllWlJYVTlya05Z?=
 =?utf-8?B?aGs5T1ZtZ21BanFRdG44ZGdJS25rSFFCS2pBMHlXVkM0aXVZNkdrMkQ0ajhN?=
 =?utf-8?B?QUZkQnRNQ3F3NWFtSjZEbTBqc1c2Tmxzd3ZuWUZDc2h6M2hZUFdKV0ZXcUox?=
 =?utf-8?B?ekdQNEJCYjJDbFkyM1A2RmNaYlV1Vis5dGtRYWcvWU1FV2dXYVJ2S01FWHhm?=
 =?utf-8?B?T2hPQy9sUi9JcXc1MXltMThHTnhHNlJSOVNpVXlwdlcxa01jMmdBOEh6VXJy?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	shIjivizXSv+PyrD1LXEW6cBtKoX1KRD90hapG/Ltewg47wlMQODC/WZRz98A4XYlKSO+XRxSXi9yL7WB4SySAbIb3jqXIo8WezpyoyYxq2djgR9kbgM9Qytxrmqer/iprUNrkU8cuZYvp6hbTr1YtF4GLTkRpMETWeL9IYFvGhn4FUyY8nSJgA+q/vhaXUZ+JdvLTTX211eBXmKnw4CyHEX4Gd/zaTSRNGWZ0NqrJv9LlMZBXo/0s6pZjQ+bEDCdWvVeejpR1Mn+6Sit+Vwq5OeV9ydpHGBFj/LqZyFebVluEiOTQUQ01lF9++MCH0f4Ycvduay2bqjdLhc4+4gFRRd47tMSjRlYtEmTaLvjiXaTqa91mDkPw98M25DR57I1eJbRswoIw2/eauXTm4cpwm/TQE8ZJZRCi1xgFB1yM8ztA2N9lXPrMvnFCiqGX7xmampnfncg1AAT1dPaXiOk76Shf/i6PoVL//ufBiBtqx3BLhpjvg6PQw4aFQtNpxQe3T7//2Lj/9kuEZUpFPsVo5cJlcXKFHAqViAzl78SOrur3XAJFE88rLNSSrMzZun+RKcISrH9daq8djWRdmQNZTRhvcWmUcn079RUvnlNGULbMSYB5W4XWtHAljWk7inkIucIsUcDrK0VD+hUY3Dis/XZhao+8ipsdtpsWRigUTAAJ59Dv5l2qrX162UWdEPpXebSQKd8Gprd+zKMSb9dHcraG/rzdw1QW6aVUrQiZzB/O7oOwbfPgES7QFs74Gkd8mPKicgXdTYwy/uKDZUdMSfLNuMQq842rKovkt5Wri1p3X2nw2wKcH0duKTNvW1luM36c1UP8PPx3yoVQXsFb3Otdld2My4EKM4rhgCchJhfxOqAw+0bGz6nT6y9jsZlk0Xqr3laOhfQrP0iBndQw==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013e4dbf-39cd-4ef3-4c13-08db8907f41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 09:59:05.5883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/mvpPlNa+lAfCw76oASWcwaPYcif22t/bM4vTqFUN/ZwJ7S8OLjKXMP2064eUhMaR2veIDiR62epO/EJxntuivLOkeSYfh/5QTZmrn0a3/Y9K8ZDhSXiGI+nZ3MsUgD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9965
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 09:59:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12443

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpanUgRGFz
IDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAxOCwg
MjAyMyAxMTowNiBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1h
dHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4peL77yk77yp77y077yj4pahDQo+IO+8pO+8qe+8
tOKXi++8r++8s++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwg
TWFjaGVrDQo+IDxwYXZlbEBkZW54LmRlPg0KPiBDYzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPjsgRmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXppby5jYXN0cm8uanpAcmVu
ZXNhcy5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCA1LjEwLnktY2lwIDAwLzEzXSBBZGQgUlove0cy
TCxHMkxDLFYyTH0gTVRVMyBzdXBwb3J0Lg0KPiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgYWltcyB0
byBhZGQgc3VwcG9ydCBmb3IgUlove0cyTCxHMkxDLFYyTH0NCj4gTVRVMyBjb3JlIGFuZCBQV00g
ZHJpdmVyLg0KPiANCj4gQWxsIHRoZSBwYXRjaGVzIGFyZSBjaGVycnktcGlja2VkIGZyb20gdGhl
IG1haW5saW5lIGV4Y2VwdCBwYXRjaCMxMS1wYXRjaCMxMy4NCj4gVGhlIHRyaXZpYWwgcGF0Y2hl
cyMxMS0jMTMgYXJlIGNoZXJyeS1waWNrZWQgZnJvbSBuZXh0Lg0KPiANCj4gQmlqdSBEYXMgKDEw
KToNCj4gICBjbGs6IHJlbmVzYXM6IHI5YTA3ZzA0NDogQWRkIE1UVTNhIGNsb2NrIGFuZCByZXNl
dCBlbnRyeQ0KPiAgIGR0LWJpbmRpbmdzOiB0aW1lcjogRG9jdW1lbnQgUlovRzJMIE1UVTNhIGJp
bmRpbmdzDQo+ICAgbWZkOiBBZGQgUmVuZXNhcyBSWi9HMkwgTVRVM2EgY29yZSBkcml2ZXINCj4g
ICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgUmVuZXNhcyBNVFUzYSBjb3VudGVyIGNvbmZpZw0K
PiAgIHB3bTogQWRkIFJlbmVzYXMgUlovRzJMIE1UVTNhIFBXTSBkcml2ZXINCj4gICBhcm02NDog
ZHRzOiByZW5lc2FzOiByOWEwN2cwNDQ6IEFkZCBNVFUzYSBub2RlDQo+ICAgYXJtNjQ6IGR0czog
cmVuZXNhczogcjlhMDdnMDU0OiBBZGQgTVRVM2Egbm9kZQ0KPiAgIGFybTY0OiBkdHM6IHJlbmVz
YXM6IHJ6ZzJsLXNtYXJjOiBBZGQgc3VwcG9ydCBmb3IgZW5hYmxpbmcgTVRVMw0KPiAgIGFybTY0
OiBkdHM6IHJlbmVzYXM6IHJ6ZzJsYy1zbWFyYzogQWRkIHN1cHBvcnQgZm9yIGVuYWJsaW5nIE1U
VTMNCj4gICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgUmVuZXNhcyBNVFUzYSBQV00gY29uZmln
DQo+IA0KPiBMYWQgUHJhYmhha2FyICgxKToNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByemcy
bGMtc21hcmM6IEluY2x1ZGUgU29NIERUU0kgaW50byBib2FyZCBEVFMNCj4gDQo+IFV3ZSBLbGVp
bmUtS8O2bmlnICgxKToNCj4gICBwd206IEFkZCBhIGRldmljZS1tYW5hZ2VkIGZ1bmN0aW9uIHRv
IGFkZCBQV00gY2hpcHMNCj4gDQo+IFdvbGZyYW0gU2FuZyAoMSk6DQo+ICAgYXJtNjQ6IGR0czog
cmVuZXNhczogcnpnMmwtc21hcmM6IFVzZSBwcm9wZXIgYm9vbCBvcGVyYXRvcg0KPiANCg0KSSBy
ZXZpZXdlZCB0aGlzIHNlcmllcywgTEdUTS4gSSBjYW4gYXBwbHkgaWYgdGhlcmUgYXJlIG5vIGNv
bW1lbnRzLg0KDQpSZXZpZXdlZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2Ft
YXRzdUB0b3NoaWJhLmNvLmpwPg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


