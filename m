Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC284E81BAF
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 12:28:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46253.1770640095413858361
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Feb 2026 04:28:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 619CSCuX1266965; Mon, 9 Feb 2026 21:28:13 +0900
X-Iguazu-Qid: 2yAbwLOjznbsUWRsa9
X-Iguazu-QSIG: v=2; s=0; t=1770640092; q=2yAbwLOjznbsUWRsa9; m=Btl6S7e3oPw0R50i3SD/ZR1Kb7ew/kbTeabrOn367hc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f8kW02ll7zyPQ; Mon,  9 Feb 2026 21:28:12 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PApYErwtt+5B0p22oLCfydV9IoA9tA5vmZl8JDgOI6dweoC7Nkw7etIJUnbnXoI78Iwiw5OW77tZRcGKrNbcz+DvQ7KNDEfopFr3GFO12vYcNsE64K4bNArv1QfVpEmrX5ReuML0RwGYCNWqGp+iC+mKjPbX/fQ0V1V8GJoLKoVDTSue6scpf7BUDoasC9CcYAlJsrTD+BAGpbtABfBqBNEy3PgTEiv5gpXXYs8n13gZMHxmqj/TmLEbFnkbVYWd9TXr7Mb8F19hggnuS4R7W9MW8p6RcklkleASxzoSdqi9MsDwL9oi0Kv2RuXzgI0op2cmxM28lra5/YJomYkEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxb47EangtFddwW0vKGtQXh12yrYVOiGildUTF/aEwY=;
 b=lKSFXo/A01KEyZQI9zQyIY2b+Qg4qAK/SBzX3+VWsjmAx5N0ZkDTX+/1tWioXMvWNaivulrwRKQSRZGrtXwJbLPpGD5SWNwHSudte0YpXd26Ywgy4m1b32Xf3lUMGooT6gMvMRffB/w+4wuzxjFIHD9kF5EyoL/JQdyUsZ19UMsfN56nEPj7gmaqEJik5ButG9Itjf3IcYe0FaBkuFh9lz/cUR7Mqeig8fsINxzNaG/Xk56PbeDft4KL0QiVi+C+t+b5CY+CQBdVyyFuFSaFQhhbqxT1PO5q5vWv4hqQcp23aXH7W1XkKkNLrbW9jSwamtrVpClFI11ivKqP0FYeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <koshiro.onuki.h55@mail.toshiba>, <kazuhiro.hayashi.f74@mail.toshiba>,
        <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3] doc/README.factory-reset.md:
 Minor corrections, verification steps and what to look for during factory
 reset
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v3] doc/README.factory-reset.md:
 Minor corrections, verification steps and what to look for during factory
 reset
