Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED71AD358C6
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 06:25:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9639.1769667917578740949
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 22:25:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=X11eUzTA;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769667914;x=1770877514;bh=ZmTzAcGXVR3TeqrkkZw3Y++3FL+LAmtDuAQGL
	P3jDjY=;b=X11eUzTAA/3vi7klXBUexaUNaeB/Z01stTQDyJHdo5aQsBq9pAwrRKEZqZC14eubD9h
	JP4U7nCDdkKNcIenR1z7Fu2PagwgqJ3PzQnXONu7uoyS8UoF2uEn0oZFVG9/VfsfkpXI98KuV8pws
	lkwsa/oA7Qzkb+BwCZn1pYrtXgADIC+Ei3nCdcrP2Eq92EcfZ5KSg6e/87jdCkGgolqu4kH6jQ+PJ
	CLu5SLPz86EFc+YqB3zTahtxudNRH/2Ga6Q4PoFpL94mZ9HMu2NFXWhjFTWL6yPZp3wAtRyFyhkNG
	/4oHF8Ut36JW0URSWVIe0GTlZSSPhQebzl8YodtgZ7ww==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 60T6PEBC2936990; Thu, 29 Jan 2026 15:25:14 +0900
X-Iguazu-Qid: 2rWhHaaNAWm0mYc9nH
X-Iguazu-QSIG: v=2; s=0; t=1769667914; q=2rWhHaaNAWm0mYc9nH; m=5odpjimkqInLraifSCOfybh3JemIoSeYd8qTOYPrAko=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f1pzG0hC5z4vyq; Thu, 29 Jan 2026 15:25:13 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N74NS02OuD5W3VBcUSK8Nd+E6Kl4aryPbHhCA5gYO0g//SDQNAxdhbXw/8YcAcv7BsSGE/iIfhbXyrES2GcQC/XlFlcDFrAZH1UmqSoOdckI/nnV9kCacBMP1/0YmWsK2tgNqhUiK9Xr6ATK0eP6wvQlT+ZZtHwPNLjPqUYhE97pw5ovA1nq8lh6lmenQNKnHarPVX12vTzIPBlf1OXovkZ6RGsl7jjJiG3+uYIGdFNJ5zHq55YenuXDH1n7Iuc6QqC9OcCTHY8DW3Cad0tPQD0RZ8jknY3R4Ef0INeNQuGgJADVNDYkmK9khcyWrjTrGVDL/xVt4W7kuktlQ5aPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h3f4Bxb2LOpZPupbltMIg0j4ybTtBV0j+qYVx5ylOw=;
 b=zUvxam2+wfz67rDJXyIQV1rHWmqk0IhwB/crnUAvifWnVb9NTG/dyHwk7V7kIXf72q6zDVcIdR+4BvabfEf+jajM1ZAtBCjgQTfz22wlHa9+yfLOWLWkC7So4dX+xMzYJfIZpr2E9bdr4YPdlGk0J9xGRrmwqOtz0OfBZZJQ3RUpq1ZgNZFdHTSNIVZXgQnPneqQ1HFSJQbvfV1t0oYEWLQev37p0d9dngC5USoQTJb7JXW1hGA9DU5lBFirjuZxbbqWAQE4luqJIedgvOhisMSJI09QUhjgROcu2BtrERvQDQv3rEsX+KWLkivMbq43mdUoss5nDwri4wA7u4UNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip v2 0/2] mmc: renesas_sdhi: Backport
 reset control
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip v2 0/2] mmc: renesas_sdhi: Backport
 reset control
Thread-Index: AQHcj4yDGXMYauQD3kGZR6iIdHatWbVmmfKAgAIWuHA=
Date: Thu, 29 Jan 2026 06:25:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148180E3FD00B8E3EC45FADC3CD9EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260127125723.3705611-1-claudiu.beznea.uj@bp.renesas.com>
 <aXk8fXVFlp36GMxt@duo.ucw.cz>
