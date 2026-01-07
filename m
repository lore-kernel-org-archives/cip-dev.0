Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C52CF6BF4
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 07:42:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1163.1767771758662201467
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 23:42:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=ciXVtoLj;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767771755;x=1768981355;bh=vqlgFP1Xg717qV96i7f9+OeQO6mrappJq+m/X
	5k73IY=;b=ciXVtoLjULTY/islNE/pIWOZOG8anWyf+y63mMw4gA/D2fB0WXH8gUdff6jdcG9cMGJ
	ei8YM20bEccEUyaJPPe3yh8SO5dafFN1rgkdUheyAbedBTFgXhW2W8i53SG1Sltk+49hX4KMY6xy0
	0nMZzE5zn5emujqhI/DI0gXgrvC0cf2EETIMqPoil7XMRLwl8ghNB2xoIqWgsYu7VrvroDcsG8nI5
	GsCCcQsmlDCxQgFSeziwzhEH6kCf4S5THNOuABw/w6qYpvrVvdKpeADF7uXS+qUVJ3as2lYaIuGBa
	9+EwUkdwK1TME+5k70zq8qUf4m6KH/KWXaLlFI6i/YLw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6077gZ95348032; Wed, 7 Jan 2026 16:42:35 +0900
X-Iguazu-Qid: 2yAbtaUVPRC2AigSOU
X-Iguazu-QSIG: v=2; s=0; t=1767771754; q=2yAbtaUVPRC2AigSOU; m=9foMGp/1TXoY/qmJsbXh8F4gDBaecrLbOtXqh0dk1Ng=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dmKkf3rwyzyPZ; Wed,  7 Jan 2026 16:42:34 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mv0ljz/DvwqwnRFhBvViUax3Bk41P6klOFdAjRlV6Q8tKEUOUck9f4T58hbkKT72wiXq7mJMBSOrmHVlgOYAcLvMSlWK47+u6D1bGYAYZijxjVIzf0BlY6kFi/LX+JfXXgSgA+bsTS+IhAT8i0mJx1A+x6fgb8a2ifR8well0WvRipM27Hm9vrpuB3OqId2J0eunSP4Zx0qZYcU5VMv7vh47TmiifhCCxnWWRveGQO1NmPHZa+b8KkP8GHItQ/gkiDq91PQt9oes4ALYMnXUfKWqe5Q9s+bcOWKnRHWS2ZGjsQskp0/aoiPWx1lIk7XFaSJ9X4sMDKlcVy0uZkUaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqlgFP1Xg717qV96i7f9+OeQO6mrappJq+m/X5k73IY=;
 b=h1f1prs/aGF235x4S+XtA8UfJ7bh9f6KffdUJI2e19RqMutkVf9LLAPzOlqNxrYcgbqGvCu9cSRhVzraPQiHtGp7LnX+BMwyzMwjU7BXwMVxrYhEokRDi5S0wEUV9Vh/t6tj6KAx/k5AlnYs40urjC0CuGWiKTEFvlJmx3uYtH4QmVNALQSTw9oWDRObCMMytSvCefovxxt0z4Wx4lycqtSoX7eTK5z8HA6VekXRBByCYWU+DTQZmSHOhzc/vM/G+XnBdRFYQ8pM8xHtgwAAi17y85hUNXjmMzT2bA08uf9Ns5PU0ZHreaJH+YYRdieeqOJEDRFMNq2VSzy9OlXXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Topic: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Index: 
 AQHcfd8KZ0N0yIOqxki80+6lHh+CCbVCww9ggACB/ICAANxMsIAAx+aAgAAB5QCAAWlDMA==
