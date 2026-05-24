Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F389CD5BAB
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 23:45:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6358.1779666312126028489
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 May 2026 16:45:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=UxpDWfD4;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1779666306;x=1780875906;bh=+AYjcCm8bzLzGefWnlDrfCzYQvdMHo3Vh07b4
	yzOpbE=;b=UxpDWfD4qPxgTQnhGFM9GQQ7pM+t3Nz4IL/nU1KpnCTB6aQ675oaiH4GsQEoYh2Lf3R
	vosnWRz7Yw+TY8JR6aW0ZVLH7Uv710QANKF2vNibZz+eWWZErcXYs9+nFRS5mL1udOxaBNaGIuiOm
	2MDdgz+Vac4D1q4NgLfAI16mgqnyD43NOEkNocTZZwGZxKGZAJL05ORatHzona8YhjMgQ7AUrNjJ0
	5NTln6/YMaY2Pr5b9aZuGA/g61yrZeMv6jdRwbUzf+cwtOlr3CvO6si13MXEni6Oufltzr7T1HWCu
	cP2j8Ze1tNyGFLALljsJ+sbcLa9iulgVPWIw5nfnOLsw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 64ONj5Ns582709; Mon, 25 May 2026 08:45:05 +0900
X-Iguazu-Qid: 2yAaLIgT4PT9HMh5cQ
X-Iguazu-QSIG: v=2; s=0; t=1779666305; q=2yAaLIgT4PT9HMh5cQ; m=StuAY5P1TqEm8q826stLA6wzpY82FtWH7t87bGa6o/0=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gNwc03TFxzyPQ; Mon, 25 May 2026 08:45:04 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHwdRT19UZo4qYDy2l5VcmsOYuiKTC/l7hOoZWt/zQAg+ntFkQAooOlXH9n+XAhxgEFUWHzbQWER6mJ6mZHZMPm1ApC6TdAiUuT/BqS8omqkfB3HJIBigkbATi0iGrpDHjPmyZsoj8Nwmvj2hl/dZPtSMOqXnSzk4f2uuufVfjLl8K1aXlgz5yBsrMoKUhU1jtFlT8Z++11LsNbLOgA6YNforkwH7aThe/kzGqrc61j2KxL0LVCjCulKuzMrGTixdAgHS7PPolMC6UbXljwzTLSpu7j9/tN8f76baP3TPTRe4+C5ztEl9kiFSOTIGiYLRJhHHdTAnuudqA8sBn5DgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIL4Gph4vrisNpNacN4tkoS0PMhLHwVOsN6obUaNYSY=;
 b=KbZs2A4wyg0NlYV9MUf+aHo4HtYjYDAQzXylXSepKyvFrLzh5suExLNVas5bbon1RERJdiKNGsQdtgqiqGOgVs1GKc+WYF2HDlv+fdh66gyuh0bmeDyE/+EdrqrbxAZjRGNXOuvRlefiGJLR529kLEHBqfu7xANLqN1z5+z0vvEwiiCVu+kASRNDwmArsphXGNVZpzWo/pZv4E/zzy418RtNn9Axh55dkoj4tfhtsTlW98wLYPLUJbqkcCz1rH412ACuESS6ALjPHBfo05NrjxPryviQrRppz/cdZ8x0fbM93VuElKp0xVwtGti4hVEgQA2bhFE3wL5ASVLmDHg+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <john.madieu.xa@bp.renesas.com>
CC: <bot=kernelci.org@lists.cip-project.org>, <kernelci-results@groups.io>,
        <gus@collabora.com>, <cip-dev@lists.cip-project.org>
