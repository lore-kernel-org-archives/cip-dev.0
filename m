Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E592E103E2FC
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 01:21:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11945.1773278480338257912
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 18:21:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=AnaNs26j;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773278469;x=1774488069;bh=KpjWFIX0DtNk8O+Zbtg40RDClTNWPigmQTIls
	hRYdjY=;b=AnaNs26jrpE4+O1GnoGvc7ZAAB6NEd0wnO9LV7GwXSvdCV6vseR6qHn7p2PS1Zdpwou
	y1MW2UsVvTntMv8SaHpYn91K92DCxT7AzJ6ssLZiwaTpbCVrCfPLzBltMsn8NjkjBYmkgFz0aM273
	u9nOHF1NQlKmJIm73fb7C2j8/LG5ngwrCjl4u55v52qIUk06DfFETSlDDm53e6+J+ftZG6WLM35A/
	6x2I/7QJXXABJhBXo02XslUpMYllyfbUYFQSaUh7Yq8ZdYroj4jWE5zOUOAH9g5u0skluPDnZ8OCe
	KAZtMxoIEjCbc7u6Pkxh+zOUURNX9U7BI7nFFccpjwsg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 62C1L8Vs825669; Thu, 12 Mar 2026 10:21:08 +0900
X-Iguazu-Qid: 2yAarcJNb85V5Dxq2e
X-Iguazu-QSIG: v=2; s=0; t=1773278467; q=2yAarcJNb85V5Dxq2e; m=IpWCIEnVEXfe04/MbrEm28xdjljyU969E4D03IbtecE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fWVDy5pMDzyPQ; Thu, 12 Mar 2026 10:21:06 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeGtWJjsipsLXRieCE4siZg2wI0+PvXPGXM24Rh0KyBWIS/+X4ze5D9ZkhShwqOudeNkOKDoBQG0vJfvlbJ9OdVsXYzmu0CllQaTzPWZkPsHxtYBdmwtaj0F2bsb9cuQF/D3szy8VORKHQ+kQ1D7NcDKYVseHpPyOExNQWF60VLtx8YzqhG44vhdgHRPXP97vQc00kgYcb89LZRNCD5YDFUnop7fltAxnOz3W3Zv0D+xHxC91IgdtGs1VJaewZAF+fCRojhLrohSe88J196SAfQroXmNIT1C+u4ielO3J+H3rHYgLcfXP6lufkdT0jWn2MAzXisnzTRNZFoMzQfsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijyKZfDWb5ApEDXMXyNZONYMCTJzXxbUxsdO66v2li8=;
 b=weHLPnOPEyXAxdIkYA89faGheTwsiaPMzi3jeokKGZSIUfVcTdEmnCM4EkRiWhuu/eT8O3Q+Gii4jKdg7ZhjmJZ7pjvnCh5jncbHnKMLfuYS2fjFGl2aMUNCS6nZ/Eu8euvNVla4D0MD4pfEZwNVfZlcY3oektoDdUFgQ18WaeSh2kcy42cvHvAYlGQR3j+riqNKVYhuJ4pI9NLkTFn/c27knf+K11ehnkiLatLM9voV3ys56eQ7Bg2bQp/haRwoAVFuvzpsIl698rJlJ89QRq+ugA6I8Oi0w04SDw8TmwHFOKiEu+ikejbWpgCCl8VkTLpS2muXNUYfa2gL09bWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: RE: [cip-dev] [ANNOUNCE] Release v6.12.76-cip18