Date: Wed, 7 Jan 2026 07:42:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185E3A9F8B3B15135381B4CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1767574966-5745-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <TY7PR01MB148184F8D88C0BC3643171681CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346883D7A93A1538A1D5EC98686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY7PR01MB148184B738A3B59788E717DF3CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB113469B5BC2D59B29C590EAA68687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134635E75F27240A59DB138D8687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB1134635E75F27240A59DB138D8687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB12076:EE_
x-ms-office365-filtering-correlation-id: 2604cf72-6d88-4f46-fdc2-08de4dc05144
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OGI5NEJjczV3ZjRzdk5SVEVqUWtHMU50THIrSEtlZHgxQ0c0ZU1NTDhyWjFV?=
 =?utf-8?B?U2VKWGFUeE5MdzdCVkhickV0K3BIZGRBRUlLTDF5QU1tbUpxamdDY0RKSkxV?=
 =?utf-8?B?SXh5cWxzdW4wUzArT3drOTFKSmZ0bDNna3B0RUY1ZFNTMUFkNVMvUUVlY1BO?=
 =?utf-8?B?SjBPTmtCYWlTVHhHb3JWUDkwdUJkMDJ6YXR4dEsvenEvSmFSYnVrbHpCVzRq?=
 =?utf-8?B?Z0N1K1o2aGRKd01haWJHSVRxQXpPZGtLY1dzTUpJSTF0QjhHVzRRbXJuKy9m?=
 =?utf-8?B?NkZQbEJVZnhhSU50bVFVZ1Q4djF0ZnB5RVdSQUoxQ2sxVEJJbGZ6a0pwOW1F?=
 =?utf-8?B?SVY3UTZNRkg1alJRak5aemhxRGJVSkdORDVUQStJRms5MzU5SkxNY3RQcTdO?=
 =?utf-8?B?S0tBWCtndFloVkJGMm0yVjdJNlVuWmJtdGw5d0RsWVF6djlkWW9jc2NFdi9E?=
 =?utf-8?B?Y1pwTmdsODNTMzd0a3lpMkczZ3FZYXBTVER1Q01Nd05vOUxvUzVPUldHRFNz?=
 =?utf-8?B?L1RMRkJaeHZkWDdsYmJOS2ZIcE5rNjNyaXFZemNLNkRFNDE3WWtNZGd4YS9H?=
 =?utf-8?B?VUFuZlVnV3paVUJ0eEJjVm90RzN6YTBnMUVNYWJrVDdNZEQ0dzh0bTlRdVIv?=
 =?utf-8?B?dWgvc0p4QkdRQStrbmtBWXZ0c3J6UXQwNlJ6WkJuYk9ybGxVQ3A3TnlNUURu?=
 =?utf-8?B?ZmhVa3dpa3pEV3BHUVZKa2YyS2JZUER0WFQwZ0lzc0dRQmxubVhpQWZabFZt?=
 =?utf-8?B?SzBzWHlOL1NMUFZ2bFVtWFZlSkpTTlpRRFJ6RzdHRnVKK2VuUzU4a2VIMGQy?=
 =?utf-8?B?aVZvM2Jjdm1vaTJULzVNM25GMXhtNU4vUFBVVnVpT21aQ2c2UFdiK21GN1VG?=
 =?utf-8?B?cVkrbEhQQ1dlMUF5UHovM3JlSDdyWTl4VXpyd0xVV0Q3UTdFYmlXbUwrZnBT?=
 =?utf-8?B?OUVQMnMzMEY2eDJxSXIrejVKWTM2Zmp0T3VOMU9qM05TZk1zSlp1NEZRLzRJ?=
 =?utf-8?B?QkRMTlBrVXoyYi9uV2NPV0VJWDRnenNQTnRieCt5SlBEeGludWJIRm9uY0Vp?=
 =?utf-8?B?TElGR21JMzRnSWVJeWs2MGM3TWdVY0JvNmt1bHRyTTRodHpjMjJ6WExRZlNM?=
 =?utf-8?B?OGxzMnRGeTRnZVJNTFBUSlJ5anBJdFlKajdtWG1YUUxVR2RVOFBlcnl1Qysz?=
 =?utf-8?B?M0VxTFM1NGhLS2MrSVM0TlRya25WY01nTG4yRXpubEcxd0MxQ3VzUjVzTkp2?=
 =?utf-8?B?NC8wSDFKZnlYYUNnTHJYUnBscG13Zm1VTytDZ0NaaWdSTzE2OWFqc2o5Y08x?=
 =?utf-8?B?S0Z1bjhkT2FFVEVneERuM2NIVDFDc2VhL0VLUzJPVFg4cmVYaVo5ZVZ6eFF6?=
 =?utf-8?B?NU84azk4VHBPUkU5Sk5zNGRCRHkxKzJ6Rlh1K3BOQUE0Z3pqMVFSeVNaV2Ni?=
 =?utf-8?B?dlY1dGRMQnoxMmdDVnAzSFJyTDhBRjllUnJzMWozbFRuRWFuYitCazYvVzEv?=
 =?utf-8?B?OFowd08vQjI5b3EwdFFsMzdlQnNXc3FOSFkxOWhNUE9rZWM4SXZYUXRkWWl2?=
 =?utf-8?B?YXhuSzIyWUlDUjY3emg3SEN2bnNFcW4yK3cwY3pFd1FDanJselRJb1NPVnEv?=
 =?utf-8?B?NGQ1VlZXNFNFNWFwa3ladURUeC9UODBybkI3RTdxamk0SHZSOE1DbnpVY2pH?=
 =?utf-8?B?K0FjWDN3elY2U1BzVXd5ZzFIdG9aVnlwQmRJYjFrQ2ZpU3J2MS9qSi96OHp6?=
 =?utf-8?B?WUNhejA2akMzazBXd0dDMk9Ta2RBOG9IN2NudmlGRVp3UlAzUUkrdUNIYk8w?=
 =?utf-8?B?aDlZVDBIQ2JBaWtaWWpPQjloSEV1MTE3T3dYR28yV0VjNml3cmhGRlFub3ho?=
 =?utf-8?B?eEdmRDJtNVJkQVdSekxBSXRNMEZ0TkZ1K2ZyUlFOcnZ2VUdjWEhicFJQV29u?=
 =?utf-8?B?MUxzcWQrdFg4Sll4SUIxSktsTUtZWmpCL1FWRVgxRXo3aHRXdjJHQTE3aEwy?=
 =?utf-8?B?aXhJcHJyME5MV0MxNmt0YnlRd0tVSmYvMVhIcjFlZlBNVm0rNCtzN1BkalBk?=
 =?utf-8?Q?WYP/4a?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M0dtcXAreEtnYm02L0hMN0tVYzRrditlMktLVWZROEhUNVZyNGNLc2g0L0lF?=
 =?utf-8?B?a0JwbDl0eEt1Zzh0dlZyT2thMmJoTTBlR1hCSExhZEdSSGVrYlFuTnhVczMw?=
 =?utf-8?B?SDV2WWpaUVF0Wm5iTFdaSXBsVUl6Y2RmZ0hNdXBGcjJmTElqK1VhUzN3cTVB?=
 =?utf-8?B?YjNoNWJ1YjkvczF1aVN5RmM3WE9xbzlIWUVFVStCQWwxVXMyL3FCVVlZeGtB?=
 =?utf-8?B?bHNDeHlkdEJ0YlZTNG53REQ0UG5zMFROSGNDK2o5WkhYVkVxNXU0aFA1c0cy?=
 =?utf-8?B?UXAwa1hmWXNEVzU0TnZOYnNxbnVRVURpZ0NUa09hU0lYYnBTazhDb29YNGhi?=
 =?utf-8?B?UnBodnNZSnI3RUxJcnZxYVBCcWd6cVhmYUdoRENLaE82M3dzakg4c1ZzRVZt?=
 =?utf-8?B?Sk1SOHBQU2VDdnVKNGZqUkZuN1JvWWVRWDB4UWluNW5BaTdvN24wbWI4cDdB?=
 =?utf-8?B?ejNvQWNjaW04UkFVaWVSQXVVN2pNeXM5UzdGb3hMMFY2TS8rMy8vczErZTVp?=
 =?utf-8?B?S1BSZTllYUhBeFJPY0RQUUlTUHZyZENaVkRwRUt3eVRCV3lxRmZVVk8rYXhq?=
 =?utf-8?B?dTBzU0wrSlQvVTM0bm5NVTdyZ1RqdFpFdFA2OXJyVlI1T2FzY1hWVTZlQXBH?=
 =?utf-8?B?L3ArNmRaVy9ZaFdPQmxBN0MwWVBnQkxUR0prcnk5NHZKT1o2ZGxhSGEzUWFZ?=
 =?utf-8?B?blBzZWwwWldpd1lOeXFRV25SV2RmNENTcmI4YUxXNUtmTHBVbkF0SnNUWUNG?=
 =?utf-8?B?WUNTL1hDb0p0ckhpWmwxV2g4YVlnNldkMm5ZTGM3WGhtYkpTK0YzdzVrZnZv?=
 =?utf-8?B?ZWxHeTlhdXFMU3EyekdQU0NDc3ZSMkpSRXh2YVVUcnJabVMwQWRvcnZuazF1?=
 =?utf-8?B?MEhLclpMK0FleHo1aXQwZnJrbmJ0VlhGb001T2xvdEl1M1BNODAybFI5NVZs?=
 =?utf-8?B?OWtvbHVoMEdCbXlWVU94Zm1DWS9VQ1M5aVorTFRJbU5BeGM1aXFmeHRiR1V6?=
 =?utf-8?B?M01oVEoyZzZWWER3QnAwRDU5UlFuMUx3RTFPRVNFRUhsYlVvclk3cVRmUkFE?=
 =?utf-8?B?cm91VTY5UytWdzlwd2pjdkFpVlliRUhKakhZSzdPckpESy9hKzgwOGdXS0RS?=
 =?utf-8?B?YzJEZjB0K1JpL3lzWGpBWDFTckhCMGRLeGRhL2dlcDJVeXlDaEVGWFlQTTlP?=
 =?utf-8?B?eExYSnVPNDN3VUMvakdhUzBiQ1ltRXFhSC8vT3JQRDlwdDVyeXRLRjl3ZG5q?=
 =?utf-8?B?d0tjb2xtd2w1VHNlYitqQ2dScmFoZTN0bU1FSkZtVEJKa0puUmU5VW0yOHhF?=
 =?utf-8?B?MTc4SHdXeUtBYTY1RUcxOEJoWGVDSzJ0UjlxT20yU2NuZk9aOWk5WnQ0UEpN?=
 =?utf-8?B?Qm1HeTYwZ0pHVlRGUjFnTjhMWmxLL2FsTTZyZFczbVRhb0E1T2pPYTJtV2F4?=
 =?utf-8?B?YU1ZL2VGWHdneWFCN1kwajlVbG1wNEN2V1YzbWRZWVJpOFhoZk5SVmRoNHRo?=
 =?utf-8?B?MjNiMlEyZXhIL1FvWnlaWGw5Ri9tR2U1ZWNFUzR6cmgwOVViL2xQNWNNUjhP?=
 =?utf-8?B?SVFhb2gyV29EM1hyM0NuWXpXOUd6TkhidURINm5IYmhWVXhTWGpxZzMyMVhq?=
 =?utf-8?B?RnhSa092WmloZ0U4b28rK2gzTGY2TmdGZGhpTHB0dEkrRkYwRy9WNlpTK3J6?=
 =?utf-8?B?WGlsUGVoejBFVXhjcFU4aUFHMkVKQzJlclVzR0R4bER5ajFGd2RPcklZa3NX?=
 =?utf-8?B?WGUxSXFNV3RrY2ZtMDQrSWdvWFJERGVWNm9EUUswY2lBbGtEU3MvK1h3L3Uv?=
 =?utf-8?B?YVUwd2tpWENEbEZEclpxTkZKVStyVnU2MFFsRmdxNThVN25PQkJHcFp2ekxW?=
 =?utf-8?B?MXNMbWZTdG5HaUZBc3k1RTZaNEdTdVlOQ2NMSk4yYkRaS0IzRWt5Q0psYVNv?=
 =?utf-8?B?eVJZRVE3cWRwOVpqWnRpTFg1N01wajJUcjVuYUR3NHpKTHVyNm0zNUc2bklY?=
 =?utf-8?B?bGFUdmVpekh3QmgrTHJXZjFjbytNN2Z0UzdRYWZhWHBlS2ZOenRXVW01VlF3?=
 =?utf-8?B?L3lnTjBXTW9XWGlHOGhxVHNRWW01amFVaktYTktrMnFuKzBEWHoyWVFZRVNR?=
 =?utf-8?B?TjhlVkM1U0oweTc5MHRYb0Z3SkZNak83andpenY2L05BeTl0M3NnUkhLY3po?=
 =?utf-8?B?RVI2Vm4vR25XTUxQL01ET0ZkNGNKSjk0eHlmbjQwRGtGY2gvaVFzZzQ3OVBh?=
 =?utf-8?B?eHo3dUxweW1yYTc4L1NuU1FUVGVwdUhibThQNWh6eVVRbFF5cDNSWG5uOGJG?=
 =?utf-8?B?ZkZRVWVuN3FpVklwTkNrTWJUUExDZ2pPVjFxOWhPQ2w0SGk0M2JyVXhRVitQ?=
 =?utf-8?Q?qGClsj4Gmlurf+bE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2604cf72-6d88-4f46-fdc2-08de4dc05144
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 07:42:32.5327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hci5VrPJyKVkpo8u0E9AmSTiR/xX2v846LXOIYWaC/ydNhrvcZ1GDL0OrrKCCi9V9AA2XU6EHf8/hD4LF8eMmeKIrYWzX4vhxpnL+OI4kOB04igsv2aEIp09pVRndpYL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12076
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 07:42:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21394