Subject: RE: field_get problem in 6.12 -- Re: [cip-dev] [REGRESSION]
 cip/linux-6.12.y-cip: (build) "field_get" redefined [-Werror] in
 sound/usb/mixer_quirks.o (sound...
Thread-Topic: field_get problem in 6.12 -- Re: [cip-dev] [REGRESSION]
 cip/linux-6.12.y-cip: (build) "field_get" redefined [-Werror] in
 sound/usb/mixer_quirks.o (sound...
Thread-Index: AQHc6aBHcbFPKqNG002qAUJxDoUZx7YZvH8AgAAfnYCAAK1FAIADUPbA
Date: Sun, 24 May 2026 23:45:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818EB11492CCF92A570276DCD0D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <177941154371.3955.14567547508285219672@330cfa3079ca>
 <ahAYjl0g7RuivHQJ@duo.ucw.cz>
 <TY6PR01MB17377025B3BE5EB9806D02FE4FF0F2@TY6PR01MB17377.jpnprd01.prod.outlook.com>
 <ahDEbDKLo7YlX2EG@duo.ucw.cz>
In-Reply-To: <ahDEbDKLo7YlX2EG@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB12579:EE_
x-ms-office365-filtering-correlation-id: ea21bcb5-9333-491c-fda8-08deb9ee7923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: 
 dqMhPLRK4y41exZHGGELk8qdUq1BGtdQg8LjQt1jlxd3Cxwc/ab0slWAlGMY4Kf3cmlMu/pLIRSPLwp3A10fixVqNcTkbluYCwmG2AKGfYzNe/WF0/HTeRhIGLQ2V3hSx30g77wb/PVH9EtbcDp7V939j8jDKj+eNYKdayKywlCeUc2XN0PmH6vAUspnLucjlCqV+k+uC0eTQ2Yl/3ZhznL7cfvlB93g2mkjLo+0kpLPo80gVtIMr3CvMlfrhrYkld5aHn3mMQjbwFFyiQOSMC0f+e/vN6wmfosTcZ0GzSlAGiqGWsY5SnLHTvFlrpOMLqIfQ3JgTZ1zitiOJpR1xr739d7pvfrmduW+fixJJLujRBHo3KqjYAbXp+YuwDBGMzHTHhuYrqBk39Z57H0ZD7XM1+BupSSggXeZWBd2+z/Y/l+FU2A+f8Cm4P6wXaMg11A+4MeuWvsL/iz/wYYjZdIf9MKr4e/WkCw5RqYhWRUge07r8lCqDLMjMUKIDJa/C6qe3BXf1L9obbw3bbHgZ5MWfkjdXU0XC8UTrQxCSaS7fjKVGZGBqWVUmi7SdJXPNtjrpS9+6s84dOFXwwOERZTIE7MhZAJIkUlzqwcECZ+4r7ORPN5t+5RXWm91usxDgTPYPNSBUhZFm2x0qwVrtfqNS0Jwph+jw1K+7XQcja2jG+BIzBxjz27AuoECncEnmHr6vIUlyZx82yUkVsQEtENcsM5ibPMvxZ6F+a5Cie7AbNqYJa3Bc3NSjZthrD6D
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L0VQS1BEU1hYMnhnSzE0UkFYYkZOS3hXWFZMNHR4SGw0YU44Nm51VFRC?=
 =?iso-2022-jp?B?WDdoNlB1NFdGendFU2xEU0RRT2wyakhwT0RJc21iM3RrakpaSW9HYmYv?=
 =?iso-2022-jp?B?ekk5MXZ2OE8zSzUxWlM3U2F0aWNwdHR1QklURGFUT3VOU0ZWeEU3MFZ1?=
 =?iso-2022-jp?B?WFhBUTAwQXJLaDlMMVUyOG5iOTFhd255NDBETUQ1Z2RQVXQwV3l2RFY3?=
 =?iso-2022-jp?B?bDVTMEIwVlVsUmJxTXNCWng1L0NnT1NucW9SaXpkK1ZlZ0NHM0dmL2sw?=
 =?iso-2022-jp?B?Tzk2d0tFSml1VlZKbVh0YjVJSEJxSlkyeld6M3czSlNZK3RyZS9CSGFB?=
 =?iso-2022-jp?B?WlJZVjdQWExLdTBzR3F0TFFNNHZhcUwvN3VVZSttenAyTUxSY2cwNHR2?=
 =?iso-2022-jp?B?aTZJaE1sVWFSdFlEKzQ3aDhPdk5xMG1ZQUZSOVFxTlNwR3lqVXpyZ2NP?=
 =?iso-2022-jp?B?WWhobGtsd0g0dGE2Y1NuRlFXS2dNamg0eWxnbWtJYXJpQ2VzY1NSSFND?=
 =?iso-2022-jp?B?eFlUdDRPQjNISkxBUXZxeVV0dEhHNEg4cXVNU2hkcTIwNjB2L1Jrakwv?=
 =?iso-2022-jp?B?bmlNdVpKZlB2UlRKWURzZytOeVh4V3JnNkNjWlQ2aU9WZytHdVg1V0dv?=
 =?iso-2022-jp?B?alRsdkRwTE5vMUpRLzdNa3o2TEt4dk1ETUV6MmVqRU9keXlGaUJBYkFs?=
 =?iso-2022-jp?B?dGVQalp2aFhDZ2VwbU5STG5xZFh4QTdPRHc1T2JiT1BuTnhOOC9UdWRr?=
 =?iso-2022-jp?B?YURWRXZtT3VJSnpXMUxsTEVTaVNGOVlSQ2hBemdqSWJRUXhlaTh2bDNl?=
 =?iso-2022-jp?B?TTd2MTlkYndUMW4wbThtbnJWUlpXekg2cDN4UWRLSWxwVUpUTjBLNlNx?=
 =?iso-2022-jp?B?c3VWb2ZvQndadXFPajZja2VyU2tzallvWmJQbGsrZE90cFhSUWlyUmlF?=
 =?iso-2022-jp?B?U0VvcWJNbFdOaVJLQjlPeXFqTnNoUko2NDBmaU9MZkJkOGh2azlwUmJF?=
 =?iso-2022-jp?B?TFp2VzRUenhPS2dHa0hKYXk2OHJ0S2FrYlhWbEZZWjljSW5tS256blE1?=
 =?iso-2022-jp?B?S0pzQW9mUzhlVHdSQ3ExbmNzSGJQM0IwTGQ5R1p2K1Y4RCtHVkU1clRj?=
 =?iso-2022-jp?B?VnRBMVhGNlpDSTUzd0xJVnBzNkRHQUdZR01zeW5DTHVZejdZZkszK0E1?=
 =?iso-2022-jp?B?L0N4VUF1ak1nTTlxRnZBRW1WbTFaQWpsbG1LUnFHMzUvbHYrN0l2cVFN?=
 =?iso-2022-jp?B?QTFmYjlHTldhNG9kcHNtVE0vOHc5MllDd1FaNlJyZXpjVWswcklTQ2M5?=
 =?iso-2022-jp?B?V1lFUXNEUjVSaHJ5dmpFZUxxa2RSVC9kMlpvd3NDNU4yejgrbkFBNk83?=
 =?iso-2022-jp?B?MkpWQjJrUVJPUm9xcTcyZjFMZDhGS0tROFJqMDU1S2pZSVNpbFIrSWxD?=
 =?iso-2022-jp?B?L3hPWXVuMDR2MWliSStIMHVZS2JjNGFFeHQwN0U5azhlZHNpREdqTktW?=
 =?iso-2022-jp?B?SStFRFAwN2NUQzJtZVVtWmpzSE5ubXpJeEVxNDNRTW1pSGg2RmxkMmtE?=
 =?iso-2022-jp?B?N1FxZHdGTDBXVVZkS1g2OWVMMlNERmwxejA1c2U4aEJmOEI0MVdQR1lU?=
 =?iso-2022-jp?B?WUhtamdvRzh6MHV5blIxN29mbkJjODY5eG5SRE0rNmRiWFJoMERxZ1BX?=
 =?iso-2022-jp?B?QUljNTYvMnp3UldteVF0aDY0UzRheXJFRHpYSUdoVS85dzR2Q0MxUGYz?=
 =?iso-2022-jp?B?NDV4Q2llS01uc21XbWh2WnhiRzYwcWhOanJ6UnFlamF6dUEwNXJvRkxG?=
 =?iso-2022-jp?B?LzVzTjV5cmVxeW55cmtZYTE5a2tyM2xZKzlOREZpbllkTnNTWENYakxU?=
 =?iso-2022-jp?B?REtYWFdBZVY3WDhDejRLck1CMWIwU0ZiaEovbSs4WFNvVW1DZERHalFr?=
 =?iso-2022-jp?B?blNobTY1SHJscVRQNjIzRlV0UGZQZFJxdU1RTzhBYW5XU3pHUXRUWDVV?=
 =?iso-2022-jp?B?bFRJOW9RbGJ6UDBFVmhjOWtzRnhQNGhkNG1RRVMva0ZqZDlpUURublNp?=
 =?iso-2022-jp?B?VzVjM0ZjUlI1NElvcmNaNWtYRGJHTjlScXdwVU5ncHh1TlhDL0Z3MzFl?=
 =?iso-2022-jp?B?dkVrVFFxSUtSQlhZYUppSkxVaHFiMXorRTdHLzliZ2Vma0Y5K1R4d2N3?=
 =?iso-2022-jp?B?cFhTekFlak5FTjRsYjY4UTlwOWQ4ajJ4cGtDSWtlQWZ2ekNneWlpUHpT?=
 =?iso-2022-jp?B?c2dWblJjaFJKejRCRU0zbnVNVEoyZWxUM0pFWStabWduWFlHQ1cyZzZR?=
 =?iso-2022-jp?B?emY4M0R2U0VNNXFGdnA5Q09qSmdsNncwMUkwQmoxeFVTK3dUTkdLSUw5?=
 =?iso-2022-jp?B?RXNyRDNDWGl3bnhUL0o5ZVVDYk82bUQvbFU1TERhdWd4OEs4cUFndS9D?=
 =?iso-2022-jp?B?NCtLRTFPVzZtWDhFa1lDNVpMODNwNStXTFVpSHhyN0tpcHd1ZWZ1Y0Zt?=
 =?iso-2022-jp?B?K0lnWURCcVRMT0RlMHU5eDAzVk5HVElkTExaMGs3MWhabnpRc2x5MStH?=
 =?iso-2022-jp?B?Z1hsUU5Scz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	HFUnqya73Hziv0o1UC8wSOy9Wly58gPsVc/pksrid6cdqYQxANRSNLMJ/P/9s1hCnZZ1tIUf9K8yYUiKzi1Akl8LxzT5lgC/jgsg8gmbR9mfIMAbkH9s+bZyaPEjAcn0/3peFzV0Cczteab1HRgAe5TghWN/hB9oo1D/opX3pxl9NUddU+GIK3gd2EL6MUgCOpFGb/qhduCNapOZWHR/3V1s2gljVUimmfSmL9kK76Eyzhx3CoBWC244ubH0PAlu7f5wHn9t2WKMs50M0bodivWv0QLMXF/V3JRxZ5k9T83UG45+z0GowMqdx20Yad+6x+UE+yF9RaSpv7QnA0gFnA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea21bcb5-9333-491c-fda8-08deb9ee7923
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 23:45:01.8904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcnNvmwQeNqStUtUz7Le0dJpD1w9a+Q873dSwwN/f7EhD8hWi1CzVolwPO/Nge7EZKRfA1PxWVQKOxksKW8DUy9anfLzwotiX/Bs7shWGYaEIkA9tOLs1zeZ7Y7rieeM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12579
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 May 2026 23:45:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23002

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Saturday, May 23, 2026 6:03 AM
> To: john.madieu.xa@bp.renesas.com
> Cc: Pavel Machek <pavel@nabladev.com>; KernelCI bot via lists.cip-project=
.org
> <bot=3Dkernelci.org@lists.cip-project.org>; iwamatsu nobuhiro(=1B$B4d>>=
=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; kernelci-results@groups.io; gus@col=
labora.com; cip-dev@lists.cip-project.org
> Subject: Re: field_get problem in 6.12 -- Re: [cip-dev] [REGRESSION] cip/=
linux-6.12.y-cip: (build) "field_get" redefined
> [-Werror] in sound/usb/mixer_quirks.o (sound...
>=20
> Hi!
>=20
> > > We recently added
> > >
> > > include/linux/bitfield.h:#define field_get(mask, reg) \
> > >
> > > in renesas series (arm64: dts: renesas: r9a09g047e57-smarc: Enable PC=
Ie):
> > >
> > >     bitfield: Add non-constant field_{prep,get}() helpers
> > >
> > >     [ Upstream commit c1c6ab80b25c8db1e2ef5ae3ac8075d2c242ae13 ]
> > >
> > >     Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > >     Reviewed-by: Pavel Machek <pavel@nabladev.com>
> > >     Signed-off-by: Nobuhiro Iwamatsu
> > > <nobuhiro.iwamatsu.x90@mail.toshiba>
> > >
> > > and now it is causing warnings, one was reported by kernelci, and
> > > likely more are coming:
> > >
> > > drivers/clk/at91/pmc.h:#define field_get(_mask, _reg) (((_reg) &
> > > (_mask))
> > > >> (ffs(_mask) - 1))
> > > drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c:#define
> > > field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > > drivers/iio/temperature/mlx90614.c:#define field_get(_mask, _reg)
> > > (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > > drivers/irqchip/irq-renesas-rzv2h.c:#define field_get(_mask, _reg)
> > > (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > > drivers/pinctrl/nuvoton/pinctrl-ma35.c:#define field_get(_mask,
> > > _reg)
> > > (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > > drivers/soc/renesas/rz-sysc.c:#define field_get(_mask, _reg)
> > > (((_reg) &
> > > (_mask)) >> (ffs(_mask) - 1)) sound/usb/mixer_quirks.c:#define
> > > field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > >
> > > Likely similar problem will appear in 6.1.x-cip, shortly.
> >
> > Sorry about that. I'll drop the two field_get-related patches and
> > define it locally like other drivers do.
>=20
> Yes please. I guess something to apply on top of existing patches would b=
e best.

Thank you for handling this issue.
If John sends us the patch, we will release the updated CIP kernel immediat=
ely.

>=20
> Thanks and best regards,
> 								Pavel

Best regards,
  Nobuhiro


