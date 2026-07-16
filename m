Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733A5C4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 07:15:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7317.1784186115469340561
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 00:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=PiBC1K+C;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1784186111;x=1785395711;bh=cuSedB55SQAwhywy+G9tRy5OxssO5TFzyxiLD
	Xx8DBY=;b=PiBC1K+CebNCxSkYMFQFTb2oTuN3+lsz3RclKIasnZPHdAZradQXoE8oZaOxHed/NBQ
	bsKe/yasrP0yVyDcIQZL1q6Y+unceTKM7SxjUKHUASXtfd/y6b3IhIAqM8OCBOVzX5JqTJDCbrSCW
	xI5v/JZ8rsi/MMYNjY88sSv3sQqwSnrnnOJhX+h//6RLU6DCf4MG7MnFQnEzDjj73rPsiTe6mVVE4
	gPe0JBmIcXYUy/liGufSZ7X2Z8g4TZ/b/VsaW79lu/3qqc0OVImwQ0oCUqfDXrevWQikBax3lhKsv
	KVDNcOnfet3SkPBfiqapEEU3EuPnxc2JGrDABUSVC+Nw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 66G7FB91468273; Thu, 16 Jul 2026 16:15:11 +0900
X-Iguazu-Qid: 2yAb9zXy0K5r8p6wQG
X-Iguazu-QSIG: v=2; s=1; t=1784186110; q=2yAb9zXy0K5r8p6wQG; m=BplSgPUyP6YN8GrJiwknfH0rt55mTPVFVKfBMe7hao8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h147L1nsMzyPQ; Thu, 16 Jul 2026 16:15:10 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlkADtZb5kA3DpQk0sL+YIQ6GRNJTo4InWQRfw+3s1MWh91fAoTloPns+eC19adOR2NLRHnnmPevK1AB4f7OPV7Qlq3s7zhYza6/aZ50quLBmx3vKlX8/NzVR35U15azqoYZuvWR5bvLZkKpTAw/VSE9b+kWe8IfsFwUCzc+RjdthJIh/aLQefrOHyRCgLljzvzoYwc+dJa0MDGtquXECyM9jkFEd6FEKG7LtcLh5q1yKSzllyyaWcSClOwAUvOE7/PqMNkC3qYzLyw2rSPqnpxe/PqecIjY0fH74xad4ig0m3VZTvYwHtQDOWpcsGP/TcKmE+pRlw6JQw9my+ehuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SCOzWfmz5sMo3B1e+Lwm6HqD43ymdWd4XPRoglGWhI=;
 b=wXj4rLZJqtS3o7TGw7839XNpX8IpixfIp3zk/+dSRAS+2ZYgsTGAoWD21wHGl4TnnZ0JIPMRMqIdvQxiyGnRyUCjfEQZyflqTd7xbUG2LUm8FnVuMyHj4KzSj5JnZAzZG1hqLJ2SSbaxWU5u1JR+EaUcn3QG4KSJD5JiCi2SHK/fFA1ti33mhxb8tYLHg7T0eehZYeaKpm8HX448J3XlU0ugqUCOGquxmdFC26bfyF9opgj8FifWvBH/uwlp4xW06YUbFY15SUEdLoWInM5o7oNBzeww+ljO+B7YisNDUeNTTS64DGucapjHGq9X+0sB6JE1rG7VP4Qh+SC2rU0VSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <tommaso.merciai.xr@bp.renesas.com>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <tomm.merciai@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/32] Add RSPI support for RZ/G3E SoC
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/32] Add RSPI support for RZ/G3E
 SoC
Thread-Index: AQHc/jOY6ZHY1I5CYEO/MixFm91emLZS/WAAgBIPUgCAB8AVgIAAWpWQ
Date: Thu, 16 Jul 2026 07:15:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481843497DCAD7363BEFA66CCDC72@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
 <akBCKNYSELOi93EL@duo.ucw.cz> <ak9oegpiSZVBH6L5@tom-desktop>
 <alXo2aQkK6ajqmaI@tom-desktop>
