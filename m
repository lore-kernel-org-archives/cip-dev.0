Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC02FDEE53
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 23:11:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9980.1776985885847951715
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2026 16:11:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=eAtFblJb;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776985874;x=1778195474;bh=xORFiHeGxcvtNK174tUlI30+5XNbuslm2bREc
	6P2vTA=;b=eAtFblJblTVC/ryfzj53wq9gGIcUSgpPdqvpfP6tAhsHsM4k5sFEaCaxgaIMRZf5i7f
	iOjpunvQdPOD/MGKv1mbFOODNOyUMlKES4R62QMc63N/i4MofBtKLmx4O3KIciXEk+WRNtq2h+TYH
	ZWLgj4A8/TlrHV5IT6+dYYSLkimcEYYMT1QZHLqsmpdHfPGWtlMb5Uj05rNDCSEyO7J/tuzxyMI4Y
	nqXsocZe2Ogw32epWcQ43hQDx+mgTAnDWhRdQCBuVx7FvauWy+aEQLpTG3m/w5JwWlDqI+/AUEI4K
	WX+Z42wR0VVgxQypPkIyHp0tsy4oH8P6Q2nuDvsT/nUA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 63NNBDTo1978726; Fri, 24 Apr 2026 08:11:14 +0900
X-Iguazu-Qid: 2rWhBcKdniIEBOLy0T
X-Iguazu-QSIG: v=2; s=0; t=1776985873; q=2rWhBcKdniIEBOLy0T; m=0OUtx0FzgSyP7ToHeAjB2GhhoDMWx4S3IgtjXBYVBFk=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4g1sKF0wm1z4vym; Fri, 24 Apr 2026 08:11:12 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQNxaye2OM31Wlc6Od27oxOW9z3GpGXhdmGcpwvZ2s9Y3jlmWftrEvEPagn4yilXe4BQeui+tN0cdgUWKc3uw3kC9BrPp47dfQZL8yGl43FwUnCKPBiGKywNzIwrzmicmVdZJhbn1fBJPYMl9HYGJ8H1ED4axl2Is8jvGSfIRPFVZc7m3Uhz9N1xTA/m0WBykJ8VfXJqeVXSY5WlGzrPYLNjDqEFUvJra91NBy2CRCHWlYObVO1mQcyHdN7oBL2iTVR5uRRTW8w5WhWD/tIbyO/boJ3fbOX0QmbkRKq7dSgZ3vs/GeAFlnQ0a6AvSCHisjrwQttSoKcZXKSNrupWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GZVC9IxndLZf7KzjQVFB+BLqO0Z1t3bbDaWyzLf1No=;
 b=mIB/M7dmSgwgL/YPvY0vUyUaOejLeL9mVSBxPFEuKRU0QlyC9kbtzMY4kYdXDp4mYZ3mZLU+E9tIDq4iFJPL/HtDywzBID95D8LS9PPnGZYfYUDn6c+JdxYdqZV2w6Gqcy7eQiJJm7Ad2zugQWgnr3V3BsU5F9Tq9UDyRffvUDTYJBmKp7ooL/AZvmWPIruA1ZvSljUmCDkpGp0fnD9vRYcQN7p50lD60zK21RBRksLu1g+uwv5aMrAxEUxE9uvnpF8buKGFDe6c3k7SijKRmXf+qu/RZej24S/mfjFEm+rHl+md2CAceFp1OdWJjbJ1mC1Dmt1t6TrG2EaVefgoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
