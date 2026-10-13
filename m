Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF652CA9ED0
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 04:52:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.451.1791867149533423700
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2026 21:52:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=fYvJnVH3;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1791867147;x=1793076747;bh=UpPvJJ3rHjCeaZ8bolbCx22SnifV8J2FvkGHP
	UJqd1U=;b=fYvJnVH37/nuv2DrLNhCxmix36y416JJEAQw/ejQry7Pt96gTYUYi7NydzR4/ww7JkK
	I4KN6rdHV8XPaw+72QB5E8rOQAs2q5XHSTpVJS0keNBoks+Wgry1BGP6jaxsU+KEKpfiMHlx+8KDt
	0AICIpAoV27UZwFjdg1fFGOl0SpGvOuwqfR10hTTPK0LfU4/FJWfbEwSz50PoH7D9RblQWVKxciI7
	t9sDk9TLoSlV4RButEOnK5pNbd1vPU7APVov1/lIJJTL8UGu+5akOlbMjVqrmiCgyOoUobAci7CGZ
	p8B6rMVELt211BJ0at/fseMmjOC88BmtZyUtoNAjlvyg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69D4qRKf1961052; Tue, 13 Oct 2026 13:52:27 +0900
X-Iguazu-Qid: 2yAasLCAofiayIvQS2
X-Iguazu-QSIG: v=2; s=1; t=1791867146; q=2yAasLCAofiayIvQS2; m=xDedaRDqyWL9j3bSyKcyhhY8P8iCLsw384CcqHxBUS0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j3hlZ4xXBzyPQ; Tue, 13 Oct 2026 13:52:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUlHsAPH+2+RLVpVeKNkXyTQJ8aehx828v+i8QBpbCVsrrV7/9FiYGRXqfou+wT01FYNlZSJ21dsIv0qa0X9Mm0uadL2q9EEKoYTrXdR3UvPcEumGpdK6TaQ7/aHGQvSu+07sNSGdkiKftPlfyDrABTGbbWHxi5ydWoehpJDnPVcPRFBHRxnkskkiielw6VPmJ19eFKmA5Dc3uLEDIz7+Tzr9epVMJG3bLB47PveA+O8GFCo1IMxGSbp4vuzy7z6E/jUx089lFhgJ2LkkAeJzJhWcaRVhBxAjWVqxkJ2BxYI3GbPDs1Pm3shel0fw1exRPkQs542uuE8z58yHHJIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDDrB2UWU9At25F9vRGayuSG8uZ8kI1VxqNRSori11E=;
 b=Ap1s1RBsH/9zBZ4ouo0KJh+UM0Rgi/9qxi+zSlgSPIZLbWySc1h6aoVHTWMNrFQ0Ucum4fRkjC/J2grWaiDVmMtY+5r8b/ZBDN9K0GDIy+jCicGEfzoy94V6hbVZE4f3WdolGOoD1pdLB0t1/ughUnq5Owgtf6c6BqpDOPRr+8V+faeBXm8ewUpU4E4AGItBUINrTS08T5r7La/p7rXVZllDEdWeUSbTmFG0nFhFlyRjik9/YqgK6lgS9jhMBk4BtfjimZEOpqHSxPxWceozBeJiXC1x/tubx02yFywndi+ffn3Grb0LwJkWTzcTAstCc2XRVpYRRYkLh+M4h2ZkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip v3] PCI: rzg3s-host: Fix compilation warning
