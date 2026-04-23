Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E75FF99350
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 08:00:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14710.1776931204623013873
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2026 01:00:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=xplICEM9;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776931200;x=1778140800;bh=3QrbZyqQnV3auEkcSS6EAJTkPJl0HPl0ne082
	mp11g4=;b=xplICEM9vV45bAJI2mAhtB2rqLHGR7hjV0cpbZKIlKYEnZgGl9FNqXoV5eISNofFter
	H1agdjLZaXtI098RKdsjEDs+10IHEG+sR26ufQqbPZ0M16luCMfWGBXRYOEih13/gcOIeTwa2xgDU
	f31saWQchfwuqIDK0AVbgL+xw6XoqyC3QlA4HZ0nrrX0iBk14OWGd2eUsDg9kHJQXscKGcydJ9BjH
	VnLq+Lqa7fP7AhzOGC4lHowX0ear+/Q3hxO1qUqXTyh7JbX2igq68gb9rqMnXKwewO+JrP3ZNp6Wk
	HCyDDwQXCEkSj0i1gLxRbK+5hDA/IQj/CF7UsSK9+Oiw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 63N7xxVq3204723; Thu, 23 Apr 2026 17:00:00 +0900
X-Iguazu-Qid: 2rWhra8uKXtXMdNA0b
X-Iguazu-QSIG: v=2; s=0; t=1776931199; q=2rWhra8uKXtXMdNA0b; m=lfmqF8YELRttcF5wCEUcm3qo6oY0nyP9rREs+FEPXQk=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4g1T5q22Tbz1xnf; Thu, 23 Apr 2026 16:59:58 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr5XZX6Dx/MrddxsafjIaO9XNspEj4ssQtzYMahQEAMZh54F//Lli74DDNQYWcX5Hxg70mvrVxcHlmp6DO9yVLIpfM5QiMC9nT9V8ZNuD25cOZ7eMkUqa4y3aEQ8Wc/CLs4+nFwVCOaf9TTvNEaQIeOHmlidZhVKsJgp1vxHwEYHKeaDRknztcsLUc1OOyqUzMLsqQWmluMc5uwh9umtWJ3jZGIxIAIG0D3g3T6jwjq7Fc6QrMQdPxL/mhHnU7Cgsg97uD1safPnu9Jvius7HzI4YpiluxANbibSbzxGWUNV6CqPEa+vXyNh8gOIHbC2cnu/1S978SQ6564iycP7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDCtixjY/EWZ+Ea+FWzhRndZ65KdeaCb951hKAxskbE=;
 b=v0gu4cjPGi8f/f+gwCD7J0lPvn8sLCvsd06O4+nKG3okg8c2PhPgrrom7SI4LmxWxk2toezQ+OS9BmBwBDVZxWOB6jpgpK1O1D8n+81kZ7zKTUL2pI/frNb1oTyJXU0Cm7hndwbr53ZHGQHueRhw6KKycxhodpnMjyRYuR5Ib2oUq8/STtpObonrz1cfDIdBj2+3wz8ip9nupHsnaI5E/hqXo7N0r3rxNowwGp591cpHMkfxjHSa0mUCHdtct8mm17hG57lwDwjPoLIeaKX2NpkFjaQ8Tuj0d+u9XeYkp4Ftb35PC2344G86gF2zVAt5eTUt2E7KI7X6vB3Vl8bsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <Chris.Brandt@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix intin
 variable size
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix
 intin variable size
Thread-Index: AQHczQRDi5unlHxi+0OhObi0LrWetrXrpa1wgABGsICAAGWckA==
Date: Thu, 23 Apr 2026 07:59:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481861CCC2F5BCFE0003FADCCD2A2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
 <20260415181810.4073807-7-chris.brandt@renesas.com>
 <TY7PR01MB148187DC9C6369DD3CFCEFD29CD2D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <OS3PR01MB8319CE5D43B757DE104545318A2A2@OS3PR01MB8319.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB8319CE5D43B757DE104545318A2A2@OS3PR01MB8319.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB9949:EE_