In-Reply-To: <aXk8fXVFlp36GMxt@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSAPR01MB7166:EE_
x-ms-office365-filtering-correlation-id: 9896aa8f-1819-4b2a-0964-08de5eff285f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dFJkSkxqRnpSU0FvRlhZOXBQOEh2ZW0xOGdsMXYwbTAxVEU0a04wcTIw?=
 =?iso-2022-jp?B?QTFzenE1TVdUTlU0Z2tnUDYrZ1YzYUJoaWhEbmorajFPUlJ2aTFPVWV4?=
 =?iso-2022-jp?B?bDh4YmlzYXBaVndHWmVPQ3QzdzRXb0grdStaWkgzUHIydWxJMjhwbGpY?=
 =?iso-2022-jp?B?dDcxYkMveUFVTHJYTmsxMFhWV2NjNWtUUUhTbmV5YkpJSk1XYUk1a3Vx?=
 =?iso-2022-jp?B?QmNKckF4anJVSDdVWEpOMWNaTm52RzUrWmk5cC9NMzZmK2ZWTFREVVhu?=
 =?iso-2022-jp?B?SHdRVDNGT2tEeStLQlFqdkVRY0RaM3h4SWdRc1ExRkc4Wmg5Z3pWdU9N?=
 =?iso-2022-jp?B?dVROdWd3VUp0d3NQQUZaM1ZQWkwvOFlOdy8vQnQ2am9xcE9KRmdyMWRz?=
 =?iso-2022-jp?B?TU5PdWQxSExMOUZKSkUySFFYYTROdWJXdE9yOUh2M2g2UEtNTmlBaGVZ?=
 =?iso-2022-jp?B?akVzckFHeldYeU1XUGNzSnB1M1dMRm8rSkpQRWVjVitWSGlGMHBoR2NF?=
 =?iso-2022-jp?B?ZElwL2doNkhXamhTK2VsOE8yV1NTOXVqWWRWT254Vk9kUUZobktGaUd4?=
 =?iso-2022-jp?B?NDdweEN6bXRzdnFheFl6ZityN2J2bUxpUWtwclhIZmlGdG5OSzNZN1Ru?=
 =?iso-2022-jp?B?WkphYWszSnh0NHN3dnNlRCtPNS9iNlExOXVUeUlxQW4yaml0NGE0bjU1?=
 =?iso-2022-jp?B?L1NmN2E1TXFMT2VKVS93VTIwMldyTDZhb3E2RDc2aU45NitiMGhDZ2VC?=
 =?iso-2022-jp?B?Y2FPRWt0eGE2NGovNDV0RlorRkcvaHhlc3NjckVOR3hYeFc0Y0FGbUZy?=
 =?iso-2022-jp?B?OGNPNnZIUVRiazRsL3lYTTYydVZtL0lUcllMYzBtR21JRWdpQ0pXdjRF?=
 =?iso-2022-jp?B?cnl4YnVkd3N3ZlhYUmpaZGpyb0hZUEQvUWREcW9QdUxUUXkraVBSUHJI?=
 =?iso-2022-jp?B?M0NkNHhlcW5yTjVUV2h2by9jTFFkcnkrRXVMVkFBODRVUG43RGJscGpq?=
 =?iso-2022-jp?B?OXMydDlsTWtFNWVKb2JyYUs1Tm81OWJwMkpaWUNCSUp2YlkzdHVnbXJO?=
 =?iso-2022-jp?B?NGxsanRxd3RNcDJERTJrVXFPVk4vdzd3MkY0QllGMnlFR1M3enVnVEIv?=
 =?iso-2022-jp?B?TGtzU0l4V3J6RkVoRHhLYjZwTlYwTVhiOG9sU0wzbmlLUTA4cUtWODgr?=
 =?iso-2022-jp?B?WDg3SnA3b2ttNTZxR0d4eVo4YmhlNkJCS3pFWTJvRWxMc1JyeWVtU0Ir?=
 =?iso-2022-jp?B?VE40dklEaUhDeGsybmNqNVpIZnk1NnpQQXVscEpXeWkzcEswL1VLN2lF?=
 =?iso-2022-jp?B?bGh4N2U1L2hPM3ZhcVRoRlBTaFhQaTJBSnVkSmVpM3V2R05FQVVEWFBQ?=
 =?iso-2022-jp?B?NEc5Y0xuNlJ2VlY2YTNRTFRNcTkwQnJ5Skk0aWNGTTJQcG5VTjF5cHY5?=
 =?iso-2022-jp?B?TVkwK1owTE1JMWhETHN2OFk5YTBybVphd1R0NHQxZmh6NkdBdXplS1M1?=
 =?iso-2022-jp?B?cExtSGRla2VsaXdPZ0NpTllsTFM4cFExU0d0c2dhZk5RaG81em5uSm05?=
 =?iso-2022-jp?B?Z2t1OUcwU2oyRmUrY3NDQy9qTUVsU0RPb3htU2pIaytGK2p2U2tkTjBh?=
 =?iso-2022-jp?B?V1l5Z3BnRTFkRGFlWHRWMXd4bkNkaDRlTXF3WS9adERsK052MGs2WnA0?=
 =?iso-2022-jp?B?TWdMYWNueGxTRHRKQS92UEZYQ3c4c21SaXk5a3ZtVXFVY2Z4Sy9lMGdV?=
 =?iso-2022-jp?B?VlJpNlNVT3h1Q1VaVlJZbFQ3cktQbVFoTVVia0xJTmZET25VKzhtV0F0?=
 =?iso-2022-jp?B?dWJSbXBNNVZrMUUvb3ZmOTIyR2lkRWNocnZmVWsvVkt1LzNxMS9BZWdy?=
 =?iso-2022-jp?B?YmF3SFZ5TjdRUmhJY0RGQVJUUjJDbVp1b0NwcWNzRG04QmpBSm4yelVU?=
 =?iso-2022-jp?B?b3QvTDVXM0J1ZFlONmZkRjNPMEY2OXhHZ3h1SFp0REFEaVlSNjlnWmRh?=
 =?iso-2022-jp?B?aTdPK1poZGxlVklYcEdqN2xYWVZoVXpOK3JRbGREd2s2SVc5Ty8vTWRw?=
 =?iso-2022-jp?B?SlB4V0xBY2hJUW96ZXZkRGNrVGptcllDQTVaY2lTWDFQb2VFSmFLOWYw?=
 =?iso-2022-jp?B?TVVJMEpEM1RualZ3WGZ5ajFJZFU3SUhsbU1ueDlJUEJ2ZmtneEJyenlO?=
 =?iso-2022-jp?B?ejZOZE9HUUFwM2VlNUJ3M2lsYitrSVZvSFo3alVYVDN5RjROUzJvNkhX?=
 =?iso-2022-jp?B?R0F4NnBuU0pOaXFndjZwVnA4aHFLejIyWVZjVG1VRmdkQThzYjdkYmpp?=
 =?iso-2022-jp?B?U1dCNGZaaHZoekZ6Y0ExWkViZVp3ZU05dTNLUVhaaGtpeWZzNENRSmlP?=
 =?iso-2022-jp?B?Y3lmSEE9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ODFaWmpxUlVUSWkwZm9idmRrZmlQSSs5RjB3TkpMVmx1YlRna00vRnRs?=
 =?iso-2022-jp?B?OVdjWkZmNlBiaXFmajU2SWJPRTZLd21IcENoRWhnaTJvVWdtQWtyY0NW?=
 =?iso-2022-jp?B?Z1BrdWRnTUJZNHUrMC90d1ZCT0NaYlJYZTMySE15MTkvc3ZBMXlPcFBy?=
 =?iso-2022-jp?B?ZERERHJoQ2hvNHk4Qko1TUlqZGhqMERqTnBTVXB6MlJBUGZqSUdhYkxG?=
 =?iso-2022-jp?B?U2ZUS1VmckNTQkxYUUtZcDF2dUVSY2xadXI2c0VBZzdQQTRvdWdCMGpa?=
 =?iso-2022-jp?B?VUJHckJrOVdVUlZXNjFvZ0dna0JubWg2ZFVxVHFwaktIRDdiOGpwc0dJ?=
 =?iso-2022-jp?B?cjBmZ1BNYUxVeXFqOEV6UUtuSGRPTExPOWpRSDVyMUhvbklocC9VV1V2?=
 =?iso-2022-jp?B?Mk56R1JKcG42UkZqaGdBK0M5Q1h5M24zTnVUNndlZUdPOFczK2VoN2JT?=
 =?iso-2022-jp?B?TVoweHVGYXFYMUszaG5jR0tiNlFyQ3NuTUpMNUZtZVVVOW1qbXJuSnNz?=
 =?iso-2022-jp?B?NlpUd0hTb0tBbGxTL01McmgvNUJvdENIS1BLUThIK1Rpa1IzKzNVS1pY?=
 =?iso-2022-jp?B?S0ZLaW1rU3BZcUZYSnJBNUNGUHlVWHh2WDZKbjFSQWx5enNnelQzZ29C?=
 =?iso-2022-jp?B?d0U1dUFkQlJvZ095NVJOU096RnY1RDk3eVNzUWtDTHk1KzZEZ1ZLYjhY?=
 =?iso-2022-jp?B?TTVaVWZKSkR5KzZTVGIrcnJaMURDL2VIbFNwcmp0SG42aHFCQURYc3hV?=
 =?iso-2022-jp?B?WHJyWEc5Y0E3VFNOb3dxLzVjZ0hIcEczSFM1YUxvcjN1YXJwckFrRGFo?=
 =?iso-2022-jp?B?YVhmMHpsSU5GekgxYnA3bVhWK3dacjlJUlNBREJSNDQrL0hpSWZvZWV5?=
 =?iso-2022-jp?B?YVVVeEdZR1pnWDlJL1FnRUJYNU9NNTh2TmtKcnpvSDBsUVJyY3FOQ0Zq?=
 =?iso-2022-jp?B?djRxWDd3RWZSNGUwZUZ6OHJzd21QcERQZDUycFB3OUVmNjFkZDkvZ3hm?=
 =?iso-2022-jp?B?aTJuQm1kL21yL0hrVWNOQnN5ZUVUeFRqMi9NZ3U4VmRsYjc1bzNraWh4?=
 =?iso-2022-jp?B?dVR6cjhqdUF5MU1SOHBxOXk2TTYrU2FHUWRSZUxkQnd5Rk8rdWxzWUl3?=
 =?iso-2022-jp?B?cTdLeFVpRGRBTVk3WnFCcnFzbUlXaXZpN1pKZDVvaUIySWxka2loWGFP?=
 =?iso-2022-jp?B?ckFOMmJFbWl0aEVLc2FONnkwUlRVMTE3aFcwdUxENCtpdXprcmw0dmdH?=
 =?iso-2022-jp?B?c1N1SG5qcXhrM2w1RTl4dERZMDhIOXBTZ0NjS0xteUo0Wm54T095TzNa?=
 =?iso-2022-jp?B?NVd1YlVoVy9hNXN6RUZ6ZzFRUWdrUk44MUs5bTgrejZaMFU0bXhlT2c2?=
 =?iso-2022-jp?B?c05YRGhDM2xTVHBpWjNqbEdyMWRVbFh0T2NNOU10YXFQK0U3K2xWbUVJ?=
 =?iso-2022-jp?B?MWoyOFowZjQ4akw1UzdJL0pyWTF0dGJLS0wvMGtYZHBxMWQrT3IxL2xJ?=
 =?iso-2022-jp?B?bk92REdVTUN5S1JLTWduWlh2ZUd4Q0g2UndpblM1c0FDcmNSdCtzaUhh?=
 =?iso-2022-jp?B?bWZiTE9mMlA1ZUN4M2kvYTcxeGNkL296TVhjVVNRbWVSY1pPa01FZkVq?=
 =?iso-2022-jp?B?OUhsMFBQTDBTK213NWN4KzZwOWNKaE0xem1heWJubkRVQm04R3ZJUURW?=
 =?iso-2022-jp?B?THgrb09tdklIYjRnR1F3Z3pDeVhIZ09vWlR5aW93c2JVM2hYYkNuSVlw?=
 =?iso-2022-jp?B?WDhHL0Z3NE5tMjNyRGhXQStBUmk1Mlg2ajB4SVF0WFRRYWdmc1pKZkxP?=
 =?iso-2022-jp?B?bk5sczZqWHhFaklkK3lRMlA0YmZGWUdiY2kvbngrbGpnK3M4ak1yb2w4?=
 =?iso-2022-jp?B?YmlvU3VVN1hQV2RZei8vL00yZ0lnUncxNUNUS2RqdEsxWDQ0eTVTWmdu?=
 =?iso-2022-jp?B?VUhndlpMTDRweHI2ZlhrbGVURkFYMWphbmV4eTlnaHRZUFhqMGhEdVlY?=
 =?iso-2022-jp?B?WHI0R1dtMjFTQzQxKy9ZRnRhUTJYMnI1M2ZYaGFwdjRMbU1zYzRxL3NN?=
 =?iso-2022-jp?B?c2IvTzdhc2l6V0daaWFiSjA1eTA1KzVhclJJS25Wb25xTEFkSitJL0k0?=
 =?iso-2022-jp?B?RHJ2dmx5dGxLTlVtMGJmRWFzQVdkcXl4THBTaWpkdVZ0U05PZG1EZGZD?=
 =?iso-2022-jp?B?NHlqOGdiZDJxbzAvbEtGZUJlUjlObTlMUDc1Q1MyNkpzMmR3R3E3dTEw?=
 =?iso-2022-jp?B?RDc1cVJub3l2c29MQmpPaEdLQjI5TUdKZUYzak1VUjIrb3ZBOHlGckFi?=
 =?iso-2022-jp?B?N0cwRTRPenBUK1d0dFFQdS9walFMYXo5TEFvQnFxU2MyMVdVUFVOZnNn?=
 =?iso-2022-jp?B?Y1o4NHR3d3dtUGRyZTdFOVhGZC85bnJrdE1kR2lEWXkybjh5SlBiVlRW?=
 =?iso-2022-jp?B?bDZ3eXhtczdqeFFZaDlNY3FqMm1CT0pmdCtCVGVEekFDaVJNQVlVNlly?=
 =?iso-2022-jp?B?UmR2TnR5TncydXVNLzVhMjFXMFRiSVIzRm1iSm5OaGJ3a2h1OCt1R0w0?=
 =?iso-2022-jp?B?YmNuVTJYOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9896aa8f-1819-4b2a-0964-08de5eff285f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 06:25:11.9606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SP8MkAy35i2kjpUROarnqCBuEKLOtqF6HgRHENuGKDWs5KJ4NywZkidnoGyKdze6+BSa5rcywgDMRU9qOORHBer1aLkWEq/eANT5mMkhHCfjUHix1kz1ilLmGoVIKPHU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7166
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Jan 2026 06:25:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21783

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, January 28, 2026 7:30 AM
> To: Claudiu <claudiu.beznea@tuxon.dev>
> Cc: pavel@nabladev.com; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =
=1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip v2 0/2] mmc: renesas_sdhi: Backp=
ort
> reset control
>=20
> Hi!
>=20
> > This series backports patches to control the reset signal of the
> > Renesas SDHI IP during probe and suspend/resume.
>=20
> Same as 6.12: looks good to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20
> Best regards,
>                                                                 Pavel

Thanks, applied with your reviewed-by tag.

Best regards,
   Nobuhiro