Thread-Index: AQHcl09ag7AnOZ/yv0qGp4shH+IghrV6UExx
Date: Mon, 9 Feb 2026 12:28:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96699658796CB7F2AF0849A0C465A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <18919FF084310FCC.3854048@lists.cip-project.org>
In-Reply-To: <18919FF084310FCC.3854048@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TY7PR01MB14520:EE_
x-ms-office365-filtering-correlation-id: 8bc7b178-02ad-4169-d079-08de67d6ae79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|14052099004|7053199007|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?c09XNXNPc3RKc1hhRzQvY2tmaFhmK0ZpVHJFalNnd25ST1RXeWtFcUhU?=
 =?iso-2022-jp?B?VXRvK3JkbnNxbXRrNCtKbmRJcGN4MlQzMHVKK3pSOFgxUFBpRHJUaXZF?=
 =?iso-2022-jp?B?K2dWTi9GUGdCWUZpdFFZeFBmSm5SNUNmNkpBYUFWa1RxVUVrY2ZLdUFk?=
 =?iso-2022-jp?B?aUJ6amhTYUpaMHJrVFhtOTdiQ09hM0RQUVpDRktNaXJZTTgwNzVIWFhR?=
 =?iso-2022-jp?B?bDRuZGhFV0lRckUvWitYeGt1dis4VTBpVUtPQVZyWXhIN1cyRXViank3?=
 =?iso-2022-jp?B?OCtCSUhMSmJpcEp4RER5WmNObGl1MW8vTis1L2FKUC9VZWNheCtXRjZk?=
 =?iso-2022-jp?B?V0l5ZVUvbUpNYXVmZlVNbUY5dWxZcVg0Z1ZkcTI0ZFBHOXBTSFNOa1g3?=
 =?iso-2022-jp?B?V3pUVGFBMjFRU25RZEZRd2w1cjBtUEgwOVI4UUhqd0taL3BuWDZ2Yy9Y?=
 =?iso-2022-jp?B?NjFidHZCK2VNTzFvcHRFQjVNOU5uZ1F6V0NzWmptR0l1enZUQkRQTHU4?=
 =?iso-2022-jp?B?VkJvZy9kdHdvWjlkVlJtU3djNHE4STdlU0xwSzJoVjFOeElqWmQyQTVi?=
 =?iso-2022-jp?B?MkxCOWlhUkxuNmNzWGtkZ3U2VHJSdk5XQ3VvM2hQQVAvblZlamxSeVJw?=
 =?iso-2022-jp?B?Q3ZiTU5kRGlIYkJHL2NVTlpTNnk2WVlFY081eXhLMndUWTZ3MFZkOVM3?=
 =?iso-2022-jp?B?L3g4cHRmV2xVMjhoOUgvbmpMeFY3NC9HZTVrZmhLUFREYmxZZlBjbFRL?=
 =?iso-2022-jp?B?QnhqS0V5Zk5TNW5RSXd3K3dwWUNiYmZWVFI2ZjRhWTN0TFNPMDNUdEo5?=
 =?iso-2022-jp?B?MWEvWmtpVm0xeWFlRGQ4eFZhNEhFV0thNXM1WG9vU3hEOTZUK0tPSVdy?=
 =?iso-2022-jp?B?MFd0L3B0UVJNMXdYVkZ6VGwzd0dTZ3N4OEZXRGMrRkRIWWR4OHhtbHp6?=
 =?iso-2022-jp?B?ZmNMUlhHMlBFUDNBODVZOWp3Mm9lZjhaaVFGb3JPL2hSV3UzcnNsZ29X?=
 =?iso-2022-jp?B?aVFCVzhTdmsvdEdKZk54K1VhVFcxRmhFK1lUYTVjM3RRdFlOeHE4Z3dV?=
 =?iso-2022-jp?B?cVRKZGlIQXBqNUd6YnlJMys4Wm9iTE12R2ExYmtvQkFaNlFPTExDaDVq?=
 =?iso-2022-jp?B?OFdBc3FlMkhoTy94cTgvdEhIR1U1SC9mS2pETW5XY0FhMmlrUmx1a0dt?=
 =?iso-2022-jp?B?bm1PdVpQb292Kyt6cHA2VHhMa0dlbUZITFF6NDlXOEJSc2pLUXJIaC9F?=
 =?iso-2022-jp?B?MS9jNEVWV2JISlBlMXgraDFueFNiN2cwRDBQYlJYUy9wS1ROTkZIZXZB?=
 =?iso-2022-jp?B?WGlkMCtHaGg1Tm5kWHF4VWU2S1kwYm5PQ3VIWWMrMjVkZTZoN0dFSitO?=
 =?iso-2022-jp?B?ZVdhUzNpZzRhSWt3bU92Q0JobUU1Y1BjMlYyVUhMRTFZL3VHbTBxUUJ6?=
 =?iso-2022-jp?B?RmFuRW9VUDZtYXZFU3k2dFNROGtxbGZHRDVLblpPWUNJankwZHdsd25j?=
 =?iso-2022-jp?B?amovbldrbGJqNDdvSFFsK3dFTTlXNlFBeDhVdDRDTXloaHBzNDQ2RzJi?=
 =?iso-2022-jp?B?aEpJZ2JGSHhneHFFY2dzeUkybHAzME9Pbk9Ta3VIWFhKY0xrRjUxMGRW?=
 =?iso-2022-jp?B?eHBLd3R1eW55QTZxZk1DeEN2M3BISnhhY1hxblFab0tjOTM2UHhERHQ5?=
 =?iso-2022-jp?B?bzhBcGx1MDFQWTIwZTg5LzZKRE55S0VxelBUNVczdG5ob3pLNHNrSE1n?=
 =?iso-2022-jp?B?TlZEU2V1S3F5SEpTVW9hdGtVVExXemFOVGFlNXZ2YXN3YlZyY2YwbVFK?=
 =?iso-2022-jp?B?K0t3R0VCdWU2emhRVXhGTlUyZW9lWmpkL2p0MzNHSGpsUHhOaVp5Q1N2?=
 =?iso-2022-jp?B?czJ2NTg2R2RzdFNTRThla2tHR3ZuQ2hjeUNWLzg0YUhRRnZIVzRPdkZp?=
 =?iso-2022-jp?B?T3ZSQy9NN0VJc0F1N1Fyd0hGYUJvdHEyTXdJb3ZaaWJYU3puVXB4dHpM?=
 =?iso-2022-jp?B?a1hrSjdvelkrMk05MkR1VWtnM1J2SzdpTEhLOEsxOGFRaVdOWmtvN0xN?=
 =?iso-2022-jp?B?K1gwN1Q4RHhBLzRmcmV3OWlGVE1rS1pQdWVoekl1NG5yRDBiOWlxSCs2?=
 =?iso-2022-jp?B?d2NiRXpEQWJmVEYxbzdwdEJWWDBGMmUrK2s1dGJDVmRTYVRoNXN4anRF?=
 =?iso-2022-jp?B?NmJjdnJqNlliN2U4ZVB6cVZ5YWhyNU5Xd1FRcERvMnU0NTRDUUcvWWpJ?=
 =?iso-2022-jp?B?bUNhemN3THBJRGM5TnlhbU0rMnBJNk1seElTMHlrK1BuRC9GeGk5bWRG?=
 =?iso-2022-jp?B?d3ZNSWFWVVZWQnZUTXNRVXRxR3ByWXJ3dzh6RkhibWFhR1k4Q21Ucmw3?=
 =?iso-2022-jp?B?ZmgxS3BtYVJKODl6cmhwUm9ZTUllQmlTcXZWYXFKUzB1NzRQdDRnK2JT?=
 =?iso-2022-jp?B?ZzR1cWxnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(14052099004)(7053199007)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NGN3a3hJWEpjaEMvNmJjdE5lL1h2bm9vOUoyWDIyeC9tYXJRNlNvUC9m?=
 =?iso-2022-jp?B?b1lIczNmcE44Q1FIaU9zclBZd2ZzQ05xZCtGWk1obGY4dlUrWkxJdVJZ?=
 =?iso-2022-jp?B?TDk0Yk1oQVhGNVhJQmptSnIrTWRxbzB0R1pkQUFqaFFYQWdyY1MxZ1Fx?=
 =?iso-2022-jp?B?Y1F2UHJlRjN0eTgwOEZDWlpIaDV1aTZOM2xwdmdnYWFDemsreDB3Z3VL?=
 =?iso-2022-jp?B?Sjl2YjJ4cWt3OXl4bVRmVTVwcC9BZG1mall2b2tBek8ycEprSnR2dkF0?=
 =?iso-2022-jp?B?YThYSUpHYXJyOG93K2k5TUhhZUZQNXZsc0xGc2RFU1pwcDMxbEo4aDdV?=
 =?iso-2022-jp?B?SnhKcm81VXVsTllkVjJlQ3p1T1IrSjc1a2E1bzIvcjV3VkpmaWdCRHg1?=
 =?iso-2022-jp?B?bzRuRjdobHd6TXovd3l1RTZKY1JsaGNCeXJPcmZjM1h0Y0NzTnNtazcz?=
 =?iso-2022-jp?B?WVI4V1ZYb1JqckVHNXJCeUJuMUUveDVuR3RrRE5lREFYY0VOZGFHSEx1?=
 =?iso-2022-jp?B?WXVGemRlVWFOcjdSaTU0eWMyR1B2Ujl1QTVPWEE0NVhTWU9KblZMOWh1?=
 =?iso-2022-jp?B?NFdQOEVRODJsR29jQVlSeUpYUEtwc3NCc01INzdVcXcyOWN2a3ZVc2Rq?=
 =?iso-2022-jp?B?MEVPYjZFT0hBRE5FbUlPYTBJaFhzOWdsTldEKy85Y0JtelNYanFnUGho?=
 =?iso-2022-jp?B?R21KMzIwWlZQcUxCUGUrbkR1UEFDU0lhdUdrdENHM0U2S0lrY3Yzc1U5?=
 =?iso-2022-jp?B?OWVmTFhSOGZYT0FxTHVJbWZDbUNvbHV6VjRJb2VhdEV1N0JYTFZ3Qkdu?=
 =?iso-2022-jp?B?bkUxdmE3NTl6bnp3bHVFTUxLL2RtV1hjUTJtSVdiUW5wazhBSk9TSDR5?=
 =?iso-2022-jp?B?NERtcDlhSERMeU56L2hWMGtWWU9oUCtIU0h1L0tQQXc0N1Ntd0xhWjBF?=
 =?iso-2022-jp?B?dkJDTlhRbGdCOTh0YmhtK01hR1hBakdlK1BKYWUrQVZKc3NmUkorL2M2?=
 =?iso-2022-jp?B?dGs3b24yT2plaUhJTkg2Rm1sS3ZpNnFMS2M2dzhhdkRML3lVWXpUU3Rv?=
 =?iso-2022-jp?B?RmZ4YThQWmhUcDVQbGdhWHAvUDV6Mkw5d3lqRmYwL0NiSzYrRld0L0Fj?=
 =?iso-2022-jp?B?cEdhYzh1L0xZNUE5eHh2dW1ROCtZcmI0SlJERUhWV1F5NEt2V1JLUWc4?=
 =?iso-2022-jp?B?RjVKeUg3R2ZmUkcrbnhUT3UzUW8xWnU1UHJuRHFFalMvQXRIQzBEcko3?=
 =?iso-2022-jp?B?OWdCZ1crMG1rTGtnR3ZZeTRIWDRHcU9mTkVhSnViRWpxT1ZSQjJhRHcz?=
 =?iso-2022-jp?B?LzlMVmNpVzc1d01tbEVJM21kNmdCYzNPb2tmdGM1TWd0OEUvcEhDSkp4?=
 =?iso-2022-jp?B?NWZpOXAvU3BSbGdvNXhDeHpSRzZ6Zko2enNjZmZMSG1nRnBjOUNFcFNh?=
 =?iso-2022-jp?B?b2NPRXpWZjRhQzZUNzFYYWlvaklVUjhuUExOdVo2TmRzcFE5VC9CYVFT?=
 =?iso-2022-jp?B?UlRoRnRSOExlUU8xVWg0QkI1SWliUmQzOEVHazRaOHl3YjBYekpxNC9z?=
 =?iso-2022-jp?B?R3VIdWhPaFFoeTY3aDlDSVhpclBzVGdIOEovVXloOVd2VjZZbE54d1p6?=
 =?iso-2022-jp?B?ZmNKRGt6N3RlMkFSY0g3QWx2Sm9HT2pIc1U4Y25iVGc3VXZ2OGNrY0xH?=
 =?iso-2022-jp?B?UlpXSEs4MnNGdkxHaG1KdDh1bVNMRTR4K083c1BiMEkrL1JhaFlja29u?=
 =?iso-2022-jp?B?Q2hvSjlaczhrNjBoamVUWTVoWDR2dzBVNHl6alljZHo2YloxWDU0TlF2?=
 =?iso-2022-jp?B?WUF4WlZVVWE1WUdkcmJBWDFIVnNkV0YxRlNrUzBUajUybUtFU29TRnpU?=
 =?iso-2022-jp?B?NVVTaWxWT25kMFlDTENGL21sMEFwMi9LV2F6QU1zaklUVmFVZ1M4U25v?=
 =?iso-2022-jp?B?RVVNakRwaTVPL0ZEYzZrT0dYV2dSaDd1ZnNMYTRSWStURnBQUzZZZWNu?=
 =?iso-2022-jp?B?bldwZitQcHdkTGFSOEN6L1VCbmRnSmNXNDE4WGp6bHlXcVpoQk9mSkJS?=
 =?iso-2022-jp?B?VmQ0ZjJ1b0p1Q0tvb1YrZG5sMU1zaTQ4K2VMWXc2NDFqZnJaMTluYVBu?=
 =?iso-2022-jp?B?TGpkMklQV2RBR0hZNHRhd3E4UXRHaEdaWG1yRFl5d0RmL21ocFRWRFE5?=
 =?iso-2022-jp?B?dEtibmtSWDAySjNwYW91c3NNVFd6SXJUWUI4U3FTQlVhK1Q1SGZhbWs0?=
 =?iso-2022-jp?B?emphWVc3ZGpqZE13eUxIVXBGUmxJRDJXbVdBN0ZQT0M1SXROUytsTFdo?=
 =?iso-2022-jp?B?TmM4Zk51VHU5dlRTbnAzdmhEeE82VlhoUXd6c3VnRERIN0VVdm8zU2Mz?=
 =?iso-2022-jp?B?czZtNXJoQWU2RWk3aThJVmJkR2tQVll4MldLN2ZnQnUwY213enRiNStO?=
 =?iso-2022-jp?B?c0toVG5YSGlDUm5naEt3WHRNc0ozeDFUMThXcURsTDhGZm1nY3EwLzVO?=
 =?iso-2022-jp?B?eFlzTHE2OFRaRGc5cXBVVjZ2NHl3RHh3czB2alFJUnVQcjZRQlA4Z0V5?=
 =?iso-2022-jp?B?OWNoTkZ5ST0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB96699658796CB7F2AF0849A0C465ATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc7b178-02ad-4169-d079-08de67d6ae79
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 12:28:08.0756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geDdLLZNCT91xxATpKhv8TpmYCJ7R/4R+CWTukJsujpLXYQitcUfULmEOzGQUa+ZjtvwmjtbjM3XtUDNPPxX/fG/y1kj9a/V3Q2AwBG/b3ScLVZVwiEu0KQ9Or6T/KgO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14520
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Feb 2026 12:28:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21848

