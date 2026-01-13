Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857C9D29DCC
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 05:43:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52781.1768282999436134525
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jan 2026 21:43:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=EGnop1Yk;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1768282993;x=1769492593;bh=kWX7fQvh6trr3UM7GGyl6/X610O97UhFmCQKi
	/w/uhg=;b=EGnop1Yk7wSa2h1zZkecRcLWG9oYrNmBKW1ffT45M11PIOdRAELjXBRR0CdQjRy3N84
	YRDOzfZV9DWOtPf0qCYpxTqHGsJv8uTe5rbXEoANnoh9bJWrcNpfAd/zF+cNPUuL5q1XPoZm+L3aL
	tNzW9eyo0gHBQkWbaLnBXCNgHm6LIUIyvflYnd9CTW0BVNi3GZ20qQ31nXfFYaEn9N5bHAfxqI9de
	Sa9wyCV5Lvl+akzqDYo2+JPvD8otHQHS8GzRIfAFhGcrPzWPegml16MesaWZt5eNl3pkQWNceWjE/
	xDbEpMevamdDEbw1um+UKCZYXBL++PiX9BqJhMd8aQKA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 60D5hCYg3437044; Tue, 13 Jan 2026 14:43:12 +0900
X-Iguazu-Qid: 2rWhoMOwv3luy4O5MU
X-Iguazu-QSIG: v=2; s=0; t=1768282991; q=2rWhoMOwv3luy4O5MU; m=Ok9q9hxlb/mA0MsqfUE+RTucgh2hpVMAAPIrCZl83fE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dqyp70HDgz4vyk; Tue, 13 Jan 2026 14:43:11 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD9FIuM+9iUpovX4R6AnCk7LCXWGXejPnWTaAWglpHBu4/2KAosSld2KAT8nLh1EnRxCXapk2C4Q93exl/iahEkEizJm5TNY8rn+Ifvz909gxugXJ2/necwMXblOdk5F5MKJfE0olko2sEfnjbW7xAqhC/kAIu4g79G0C5j7LH4KJ++tIeqjb7XfNeayjp1o6ykkeES84EPdGoJfNfMF2B2iyg2e/BdLoOesUKzUJPWZAbvqoerk13T1T0LW3soAKSUEzdFgB8Vkkcm8X5z30DT9U+zcg/NKMNNbxj1Bt85IRQiU6BRVMlULiGqriWASeN3jvrOGkf9+6ETZEA47zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I5uTaCW2sLM/j4rHhoAvrvANilv47l0Ec86/5xhd8A=;
 b=DD7SxzZjKhKBnLO3OhVlzOK3v4dcfEtId+UAUIOpge179BGIJbyATvgAMwcQv/cKNHEmPEWCnzbUe9ZHSU88uFYQWkOr6vVVHmxJrIo2c7C2IkpQotWq0J2Wxp8+QvL05l/26/R/+MJwn7OnaI5O3Q/yYrLdV7rKzVG3cu4d8c8K65n17QAZd60ci4WhawSncGVYBvSUysfQn8spNT0dlV+6VyXvV7OBULwmVsrOfvTvZ2W17OSBqtAYgPfm5bdgpNynr9yPYIC3YWnsZpgkqo+e+bQMv3U/pNfiX8MYuat/67AzpGFpWds/tEQLh0vsR0FFoWJcAiuMsBGF4ZSmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <tommaso.merciai.xr@bp.renesas.com>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <tomm.merciai@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/22] Add I3C support for RZ/G3E
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/22] Add I3C support for RZ/G3E
Thread-Index: AQHcgIFAZRMB+qPoHk+0V5ST4l3Rt7VJp5QAgAAYpICABdckoA==
Date: Tue, 13 Jan 2026 05:43:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148183E8B139F71C9C853E40CCD8EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
 <aWDa/P7QVLdqjKrA@duo.ucw.cz> <aWDvp3CFQIiO52v9@tom-desktop>
