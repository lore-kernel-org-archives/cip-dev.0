X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.61])
 by mx.groups.io with SMTP id smtpd.web09.4495.1648210981259920005
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Mar 2022 05:23:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Sw/UX7Fs;
 spf=pass (domain: siemens.com, ip: 40.107.21.61, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdnQEDv4voqmoTPw0zCfDRVBIRCfIyYrBSwNWLCelI1xmat2nNJvT31QqIxZihU8gyMm7F5oH2md2G4jhtstoBMH1gWk+Kqx5kRz2OSeBfJ2kpKLU/pRaVvOn4/GlEVA8h9jHF0bKPBKXXUVyFdhajgIGZ5F7fVh9oZvVZ4hI+bc07aiUv1y+RBuzGo1JWPSsGksfalvwnBFtgkU4Vsk/RgKV2YyTkHyvxJ9EQmfstAjfypjhvJO7oVLJIeiuSFv506p9F2GQ0SVcOZ3foshCuiBG2LCfE++s8vQYn/NISGd6McUHGj6ThZfGMfqKW1AyD4g/GgB3OisHAI4JdcvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8eyHYLDMK1azoRg4hXRB5u0VollibBe5cQ69v6wD2U=;
 b=HHi5g0l7ovhSVajkIFmVpYWMhoWhu2kEkuCIWlVy91aE/rZZn+BEBB3CY/WeFGYTq4+Pc1IFtMGMpXr2EJ1k0/5S2ui1y7x/Ts+dkTFJ0139W6ES62U1VmL00auDVBYcFl5OZhK5KiZZwI71hqsxiRDwfoK49eS327kowYBHc2UUHK6XuswN2qKkElEzQVXEjPcwt+ikhWhBTKFYLVwK0gIrOR8dbpYjBKoIqsV+LGfEyyfFQhLnkp9ae6hqXcT0B0l3Nzw0wppzL4ZsICWuLcISXePhSIkHfmngaLU97E/6yVqqgOZw9OTD1/TEHkuhGHVcloprMPrFTGPLPIUfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8eyHYLDMK1azoRg4hXRB5u0VollibBe5cQ69v6wD2U=;
 b=Sw/UX7FsFQOUi4k9wFhMlQmE+cwEaODxHojZahT3iHdsKcY/kSa1lf15CB/F3iBsoXGChnBih0pM1VfAVzX+4fJii0SPjuCa4jMlGCE7a/kE6sA44UOnPCC0xqMsd01tTymcn06LW7BuqtoJFiUeXUfn8CGseU/Gti1r+wavv0Pl7yg/UdjMdb649soUwbb+QOjO9yTRdSpIoDrUQ+YKo8f09aOuRqhi8/HkbO6D66TzvI5wMVmJIZhqYbHJm/YxmpERVMf4Uc4dCsjgVCh7bmA3BZ11y4XeW8UiR5IlwNZS0o3KSHuRTU14T66BscPtdobTQi+lnbDZouhYAqxAlQ==
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:418::19)
 by DB8PR10MB3162.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 12:22:57 +0000
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::192:e4a1:871c:a84d]) by AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::192:e4a1:871c:a84d%7]) with mapi id 15.20.5102.017; Fri, 25 Mar 2022
 12:22:57 +0000
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, Srinuvasan A
	<Srinuvasan_A@mentor.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH] python3-shtab: add export to the DEB_BUILD_PROFILES
Thread-Topic: [cip-dev][isar-cip-core][PATCH] python3-shtab: add export to the
 DEB_BUILD_PROFILES
Thread-Index: AQHYQD0AEJ9SfNLoxUivRS0OrovNlqzQAiXw
Date: Fri, 25 Mar 2022 12:22:57 +0000
Message-ID: 
 <AM9PR10MB4869002D4384D86EDC6057A0891A9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
References: <20220325083408.4080473-1-Srinuvasan_A@mentor.com>
 <b126a869-b4f9-4468-2e76-4bb4fe895632@siemens.com>
