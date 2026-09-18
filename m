Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42E2C982D2
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 06:16:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5282.1789712164994343131
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 23:16:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=BRHMoS83;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789712163;x=1790921763;bh=xnKBvivldaYAfnWqGzdI/c6N32y8NF1br1E92
	pxPl78=;b=BRHMoS83pBYD5hu3HsFNOmiy4baCi8Zy2sjq7h4sEEAKALWRHs7t1xUUVKB/Ue4BFEr
	gmqk8FA3ug94aEgbQx0WopwoO+Jbvasfh81z3QFWpjZAHSrZbLJq7emQEjPFBQlpSrCuQLk02rwGj
	Ukors6LrkrtnGmJY1DTflXwO0wCCcqrOgbZA76lTYG25GrLHtPSEPXD+QRoVYIPGTepXX+uOiwO//
	RRqyudb+61dig+NyuFOE/EC3LcsSC/TTQn5qWOeQkzWdZB3+wBJQM7eLoD9upEwwYrnpRfWGCoj6W
	/5CxoYaxM5COACFiDu7O8o13KTqJKKe25I4fx0EkrG9g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 68I6G2al1387727; Fri, 18 Sep 2026 15:16:03 +0900
X-Iguazu-Qid: 2yAaDenV1L3w7BgWjY
X-Iguazu-QSIG: v=2; s=1; t=1789712162; q=2yAaDenV1L3w7BgWjY; m=j3M7gOeo3QcCibxVcVxnSR2xz0TgSBbYUSkSR1PP26w=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hmMnZ2Mn8z1xnk; Fri, 18 Sep 2026 15:16:02 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olJIkaPru3/STQF+bfaBm0sScekkNYLuuy9xsdbHMyFBQbAjv7cuSTmjlTUOKx+wuXzDD9pmWWoN1HmLAJzpFXNZdg9BQBBKsvYxyZLzp5peAcd7qOb2iD5mGx7yvVoR7rAF0cgeOTSf2MJdEZ6jcAgmM1loL/oqnprGiJvq5MS9IMoFsRlTjKIRytozTfiQNe193dxxYNhVa5qTx3Q16E9mMC3toWEwlgLZu/duGwNVfiUx9jsFwknrhR6gEk7bl+N/ZJkOqk6rQidItU6EHxv2Yg6dQXdOybqxoOSxp4yz34qrbVtLRZmb1GrXCx6n/kK6CsIWwt9Xp5Ix2ZHyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oo4RRPHtHAKSP2OhSkz10km+Jx8Nq+02UoUUL8aZbRk=;
 b=Lkxk6ivmBGdeoOxWIQRoHMyZiAXGmttmcXHCbTE3/MAejy57EbO6swk9nPyTwAzhPoEwMReXrllgRuhUjz7heRR1GDA81YcwGFcYtsCTlQ8Jd00ynmfYcuA4l8WVzefnXCvk68yJHmUWJG8YUGmBsu9rQ8KVG22ULpKOxdCvV4Cy+YqyXfvD7RJZHhr9xZfx0Xi5BVPPKEnYP/MxyZ5Wc9FdIKBdCAF0A/fF1LlocLdUKagqy0m8D5BUyOOz8h0Y8+612fhSEGSlVUgLaIieMrnG2jMlC53yQf5Aes3RBOJwX4yy2DVoqAZ59+54e8MHKPA7+dQ7X/r4Xv2nlRSp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH linux-6.1.y-cip] pinctrl: renesas: rzg2l: Populate struct
 gpio_chip::set_config
Thread-Topic: [PATCH linux-6.1.y-cip] pinctrl: renesas: rzg2l: Populate struct
 gpio_chip::set_config
Thread-Index: AQHdRQ0Puw3DgIAtiUyjzXLeEFsKurbPpZoAgAQ6ZsA=
Date: Fri, 18 Sep 2026 06:16:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818B62939D14B122BCF124FCD872@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260915122333.2531384-1-claudiu.beznea@tuxon.dev>
 <aqlK8Dj8O1ax-sfu@duo.ucw.cz>