x-ms-office365-filtering-correlation-id: 3f7d406a-0f6f-490d-acaf-08dea10e4ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 JU0WbI+Gf/fBbiUebAMq3IxGMUTpEwNXoUZgkOSvVwZXQn9P8hDM/cYnADBsZC1/hFsVQeCxrDDFLsriE5ZaZX6q7F+mwT4xvYFwDBRQJZr/3tYJFkMU9E09L03ZfBWK7vEQ8Knz+BXz2BJIcbVAFph7cS2G1MPQHQkCCg6kaaLzx7nD7NvmBtiNs761s/iVkfZu8/JSuJF7Kb9reNjxHLxlRRm0Xkq8waBKRkah74GlhF/ZB0vuMRhbud4mYrkKBXMXchKl/oo96xJhdPwuyf8xJ3fMhPNp4SkLwqCMbIotFoCnUUHVkAkHKmPxHcXkpbMP6uP3zUdvnQaH5Og/22pmBQvyJUHz4PeKEgpLhO3TzW1FPiFZEZ1MJxdyiC/YYhu7L7YPVnC+NNN3RmZJnHyX5deMXs5VyYEhYZKDmzyWai0fYN1ZGipK3CS6I56OkN2g281k+GLUwRAfzgHc9Czjue1PlTuXns5MAt0d6IHgI1r7imxQXdfDc2JN81nzlnz80WnHb9dslq1BzOJWE2agjhR9fV1zGBWVnMWlOzxBJ52YvAf/YG4MKQxvZ3LOmHJqFVo6O1YcLF4uP4mmgyUV/T/Ga0mwSUFfenWN4mZ0G8gmmy60fa0xSpgjc0OyR7OoFpZQxwUr1T2bGYYu5ugrp1NSGr8sfWQD1bSWmqIPeZiqRw20+3wRoUJpfn7DNMgoxSnrCOKwTd2NiXVcu4MCckRRNK/IX87NC3fdpZN7jSR2Sh3cXsHR6A5PY9Bk
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OUVPeHNhblpBWElRRHR2ZGs2S1RIV2dHQ2tzTnIrMHh1SUdQVk91Kyt6?=
 =?iso-2022-jp?B?aG9HNWVBYWlZeWVuenRwMVF3VXNVRjY3UG1pRjN2M0NHQ1BXSjNPZHh1?=
 =?iso-2022-jp?B?RmhMYVV1MW1WWXRYMU9ablVKQ1V4ZEJDL0NDd3YyajBiZDVzMnBvTmdw?=
 =?iso-2022-jp?B?ZVV3b0tyblZzQ3l5VHBmckhoRi8yWVc3V2pjWWNnaUNxazkxYklyWlBs?=
 =?iso-2022-jp?B?QTNhMGdhRWNSY083MjRCRUx0OTZuNnZZNTJUSGpSTjRuNFVsaGZHaWZt?=
 =?iso-2022-jp?B?aVdYNVdZb3B5ZWhPak9FbTdoaEMrMTJTSjhOL1hYK0IzbWpmTTRJUmVB?=
 =?iso-2022-jp?B?eGV6RjRWckpNbTdRd1E3cCtTMHh6RU5acHJ3S0pXYUtwMnFYZ0JlVlNs?=
 =?iso-2022-jp?B?aWRtZXFVaUFyRFNKNkNhN3k2SGh1VUgvSlhuUW9CWjRuNEU3czgvbGNs?=
 =?iso-2022-jp?B?U0hlVXEvS0JaUjBEM2tNaFpjSHY3TDRQbTdDc1duajBxWUhmd01zSUZi?=
 =?iso-2022-jp?B?Sjlwdm96ZElzbWxtUllHTldFbEsyQ0JBVU9NSDRuV1BmS2dQS01BUE40?=
 =?iso-2022-jp?B?dE1sRDdvMmYwTWkvSFdjNnhkNURINXJ3NHFYOXZsTC9ka0Jsa3B5dHNB?=
 =?iso-2022-jp?B?bHZDOEc5WjIyR3RBZE45QUY0Wjh3ZDNCRkFuc3lBY2VNeFc0RnJ1Qi9C?=
 =?iso-2022-jp?B?czA1UWc4WDU2MXRySGljbXdrYjB4a3hpZW83TlRZOEh2MTVoTlhHckxt?=
 =?iso-2022-jp?B?SnJzTVA2WlBNVlJ3THQzZ0QxT0FIc01VZVVpNDZWQWJpQmU2WW1hbjhh?=
 =?iso-2022-jp?B?VGV6NzhHdlRrZ3ZERlhzL2IxcHVBU3hRc1RiSGNwSWhuR0RadDRBQXk5?=
 =?iso-2022-jp?B?VG5IM3paeTVFU0pKY0VucG94UFVyVElBRSs3UGdJbnFIR3J4L2tqTFpU?=
 =?iso-2022-jp?B?TVVQWTJxYlpzdTcvalNrSlpDSFlqZkxacVZFcjBadzZSeWp3V0lvdXZq?=
 =?iso-2022-jp?B?RWw4aTJ4TERmVmhRcW5KUG5MQjVLaS9lbFgrWHBCU1VvNVJzNmJ0K0Vq?=
 =?iso-2022-jp?B?YlZoVTd5STRYNVhOK2lZUXdUU3RlUEZnWFNVRVIyTmdmZkxaUmNGRTFj?=
 =?iso-2022-jp?B?R0M0TnJ1T1pjblE2Vmo0WVVuaEdUZ0hoSSsyWThVM3VwZlVZTlcxSlR2?=
 =?iso-2022-jp?B?N3hiR2g0REprM1BoMmczS1lQZUwySXBBRGt4b3BQaHlneEpvdjdHRXRi?=
 =?iso-2022-jp?B?QjJmZE9kWjYxWk1WWUdVaTkvdlZEQ2J3L29qNVZpL0RNcjVvaTRtZUtQ?=
 =?iso-2022-jp?B?ZlA2V3VQRHE1RGFzQmx6ZjNNanZsdEViWm5qQ25mbGZNdHoxRThoSzhj?=
 =?iso-2022-jp?B?b3VWaEUyNnJsZ0pvMFJLZjNjMGZRbmNPbzNWaDZETGoxTHlQY2RzMTly?=
 =?iso-2022-jp?B?ZXBXdjIrdTdQQWxHOXpJdWN2TDFEbldGeGowYVA0MjJjQU84aFQwK0VV?=
 =?iso-2022-jp?B?NWtjTHo3a2NUOWRvWTg5ejVwa1l3dFoyTXBPNHlHUlhHVVZMS0xlbWVZ?=
 =?iso-2022-jp?B?TmxPYUp5UHM4YVc2bXhyODM3N3M0anhFT3dlZEJpck1TdVFrWnhacjNi?=
 =?iso-2022-jp?B?SWZMR0lpWXNMclVtSFFKcWZ6eStRampIZzFCZEpXSUEweTdRYlB4TGIz?=
 =?iso-2022-jp?B?MFpXVisrWUREbWJZenBhNTN3NCtxY2JGeDVmSllQTWdTRkdySm00M29y?=
 =?iso-2022-jp?B?QUdSTmxDODVlaE5naHkzMW45VTc2TFQ1SXRidVNIeXhOcUlrdWRjbFRs?=
 =?iso-2022-jp?B?a0R1ZnFraFArdllwN0tLRWVQaGtzWnAvZStRUVFoWloycXRkL2pVeGxl?=
 =?iso-2022-jp?B?a2k5OGlEaHNpUnlEd1Jjdjl4c0tmRi80Qm9hNCtPajVWUWdWbG1RanJ4?=
 =?iso-2022-jp?B?U0o2Z1hrT2FNS2J3dTllYlJzUVJ2QXNzaC9VMU9vUDRTdHFodkJJR3lm?=
 =?iso-2022-jp?B?a2hLOFluWHNGdFhFNjhjYzhTdkRaYWFDZXFDM2tyb2JzK0E1UzJiMG1O?=
 =?iso-2022-jp?B?K2MyTjVpWjBMQXFZVmRCMlZ5a1RJMHNmT1d5RkFwNjR3NmdtNDRmVmdY?=
 =?iso-2022-jp?B?NGs0QlBUKzlPTytDR2RYVDRrWW9OSE0wQlRmUVNoUGhTRmduT1IraTI1?=
 =?iso-2022-jp?B?VkhiRXJOUGpRWHhhSU93NlB5ZDg2WCtHbkc4WUFUMHlZeVY3OThKVy9p?=
 =?iso-2022-jp?B?anFHRXFZd04vamN4S1llTkQvNnpLa090OW1WN2YzaTREMDQxVGI2dk5F?=
 =?iso-2022-jp?B?Tm1Lb2UvM0lqWkdGU25Ka2JXZ3Z0MndoZzZwQWxvT3YyQU5TVkdvVm9I?=
 =?iso-2022-jp?B?UWdNUFNqQitGdCt3dTdEcWozcDdQN3JLNis5bWpicUYxc3RUOXZWdUw2?=
 =?iso-2022-jp?B?OGlrZXpuUDVHczZMcnh1ZGhYaVVVRnhSV0d2eWs1MnUrVWd4dkJ5RGxy?=
 =?iso-2022-jp?B?YXRKWEVIa203MnhBVG1rTzRuNUtGTGUzSGJMZmpjRFdqVWVVcjZkWVl3?=
 =?iso-2022-jp?B?eFY5QzhsST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	uIsszZ4WdyX/oiMPR2Wh+lAfOEmID6UbMjXuDpR3OHx//Gb8/fDiyTOQbKdee4lF9mWSLMC2hNgUP18ujPBAUJ0bktua/4gQSuDXZmVhCL0Xjabx7XYdBqmNcio5DJ8QiHVjlTb0ZSBp9P+EEljS7dnPEwOiIo8pOVym2XgfBHGbhNjRrZIoSlH8Xx63iWoBhq5KU67LaWlDV7RC7uyjAfXXuHaZC7KSIqVyndYcTWemCTYmjU2kR/GWGvKn7Gr8DEFywMjcgoVBruHWUucxupx5SHD7h8WK0e0EWIlvJIHd0G6LqXM91HrB8pXWkmt7a6xbjbwQ1YBgyAh4SOAOvA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7d406a-0f6f-490d-acaf-08dea10e4ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 07:59:55.5659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /f8ujOVCtHagAu1yo3sc0aCW4scFUzdipPEyMx01h10B08cE9v0fgbiiGfbX36r0c9XyCifq0z//19vi8p57MuLioy4BAykZ+8j3nBzgih7naeuIngs4nsaK3eSd2nlX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9949
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2026 08:00:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22791

