Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B255CC5AD49
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 18:37:17 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.40])
 by mx.groups.io with SMTP id smtpd.web10.2847.1748889434719110650
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Jun 2025 11:37:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pHRRPRKE;
 spf=pass (domain: siemens.com, ip: 40.107.159.40, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXjug+YR/6JeUijUDHonmWQUNhsd5WCIskAJYF2CDMPHom41PObwmpvancHV24qm4J+mRDDnpDHs56EF2beiHpkaoLk+LyA2m0uNKHw+sLfVo60ei5rARGs748E/lNFIxTzlgOvFHLz6KwAE/uuKzOMmv24kBu953HzL5+/1F31zRBNNYxQPwxvTm7Ms8ellWHwYF2eKy8tDYbXKo5n6/z7nzA4DL3Lu4/ePsNA1cbuZ73suALEExG9+QF0Ro2bL8TzZ23Xupp1Hq+IFlqG06/TcnUOocQ4biKADlDfdLvmjOyT2b08/WPPGLmBRYcSBPueO89CEQuqJ9u7rvuwRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoccxrZ9pieqMjGZ7q6Tv5u5zgq/xfalClVeLYTT1Js=;
 b=QcGKfEyMvwRHVl6SEB49gLxVsl6w+pvPCoLAcvz7HKMb5YFiiLi2YDUknSgebd4+SZK0qrwKwPZzG165GQ3l2EZy6V2Nbvm5YsHa5EvZUUfVA09k7i3EW/TA3PnGCkVXzO8gCJYjO0x5/PVud/VH2lSLAZxx4F8kf+sjcRVAHUZWDnwSfARinJdfy/aIOyeGVyJhNzfrag6rzhkThEgAywwOxJ3d0hVhW9z+0KFlqtIRXvOoXnhQLOWsx206QtVEqs8kC59UfwDvdhoK2YsJJcfP3sjBMwuoPpkJj+1BnNUFbMad9pn+HMqJUxlRnkASlqfMHzUyO3uJTFb3b7wgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoccxrZ9pieqMjGZ7q6Tv5u5zgq/xfalClVeLYTT1Js=;
 b=pHRRPRKEJKU2lzcBV6fQXkJi6b3yibftZt+z0xA+SPDwZ8wi0ZXnGcDX7i8aNyZzIad7OAqns8BCWioFJjHkaQAOC814nJafpCzJ5rstyFELHledXuiOvhToiQKGlmD+Ih8VlZkB0lMuI0hnK0qaRWmc1wEoRL2im0SlKNurE2UBWzWxHuDi7ADSzbz7lbEmhUJvMXDJ/KF2ZVo5rG9CsP+kuHo70hod5795/4q4ObLpsesX2mWBvKxxhrqQL/DyffAmd7BQ+5zuQJ6ygPjBuDU/fdWMX2sKr5ZsiomIOkJ8q8edC6klP67Opm4n5G0W78aGeJYsEkBTRREqw9Yaxw==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by GVXPR10MB8897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 18:37:10 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%6]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 18:37:10 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "a-gupta4@ti.com" <a-gupta4@ti.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "vigneshr@ti.com" <vigneshr@ti.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "s-adivi@ti.com" <s-adivi@ti.com>
Subject: Re: [cip-dev] Secure Data Encryption on board without TPM support (
 AM62P)
Thread-Topic: [cip-dev] Secure Data Encryption on board without TPM support (
 AM62P)
