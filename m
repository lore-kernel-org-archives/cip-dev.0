Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA3EEB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 23:57:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.2939.1689724664451623783
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 16:57:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 36INvY2W2880225; Wed, 19 Jul 2023 08:57:34 +0900
X-Iguazu-Qid: 2rWhoCDaNVQOYP3lOz
X-Iguazu-QSIG: v=2; s=0; t=1689724654; q=2rWhoCDaNVQOYP3lOz; m=gWNLdYh07aoKauPbt2XRgL+I5vzO773PJabxPZEvOiM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 36INvVLt052564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 19 Jul 2023 08:57:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1meei/u19LzJ+OpaDTYWACYZ3eyhbohLedYndjSSORTf2n37+fCQW9fwF6c0VMrf7zNTj/pQ9dIEFYuUIE4vsHtXxOLAFXfUi9hNkeVCGlGYo9Sx67OUBr7LKW2alS0CZgrjlAfTUYq8uGIca3wJAcyAfBFvH/SBAoS0FVo8p3fH5NStUoXKjkW+Me+i4fkDZl9Lc/7BjPkASP8CWjumdAybyyvckubS8qfoZ9QQAKaM0+lj7o0XPH5ums3O04ByqSKU8t1nItGXc6iFBxjs/Njn/WcTXjJWliN7zrN9cAcG92vx5piq3IW+ZAkJOxfcFNN+Wopi2pz+VsDAPGhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIb18PIhZfIReE50EL3wvdtaMcVdyZQi7PLzRlK9WR0=;
 b=k/pHju+f/XuWWYZocOMfXt/iCByRXtBoEdjqn/aavK9kLd9Yi06F04FraVTcall/LCykW/i+50oTFCsVFdQ+GtPe7GZL/jUYhexjK1mCcc1qCHcU7y2nJZoTqLE0Uc8Nhwk+abjjivx7PwjqHD8t1EvUb6BsXR1yhJn6ib35yJzRrhvIU28wzS9ZT7sfCZuJ8n2Lx503l/FpvB+9KIoikAxrQpwi1Q1LsLxR85G+BS8IhybZgbIJ7eMYNRvAz6y17j/c8sSJwXa9WdY4DMnyzbAete9HXjne32nb3C4TSry2g7tAWyCPaj82YgbMIMG9eZSc4A7i/06J9GqG5vld3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: [PATCH 5.10.y-cip 0/2] watchdog: iTCO_wdt: Backport patches to
 enable handle_boot_enabled=0
Thread-Topic: [PATCH 5.10.y-cip 0/2] watchdog: iTCO_wdt: Backport patches to
 enable handle_boot_enabled=0