In-Reply-To: <b126a869-b4f9-4468-2e76-4bb4fe895632@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-03-25T12:22:55Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=8a94e0d1-cd67-4706-a961-fcec4aa46afe;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50bb8eff-f7a1-4392-8010-08da0e5a321b
x-ms-traffictypediagnostic: DB8PR10MB3162:EE_
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-microsoft-antispam-prvs: 
 <DB8PR10MB316226B441EF8C5EA9D21039891A9@DB8PR10MB3162.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7v6/60b+E3qkQwsHe5jqwHtnApD55iYyCJbBJYlii+rbPH77anSe2fOaDbc1OJnC6SBjRgZnNT3rB2/9/MLUS8rm+zy/jsTQoqDVQUve4uEL3iVZGBtWI4KHUrBMOuvdeAqCXmvoA/9derQLbGvOp0pWmIT2v9RfaKH6GFC8T+GcEwn8FmnRCoUwqys2g7FDOGSA5xGzCegq+zESEkEMMDQm1CU3XY2EyxKVrO4kOIdyLaqLcVkVlKm2NW/8iBajk7iEMLJgWyDUhx3w4jW5ZHBcRvXOVvRfXyCZZBna2UlCbd2szaesYcpQ0bQiVqczTVY7y/n2F2EkbUJ9ja35Gy7bs1Dy+r3R1SWU029J/F5l+KuT3Z7kaBRdQrQrBOaHd56Q2k/NlwhRX0PA54EzLPlRQpHqvf8GSVBcE/dGlP4bcz8zKd4FB2qzIIp4HsVkzIO+oZNrZ8rR2zYuN3BE9z7rwtXiSsWzHUc4b1rWwzzqZUfQ1N78Uy2o5TTglNBhOmedWsQ0m4gQdywq9bqFT16kcdXi5pcjR5Cks0Q7OK920h+vPu6VrhnK0K66sTWTPTvtrOKhT+KvkNKJ1CEUzfK1wxEu3kOevni2svDni7u7oN6GAeKX3MMrvT4ktrhk+1SrUzOi8s852QiltLwnT8rRrkGmaOlWK7EuQVGN0QdC92Y9jBED9oFxANkH8zNWOAtt99lQMFiNXBAFpSS3N3qT6vhkrGqMT6vY16+QKP2CmIFDJRq3C2/em1pr5d+Mok4OWYPqZ7uK1aI1b7z0QT/C//E9H5AM/jtvFsXdpJg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(53546011)(38070700005)(186003)(7696005)(6506007)(9686003)(2906002)(38100700002)(122000001)(55016003)(82960400001)(83380400001)(52536014)(33656002)(8936002)(316002)(4326008)(110136005)(64756008)(8676002)(966005)(5660300002)(508600001)(71200400001)(66476007)(76116006)(66946007)(86362001)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YVN6WC9HRnh5ZW5KWkRLdXFCdkxRVU9IaW9Vbko0cFF2T1IyVXFzQitBWDk1?=
 =?utf-8?B?Yk1FTmkxbWhwaUpaMDhXVlJ3WVpnSmp0RnJHcVUzeC9NQkZ1UU9uTHN1OUxu?=
 =?utf-8?B?SmZRQVBkcjAxejA5elY1UmZXR2c1dDJKSDNSRThYVWsxaXJzU3VSTTYvc2tX?=
 =?utf-8?B?c0U0ekNOVFhYVnZCRU9FZEg2cEt3cUVVRXNmMitvc3R4eCtuQVEvU2svYnRv?=
 =?utf-8?B?ajVRNGJPRm0yYXp3MEY3ZG03VjREdnN2OVpsM0F2ZzI1KzBMQ2pEVnBCSTNr?=
 =?utf-8?B?OXdJVkNpR05JdGU4UVBPRWpwUFRDUjgzbitaSFNxdEVYV1ArcFN3bVdFYzNk?=
 =?utf-8?B?MlIrUUx6STdjR2ZQc2NPRlY3VExIaGt1cENHQk12MUs3TCthK2ZaeVpsbzJW?=
 =?utf-8?B?UVZwY3ZhSFB0UVJoK0NIbHB6R3ROVVhTWW4yY1lwNGY2V1VGQjVIanRodFpB?=
 =?utf-8?B?N3d2b3F5SUQ3TVg5TTJWT3JMeHJ3Skx3ZzZuTVVoOHFyZEZBZGhIcWlHeHRs?=
 =?utf-8?B?MmtQazB0SE9uSlFhZDJ3bHg3bkdXOTlHMTVjRGljUUJKTUlDOTBUSXM1Z1NP?=
 =?utf-8?B?ZUxiMzVLOWdjOFZpeXRCaHl1azhFY0JvR2FaWHlmVGE2RUZBVnRRZjlMWXpY?=
 =?utf-8?B?anJtWS95dWZrOUV3QVVaUGtBbno1Z09uYzRURXBsQkdSMjJOVlk1Yk9RUmow?=
 =?utf-8?B?a1lReWdxdCs4c1g3ZVoxeUMxNnpZT3lhWVpDNHphY0x2cTdDcmpPTGRmNEVN?=
 =?utf-8?B?OElwd1k0dU5aOUVjaklmRnZzMndlOTlTYkdRL2d0ZjRackREMmJkaWJTeDJK?=
 =?utf-8?B?akxIZVQveXZyUXZjR0NFNnM3NWJsQk5yR25MeW13ZUxrU0tJK0NwdklWMHky?=
 =?utf-8?B?eFB3Q040UmwrYXBaNWU1aEl3dVVEYllwZ0lwYUlvNE8vVlA1SlJDcExhcVh5?=
 =?utf-8?B?SG1KbDZaOG5EL3VxYk4xVkxDOHg2RVNUZ2h0OFV5V2F3Z01sWGtNR2Q2Slcw?=
 =?utf-8?B?N2VNT3hNR1JkMnpYNUswODNUYjQvZU9yYnBVLzUzRGFzYU5NUzVDUFg4YWht?=
 =?utf-8?B?cXRuWkVtamFFempVVVpJRDVmaE1DVjdvUThwc0lreGdwSitJOUlkVXk5RGM4?=
 =?utf-8?B?Wm9Nd2JtOVhRRmtGSjgvVWpqc3M0TjVIRVJWL1dUK1BkaXdHdW8vTDRYdk5T?=
 =?utf-8?B?T2hYSzBUeFJUVk5NbXR0VllUL3FLQWhlaHU5bkJFTnh3SWtudW8vNEVNYmVa?=
 =?utf-8?B?WkZYelZmbENSM29IWm9GUFFiRjQzL0hCMFNxd05QbkZXczhDQXdwa3JXMnRR?=
 =?utf-8?B?L1JSQitGR2l4Qk0xSklpUmhBdkgvWDc3ZlgvdWpiTFg1S3dPRnVqTGhNZ1pJ?=
 =?utf-8?B?WTFOUjE4ZGxDazJIQTJ2Y3kwUEpRelE4UnNmamJMeng2M3lsV1VpQjJoUkFP?=
 =?utf-8?B?Mk5qYlZJMnFlOTNaSWg0MHBtVklGZFM5VmRnQU1HK2dneldmV3dKVytSVmx4?=
 =?utf-8?B?T3ZFdzk5cDhOMGhoMW4rL1FWZFRwUTVFUHNsdXRnVXJFdVBoMkZnS0ppelBF?=
 =?utf-8?B?ODV0UVdCVE9lL2lYbnJWUXZyT3Q0a20wYnhFVjV5SEE5bzNaNllJMkhSSEZi?=
 =?utf-8?B?TThreTdHMndBdTI4V093WVA1RzBkYWZObUFrL0FYNlEvcWhaeFJVcnorbEVF?=
 =?utf-8?B?dzcveEVodmp6amhFSU5aQVVyUVV4TVlwdjk4d05WSlpIUEZNVUZSdlhwZ3p1?=
 =?utf-8?B?RUdZRWpyNHBJejhLeWNIMzF0ODlSeWhNeXZSTlg2c0poNFRZL2syQ2xlM2hL?=
 =?utf-8?B?VTErMWZnR0NUTVA3cG9yNWFsV1JPcTdVcXFQT3BERVN4TjQ4bnJKSmR3Tkd6?=
 =?utf-8?B?QUNQR0VubmlVYnN6bXMzZWg0cTFZRDdMekhXaFFVT0NSQ2NhanR2TXJUbzRM?=
 =?utf-8?B?aElVZlZDelZVZHlXV2lJeU8vK2dxK2dZL0MvUDkrM2JkaGZ3MC8vWVZaQktG?=
 =?utf-8?B?N2p2bkxrR0lKOFZkMytveWRhd3BzRzN2Y1oxS1dZOHBUNTJEM1MySFdrWDlD?=
 =?utf-8?B?dkx3bHZmWHBSWEhZdjVRNWViN1NvYWp6WjY5ck9lVmR0WlFGR25WNzgvNUps?=
 =?utf-8?B?ZE1CeFRkUGJwL0RZd3ZOdEJRYUpBMXZuS2Y2Y1IwNFpuS3BsUlVKVjY2b1pB?=
 =?utf-8?B?UUlPT08wdDJDMEl5eFhiek5naWFtdmc3cVpmbmdtS2NkTDdBNjI1SDJZeDNB?=
 =?utf-8?B?OUdZYVJaRVNZaUcrVjNIbG1wOFY5djJtMnNyTmZJeVRGSWVxYnIyUnZTYW8w?=
 =?utf-8?B?ZFBSdDRieUpFYkdGclA0dktlYWY2NkZPZWlZZUpmeDJiclJtZXdYdDdxR3Za?=
 =?utf-8?Q?9XVCje877flSrYy0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bb8eff-f7a1-4392-8010-08da0e5a321b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 12:22:57.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gd4umo6SQ4yoIfOMQrelAhFfb7hqPszwwffm1w6LGPh/0UuAhhfETUv8bflmKxJrq+KiBajZSkllBmrAzo94nsKsWRDyU1Jy63Bc6noZmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3162