SGkgQmlqdSwNCg0KVGhpcyBpcyBub3QgYSBwcm9ibGVtIHdpdGggeW91ciBiYWNrcG9ydCBwYXRj
aCwgYnV0IGEgcHJvYmxlbSB0aGF0IG9jY3VycmVkIGJldHdlZW4gdGhlIExUUyBwYXRjaCBhbmQg
dGhlIHBhdGNoIGJhY2twb3J0ZWQgdG8gQ0lQLg0KVGhlIExUUyBzdGlsbCBoYXMgaXNfZ2VuNCgp
LCBidXQgQ0lQIGhhcyByZW1vdmVkIGl0LiBUaGlzIGlzIHRoZSBjYXVzZS4NClRoaXMgY2FuIGJl
IGZpeGVkIGluIHRoZSBtZXJnZSBjb21taXQsIGJ1dCBpdCdzIG5vdCBzb21ldGhpbmcgdGhhdCBo
YXBwZW5zIGluIGdpdCBtZXJnZSBsb2dpYywgc28gdGhlIHJlc3VsdHMgd2lsbCBiZSBkaWZmZXJl
bnQgb24gdGhlIC1yZWJhc2UgYnJhbmNoLg0KVGhlcmVmb3JlLCBhIHBhdGNoIHRvIGZpeCB0aGlz
IGRpZmZlcmVuY2UgaXMgbmVlZGVkLCBhbmQgdGhpcyB3aWxsIGJlIGEgQ0lQLXNwZWNpZmljIHBh
dGNoLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0K
PiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDYsIDIwMjYgNzowMiBQTQ0KPiBUbzogaXdhbWF0c3Ug
bm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvKTvvKnvvLTvvKPil4vvvKPvvLDvvLQpDQo+IDxu
b2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiBDYzogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBmb3IgNi4xMi55LWNpcCArIDYu
MTIuNjMgXSBjYW46IHJjYXJfY2FuZmQ6IEZpeCBidWlsZCBlcnJvcg0KPiBjYXVzZWQgYnkgaXNf
Z2VuNCgpDQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBG
cm9tOiBCaWp1IERhcw0KPiA+IFNlbnQ6IDA2IEphbnVhcnkgMjAyNiAwOTo1NQ0KPiA+IFRvOiAn
bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYScNCj4gPiA8bm9idWhpcm8uaXdhbWF0
c3UueDkwQG1haWwudG9zaGliYT4NCj4gPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmcNCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIGZvciA2LjEyLnktY2lwICsgNi4xMi42MyBdIGNh
bjogcmNhcl9jYW5mZDogRml4DQo+ID4gYnVpbGQgZXJyb3IgY2F1c2VkIGJ5IGlzX2dlbjQoKQ0K
PiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmENCj4gPiA+IDxub2J1aGlyby5p
d2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiA+ID4gU2VudDogMDUgSmFudWFyeSAyMDI2IDIy
OjAwDQo+ID4gPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+
ID4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+ID4gPiBTdWJqZWN0OiBSRTog
W1BBVENIIGZvciA2LjEyLnktY2lwICsgNi4xMi42MyBdIGNhbjogcmNhcl9jYW5mZDogRml4DQo+
ID4gPiBidWlsZCBlcnJvciBjYXVzZWQgYnkgaXNfZ2VuNCgpDQo+ID4gPg0KPiA+ID4gSGkgQmlq
dSwNCj4gPiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZy
b206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4gU2VudDog
TW9uZGF5LCBKYW51YXJ5IDUsIDIwMjYgNTo1MSBQTQ0KPiA+ID4gPiBUbzogaXdhbWF0c3Ugbm9i
dWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvKTvvKnvvLTvvKPil4vvvKPvvLDvvLQpDQo+ID4gPiA+
IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiA+ID4gPiBDYzogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCBmb3Ig
Ni4xMi55LWNpcCArIDYuMTIuNjMgXSBjYW46IHJjYXJfY2FuZmQ6DQo+ID4gPiA+IEZpeCBidWls
ZCBlcnJvciBjYXVzZWQgYnkgaXNfZ2VuNCgpDQo+ID4gPiA+DQo+ID4gPiA+IEhpIE5vYnVoaXJv
LVNhbiwNCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+ID4gPiA+DQo+
ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBub2J1
aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhDQo+ID4gPiA+ID4gPG5vYnVoaXJvLml3YW1h
dHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+ID4gPiA+ID4gU3ViamVjdDogRlc6IFtQQVRDSCBmb3Ig
Ni4xMi55LWNpcCArIDYuMTIuNjMgXSBjYW46IHJjYXJfY2FuZmQ6DQo+ID4gPiA+ID4gRml4IGJ1
aWxkIGVycm9yIGNhdXNlZCBieSBpc19nZW40KCkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFJlc2Vu
ZCB0byBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IC4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogTm9i
dWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+ID4g
PiA+ID4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDUsIDIwMjYgMTA6MDMgQU0NCj4gPiA+ID4gPiBT
dWJqZWN0OiBbUEFUQ0ggZm9yIDYuMTIueS1jaXAgKyA2LjEyLjYzIF0gY2FuOiByY2FyX2NhbmZk
OiBGaXgNCj4gPiA+ID4gPiBidWlsZCBlcnJvciBjYXVzZWQgYnkgaXNfZ2VuNCgpDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBpc19nZW40KCkgaXMgdW5kZWZpbmVkIGJlY2F1c2UgaXQgd2FzIG1vZGlm
aWVkIGJ5IGNvbW1pdDoNCj4gPiA+ID4gPiBmMGIzN2YyY2IyMjQNCj4gPiA+ID4gPiAoImNhbjog
cmNhcl9jYW5mZDogQWRkIHNoIHZhcmlhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8i
KS4NCj4gPiA+ID4gPiBUaGlzIHJlcGxhY2VzIGlzX2dlbjQoKSB3aXRoICdncHJpdi0+aW5mby0+
c2hhcmVkX2Nhbl9yZWdzJy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGBgYA0KPiA+ID4gPiA+IGRy
aXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYzogSW4gZnVuY3Rpb24NCj4g4oCYcmNhcl9j
YW5mZF9yZXNldF9jb250cm9sbGVy4oCZOg0KPiA+ID4gPiA+IGRyaXZlcnMvbmV0L2Nhbi9yY2Fy
L3JjYXJfY2FuZmQuYzo4NzQ6MTQ6IGVycm9yOiBpbXBsaWNpdA0KPiA+ID4gPiA+IGRlY2xhcmF0
aW9uIG9mIGZ1bmN0aW9uIOKAmGlzX2dlbjTigJkgWy0gV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xh
cmF0aW9uXQ0KPiA+ID4gPiA+ICAgODc0IHwgICAgICAgICBpZiAoIWlzX2dlbjQoZ3ByaXYpKSB7
DQo+ID4gPiA+ID4gICAgICAgfCAgICAgICAgICAgICAgXn5+fn5+fg0KPiA+ID4gPiA+IGRyaXZl
cnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYzogQXQgdG9wIGxldmVsOg0KPiA+ID4gPiA+IGBg
YA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRml4ZXM6IGY4OGJhNTA5OGU4MyAoImNhbjogcmNhcl9j
YW5mZDogRml4IENBTi1GRCBtb2RlIGFzDQo+ID4gPiA+ID4gZGVmYXVsdCIpDQo+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogTm9idWhpcm8gSXdhbWF0c3UNCj4gPiA+ID4gPiA8bm9idWhpcm8uaXdh
bWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4gPiA+ID4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEJp
anUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gQ2hl
ZXJzLA0KPiA+ID4gPiBCaWp1DQo+ID4gPg0KPiA+ID4gVGhhbmtzLCBhcHBsaWVkLg0KPiA+ID4N
Cj4gPiA+IE5vYnVoaXJvDQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiAgZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jIHwgNCArKy0tDQo+ID4g
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNh
cl9jYW5mZC5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMN
Cj4gPiA+ID4gPiBpbmRleCBiNTg4OTUwODRlYTJhLi45OWQwY2JlODYzMjEzIDEwMDY0NA0KPiA+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ID4gPiA+IEBAIC04
NTEsNyArODUxLDcgQEAgc3RhdGljIGludA0KPiA+ID4gPiA+IHJjYXJfY2FuZmRfcmVzZXRfY29u
dHJvbGxlcihzdHJ1Y3QNCj4gPiA+ID4gcmNhcl9jYW5mZF9nbG9iYWwgKmdwcml2KQ0KPiA+ID4g
PiA+ICAJcmNhcl9jYW5mZF93cml0ZShncHJpdi0+YmFzZSwgUkNBTkZEX0dFUkZMLCAweDApOw0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gIAkvKiBTZXQgdGhlIGNvbnRyb2xsZXIgaW50byBhcHByb3By
aWF0ZSBtb2RlICovDQo+ID4gPiA+ID4gLQlpZiAoIWlzX2dlbjQoZ3ByaXYpKSB7DQo+ID4gPiA+
ID4gKwlpZiAoIWdwcml2LT5pbmZvLT5zaGFyZWRfY2FuX3JlZ3MpIHsNCj4gPg0KPiA+IFNvcnJ5
IEkgbWlzc2VkIGl0LCBJcyBpdCBwb3NzaWJsZSB0byBjaGFuZ2UgdGhpcyB0bw0KPiA+IHNoYXJl
ZF9jYW5fcmVncy0+Y2hfaW50ZXJmYWNlX21vZGUgdG8gbWFrZSBpdCBzYW1lIGFzIG1haW5saW5l
IFsxXT8gU2FtZQ0KPiBmb3IgYmVsb3cuDQo+ID4NCj4gPiBbMV0NCj4gPiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L2Nv
DQo+ID4gbW1pdC8/aD1uZXh0LQ0KPiA+IDIwMjYwMTA2JmlkPTZkODQ5ZmY1NzM3MjJhZmNmNTUw
OGQyODAwMDE3YmRkNDBmMjdlYjkNCj4gDQo+IA0KPiBJIHdpbGwgc2VuZCBmb2xsb3ctdXAgcGF0
Y2ggdjIsIHJlYmFzaW5nIDYuMTIueS1jaXAgWzJdIGFzIHRoZSB2MSBkb2VzIG5vdCBjbGVhbmx5
DQo+IGFwcGxpZXMgYW55IG1vcmUuDQo+IA0KPiBbMl0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvY2lwLWRldi8yMDI1MTIyMjExMTcwNS4yNzAyOC0xLWJpanUuZGFzLmp6QGJwLnJlbmVzDQo+
IGFzLmNvbS9ULyN0DQo+IA0KPiBDaGVlcnMsDQo+IEJpanUNCj4gDQoNCg==


