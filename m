Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA5FD358DA
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 08:10:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10570.1769674252355634347
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Jan 2026 00:10:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=nryhPoVx;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769674249;x=1770883849;bh=cYYTnuVJAQcsfNwcRwRnT1w6ztrDgCW+QSOX3
	d63We0=;b=nryhPoVxi07jEVHU1TBuDuNPXRO2AeJ6TNL3d3JW+bhPbdZhyesrDWJmK6lqmBIOc1x
	EbcdSc5JkVqrAct+XhcmHZFRHwbEAOZxCWu3+gbgK6l5BdC2/C6p9SoVLZSfs6LuY4CULt2GYy9L8
	Vs9cEv6teh1jyhGy2k0HTxtl2aSEObkKip4FfIOgeV8PPXlVVVgAj9e3FWGYtbwvbd3ZICDEWs84W
	RKEqbBjOgAsqXDYe6qg8ofY5oGkfvwHJDgPOFcmKQizTWRU+Uf46RRb4s4CVRvXFaYmMg/xPzJZV6
	LDV/TWvn6Gpq38vrU2yxUpKJk1JpJrjAJTIMxIagkF5A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 60T8AmJh748920; Thu, 29 Jan 2026 17:10:49 +0900
X-Iguazu-Qid: 2rWhHaaNAWtjjIGSK1
X-Iguazu-QSIG: v=2; s=0; t=1769674248; q=2rWhHaaNAWtjjIGSK1; m=YguAne52PoKLGe+neXLVvTFJSsT4SSHvp61nQcCwRnc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f1sK427mrz4vyw; Thu, 29 Jan 2026 17:10:48 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olJPn0/jhw/LgnYGKKntxvItNSqEWP+EMh5eLjJYvQ88ks6sbEYRLnsY01qcCMiTYeFdCC9dwzr3di0cNm//D64XjFq5M9Btd38EPUA1+/BNIj+hIzukSxubLqQCMCVBKmqmwoSV5pUeaih4CAvTUqNl0yZLRe/V+YMu0OXjoB7x4ZzoO9DeCAWo6udCN3+j56jnW0g9LtWByaEycKLsLbNbOy7n5p3casjW+f7PaYwF5Gbr9Jzq5hwrxAJv5NNZK4Tz1mksUYUaI2WgXO3aBuW5f9m5NOXoWdHZf8fwc3DkcdHJNiwHNkliWCvDSp6FT0WraTtatSiCJNshFwxuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9zxIIgaz+6EZysMUBRwatlrIGvVT3qClLDKdOxZLXk=;
 b=m4Eg+2Nz8my0CcwfZddhZDzHy2joRq41GPs2efNYGwW+11Byd37KC1GmhI4W8fO/1jPPoWflhdstkCljUJhi+Yw6Xm7POPQIPCXuCsa5VRXoJYLiKYJtXg1mtxSfC0AU9JgAseiOgBSWSYzgRwn6t1tkBHokdB5mi7OlBi2a7tqj66cIWYuT0nRH/TwVtWwpOn6DjLxIjtBdkJpSN/qq1JrA4a2SaEqxpzRzGmEAv6umaPCL9PCgDUO2++5+czooHlvsbuvQtelhqHkMUlvKUN8ijMX0m8IZd0Q3hvYdpth6lU13kTMYrCr+CNQAARV8nipgXwf4JJat843YK5Bc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 6.1.y-cip 00/11] Add RZ/V2H TSU support