Thread-Topic: [cip-dev] [ANNOUNCE] Release v6.12.76-cip18
Thread-Index: Adyvo7ioq5fm8MhtSt+h7L/y0HwvkgB/6JoAAAa3r2A=
Date: Thu, 12 Mar 2026 01:21:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818386C9D6CE5A68316984BCD44A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <TY7PR01MB148180663612C1BAD4584B06ECD79A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <abHneDl3zh3RSgNZ@duo.ucw.cz>
In-Reply-To: <abHneDl3zh3RSgNZ@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB9520:EE_
x-ms-office365-filtering-correlation-id: cb8fa2fa-595d-4e47-f757-08de7fd59f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003|7053199007|14052099004;
x-microsoft-antispam-message-info: 
 T3guHpUerrbRWLQOo9+TgIlmfMDZYz8gfsJG/O+TukevDiXs/Wc5z03RmvZn0l/zHX8RUZBcYExpPcPfB3z27cRhCEoRmzb83jv2/JzcI1HKELgeh415CarYcGoitbvRxc2F6HBmvgLKhFsHLYl2TuHvkpDsmJp465WKE4CE72XDAyTZxuIxqDr6npHUkypBNw/xKAaJ0ZNWfdISQEf62g7qZfq/PezJRrap8RynG9JaySynt1Qo7l/mfInSRBP7GMjAXemfIphEjDv7XgxKQzZfS5vYnpNan8L2t7gwekZs/LHsmwGcDw8zf917jElkXU5L9LdfAyafK0gg8II73OVIHzC7qC0RDTSzXAyGt+6t5LXwglaItj9kgMAGRMl6ADmT2onr41HhHn+WegNEiw+JNpfyjjXLTa6aU55O2HPbtbJ6rK0qVKOnJBpscDNgg/He0ABiC/EcjwfaEUtphdZQKO9pI49o7ZZf1NX00soQJv9ns/R7hUI7oS8ZkC5RRX5xEMzyJfPDYiFyktMuPtmc7xt1DpcN8OhPwmbfyFzNGSevFDGR3Gs75hkqADel+uK6wCijaBmGE+zZ0BhwDW37ZSK9VzNZuAv2rwONRqoUpAEQGIVkTx8WDdO8yF1XQv8vyfgZJHdEzNl/ghUbeBoo6m+fsCftQPq0FTB+QmHNvfSTwAQmVJHbzvPGmETwWkZuJRH+NE8yaQmbW0ETWfgPMCVWl7LYVqghjaxN31CPA9PyDXo2P1ykqHzRkJKzhIlUiAIeVpHpbz9+cqQFaUuxpVDggERoXX1SAf1cBOI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bEppdTF3NElhZlExa3JEWk5ENjFPT0JybEpWUmZVanI2c1hhZ3JFK0xh?=
 =?iso-2022-jp?B?dmxXSW1MdTVpMGdZZTlHVmx1SkFpWU5TK2ozeTNOU24ycUs1UlBYbHlW?=
 =?iso-2022-jp?B?UE5TeW9MQkVwNURUR2xrL25xZHZGanhRTkhPY09qR0VLdmtTa3NHUmZk?=
 =?iso-2022-jp?B?eEQxU1p6Q3A0ZVlVVk9tNmg3TE5yUXNUQzZ3ckhHRW82RldWM2hTdGF3?=
 =?iso-2022-jp?B?cFR0QmhCd2FwQXV2cjRFTUltRDl4OHhyYVhQcFFyemxzZUdCYUlrSWlD?=
 =?iso-2022-jp?B?eU5wby9VSUlncWRJT3RIQ3FYdGpianFiR2FNeFAyR252L1BOdmlnS3Qy?=
 =?iso-2022-jp?B?S2RJNjN0MEtUazNYbmV1OFJiRDFTUDREbjA0di9uOUJvWm85MVRCNW9O?=
 =?iso-2022-jp?B?cXdNZTFOVlBtOTFISjF5OW5lclhVWGdjejgzRS9DK0NzcmNKWXJ5cUw3?=
 =?iso-2022-jp?B?KzQ1RFhzd1lBcTM4SkhTWUo2U1dFWFBrYVRmNGtCanhFS0hBdWNtNUpI?=
 =?iso-2022-jp?B?RDBrQitCUG55V0xLVmVSd3hiQ3c0aFA2cWdCVENoaEc4UXErQm1MeDNa?=
 =?iso-2022-jp?B?V04yazI3eUdHcStsNFltMmxvSmR3c01sbVNKU1FFeEZ6dWJ3R0JyaVJw?=
 =?iso-2022-jp?B?NHUzdUxLTlN5OTNENTBoeUkrRVRGWG84UmY2dHVTSkRVbE85RVAxTisv?=
 =?iso-2022-jp?B?eEJtZGxYSFM0QVZUb0x5QTkxTVhYY0hWbEhrMitRSmI1Ny9nbHRxTVBu?=
 =?iso-2022-jp?B?aE9iazVMcmVnUXdkSXhiNjM0R3VzWGdhM2Fxc2pJTGZUekE4M21nSzVt?=
 =?iso-2022-jp?B?L2RhblFBRWo0Szh5MzFPZGJqQkhwc0V2dFBtOWQ5TThRRjBGYmJaTXRh?=
 =?iso-2022-jp?B?QkJOb3J5d2RkLy8wWkc1NFA3OWlRcVlGdHN1K1ZzdkpRdC9wNUhQYUQw?=
 =?iso-2022-jp?B?RCtLTis1RHc5dDIwdzh0aXAwN0J2R1JJbFdpRVpHUk02V0xkM3liQnNa?=
 =?iso-2022-jp?B?UW1QcHk4djdKWWlaQzdRdTZwbko0TTMyWFRoZ2xUNm5qZ2dFNGlMSnBH?=
 =?iso-2022-jp?B?OWx5UWhqKzYvUGx2WTVRTkdLNjdqU1JERjRpRFA2WExvaU9FR042b3B1?=
 =?iso-2022-jp?B?dUFad3JCWjBsOC9pclIwS0JuV3Q2RnVIQkVyTmx0dFZrNk1CVFAybmNt?=
 =?iso-2022-jp?B?UFlMRDc3OHpYMFZjMmFlVWxzYzdOemhsb0J5L2RBNVB5cmRSejFxQVYv?=
 =?iso-2022-jp?B?dUNtNUNjSGVwNzg2UVR5NStyRzdKQkltc0xFWkxFOUsrTnh5TG5FRVd5?=
 =?iso-2022-jp?B?Ykl1d1hLdG9HdFB5aE1qQzYrcGo1bVV2aDEvZHNhdkZWM3h3bXdLcy9S?=
 =?iso-2022-jp?B?ZHVBSHVpNXc2Uk5HaS9rek5zOEJ1Qit6L1lsNzViOUtlTER3Z2xKTUNZ?=
 =?iso-2022-jp?B?bE9teHdsdENyRXBqTHNTd3VUQm8rcmF5OUNWRUJYT3UrdDEyQ2cvdEFa?=
 =?iso-2022-jp?B?WmZRSEVyS0NpcDZLc0FsOGZyRElKZU9NdXFIYmxtQWozQUV2NTFCNWNy?=
 =?iso-2022-jp?B?UjVXVEFzcDFUUzFZWU1iUmVlTG1ZR3lBU0s4cDZ5VlowbytGOENLTm5o?=
 =?iso-2022-jp?B?ZmtLSG5vUFpCZGM3a1lKMEQzajFsK2U0QVViaFZYT3F3NGE2L2RiOFl1?=
 =?iso-2022-jp?B?MFBERFphYTdBYUtQUTFnVkpnY05uM1BjeDlTcTQyOUdxSGhmU1ZGOWJE?=
 =?iso-2022-jp?B?TyswN2tMNmVxd0pZU3NhVW0vYUVVSGhWSGlXbnJ6dFh6bEFPUWpnNm5i?=
 =?iso-2022-jp?B?Uk03VWpOTDloTTZrKzJxNlB6Z1Rvdm5ON3Fra2kxN0dhQUxLc1RJMHRN?=
 =?iso-2022-jp?B?UFdMZXZCUzBZL2dsYXZMVVZsU1U1eDdJTGpKS29KVTk0MHVvWnh3YnVU?=
 =?iso-2022-jp?B?MVZLcmZ4c2VHL0xGTWEvMWtnOU0zL0xuSE5EQk5SdGFwNmpybHZJL3Vq?=
 =?iso-2022-jp?B?Ym4rMWhmOVpDQ0dOQ2RNM2dOMTdhcWYxRzhGTGRkWWhyQU91RCsycEVi?=
 =?iso-2022-jp?B?c29qSzVjK3VCSXAyMFJHNzBGcFp3U0NsMUJZblZNNlFEVjQvSXNyM2xs?=
 =?iso-2022-jp?B?ZHJYeVpZRFFGSjhHbForVkJ3SldqcFB1L0IxZndDTmxGNVVqM0xhbkNZ?=
 =?iso-2022-jp?B?Skk5ZGZFa3d3TVl6NTZBTmJTSlFFUmJYS0lYdEc5K3Q0V092WmIwd0pP?=
 =?iso-2022-jp?B?cDRRUks0QW1nNGYxUTJINUhTQ1BJdDU2djk4R1RUc3pjbGVkNDA2NGxG?=
 =?iso-2022-jp?B?K3BzdGhUWGZ6RUtjbWRURjFLSlQ3c3JJVkR0NWlReGpVVjZLQU9aTjlM?=
 =?iso-2022-jp?B?a3VnaGhIZTJyYkpseEgySzdLeXpGUzdRb2J1ZUdWU1hXNVRpVzJaSUxP?=
 =?iso-2022-jp?B?Rm9pTzRXaHo5T1o3ZnZva3NWVS9ITWF1TlZnb2F3QnVKYUdLUlVNbEY5?=
 =?iso-2022-jp?B?YUNUbG8xa2NZaXlEbHVxT0hsQXVTOGUzRE5sdzV6cnFDR0RZZy9YZy9r?=
 =?iso-2022-jp?B?OUxhM2pjWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Wc4/44H3uluThAwKTn78B06OyvbH6JGyQm2I7m1aw7GYO2t9z1V0LiZlxEettHkwRWCJDMsyDINCSlstaAjBlXVlPF67exsleXwo7NLQN8RCD7x2FKMoW+91l/pxZigmsJRkpie6e4MrqrajhQoV7GF8uFLpzFqVMMgzuxgg/LF7Qs8859/QF9ntx2iw02bcjAj9LwA/+guFU56lfvBl/CeBSNHLCdTIAALZpDZSkH6T3pyYIiIEa2EuWWa5jP/b/+E85kRlBjZ7NotDcSbnWvfGEcY47S84S5pgETsl0pCHbshsI4xNjH4muxFBbeHu5J5YMKcWbem0i1Kz4oNE9Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8fa2fa-595d-4e47-f757-08de7fd59f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 01:21:01.0836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOHkCvv/CkLT2dsR1T+yCQH3KcUigHIsz6umHkQ+ybSqTnXWaWECfJFp8/vjfUG7mtL/QC0X4a49bFPmLS/jo5kM3UYGT8qXkJPIpzlV82nKEOyNn5SC4uNFosx0fRdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9520
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 01:21:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22346

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Thursday, March 12, 2026 7:07 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com; pavel@nabladev=
.com; uli@fpond.eu;
> masami.ichikawa@cybertrust.co.jp; chris.paterson2@renesas.com
> Subject: Re: [cip-dev] [ANNOUNCE] Release v6.12.76-cip18
>=20
> Hi!
>=20
> > CIP kernel team has released Linux kernel v6.12.76-cip18.
> > The linux-6.12.y-cip tree has been updated base version from v6.12.69 t=
o v6.12.76.
> > This release includes updates for the Renesas ARM64 SoC RZ V2H.
>=20
> Thank you!
>=20
> I should be releasing v5.10-rt, and v5.10.251-rt146 is available -- could=
 I get matching -cip release?

Yes, I will prepare for the release of 5.10.y-cip.

>=20
> Best regards,
> 								Pavel

Best regards,
  Nobuhiro


