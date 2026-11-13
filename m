Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4354.1794605570930870465
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 13:32:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=YV5cUVfE;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794605567;x=1795815167;bh=570LEya3iXNv6d0bw7a1CkL0e9w90l6li1SDv
	m+hDcc=;b=YV5cUVfEUqvbjOf6LY7LNCGJM3oXBD3iymrRqxWGDQDpb8EytJ5f3WqYEGvsCm6rlC9
	2e2Cc+BVt4Y4H/hDfutyPjyfdRKOFiCHAZCBjtnxMk0/kj5bdRuNPEMh7ClgHPcNhHX2Q8P7AXVpi
	oi1eWtji4vd87mvMt08Xh/9vLynhDu5VLErB2DPfA8ZvplIV0105zpjgwsSfXJIEOI9/s5Z3upApq
	sOvxzALdJqDQOS/bNxoa9sNXz3tMYtnpV4zEepBHfQcZGDZAGeH4CTPw3gWNJ2d2QzRY96hGt0EuL
	YK04LsY7Iy+df+cDz82vtUr8yMKZCQl4ehIEzPw7ZHKA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6ADLWlJZ3086242; Sat, 14 Nov 2026 06:32:47 +0900
X-Iguazu-Qid: 2yAbgtIaJCsjgx7NsO
X-Iguazu-QSIG: v=2; s=1; t=1794605567; q=2yAbgtIaJCsjgx7NsO; m=JnhlUeBfriM5pOsc9iMm/dbzwWT73GvCQbHJdh6IEU8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jR9TV4WLLz1xnZ; Sat, 14 Nov 2026 06:32:46 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcZZ21x3FBioHFBv5ckn5Akm4zuK+8gs1TLjXtK/D/lHWGjUVNL9NdSYHWDZ75DtsKGWfxVHRY/Qp713l9SDEmTgQrOl2OJs8elVijJ6xdOwlC74vj6amw3y229AQZ7ev3GWhmVtK2EfbQg81RjNkUG6Atr12wNcv09xx4rg+oegD2tZZFoHt5FjvqBRHJkoc4m8o9hywNWBnU3igZmHyZTs1vFeM4qZIklQgmljqAOqp2WUvc8T890G2bvgvrg4awRmFhV9YwE2C3XSDcj/1a8F84zC+e6LRqyFM4wknjLV69HolQ+/edkONDgfL1HDbaYCFhkaDrOOKNqc64vjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epLD0CMsgdL8hJNSF5VDUAqnrpBgrLzWnWFLHf/O3+s=;
 b=bpV+95g3d83a8J1Ka6XZnw4EQMwgPnsLZqOmoTGLVHF2hTeLcJ0ZkP90p6dnONTvWGEl2gb7ypDdx38/BRKmtyhlg6oFnmVbcfplDZiMVx1kLwYa9bum9k9XuHMxoYQNLGPbAr0Z7iDI2nq4Je4PmGL5QweeLL4c36qu2FKFvZZNKW9/csTrtVkoSyNDSXZNo5ab7yFo+ISjQcHyjDCdCQBLpzADZ2xTuaYl615vJ4PSiDR5yQwHHlSnHCvyAH7Km6JZGOkbzq1pNwaC6SPBAudGjTNcVuXF9XoPetSa2B164+QnY7jfxZeCE2pt56jAO12AfHV1F21v8AnwV1CpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/24] Add Display support for RZ/T2H and
 RZ/N2H SoCs
Thread-Topic: [PATCH 6.12.y-cip 00/24] Add Display support for RZ/T2H and
 RZ/N2H SoCs
Thread-Index: AQHdcEP1MnrqEchTTESqm36f/PU88LcrslSAgADYBgCAAAE8oA==
Date: Fri, 13 Nov 2026 21:32:44 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB148185341D3FC9F27DD489608CD7F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <avbK92i8jrUrGjan@duo.ucw.cz>
 <TY7PR01MB14818B045362B469FE775E88DCD7F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: <TY7PR01MB14818B045362B469FE775E88DCD7F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB6786:EE_
