Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD88CD98DA
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 23:50:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.143206.1781567451621573298
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 16:50:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=X2B/ybpu;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1781567448;x=1782777048;bh=yQZjH0mC9+g0JG4tqodDs4bXaN6RwdGHrTVsS
	tWi/jY=;b=X2B/ybpuct3OF0It8LZoLBcB/CoPcavoXfOZC/YiK4zf2hcXkTcF8Ob6iUcYQZ4UAq6
	HbNP1m+anXeTtHjc/c+7paXCnaqRL3KsLEs59TjXDXXZVZAKrhLLprhj0aLHrbVzUN8DtgoGbvRon
	+POK66B58Dm+htu1xzOyWoGVp/DuEHvLl9qINrsuTgjBJzx1GSonubgLbsxch/+/j5gbgENvGEm6Z
	8Bejbp828SIpYheZZcRGTPV1qdaxqMlJf5cou851GamtSY5UVSCsicbjUITOyVahuJw5EimqQ4Ct2
	+T/6qzoxxKkjy0OneElJjoTpeTughlaDwPGRIzR67AaA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 65FNolrp3143203; Tue, 16 Jun 2026 08:50:48 +0900
X-Iguazu-Qid: 2rWhVaVmImvJSNi50a
X-Iguazu-QSIG: v=2; s=0; t=1781567447; q=2rWhVaVmImvJSNi50a; m=YxmiXHcALYSp3xH0Xi8kB7Ul8bc+MnS2uesD7Q5xCp4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gfRhR2TKMz1xnp; Tue, 16 Jun 2026 08:50:46 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4IDVfmDpOoYVwMNXp/AUnJKKOENicQTIFsmnp+uvz0N3VIQTOyjjgYCFSdh8bV1Y9K6FnqUS/dTTYZyHfhzlEQHCTBYmY3P/rIvPDzwAbIOI5YgRNcO7m+y5G/ZJ3qxBewZMD04G1FLJk/JMC0BW2N3cF2eqDpT4ynG7t2JWwQLZtQmMJGmkylpl0JSEP0bfvcGrPc/6MTr7eKjnZEkpgkWn9FBo8IupJDQyhmc6lj8eoczZePP0ciAWcIrdpVwhnlo8os5he3fU5TxCy9ZmkwzHhgND500IF5QKSTfoZIVN8hmZ6Ao+wfMDs4leqR/PEvoK4XxqUrcZXZT68gySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUVdY7mo4Ov695cB5CGbUmf1yJPIdQ4yOXvfLnVisIA=;
 b=tFdpFVd/Rkc//KG1xkj7dXSWJ+it34e0ABFCexEmL/WDxBW/mtcLWf9m6LUCvn9s7W5HjRYN7iYUiekGxUE4VkMSL9h99QZWrDc0ADLnEk6SBXkJNx962SexGKfsvWG/uEzlMAP9/7ixwoy3SdODxUsmx2LJSTIOWvmXHqLE8CKjXq93Stn8Ry4VhRNvI4V32FhprmqGR/jux09Q5MJW5yPPaEybvGi6DJnUnLHcOBN05OJDe2x9wnUpazYO0aLxpOJf/ev3A3ZHgOJILdwmJnUHI0mSHKWXvYDsFWPxJJEveo1gQF6DutdNrsUiYspUZVezC24bJ14fE/jX3jDXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Thread-Index: AQHc+RIwKFPPVjUeikSpa+v7h7aK+LY413QggAECSoCABYA3gIAAyK2AgAAlrvA=
Date: Mon, 15 Jun 2026 23:50:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148180CBA9D53CA9256F7189CCDE62@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aisi82Eui1N1svgC@duo.ucw.cz>
 <38f60ffa-0dda-4e8b-a1da-82f9288e1faa@tuxon.dev>
 <ajBolVke5ENiZ9n2@duo.ucw.cz>
