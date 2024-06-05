Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32017C25B76
	for <webhook@archiver.kernel.org>; Wed,  5 Jun 2024 08:54:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.10486.1717577643758593094
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jun 2024 01:54:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=bytoW0Au;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1717577634;x=1718787234;bh=MaWYrM/UUVxoHAjrc+fEvq00O+CW+TOJY5lcsUP
	4dbM=;b=bytoW0AurIkniflqkQPKDYkQPzMyic+26Fccbw7Y6VmgY8ale//sYUYdqf2mBGQfPd8RZ
	+rYj2Jh1RTDCaAcqsqyVT+lwfI2pk/prV5gdfjZa8sowvW8fVNUYnGwhyGzFBMYna8FNEqsOZY2UL
	Ne10IDh8cwjUqQ5TWJCr8xF9jh/hMxlOEFXQohh2r9NnBTsQHX072HqatlrhrqYjqx/glFccIi2Ba
	UA3r51u2KgfUco04LcOwjv8JAV6TXcrColOz1HxrMACV/qx7Wx2foKkF+J2SqSIFSz65rN+aybMaV
	MyYrF2M9945VERNeZK/Y40cYAHLcg3OvyCoXps9UNw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4558rsbs432916; Wed, 5 Jun 2024 17:53:54 +0900
X-Iguazu-Qid: 2yAbxjwjwI7MkOkLI9
X-Iguazu-QSIG: v=2; s=0; t=1717577633; q=2yAbxjwjwI7MkOkLI9; m=TpUKKS5ghcNYeAfOVYEqkOaArShYJbtiDNMxHaJrzt8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 4558rq6V2550698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 5 Jun 2024 17:53:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErhHBK+fgqvQRkKIuChMRuhfciR2y1jKE7mdta8f50JLTL2P61YeIbUd5PEDCMFTA+nH6lrrUlC3I228hUPcAeALeh9D8ivMQPkD8MbcbwbGWLaFZhYPoE/gV5HvxzNE87RplV/aqK9BWOn08TYh4PZEZ7XJmc0xDzLavpM9waYtvX2xNK7uhGLJCRBCcGnm0HELWeCn4gjicO8XEm6+uZW77VEbqbBUyX/w607lFCEzGxpscZCQyCKPYwGKqme8Wd0RLs0ZJ8yoosBA2Bf2DH7QLjQLHMAYzA/I1uu/fqNtcjFKcgtz+NLJnpfNZHwUTA8ID6TKRXSoENUTe8KtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaWYrM/UUVxoHAjrc+fEvq00O+CW+TOJY5lcsUP4dbM=;
 b=Sk4YdMm108mQAVoKkqOjdpxY8db6NVBomjsXkl/iCAVco68OWC4GUCte2ITCeSrbbvRDFrdhGgVz3ACToBGoYorjIgmOP7cy06McwIMnzbT7hOrHPZzW5XkmWbHHuJiHcEf5/ZQlfEHQ210ocCL7L0vQ0D0S9YyBjQ/L7RE6c1GWrqiEOKtxXRKNg0wa8pAplpevNXKA88imgixrfskvUnm//FTKjgyBA6coxAZcjzeooRdebtPMRoPZmFK16j7EXEfi0gvboWmgB1FgqEgyjKcbeK9FCU0BUp2kfkkqk/07SgcVCan5MQRebiV8yQxLAdEW7W42rcGuxWukjBFBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <paul.barker.ct@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/47] Add Ethernet support for Renesas RZ/G3S
 SoC
Thread-Topic: [PATCH 5.10.y-cip 00/47] Add Ethernet support for Renesas RZ/G3S
 SoC
Thread-Index: AQHasZ+56yAkZGhPGkSEtENJ2teLWbGvUrEggAmVntA=
Date: Wed, 5 Jun 2024 08:53:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388EDBCE987B451E1BC059A92F92@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
 <OS0PR01MB63885CC33A00E94C4BCCC37092F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB63885CC33A00E94C4BCCC37092F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB7060:EE_