Thread-Index: AdvT6GldKr1rrCM8TXecTWxSCZ7GHQABO3AA
Date: Mon, 2 Jun 2025 18:37:09 +0000
Message-ID: <2f3c55fd7908070c9864b2adb87e05966ed41ffe.camel@siemens.com>
References: <82039e1a1c384350af46fe375650472c@ti.com>
In-Reply-To: <82039e1a1c384350af46fe375650472c@ti.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|GVXPR10MB8897:EE_
x-ms-office365-filtering-correlation-id: c737288f-cd34-44af-1d70-08dda2047bfa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|4022899009|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OUJaOFBpUTAyTXFvcVptazVXN3BETnhtSC8zUlloM3pOMTNaS0krTmlYMldu?=
 =?utf-8?B?aHppWmJ4YURuVnlLOGRIVTczL0NXQzJWR0xHUVdYdEVnS2lsSDFyczB6S05o?=
 =?utf-8?B?UnM4RUkrV2FHUWlBZEU4UjVldHhiOGtwdndYTVRXa010MG1DMVNpcDRYYXVQ?=
 =?utf-8?B?SUNHZStEaHZPRzVsU1A2ZCtNbXFJdEdFUHBGRnptZTFRNGtXcHVzQklBbzZF?=
 =?utf-8?B?a3NpaHd3NVkwbFN4UEUxU29CQUJMdGlBbndNNWxvYUJsYWYxTFBIbDZRTDlh?=
 =?utf-8?B?eDZpTzd3S1RYd3lXdUZqeEsrSzZUbGJNSE5hRVFXRXg5WXhYMnU2Q0duTFVo?=
 =?utf-8?B?OVpLQy96Q3lPRGhrRG1RcTNHYXRkU0dOdkNwc0xpdjRJQUhaQjkvdjhCYXRY?=
 =?utf-8?B?ZlN5cU5RQXBuZDIxQ3B1TEgvQ2FneG5DUmx2bEJKaUF6VHdqc2VnMVNQSFA2?=
 =?utf-8?B?WjNQMjNramJqRjU4VFpDRmwyMjhObmN4SDJUNUxnSGZHNEZIVEtsSkcybTJL?=
 =?utf-8?B?QkN1QjFPREsxN1ZMUnNHV0lvenVUSmRFZ28vK3M3R25Hc2hIU3RPVXdDU3Jh?=
 =?utf-8?B?NHNPZmk0R2l5cVNPS0N3SS9RRHR3QWNQekpFdCtkd2VhM2tTV28vS29xeVBH?=
 =?utf-8?B?TG5Hbzd0WmdzajNiVmFZSFpTYkhQVkt2K1BMcmlTYnROSDhFbjZRcDd0c3J0?=
 =?utf-8?B?TVUvR29GcjVUbnlBaE80YndCRkFPRlhsQ2ltaTJLeFhvNUpMWlAxcEZ5WnhS?=
 =?utf-8?B?YzZIV080aEk5RThvWXV3bzJkQVZHNEU1bTJMVGRYOHBQK2p5MWJIZDRGVzJR?=
 =?utf-8?B?T3NndGxzbE40LzhWYm9OaHZkTldGVGRUVTkvNmZrT2kzb1R3Z0hjOWV2c3VY?=
 =?utf-8?B?UGVHa3d5RXkyZit4Q3o3TDlLRFVqR2Q5NFZLQkNUY3lwSXVyakI1ZVlKZDRr?=
 =?utf-8?B?cktlMW1WODJ3dlJUZnFtSVVSbnE1N2txa2sxMldFYXRFSE9wb3oya2hJZEJZ?=
 =?utf-8?B?dmE0WTRYaXJwVlRiZHNKRXhtWTh0VTlmZnJCV1UyRHpOQVRSYzMzcWdQMDM4?=
 =?utf-8?B?N3A2ditjNlpqNGFpOVBmdmF6aVJiMThUSElveDZqZTg0THoxa2h5bGc2dTZm?=
 =?utf-8?B?MTROQ0NRWW9JNTNaY3BrZmQrNUlGYm5qdDZQa2Jsa0s2MUhjclkvQzU5NGpG?=
 =?utf-8?B?VTFtN0g5Y2V2UVdRaHBycVBQeG5TU3BWTkRuRlM0cTVVMEpPc2E5YnY1K2Rz?=
 =?utf-8?B?QlVzS0phUjZIb1ovQndQVmJxNzBONVN0bFU1VTJzeUtBUXpwelJKY1hOM0Jj?=
 =?utf-8?B?aXNoeVp6OC9BQ0UvWFJhWWQvUTczZitqbnhUakovU3ZpcXNxWloxY3lZM3Zs?=
 =?utf-8?B?VEx3TzRLRFhnRTVrbjNZN3VTRXg1QUFYdkNUaGFUR1l0QmkwMGZZK0w5Vlpq?=
 =?utf-8?B?ZFRzMDR5SSthbk0wVUF3YlpyK2pOTlBGOFJCb3M3bC8yTG9saWt5K3kxb3Mx?=
 =?utf-8?B?MjFwOHRsQWhsMjdCaGkzNlVWMDdWOWV6UXZCVGplS2MzZkZGa1A5ZkJnaWtv?=
 =?utf-8?B?OFBPSG0xNG1Sd0pRQmpaVjVmOWRBUXlqaGNaVDQ5RzFTQVBzcS90V2hMMElL?=
 =?utf-8?B?OWN2ZXVDNnlUYlVHOWswOHFTamtiMzFkdTNaK0t1S3dvdG1tYmdkUzdrQmQ3?=
 =?utf-8?B?UDZMZUI4MWZZVHpTWnp6cmxjbzAzYkduYnMxeFFVTUxzRU1ZeXNxVGIvZ2Ft?=
 =?utf-8?B?R05NU0taWi9melZWVk16d3dYOFpnZWpsdHBqemNpMjFpQ25reENNYTZwWW5v?=
 =?utf-8?B?N1Z2NlV5U3BuZ0xuQVNCbkRDdlpyeEVTRHZDRWFxOWQyK1lZZ2tQZFhrcjVG?=
 =?utf-8?B?VExQb2pxVVZVMWVyRFh3azI4YjZrZFlkSkhwRmdtMFFGYy8xN3pCazRURzkz?=
 =?utf-8?Q?mcJzIo+NDUw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MEZXVnh4ZndudEUwcFhwd1F1Vm53MEZTWHkzMEhuQUpUYmlqYWFNbWUwdlZ5?=
 =?utf-8?B?UjIrUktxVTVyci9RelNwbk5HeXhyc3hiRnpJbDA0Ky9tdllrQSsrNHhvMGRG?=
 =?utf-8?B?bzMzNG5TUVRHdTRkM0FtWVovc29GUFVSZXFRYW9UYWQ0aW0yT3p5WVFoR3Yz?=
 =?utf-8?B?ZzZrdGQzK3R0RkFybFl3d2c4WldtRlFvaFZBdHgrQ0tZQjJNNWFiWWlzdXVx?=
 =?utf-8?B?MEppNmNNRSt0L2QyRHJkY0lNcU5QQVBCc3labnpYb1psUVo0Wmlrb21TYUtF?=
 =?utf-8?B?aXdNSXdjZmJCSlJjRTBIWkkraENnR2hxbHRvMVFOaWVIa2VJNXhTUmhVYW9x?=
 =?utf-8?B?Zk1CMENPOXhMV3o3VDhjdUxqQlZyS0Z0MUh6VnNGYjRDY3FydDUydDZ6YVNl?=
 =?utf-8?B?ZDJZN09WVnFGc0I0aGlWajlQcmIzUkUzL0M1T1RLMWhkeDZMa1NQbHQzMCth?=
 =?utf-8?B?allWZHRvdXZaeCtQOUhzbjZ2UEJUUUJhWks3MDhYMUhCVDE5MHRyM05zR0Y3?=
 =?utf-8?B?azZKMTZ6ejV2Tk5IaHFkTmNIdWxDNnJSZEhuK2xHL1lhMmZHamduZjRWQ2pR?=
 =?utf-8?B?aGsyZXRsdXVCOFkvMUprOFN2K3VGKys3YkZBbFViVSs5MjNMQnhoK3JnM0lF?=
 =?utf-8?B?K0ZHZHROdnBsVGhYYlFzQk5xTlE4eTZnS3RiT0p5RTB4eE1NUndSZndBVmpU?=
 =?utf-8?B?TU1ZZVU1L2lsc0VLR09wMkZjRFN6SlNDK3pKUDFYbnZsUmFZUnVyQW1WcTho?=
 =?utf-8?B?RXhHaDNVcHJtSVF1Q05pMFlnSFFOakRid083UEFkYldPUTdMTkxVVSswZ05Y?=
 =?utf-8?B?ekhBWnFHZGtNTWVSV1ZYbzQyc3JtdTR0V0I4eWY5VUsxNzl4YXV0QVRhcjVM?=
 =?utf-8?B?VjBpS0o2Q1E1V0MrWnQ5TVBGMThnc0hqdThHc1EwTzFuR29YQUloSE1YWGdk?=
 =?utf-8?B?U08ycFM4Q0tPZktBWXpBNkN1Wk1OZWpEYkQxci9PbktPYktaZFVNMlJBcStK?=
 =?utf-8?B?YnNVRnNZcFFkeGtlNjlCOWNpME9SSmJ3Wk0yMzUySE00RUJFSFE1V3ptb2R5?=
 =?utf-8?B?aXNpcGo5dUZmVFBTWGlOVFpyRW9EbXRpTS9hamtVOSsrczdyZ3N6RWN3aVFi?=
 =?utf-8?B?cFhPQStselk4UW1UaFBQRzRrb0ZidmpoblBjbXlNL3dqNnB6NmlzUjk4VUhl?=
 =?utf-8?B?ZVplUjFWeVZmdDhKTUE0SWY2citOU05BOXoycklGdUZxODViTktXck9YcTR2?=
 =?utf-8?B?U0twVk1QQ3liVXNEeXdKSlF0aDB2bDJUTGFMaFBteTlkaFBFS3M4WisxZGpq?=
 =?utf-8?B?b1g4WmFqekRQV21NZDhKcEZvMG1hTGhLcVl4dDRFZUpFT3lKRjYzUkZxTSth?=
 =?utf-8?B?UFdyNngvZndjbnZwYjBrZVM1SXlONUE4bkVhSUJaVWl1RFUvaFB1UTcrNEV6?=
 =?utf-8?B?SVVZRFZHQzUycjAvTFBYZDh2SG41d2U2VFZON29GMGw0QURKMmt2djJDN0Rq?=
 =?utf-8?B?blZvVlZwNzZ4NWFpbThCcThTZGx5QVhhcURFVU53cGxlVXRzL0p4OVozV0ZP?=
 =?utf-8?B?d2VlcytqRnRUelFGeFZDeVVPTThkSVkwcWVPb0pNQW9GY214MTUvU2wrdk1R?=
 =?utf-8?B?RjJKK1d2VTJ5Tmo0U3o3bUE5V0ZtY2N1Zmw5TTduOFh6aDQ0V0lmNlBLNjhH?=
 =?utf-8?B?bEpyQWcxQ0ZNMk50YkErSHZZczNTQ0ZUN3QrZlBTcHl0NlFQZU0wc3p6cVRK?=
 =?utf-8?B?VFdBbXRzbDI2bTdlRzFvQUt1aFhkdTVUSm9aWE05MTJaYlcxNWtWTk1qY0Jr?=
 =?utf-8?B?Y2hxRFVxSG1FN3IycHJPVTdoUEdzWkNqbm9MTHRGYjJFT1pTeTVQY0s3ZDBm?=
 =?utf-8?B?Qm9FMGgwSCs0TXlDVGlla3BlUHgxRU0zWjdNODNabGJoSG1RTXZ0VzRDREcy?=
 =?utf-8?B?ZVM5ZHJiTEkyUk90elAvdC9RK1RSd25pSWFjRlVOeXlIaFFHNEFMRzZuc0Z3?=
 =?utf-8?B?VG1oVnJ5UmhJbDBuSkRQTGdhQTIycldNRmh3cm5tNEF2a1dLTHdsaU1kZE1P?=
 =?utf-8?B?WWhXUldxMGJ2TURGNXZTbXhNcXpmYlpiMUh2L044dHFIK0ljekJCWUlNM0V0?=
 =?utf-8?B?bXBjdEh1RGFxNC90VWIraW8zSkI2Rk53S29icExUL1NQdnE3K1Y2S2poR3JB?=
 =?utf-8?Q?7Osk+QSiA5ZMLD1ApzwyS5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C3697D0E02A634F8100EF800F93A443@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c737288f-cd34-44af-1d70-08dda2047bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 18:37:09.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KO/Af/Ka7hKYFe6wrzpyNzGfh+t/6fEUrUItCa2tXItUl4Wk4YMKJckWjmL8wa8cnkDMD48DmdEv0OlojGghqQp+rHB7U1sKCFP8BxibPMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8897
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Jun 2025 18:37:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18962