x-ms-office365-filtering-correlation-id: 57077f02-ee55-40e1-49b5-08df41cda7b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003|261102123227099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info: VlSQ84KiuJnsWIx3jaTIJQf62+JZXE0/c1vL0mR7KkCvPFzrba7kNBmTCgUH/i5idHaQnG1VQXFmFpD0pwhBIt5qtjwythVG4zbBYiPS3A7yTqdGcPtUd1bG7mSK1DZHrEnMgcsUOUzN/wbA8x7QkcICnwdoc+Lp9lWysmuBPWSH1NgYx/hlKV4bhMuJglpe+q29MJgqqnDDWD65WI4WeZAypUg/nZdt7GHggZkwCcznfhDv6XsHIvpcM4TeE7ufy1CN64afKNk1Zkr14GUW/PBCliPhgCcmvfSYhE6WAdBkN1vPhMdefxZ3W2kZQEyGLR5DoMK9r49d0xvk8ymR9FibQK6TVR5Rgbf54L7p0ojOgFFkVO+33+9FmGENxoLX+2C/8vOv83lDRX16QYFxLy/tvheU4x6ENW90zRK+1tmNHUQwrjf+IPAbr6zLr1oaj1ZwFwRBrvOF2jRW2KLw9Ddt7liO4tqYJjcAuDZeERA8WtvcbOhr/dosThxYZQnDFnfLLtPLz+rlzvO9TKesG2FnSh59OcvPuP74T6FNAMFicgE/YWF/fjGAX7foGk4BplO/TTugw1rdaJdGcklZK8NqkYJ2+7ItbC44aAfJD10MrBW21aCLrSPKvk0kf29LhfOua4fG3bswfwBmtR7cw2Dvo7gBkZvfJnMbXjA6wjmO6wj15v1GGjOnHS/BYOWMqHsfd3j52yFBtElh5ve9Ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003)(261102123227099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dFpGQjhIMmNic1V6L1hGSno1MTY1M0pSc25wOUFRTzFlajN1SWtjM1NK?=
 =?iso-2022-jp?B?d1lVUE1XTlVKUjFicVlnOXRTQzdzNzVsamo5QllIOGdaa2dFR2gzc2NR?=
 =?iso-2022-jp?B?K1hYd0xjS0J1TFFha1EzejQ5djQvMnZScWFyamRqemZucXdmUTZyNHdC?=
 =?iso-2022-jp?B?Q1ZFcFZMQjBHQllzRVVzdm0yZHRWQjlMaGhyamRDVkhxVHRRNHN5Zkdr?=
 =?iso-2022-jp?B?ODY4R3MvM2RsWC9HSUF1ZUM5UlpXNk9ZZlJwVkR3dnFCSUlHVE9VeDlB?=
 =?iso-2022-jp?B?cTEzbDh3MUtOMlE5VWpRMkhFK01jRDhCeHptMEMvNU9WYkhMTmtBUXdH?=
 =?iso-2022-jp?B?enFkMDYrTjNlNmZIOUF5WkNmZ2xzVWdpTU9uUU1LQW4wRWUxckZRZTlt?=
 =?iso-2022-jp?B?TXpmVFIxZk8rdGNBWTdHNWs0R0RWcDF2dmJibEUzeDFqSURxSm0wZG13?=
 =?iso-2022-jp?B?dFM0SEVMNkJhRldWNTFrL3UrL1JKWmtUbGl4akhMdUxHZXM5RnlaQVJn?=
 =?iso-2022-jp?B?UzR1dzk4Tk8rcENyVGt1TStxUk84WVcxUENsY3RLSUgzVDhqYXpqbUdO?=
 =?iso-2022-jp?B?V0ExMHR5akQwWWQ3ekRNeXQyVFpPU2xOdkVsd0xuL1dUOTlsL3VzeEoz?=
 =?iso-2022-jp?B?cU5TampqL0p2NGtLblY1KzRYSWRoaURacGJ1d3Zabm9leER3S05jQ1JE?=
 =?iso-2022-jp?B?TTdkZ25IQXlmSWpBblovc0lhblZEN2NHb1JrMmlWeWpKbnBJcTZHeHg3?=
 =?iso-2022-jp?B?NVk4em91RUJFUndSNzZuc3dzRXd3cmYzdW9EWDBzaGduUERGMW9wQ2Rt?=
 =?iso-2022-jp?B?UXhTdXlJdFA0Q0dydTlGZVAwQm5PMXpTN29ycGhoTDFBaU0ydzVJMFh5?=
 =?iso-2022-jp?B?N05RZkRUaEhzQlp5L2FmMGR3VjJuelpZMFFjTWx1b3FWYndHLy81YU41?=
 =?iso-2022-jp?B?Qm5vaGoyZjBnQnlFdTRDcnduZHR0SlFTNUJmWXJwOUQ3cmtvT21peVll?=
 =?iso-2022-jp?B?ek1iaDV5ZVluNTFVMEh5S0xpRkdMTEUzWEpPSmNxNW9EMFBhQXUwVUpn?=
 =?iso-2022-jp?B?MnVLc01hYmFFWnNHbjBHM1FlcmFycXZwREY2YWlqVTh3NDFVSUpwWTJp?=
 =?iso-2022-jp?B?c3Q5empCYVlXbi9KTXNKVXFyVFRLRm5yOFR6L0d1Tld6MnJ0ZEtyRE8r?=
 =?iso-2022-jp?B?RThzemlhSW9BWW5QN3hLMGZKUnBZQ1BJbzFPUWpMT2NFTEE5dFRNNE9O?=
 =?iso-2022-jp?B?L1k4UllacCsxOEVWR3YxZ2hVd0UzZHVhR2NRd3NzTnYxazN6YUZrbUVB?=
 =?iso-2022-jp?B?WHRyeUpITENGeWU0eFlqY1FRN005YldBVHlFWWQ1TFcvd25ZR3ZDN0F1?=
 =?iso-2022-jp?B?WnA5ekZrVXVaZExzTXNxMGkrVHgwZUJ2WHI0dVdXckVTOHBtZFI1Nll3?=
 =?iso-2022-jp?B?QWRYcUs0OUZ0SEJVUi9Xa0N2TUE1LzNod1prWG9zMElkbGYyVnNZZnpV?=
 =?iso-2022-jp?B?cjJycmRNMklzVDNJR0gzV1U3NTdoUTk4UXlBemRycnJjVWZCR2kyVGJU?=
 =?iso-2022-jp?B?aXp4ekg3VHhCUy9XdThjL1pVMkk3S2VoVC9qMzl4bmlkbWhHb3FzQW9h?=
 =?iso-2022-jp?B?cHdHRmIwM0xNcGRXRVNIVWtLMjRlQkFOSGJ4SEJhV3hYWmpsa3Z3UVR0?=
 =?iso-2022-jp?B?RXNDTVBWcFlCaUlvd3hIOTlPNksrY0dMQ1h5c25SejFaam8rR2JOM1RI?=
 =?iso-2022-jp?B?NFJvMEJDcExhbFFWVnVuWHBvaUZFdGdHT3RhaXJpR1NEcHM4cEVWRzU0?=
 =?iso-2022-jp?B?RklOcndpY3BWTVdDdDBmS2tXbithUEdhM1dWSy9BRU4wTTdocys3UWZ1?=
 =?iso-2022-jp?B?NzlEekIwRUtqem9HMk9obEo0Vlc1TUk4UVpSUHI2SHFwVmYvMDRLdkpE?=
 =?iso-2022-jp?B?SnFyOTRKZlRnK1N2cEtKelFnOFBwQkJiRkgwRk85RVgwYjc2VXVhcGp1?=
 =?iso-2022-jp?B?REJCeXBTSnoxa0FDZkJscmVnM0UrampoY05NbEppcGtqQm96U3ZnMEww?=
 =?iso-2022-jp?B?RFlSbkFmVXFVT0IvWmgzR0IwU3cyNlhneUxTcUFVY2RMY1YzcW5jMWho?=
 =?iso-2022-jp?B?L0Y0VG0xTEIvcXIrVEdYK2tsMWtjTlA5YWVrTUdLdFlqTU93MTQ3am50?=
 =?iso-2022-jp?B?ZnFKV0VKZjlMaWZvUUdvcG95eTQ0aGtDVW80SngxSW9Pb1Bpam43SHhI?=
 =?iso-2022-jp?B?b0ptemN3STQ5UVdsakpydjNPbzJ5NU9zYlhSZlc4WnRMWjd6U1B6UVM3?=
 =?iso-2022-jp?B?cFlrcklIWnJnNXkwMEhrRy8vcFhIRmpUaDR6YzVUVFdIcGdYc20rT3Zx?=
 =?iso-2022-jp?B?Wm4wVXZyYWFhWFloWEY2NTVKWDF6SFRLQVZtbjAwVXNROVBhQTZHRVBM?=
 =?iso-2022-jp?B?anRVYjk5blc4SGhnOEtKSGIzZjhUY0hFNUEzRmZhWmp2VjlkRjM5cjVM?=
 =?iso-2022-jp?B?U2sxRFArM1lTWXFtelhsUnIza0grdzhiTnNNVE1xM1dWSFNGV1c0WVNo?=
 =?iso-2022-jp?B?a2VFaWhGOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vaentMOcTIsDWvpNNvrxCbwPMAYGFm5VqVW9jR/r6/VD8/UOm5yTcDyDs1m4fnFBmnDuP9kqocJR7BaFQZOI3d1GUyL+foMNY1+lPXkw3mm/7wkumJ+syXo2WDEEyWEmhTTt3jsrluq1/aPceXJHTAugvJ49+KzQy0Ng/dLyOFHpnZLnfvypwOLSB5AmAEeQX4VkgKhXsf1qljT6xU5gRtb7wYad0Q86KiLKKWJKh4a7RAoscjR8/iUCL6Y9ki3O63YNXsO1m75mG0O4d2NadAcgPx3+L1FjIon9Mw52OiJVeoZZN4+uw0g623QmPQ5sIlpGboRR6yiQwr3akILyMg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57077f02-ee55-40e1-49b5-08df41cda7b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 21:32:44.7169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dPkVLcX8XEgazagWeR3F+lqGqlf4/0SDTa4tTQWzfxX+CgCYfcZ+h+cscHtJ6MbC6AxS9ofv3LOA4faE7MLSN+9vaFU04vF+lI7KAfHcTdVFJOxSrRPW+5y4AafWagF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6786
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 21:33:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24804

Hi all, again,


> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> Sent: Saturday, November 14, 2026 6:27 AM
> To: 'Pavel Machek' <pavel@nabladev.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 6.12.y-cip 00/24] Add Display support for RZ/T2H and
> RZ/N2H SoCs

[...]

> >
> > Hi!
> >
> > > This series backports upstream display support for the Renesas
> > > RZ/T2H and RZ/N2H SoCs to 6.12.y-cip. It adds support for the
> > > VSPD/FCPVD/DU display pipeline and board overlays for HDMI output
> > > through an external
> > > ADV7513 transmitter on the corresponding evaluation kits.
> >
> > I had some minor comments here, but those should be fixed in mainline,
> > first, so they should not block the merge.
> >
> > Reviewed-by: Pavel Machek <pavel@nabladev.com>
> >
> > I can apply the series if it passes testing and there are no other comm=
ents.
> >
>=20
> I reviewed this series, it seems to no issues.
> I applied this series with Pavel's reviewed-by tag.

I will wait for a version of the series to be posted from which the followi=
ng patch has been dropped.
[PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for clk_divider_best=
div() ULONG_MAX handling

Best regards,
  Nobuhiro

