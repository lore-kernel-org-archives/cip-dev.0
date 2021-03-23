Return-Path: <SRS0=Zp8/=IV=lists.cip-project.org=bounce+64572+6313+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF48C433DB
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 07:51:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92A4619AE
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 07:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92A4619AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6313+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vp3yYY4521723xMSYCultFjk; Tue, 23 Mar 2021 00:51:04 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.103])
 by mx.groups.io with SMTP id smtpd.web12.5727.1616485862247687971
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Mar 2021 00:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2oT7LjaMWjYMdEalxam0dh4qJ1Xer0oWcbZvcoj5qAnVmPU812P7JwoIt9bT3W/5Lona0R64u3gONkw0swLIWAN8YWWxZfiw4XyX3Vvebxz1MTVQB58gyHbQqkdkJ8qTw0zURVFH0cxPROtNsDNRiPOn2tqirIDdmE0RFxJ4fg3aPHx7a0C+LG5MWGpMFBq2QQqdE3C01o8XyDf2xLRhu3tsJMEUJ1PSjubwET5mYWpujzUxwtdWq9sA9jtAhHKjCwM7MybVe6WSs56eErFU2jjaDxNckL5qD0EM2Ku0hFJ9G1v2ozvM/z/JiHf9hxm7t2geeNDKx+d0N626aA1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouBpx3A64EhGpadYlH5M7erWnG61+jLzqKyT1HAmGpQ=;
 b=izI87xb2MJlBblEftERUn3LVM7c5An0yPC3XBBfyDj0zVjkqxdT13m18CmcLWSZeYWOYC9W2iAXYpx3xWc/9sZgz/x+pcLXjsNJZLnwVpNX5AQL80Pt5+jAPfPz/ul1rQlYXh+9Z+cwCKSa38+20IufODAHdPQcXej4GN6VpTZ3+bbkT9J13p6Yvy+TuvVW0XAy++Dd51kIlDKMo3YwZXBLWWj1+b5M5FO/9/iYS8bxuwu3caU650RUORw2nUynXbAbl2IYxR+HokApTv2C/QUfSuEVgEaH32x6hC+dHm+c7ozsPi6zDht2wBj6KjMiok70DSVAxZ/2GY0pSOQzCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSZPR01MB6280.jpnprd01.prod.outlook.com (2603:1096:604:e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 07:50:58 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6064:8513:28e:374e]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6064:8513:28e:374e%7]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 07:50:57 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/40] Renesas RZ/G2{E,H,M,N} add VIN, CSI2 support
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 00/40] Renesas RZ/G2{E,H,M,N} add
 VIN, CSI2 support
Thread-Index: AQHXFQKMlgedNTDhyE2AQ8aDsNQj6Kp83uMAgAAuUnCAE5jdkIAAnQIAgAAFKlA=
Date: Tue, 23 Mar 2021 07:50:57 +0000
Message-ID: 
 <OSAPR01MB2385C3E052E78BBC6D40EB26B7649@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB2983E11EB3496D43C5B6DC3892919@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <166AF609ACF1E617.19014@lists.cip-project.org>
 <OSAPR01MB23855CFB57061061DFE88791B7659@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <OSBPR01MB2983ECDB4D1ECED73360717192649@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983ECDB4D1ECED73360717192649@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.129.175.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48d223a9-1289-4a27-1f40-08d8edd0652e