Thread-Topic: [PATCH 5.10.y-cip v3] PCI: rzg3s-host: Fix compilation warning
Thread-Index: AQHdUnfx13PN1WwZk0S+JTT5w2z9J7b69+RQ
Date: Tue, 13 Oct 2026 04:52:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB1480829D2B2DA4FCC97978D98CD9E2@OS7PR01MB14808.jpnprd01.prod.outlook.com>
References: <20261002141124.2402765-1-claudiu.beznea@tuxon.dev>
In-Reply-To: <20261002141124.2402765-1-claudiu.beznea@tuxon.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|TYYPR01MB6873:EE_
x-ms-office365-filtering-correlation-id: dc0ac439-4aa1-4d2d-0852-08df28e5c2bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|11063799006|261009223027099003|261009221227099003|56012099006;
x-microsoft-antispam-message-info: 
 8E61OIbv1ea1KEu88J840O5MD7xKYRMkimfPW9GJ5V/Y3MIPBIZsq0y/aw8Zp8MtPC61HBMgQu05QLgp3W4ScYdCH7GMpnyxZJNZQxpCeodrzmeUIhDNsNNlsMPnaygcP7B8bgoPbw4Y7bjOYkaAEDZQHBFRIsiDB+r5UE3meg6NZR84Ya359kbvQwwH2UnAhbjFzQ2ZDFiLHy0yG7MithDo39Nu9RswUGv/hr2KDD6PCIRksb03Bj5evYLcKyBYdiU0deESaG2KMa4WwSmNS5HcBA2/Pz/kC0M5ba2/xlSubQMpOQf0IAclwD++ZYMST8CjWrNqfzbatpNXl1zQJQJ2CrjBbwvmT80k9Zd/+WM5R+czeMLQsUsPlNeUp7/Zz7SWUwGPm6KdqPrF6Vzl+Ih12POg5L9XGCVBa25FM/IVk1XjDSZcNplwP/mz9VQUVk3L8ShlLmt6y9zhlN0A9Jf37BkTrW8jh38m1t+bojCdhq/JcCwNfwjZzgoBhrMZYJbxwVmX6W+v/a211ouviWIrbpduR94pVg1DmegL7PKtuSIG4m3X4VaDDPvhXRKumjoRMKO7ueX7t89cqb+OJZljP1MYQeG/cYb8LPpYo12fx+B3CunN2eIc5HdVMmQjj30ol+j6xXz5KfNnjNiHUWzZYBjbYnfoVVRwfwA5QbvqgYggHgXRpcEWjllxsI5SO1xCTqjDjT5LnG2Mfebhi76HdG2wg7YXNb2nfSndeao=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(261009223027099003)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZnE4SThVMHJpVTJoQ0QzeXRncndUYWFRRHFiV2ZZR2JhSkkxOVFUM0p5?=
 =?iso-2022-jp?B?SXdZVitzeWVScmN6VVQ4bnpjQzQ2VlcwUGtBTnJmQ3RUTkgxVmxUSU1n?=
 =?iso-2022-jp?B?dngyeGV6Z1M5NmFoNTJHeWZHMnhOdFdtWmJreXFlaWRlUFQ3VS81N0NO?=
 =?iso-2022-jp?B?anNYV0M4Y1M4dXhzSlYweFh5TUVuclRQWkk2K041czV6UExhU3VpdE4w?=
 =?iso-2022-jp?B?dHRFQjQ3WFBWaHhZak0wR2VuQTY5dW9JQnVXVzQ2VThpVEdtcmxnaEtF?=
 =?iso-2022-jp?B?V1kwbitXaEU4QlFlZytWbWQrblE2OTBHbmQyMlYyd0Y5bVd4RHNJbTJM?=
 =?iso-2022-jp?B?eWdtM0U5OXIrUHhKdjFpL1RrZUoxNkNzUVRmU1dGelQxak0yUlRIay82?=
 =?iso-2022-jp?B?MHd6NkhZSmZNVit4bTBvRmRZVXFzdjd6dzZmQlFWaHBFblFEY29KMkRh?=
 =?iso-2022-jp?B?TUhUcXVhRzdQSitQKzQ5NlYrcGI4VEtBREVFaUFEdVBMbmpjdlVxWTNE?=
 =?iso-2022-jp?B?Snh6ODNEMEJ1K1BzNzlQRnJRT0E5WHc3eHNyUmFPSFdGKzVHcUYyZWpv?=
 =?iso-2022-jp?B?YUpDYzFGTE1LWGNRd0luaG5ZajZJWlZodlkvREhTejRST1gwWHYzckZV?=
 =?iso-2022-jp?B?OVA5bE9xZnBabSt5RXUrSGhBcWMxNnhSRFVvaU5FdWNzekRvWEJmNm0x?=
 =?iso-2022-jp?B?VklYUVlPNkNkYmlySWFrN0Jxd09FRHdEbFZhZUdwbllPeTlNVUxBaXB0?=
 =?iso-2022-jp?B?VG00VzdseWpGaWh6Z3lVVDVJU2QrRi9FbFEzTkhHa1dMTWNhdzlNUDdk?=
 =?iso-2022-jp?B?R3ZLSm9RbVVSYXNCNWFBYVMvL1BSNjFMV3o0dUQ3b3JsTFBGRWNHL3RW?=
 =?iso-2022-jp?B?UWRqaC9pV203TE9Vd0Njcmg5OWRQUmFKNnZ4UFVLUHhmYmd5Mm4rWEJD?=
 =?iso-2022-jp?B?a0IrWTlQbmtTd2ZzbDRTQ0crNEdQdTFQZW50VnpqTzZUdTY4cjdOUDIw?=
 =?iso-2022-jp?B?WEZHSUtXSmVZUGtXZDZRR3Z6K3YyeTJUb0hVemlQekJjMjNJdlIrRWcv?=
 =?iso-2022-jp?B?OThnbTZZU0ZSQ1g3M2JRbit6a2hFSE5RVW1vWGp0Y1FpWW1kclpIbGFw?=
 =?iso-2022-jp?B?eHp1UzFUVVAzWWxmMndJb2Q2bHNLUTFzTzBIUUw3aFJBNk5BYzBtYWRI?=
 =?iso-2022-jp?B?NlovY3FZL3VDclp0ODlCTXpCL3lqa3duU1RrbXQwd1YzVXFkazYrcVR0?=
 =?iso-2022-jp?B?Sk81Rm9TTUdtaHlMcms3SHJxWVBSZG13NkRUa2ZxSVh2MnFXcFdmRzlY?=
 =?iso-2022-jp?B?U1JlWnpTRTI4UnJueVd3WGlPbG5wNGozYUZWS3ZweTBpWnJxYzlJUE1F?=
 =?iso-2022-jp?B?aDRvenFXM2o3bFFZTXk2QmpOVUJjU0RpZlJqNUJoODFvUFVYZVRzaHIw?=
 =?iso-2022-jp?B?L0xzYnljckNGNTVrKzdlRVV6T2p6SGhpaGtEUEZXdlpWSFlKRWRXR2J0?=
 =?iso-2022-jp?B?UXM4d0dra0FDUnBzK1NNSHhiNHdkeVhuaVVvdlF3U2l4K1pGYlBRWEJq?=
 =?iso-2022-jp?B?dXJpaWRwL21jdXJOa3oyb3Y2S3A0RWY1RWVoNW14UWt2am9JejVROEF3?=
 =?iso-2022-jp?B?bTlRT3haMDZidm5tNjdPU2g2SjNFQ0NFNkViY005UEtueVBRUjBUdmRF?=
 =?iso-2022-jp?B?Nkx0OFd6WG1UaVpvaCtkUDNLWkJaVWY2QmJOeUZ2VTF4QTBLTUxUMFE1?=
 =?iso-2022-jp?B?MDhZend4dFRLNy9ZaVlsNVdPUTh0cDdEWFVBUTJCb2xUdmVZOG9ZUzFr?=
 =?iso-2022-jp?B?M2p4QVYvaDdSekZZSmdnNnI5RG9WWlJGVC9xUHdJdk81SUJsZHZsVHha?=
 =?iso-2022-jp?B?cWpCeVFSSW9nOGF5YU81T0dpR21BVVViRzk1cUVlVDNPZlQ0dzVobnY4?=
 =?iso-2022-jp?B?bE0xdFhRK2RmeUxCSmRmTjFlaVlpNEdxK3htdzVnUE9GVDVSRy80bzkx?=
 =?iso-2022-jp?B?N1VpTllIbmV5bFc4c0k0ay9PNW5YZEtYYVhlUllCRzN2UFBpSklCaGZm?=
 =?iso-2022-jp?B?K0NhcG45NnJCQTlGVVBDajV2RGNITVVkVERxYnBhcUJxNm5BTHJkL3dM?=
 =?iso-2022-jp?B?WHM3NFVTQkpIbmxpc1JYQXhkbnVKaGpjNDNJTExyYzR5UFd2aDJoRE5y?=
 =?iso-2022-jp?B?dENtUm9oc3JyK0JUajZJMDNRNWtXdlBMVFRuSkFyeEplRlh3L0hrU0sw?=
 =?iso-2022-jp?B?VjVkZFd0ZUVoMEoxWTJ5YkEzaU5QZUx2Q25ZR3ZUOVVCUXIxRFJ4QmRR?=
 =?iso-2022-jp?B?bGdZOUh4dmNkTEZjdWVhR3Myd05nS0pEZTdTOEtualdwV1RyOHpyYWdE?=
 =?iso-2022-jp?B?K2pwSFYwTzlzV2E2USttSUdtTUYxcEY4clVBQkdORDdrSWNzNjNzZXgx?=
 =?iso-2022-jp?B?TGFiSDYzMFpFa2p1YjVYdnJhYVZ5OWM1TkVBNFg1ZDk2amZ1NVRBb01B?=
 =?iso-2022-jp?B?M1RWeVdQcHNLcjhiRWRidEVleThIRXcyUlBWNWVpL1BONVlxcnZpejBu?=
 =?iso-2022-jp?B?N3B1aWc0MD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Th73tNvACrl2EwjUH2q07zYRq8Jvu+Ym4uS3S8horsxp8D6FTF9nlbzZNoi30Vof7ERZM5BtJcqKRJJvoIzHHIa8lTNQ4cLaj41jE8pkvYd3kIKp0PIiPMcc+2n9oCQv3aA7n5+aW9STZlUGviCFKCwHFHXS0OEPTSgDzrBAkKyYV6uOqpkZbCicNOU6J2bDFZpT1FeEqcBOysnG014LTFjTLjLD/2m47qE0LTsYuAoCQLlBAhChy7wAuihOtisHO2k5jTUDQ+l2y/ZTD/TG0byYvNafxx48wFj0gnfkSgxSpY7WEOA0OlN0kkHDDhy4Bh7lsD5i9RpgVB5H7hlfNw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0ac439-4aa1-4d2d-0852-08df28e5c2bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 04:52:18.8938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqFzwYS4fRjnW59QtVyphg9P1y3cXfyaL8S9uNzYlgL2M7GRQ/V2b70qQ97uMEsA8Yqv4F2mjGxheeAA2cFz9V/ATbrZPb23bgON6He4m8OYgx0wvZDomvL5pfL2/th5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6873
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2026 04:52:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24446

Hi all,

> -----Original Message-----
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Sent: Friday, October 2, 2026 11:11 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com
> Cc: cip-dev@lists.cip-project.org
> Subject: [PATCH 5.10.y-cip v3] PCI: rzg3s-host: Fix compilation warning
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Fix the following compilation warning:
>=20
> pcie_rzg3s_host.c: In function =1B$B!F=1B(Brzg3s_pcie_probe=1B$B!G=1B(B:
> ../drivers/pci/controller/pcie-rzg3s-host.c:1558:2: warning: ISO C90 forb=
ids
> mixed declarations and code [-Wdeclaration-after-statement]
>  1558 |  struct rzg3s_pcie_host *host;
>       |  ^~~~~~
>=20
> Fixes: c5249a6594d6 ("PCI: Add Renesas RZ/G3S host controller driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v3:
> - fixed it by dropping ';'
>=20
>  drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
Looks good to me. I can apply this if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


