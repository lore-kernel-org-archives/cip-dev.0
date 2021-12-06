Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9668BC433EF
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 09:49:48 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.99])
 by mx.groups.io with SMTP id smtpd.web11.49445.1638784186242614343
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Dec 2021 01:49:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Un3F+Br1;
 spf=pass (domain: renesas.com, ip: 40.107.114.99,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoORC4PNbeQATUmPKsBfxjzbzbakM6IFaL9d8CPrK6j+neofYL7bkdW1y+pu2ngcSKEVgjfkNL/tD+bgTtWQo/JikL2BhdPehOs66/fSoJMvcpRzwBnBQed1JcTC1CWVWig658ufzcb/RLFvrin/qp+AuYZ+1Tfw4VmSAuDXTXQVQ4rTtavq2ikxjkBs1EE1SKwsMFcUpPzk6IsMIiuHnQoRtF13FF/pKVTwGlz7kBwqSEMvH+bV5nr3A/uq35X6i11lbBd1f0Q6LsTTpzimlyFeTmUCe9hJlut8MAqn189GPfQ8hqlAIsNod82yRgXw/FatOIxbdy77jx9a2Dmmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVBwHeE5k4hQB+z/RI8jce1ipf2hOqptEjEavM3fGsE=;
 b=M4ZRddcelhHXbIJrBmg896zaYS+GuKDUf+SFyIBm1FwkT//eAmiAoQ8F8daexZTXRTd0PVvpTD5isrgJyyt3GTKK1mDhqxXQ0KKy4s7FgMrWCY3czAl0D0lH66H58pInpqOXH/cPafpeCxoGjlDwejWoTjM75rDIcBwh5Zdg+3LRyBXH4abrX1YdeZo8mpep2Rn1C/OdEcnvhkWEUaq23IeC8VUS9hOAoDyE4jCvCFd/gYYefqiYCdh1IhUUFphFFV5wodBC5qkGq/aosLIj84i2vMBSzYuaKmN3EoOJ9jeXAWZwSxYDjKtFSeldvcicDBWnb6BgZPPfciCYluLR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVBwHeE5k4hQB+z/RI8jce1ipf2hOqptEjEavM3fGsE=;
 b=Un3F+Br1/RpgFxG5MJRl5O8dVoCrq3m1axrWZBVgS7ydfs4hcIatJoHSMrPkHoI886EtHcnuCNJBb2N+OsOdQqZSJftONYlru6sNwHbQIBqhYH8VqnBwVB0j6TbnQ9u0sFPsOCbFS/hhJmpC1ICTQtDGxmLjS1COeafA6h4ojfY=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSAPR01MB4691.jpnprd01.prod.outlook.com (2603:1096:604:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 09:49:41 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b%4]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 09:49:41 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Planned maintenance for lab-cip-renesas: 4-5th Dec
Thread-Topic: [cip-dev] Planned maintenance for lab-cip-renesas: 4-5th Dec
Thread-Index: AdfdQY0ruckuk3pKRXmKZHiU8njZGQLPw/GAAIAK7UAAAH8NAAAA1PDQ
Date: Mon, 6 Dec 2021 09:49:41 +0000
Message-ID: 
 <OSZPR01MB68779DC942B56FE78F9FD2B8B76D9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <16B8F29B24FD30B5.32206@lists.cip-project.org>
 <16BD574183886849.11393@lists.cip-project.org>
 <OSZPR01MB68771C64F1E64D3A47F3472AB76D9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <CANgtXuNW1uTwGNKLx95s8Dpz+1pkoPzSu0_iLYsWWJabp7DKsg@mail.gmail.com>
In-Reply-To: 
 <CANgtXuNW1uTwGNKLx95s8Dpz+1pkoPzSu0_iLYsWWJabp7DKsg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: accef8b2-74e5-44a2-333e-08d9b89db9e6
x-ms-traffictypediagnostic: OSAPR01MB4691:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB4691B10FF09223830565559AB76D9@OSAPR01MB4691.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 voip/11ts47s1lD8BOtZYR3EUV08q5gQjVKa6GiL6/hDQkl1wDVIKiF58jt3oOsnyQR5DTSGZwidKznGLTO1MhJ1M8LhzaHbCKyyoa6ndu29Aon9swtyhGikIxhgBjYeWW2Ewm3iSKB1gqO+mM0lPEm1O/vMfIRiD9WfWN2J+czpZ2fu0ego/U5iXIe3V77wuFYT1u1wIguRHNN9FQm5iwkFccBstAR8NkHZswVXUDmov0hZ75ZJ3Y19Hq/0T6I0zfXPsL+j1fE41EHDVD/4X9dXe0XxkW+Nwc4Tv49D6pX7qYLkXfZG4zg6sMicGw8gzZ5Bl2FeRss960vPhDLnt2hU6gahmO8hT+aONRX1sPA2hwQu+QADzZ2Z55uxLIFq8HTt28jf+zx6ixXZvKA72e7MKI2Ys3C6Vb/fmXGjBYu5/zdq5NLiIYvX7Im34HghFWP953L5nVXMKyKVRnQMJZX72VZ9P3VQ/6CDkZ69HxONpB3tNGv1lqBTtQ7W3D8Pson/x6TLyeM4mNLnTD/k4eIeTluVrWJbHuOLTWKEtMjtvyw6ZI4j93p/MjFGCeatpWxrDUIV9p8Sqpg1YPnqubzskot4jh4U1Yk2IRhNQzb/bvb6+O3onHPz18Dl+lk7GeZOCXFNUB2VX1qxfv0vUWU+iUNkGHZkn95JbAEo5qUidz6zyZRgLdHy02XUoz79UpO9rSBgtgFEdOxxRLD8kg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(53546011)(2906002)(6506007)(55016003)(76116006)(122000001)(33656002)(7696005)(9686003)(38100700002)(26005)(186003)(66476007)(66446008)(66946007)(64756008)(71200400001)(66556008)(83380400001)(8676002)(52536014)(316002)(6916009)(508600001)(8936002)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cmgrS0cxZjhHeTV0dlZra2hzV0xXS3FhZUlHQUJ4eWZpZUMyZmFmemhhYUFY?=
 =?utf-8?B?cVEydERIT2RnME1lUjY0b01MbFQ0UHAzcEM5UkN2dVY0Y2NmeHNNbU5tQUVP?=
 =?utf-8?B?RndkSCtma0xZdUE5KytVVGpkNUtGK2E4VjZZcXdIUm9HeFBqVmZsNG03UVM5?=
 =?utf-8?B?bzEzQ1hHZENrZFQ3U1BXbUhaRG8xSldpSE9PWFIxd0VMbml0MSs0K3FWOU9x?=
 =?utf-8?B?dkkwVXZveVNYVjRhY2ptUkc5T3hnRGVyUVpaWGdPVC9veFdyYkI4eFgrOTlr?=
 =?utf-8?B?djVPQTNlUUVoS2xCTzJhbUV6YXBaZVZ5eWh2ZzFFL1BlUWdNMDM4WDYrSm05?=
 =?utf-8?B?SFIvdU9LWUVsWm54ME0zZ1k4eWlTc1hGZ0RiWjR1UW5KYXN2RTF6T2VKZlF4?=
 =?utf-8?B?SUlCOERyZnRYMFpabWZDV3hyYXc2M3JuSXNkMjRXd2oxYXVteTZXTjVVd09N?=
 =?utf-8?B?bFNVelhURFo0MDJVcXM4Q1JhbWZWelBHQkU0VWlFeVRUbGNQT3JOekhDM2pW?=
 =?utf-8?B?RVZ1cGFOZmc2U0Rsc1lpeFp2K1NrdGVtVndXMHNBS2JaNlJDYjF2S3dTblNn?=
 =?utf-8?B?eklGZWNCbi8zdHRZOEhOd1c0RXF6K1VJdGIycDVWbE9zbG55NEtSczMyRVlj?=
 =?utf-8?B?MjR4d0ZMZk9LUStGVTNuK0gzNURGNUoyMUxFOG1tWEJKbjhXWlBXRzROK1pk?=
 =?utf-8?B?Mm9vNGZ2QkZhc1F4VEFoMWNHSWkva0taVWcyekRUMXY4UDZZRE5ZcVY3SG53?=
 =?utf-8?B?cjA3bWxwMVRaTmNBNmlxeVh2R29qODBJWVBPdHZhU0pkYjB0ajBPcEw2SE1x?=
 =?utf-8?B?Y2ttek53bTNzZmFRNUFFLzRyRmVzVWY4Zloxc1ZjSWl3V1FoQWYwdENnYnI1?=
 =?utf-8?B?NmYrajJ2ZE80YW4yZTlGbE5HWTBLbEpqQXdlZHFaRHR6eklQS1FoSmhIZ3B3?=
 =?utf-8?B?UGFtdzJybWk4YWZZWENaS0dQS2xDU1hnOWFyOEVVaXBIY01CS2NoM21vODNH?=
 =?utf-8?B?YkkrZFkvZENvQ2VtdlFycmc1N0RnNEtxT1VOc2x2MzZNSktFSklRbWtpRm01?=
 =?utf-8?B?bDdCUkk5dHg5TVRkL2V2VEFDOVExV3Vob3R1cmM1cWlpWGQvTVh4bFNPbWdD?=
 =?utf-8?B?eFBNU3N5VG1RV0lUMGNkdjIzTXJ0R1dhRzFXNmlra3ljcElNdS9UNlI2K2JC?=
 =?utf-8?B?UHpOb056T2NJZUxpanh6OVcwbm5XaVN4MVVjUEpRdGdYdEwzaHNYVFBFMDNr?=
 =?utf-8?B?N2d3V0tNcXBoQlRORkxlTjlGN1haVXR6OEo5anRXUTM5L3JIWkVZWUVtb3k2?=
 =?utf-8?B?K1ZoY0RDTHBXMW5qRFlFVWRuSzBXTktZVzJUVnJTNVE0SS9rbEZiNllCRkdn?=
 =?utf-8?B?TDlpSnZuS093akZrWEpIMVc5VW9OdmU0OGl1eTN6MWFwaTBRUEJtQnR6bWhK?=
 =?utf-8?B?YTN6THA0TUtzR1YzYzVRL1RxQ0pubFlzQjNUSVBhUVBaTUp3U0tHYmtEM1Vo?=
 =?utf-8?B?c1ZRelJNWkdGRW9FU2EzSTcvVGtYalJvMDFCR2dlN3k5ZTYvVk1PSHMxSzRJ?=
 =?utf-8?B?TGtlQWxZV21oVnlKdks5YXRIcVZ1Z3pmdVJZZjM5V05RcStFSmk0U2lWaHlj?=
 =?utf-8?B?ZG5sZWNjWWx2aWhDVys4Zmk2YXhYY2Fic25tN0xXb1Juc3dnWlJrRGF0LzdD?=
 =?utf-8?B?ajhsYXZtTDg5ZGF3WDBjUkJFV2o3cHFlenVaR3d4N0g2eXlNd05FY0VhUHJU?=
 =?utf-8?B?VFNESjFPQUJvWVFMZWpEb1hYMEJlNEt2YkdPZVIxYXJuYnNMWFFrbncreUhV?=
 =?utf-8?B?WVZhYW9QUDJYMExSampmOGk3bFpIS2VtbnJpb0MveE93c3RqT0w5M0dZeHVw?=
 =?utf-8?B?Zm1TVkhyQXhIWUhQWGM5N2ttUXdFVEJBVkltNjJXa0V6L3JNL1B4OUtSZyt0?=
 =?utf-8?B?NHlwTXkzRVoyRDc5d3lVRHJETDVDV01GM2xBUGlRSG9pb0ZBRmNhOFpDOUtQ?=
 =?utf-8?B?WHFzRFZHV0FYMHZhU0d1V3paU2NraVRsbGlObFQ2ajdoTlRxOU5KK1VCTURw?=
 =?utf-8?B?b0l4ZGlnLzJidEwreXhhRUJLUUV1QWdyQmJaNnd6T3RIbkxqKzNiZG9kV09i?=
 =?utf-8?B?TDNGNjk4ejVZcm84L0psOGNUM0VYbnBFcTI4azErNVpHZC9lV296U2xPK2ox?=
 =?utf-8?B?OGQwMnhnOGgzQkdLb0ZpaFhmeHpjbW9SR1E4dldRUElxU3plaHNwY3J6NGxh?=
 =?utf-8?B?d2dVWDNCcVptc1ZsTlpLU2VjR2JRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 accef8b2-74e5-44a2-333e-08d9b89db9e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 09:49:41.6633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 1TmAMgkptGzNDRBhHfLYaq3SOLJRZc6vLNmQJ1JN72Jmtx5moexaxq1JFiKmYdZRtEvOR6S7ZjaVOprGJkoZRi9RHBHMsWP2p1miOPZrfns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4691
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Dec 2021 09:49:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7071

SGVsbG8gQWxpY2UsDQoNCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhhbGYgT2YgQWxpY2UgRmVycmF6
emkgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiAwNiBEZWNlbWJlciAyMDIxIDA5
OjIyDQo+IA0KPiBPbiBNb24sIERlYyA2LCAyMDIxIGF0IDY6MDggUE0gQ2hyaXMgUGF0ZXJzb24N
Cj4gPGNocmlzLnBhdGVyc29uMkByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZz4gT24NCj4gPiA+IEJlaGFsZiBPZiBDaHJpcyBQYXRlcnNvbiB2aWEgbGlzdHMuY2lwLXBy
b2plY3Qub3JnDQo+ID4gPiBTZW50OiAwMyBEZWNlbWJlciAyMDIxIDIwOjAzDQo+ID4gPg0KPiA+
ID4gSGVsbG8gYWxsLA0KPiA+ID4NCj4gPiA+ID4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiA+ID4gPiBCZWhh
bGYgT2YgQ2hyaXMgUGF0ZXJzb24gdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+ID4gPiBT
ZW50OiAxOSBOb3ZlbWJlciAyMDIxIDEyOjMzDQo+ID4gPiA+DQo+ID4gPiA+IEhlbGxvIGFsbCwN
Cj4gPiA+ID4NCj4gPiA+ID4gSnVzdCBhIGhlYWRzIHVwLCBvbiB0aGUgd2Vla2VuZCBvZiB0aGUg
NC81dGggRGVjZW1iZXIgdGhlIFJlbmVzYXMNCj4gVUsNCj4gPiA+ID4gb2ZmaWNlIHdpbGwgYmUg
dW5kZXJnb2luZyBtYWludGVuYW5jZSBvbiBpdHMgcG93ZXIgaW5mcmFzdHJ1Y3R1cmUuDQo+ID4g
PiA+IEFzIHN1Y2ggSSB3aWxsIGJlIHRha2luZyBsYWItY2lwLXJlbmVzYXMgb2ZmbGluZSBmb3Ig
dGhlIHdlZWtlbmQgc3RhcnRpbmcNCj4gPiA+IGZyb20NCj4gPiA+ID4gRnJpZGF5IGV2ZW5pbmcg
KFVLIHRpbWUpLg0KPiA+ID4NCj4gPiA+IGxhYi1jaXAtcmVuZXNhcyBpcyBub3cgb2ZmbGluZSB1
bnRpbCBNb25kYXkgbW9ybmluZyAoVUsgdGltZSkuDQo+ID4NCj4gPiBsYWItY2lwLXJlbmVzYXMg
aXMgbm93IGJhY2sgb25saW5lLg0KPiA+DQo+IA0KPiB3ZSBzdGlsbCBoYXZlIHNvbWUgZGV2aWNl
cyBvZmZsaW5lIHdpdGggbm8gbWFjaGluZSBhdmFpbGFibGU6DQo+IHI4YTc3NDcwLWl3ZzIzcy1z
YmMNCg0KSSBvbmx5IGhhdmUgMSBvZiB0aGVzZSBpbiB0aGUgbGFiLCBhbmQgdGhlIHNlcmlhbCBj
b25uZWN0aW9uIGlzIHJlYWxseSB1bnJlbGlhYmxlLg0KSXQncyBwcm9iYWJseSBiZXN0IHRvIHNr
aXAgYWRkaW5nIHRoaXMgdG8gS2VybmVsQ0kuDQoNCj4geDg2LW9wZW5ibG9ja3MtaW90LXZ4Mg0K
DQpXZSBoYXZlbid0IGdvdCB0aGlzIGJvb3RpbmcgeWV0Lg0KDQpLaW5kIHJlZ2FyZHMsIENocmlz
DQoNCj4gDQo+IEFzIEknbSBhZGRpbmcgdGhpcyBkZXZpY2VzIHRvIEtlcm5lbENJLA0KPiBjYW4g
d2UgZ2V0IGl0IGJhY2sgb25saW5lIGZvciB0ZXN0aW5nID8NCj4gDQo+IC0tDQo+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IEN5YmVydHJ1c3QgSmFwYW4gQ28uLEx0
ZC4NCj4gQWxpY2UgRmVycmF6emkNCj4gYWxpY2UuZmVycmF6emlAbWlyYWNsZWxpbnV4LmNvbQ0K
PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K

