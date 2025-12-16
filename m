Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5716D5E151
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 13:29:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22429.1765891775315199599
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 05:29:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=fZYRgFpi;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1765891759;x=1767101359;bh=SvmUZ8TfdRjbs43doZcZ33LEKAchV8uEAI3Tg
	T3osgM=;b=fZYRgFpimVAwPzDgN7v+qYWcENK+2sWCpOH1lbgvW1kG8M7Z2MjZQnx7Dqs8WisbUMv
	PS3/qLSnzkVovBwYCtGwwrzuV1KO25U+xpl1McKjdYSKE28rS0kcpRcDyTzOhRgNXBquJnNC7yANo
	CvScxeC+TlEY4gc6DEYgQQ+zl2msaEfCx+Hxo/4kbfRdhV4A+5Rb3j3UO8OOJzweWmkGBMxbYtFx2
	yAMeBhdUxBiXrZBk3zvCyL5h6O1NlX27YP7iebGkvUMoCwzbDWqeGrKJ9Y7kCUCbbFn3uKSRRUaKE
	sITcay3nBOewjFJHNKxw4mN8n182wGmIfzmVvay5L9sQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5BGDTIWg3067117; Tue, 16 Dec 2025 22:29:19 +0900
X-Iguazu-Qid: 2yAa7S8R41TnvTQFXc
X-Iguazu-QSIG: v=2; s=0; t=1765891758; q=2yAa7S8R41TnvTQFXc; m=t9eNIOpCxTjf75Tcgq9V8+DgR6tmtqra8FX2VfXlWPE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dVySt3Y70z1xnZ; Tue, 16 Dec 2025 22:29:18 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRssm8U68IsHJiAU0iHTVLGwVQiYlYEG1wHfhR/3FtsEEqeeWhwTM+BathZ9AZmocksDurcZZr9v5O/bPc8Em3QNNm55lVxnFOIwHONRu2AVluldY+GpkZbalV7bH726YgT8+NXTBmXcppQf7JDnyPbhoJDoR4gj0VAdq9MEofaVlhUmrXVSsCM2XodpbzT2gW3HewOBo6G+O1H8VUmsHq4UNQHTbiR0o6yyTAnGznGKTAHzLUPV2z4h2XDUD37oV+h7+oYCul/Yi04tbo1hTg9ibh2S+mrXnBjWMXgljNJcIW48VVzpiK3w3drlv2u3p1z+LNcbAVJjKLlu5v65pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COQUGZjeyuKlBAY4driFhea5GfwFP/tg1fQVYkhIsUs=;
 b=IgH/YMbMi3cT25R+GifKbryR5vcbWklGeIjN7J5WV58Vx9hBxOM48SXbi0bOx4a4NcmHx7nCLNkeQH1eWdaCY67lp8iIlbCA1oDsSwVJyflrsNeYemzZq2ugZHpPhEdZ5dIUKWOVxO1HYxA0G/Rk61pvj7yFyRSVOaghjNoVf/kKjj5QcVG54Dq03FMgWXUMY04R7tYzoAyxIYRmSmpleExHLAqdz4HvfbxqapJ1jifBvU+n2ihYlj7RPcfIry+0yAoYtsAHfNatjWBJiCgjeWSJzdDYCsPnGoGuSkTJDZnUf9wOzFEYKFyaB0wwuWpRVo6JZ4x5Q/OUlhdQrwiLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@denx.de>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Add 64-bit
 polling support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Add 64-bit
 polling support
Thread-Index: AQHcbU1hcK+14a7xykyPtYJ5KgamIbUkLLmAgAAX9RA=
Date: Tue, 16 Dec 2025 13:29:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481822C9BB7AFAE7AD8DD413CDAAA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
 <aUFKBR8JII4rHjNg@duo.ucw.cz>