Thread-Topic: [PATCH 6.1.y-cip 00/11] Add RZ/V2H TSU support
Thread-Index: AQHckFmWDEZFO47JiE2v8ixOLy4UobVozFJA
Date: Thu, 29 Jan 2026 08:10:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148183B37BD1A587297164320CD9EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12156:EE_
x-ms-office365-filtering-correlation-id: 5dce260d-ef73-4dd6-e98f-08de5f0de686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZmZpb3pjT3NnNmZBYzVNZnVNWG85R2w0eWg5eFJPZ09LQ2tQOGozS05a?=
 =?iso-2022-jp?B?VUlSNDFNTnJUcDNMTld1SEhVMmpBTlJkNmVZd0xCMXF5NTd6QUozNGJG?=
 =?iso-2022-jp?B?ak8xWnFJakQvVHJrWG5Vd01qcG9DSVpKOXllcVM3SnV3aTYrVmxnbFV1?=
 =?iso-2022-jp?B?UDdmMUlsQ1FoM0g2Z3J4RVFrY2hWOE1YbEJZMzZFTWwyYU5EY3kwRC9R?=
 =?iso-2022-jp?B?ZGt1eHZ6a29CK1Qrb3ErOHlqQ0tJbHlFRTZMdDBHVnpWRVFBUGRhUFpY?=
 =?iso-2022-jp?B?bk5RZXFPKzNSVTA5NGRVN2ozVmpFZXIrN2dhVEdrdTJxNWw0K3pJRHVW?=
 =?iso-2022-jp?B?dnY3MFFyTDZadERqRVZJOXROdWIycUdmbmVKdzZTcW5kQ2tnVWZsdEFz?=
 =?iso-2022-jp?B?Q2p6M2hKbVFuaEo0MlkrRHAzTTQ3TXE1M1FFMTdYcHFpNkM4L2h6RlJE?=
 =?iso-2022-jp?B?RCtPeThHd2xqOG9YMHR0czhmT3BHTy82Mkk1SmFZQm96cy96L01jRDlH?=
 =?iso-2022-jp?B?Zjg4QjRIZ0VPYUpRN2xYWUJLQncvWGpzNW9LQVJYa1RYTU5xVHorZ0Rq?=
 =?iso-2022-jp?B?UlRDRWovS0ZDOWw5anV2Mzh6Y3ZrRkl5anpTZHdCa1prT2FiTEVqbUlO?=
 =?iso-2022-jp?B?L0trb0huWldyMU5jVmdpUjlIV1FEKzlZVUdBNjE4cWJ4dWF3TGl5Zk5N?=
 =?iso-2022-jp?B?QWhPRm80OFhlSWJVUVQ1OUgraTVuY0prcG5sWnJhc0t4WE5oSUlQNmtR?=
 =?iso-2022-jp?B?bFZRY3M4aXJ1ZFVsWEJhNmZLdU85cjRqQzFGVlhSc0wwNmFuUlN1QW91?=
 =?iso-2022-jp?B?bitQY0NJTGtpSWd0Z2R0Z282YmxMbHI4SVFFNkowSlh4N1lhSDcwMnlS?=
 =?iso-2022-jp?B?QmRxTDZhaEsyMUpsKytPejdFeEFuSkc4NVlqYXY4U3ZQOE9NTWduMDl3?=
 =?iso-2022-jp?B?a1QrMUpJQ3RjNmpvblRQZVZWcFVMRXJkQ1VlOXVwTGliUmhIOFdWMzV5?=
 =?iso-2022-jp?B?YklpMHZRZzBSc045VUEwQlVnWGZJeGJEYmlsSFNsVi9tNFZpYVdXdDJ5?=
 =?iso-2022-jp?B?aUg4RWRPZ0lLWHZ1em9YOUlaN1FleElZdTVpbUtIbGRTOW1TQkllQis4?=
 =?iso-2022-jp?B?NnFRemxmTDJSQWhuZytJTE9kdVg3c281ODBnZDdTTkNUb01UOFZHNFhC?=
 =?iso-2022-jp?B?ckdNa3FnN3pnM3l3SExBdUtlaXBpRkh1MXJmeUhZQW5xRXBUcVZObGNG?=
 =?iso-2022-jp?B?b014SmdnMGNqTEdFdlcxdXd0ckFBbVR4RXo0dS9ERnREOHFrM1ptaGx1?=
 =?iso-2022-jp?B?b2YrSVZUZFY2YkNjOFVMM2graXVZSFYvNFNRYThmTDdzVlYyaVczYy9p?=
 =?iso-2022-jp?B?bHhmNVB3cmNqQll5YWpLakJBVE93YnVsbEhYakZjWXU3MVlFdWtPdENV?=
 =?iso-2022-jp?B?blE3b1ZVZGFlNnhkdDNtYVgxSHY4VlFVRzlBaGI0U1RHNjQvQnpxNWN4?=
 =?iso-2022-jp?B?VVFoNlpJSUNIeHFuOHh4ekFSd3VqcklXRnBtR3FITU8zQ3VSbDdRbTYr?=
 =?iso-2022-jp?B?UUpqd1RpWmp0TW1tSGdROWFVUUhKQVh5M1RZTGRhV1RQWUV2QWVLNmFD?=
 =?iso-2022-jp?B?UzRqT1pzWkZwdDI1ZXNRWVBzZVdhZWNVZzRzc2tzWVJIT1FBR09MOEx6?=
 =?iso-2022-jp?B?VlBqODFOMnV2ZUtCcERtSVd0Q3RweHVXNS9Qb1JMVG9EdXRWRGxqQUtq?=
 =?iso-2022-jp?B?cEsrYTJEd1YvMlZtRGhLcHE1TjhRcDlCUzhXTWIwaHZFTGlMOVlDTGJP?=
 =?iso-2022-jp?B?a2J5YS9EdE5lNnhkRGRVY0htczRrYkt6NXV2REFGWkx2SlNscS90dVlz?=
 =?iso-2022-jp?B?VkpBVUR6cE0zcm1xbzlqNmdOV3FqWnNMNU1QZ2pNMmpyNGlCc2FKY1Fn?=
 =?iso-2022-jp?B?L1l2ektWd0pWczFwODd2TFZqOG1xNUZyQ1JKL0Ntc2hFeVJSK2k3TGFh?=
 =?iso-2022-jp?B?bUp4N3o5MnBDWForTHZ3Y3J6bEZIejZEQlR1TmNpelUwNFBUWlRSQUl3?=
 =?iso-2022-jp?B?S3U2Z0hXQmQ3VkM1VGp5SzVxdDIwVjB1YlhQTWJxYUdmNXJWN3FhVEhp?=
 =?iso-2022-jp?B?SDhLMnFtaFpRNUZWRE15VWJENW1rdDlkc2M5OWpYUGErOGUrZm1qS2Fz?=
 =?iso-2022-jp?B?ZTRjdXdnck1zenpwRlBpTHRiZlFaVk1mT0k5WmdJQzdqRHZaWmpYK0Uz?=
 =?iso-2022-jp?B?LzVlQm8zQ2hiT3VEUHgxTDE5RUJ3WXpDMi92RnV6K1JVaFdvMmRoWmdK?=
 =?iso-2022-jp?B?cTQ4MDlFNGRsSUJLVkE4eDJPREtmN09YOHZVbmhkem9nWUZScmFqNHJG?=
 =?iso-2022-jp?B?MDhmSEU9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Nms0SGJzOG5GWjU0VDlqN29rR1NKaFMxTnVXaU1qQitNWVV0TTExTHFI?=
 =?iso-2022-jp?B?blEzdy9rOVdYYXBzZHd4bUZveWVLaDlvenJ0cGNCL0dscXNjL3RhTjE1?=
 =?iso-2022-jp?B?SVZxclgxNkVRUHJ2QW1XQnpHY2R5WmI1OXlOdXJ5Y0d6RXNIaTlKOW5R?=
 =?iso-2022-jp?B?aDVOYmxXcGVmWWhzU3BtQlp0Q2h4SDZxSFpCaWxvRjB5cW1jQWdjTndk?=
 =?iso-2022-jp?B?ZG85cFo1ZGlTL3czb2xzUmV1QW5CM1ZJSXFkSjhVZUFVUXF5VVpLNkhE?=
 =?iso-2022-jp?B?dGRWejZMaFlWOUJBR3RzZUVMT1gyTGtJS0VUQ295Rms0QW4wVzVTSXJP?=
 =?iso-2022-jp?B?QmFnT0lOZWVlOHJpOUs0TkFNdEY0dXJzWUVxM0Z1ZGlZR1dPbXZrRDRa?=
 =?iso-2022-jp?B?YVV0c1BFSUtPd0poSWhhSlF4aG8raitTczQ0L2FwcHhpcSsyazZ2S0Nz?=
 =?iso-2022-jp?B?SlpybmZLa09ieGduNGhVMjNyU2U5VUJGQ0ppa2hMSzkzWFdWQUl6VWNH?=
 =?iso-2022-jp?B?bURibE9TdWhuckFhSnhucEFjNGUvVGJ6TXNDZDN5ZW1hbzR3QXBnZmpx?=
 =?iso-2022-jp?B?UHpwNzhYZFovbU5TMHBKaTc1NmhEVjJscWhuTkQ1eHZjdWt5aG9BR2o0?=
 =?iso-2022-jp?B?OExvSGNsc1UzVDF3cVRiS3IzT3FzL2NPT3ZhWWd5am94T0t2ZTJZcjJY?=
 =?iso-2022-jp?B?MDVzWENOMHRuanhnY2FTS01TaXJYOC9oVmh0TEtCb2NkbFVGK0t1ZGJP?=
 =?iso-2022-jp?B?a0w2UkhuQzdwNnMvSVlMYUUyL1Y5bEJyNnkyaDNYYWdUL2NpSFMreXB0?=
 =?iso-2022-jp?B?RmNqdkFacThwNTNsWnlRZU1SWnhpcnRQVmcyRWd2dHdRV01RaS96WHVC?=
 =?iso-2022-jp?B?UVMwaHhWUVVMUjgxVHAwY09kMG9sOHFoNE40aXVZbWdlR3lsWkhzWmoz?=
 =?iso-2022-jp?B?V2dIdDFVeDhvcis5bG1hVlZFS3BJK2NySFhkUkxGMnpnc0ZFL09CamlC?=
 =?iso-2022-jp?B?RVdQVjdKZTVmOUM5WmptMEE5TkFueDVoRzdSZ1BqcnpQOERSdStrdndQ?=
 =?iso-2022-jp?B?RFQ5UXc1cDFjbEZEZkZWakpBeDd1dnpnUG9CUU5KemNjS3h0MkxrSGZ4?=
 =?iso-2022-jp?B?dnF0ZUNYTzVibDFuVmZpVHlpcXExVExTVWFtZGo3NEZhdXRzOUpHQ05O?=
 =?iso-2022-jp?B?S3VJekZUaTBiaUlmWDhZSXVIdlZjbHo3VzBLanYyRjVEOFdqekVWQVlu?=
 =?iso-2022-jp?B?cUpsbGllMkhPWjZQN2wwUVkwRTA4S3A1SzFsK2xDdmxiRElRWkdrVzJM?=
 =?iso-2022-jp?B?V212WDNqcS93R1pLR3ppV3ZDZXhzMit1TDRlY0lpYU1aajQwYzBQYVJt?=
 =?iso-2022-jp?B?TS9CblVJb0p5WmpjUnVGdkZSYXlybW1iUDhSTTlGODFiN2NYNHRWcUJ2?=
 =?iso-2022-jp?B?V3QvOEdnUklrQVJmQmcxWTVPUmZkVVFqKzJzWEtJZFJwVUxIK29mVERi?=
 =?iso-2022-jp?B?eHRqNGRhWWZuVkhFM0pLSzdxNm5MajNJcHgrUFF5TFpXNElBTjNxMnJv?=
 =?iso-2022-jp?B?QThWNDBoZG9QMXl1czF4aExsVkc4U3BCbVlTT3IzaUZNQ25ZUS9Yc3dJ?=
 =?iso-2022-jp?B?ZVFjQVhKb0xHYlpjSGU5RitYS3lYMWNjWlJhaUxrZXlmUW80b05KTFk0?=
 =?iso-2022-jp?B?TkVEVS90VjhlWHJ5MSt2NzdCZ0NTRUFzM21oek9RT2M1ZURxNlFielc1?=
 =?iso-2022-jp?B?OVlLZG1jcFF2bWUxcUZpam41aUNSZXhOdEFlRE5yZkpmWjdYOWlUVi8y?=
 =?iso-2022-jp?B?bW4yVVp3aWdFTGhDTmtOdVJvd1VnR0tuQWF4dVdFR2dESDMzbmFQaXVJ?=
 =?iso-2022-jp?B?Q2tYWjE2WTF0ajJ4TUR3dzlJaHRhNFlrSU01MXpOWUxVb2swUHJscndm?=
 =?iso-2022-jp?B?YXZ0UEtTcXAzS05rMDdkbkgvT09xblBiRHQ3Z3EyNnQxSTNVZTZ2UDZB?=
 =?iso-2022-jp?B?OEU1K21rNmkxc0lJUDlXSzhueTNDdDRCSVBENlpUazhFWHFtM0hwakV5?=
 =?iso-2022-jp?B?WTV3WTdiM2FuWnJrOGZqWUlBSE9ET1hFRU1iUmk5eFNmV2tmakJ6cG9x?=
 =?iso-2022-jp?B?MCt3L1ZHQWNmdUNDRVNEWm0vYkZsa1c3aDA3RmhGWnd2SzFnSHI4OGkw?=
 =?iso-2022-jp?B?bHl2VTMxTENESUx1dWxXUW9nUWVOSHdxV2FFVnlXeFROQkZzU2tYOU9r?=
 =?iso-2022-jp?B?eWdEeEVrcExxcklPZWFZeW5FclZ0WDZTWEExMDRmTjFFMmh5bDFLdnhJ?=
 =?iso-2022-jp?B?NDZaVmh0SjFCUmZtSmNtai9Rem5uaEN1RWxKNTVBQ21pdmRUQkZPVWtm?=
 =?iso-2022-jp?B?SSs2ZHdRT1RCeUlMQ29PbkJhK2hKWWROQ0VyQ2JZaHFvbjFZTXB3SW1Y?=
 =?iso-2022-jp?B?L2xYUDZZTkdjbndmMEZjS1crR0E0T0U0MzJnbkFvZWkvSC9XVllEU1Jj?=
 =?iso-2022-jp?B?RytTUStTMVVsdmpmcXdWTXRQN21LeVNKSVRXVE52RkZZV09RR1JhZ1pa?=
 =?iso-2022-jp?B?dlpxaUg1RT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dce260d-ef73-4dd6-e98f-08de5f0de686
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:10:43.9366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1IrjxvOCaBnT20pniSWRWmehlJkeASa2mKwkGOrz7l9B4XXJGX2cWhDSAOjWphkiFnAs37ohUxtsPy4Ijwfixw3mxC/0U1OBbQYL7T4fFdZJrjL4ydr+KsO07A0viz+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12156
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Jan 2026 08:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21785

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Wednesday, January 28, 2026 10:25 PM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d=1B(B
> =1B$B>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwama=
tsu.x90@mail.toshiba>
> Subject: [PATCH 6.1.y-cip 00/11] Add RZ/V2H TSU support
>=20
> Hi,
>=20
> This series adds TSU support for the Renesas RZ/V2H SoC.
>=20
> All patches, except for patch 4/11, were cherry-picked from mainline kern=
el.
>=20
> Patch 4/11 is needed to fix asynchronous aborts during unbind. See the
> MSTOP series [1] for more details.
>=20
> [1]
> https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.beznea.u=
j
> @bp.renesas.com/
>=20
> Best regards,
> Ovidiu


I reviewed this series, looks good to me.
I can applyt this patch if there are no other comments and no issues on CI.
 https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2293415029

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

>=20
> Claudiu Beznea (2):
>   soc: renesas: r9a09g056-sys: Populate max_register
>   soc: renesas: rz-sysc: Populate readable_reg/writeable_reg in regmap
>     config
>=20
> John Madieu (5):
>   soc: renesas: rz-sysc: Add syscon/regmap support
>   dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
>   thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas
>     RZ/G3E SoC
>   thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas
>     RZ/G3E SoC
>   arm64: defconfig: Enable the Renesas RZ/G3E thermal driver
>=20
> Kuninori Morimoto (1):
>   arm64: dts: renesas: r9a09g057: Move interrupt-parent to root node
>=20
> Ovidiu Panait (3):
>   PM: domains: Add RZ/V2H compatible to PM domain detach list
>   clk: renesas: r9a09g057: Add clock and reset entries for TSU
>   arm64: dts: renesas: r9a09g057: Add TSU nodes
>=20
>  .../thermal/renesas,r9a09g047-tsu.yaml        |  87 +++
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  89 ++-
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/base/power/common.c                   |   1 +
>  drivers/clk/renesas/r9a09g057-cpg.c           |   6 +
>  drivers/soc/renesas/Kconfig                   |   1 +
>  drivers/soc/renesas/r9a08g045-sysc.c          |  70 +++
>  drivers/soc/renesas/r9a09g047-sys.c           |  80 +++
>  drivers/soc/renesas/r9a09g056-sys.c           |  69 +++
>  drivers/soc/renesas/r9a09g057-sys.c           | 102 ++++
>  drivers/soc/renesas/rz-sysc.c                 |  32 +-
>  drivers/soc/renesas/rz-sysc.h                 |   6 +
>  drivers/thermal/Kconfig                       |   7 +
>  drivers/thermal/Makefile                      |   1 +
>  drivers/thermal/rzg3e_thermal.c               | 572
> ++++++++++++++++++
>  16 files changed, 1123 insertions(+), 8 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
>  create mode 100644 drivers/thermal/rzg3e_thermal.c
>=20
> --
> 2.51.0