SGkgQXl1c2gsDQoNCk9uIE1vbiwgMjAyNS0wNi0wMiBhdCAxODowMyArMDAwMCwgR3VwdGEsIEF5
dXNoIHZpYSBsaXN0cy5jaXAtDQpwcm9qZWN0Lm9yZyB3cm90ZToNCj4gDQo+IA0KPiANCj4gRGVh
ciBDSVAgRGV2ZWxvcG1lbnQgVGVhbSwNCj4gDQo+IEkgYW0gY3VycmVudGx5IHdvcmtpbmcgb24g
ZW5hYmxpbmcgZW5jcnlwdGVkIHN0b3JhZ2UgZm9yIHRoZSBUSeKAmXMNCj4gQU02MlAgcGxhdGZv
cm0sIHdoaWNoLCBhcyBwZXIgY3VycmVudCBoYXJkd2FyZSBjYXBhYmlsaXRpZXMsIGRvZXMgbm90
DQo+IGluY2x1ZGUgVFBNIHN1cHBvcnQuDQo+IA0KPiBUbyBhZGRyZXNzIHRoaXMsIEkgaGF2ZSBp
bXBsZW1lbnRlZCBhIHdvcmtpbmcgaW5pdHJhbWZzLWNyeXB0LWhvb2stDQo+IG5vbnRwbSAobGlu
ayBwcm92aWRlZCBhdCB0aGUgZW5kKSDCoHNvbHV0aW9uIHRoYXQgcmVtb3ZlcyBUUE0NCj4gZGVw
ZW5kZW5jaWVzLiBJdCB1dGlsaXplcyBhIGtleWZpbGUgZW1iZWRkZWQgZGlyZWN0bHkgaW50byB0
aGUNCj4gaW5pdHJhbWZzIGZvciB1bmxvY2tpbmcgZW5jcnlwdGVkIHBhcnRpdGlvbnMgZHVyaW5n
IGJvb3QuIFRoZQ0KPiBpbml0cmFtZnMgaXRzZWxmIGlzIGNvbnNpZGVyZWQgc2VjdXJlIGFzIGl0
IGlzIHByb3RlY3RlZCBieSB2ZXJpZmllZA0KPiBib290IChTZWN1cmUgQm9vdCBpcyBlbmFibGVk
IG9uIHRoZSBwbGF0Zm9ybSkuDQoNClNpbmNlIHRoZSBpbml0cmFtZnMgaXRzZWxmIGlzIG5vdCBl
bmNyeXB0ZWQsIGFueW9uZSB3aG8gaGFzIGFjY2VzcyB0bw0KdGhlIHN0b3JhZ2UgZGV2aWNlIGNv
bnRhaW5pbmcgdGhlIGluaXRyYW1mcyAob3IgVUtJLCAuLi4pIGNhbiBleHRyYWN0DQp0aGUga2V5
ZmlsZSwgYW5kIHRodXMsIGNhbiBkZWNyeXB0IHlvdXIgcGFydGl0aW9ucy4NCg0KPiANCj4gSSB3
b3VsZCBsaWtlIHRvIGtub3cgaWYgdGhpcyBpcyBhbiBhY2NlcHRhYmxlIGFuZCBzZWN1cmUgYXBw
cm9hY2gNCj4gZnJvbSB0aGUgQ0lQIHNlY3VyaXR5IHBlcnNwZWN0aXZlIGZvciBib2FyZHMgd2l0
aG91dCBUUE0gc3VwcG9ydC4NCj4gQWRkaXRpb25hbGx5LCBhcmUgdGhlcmUgYW55IHJlY29tbWVu
ZGVkIGFsdGVybmF0aXZlcyBvciBiZXN0DQo+IHByYWN0aWNlcyBmb3Igc3RyZW5ndGhlbmluZyB0
aGlzIG1ldGhvZCBpbiBzY2VuYXJpb3Mgd2hlcmUgVFBNDQo+IHN1cHBvcnQgaXMgbm90IGF2YWls
YWJsZT8NCg0KSWYgeW91IG5lZWQgc2VjdXJpdHkgZm9yIGRldmljZXMgd2l0aG91dCBUUE0geW91
IGVpdGhlciBuZWVkIGEgdGhpcmQNCnBhcnR5IGRldmljZSB0byBzdG9yZSB0aGUga2V5IChvciBh
biBlbmNyeXB0ZWQgdmVyc2lvbiBvZiB0aGUga2V5KQ0Kc2VjdXJlbHkgKGUuZy4gSFNNKSBvciB5
b3UgbmVlZCBzb21lIChodW1hbikgaW50ZXJhY3Rpb24gb24gYm9vdC4NClN0b3JpbmcgdGhlIGtl
eSBvbiB0aGUgZGV2aWNlIGRvZXMgbm90IHByb3ZpZGUgdGhlIHByb3RlY3Rpb24geW91DQppbnRl
bmRlZCB0byBoYXZlLg0KDQo+IA0KPiBMb29raW5nIGZvcndhcmQgdG8geW91ciBndWlkYW5jZS4N
Cj4gwqANCj4gUGF0Y2ggZm9yDQo+IGluaXRyYW1mcy1jcnlwdC1ob29rLW5vbnRwbQ0KPiByZWNp
cGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay1ub250cG0gwrcgbWFpbiDCtw0KPiAy
MkNTQjBDMDFfQVlVU0ggR1VQVEEgLyBhbTYyeC1zZWN1cml0eS1mZWF0dXJlcyDCtyBHaXRMYWIN
Cj4gDQpQbGVhc2UgcG9zdCBwYXRjaGVzIHVzaW5nIGBnaXQgZm9ybWF0LXBhdGNoYCBhbmQgYGdp
dCBzZW5kLWVtYWlsYCBhcw0KcHJvcG9zZWQgaGVyZSBbMV0NCg0KQlIgQWxleGFuZGVyIA0KDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEF5dXNoIEd1cHRhDQo+IFRleGFzIEluc3RydW1lbnRzDQo+
IMKgDQo+IA0KPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0KPiBMaW5rczogWW91IHJlY2VpdmUg
YWxsIG1lc3NhZ2VzIHNlbnQgdG8gdGhpcyBncm91cC4NCj4gVmlldy9SZXBseSBPbmxpbmUgKCMx
ODk2MSk6DQo+IGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL2cvY2lwLWRldi9tZXNzYWdl
LzE4OTYxDQo+IE11dGUgVGhpcyBUb3BpYzogaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcv
bXQvMTEzNDMzNTMxLzg4ODY0MjMNCj4gR3JvdXAgT3duZXI6IGNpcC1kZXYrb3duZXJAbGlzdHMu
Y2lwLXByb2plY3Qub3JnDQo+IFVuc3Vic2NyaWJlOg0KPiBodHRwczovL2xpc3RzLmNpcC1wcm9q
ZWN0Lm9yZy9nL2NpcC1kZXYvdW5zdWLCoFthbGV4YW5kZXIuaGVpbmlzY2hAc2llbWVucy5jb20N
Cj4gXQ0KPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0KPiANClsxXToNCmh0dHBzOi8vZ2l0bGFi
LmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vYmxvYi9tYXN0ZXIvQ09O
VFJJQlVUSU5HLm1kP3JlZl90eXBlPWhlYWRzDQo=