In-Reply-To: <aqlK8Dj8O1ax-sfu@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB15883:EE_
x-ms-office365-filtering-correlation-id: f84f1441-5e7b-40aa-a540-08df154c4f5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: 
 MC2qw/uyc5Dd5q9G7tppyWveNHylxXxK+oZi75BFo2AjtIQznb5yZnWZ2cBSsGjqcHryN1Vo20IFc51davY8b0/nZ5LKY7Gw+9oI1+wJ0XfUE55siIyFjBKHcprTUAcvD1fA7JfbqB2e9Cb4NwBCQ9ANfI5qtP+0opZS2SWmamIkfCNz7ByKL8Q/GiszdWJucYRc6a9dSRCfHnC8hGlbaH5LxCB/2ufd/IPy3X+G4JzJDKy2sLZnMxiqF0G+ksgODW8e+BQPpDGOh0qfDMb9DJ2WqWv9/lnE1rPw+YhqvsgSuAnPsjzs+uTMt3mKE77vK/jFq8YK2mpa80aCwRm8gVgG9kvAae00GZyEGCop/CMIcvmUm3lkF6tXVZ5yemfu9CrcjSDQYCK8fVlkUy/kqRfjg0z7hgk2emXxk6wOPah08iUyXTN8RUVN2dmhadVl5/jQ7Vom74q6ju06q9AKr30qGDh1bL8SiEmGAy/mX5CGvsNxLfQHVE81YupELojp/Aomd5NLDWfRhifNzd5JBkT23eNx6eg1Kw3+L83eNdTf9DNCAnMCxneXLM0MDCq0TDTMIz3EMMVaRvta+XgLabJmoVKPTeCOW9wg6ySN8CYawIsgAWRacApBkSTclaTAKM+rp/i5ihWDKKUnOEt0NnQYsi/eO+/GkeHcEiNnsdb4PZ3F4HTeORJAs3Qf0mpiUmgPEMldsKVPa8dw9reZapZfL2UgKwONY+RaT1JqSqA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NjhqVDA5ZmNnRktST2o1eG5CaDhLc1E0citucFJhMExpTzM4WnJlRDRD?=
 =?iso-2022-jp?B?SVZHRlFkRXlSeHB1dVJUblF4cXB2Wk4wMFNRSElRS21pbWlUbTBOL2Jo?=
 =?iso-2022-jp?B?ZmdiYXEySUJZU1hUUVhodDVLWHQwSjlUd2hFUTR6dWVYcEh6c3VqaFVx?=
 =?iso-2022-jp?B?c1h2VjNIWlFmQUJYSU1QVDFxUlM4elZ4N0ZOWFdRbXIycjlFcGtKTTNp?=
 =?iso-2022-jp?B?MUFpVUcrYm8xbS9BR1pUb3hZanZSWUJBbXlXQmtqSURpcmF5LzJGSUJH?=
 =?iso-2022-jp?B?ZnRkNDdEMENYeFNwZzR3MnN3T0pHSGwwOU5GMVlPUjBqSGVUTWJaUExJ?=
 =?iso-2022-jp?B?YnY4eU1KV1NOdFF1NncwaHJNQUNHSVZHUjl1NGNyQ28rTzJ6Ty9jZEZI?=
 =?iso-2022-jp?B?VHJROC9YNlJLSFo2RkNaKzU0MDhiMHJoa1d6QlFaTmVCc1BWdSsvUjJT?=
 =?iso-2022-jp?B?djM5RWxJUC9sY0VSR00vbjVOdkxBR0FMRVprb1cyajJ1a0I4WEwvRWdr?=
 =?iso-2022-jp?B?U0FwdDJnQnJwZkFOYW8xVDE1cTg5eDMreklkRjdMRTVqZE9OQldickF2?=
 =?iso-2022-jp?B?K1JMKzV4dVR1UHZaN1hrRlBUZ05Xa2NtRXBWeXE4V0xzbGtraVVCMUZC?=
 =?iso-2022-jp?B?WnVOOUZtY0QvMzRKblJ1L1pIbmw4dG02VC8xUW9OcFYvemxaYndWV0Iz?=
 =?iso-2022-jp?B?em13T1AwMFQvbDk1ajdvai9FWnUwY1IyRTVLNVRqUGtLYUZnUUFRQktQ?=
 =?iso-2022-jp?B?QlZ5aDdFbkdGVEk3Nkc2UnZ6cUJqajRpYlF1Wml3dUNZS01iWDBsVFFJ?=
 =?iso-2022-jp?B?V0tFTEZ5U3pZRUovUUZLNHQvMzBMTlpZV2hpMUVZdW9uYmJOeDZyTDZF?=
 =?iso-2022-jp?B?TG5KRmczZEc4cHZkRmtJMGlVL1V0WTZMSU5GWEM0MW5EcDFHRDJVM0RX?=
 =?iso-2022-jp?B?YkJyTXJtWEdTbmFEOVhEWEFWbXo3TFAzd25rQktCTmxYQmMwUjFMUFpC?=
 =?iso-2022-jp?B?cnl0WG1vRnZWQmlYaVdQUWVOOU16Q3dEMWVVeWZLeGR1ajdEbjlmQmVG?=
 =?iso-2022-jp?B?dUZpcklNYmhkY0xxUTBsWFlBSW4vRS9xcC9PMUwvM3BsMmQyT1JwQU9P?=
 =?iso-2022-jp?B?enJXZTZDdWV5YkFDSTFtWCtzTXozNGNic3RDdlVKUWlpVStJaUdMMFRo?=
 =?iso-2022-jp?B?R2FveGo5UnhMczYzYnFidm9pQlRhREREaHlaMHlWYzhWV0lGMm9Gc1g2?=
 =?iso-2022-jp?B?WGJuNjNKdUxUY1o2L3hpdHZsVGxxQWt1Q0ZaeE0relBKN2RETkpvejQ5?=
 =?iso-2022-jp?B?ZEpMVlJldENHM2NESUR6VmFEZEZGeG8yWFVienBXKy9jMG1Qcm5za2pl?=
 =?iso-2022-jp?B?a2d5UGI4WGtPVGJQbDVZRy9vV21mU1dpaVd2d3hFVk1RRmtaeTZ2WWFO?=
 =?iso-2022-jp?B?Y0RzNG9sR21RdHRrNzZHZmQwRWcyUXZSc29ac1Rsc200ZEUxeGc4N0xV?=
 =?iso-2022-jp?B?aFFsenk0aUI4cms1cjJVYjlDcHoybXFDd2pIWTZ2ckFaTi85VEE3WWp0?=
 =?iso-2022-jp?B?WS9qUTFrZ1B3QTZ2U1NpVUQ0ODdnNFFpTGM2MkQ2Skt6MENOb3Q3MWlU?=
 =?iso-2022-jp?B?WmdXMUZmbFlhZmZHL1N1SXVTUzcwcWMzRUc2T016MnFSdDgzM0Q1ZEZI?=
 =?iso-2022-jp?B?NStUSWx1YXo0TWpQRk1ERVlXakZNcWQ2eXpVRlluM2RYVDlmbzRaVm5G?=
 =?iso-2022-jp?B?T0ZSNVlOR2tpWHdoVlFOR2RPOHI0bHcrVG40SkNzcWlNYlB6cFpBcWta?=
 =?iso-2022-jp?B?Q2MzT0JjTkJlRmkzc3lodGlSMTJQS2hzbTc3WnBBNnFjV1pFY3ZxNmlw?=
 =?iso-2022-jp?B?cnBaSmp5eGhjMjdlcVRlV0pHVTV2TzZEaDJlcUIvNDJlL2hBaEU0SHY3?=
 =?iso-2022-jp?B?SW4yTG02MmZOUld1MTVyRXhiZjZieU1SNTY4V0FGSU5KcTJ4VlVoVExt?=
 =?iso-2022-jp?B?aEw0ZGU1OWhxRHYwK1lrZ2lKVitYQitjTHNnUXpPYk0zL1o0eGREOGpk?=
 =?iso-2022-jp?B?RTBQL0Z2cm4zaFg2UExhMDFKQndnUXk4NHI1Y1FyZC9GVzFEbExkdXA1?=
 =?iso-2022-jp?B?UDc3dE04RE5yZVFhVXlsVTFpY215ZUVaVjE1aXdsVEVjc3U4RWpDTVFL?=
 =?iso-2022-jp?B?ZnpMTEtHbFJnVWR5UGZ6a2x5Y3Fid0dLbmRSSUF6ZlN0N0FlMndHUkRo?=
 =?iso-2022-jp?B?QjdMVElJZ0t0WUtlRlpGYWVSbTc1T0VydzlVVDBqb0I2bG1nR2xSVVc2?=
 =?iso-2022-jp?B?amsxZllqUXZxWjA3cnZlMzIxNTZ6cDVxaE5kcE9laThtRStZUEhvbVJs?=
 =?iso-2022-jp?B?aTh1VkRYMTNxZE93QzRTQVBmUWNqT3ladUlOSXpPaFJwdVZsZ1RXM09V?=
 =?iso-2022-jp?B?bTJINzRxdnQ5NnFkT1YwV0tlS2ZoOUVPeG1QM1NlTXVmNjFoQkxoblVJ?=
 =?iso-2022-jp?B?WVVvMzYySjdua05MeGpCK1d3UzRwK1M0VWxDVXlNWnZEUFlFY21lb1lk?=
 =?iso-2022-jp?B?bjhFOGFjOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	kpW/2qkrcbcRrkTI7EF+sZiYdmBHJaEMw3qgIYx6LYyb10s9jox4jvisP8sahF2B/kcOcqUf1GWY0/o9uDK1IhcaDkOgj5xTjc559FWgGVN4P0dGi83uGqByhEHLiphgb5/PbOO6LLCTvNiUPJdkDYdiVvDJ+BvvS0eRQqzcGLhinubJ87RcMuZqGW6fD7VUfPToteVeVg1H/YhfshiC6CA2R2KfHi0EmTJzBRnDzxlsWo6J0AWk/gPtQZhwbezwIFdgI+vxDUDYFRnEdgfPUi6i6idMyFkuEYipyO5pjj6DUDcaDoF0hJKatppXenYuK+ibIiHbBtwkSb+Qz3CJTA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84f1441-5e7b-40aa-a540-08df154c4f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:16:00.2909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ES1lk+YGRgUjiSTdYhGa2Q8BkJJ+r89j8dLkPxWi7I/dlciXbdX4+zudsGfm+k1CP8EClN5uNXedMGUTuA+82ONLrtGd755Vj12JkWnsWP4CgGQWl9A+ou1I4yX3Z+p0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15883
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 06:16:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24234

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Tuesday, September 15, 2026 10:41 PM
> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [PATCH linux-6.1.y-cip] pinctrl: renesas: rzg2l: Populate st=
ruct
> gpio_chip::set_config
>=20
> Hi!
>=20
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > commit 60a19a68779b1f24e3160c8e4317d0334a397687 upstream.
> >
> > Populate struct gpio_chip::set_config to allow various GPIO settings.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply it if it passes testing and there are no other comments.
>=20

Looks good to me too.
I applied with Pavel's Reviewed-by tag.

Best regards,
  Nobuhiro