In-Reply-To: <aUFKBR8JII4rHjNg@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB14558:EE_
x-ms-office365-filtering-correlation-id: e7c95b36-b66c-4e8d-048f-08de3ca71c0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Z1E4NG1FbE1jUExMVzFMSTV0UnREQjlTSnd6YUUyYSt0bis4TGQweVZI?=
 =?iso-2022-jp?B?aVpVY3BnR3pOaHJlLzZrMkFwYUxkL0V3OE9tdS9WcGw2WW1TVW4rUTI1?=
 =?iso-2022-jp?B?RkpQckIwK1hoU2JxSlVScmpEM00xSGQvY0w0UEFYY0N0NmtGbHpIejVR?=
 =?iso-2022-jp?B?QThUUnlxSlFIVTY1aDE2N2RGZDdVd1JaS1ovNmI2VU44c3ZSb3RkbDJ2?=
 =?iso-2022-jp?B?cURIOUlRWnJneDhxL1FjSklzVmc4ZmlNbmVJaWI3Z2RPWTFDMzRScHI0?=
 =?iso-2022-jp?B?dDU3eFNsY1VXNmFjUU1GQmtwMXdUaXZzenNQT1BvcXVueWt6TU5NS3Qw?=
 =?iso-2022-jp?B?eCt0cko2c3ZMRy9RenJLZzFjMU9PYUJKaWR5Q0xBdWJWVTZWVUNIRzZZ?=
 =?iso-2022-jp?B?cjFzL0w4OWtQcnc5VXpwYTM1M005ZzJRTlRzS2lCcldKN0lZdWhjZEZQ?=
 =?iso-2022-jp?B?eldFUjc4RFh1bEYyR1F6MUo1N3RzZG5pMlQyVFZIdGptK1UzUFpVd2VT?=
 =?iso-2022-jp?B?NzdmaGI4RW5iYlJJMDlWM3ljamdwY0JhMHB0bHNyUUs5TWNkQk1Dc0hz?=
 =?iso-2022-jp?B?VmxvQVpBWWdybTJ5amdPUDVEUjA0NVoxenZkZUtTUXpBNi9PQ3kya0Yv?=
 =?iso-2022-jp?B?TmU0VUl2K1BnV1F6b01LTGxTT3duQ3ZjR3RXOVBFSjZGSWYzVkgrandW?=
 =?iso-2022-jp?B?V2NsNTJjVVdFOERTRTRPdjQ3dzI5RXE4RXJxRWhHWDFOTWd0QzA3VDdN?=
 =?iso-2022-jp?B?Rmx2NmE3bGtSVTcwZ0YvT3BnN1V0cUFhMXlvUThqLzNoMkRFZWNLQnZM?=
 =?iso-2022-jp?B?ZENVYTFrTk9KVDBrUDFjRG9iY3E3TlBtN0trWm8yTTVpV3BIK0Uwczdy?=
 =?iso-2022-jp?B?N3hiZStYMFd4YVh0d1ZlTXZ4VjJ6Y21HWm9PUjZIUWRRVFF1Wkt5U1pP?=
 =?iso-2022-jp?B?UTBabXAvNE50T1lrZUdxSG14MUVuSysxV0srU0Vnbk0yWWZaL3NJeHov?=
 =?iso-2022-jp?B?YlM1ZVpXQzRYUVpiTzIvR01TWlRPYS9XbnFhUUI2QjAwL1lGVnVIVVRs?=
 =?iso-2022-jp?B?cmZnNXhKcmNpTXo4YXFRcUVsTnoycm1sQ2syZndiY2E1dXBXSnUva3JV?=
 =?iso-2022-jp?B?MGxwZ3dqT0V1UkVXV2RFa3d6WTJBbG16ODFBcGlQL3Y5ampUNDNMNllF?=
 =?iso-2022-jp?B?RnNiN25oVlNTQ3VIQktFbGMxbENSbzNaYzdhRzQ1cFpDVkZqUkhhWU5n?=
 =?iso-2022-jp?B?N2pkd2hkdHVyV25IMlE1d0JtbmZSS2VZaTNyb2wxdUhaQStoUjczNlYv?=
 =?iso-2022-jp?B?dnkrVHIwOTFNQjdmS2MzMEhsS1BsNGdCZUp5OXRNeUo0bllIYkhocm4y?=
 =?iso-2022-jp?B?T2ZiaktORk1pMTZOZGtmNWdhb3Q5MUdGU1pIajBXbFQ4TkE3Nzc3VnlG?=
 =?iso-2022-jp?B?dDV3T21GV3JmZ0tjdmg4c3RKL0RvUXFGeFo5c2xvZWxuTWlDNVVOeGJx?=
 =?iso-2022-jp?B?TUEydEVDR1h6MlZyOXplc1gvU2Vqc2tOUnErcSt2ZjBwKzZBcW11TTVT?=
 =?iso-2022-jp?B?bEtNbkdPUXpRM1dzQ09WYVh5VWlGc1BiWjl0eTJKRGZYVyt4Nk5MT0pQ?=
 =?iso-2022-jp?B?V0Z5cUl2bjhBVERsTDVwUjBGRTEwMFZldU1WQnlWTDEyWm1QcVNvYmFJ?=
 =?iso-2022-jp?B?S2FxTkNLdFhTY3lnTm9yTXlSQkpyVjlJVjBlcTJienpscENONGQ5SFFP?=
 =?iso-2022-jp?B?SFczcmVVeDlXTnFpQWgzNG1UalFDUjJnUk1oajQycU9uMC9xUXc4ZHV6?=
 =?iso-2022-jp?B?SndnWnFmRHJ2TERqVTFHTS9aOHJJbWxYdUJyaDdscS9NTHY4QjhNYlRy?=
 =?iso-2022-jp?B?czVGMnJaQzFEMmc1dEtJZWpYUWczbEJpQW9NRmFWOWdEUlphajlCWkZ5?=
 =?iso-2022-jp?B?NXVaS0J3cHhBRmNxSEk1b0p3OXo0SXpDU3JmZDROOWlVdGdoeVVsV3M2?=
 =?iso-2022-jp?B?TVAvaktMdmNWNUQyTk1sL0t1OFI2TUM3WjBMYmhmV2I0MkRiUWM3TVhC?=
 =?iso-2022-jp?B?NWYzT3hTVVZzNksyL1JPejFOalRjNWg2dmZxRDczUkVwY0hlQ1hiNVkx?=
 =?iso-2022-jp?B?K0NTSGJLeC84RGF2eSt3emRyZHNuOVR1a0svczNNWFNmcHdkQ1YyYVZE?=
 =?iso-2022-jp?B?N0dMYWZCTXdIVUtNRW1wL2FUUFA2T3Zo?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QmU5NGtTY2FWb1N6WThXM2RKSUtRVDlHWllwZUV4YnJZUDhMbmlNd2c4?=
 =?iso-2022-jp?B?SzRpTkZkOU9XNHV1cFpOZkVWcG9ockxuaUJXVXAxQUl2YTE2U3RmVjh0?=
 =?iso-2022-jp?B?bWdWdTZTMC9malp3bjJNRWxFdHlJYUpvUWNXL2trdmlsQU5GNTk0WVhy?=
 =?iso-2022-jp?B?NVRoaGNRT3pHV2treDlvUklOMkpBN1hTbkZLRzhxNjA2NEtMdWFyWVNx?=
 =?iso-2022-jp?B?MysxOTBiSGZ2TjZsSkgxVy9IeWNMRjdiNGdkRjhNQ3hHbnJiTTVXK3lL?=
 =?iso-2022-jp?B?bVFkWXhaSDhGcS84VnJlK0JhSHZkY0p6MDdiZGdMNHBmcFRzeFZzV0tW?=
 =?iso-2022-jp?B?eVQraElIWHQ5clFZVTUrUTlRdTBzM3dOeXZhTXl6VGQveWhjaCtnSnZG?=
 =?iso-2022-jp?B?aW91UjUwMTBTMSswNUVqVzNFZGdSK1pxZnNyU3RYdFJNRU1CbU9iaXdt?=
 =?iso-2022-jp?B?RVhRbWFGWWlTYkFJbm52Nzhqb0VBeDFDNnNMQXNEZ0ppYXY5K3ppWjV3?=
 =?iso-2022-jp?B?UTFkMmZUTVpUY2JFbGhqdTFFOXlBalZtQWtUSCtqSklFZEdKZ3QwK29E?=
 =?iso-2022-jp?B?aWEyQ0VWcU5xbEFhTDZ2TnpDdVkxUUROemNsdUczY3R1Z21rWUE3RnhN?=
 =?iso-2022-jp?B?Y1ArbDczRVkrd3IzayszTlp1Y0R0aURZTE40NW5RNWRyN3gwZWJmYTdH?=
 =?iso-2022-jp?B?WmROYWZlTFpBVUg4Uk4zb0ZvVVg4OStvZ3VHQm9LZDIvTTd4d2VyeUJ1?=
 =?iso-2022-jp?B?SjBEMG9LbXJxeUdKeWV4NzJEdXBuWXBpbXdsQW0rQUtIOHBKTVRuQkxl?=
 =?iso-2022-jp?B?L2ZDNk1KMDlXMjZNb3RKUlpqTHRVQ0hOZWJkVG5HN1lFMHE0RFpKMXlh?=
 =?iso-2022-jp?B?RC9sYnRiYnpnUmI1RXNOMllRL2Q5d0JSMkFzU0JxbSt1aC9VT044M3R0?=
 =?iso-2022-jp?B?ZFdpdlh2UW01RDVFbHZpVGNHY2MrU2RQS1ExSUQ3SWR6V0NrSjRGN0RF?=
 =?iso-2022-jp?B?cHo4NDlnc2NTcGxqU0tDaDN3bFBnYVZxV1RpT1g0Sk1JNzQvdjR0OGlo?=
 =?iso-2022-jp?B?QTNpT2U3YnFoYXloaEFrYjFFRFRyeHFxUVhhZlkwV2dLREFrTDhweFl1?=
 =?iso-2022-jp?B?NGZoNTdYZFVZMDFnekF1LzVqMEh0REdZMHJYeEhlR0I1aThhYk9Weity?=
 =?iso-2022-jp?B?NmNnM0F2T1cyajVKd0o4dnNicm1mamhwdDZJb0R4MnB5OVFxUE9LdEdo?=
 =?iso-2022-jp?B?QmlsK3I5YVk2Vmcwc2Vna2R4WnhWQVZuTWJaWktnWTNkWW9jTzFMUXhC?=
 =?iso-2022-jp?B?WGx1dUxWdEZaMXRqRUFFMDhoNVRoSWk0NkRIYXlJVlZQRTBzNVFWTDZD?=
 =?iso-2022-jp?B?SWJjdnNrOFdQVCtUSFprWXJLOGRaSkEweHNGQzlyakJxOHplbzRzZHV6?=
 =?iso-2022-jp?B?MFVLb01lc05qZXllcytiYXNPcjQ3MXRtbXIralpFNU1GSFJhUWpvcmpH?=
 =?iso-2022-jp?B?eGpJeHNEQVVqM1JYTk1WcFV5T2xXc0RPeHlRQzJFM2t3ekk1WHRtQitR?=
 =?iso-2022-jp?B?UWdUNDRSemVEMnU5Rml2ZEhweElQZitMRU16SlU4ZURDSHVOR2RsOUw4?=
 =?iso-2022-jp?B?Q3hkWGdmc3hKcGFSZDhWT3FvZDBlNFVvTk5MWTZ3ME9XL0tYOWVnOWps?=
 =?iso-2022-jp?B?b0tRQkRiRGxKeXV2Y0lUNERKbndxZTVXZUdxVDJUR3M4cEd2aWdyY1lK?=
 =?iso-2022-jp?B?cDg0cHNZQ01qYncyS3o1LzRseUU2VEpYek5TM2xxVzFkN0xOT1dzWXRw?=
 =?iso-2022-jp?B?aTk4OStnQXppaTV4U2hIVGtvanpDalN1MU84cVpocFk1VzBxMy9Uenhl?=
 =?iso-2022-jp?B?Y0dpMWxFVXo3aUtTTlVNTjJFWEdRWW1xNmlZemkvK25sS2JSdzFncWty?=
 =?iso-2022-jp?B?VzZOWEo2bGx4OHJPM2FkZ096YldiWk5Tb1lqMFprZ0d3SGYyNUF5VnJs?=
 =?iso-2022-jp?B?SmoycDl0ZEJGRC9mazBrUjRybzJVNFRzZVRWeG5RUU1WVXRwaVV3UXZk?=
 =?iso-2022-jp?B?d2VFemNsbmNTQzVqcy9WaEE3cG1tcCszUkVqZDJWb0VQczRDeXVtOEti?=
 =?iso-2022-jp?B?ODFPUTEzTDREMnVUU1RJZVc2L0trOFVUdkxZcVIyNmowT3c3dGNjcGlq?=
 =?iso-2022-jp?B?STJ1QTVtQjVYOC9DRy9LWUUxbURuRHlEcDBnT0lPdEVLT3pBUlAvazNu?=
 =?iso-2022-jp?B?WFVzNHl6aGF5RGd1M2N4aCtuTkRoVm9IeW9kL3lHVkdKZktxRWxvYnFM?=
 =?iso-2022-jp?B?bzZmdWZGZXVuM1psVVkyR1Z4QkE2L3doWFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c95b36-b66c-4e8d-048f-08de3ca71c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 13:29:16.0506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NexVZM5ZIQS68zRzD/HoUd3YhQphO91rvzdkjoHSwtvEtsud3BJdg2O6Cmf5/CaW0es9tP0Jdk9f/iVllnSi6+gN2QZo/Pccl3qCJASvH9qVmpVZkw/eStQfmPYYTxeS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14558
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 13:29:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21085

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
> Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, December 16, 2025 9:01 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Add 64-b=
it
> polling support
>=20
> Hi!
>=20
> > As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
> > bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 byt=
es.
> > During testing it is found that, if the DMA buffer is not aligned to
> > 128 bit it fallback to PIO mode. In such cases, 64-bit access is much
> > more efficient than the current 16-bit.
>=20
> Thank you, applied.
>=20

# This has already been applied, so it is a record of what has been reviewe=
d.

I reviewed this series, looks good to me.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