x-ms-traffictypediagnostic: OSZPR01MB6280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSZPR01MB6280D5B256C615BA024F715FB7649@OSZPR01MB6280.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 1vHlNlMBw1whtBtGHqzwaQuXXGTdYFNNB1RalPhT8d9zkmulOEf4vgVtKBOHsSuUDZapdNHq6CROFI0RjhEw0CVhEHVs42d6weOVLT3DN1FtbKAZMCmwKIFQRjnipFecQZa0ber0sp+YkyEhYB4mmGkp96GWomANAHe3qeNQTIxvH1tB8DfJRnTNCiQCVqoHO1U4AqolwOAqZnnS23yBpug3zRla9/3QiOBsurRt319bTWncV9aVFyx/WlAetMeOXHjxbQdXksgm63mILU9e5eYMrSeWyCCt/NMEobW4Y3t7LsmCfjEPhJw+krimZwSuChvTYJatKFq/87MnZ571kBP9UMtD0Wilnjd5jLOsPZwJU/SAD3ufzf5K2ICkXn2XUb/NF3mzVKo6F8flEcSMTiiDLrPFDewY8RVu7b1Qr+cnI9ZSc//3V1QqKUm1YLYxD8Vm7ksqqueeGwDFTCV8QuyxfydSypnyLxSDdtGwnZ2NRb2WNz5j+xbWiKbeJrUdVjEkm6WOd8iSFG6vICNgdqShGOpfi028jJ90ovr4sc2xBC0R6aUDqKQbNiNftfnDJrF5fMBY0up3xeLjzgg2uwFvZaqTkMfP7jTilLjMb7KmSsTYVB83W4nvfEBLI/r2y+P7g4IlKpjZ+5oIx2i4UOY8TNP7upxjyaNb3VY1dn8=
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?SUdSR0xHYVQ4ejFqL3pKQ3RucUxQVXJRYWRQUXQ1UzQyLytWK3BRdTNyeVNW?=
 =?utf-8?B?aVNwSHhRRlh1VkZCRysvb29VTXQ2NkdaaG1zUGwzaHcrSmt2V09MUUFYdkpX?=
 =?utf-8?B?Y0RuaGZWdWdjK2d1TEJaTjRtM0o3bWQ2VVI3Z3dVbnpuNG1XTnM3Nm93dXNM?=
 =?utf-8?B?NmVKczhhZG5rQ0x3WEF1YTVKTG1Oc1FROUpHTjRPUXg5SWtGZVo2VXpxZDNV?=
 =?utf-8?B?VFUzeHRtUnZOVEt6TTZBUzdMeEZoM2RWNmtDbXZLZVZyUU1KcWh1bjUyYUZT?=
 =?utf-8?B?cTI1V3c5VzZjc0Ryd2k2SmFrVWY2ZUtXalVBaWNERmlvZURxKzUxSlEyZUNQ?=
 =?utf-8?B?U0t5OGhNeC94L1lUS0tuYVhUUFoxaHU1OG1yRTl5cnFMMVN4ZStzak52aDNK?=
 =?utf-8?B?RTc1RHhrdDZhWmJMdU5jdkpTT2xkU3d6MEVFS0xUSGlXMnkxcHBTV3RVTWdr?=
 =?utf-8?B?OVBkRnlLMVRFSmZFa0xtYVhKQjJ5WVJ3VDFaVy9QR2d6ZnVtUDVhNVhaL2hQ?=
 =?utf-8?B?bmU0ZXV0LzNVZzJOejVjU09QcDltbWJFV0JpSmJiY25NUkdrZTFmYVpYZGZL?=
 =?utf-8?B?YUtCSVdNQ1JOM2dWZjhOVGtEbVZtUUc1L3ZZaVZ5MFFUajFiOGszNS9vMDJp?=
 =?utf-8?B?enlzcms5QWdZMmxHUG80b0ttQ1dmOG5CZFJhRzJXVXFCeGNaMjN5UjBBWDJU?=
 =?utf-8?B?T1hFaWlzbFVUTC9Ea0l5R1R6bkl4Q00xS0NZanhxMzlnZjZTdGpidFpkS0RM?=
 =?utf-8?B?b2VOcjBzVCtYazd3d0FVVXk3Z3pYVUNPY0Q5RWcrQWdjQ1A5dWZncUxMV2Jo?=
 =?utf-8?B?RndVWWhzY1dtdlZFRkRTQklDVGVOdytpSUJqc012aWIwSGNTcmc4U1pFd013?=
 =?utf-8?B?SkhHYzFLTzI0L0ErR2hIS21TSWFoNDZYOHVDS3BIRDI3SHVaQUtrS25WVUZz?=
 =?utf-8?B?by91cnhYa0Y4YjFRSTkzaWNaTkFzYkM1UjJHUlp5cXZMMzU0V0ROcmxJb1RR?=
 =?utf-8?B?ODRyOCtoREVGZ1gyZUl0bjVSRzVnaUMwVHRrQ0ExaWhodDFZendDNWtxdFJH?=
 =?utf-8?B?UzhoUGY0ZVpOS3crb1pOTUVkd3MrNDJsRWZyQmpBbVdTbzlWbnZ5YldNRHR2?=
 =?utf-8?B?Qi9pcksyWUFjOTR4TEZYSVpXZXBSRFVIZitqSDRMUlBGQUxTUFEyTnkzZXBJ?=
 =?utf-8?B?aGVuMXpWNkxVeHE2aWtybmhQK09ubE1YVlBqMVpqaUFqdlRTN2VUakZQcDFi?=
 =?utf-8?B?cmxCazF1dUxBeWViamZaemhNSjYrSUd5NEN2OU9kWlBzNzZTdTZFZkdnd1di?=
 =?utf-8?B?NjVuemdvVkdaYzd0d21DeEUzN1ZhSXNVMXBUQkVic2piaXB1YytXN1lrSnJ1?=
 =?utf-8?B?dWFqNHVZQWlCM3VKMkRiZ1JNUU50K2d5eGhOT1hPeXZtZ05JbWdCWWtTMlBa?=
 =?utf-8?B?UVpuc2pYMlRuRENIblBFQnMwVGdxOUg1akY3c2VJcUFKM2ZzUDRBekVJbEE4?=
 =?utf-8?B?aWxjRDkvRUFTVWNmTUpKRzZ3VHNTaVFUMFU5Yllla1hIMW9JMElPMzFOZDFs?=
 =?utf-8?B?UFVndElHS2tNelNTV2lOb1Yxb1N4YzNkdDhxUWxaVWhJWTNONng5aUlraXl3?=
 =?utf-8?B?ZWxrekh1UUdtcURleFdseHdQRkxYMzQyYkRmYXlRSUhhVFRyeThmanV4cGY1?=
 =?utf-8?B?aUJJOXVndkF6SEVvOFNIcks1MWpyQ0lwbjg1aktBOWtQdXN6c1A2SStCa1d1?=
 =?utf-8?Q?50Em6a7zpnh2ZeEOnp2WQVXOUMYbdeuRNkt/p/y?=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d223a9-1289-4a27-1f40-08d8edd0652e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 07:50:57.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQWMJWoIJQ873od1OKtKfji7dVTLq1Ghki8Aouf8aTx5JTRQZkSaXSDmr6g914HLMK1l8oCbQHP0IuSw6vIVjsPBxEY41AST+K/6DP4Enss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6280
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pdc3dEQ2FLgKLzsmCJc1j02Lx4520388AA=
Content-Type: multipart/mixed; boundary="kskPrrf9Io2dqSNWEsT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616485864;
 bh=GEN50w+33o2KMx+WMDBUw0LYE5E6SgkVu20ELWPmFb4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=PTzUIyaG3NhKGN0WRElHAKmL51UcB2nxmJSX7GF2ADEzeIS0ex0x4rB+4rKBu5uTg2D
 ucBTXvWxNEFwQ8F0zu02zaTUCmDblib8e1X6/MjK0+4OmCb4jRGOCmYKd+mTY7yWJcrQB
 8hdberDN7nGWeiR66K3ouE3IDtAxF29oWd0=