Subject: RE: [cip-dev] Request for review for 4.4-st75, 4.4-cip110
Thread-Topic: [cip-dev] Request for review for 4.4-st75, 4.4-cip110
Thread-Index: AQHc0js6zeLtiNBgBk6Ixd7iAtoaQrXtR81A
Date: Thu, 23 Apr 2026 23:11:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818853A3654BD45BF6BB2A2CD2A2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <310741778.1030622.1776850439887@webmail.strato.de>
In-Reply-To: <310741778.1030622.1776850439887@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB13872:EE_
x-ms-office365-filtering-correlation-id: 1704a29a-6687-42d1-0e56-08dea18d9b5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 ifrkAqsc7B5sgdZ40f94vL4qAXuVFng2UiysZrXUOVLHcjwDMe9JyNWYO3eMkD5N+vjwKzrXKaxpUopgLR0tr3lpj3AhYRX1Vd6c2UBdPKA3QWSn7BBLX2LJXilSVlr+/GLnyODYHjmyA8k1OFwAeKFYzIyPYIqpuRR5w2Cv5GOc9fVA46qv/45icHrlPYLvuDwyzvP1v8Au9YgqhUp21cOmzLMmKWS397NlztblwT21nPAHZxfVFWLNR1UXGpTmMDmKI9eC2XcprB+TBUcKKApx9s/+5RlA8gq1iD6VQyqIX0XllmZg8szm9TDL/04rSjAp+RoUlw7/6Hmm3Y67Xh8/zaFtKChajKcmHii3ZJ8GJJlY1A3e1cVBo8D1Vk/RqanxB+eLJVtXkYf/hzwZ619gEMj8Zo/9IJvvgBgETu9zyDAGVXD4YzFQjpBXVq2IUbkxOejIx8+5IBdmJTLETfx5CTrcPt6WezXlHSwxaUBCbvtPBewbx8EHxoqYchm8fBFjEB4jofssxvCIFIAlWkOz0mxV4dvAJikmr9MuOSuYkHvdPen5M2vPlAQycsetEAddgp9t2uiAMdh3M6OhkZtS5vAyCzHkvJ4YdD6Dk2VWypE4e96V1GyP7D1OwcGTbEXqxOSXHse/5a9NEQKsvmvh58bD1aXv99kSc8XbsJYf3eRJin6z4gRb9Y6UBB+cvY/DlvgAjXz1O1rzZaNg8tBAPGKROF10IPp+GMbxHC46xYrEw1M1PiIuysyur3IjBMIvwu6wOUQ8HmoecXO8V30v9e0gix2xvKWUFBUkWto=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WGo0L2RETjJpcm1yeVoyOWZoNmZVR3dWREV4QVZjMWZJZmtkNkpoUEpi?=
 =?iso-2022-jp?B?bUJXSFNua2d5dUtLd0U4VEFWNklPUkRFNnJ6L3ZnWEhxaXgzdGtrbUE2?=
 =?iso-2022-jp?B?Q3ZHQ24vd00zVlFneXRmQU44bjZ3WUc2ZWdYM0RHaGcrOVQzWkRTWmRG?=
 =?iso-2022-jp?B?NDlwZnR1ZjQzQUgzeFl4STV5Q2JsbjArRXNnbXpKWVNyUHVWMWw1U3ln?=
 =?iso-2022-jp?B?Vlc5ODVFQjJZZ1RwckxqamQ3TXdYUldJTEJ0N1ZTSDhiSDlRb3B3WkZD?=
 =?iso-2022-jp?B?Z09tdUE2VERRdVlRR1ZQWnZtMmlsVUNvQS9Vb0xMY0Fwc3pFZ0tjNGND?=
 =?iso-2022-jp?B?WlZVK240d2NWTytzaDFjTENMTWxqTmZKdVRubmZheURhOElTQmYrSVNN?=
 =?iso-2022-jp?B?bjI0T1hEamNMam9aYVZFWXkzMzl1bDhnZlVmMXF4bmI5SHlhRzI3NThN?=
 =?iso-2022-jp?B?UmVzaWhxN3dvOVBKL1NyUGZVZDRXelVGYVFEc3lQdnQ1V3QxSHplN1pI?=
 =?iso-2022-jp?B?YkV1ZklDWGdJZHNwRWVwSmpkcEs3QmcrUEY5Nlh1V25vQWZUNE5lTTVu?=
 =?iso-2022-jp?B?bzRaZVZjbWptQ1RhMEhvMy9QeWJVRUNVY25pVUR2ckhCUGNVbDhsK3Vp?=
 =?iso-2022-jp?B?TmFnTmhRQTYwR0Vnemk4dDEwRXdicXZ0T1p0SGVETnJPc3JLSDlkOW1U?=
 =?iso-2022-jp?B?UW5Qa3hGeEdXL2xLdnNyeEJISW13U1U1ZEtXOUxsSXM1bHNLWlFEUzhE?=
 =?iso-2022-jp?B?NUlUQVJhN0JIbkRnMXhoaFJkY3ZobHNKa3puZ3p6Umo0a2txMnQ0YnBR?=
 =?iso-2022-jp?B?QUJMUjJGeWlFS2krTDBDUTJ3M01vVVpoeTVlRDJLWWthWGRWSC9PdVd1?=
 =?iso-2022-jp?B?SHFFVTF1VzdPNE5yNVdCaGRiTWpVa3JhbWNGUnlodEVQWXVnOGVic2dv?=
 =?iso-2022-jp?B?SUFRVUZISkVJRjh5VnhoZjkwWXRjbitUaU55YStiUGtyN3YyRit4SG1B?=
 =?iso-2022-jp?B?cktwVGNPU3VoRkMrUEVCdC9adFZkZXBNUWV5QU9abXBHM2NTZGtwRExx?=
 =?iso-2022-jp?B?d2p1dWhxQm03N3oyUTJxYkI1OGlJekJUdThScVYrSDlQcDFEM1prNTBU?=
 =?iso-2022-jp?B?cTdub1BySzlDbTNlTEt0Tm5MbW5JQ25la2VlTU5sRnF4QTBkdFREY01M?=
 =?iso-2022-jp?B?SVRsYjRIVlJnYXE0RlIvYXB1cTd4SEFRV1V4eHhOcm1ZL1ZRcWdEam5I?=
 =?iso-2022-jp?B?bFhZem5zTGlHcjhMRXZQcXFhVXV6VG1rQzZLd2tlN3V4c050MHdxb1VZ?=
 =?iso-2022-jp?B?NUhSSVA5cHVqZW0wV2ZyenZSdHBOUFI4UE9md0MxMEh4MHg2cFA5R0tZ?=
 =?iso-2022-jp?B?MnBSSGdUUlJtR2poUFFKTzFPeVNBVHN4RG5kYmh3M0YzUStnR00yREhN?=
 =?iso-2022-jp?B?cXQwSjZMUlVSdFlzR2lPcW42Zk13TEJtQVIycHJlQ1FzNE5DQjZtT3FM?=
 =?iso-2022-jp?B?aFRneGp1T1VEYy9Rd3lzN3RCZ0VqSUhJaXd5RXJnQlk5YURHVS96NDVT?=
 =?iso-2022-jp?B?OVMzYnl3VXVvc2NqN2F6d0NYWURoNEh3TVU1SXNmTE1hVCtFdHNHYjBv?=
 =?iso-2022-jp?B?czNvQkpKWlZUZTJIUnJRUFJDYTNadDR0UytiTkFseGZiQy93T05sMmM5?=
 =?iso-2022-jp?B?Njh2eWFvTVVEL2NmOGd2V2p2cGcwcGEwaU5nYWtSL1lMeDdaaGk0OU1n?=
 =?iso-2022-jp?B?OWVxMlR0NGlJREVyZnVWVWVBaWNueUFnSWNWUEdDbXRGMW85RFNhV01w?=
 =?iso-2022-jp?B?WkVZVjhsOHdYZ1hZVE0vWDNpM1lUTVZTeXkrZ3hzNUN1QkJ4bG4yczdP?=
 =?iso-2022-jp?B?MmREWitIMVpMRExsTE96Q012Q2N5NDZUemtBdVFHZFZCV3M3MGdtTEhR?=
 =?iso-2022-jp?B?STN0UFRaNnZ5bUlsSk9LbVl2WE9UakZ3Zk11Mi90YVd0UEh1RFlIclJL?=
 =?iso-2022-jp?B?b2ROT2E4SzZaaHJaWVhrZjlFcytaR1hHQWgrcnc4SW4rT2NINnJyTHp2?=
 =?iso-2022-jp?B?ckthcU9hMHNTRzlVUGhrL1o4YlM3dndsMVhOQmVWcmpneGZmQTVST2FC?=
 =?iso-2022-jp?B?c1ovcjJmVzIxN2xTV2QzMHNzMXBka25uaVpjVjMzZElmRmRQTGQ2TGlk?=
 =?iso-2022-jp?B?YzhFWEx4cTJMV3p3NnpEOTBJU3o3RDR5dnNNMDVjUFNyMVRQOEs5dTBV?=
 =?iso-2022-jp?B?bXk0WHVTN0hkTW9IekpNQUhSS3lTQnVIbHBLZk9ERy9zSXFNaXJhN3hF?=
 =?iso-2022-jp?B?Rzk5WVY5ci8xNjJoYnJyaStMWXEzTmZoTWlHa3JzTGlydWpHK2swQ1Jk?=
 =?iso-2022-jp?B?VlNsNDBpQzYzZ29lbGlSd0krcGpqNkgyU29OdzY5NHlCNHUrUHVXZzJ0?=
 =?iso-2022-jp?B?YThQNFFDOWxrdUR5RlhtTTNSeHdMMGtpaU5jemZicDcxT1RQb3dJWWhX?=
 =?iso-2022-jp?B?dDVKMG0xYUVzYUZlMVRiOTljbTdHWDdmT2hCTyt6b0RNQVNuS3l0alpl?=
 =?iso-2022-jp?B?OFk5UUVpcz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	pUT+ukRNkmT6B6ckH1/KPr07hzM5X0sdhSK/eljlpqQqQoo2RNXN/X/GLitoun2r260yaADBsJJwHh09GR08wtMpQs+MnLfjvHdgTuu7KN1fQOUmPq1t6/UfuKa5a00vIYzUusaNGLWFUU5r1jc0JKMRTvfKfoxk/plqv2SInypFfzYHtSkWW1LFPaMBegTNRl+I1bXTA2TTFktGm6omBh/v3PDVM5UodSyOITrtMIFiR289okskQICOLrndPLwoVmZJamtMYvDuGV21WP3E18yTYKOaroV59kHQ0z2qIwqnAul3nuHISQJg7NNPVVmcwaTpCjLo/299s/ZcsvR5AA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1704a29a-6687-42d1-0e56-08dea18d9b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 23:11:10.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6vtLk2IYxu3GrTIRvS7FchtZcWOPIQ70FuLtrsFJwZe4OcXKLQhSl3c4nI+N7yucPnw9CwqAfPE6V4wjSQKRNo68L2FB5bzHlV4iCoIwWBSNDUV8buYXyefasfHuB5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2026 23:11:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22804

Hi Uli,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Ulrich Hecht via lists.cip-project.org
> Sent: Wednesday, April 22, 2026 6:34 PM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: [cip-dev] Request for review for 4.4-st75, 4.4-cip110
>=20
> Hi!
>=20
> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-4.4.y-st-rc
>=20
> 7c091280e3bb2 net: usb: pegasus: enable basic endpoint checking e2727eb73=
284b ceph: supply snapshot context in
> ceph_zero_partial_object() 2574b34a8eb2d xen-netback: reject zero-queue c=
onfiguration from guest
> 14894a8decc71 net: atm: fix crash due to unvalidated vcc pointer in sigd_=
send()
> de412dd7471d2 PCI/portdrv: Fix potential resource leak 1837000f16f5e hrti=
mer: Fix trace oddity
> 5525cf4093568 md/raid10: fix any_working flag handling in raid10_sync_req=
uest
> 554c2968593e9 net: usb: catc: enable basic endpoint checking
>=20
> Thanks for having a look!

Thanks for your work!
I reviewed this update, looks good to me.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

>=20
> CU
> Uli

Best regards,
  Nobuhiro