Content-Class: 
Content-Language: de-DE
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLaXN6a2EsIEphbiAoVCBDRUQp
IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDI1LCAyMDIy
IDEyOjQwIFBNDQo+IFRvOiBTcmludXZhc2FuIEEgPFNyaW51dmFzYW5fQUBtZW50b3IuY29tPjsg
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7DQo+IE1vZXNzYmF1ZXIsIEZlbGl4IChUIENF
RCBTRVMtREUpIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPg0KPiBTdWJqZWN0OiBSZTog
W2NpcC1kZXZdW2lzYXItY2lwLWNvcmVdW1BBVENIXSBweXRob24zLXNodGFiOiBhZGQgZXhwb3J0
IHRvIHRoZQ0KPiBERUJfQlVJTERfUFJPRklMRVMNCj4gDQo+IE9uIDI1LjAzLjIyIDA5OjM0LCBT
cmludXZhc2FuIEEgd3JvdGU6DQo+ID4gRnJvbTogU3JpbnV2YXNhbiBBIDxzcmludXZhc2FuX2FA
bWVudG9yLmNvbT4NCj4gPg0KPiA+IFdoZW4gd2UgYnVpbGQgdGhpcyByZWNpcGVzIGluIGRvd25z
dHJlYW0gbGF5ZXIgdGhlIERFQl9CVUlMRF9QUk9GSUxFUw0KPiA+IG5vdCBhYmxlIHRvIGZpbmQg
YnkgcnVsZSBmaWxlIGhlbmNlIGl0IGlzIG5vdCBzZXQgdGhlIHJlcXVpcmVkIGJ1aWxkDQo+ID4g
cHJvZmlsZXMuDQo+ID4NCj4gPiBIZXJlIHdlIGRpc2FibGUgdGhlIHRlc3RzIGBQWUJVSUxEX0RJ
U0FCTEU9dGVzdGAsIGJ1dCBkdWUgdG8gdGhpcw0KPiA+IHVuYXZhaWxhYmlsaXR5IG9mIERFQl9C
VUlMRF9QUk9GSUxFUyBpbiBydWxlIGZpbGUgaXQgaXMgYnVpbGRpbmcgYWxvbmcNCj4gPiB3aXRo
IHRoZSB0ZXN0IGhlbmNlIGl0J3MgZ2V0dGluZyBmYWlsZWQgbGlrZSAiTm90IGFibGUgdG8gaW1w
b3J0DQo+ID4gbW9kdWxlIHB5dGVzdCINCj4gPg0KPiA+IEV4cG9ydGVkIHRoaXMgb25lIHRvIGFj
Y2VzcyBmcm9tIHJ1bGUgZmlsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNyaW51dmFzYW4g
QSA8c3JpbnV2YXNhbl9hQG1lbnRvci5jb20+DQo+ID4gLS0tDQo+ID4gIHJlY2lwZXMtcHl0aG9u
L3NodGFiL3B5dGhvbjMtc2h0YWJfMS40LjIuYmIgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Jl
Y2lwZXMtcHl0aG9uL3NodGFiL3B5dGhvbjMtc2h0YWJfMS40LjIuYmINCj4gPiBiL3JlY2lwZXMt
cHl0aG9uL3NodGFiL3B5dGhvbjMtc2h0YWJfMS40LjIuYmINCj4gPiBpbmRleCBjZTgzZDZiLi41
NTRhZmQzIDEwMDY0NA0KPiA+IC0tLSBhL3JlY2lwZXMtcHl0aG9uL3NodGFiL3B5dGhvbjMtc2h0
YWJfMS40LjIuYmINCj4gPiArKysgYi9yZWNpcGVzLXB5dGhvbi9zaHRhYi9weXRob24zLXNodGFi
XzEuNC4yLmJiDQo+ID4gQEAgLTI3LDcgKzI3LDcgQEAgREVCSUFOX0JVSUxEX0RFUEVORFMgPSAi
IFwNCj4gPiAgICAgIHB5dGhvbjMtc2V0dXB0b29scy1zY206bmF0aXZlLCBcDQo+ID4gICAgICAi
DQo+ID4NCj4gPiAtREVCX0JVSUxEX1BST0ZJTEVTID0gIm5vY2hlY2siDQo+ID4gK2V4cG9ydCBE
RUJfQlVJTERfUFJPRklMRVMgPSAibm9jaGVjayINCj4gPg0KPiA+ICBkb19wcmVwYXJlX2J1aWxk
W2NsZWFuZGlyc10gKz0gIiR7U30vZGViaWFuIg0KPiA+ICBkb19wcmVwYXJlX2J1aWxkKCkgew0K
PiANCj4gSSBsb3N0IG92ZXJ2aWV3OiBEbyB3ZSBuZWVkIHRvIGV4cG9ydCBub3cgKGJ1dCBJc2Fy
IGRvZXMgbm90KT8gV2lsbCB3ZSBoYXZlIHRvDQo+IHdpdGggdXBjb21pbmcgc2J1aWxkPyBJZiB3
ZSBvbmx5IGhhZCB0byB3aXRoIHBhc3QgSXNhciwgdGhpcyB3b3VsZCByZW1haW4gYQ0KPiBkb3du
c3RyZWFtIHRvcGljLg0KDQpUaGlzIGRlcGVuZHMgb24gdGhlIElTQVIgdmVyc2lvbi4gV2l0aCBh
IHBvc3QgIkRFQl9CVUlMRF9QUk9GSUxFUyIgdmVyc2lvbiAocG9zdCBmZmRkMWIwKSwNCnlvdSBo
YXZlIHRvIHNldCB0aGlzIHZpYSB0aGUgQkIgdmFyIChub3QgdmlhIGFuIGV4cG9ydCkuDQoNCkZv
ciBvbGRlciBJU0FSIHZlcnNpb25zLCB5b3UgaGF2ZSB0byBleHBvcnQgaW4gdGhlIGRvX2Rwa2df
YnVpbGQgdmlhIGRvX2Rwa2dfYnVpbGRfcHJlcGVuZCAoYW5kIGFsc28gaW4gZG9faW5zdGFsbF9i
dWlsZGRlcHMsIGlmIHJlcXVpcmVkKS4NClRvIHN1cHBvcnQgYm90aCwgeW91IGNhbiBtYW51YWxs
eSBleHBvcnQgYW5kIHNldCB0aGUgQkIgdmFyaWFibGUuDQoNCkV4cG9ydGluZyBhdCB0aGUgY3Vy
cmVudCBsb2NhdGlvbiAob3V0c2lkZSBhIHRhc2spIGRvZXMgbm90IGxvb2sgcmlnaHQuIElJUkMs
IHRoaXMgZXhwb3J0cyB0byB0aGUgYmIgZW52aXJvbm1lbnQgYW5kIGJ5IHRoYXQgaXMgdmlzaWJs
ZSB0byBhbGwgdGFza3MgWzFdLg0KUGxlYXNlIGFsc28gbm90ZSwgdGhhdCAibm9jaGVjayIgaGFz
IHRvIGJlIGFkZGVkIHRvIERFQl9CVUlMRF9PUFRJT05TIGFzIHdlbGwgKGp1c3QgaGF2aW5nIGl0
IGluIERFQl9CVUlMRF9QUk9GSUxFUyBicmVha3MgdGhlICJCdWlsZCBQcm9maWxlIFNwZWMiKSBb
Ml0uDQoNClJlZ2FyZGluZyBzYnVpbGRlcjogQ3VycmVudGx5LCBtYW51YWwgZXhwb3J0cyBhcmUg
c3VwcG9ydGVkIGJ5IElTQVIgc2J1aWxkZXIsIGJ1dCBkZXByZWNhdGVkLg0KTm90ZSwgdGhhdCB0
aGUgREVCX0JVSUxEX1BST0ZJTEVTIGFuZCBERUJfQlVJTERfT1BUSU9OUyBpbmZyYXN0cnVjdHVy
ZSBwZXJmZWN0bHkgd29ya3MgKHVzaW5nIHRoZSBjb3JyZXNwb25kaW5nIEJCIHZhcnMsIG5vdCBl
eHBvcnRzKS4NCg0KWzFdIGh0dHBzOi8vd3d3LnlvY3RvcHJvamVjdC5vcmcvZG9jcy8yLjMvYml0
YmFrZS11c2VyLW1hbnVhbC9iaXRiYWtlLXVzZXItbWFudWFsLmh0bWwjZXhwb3J0aW5nLXZhcmlh
Ymxlcy10by10aGUtZW52aXJvbm1lbnQNClsyXSBodHRwczovL3dpa2kuZGViaWFuLm9yZy9CdWls
ZFByb2ZpbGVTcGVjDQoNCkZlbGl4DQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcs
IFRlY2hub2xvZ3kNCj4gQ29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg==