--_000_TYCPR01MB96699658796CB7F2AF0849A0C465ATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Any comments on this?

Regards,
Adithya Balakumar
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Sent: Friday, February 6, 2026 3:29 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; jan.kisz=
ka@siemens.com <jan.kiszka@siemens.com>
Cc: balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=1B(B-=1B$B#O=
#S#T=1B(B) <Adithya.Balakumar@toshiba-tsip.com>; kunijadar shivanand(=1B$B#=
T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh k=
umar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>; onuk=
i koshiro(=1B$BBgH4=1B(B =1B$B8v;JO/=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <ko=
shiro.onuki.h55@mail.toshiba>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B=
 =1B$B""#D#I#T#C!{#C#P#T=1B(B) <kazuhiro.hayashi.f74@mail.toshiba>; quirin.=
gylstorff@siemens.com <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH v3] doc/README.factory-reset.md: M=
inor corrections, verification steps and what to look for during factory re=
set

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.factory-reset.md | 40 +++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
index 729912b..aa8dd1c 100644
--- a/doc/README.factory-reset.md
+++ b/doc/README.factory-reset.md
@@ -1,18 +1,18 @@
 # Enable Factory-reset

 To enable the factory-reset functionality the following two elements need =
to be installed:
- - initramfs-factory-reset-hook which executes the factory-reset
-  ```
-  INITRAMFS_INSTALL +=3D "initramfs-factory-reset-hook"
-  ```
+- initramfs-factory-reset-hook which executes the factory-reset
+```
+INITRAMFS_INSTALL +=3D "initramfs-factory-reset-hook"
+```
 - factory-reset-helper which provides the helper scripts to set the factor=
y-reset marker
-  ```
-  IMAGE_INSTALL +=3D "factory-reset-helper"
-  ```
+```
+IMAGE_INSTALL +=3D "factory-reset-helper"
+```

 ## Technical details

-The by executing `set-factory-reset.sh --create` a marker is stored as a E=
FI variable or on disk (default `/dev/disk/by-partlabel/efi`).
+By executing `set-factory-reset.sh --create`, a marker is stored as an EFI=
 variable or on disk (default `/dev/disk/by-partlabel/var`).
 The marker on disk is intended for devices which do not provide the facili=
ties to set EFI variables.
 The initramfs reads this marker and formats the hard-drives provided by th=
e variable `INITRAMFS_FACTORY_RESET_DEVICES`.
 The initramfs-hook will try to detect the previous used file system and wi=
ll format the partition with the detected type.
@@ -27,3 +27,27 @@ The removal of the TPM keys can be deactivated by settin=
g the variable `INITRAMF
 As the factory-reset is executed before the disks are unlocked in the init=
ramfs, the file system type must be provided with the
 variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of =
encrypted partition is not supported with the file based
 marker.
+
+## Verification
+
+- Create a test file in a target partition (ex: `/var`)
+```
+root@demo:~# touch /var/to-be-deleted
+```
+
+- Set the factory-reset marker with the below command:
+```
+root@demo:~# set-factory-reset.sh --create
+```
+
+- Trigger a reboot as factory-reset happens in the initramfs step:
+```
+root@demo:~# reboot
+```
+
+- Factory reset runs during the initramfs. The reset scripts format the ta=
rget partition with the required filesystem. If disk encryption is enabled,=
 the initramfs scripts also encrypts the target partitions. Both of which c=
an be observed in the boot logs.
+
+- After the reboot, confirm that the test file created in step 1 is delete=
d.
+```
+root@demo:~# find /var -name "to-be-deleted"
+```
--
2.39.5



--_000_TYCPR01MB96699658796CB7F2AF0849A0C465ATYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Jan,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Any comments on this?</div>
<div><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Adithya Balakumar<span style=3D"font-family: Calibri, Arial, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br>
</span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsi=
p.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, February 6, 2026 3:29 PM<br>
<b>To:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project=
.org&gt;; jan.kiszka@siemens.com &lt;jan.kiszka@siemens.com&gt;<br>
<b>Cc:</b>&nbsp;balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=
=1B(B-=1B$B#O#S#T=1B(B) &lt;Adithya.Balakumar@toshiba-tsip.com&gt;; kunijad=
ar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Shivanand.Kunijadar@toshi=
ba-tsip.com&gt;; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.k=
umar@toshiba-tsip.com&gt;; onuki koshiro(=1B$BBgH4=1B(B =1B$B8v;JO/=1B(B =
=1B$B""#D#I#T#C!{#C#P#T=1B(B)
 &lt;koshiro.onuki.h55@mail.toshiba&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$=
BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) &lt;kazuhiro.hayashi.f74@mail.tosh=
iba&gt;; quirin.gylstorff@siemens.com &lt;quirin.gylstorff@siemens.com&gt;<=
br>
<b>Subject:</b>&nbsp;[cip-dev] [isar-cip-core][PATCH v3] doc/README.factory=
-reset.md: Minor corrections, verification steps and what to look for durin=
g factory reset
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">From: Adithya Balakumar &lt;Adithya.Balakum=
ar@toshiba-tsip.com&gt;<br>
<br>
Signed-off-by: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.com&gt;=
<br>
---<br>
&nbsp;doc/README.factory-reset.md | 40 +++++++++++++++++++++++++++++-------=
-<br>
&nbsp;1 file changed, 32 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md<br>
index 729912b..aa8dd1c 100644<br>
--- a/doc/README.factory-reset.md<br>
+++ b/doc/README.factory-reset.md<br>
@@ -1,18 +1,18 @@<br>
&nbsp;# Enable Factory-reset<br>
&nbsp;<br>
&nbsp;To enable the factory-reset functionality the following two elements =
need to be installed:<br>
- - initramfs-factory-reset-hook which executes the factory-reset<br>
-&nbsp; ```<br>
-&nbsp; INITRAMFS_INSTALL +=3D &quot;initramfs-factory-reset-hook&quot;<br>
-&nbsp; ```<br>
+- initramfs-factory-reset-hook which executes the factory-reset<br>
+```<br>
+INITRAMFS_INSTALL +=3D &quot;initramfs-factory-reset-hook&quot;<br>
+```<br>
&nbsp;- factory-reset-helper which provides the helper scripts to set the f=
actory-reset marker<br>
-&nbsp; ```<br>
-&nbsp; IMAGE_INSTALL +=3D &quot;factory-reset-helper&quot;<br>
-&nbsp; ```<br>
+```<br>
+IMAGE_INSTALL +=3D &quot;factory-reset-helper&quot;<br>
+```<br>
&nbsp;<br>
&nbsp;## Technical details<br>
&nbsp;<br>
-The by executing `set-factory-reset.sh --create` a marker is stored as a E=
FI variable or on disk (default `/dev/disk/by-partlabel/efi`).<br>
+By executing `set-factory-reset.sh --create`, a marker is stored as an EFI=
 variable or on disk (default `/dev/disk/by-partlabel/var`).<br>
&nbsp;The marker on disk is intended for devices which do not provide the f=
acilities to set EFI variables.<br>
&nbsp;The initramfs reads this marker and formats the hard-drives provided =
by the variable `INITRAMFS_FACTORY_RESET_DEVICES`.<br>
&nbsp;The initramfs-hook will try to detect the previous used file system a=
nd will format the partition with the detected type.<br>
@@ -27,3 +27,27 @@ The removal of the TPM keys can be deactivated by settin=
g the variable `INITRAMF<br>
&nbsp;As the factory-reset is executed before the disks are unlocked in the=
 initramfs, the file system type must be provided with the<br>
&nbsp;variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-rese=
t of encrypted partition is not supported with the file based<br>
&nbsp;marker.<br>
+<br>
+## Verification<br>
+<br>
+- Create a test file in a target partition (ex: `/var`)<br>
+```<br>
+root@demo:~# touch /var/to-be-deleted<br>
+```<br>
+<br>
+- Set the factory-reset marker with the below command:<br>
+```<br>
+root@demo:~# set-factory-reset.sh --create<br>
+```<br>
+<br>
+- Trigger a reboot as factory-reset happens in the initramfs step:<br>
+```<br>
+root@demo:~# reboot<br>
+```<br>
+<br>
+- Factory reset runs during the initramfs. The reset scripts format the ta=
rget partition with the required filesystem. If disk encryption is enabled,=
 the initramfs scripts also encrypts the target partitions. Both of which c=
an be observed in the boot logs.<br>
+<br>
+- After the reboot, confirm that the test file created in step 1 is delete=
d.<br>
+```<br>
+root@demo:~# find /var -name &quot;to-be-deleted&quot;<br>
+```<br>
--<br>
2.39.5<br>
<br>
<br>
</div>
</body>
</html>

--_000_TYCPR01MB96699658796CB7F2AF0849A0C465ATYCPR01MB9669jpnp_--