In-Reply-To: <aWDvp3CFQIiO52v9@tom-desktop>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12939:EE_
x-ms-office365-filtering-correlation-id: c7525337-ea6f-47e0-b6c8-08de5266a177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SmdZV0czWnVMLys5RFFtYVpGTzZ5Z0dyK0JSODc5UUVrdDVCR2RGN3B0?=
 =?iso-2022-jp?B?Uzk0ZG1zaUdmNStPNEh2OGNoaC9FbFo3cmFxSzd5S2RSZVBTMkxlcmVJ?=
 =?iso-2022-jp?B?SW92WVFnaFZSMlpVTTFVVWlwQnkvNFlIRHVJb0swMDRSK0dSTkVjb2N5?=
 =?iso-2022-jp?B?U0pnWEVhZTFqVEhyNkxYUHVMR25QMzdDT25GQmE0YUF1d3FrZTRnRGFL?=
 =?iso-2022-jp?B?RTl3bXVlSGovSCtSS2ZIMXNFcVNKMlJPWWJ5N21xQzVKME9ldzNQQy8z?=
 =?iso-2022-jp?B?OE5PbU5Wa2dmVThKZ2t6OUZYSWVXSGhnNnNYMUpFRit5L0tWT2l0WnpU?=
 =?iso-2022-jp?B?aWEyUjJsb0s1V1Fnak45bDBaSFhHNTJCWkVxNmMzQmRJVVNsQXJCOWw5?=
 =?iso-2022-jp?B?cTdUTE1GNVJzaWpwWWdYVll1UlFHbm0xakFSd09IK0ppZmRUWi9wb1l6?=
 =?iso-2022-jp?B?UnhVaFVNd3JRTUtDSGE0ZWpaRWFXV3N0SC9ZS2NlblBkdlVSMDlQU1N0?=
 =?iso-2022-jp?B?ZzdiMis5RHdKdkRTcUdBaHZhbzR4amg1dHhON3lIOVpQeWRwc3M0bVNr?=
 =?iso-2022-jp?B?ckF2Y1FhRkpBYW0wWGlXaWZNZEo4cXRSV043SHc4RFp2bE02UElzUWhP?=
 =?iso-2022-jp?B?RzlsOFBUaTJUN3JJbHcwZHVMMzdGUWFGTVdhcUpWVkJ5WDN2anh4USti?=
 =?iso-2022-jp?B?aXJIZ1dPVDdZRG8xRkNRTFkvU1dPaW1IWWkweE1XMGdId3ppS01vNzVK?=
 =?iso-2022-jp?B?cWJMUzdsUGlxelZRL3NWbTlRL2M0VlU2c05tOGEwdWtvWC9tWFgwTWZG?=
 =?iso-2022-jp?B?MllaMWJEZXNaR2V3RU5kODNtbEtBTG92bHRRaENlSEdadHYxSCs0WTNi?=
 =?iso-2022-jp?B?N1BXVGhXMzZFbVZ5eXBUR3JVbGdJWHF6SnlOeVUwUUU4YkVKa3BiUjl5?=
 =?iso-2022-jp?B?UXhmNnJZVGNnOEg2USsxdmFlS0xMdGd6S29ZeXJMSmVtd2FmR0llQ0ho?=
 =?iso-2022-jp?B?WjJBMTVyVFpZMld1Rmt4TTlDa2RKMjhxa3J6NTdZS1NWTlFGc3FxVGNs?=
 =?iso-2022-jp?B?dDMwVUZka2NTZ250T2p4ZFhyZ1RGZ2hTaEN3YVl6Rk5nUE9GMEZiZ1Uy?=
 =?iso-2022-jp?B?Qis0N2oySWxhdVF5Q1ZGVUU5bG1rQWxhcVBZNGJDK3Y2TWxoZTZ5UW0y?=
 =?iso-2022-jp?B?UFZrclAza0xxQXVWaTd5NkFEUnFTWGx3WE5CTytKQ09VKzFWbXlVaWNM?=
 =?iso-2022-jp?B?NTVjR3gzdkp0UzMrQ1g5c3J6Q2RVUi94c3kxMityMFNDaHlqdHoySkpU?=
 =?iso-2022-jp?B?Rkh1UXEwMHprOTd2UlBNWWRxL3J0V013ZWdSeUxIQUtIZk1QNVVJcTQr?=
 =?iso-2022-jp?B?eVJOQ2JsWmZQZ3Juc0JaSzdpNU5QNFFlTENWOE42NCtJYVpFQUhTMjFh?=
 =?iso-2022-jp?B?NG9OL2crVHUrRnN1MkpGYTZwTWxWOWl0NGlHZnJ5ZFNsM2M4TWdZYW5q?=
 =?iso-2022-jp?B?SUZ2OHR2dUw1MnpBcHM5a1pPRUd5anZPMG9VKzhjcCtXN3FGQjdheUU2?=
 =?iso-2022-jp?B?azVBUEplNzhmb1EvZG9ETnQ2YkRQZmN1akxvNDZjOWZIUTlCMUJOWEZs?=
 =?iso-2022-jp?B?RjlHaG5jTFZyT3FBMngyV2xBMEZoL1FvZ1J5VWx4WnBRMllBYjNYY1Za?=
 =?iso-2022-jp?B?YUh2R2lwdzlMNjV0WncrVUZmUVBCVW5IZFBreXFZbXdKNldLYlNYU2tU?=
 =?iso-2022-jp?B?QXJ6UjlaS2NUcHFIYm52cTFpQnJNWWtiUVhhQUpjSEt6MEk1MnpzeCtp?=
 =?iso-2022-jp?B?ZTZiWUtaM0dGMGdyU1ZRYytJckdoeFF6dDgzc2VqNEc2ZFVGWWlGOWZm?=
 =?iso-2022-jp?B?Z1EyY29FdHB6dE9Kd2kxUjNuaUllMFZUTmtsTklMUEZSNmxjQVVobDM5?=
 =?iso-2022-jp?B?UFpOdGRJaTBZRE9qTE9aZXdmMmhVV21iTTh0bFdZWFNEMjZaM3FKMlIx?=
 =?iso-2022-jp?B?MmNXNWhwdmx2K2lkcXh5MjlyVWZrU2FuVmppWnQ0L0hrbGhOYVloSllK?=
 =?iso-2022-jp?B?cUg4cUpwS05YZUpPRWxFYk1FWmcxUHoyT0N2QjR5WWYvOXFVbVZJSzk2?=
 =?iso-2022-jp?B?cWdBUFlCV2VHRHdJaHYxdGl6NWVlNG1rRXpNcXNLbHI0TlNuRnR4T05H?=
 =?iso-2022-jp?B?akErWWpidVpZL043eGh6bjMrUng1U0dU?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NFZlbTEvM09sakVvMzZhNSt5S2RVczJSU1dTbGc1T1RMbFBVS0RHSGtS?=
 =?iso-2022-jp?B?NXBSbEFoZ3ByOVZIR1huSHg5bWwzV0dJdzEyYWptYk1oWU1DRkFGZ2FV?=
 =?iso-2022-jp?B?TnMvWGVESDlqQVNra1dJRzhneFBoTEhaTUw0VU00RENTVElOdUgzUith?=
 =?iso-2022-jp?B?dGo1bkIwQzhKUXFaUDRjaVBkTy82MW5KUUd0SFAzWDEzUVJsZEY3ZVRT?=
 =?iso-2022-jp?B?Y0N3R3lCSG45ODFoOG9GM2pNN0I3QUYzSTVadnpZMWMwY0pYMUxUOUJq?=
 =?iso-2022-jp?B?aEhlbFhVNWR0LzlJQ0RRVkFrRlpVc1U3bnZweFpuTkcxTTBFMXJsajlk?=
 =?iso-2022-jp?B?LzBEKzB3Ulpva1VOaGFEd0lHbkhKTGNJeGJ0NmJEOGRxTnlMK3JrbjMz?=
 =?iso-2022-jp?B?bHo3SFp3c3JxZGNidTZBVENFVE12K2xhMlRueVpiVkYrM2pPSzJBVTh2?=
 =?iso-2022-jp?B?bndvZGZuZHU4SHFHZlR2UVp5SWxCbVlxaFJLWTYwMzIxR3MvMlFBUEFS?=
 =?iso-2022-jp?B?L2lGazVUUXk5Tk02ZlhVWXBDSE9VMnpjaFhMT1dnbnlUL2hBVlFoN0Yx?=
 =?iso-2022-jp?B?RVE2SmhHaGc3UU1rY3FrbGZhMkg4SnZRMXNGVE95cTJQV1pjZUh4NG5a?=
 =?iso-2022-jp?B?WEhWTzM0Mkp0VHhXTVVObUZOL1RlK3BsNVFWdkIzWnVPOWlLYnZXbW9j?=
 =?iso-2022-jp?B?N3BwWHRQbnJ1dWhlTUJOcGZiNk9NbWVvT2RSZXYzWFVkOXAxeVRXaDBF?=
 =?iso-2022-jp?B?emxmVXJVTjZGbFd2K3RxUVFmcUtQVmwzMXpaeTR2R1dheXU3SmRRNis1?=
 =?iso-2022-jp?B?R0p3azZrN2I1d2syUnVYTXJBT3paY3JHSUk2d2o4Q0xjSGpzaGhkOVVu?=
 =?iso-2022-jp?B?aWo3ZXQySEJQNUw0WTlWcDNNS3JZUWRlSitMK2Jzb2IyMU0zNDFteVli?=
 =?iso-2022-jp?B?WjZweWhIS25xamhTNjRDTncxaE42V0lXd3d5d3ptTi9PU3FoSjVMRDFV?=
 =?iso-2022-jp?B?SlJVSy9iaHByYmZOT0U5NHRFaTlIU1FwdjhFYXlCRDFieUpnTTI5aTVI?=
 =?iso-2022-jp?B?bGxFSGZOVURzcVZGdjFtN3VlUlRXZ1NZQ0V1MFRhUGo1TnZYWkpKYkpk?=
 =?iso-2022-jp?B?clhKZzJ4eVJIM2tPS250YnkrVDNlS0RoZHVlQms1ZzJubjk5Z0szY2Y2?=
 =?iso-2022-jp?B?dGRsYW13Z1lmY0hoV3J5bW1vdENqMnM3UG5IR3BaUWd1SitPS2V2MXF4?=
 =?iso-2022-jp?B?ZW00MjR5emlBa08vNmh0OEtXNTVYUGVQZjc1U0RuaG5UdnNLMkE3dDJm?=
 =?iso-2022-jp?B?NitDMDJ0ZUd1eExwUDIxa1JUdWVVRDVudVR0NUVPcTIrTi8rRWNZdnY1?=
 =?iso-2022-jp?B?WkV5bW5DajVSUytQNTI0dHFQaTdYT2poMmZJMEhEdkJjZklQYXdwZ2ow?=
 =?iso-2022-jp?B?anIvOHlkbnE5UjhtTXoxcklBUXFqaTZMbW1IOGRMNU14TnN3cTRBZ29k?=
 =?iso-2022-jp?B?cjZCTU1lbm16WmZpUEJITHpyWUZmR0tTNERXQThMelg1Ym56RVhlZk8y?=
 =?iso-2022-jp?B?U0pNakVUcEV2N2hjcGFaTHZ2c0NrakVLV0ZhcmdJY3R5d3JCaUF6WFV4?=
 =?iso-2022-jp?B?RzFSbG9xMkNINXNGUjZQT1VEc3JIWXROTjR1OURNZnVEV1J6YmVCQURY?=
 =?iso-2022-jp?B?S202Z0VRaFhaWjNDNHhueWVQV2l0K2pJcEl5OWdjeHNsVXVOWlR3UjV5?=
 =?iso-2022-jp?B?c1BXUm9mQUpjaHVNRTJkYlJZWGJOZFEwQ01wb1QzbTJGKytWdCt4WjBU?=
 =?iso-2022-jp?B?TzFUT01FNEpLN09UNFhObGRpN1p6ZnhPaEhYblhBdHREODJoOEZqZStB?=
 =?iso-2022-jp?B?OTlUM1ljaEpLajZmRmhHVEtoeURVNFZMNHBDK3B1Q3FLdEVyVTZueGts?=
 =?iso-2022-jp?B?YmY0aFNMZHpGVVViM21xUktxYll3d093VWlGZUk4UnZpUnB5czFRaTgw?=
 =?iso-2022-jp?B?M1lvUkhiaERrVzZOS1pUODlIdDh1OW1vQWFnWWNMYTh4ME96NnkwbGVM?=
 =?iso-2022-jp?B?ZGYxZUtJUUQvQnNXdXovdzVVMHRSeUlqNW02QW5XWFE0NlNlQ2t2V2ZW?=
 =?iso-2022-jp?B?OC94ZStVTVdTZURyckJXN2lteDFiRDNzVFlSS2R4amRGRnRBaTFBbXpZ?=
 =?iso-2022-jp?B?Qk5EME95djMrUFdZckZmS1N5S0hCNnNUaVZ0Vy9SWXV0N09LWXV4elpS?=
 =?iso-2022-jp?B?SzhVQWhUbkNyczFzc1F4REprUk5kRGE4ejRtdHp5Nk1rU3VYcGlYS3lp?=
 =?iso-2022-jp?B?SWVhUmU5cHdOK1dZampHd2N1OStNbzJhZk9LVjdLVlc3Q3F6bEl6aWJP?=
 =?iso-2022-jp?B?UTN4QVJyeGJVWW5RVHZzN2xiSDRzZ3ljZFRubGJGRC90QjZ5ZS9UUUN5?=
 =?iso-2022-jp?B?N1ZjTElWSk0zbUZBbmZXT21SNCtabElzcG5GalEzM0xadWd4QitPRkd1?=
 =?iso-2022-jp?B?eVdvdnJNZTFkalZwOGNJbzBYRHQ5YVZ3Lzcvb2lkYmxPYVhDZHp4U29T?=
 =?iso-2022-jp?B?YzYwalFWWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7525337-ea6f-47e0-b6c8-08de5266a177
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 05:43:08.2252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7S6UaxD2w6YJsIn3P3qTQDhH8KLFhx5Dw9qCFowrImKLBAC1/G1jZikW6OAs1+EnXMPZWjqP0lce7WFZ/qI2ghkycUIM10Oxy2EFZ7q//ZpFLW6ojV265myoH8zD+qXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12939
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Jan 2026 05:43:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21535

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
> Of Tommaso Merciai via lists.cip-project.org
> Sent: Friday, January 9, 2026 9:08 PM
> To: Pavel Machek <pavel@nabladev.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/22] Add I3C support for RZ/G3E
>=20
> Hi Pavel,
> Thanks for your review!
>=20
>=20
> On Fri, Jan 09, 2026 at 11:39:56AM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > This series adds I3C support for the Renesas RZ/G3E SoC into
> > > linux-6.1.y-cip kernel. This includes also nxp,p3t1085 I3C
> > > backporting for testing purposes.
> >
> > > Tested using the NXP P3T1085UK-ARD connected to the RZ/G3E SMARC
> SoM
> > > via the RZ/G3E SMARC BREAKOUT board.
> >
> > Do we really need to add nxp,p3t1085 ? AFAICT people would need
> > special hardware, and then would have to patch their dts anyway.
> >
> > I'd propose not to include these in -cip, as we could test them in the
> > test farm, and it is just for testing anyway.

Since these patches are necessary for the working of the ICs connected to t=
he board's I3C bus,
I have no problem applying nxp,p3t1085 patches.
Additionally, the contents of these patches also appear to be fine.

>=20
> Just FYI for testing on RZ/G3E I used this series + [0] + configs i3c rel=
ated
> enable.

Thanks for your testing.

>=20
> >
> > I had some minor comments, but those should not block the merge.
> >
> > Reviewed-by: Pavel Machek <pavel@nabladev.com>
> >
> > I can apply the series after 6.12 version, if it passes testing and
> > there are no other comments.


Looks good to me too.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

> >
> > Best regards,
> >                                                                 Pavel
> > --
> > In cooperation with Nabla.
>=20
> Kind Regards,
> Tommaso
>=20
> [0]
> https://patchwork.kernel.org/project/linux-renesas-soc/patch/9d1cf2cdb1c1=
1f
> 24378404142e4c8aff680c6961.1763638659.git.tommaso.merciai.xr@bp.renesas
> .com/

Best regards,
  Nobuhiro