Hi Chris,

> -----Original Message-----
> From: Chris Brandt <Chris.Brandt@renesas.com>
> Sent: Thursday, April 23, 2026 10:48 AM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix =
intin variable size
>
> Hi,
>
> > It looks like you're backporting patches from LTS.
> > Could you please backport them from the upstream kernel?
>
> Since this is just a 1-line change, all I need to do is update the commit=
 message.
> The commit hash is from the upstream kernel.
>
> So, all I have to do is remove this line from the commit message:
>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> Do you want me to re-submit the entire series? Or just this patch?
>

We maintainers do not directly modify submitted patches.
If modifications are necessary, please resubmit the entire series, includin=
g the modified patch.
  https://docs.kernel.org/process/submitting-patches.html

>
> Chris

Best regards,
  Nobuhiro


>
>
> ________________________________
>
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on be=
half of Nobuhiro Iwamatsu via
> lists.cip-project.org <nobuhiro.iwamatsu.x90=3Dmail.toshiba@lists.cip-pro=
ject.org>
> Sent: Wednesday, April 22, 2026 5:42 PM
> To: Chris Brandt <Chris.Brandt@renesas.com>; cip-dev@lists.cip-project.or=
g <cip-dev@lists.cip-project.org>;
> pavel@nabladev.com <pavel@nabladev.com>
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix =
intin variable size
>
> Hi,
>
> > -----Original Message-----
> > From: Chris Brandt <chris.brandt@renesas.com>
> > Sent: Thursday, April 16, 2026 3:18 AM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> > <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>
> > Subject: [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix intin variab=
le size
> >
> > [ Upstream commit a00655d98cd885472c311f01dff3e668d1288d0a ]
> >
> > INTIN is a 12-bit register value, so u8 is too small.
> >
> > Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support"=
)
> > Cc: stable@vger.kernel.org
> > Reported-by: Hugo Villeneuve <hugo@hugovil.com>
> > Closes:
> https://lore.kernel.org/20251107113058.f334957151d
> 1a8dd94dd740b%40hugovil.com&data=3D05%7C02%7CChris.Brandt%40renesas.com%7=
C5800573b6dfd43099f3b08dea0b
> 81c1d%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C639124909762951163%7CU=
nknown%7CTWFpbGZsb3d
> 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp=
bCIsIldUIjoyfQ%3D%3D%7C0%
> 7C%7C%7C&sdata=3DAubj6SDPhuTOrs1Zp7wdfyFQUSYQxi0UeAiqCOUPAac%3D&reserved=
=3D0
> <https://lore.kernel.org/20251107113058.f334957151d1a8dd94dd740b@hugovil.=
com>
> > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link:
> https://patch.msgid.link/20251114193711.3277912-1
> -chris.brandt%40renesas.com&data=3D05%7C02%7CChris.Brandt%40renesas.com%7=
C5800573b6dfd43099f3b08dea0b81
> c1d%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C639124909762976580%7CUnk=
nown%7CTWFpbGZsb3d8ey
> JFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI=
sIldUIjoyfQ%3D%3D%7C0%7C
> %7C%7C&sdata=3DMwsosum%2FweloQSkzyLfCLpNo52mw7ZImb%2FcdbTlk430%3D&reserve=
d=3D0
> <https://patch.msgid.link/20251114193711.3277912-1-chris.brandt@renesas.c=
om>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> It looks like you're backporting patches from LTS.
> Could you please backport them from the upstream kernel?
>
> > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> > ---
> >  drivers/clk/renesas/rzg2l-cpg.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2=
l-cpg.c index 0c0d9d76c4d6..c45c22190fcd
> > 100644
> > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > +++ b/drivers/clk/renesas/rzg2l-cpg.c
> > @@ -121,8 +121,8 @@ struct div_hw_data {
> >
> >  struct rzg2l_pll5_param {
> >        u32 pl5_fracin;
> > +     u16 pl5_intin;
> >        u8 pl5_refdiv;
> > -     u8 pl5_intin;
> >        u8 pl5_postdiv1;
> >        u8 pl5_postdiv2;
> >        u8 pl5_spread;
> > --
> > 2.52.0
>
> Best regards,
>   Nobuhiro
>