In-Reply-To: <alXo2aQkK6ajqmaI@tom-desktop>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB13050:EE_
x-ms-office365-filtering-correlation-id: bb61703b-fb06-4c03-13c5-08dee309f687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|38070700021|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 bO8ufGN+c+nnq+Gcx/BPGARjVe6epUoHzvx9Ss9gKlEajKhM1z/uQu5NrTRCwZkuJNBL68JCev0O7HV3x/IrTQ8/MrO8TvR6iIHCaNCSFPmbfgb/VcjUGrpfZeW3EkMBBIqhFJJq65D079doTEw6vC7Gry/lUwzJ7l+wH16LBPtkwQ3UK7k6hONeMzCFm+zhVG2RZLTSPtaAhQBTMtv+N8D4Rb0sCbrHt7bEr8/TrRC9Zx8eSoGC8UDF3FDycen1+uo6ljsCQvE8q5/vOHQUY6nBxnJGm/PSIzb0P1DxsztUATD6CyKUP7qDy9j1FJ5XrwzH9WfyGFqaRL+ZlFtgYcDw6kipUkKw7faKp5NdqBGqpPAe33xLNY58kPsCxDrgl5oFgVcEYW0M0BjrhbrmIULjBMSjtXYQYypK3VWrDSKXjguQ7iTfQ3WyRWlrBZYImgTG7EXR+5JK779D0bongRz5uMXskkiZTvmcUhrVP/NbpYwNQqNlaQbDKsataIFT2xFvpSt7+ceWVMQ3JUsiMX91cunxQiiXONel70RoYteZfeuxcoxFeiN7+RktdUo5WZqax/PdUC+2IQbHaZ/Aq1ws6xZCQqgXtxNed4HYwrDo7Auv4MyZdfnSXqnF3VwW2UqDeN3ZSZbT8ptaPAbq2L66Cg9qi/DAgmMiL7ztxZ/MgqKAqVByYk6CrBVueqkYGU+Q76IqXgg5bAiEC0GxVBnACpECikHMM5RSb7X33vg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(38070700021)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UTB1QlFyVlNMZ0FYZjlLMnNlVEtiVmg0cld6eUhudnRuK1JJOXlSYzJs?=
 =?iso-2022-jp?B?bGJLV3QvSjYwSjZnM2ZTN3UzMnNCdjhKaHJNRnNJbXV3Wnl6WlZwZ3Vj?=
 =?iso-2022-jp?B?MURPeDA3MWRrRm5TSUpQcXJCdGhxMnZoM2NWUldHRWpvL2hGdDdGcXpa?=
 =?iso-2022-jp?B?R21pK2tobm9STm1wbDZqaldsZGlIOXp1ZERyZi9vd1NhWVFlaUZsTjJp?=
 =?iso-2022-jp?B?VVRKazhWSnZOZ2c5bU1SNG1wYVYvTmlwNW12enkyYjluTmRtbFowMnNG?=
 =?iso-2022-jp?B?elBXMDIzd0hkaEpEV2xVUVNLU0lyYlEzMUViWEVYNzRkNml3NmtmU0tr?=
 =?iso-2022-jp?B?VExrbnlMc3QvZS9NOWpaY2hWd1dvcExnS2dudERqQ0s1dXVLVkp2NS90?=
 =?iso-2022-jp?B?WndpOVpRYmx4Qm9aVUx5Z3hlWm1rdFVYWWxwKzhvM0FwdlppOTFVSWJo?=
 =?iso-2022-jp?B?d0QyZVZsbjFjdFFlMjBLWXRZUm82dkhESHU1aktYMVlNN0tMeCt0ZDNq?=
 =?iso-2022-jp?B?emtRbjhtbVFqUEVRbENsalNncFNXbGF1TVpCQmtjNjYxSlRNRTUrWGQv?=
 =?iso-2022-jp?B?WktYK3hSMVRUT0ZodEVKeC85UFhrWTVTdFFQOUk0ZzRZd01GN1ZhTHli?=
 =?iso-2022-jp?B?MytWY2JncmIzaUFRTDNuU2VYOEFvcXRkZHpnREFlTG9tYnJQdHlIc1Ax?=
 =?iso-2022-jp?B?OStnbXpuMGFuSlJFMUVnVGhSY2dFNE5oeHQrK1dNUnV5NFJJY2RJc2tp?=
 =?iso-2022-jp?B?bHJRL2I5S0M3Z3Z6d1BJY1hJU1RMRHh1OWNORFU5STErbytscVR3Ykgx?=
 =?iso-2022-jp?B?Tnk3UDR3bWh4NXRmU3RCOUJXYm9HbVBFck14aFBZOE5qaVRxcFI1Q3A3?=
 =?iso-2022-jp?B?NEcvb3BuaHhIcS91UTdmc01kSHlMdmdSYkJKaGk3VkdFR1BQUXAxSWZW?=
 =?iso-2022-jp?B?VXlTWHZpazNmRWFOOWlyemhMd2lGVHR4U3pySlZIZUlPN2JkRzk4Sk94?=
 =?iso-2022-jp?B?WU9iUFJtZENnY3lsN053RDdidWlubXN4VHptUlk2TzJHeGRLUVVMVEV3?=
 =?iso-2022-jp?B?Tk5QOUJab0ZJUlNTMWE2NzlDdXdsVnRLM1VFTFA2UXpESUp5ZjVNQ2JE?=
 =?iso-2022-jp?B?ODQyamg3K1FObThqNmxqS2RIQVF1dUFpR2NMWmhDcGtXUUtnUUdPNVg3?=
 =?iso-2022-jp?B?TlRlYlM2cUk3ck9YVFo4OVR3WUdWeW4vaGhOeXNTNytaeTI3Wm15Lzly?=
 =?iso-2022-jp?B?U3U2TDJxdnlRN1VMNUh5Q0lBL1NhRUJHenpOdGpQQzR4aG9JTjNMa25j?=
 =?iso-2022-jp?B?WmlseFVSa3JobmFmcEJHeHpMUEI5S1Q3eDVpL3VkU09UMWhKT1BwMVFm?=
 =?iso-2022-jp?B?aDgwZTBOZHhhdXdrREJqRHpPREZseVE0SzhESWtDQ3ZqM1dicHVvMnd5?=
 =?iso-2022-jp?B?djVSTHFRNHE5UW9YY1Z5bmpYZWdkamcvSVNSUGJqczhOMkhoTjR6SDN5?=
 =?iso-2022-jp?B?eUN6MERHSXRnbU5kQ2UyamFxaVE4QkZ5YUtxUnRDdExyYWRxZDdMNjY5?=
 =?iso-2022-jp?B?U3FRN2ZtK0RLZ3h2cm1Nam95b2REZnMwTVFIMTVjdVhmbEdZeGdwbW54?=
 =?iso-2022-jp?B?TkdXRFdkTU1uQms3a2lGSy95S3dUL0RaazNweDIvd3lDakxpZ1NHOGRR?=
 =?iso-2022-jp?B?ajE0d3pqajRpZ3VUOHJpd3NCTWgwcnNsQ2c1WU9MVUlWbW44L2JqMXpD?=
 =?iso-2022-jp?B?bE00Z3VMRndFb1V1TkxKZkdidFVmbFprYkNpQ09SY0ZaOFlZMERHNjgz?=
 =?iso-2022-jp?B?NWJSa1c4SkkzZnJxcW1zTWhrYWJrcFQ3dU5Rc0tlTGluYi8wS0lMbjdl?=
 =?iso-2022-jp?B?TzRLMHVFVE9YWkI5OU11d2ZzWHpiNU5MTVRxU2FKaFBCaHF6MDBxNnh5?=
 =?iso-2022-jp?B?VXZac21rR1JMN3pPS0djQktXeW1Ka1pvWVdGSElDMDZZUnZjMDhuY1hI?=
 =?iso-2022-jp?B?aXp4RVE1cEJsZFo1SndqUlorTXU2Mmtod0V5NVZ4OXRvQzliUWlob2tr?=
 =?iso-2022-jp?B?Q21nLzZidDlZYUZhMCtybTcxUHNJQ0dxSlk2dTAreVhhbHZkQ3JSalhW?=
 =?iso-2022-jp?B?Y3NGT0tnaldhQ1Y5RHpxUWRIR0lVMlpWSTZIV3hYVkRPdC9pRjFoY3Rj?=
 =?iso-2022-jp?B?VjRWa3FScG5uSWdBZi9LTkpsRks5eEYreVF2WXFxRWQwTkJmRmN1YldF?=
 =?iso-2022-jp?B?WDFmZlVNUGpZVlZ5dnhUZllUVXp3YktZVjY3Y3UzeEUrcURjQ2pOYUJt?=
 =?iso-2022-jp?B?YlBvWnhxMDBDM1EyQTExVzRweTY5UzdUeE1raFdrMHdnWTFpakJlam53?=
 =?iso-2022-jp?B?bUorMXE5S2ZhbiszdkZkeEJtN2phMGZEUVQyWnJRdWduN2hTelFGeGFU?=
 =?iso-2022-jp?B?aldjUjRSNmxpZkN1YVNZMVdDd1VkZnlIRXFzZnpqMUZaMEx0NlBWUFk1?=
 =?iso-2022-jp?B?S2JvTThNdnArb1pTOXkyRXNlLzNIOWticXRScDN0dmNIYVNxZnRJZzl6?=
 =?iso-2022-jp?B?SlJ1QU5Nbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	olRgDHmEj+fvDUEeFXASuWXtH/JhH/SrQnx/P70QNjXrM/uFyAa3zkq+PFBamzXMP4PkJfOqq0GRqlRWPBiMehma47uTFDdupnZPtPow9fgkostSXDgDEBenGLIqekQXkJlsq3/tzwBTeI6RHrjOnT0871xL09xmtVQXGbjJlpHj5MrJORhKGMwhfwhJbV/oeNSccKiep7De3DiGAW2oaVCJ0jnzrW+7Z+9SRuuvvqyj0bySUpchTI09MWvpLdgjnJidnhao+owTF7CaVFYo4Eoy7nMSEhAb50iPWBsk4u+uZWynk2wM2sz8ObVMc1P7o5wUPUzCwBW1Cc+iJZiGxg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb61703b-fb06-4c03-13c5-08dee309f687
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 07:15:06.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNApWYGE5p4pWvpJ3HWr31CcP3hy7eQj38ctojKVGQ1oNV0rgy1FwWwS8DkXHR/gsBqLHIkJihLTWRhEUIlXnbwEdVY1GY5ejnr0SmDk54XRvm8grKmDC0Ii39lRXPse
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13050
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 07:15:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23607

Hi Tommaso,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Tommaso Merciai via lists.cip-project.org
> Sent: Tuesday, July 14, 2026 4:44 PM
> To: Pavel Machek <pavel@nabladev.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/32] Add RSPI support for RZ/G3=
E
> SoC
>=20
> Hi Pavel,
>=20
> On Thu, Jul 09, 2026 at 11:23:06AM +0200, Tommaso Merciai wrote:
> > Hi Pavel,
> > Thanks for your work.
> >
> > On Sat, Jun 27, 2026 at 11:35:36PM +0200, Pavel Machek wrote:
> > > Hi!
> > >
> > > > This patch series adds RSPI support for the Renesas RZ/G3E SoC,
> > > > which features three RSPI controllers. The series also enables DMA
> > > > support in the RSPI driver, and backports the necessary
> > > > infrastructure changes into linux-6.1.y-cip.
> > >
> > > Thank you, applied.
> >
> > Just to double check with you.
> > I'm not seeing this patch applied on [1].
>=20
> *this series applied.
>=20
> Shall I rebase and resend?
> Please let me know. Thanks.

I also reviewed this series, so looks good to me too.
I applied, thanks.

Best regards,
  Nobuhiro