--kskPrrf9Io2dqSNWEsT2
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBGcm9tOiBub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcA0KPiA8bm9idWhpcm8xLml3
YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IFNlbnQ6IDIzIE1hcmNoIDIwMjEgMDc6MzINCj4gDQoN
Cj4gPiA+IFNvcnJ5IGFib3V0IHRoZSBsYWItY2lwLXJlbmVzYXMgaXNzdWVzLiBUaGUgbGFiIHdp
bGwgcHJvYmFibHkgYmUgb2ZmbGluZQ0KPiB1bnRpbA0KPiA+ID4gbmV4dCB3ZWVrLg0KPiA+ID4g
SSdtIGhhcHB5IGZvciB0aGlzIHNlcmllcyB0byBiZSBkZWxheWVkIHVudGlsIGl0J3MgdGVzdGVk
IGlmIHRoYXQncyB3aGF0IHlvdSdkDQo+ID4gPiBwcmVmZXIuDQo+ID4NCj4gPiBUaGUgUmVuZXNh
cyBib2FyZHMgYXJlIGF2YWlsYWJsZSBmb3IgdGVzdGluZyBhZ2FpbiBub3cgOikNCj4gPg0KPiA+
IExldCBtZSBrbm93IGlmIHRoZXJlIGlzIGFueSBmdXJ0aGVyIGlucHV0IHJlcXVpcmVkIGZvciB0
aGlzIHNlcmllcy4NCj4gDQo+IEkganVzdCBwdXNoZWQgdG8gZ2l0Lmtlcm5lbC5vcmcuDQoNClRo
YW5rIHlvdSENCg0KS2luZCByZWdhcmRzLCBDaHJpcw0K

--kskPrrf9Io2dqSNWEsT2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6313): https://lists.cip-project.org/g/cip-dev/message=
/6313
Mute This Topic: https://lists.cip-project.org/mt/81205345/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kskPrrf9Io2dqSNWEsT2--