In-Reply-To: <ajBolVke5ENiZ9n2@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB11368:EE_
x-ms-office365-filtering-correlation-id: 91e62e87-60cb-41b1-b992-08decb38ea5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: 
 tMYTNHpMnOqcG1siCXLq5lkysF0Vnwr+vfCJihPIkgezcpbzh+5oCDOciRYZwrwUUfhZgJEBmLQFRTdS82SX2qxJO1nqW99gOsVBYX7JQy+R5NCQYyFN7jrVXOOs0CSNb/XMVR8YzdskVz8Ve0c6RRI7Tx1+dakxXGpWytEfyx+zEAS8xkVsT3rk16phpNY2puAvbYwiNaGVOAbpTTekXrWrBihwlL3HGCBcE/ao7Xb5MgFdlNeIspWBEFgMJPnk9Z2jnNRCjXhXOEFDH18Qd1GPjBGGHXXw2gihHsDdW2HtTxzkZYm9vJ8bhhGIBUDwOLWRWoJMbCC50zIAt1Ut7fBzMH681+gMPH/iU4D8sqXI5qctkhgaHKlCEhaUa6ni8pI9Bl9Go16a6MgH24foNlnQAyZUTOkikbnV352B3Uz67x5UdKFNIgHR2FXou5BmuHanBEPGYWkkWyq/2VlaQcaXE+RXCSKF7RlA0dTpnieh4MfFUJ/wA+2+YAGiDGVXayVnDOV9bKKOBRpoaL6G2wtS6/xo/FC8xwXDEjZWonVAc2+8nlKCZOl11aMlDgeJjhG+Sd3xEVRo9SPaN7WV1ydKY7zv55RbRp2TW8Hx4HiYRhaH5ZCCMdM2jo+Yvg2A4kndHLxtlL+vGORQi5++DxuTNRq3zSFgH1k3HE4vejKvnEVm7/6jSKQIkBLX7sQ7YZa7ZTuMlxO+u9OwRuTfzE83c/pIx6gLUZpT+fif6r1NhmyzMV3LNyIkdZV54r29
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cUdhUC9zRlNJOG1ZSTZWbnBXbDZjQzUzbHZSK1FpeTBKdDBUZkc2b0tr?=
 =?iso-2022-jp?B?NDUrMC81NldPdWEvVGpTRGdoMm1DaUxvK1kyUzRMT0l4RjFjaTFoODl5?=
 =?iso-2022-jp?B?aUNoWEdkVUtJRmVPZ2IvbGNtelQrR0wvTE4vYmdtSm5yeDIrN1hqMGVO?=
 =?iso-2022-jp?B?elU4blAxaUloUTVaMEJsZ2c5a0JxMmRWZ29wRWM2UGF4L1lnQXdZeHF2?=
 =?iso-2022-jp?B?d3lRb214bE10ak1LREhlK1dvTHlGTmRsRTM1UTBkREMzWWRZTUo2VXBG?=
 =?iso-2022-jp?B?bHU5M0pLM2xkdlgrNE9xM2tDdFU2ZWdneUVyaFF3SDljejRmRzI1QmhF?=
 =?iso-2022-jp?B?RjBSZGQ1VjRMM2JOTlRVVGQvMTBKb3M4OHB5eG1qeTZldmROQllRMkpt?=
 =?iso-2022-jp?B?Zm1seGVKdkZJVkMrWlJDNC9rL0hMUVI1ekhKMmxCVUU5SEJ2RUZGbTh4?=
 =?iso-2022-jp?B?azliQ2hmQys3aHBKSkp0dVNtUlc3L1VrY1NyaUZHOWRqSGJKVytMYklk?=
 =?iso-2022-jp?B?N3NXbllVUngybDJWYUNkcFk2UklTbUh4Z3RxRUxHR0hMRStUOTl4OEE0?=
 =?iso-2022-jp?B?L2tNRTV1emkxQ3NKT1FSUisxVUpQSnp1a2l2dWxCQ2k4VjBKYWR3VUc0?=
 =?iso-2022-jp?B?VDZLMXUwQnFNVU1TbDcyYlRLd3VNa1hjUmR0U2o1VGhBQUQzT1BaVFg2?=
 =?iso-2022-jp?B?UytFd2tEdHdDck5IWjZ0WmpkelFYT1ZZQmtkdm5heDlGYkQzcFAzU1Nt?=
 =?iso-2022-jp?B?cjB2dGFvQ1NsYU9kQzgyVlNLak9PcFBwZWEvdkhLK1RscTNEd2xVUnl2?=
 =?iso-2022-jp?B?dTlKMk8xZmsvU2wrYXplZ3JYMnhlVWRHVTRBblFacFR0WEFRc2kyZFhB?=
 =?iso-2022-jp?B?aXRadnN0SXVVSmJZYkJGOXpTZjU2R2VtU1RQY2lmY3lMa3dXZk1CTGMy?=
 =?iso-2022-jp?B?YkxSendORUpRN3ZicW1mbTB3QUxEd1NLZzBEdjRBUjUyTncxd1lFK0g5?=
 =?iso-2022-jp?B?UGtTS1RlUmNPdUZRMks1eVJxQlYycTlrT2g3aStTbEN1SDFhTUFnNlgx?=
 =?iso-2022-jp?B?RTY2M0FiL295NFhKWHE3R1JxUHlwSHBHbUhobGJIbWdramllc0dZWHhi?=
 =?iso-2022-jp?B?MFpLYnptL0thTXZtWnlPSGEzeU1wMmtNWEVyMXJmQ1RrVm1GdWY1eU1k?=
 =?iso-2022-jp?B?eUZFbS9ZZm9Zclc4TUhFeS9iMEp6S1dNSW15QmtKc0xESGVaOGhKMW9N?=
 =?iso-2022-jp?B?V0g1NzFrVEthMlRsK1VVR01tWDE1aXV5L2d3SEJCQnZpeDUrNEtGQ3RM?=
 =?iso-2022-jp?B?QndmL1YyazNwRTVSa3ZXT2M0bk9Fb29Fb3ZZR3NsTjR4WWlPd2tyeUV5?=
 =?iso-2022-jp?B?eUpzSmZRQmpzdmJCR1VLcFFDZm12ZTlqRFJmbWRmOVFsWDgrTlFVQUpr?=
 =?iso-2022-jp?B?VzBFUk05MkhFZ0FQekMyNURVU1dLdk9odzZJSU1UaWFHeERmditIK0Q2?=
 =?iso-2022-jp?B?czdDMjAxUERNZTFOTm1NR0VtWUR0cmJncjVnbndYY3hSVVZwdlZvWXN0?=
 =?iso-2022-jp?B?OGF5cU9pdnpxQmhMRXFXeDA0a3BIbVc4QVJjaXJEWXhTSDZtN1ZqK0R0?=
 =?iso-2022-jp?B?RG5JRUtrcjNUcm5VaXZIR0p3UlhJTitjK1o2VUIwMFBrdEtucGRoa3RS?=
 =?iso-2022-jp?B?V2pwMjlEcndEbll2ZWlOSnQyV3VKa0VnVVpVT1dEL1JWN2YvNDJtdU81?=
 =?iso-2022-jp?B?MkpjVG5sa2RRZFFweVY1WjYzRUZISzQ1ZGRXQ3BpYmZybjl0Y2hldnVP?=
 =?iso-2022-jp?B?a1AvY0ZWL21YcWZsNkF1SkUwZEpXNllocjMyUGZuVmZ5Wkk0SG1tRVY1?=
 =?iso-2022-jp?B?dnJWa0RBYWlhWVhmbUYwcm03NmwwNWZnV3p4ZWFNRExMWjg5Tm1NMGpz?=
 =?iso-2022-jp?B?OHJjNms3OXAzSjFKSy90d0dMWDJ0NmdMSERiUzVmTnlQcHg4YXlLY1BM?=
 =?iso-2022-jp?B?ODRvNWhGR2hERDlFMEFaNTAwRjEzbUVFWWFUWVNmRS9OSDQxcXVUenFy?=
 =?iso-2022-jp?B?MDhscStoWkhUWHVxd3g0M0pIWE8yeXVSbUZBd2RaTXFoN0I3aStPdnMx?=
 =?iso-2022-jp?B?TUZIRm12TlRTVjRUeVVRcVlrY00wdnBOb2hKM0ZRZ0dMYTZxczlRSGxw?=
 =?iso-2022-jp?B?UklVby9yK3BSTGNPNWRhQ1pVT1hzY296NkV2K2VnRGlJL003d0RoYlNz?=
 =?iso-2022-jp?B?SUtRclg1VFArNURzMUZ5U0xXeXJwVk1seGFWdm9ZcHYvV010VVZGZnFR?=
 =?iso-2022-jp?B?cFg5WGxyUHVwbkJDM1F1WHRaOFZ0dkp4Umc4WlVsdXFGaSsza0NUdERX?=
 =?iso-2022-jp?B?cU1yWEZOdE9VQ0t4enI2Sk9Sb0xzQ3FXdzNMQk9tQXN4WGM0VlpvRHB4?=
 =?iso-2022-jp?B?UDJHOFQzMFpwQSszZzdBN3hKUjNkMnREU1d5eW1EQmhxc0xtMitxVmJl?=
 =?iso-2022-jp?B?R1pmQ3VwK3Jxc1JpT3lUYlI4ZUdZOW5GR2hYWjJHZUsva0VFMndRaW8z?=
 =?iso-2022-jp?B?bUJaczFpRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	YU/ujY8HKtHKhST/L6bOoxCuWvdLuvAYO0QUmkIK15v+RhSnpVrls5rPVJILStEo8BmuuVP9jiz1Ouwy0dPJrC86cgrGHSXIxoX4kF0TDkdzVUTJECMi2KsEfqyKAtxSsbVUCd16IhBWJ7cDf9LVoaLJ0yp7aRsIVRwYTRYVto8Ico9+ENBSiupqh7PoM4C5R0nMY61GbgvmedS/K6h7UWdBJvcoNdzZNgMErwedV2l0CDBouyYCSMN+QwQMotFvjOoU2XTtn8BuSUwcducV+eEtES2Pxlcktkxx/XedWcg8cxGdyQBcaGfIZ9Qq1v8mN1U7SoFU+mLmnkhNIR4FyQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e62e87-60cb-41b1-b992-08decb38ea5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 23:50:44.3748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8or5yNgfrWJNJ0/S7fOH8YUK2390YrzX5jL1iQiVdrKsV83TUFIHxKsuCd032AfhzKYI53/6uW+E6VM9IkRjXobk6SkMApADLUTD//CXsMPv3V3hJ3kKblpfunEVtSr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11368
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jun 2026 23:50:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23143

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, June 16, 2026 6:03 AM
> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: pavel@nabladev.com; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =
=1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>;
> cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB suppo=
rt
>=20
> On Mon 2026-06-15 12:05:03, Claudiu Beznea wrote:
> > Hi,
> >
> > On 6/12/26 00:04, Pavel Machek via lists.cip-project.org wrote:
> > > Hi!
> > >
> > > > Thanks for your patch.
> > > > I reviewed this and other series, these seems to be fine.
> > > > I can apply this if tests are OK and there are no other comments.
> > > >    Reviewed-by: Nobuhiro Iwamatsu
> > > > <nobuhiro.iwamatsu.x90@mail.toshiba>
> > >
> > > I'm looking into it. As this modifies generic code, I suggest we are
> > > cautious here.
> > Please let me know if you want me to limit that code to RZ/G3S SoC only=
.
>=20
> I'm still reviewing the series, sorry for delay.
>=20
> My first preffered option would be explanation why this is okay on
> 5.10: (Will it change behaviour on non-renesas boards? How sure we are th=
e behaviour change will not break something,
> or slow things down
> significantly?)
>=20
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -442,6 +442,17 @@ static int __maybe_unused ehci_platform_suspend(stru=
ct device *dev)
>         if (pdata->power_suspend)
>                 pdata->power_suspend(pdev);
>=20
> +       ret =3D reset_control_assert(priv->rsts);
> +       if (ret) {
> +               if (pdata->power_on)
> +                       pdata->power_on(pdev);
> +
> +               ehci_resume(hcd, false);
> +
> +               if (priv->quirk_poll)
> +                       quirk_poll_init(priv);
> +       }
> +
>=20
> If we can't have the explanation, limiting to renesas boards would be fin=
e next option.

This concern was also discussed when the original patch was posted.
   https://lkml.org/lkml/2025/11/7/557

If we are only addressing specific SoCs, I think we need to fix it in Upstr=
eam first.

>=20
> Thanks and best regards,
> 								Pavel

Best regards,
  Nobuhiro