x-ms-office365-filtering-correlation-id: 6e19756b-ca69-436d-ec1e-08dc853d0506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bnNVSHl1TjNCQkJ2anZiK1JKRVA1c0doeVdjM01MQm8zZ2hjbXdxdmpUYzhi?=
 =?utf-8?B?Vi9kem13cFFCSXk4WTM2SHNsak9rQm9JckQ5TmdreFYxVkx3NSswYVA3dy9a?=
 =?utf-8?B?L2plQ2N2aDV1Vk5TU2NjZzNzK3pmRVZCNm5XTzgyRVdTYlBiQ2VJaDVaeUVk?=
 =?utf-8?B?Q2cyRUFoc2pYWVJEbFpnUEJVL0E1QXkrQXFBbkVTZGlvRTNRZ0xDM0kyTjN1?=
 =?utf-8?B?UHR0bUtoT2NVcUtqcnV0aXdNeXBjei84V2h2aXhmc2FHRXBQOE5HbkdUTjR5?=
 =?utf-8?B?VVFrTjI2Tk5OYVhnNFhvQ1Y2WUN5aVd3MHZXWGpybE42T3FUSnVmOEZEb3lk?=
 =?utf-8?B?ODUvSnJCbTN6WHRhTGxVd3N4NjZtenBnaCtTeEZrN2xGcDRXTGNrbUp0dFI2?=
 =?utf-8?B?Y29aT3RrcWVWK3lNS3lhNDlJWlE5dVYyZzFoZUlIT2NqT0pmZVdDM24rajN1?=
 =?utf-8?B?R1g0ODhENjJtcnd4MjF1M3NvZ0cvWkhKK1ZsWnhiTU5ZQWQvMUQ0aU96WDlh?=
 =?utf-8?B?WTRVREFtSDlCU29iblZHZi84ajdtRzlzUEw2OWJaY3grNXl4cXpVekJkWitS?=
 =?utf-8?B?OUI1bmdzVTRDTWc1N2k1TWxkUk1XajNpbWRBcEtrRXI4elJjcEJFb3lzaUFj?=
 =?utf-8?B?SDNaSi92UU93eDFFQmNNRUpuaFJBRE9EWjdOMEVvRzY3UGJQbkRGVGNPYmdQ?=
 =?utf-8?B?RnlSNEJSOGhqQnpJeVFXUVVKYmxkR0wzaFBZMFJxU1FsUk5qWHZHZG9EYnhQ?=
 =?utf-8?B?VjRIQVRhQlFWZU00V2pXNWI3ZGkrbkNmQ21CNlI3eVphYkwyelQ3bUFXb2ZR?=
 =?utf-8?B?UUtkdFlLRXV0RHo0VzdNNC9sQzUwTUhuNkx5WTVNbXhYSjlGaFQ2T0tjU25N?=
 =?utf-8?B?MFphWlk1ejJ1RlNnRXRlWHlOUnR2WXRhUE1BOVZ1cEtaU1o5cFFnemFNSDIw?=
 =?utf-8?B?Vjc2QXlyVE92RFdkeTVOZ3NDTDZ6VVVvUkN1dFdsTDViaG5Jczg2dDk3U3hn?=
 =?utf-8?B?amw1QnZ5cjJpTUN5Tnd3ZjNpZk94T3VxZUQ5b1pFZ1NEa0xPTDNnZmhIMmZt?=
 =?utf-8?B?UHVhSnA4KzFlcU94ZnYzZ0gyRnZqd01SdGVzTWM4RUhleDNDZXVBSGhrVC9y?=
 =?utf-8?B?WWJoU3g1ci9kNVpsMUZyaklESTIxbDZuREJtalgvOWIyQWZER2FzMmtqa3N6?=
 =?utf-8?B?clErbXVqQmFGajJEV0t4Y1ZvOWM4SzE0NVp6WnZnZDVnTzV3UHJlbmtacWpD?=
 =?utf-8?B?ZGprK0FYVElIYU5FTXBIMVFSYzlqREs0OHpPSHNrR2ZaV20yc1IyUm0yTVpk?=
 =?utf-8?B?YnFMM2svaFBrakNMWXQyZXpId0xBcmpqNUpDbTZvZ0hPYU5QVS8zSmJDb1lW?=
 =?utf-8?B?cjIvUnlqakxrVUZRSDlPbDN0dWE0ZmZkaHd3VWdIbFNRc2lpZ0cwcDlBUzVx?=
 =?utf-8?B?RThIdy9DekZ2UVFpUWhiU0p2S0ZyTnhldFpiOEZTRy9BSm9oZjE1Z3NPYmZE?=
 =?utf-8?B?MnhIVytSTkE4NEJabkJkTGIzaUZyK1dMdzZOWjQ1VGNnb2E4aFRvRXlQWWtM?=
 =?utf-8?B?SW1zQ1VtUDNBY2gvbXp6cStnenRhWkJwRXF6WEh5SUdVQzFLZXlXdnpGcTc5?=
 =?utf-8?B?TUJTWVJkNHB3dHlzOWZqL1JqK09PZ0U1UFdyY0Fpd0VVYUxVS1NRMTFpZm5U?=
 =?utf-8?B?RmVuMFh5b2tsa2hGMnJDeHZJbmRQM3JUV3UyVUJKRjZOU1kxNlAyQ21XM3Jn?=
 =?utf-8?Q?LePMiYEHD/G29ApOKY9iHL8UkTz2bSqn0OuEhfH?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?emh4SEhkaDBPS2FDbXpyQWNodmhuNlB0N245bXZYTkdaK01ybldFSDRGUTZO?=
 =?utf-8?B?cnZUWkVLcmxKSEJIN0pVV1YrdHZnVEtMRTlOaTBGRDA5YlcvUG4wdVQrdWJt?=
 =?utf-8?B?aFpvMTdzdGF5cStBaG1zdU9uVzBZenVZMkdzejNhK2lqS2lvcnJzV2FpS3Jk?=
 =?utf-8?B?RjRybSt3TkZ0ZVR1bnV2YlJnb1dMeXVYK1Y3eUN6Qy9UTzZhY1p1bGdjZmNx?=
 =?utf-8?B?WjI2dVNEWFp0RkdvbW45dm1XTFNRbEFTTExkbVVQdVdLVUVKaXI4WVNrMVJO?=
 =?utf-8?B?UDdDMmgyWHFxS0M5eFhvaU10UFJCaDJMSEJQNFY5Q1U0OXhicDJHZmtvUWlw?=
 =?utf-8?B?ZHpCUU1RS2hhRG02TFJUYklEVVY2U3doSm53ZGZHYUpmWkF1VmdJajVQa0NN?=
 =?utf-8?B?c0pXSnk2b0ZBNVMrZmJ0eVlhMzFKUTYrSzR4THJhWlc2QkNTQ0daZUhYVHFR?=
 =?utf-8?B?VEFOVHRFV1E5alVRaUFGVk9rbXZlL3ZtcG5wM2JWNWdERUlFa0luc2N5bGhZ?=
 =?utf-8?B?ZE1RKzh1UC9MR2pyZmsyOUdJVlNRaVhyazZaTlZVU3hLUlNHZ1NVZHMxNG42?=
 =?utf-8?B?MldMTWN3bWdtcm9RMTR5M09qaWdrQ0Z2WXNuanVFMWozc0ZJbGNtdTNIcDc5?=
 =?utf-8?B?MUg3SHpHSlNkLzVEdzcrS0hoUno2V0ZVMUlHY0x5OUZNd0F1SWRpb0xOUHRa?=
 =?utf-8?B?bnBNQ1VHS1VNQ282elBwb1V6bGRJdW44M0lSRHcrVkVCOGxHQ211c1Z4bERI?=
 =?utf-8?B?VllXQytTWkxUeDNlQnp3MjBZVG9vcnU4TnBqZ0hTYTFKUnM5bFg0R1FmMVZa?=
 =?utf-8?B?QUVzUXlrT0xlbEZ1S2JWdzZMdTJlL0FTT2NqMGZxZy92OXBMUkwvVkVxUlRN?=
 =?utf-8?B?ZnJXV1lyQlRyelZZMnBWeGtyaDlxWndIS1NjYXNQbmpmK2JzQ3Bva3ZhV0No?=
 =?utf-8?B?eHlCZ2Vnakc0NFhvVGY4L2RHWVNHUVBSd1grcW5TY244cHNiQmZBaFBiVXFO?=
 =?utf-8?B?NVZNQWFGQW1kaDd1ZUUraE1odEtQakw5T2VnM0RwcGRpWEtkZ2puRVY4VzM1?=
 =?utf-8?B?VEc1TUo1V3FycXBGNVY3eHpvTTNpL2VTQmRIT1h3NXFKdkc1QUJDN1V6ZkxB?=
 =?utf-8?B?bnZ4Nmx4V0lReG5IenFFZGh2dUFySUQ0bG1mMmRmd3JCK3oveXBFc0NsYjB3?=
 =?utf-8?B?QmlteUtxT2d2b3VKV1ZkVFlYYmVZd2lwWERhQUxCbVJFOG55S1VXVEZ6REtI?=
 =?utf-8?B?ZEFUVzZibEo0LzFLMkExbGd2NnRIb1lTOUZDUzB3bkpKbkRCam5RWWFQWjFL?=
 =?utf-8?B?cmFsZGZvalBJdldEQktxVWwzZUp3b0g0MnZyVnpWSWZaSTdENEp2ZE01OCtK?=
 =?utf-8?B?R2VWWjJMWGg3RUlTeE40UG1UdzFjWnRlRUJFNTJsN1ExaGhpaHZpeXRrOU1J?=
 =?utf-8?B?WUdCaHhJa25FRkFqSDcyVS8vRU44dmxMaDFYWk8rcEt6NGczZTR0Q1gyaGUv?=
 =?utf-8?B?cTVXZTlXK2dSWDl1My9EZ1ZvZGZuRUhNRXJoZGl5S1hrclFRMTFMbVpSNDl1?=
 =?utf-8?B?NTJuR05QMGQyQnpiNTBLYUltVC9aWElQSTJ5MUQraTNVMWZJanIrZTg3amlB?=
 =?utf-8?B?V2lOWW82aXR6czMwOU1Ic1FmbGpiWm1CSGxMeWFEcVViTFUwby9qNStSajdG?=
 =?utf-8?B?UE5DU1VFMlB3enZYeTVlc1hSaEJqQ2JaTXdXZmFnMFM2ZnVuYUU3SENHUjdw?=
 =?utf-8?B?OUYwUkV0TUlUNkEvZ2o2c2NGcmNxTkE2bGZFa3gvUGlvUVVjNkV1WEM4MGhu?=
 =?utf-8?B?d3dmd2dDK2hrWjRxZE9vb0tybGRoMEM1cWZPN3JwbDJmWUg1ZGc4OXd2aGZz?=
 =?utf-8?B?anVlOEcyNDJjUmR5bFBKa3RudjllS3dvdUtwaDFSSk9VQ0xmZVJhRWM2dmNX?=
 =?utf-8?B?dDVzSGdsci9EejFTem9EWk9NS2YzR211SnAxMnVFMnpIY1FOcHJDbi9DQ0hp?=
 =?utf-8?B?eWJNdXM3TFZNeEpOL25peWlrLzI4Zy9vbCtyZmxid1MxT3RiVEdXUG5OdGly?=
 =?utf-8?B?dkVITHoxY0ZBY2xOR2lJT0tjTWhNdHZGeC9JRENMQ3RUdTZ3WmhzYlg5ZGg4?=
 =?utf-8?B?ZGRHbnZOb2FoWkVsdVNPekVRM0dXNXFDMG1aUG1GRkxqYTlnS0w5QkFsNml4?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e19756b-ca69-436d-ec1e-08dc853d0506
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 08:53:50.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHKuVa1Kl8PMZS63Bz11NpXvmnEU59MdBaG6jCwTlrCHLk7AZt+Pjho8xSx4VMzNycbGMak3u/Lw6h+9pdhdeYQd5QAk0sBmwQH+nPF3rdvYzUg0rjJEKcTb7G4yMfNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7060
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jun 2024 08:54:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16111

SGksDQoNCj4gDQo+IEkgcmV2aWV3ZWQgdGhpcyBzZXJpZXMsIExHVE0uDQo+IElmIHRoZSB0ZXN0
IHBhc3NlcyBhbmQgdGhlcmUgYXJlIG5vIG90aGVyIGNvbW1lbnRzLCBJIGNhbiBhcHBseS4NCj4g
DQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAta2VybmVsL2xpbnV4LWNpcC8t
L3BpcGVsaW5lcy8xMzExMzQ3ODA2DQo+IA0KPiBSZXZpZXdlZC1ieTogTm9idWhpcm8gSXdhbWF0
c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiANCkFwcGxpZWQsIHRoYW5r
IHlvdS4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