Thread-Index: AQHZuZlptQWFv1h4vEm5jy2WZEitdK/AMrNQ
Date: Tue, 18 Jul 2023 23:57:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420F5FE763941127A88E47C9238A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <cover.1689699632.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1689699632.git.jan.kiszka@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSRPR01MB11420:EE_
x-ms-office365-filtering-correlation-id: 7ae29a59-b725-4dff-8e11-08db87eabf15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jJLLxZlNZIlgUZIX9511oF1Ut/Navjydb1KBHdCY7uSmYBTDSjTPJf7Wgh5GrOCImRa5CkkoptnB8VrsG1QA0sVC4fxZlYe3uEjDZoPZGc5ygfzkFxMtdBw4lvapTTKo448bmrDy2LLwTE2jhB6ALOn8osbHEI4IUyLqO2LVBsLQa7P6wxcoQH7yVWo4UalYWDCAMU6yXnY7zj/WMfi6wNzjFP5WHFACDiTNPOpOckpzyNbQcEann7m2AnSTzzKeGgGoSo/ucPDeWfC0TWIcIyqjApGh+auDesRCXrHQ0eeTDFKvP1N33D+ustVHg6zsXweL3B58i6WDwy9tXmheGKPvZD3Rsots2384JTJLEMk/PoGNTCBVrYus/GSl668Qpce/PWrH6zW+yMWVzWQtSZdsiioSnH3qj7s1v1XKZrMGjuUROSrf2ePPtkpgr7T5lotbIGNSG1UQ6tLUyNyn5EYH/oPV6L385nQESfm/ZjiOlAWJ+Cr0VpogQHyZZETcPemhtR+HcXWanVEjl89UdQDaIA7UQRr4fVaeVhiW8dGUHqQ3KIe4CtJqru6c0Roj+0olVEuNqbIwPuGiINOQeubz773Q5zUWTG4WyG6ekhs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(71200400001)(478600001)(7696005)(110136005)(83380400001)(33656002)(86362001)(38070700005)(55016003)(2906002)(26005)(6506007)(186003)(53546011)(966005)(9686003)(38100700002)(122000001)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(316002)(41300700001)(8936002)(8676002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?amw2NUdkajRpbTVtRzJRZHcvUVhEdWxhbGJUOWJKM0lkL3RocDlRMDFncjRW?=
 =?utf-8?B?cnRVbGt5NXprS0JRb2pNOGVOcGw3QXJ3N0p3VDFuVVdKMzlEVTJXYWppQkli?=
 =?utf-8?B?dU1heVNCd1ZjNmF6WHBIS0hXQ05IOUs2ZkE4Z25CSXVwRWRENm42MVNmTzB5?=
 =?utf-8?B?YlhDN3NkeEVUUG4zd1B0ZVh5VTVOUmZqV1dZUHBQN0Vrc2hiVTNzUEp0WlRD?=
 =?utf-8?B?SGROQWs2U3dUbGtNRzRTTGlhQzB3V2tSMXdnUFZ1WTMyZXp6dkx6eHRaamJu?=
 =?utf-8?B?ekU5MU1xTDMvOTBYZFE1SGJCNGZKdEl5WWd5UnlsdWV0cGhMLzNyS3BwdVUw?=
 =?utf-8?B?SFUrSXFKS3FhRm1Oc2tidGYwbDRGbGhRcGhVdnpxbTlFRGpEUFArNjRQRUpD?=
 =?utf-8?B?eWFiZzltMitrMytJa0xRNVZjemJBSXhVUWxxd3IxVUhoa0xlK1VKS0dMUWly?=
 =?utf-8?B?eWJTL1A0dnp1ZjlsblpPRDhPRzdGVVY2Vy8yRzNwRitWQjZWWXYxQ3VqSkdD?=
 =?utf-8?B?eTRRMDVhcnh1amRHVDh0eVBOTU1GS0plL2pvTGZGVjhWZlcwcWhFd3I5R01X?=
 =?utf-8?B?L1lqbnlyVjFQeFJGSzlDcmFUb1hRRWVKVWo5QVdHR1hQZTl4QTIrNFFReHUx?=
 =?utf-8?B?K0JSWjhLTDJUT25KSlVKS2VNZXViOGhLN0RhTVFPam11VFl6VC9JTW83UUpS?=
 =?utf-8?B?dUh3ZmtDR01kRW5VVGpxUFhJUUM1d28vRkVZb3pTSlJOdHdqRWlZZGpHUUM5?=
 =?utf-8?B?RG5xR0tqYkZqclM1dmJuVEU4ZEFWZUt2dVhCanc2aXYrRFNLY3N4MGZUVUdm?=
 =?utf-8?B?cEVKV0tkcWlidmdJWHhoaklRZU9hWTQ0aEJWMHFSZTNjazR4c1VSNFhtRldP?=
 =?utf-8?B?U21pUDZjZnAvUHJ5UXowTWh3M0JsSXZOOXBDZ1MxU2tab2ZGQXl4ZUZZNFNX?=
 =?utf-8?B?UU1xUWVLMi9MNi9ZbHBEdVFEVUhJb3RKMk5vRFZXS2pLS0p6QmJ1akVIVmhz?=
 =?utf-8?B?TlpZMHdRMnpjb0hMeFhLSUJIOEhGWmJmS2ZxWWtIVXh5bGpzRGlSMWhLQXhJ?=
 =?utf-8?B?Rzk4TDZtRnp1UG1rc2kzdksxVHdqYjZhOHM5K1UrQys0RHlIcTVPS2xVYjFF?=
 =?utf-8?B?QmpQN25CekJraGl1STdIMFJuQ0JaK3R5YUVXRHptUEl4UVlubjJNMFptVmdS?=
 =?utf-8?B?dDFkMGJHTVZEdWRHVk9KcXNSVm1ML2xrVWRLbzNIbWJHaS91N0dsZHdhbjN4?=
 =?utf-8?B?QTdhMDk3VGwvcVhkUUFMRjBvcU8xQkRYRWJza3FNNTRXZHhDZFo4cjlLdGU2?=
 =?utf-8?B?Ny84WGdqcXFUN2IxUFVpUWIzc3RRY1V1SndJczRlaDRxcncva1Z4Tll5ZStE?=
 =?utf-8?B?R0FzdVBRclZoeDNFZTk4aExEaWQyM25ISm0vamNQa3N6THBpOTFETTNRdWNL?=
 =?utf-8?B?UHVqNGJ4c1JYOFpIVTFtdXM5WjZweVVjdTlDeHhiMUtQZ0p0M3NzRld5dVN5?=
 =?utf-8?B?eENmM2k3UDlaTWxKMGIrLzJoaTB4V085QXJEV0lBdUxiQWNGeXg3K0NIVXJH?=
 =?utf-8?B?WXhDMDcrK2lPQXVBR1JQZzVIZU8zQnkybW5COGY3N2RxL2pzbDJPR3JMS2pL?=
 =?utf-8?B?UkcwR2dTMUQwdGlpQUpoTmxSOTQ0UkFsaytpNUQyTzRYNVpycmZkMlhWejJz?=
 =?utf-8?B?a284VktKelVxRGR6UTJ0L0lSM092YzEyd2FkQmxiS2RsREpBbFMzanpnbkV5?=
 =?utf-8?B?dDNaNXlIeGZRQ3BRQk4yYUVuZDJsNUYwdFdKMEZ6OHhTdUsyM3FoZXB0WGpR?=
 =?utf-8?B?Zk82azg1dEN2bVp0MkhocGVBQnFzdFY1b0xxeStXbERWcmtVU3RvWTk1dHQ5?=
 =?utf-8?B?M2YvdytCMDZsNzhEdm41NGRhNTczWnVvYmEyY0RiSHNPckVueHdJZlNRMTJ0?=
 =?utf-8?B?cnJlVTYxVEJGVmtzWldnTFcra1A3V0xadlY4YUN2WUllSjlsS1R6MllXVlJP?=
 =?utf-8?B?UytJaU9zd1FqVFRLTG9FQVBPOWFZL2NFR0M1Zng0dC9Td3hSMGNEVnVINlV3?=
 =?utf-8?B?c3FrempEdmM3MUtHTzM5dzBkR3ZjSjJPYzZNN09WMWc0M1lRWEJXOE1lRUFr?=
 =?utf-8?B?ZEkxdUV1U0RVdFJ1S3RJbG15MEhJWS9LSmw3ejJodE8rTFA5c1pCT3J2bU9i?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8vKnn7bPAVOZGVFYx8rbB5PgrUmhlOJnUFIhe+GDtxPGb6GGEtEXDiXzsU4z8YYO6IkeuvhmzDb02S6CmwlmeWY0pLdMNm7grT3iNRONOT8WgabethGrz145okZ+xF6jHAjiwkzB9OshqP5q/kXWj4VgUUfSFpPOSlMD8Jr3jKsRoCN1SsWfEM6rbjKlVrDJoKk8X9Fzlx0Inrq91OQYBwDvpu6uVEOjBiAxmyda/eKxdKXzPSMxtPlGX2KdjuHfRjaWQwY7hSYvki/GMDk8Sq3NMs5gGbpNnl8We4QazAYhyIyvT6RVvXZNQk7BuwpuaB01UeRLHC+M9nTIcDAGQ+c5oS45MZ5XN7lBV5xzkjruQ+3I6faeDvJSwkyxbBmC0qWKWCxagCWqXkGOO+5KDr4Mo8VUeclXj80mtR4rNhFABhsIi67mmbizZhmvYywrut2ptpOyf0S7T59xjK25m1YpwI2hkS9N4fUh6x5zWSKqSLKWHFFArfnrVsVWjycjy0oLfeYSPZK/cFh/IhHOjGynZAr2NeS/IvBVx4V2C7yZBaZI15qVluK81KWVvC2xMmNiuNOe+SRvF32zVhl0iGsULk6v4I2pybTG2m1tEEoRB5MMpv4nJldrIS7gGEDsGnCxUQjjPyWvjDW6DLMkJYTVsXnyijrqNVe/3HbrgSFX/9rRKl+vD7QXWdyFt4T9CaM1EtCNDemMnxY9IAg4RZwrH6AIuw9XLdbG1fWzZRBUTjTodfo5xbG/SzfI10tnj2kvfRWZJ5yiwvzVQO/G84b8p3hmxW1HeaHG7z1bW+w72FZjD1/eRebP2pU1iN6pBka6yTBZYGBM+rPHI890heaP6McGtaOcsOs5L+E5Qg4=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae29a59-b725-4dff-8e11-08db87eabf15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 23:57:30.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJEORMbgR6H8zeOMC6AVq3AM++vgVpvN2osYvCf/dPg0kie9jBhNV2EeR5mB4EdCTC3zclEMOoPPNrezRtgCH4XdvGlNmVSYKMyOgtz2G+Z4Hgt1Xyr9vfRlJhUxalY/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 23:57:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12417

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxOSwg
MjAyMyAyOjAxIEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdhbWF0
c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqENCj4g77yk77yp77y0
4peL77yv77yz77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBQYXZlbCBN
YWNoZWsNCj4gPHBhdmVsQGRlbnguZGU+DQo+IFN1YmplY3Q6IFtQQVRDSCA1LjEwLnktY2lwIDAv
Ml0gd2F0Y2hkb2c6IGlUQ09fd2R0OiBCYWNrcG9ydCBwYXRjaGVzIHRvDQo+IGVuYWJsZSBoYW5k
bGVfYm9vdF9lbmFibGVkPTANCj4gDQo+IFRoZXNlIHBhdGNoZXMgYXJlIG5lZWRlZCBpbiBvcmRl
ciB0byBtYWtlIGlUQ09fd2R0IHJlc3BlY3QNCj4gaGFuZGxlX2Jvb3RfZW5hYmxlZD0wLCBpLmUu
IHRvIHN0ZXAgYmFjayBmcm9tIGEgcnVubmluZyB3YXRjaGRvZyB1bnRpbA0KPiB1c2Vyc3BhY2Ug
cGlja3MgaXQgdXAuIFVwIHRvIDUuMTYsIHRoZSBkcml2ZXIgc2ltcGx5IHN0b3BwZWQgdGhlIHdh
dGNoZG9nDQo+IHdoaWNoIGNvdWxkIGhhdmUgY3JlYXRlZCBhIG5vbi1tb25pdG9yZWQgd2luZG93
IGR1cmluZyBib290LXVwIGluIHRoZQ0KPiBoYW5kb3ZlciBmcm9tIHRoZSBmaXJtd2FyZSBzdGFy
dGluZyBpdCB0byB1c2Vyc3BhY2UgKHR5cGljYWxseQ0KPiBzeXRlbWQpIHNhZmVseSBkcml2aW5n
LiBFLmcuLCBhbnkgaW5maW5pdGUgbG9vcHMgaW4gdGhlIGluaXRyYW1mcyB3b3VsZCBjb3VsZCBo
YXZlDQo+IGNyZWF0ZWQgYSBsb2NrZWQtdXAgc3lzdGVtLg0KPiANCj4gVGhlc2UgcGF0Y2hlcyB3
ZXJlIHByb3Bvc2VkIHRvIHRoZSB3YXRjaGRvZyBtYWludGFpbmVycyBmb3Igb2ZmaWNpYWwgc3Rh
YmxlDQo+IGludGVncmF0aW9uICBbMV0gYnV0IHJlY2VpdmVkIG5vIHJlYWN0aW9uIHNvIGZhci4g
QXMgdGhlIGlzc3VlIGlzIGNyaXRpY2FsIGZvciBDSVAncw0KPiBPVEEgc29mdHdhcmUgdXBkYXRl
IGludGVncmF0aW9uLCBsZXQncyB1c2UgdGhlIENJUCBwYXRoIGluc3RlYWQuDQoNCkZlZWRiYWNr
IGZyb20gdGhlIHdhdGNoZG9nIG1haW50YWluZXJzIGlzIHJlYXNzdXJpbmcsIGJ1dCB5b3UgY2Fu
IGFsc28gc3VibWl0DQpiYWNrcG9ydGVkIHBhdGNoZXMgZGlyZWN0bHkgdG8gc3RhYmxlLiBIb3cg
YWJvdXQgc2VuZGluZyBhIHBhdGNoIHRvIHN0YWJsZSBmaXJzdD8NCg0KPiANCj4gSSBkb24ndCBo
YXZlIGFueSB0ZXN0IHNldHVwIGZvciA0LjE5LCBzbyBJJ20gb25seSBwcm9wb3NpbmcgdGhpcyBm
b3INCj4gNS4xMCBoZXJlLg0KPiANCj4gSmFuDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtd2F0Y2hkb2cvZTljMmQwYTUtOTYxOC1iNjE2LTNiZTMtODI2Y2MwNjYN
Cj4gNTM4OEBzaWVtZW5zLmNvbS9ULyN0DQo+IA0KPiBNaWthIFdlc3RlcmJlcmcgKDIpOg0KPiAg
IHdhdGNoZG9nOiBpVENPX3dkdDogTm8gbmVlZCB0byBzdG9wIHRoZSB0aW1lciBpbiBwcm9iZQ0K
PiAgIHdhdGNoZG9nOiBpVENPX3dkdDogU2V0IE5PX1JFQk9PVCBpZiB0aGUgd2F0Y2hkb2cgaXMg
bm90IGFscmVhZHkNCj4gICAgIHJ1bm5pbmcNCj4gDQo+ICBkcml2ZXJzL3dhdGNoZG9nL2lUQ09f
d2R0LmMgfCAyNiArKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjM1LjMNCg0K
QmVzdCByZWdhcmQsDQogIE5vYnVoaXJvDQo=


