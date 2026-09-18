Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73B9C88E75
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 05:55:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5052.1789710902668507332
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 22:55:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=dapifx09;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789710899;x=1790920499;bh=Kx5z5pkU9hReGj1S9LY7sl5Gv6+LwuNg7ZIH+
	lcbQw8=;b=dapifx09FvAqSh0GhyYw9/hh+JNgIl/pwAb4YLohlQUAX9M7+6ZW0xwNQsUxNPAHPWn
	KZk+46E5ulxPEsESHic+vyhJDz2rasfk8SUIZh5ShK+P5JJ0Y3Ie2IR2gXRBnV7y7Zcu9Vvnzo+vd
	d/jTTRG/IttcwbCc4oRUPWg9D9cS2P0YvuJX4rJnjsLHhgyr/nxxrEur/LxD6AwXpMi0sW+Vv1ad6
	XbC1uyrgs4oYEXf5mVIqw/jQhXTlG2PVCMzMibIyO58Pcdrn5A+VdpSKEU4iQACP6zV7eqQ0V6WEZ
	7kMTLv0GxNXnQU7M4D+MQmPuZYHK1IW81idX7BA4eGGg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 68I5swsF377667; Fri, 18 Sep 2026 14:54:59 +0900
X-Iguazu-Qid: 2rWg3sYdYUYYuv640P
X-Iguazu-QSIG: v=2; s=1; t=1789710898; q=2rWg3sYdYUYYuv640P; m=B7TD2sTWWUG0uaGiBklXyTPi8W2JajwjKzgAcQJWZAU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hmMKG3YfBz1xnj; Fri, 18 Sep 2026 14:54:58 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EChioZwj5FsI9HDimFdGvFduxKNsd1ch10NRmcPIzHqsychKRWUaoLFj7TTTAsLa9t6wxLDxaZGF1BbHGEQfGUCbmQzxPSKHl6PO0H4JFXtLaKKz58pWQC6amezCnjm7M0tHfF2k/SN9LHjWcx/sR/krLQBxCsOmQys4ceMTOdzUNziH3W3cFVBxgbkwm0SHNZ2YLc5NrO2tDYGRwaufMOuK8vnMFCIqE0BtTdpNL7PVMoHzlFjKthrjOUiDc952nxdzDdSVCz0Q1qM2YkRY6vdiP99tf4BZCvsCITwtJtYDedHeL7jg53i7DcLYYWEmfPa6Q933dEFIE8n+Gkzbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF6EjrwoVloMunKc3S0QFM+chBGSOubTDxeWKfvElrk=;
 b=fseT+2iHPbJgSLLN7pg2TDCqQPeRCChMMS7FxzNarluhZgyR7Rmy9yrbKrRa2A/I8snkDAIptoUdP8DdWPdON/VcV5xMQLXKFIVdOgPoQbiWkLu6XdXzlLDXY/XUkrygew5PUxckS+eGic2xOCSpUZPOGncqdAB9vH2KAzrEHkFRh2OTAMs+Aw26cGvU4Qz5cL3N5JmBYesrmxsRfTo0PWx4W+q37zdvF1Dhc4bRJjq5ULxg9R/RVmrWReFCoRCUytwZtL5Hd6pcrA6Bz0SM8q6v+ZZGR6Q/26f4nPYDTOhGvtZPmJeRTX2fwMQPdQLIS/N5s49nzQYQGKT4tD2Gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <claudiu.beznea@tuxon.dev>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH linux-5.10.y-cip 00/14] mmc: renesas_sdhi:
 Backport old info1 register layout
Thread-Topic: [cip-dev] [PATCH linux-5.10.y-cip 00/14] mmc: renesas_sdhi:
 Backport old info1 register layout
Thread-Index: AQHdQfYhdBW1pH9PckSpd0a3Cu0adLbNmHJggABlrgCABeJP0A==
Date: Fri, 18 Sep 2026 05:54:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818962EB9ACA81716EE1D12CD872@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
 <TY7PR01MB14818F24F9C791A224F65FADDCDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aqfihPH06IEnYlBG@duo.ucw.cz>
In-Reply-To: <aqfihPH06IEnYlBG@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB11510:EE_
x-ms-office365-filtering-correlation-id: c28b6ba3-5ea4-42c4-e099-08df15495d60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 avTVurvMy79FjzBk4ESXp4QVEa1jFKv9sd6zEwawtAmG3+PMsIPA0jyXfxUWu/pM0mA7+3PLtdRbKCGnCGG0qmyHcOZ7Sco2WAe3oD5jlyJRPXPN0Pt9pMDw7HxQ0pRTfNyl9+RQu5BZg3RNgm7y8LLfjKSJg/26bmI+Hjy3p4OKoNTJMMaHTE3UQnVkSZHTv5o7a8Yf+7DwL39jjL7IS92eQoOyhg+xdES1aM5gRK6j6g+4pDUtNPaXqLEUch+QW2nqcPflYnz7a9drPVc6vaTBngu9KWGxGWdQIfHztJhuAjrzpPLvdbupEYrbEOYp5CR8ZBlYhlMod+GFa7gCzxP23sUxZ6xDQdbCCfy3SvdRUokoiWV0/UfZEImGMO+xdQManKW6BvKMaMMnBnh0UWlii5XaIQnD7m5VKCSPRkb5dcMIFFhwjUFUNrXEtt6c2QKMHiQ7RXwvWQiLU5ed9qqUaQY05c6oTfGdhfaO9rUcMU5a6nT2VRzYr2xSqK4WlXcgxKVs5XPiEYfggoUkpyOua6xGqVFt0qYyBOkgwO5xxY3npzv9NYB1Bjx2zGw6fx8Ol2oM3z6VZkwd/jRNEpAvJKdTe1LO3Q9zmAwOri1MDJ0rtRUrdE8XHVZeVMdgCpGuFg8AC93n69EqK/8CJf/wNVtk7MpoBoAd3xZOTY9Vl39OAstdo5kHIYyC1RZDRfU1nNVv+Z1vXQ1SsOnoYQtmvR8P1Jw0b7ykzzurV0Y=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NUVxL2tQb2pHN1pzbGFzRHJSZzdzcnQ2MHY5TVlSTWFTVHI2ck1JU3BK?=
 =?iso-2022-jp?B?eHlTNVB3MG53VFhXd01YV2dTNWphclJnOHBVdFhsTnhtTERlRktFTXN5?=
 =?iso-2022-jp?B?eVhZYnlON2o4YkEwMDMxSTVTcW9NWXhCYzFIeDhHUXNqdGNTZ1BHNUpH?=
 =?iso-2022-jp?B?TjYwQjNKQmJMTjdUc2pYOUlXcitNckh4T2ZOMEdHcktyK3VoSlJETDht?=
 =?iso-2022-jp?B?MmMxRzlCdXdldHV5Q3N2RzhtZi80OGtjQjY0d3gwUndwb3NjQUZtblhV?=
 =?iso-2022-jp?B?NDkxWVJrKzRUdUtQWUNxQWhIZnRYbzB4OGsxM1VKK3JxalJhQlRST09N?=
 =?iso-2022-jp?B?SjVtNzQ0SGdHQVpxWExXTVVnRmF4alptN0x2Y21SZXdHNWJUZjdpeENL?=
 =?iso-2022-jp?B?TVQwaURHTzNmT3U3VGJWZXlkVWMwM2Z5dmMrSXNtQ1lqdFR1YTFqbUVH?=
 =?iso-2022-jp?B?QVJVNU9TMHkxdFdxZndBd1VLV0NHa3BpQmxoOFMxS2ZGdDVUekUxYkdT?=
 =?iso-2022-jp?B?R2dHTDNCT1d0TlJUcGpxYUlFN2tRZDNySEVTa1ZGQlRxWlhFSEc1VXhj?=
 =?iso-2022-jp?B?VkxVNTlJQmZxYmg1SXQ4RHJvODMrUDdwU3BXSXNkRlJRME5ESW5ONGxy?=
 =?iso-2022-jp?B?UUwrUk1NTE5SRDZFZzZFUlZGQTBoVEpxZnVTMVlGSXMwUEY3KzJTNmxN?=
 =?iso-2022-jp?B?WjhHY0gvN0kyWXVnNHo3ZTV1WUxKRC9zRzRadEFOakFRN3cwR2xHU29r?=
 =?iso-2022-jp?B?ZGs1U25TUXE0NENaRnZpV0lRYVlHMVlYNHVyRER5cHdWRlB5cVVTSUJn?=
 =?iso-2022-jp?B?MW4yeEdkVElQVUxVU3AybWFlblZ4M1RsL0FRZm9jbEJGNHcrTFA3b2lJ?=
 =?iso-2022-jp?B?REo2ajl6K3NIb3FBSkN1RWJwWThpd0MvQiszNm4wMkFFNjFqSzJmalRz?=
 =?iso-2022-jp?B?QVhndGxkbW9GeGFKOXdaM1FIZFNNcDVDTUJUYjBxaUU3cU9xdW5JSjR2?=
 =?iso-2022-jp?B?R2J6RjdQMHNMVitnZnNqNURodXhjaDVINTIzcWs3bXEyWnNFbUlRMU5q?=
 =?iso-2022-jp?B?V3JZYW4xWU5Zem1ZemlwNGpncFU2RnJKNHNzNzIzTUxKTUJxdFBEU0ts?=
 =?iso-2022-jp?B?Q3duemhoK1ZLUkh6S1IxMjNmb2M2VVowQVF1V1E2czRnRTNyU3RBOUZh?=
 =?iso-2022-jp?B?bVlJTVhwclJQVWhqSVlON1FQRUN1cUtZRzZ3UFpjWnNQcVdNcDd3Z0VS?=
 =?iso-2022-jp?B?UnZYdzByODhzVGxYU2MyWmlWdTNTZCtLME1ySGlFb1RCeG53ZjVnRDEx?=
 =?iso-2022-jp?B?d1dkSFZPTFMzRExEOXlVL3BNL0hYdmtHMHd6dEp1TnJsaDkyWTNOV1FY?=
 =?iso-2022-jp?B?Zzh6Zk9hNHU2bVlMc3pSQWE3OSsyTFJFUGVPQTc3cFlWVVM0bFdpSENr?=
 =?iso-2022-jp?B?bHRacnhuMjMvb3c0NzZXTjdvUWk1dWUveHo1elhaWWZSRTZUUmV4cDdP?=
 =?iso-2022-jp?B?QVQxSW1NK3IyU3Exb2Mwd0QvS1VxbjJRRGEwR2t6dFNpK2RGV3BvNHc3?=
 =?iso-2022-jp?B?dDZKbFA0YWV1UlkwYTJNUWV4NXM0MVlzOU9IWmZJa0ZOdVl4Zm1qNzgv?=
 =?iso-2022-jp?B?SnpKaXRUR2xsN0V4bFpjOTZaaTJOUEtjemtucktGL3JGdHpza1Bkc1ZF?=
 =?iso-2022-jp?B?STRVUDRwdWRhalN0eDZMSWtNOXFJRXYrdGdrNmxFVzdzeXlrSDR1em83?=
 =?iso-2022-jp?B?Rk11MHJNWk12NmxINnZmTm5vZ3UweGVqYmlYKzJtUGN3OXdsbzJ3ZWpB?=
 =?iso-2022-jp?B?VzhRejNQaGpOdGNLU29KMUVpbHdJVEQ5RXgyVW9mM3gwWmNacGlRZEdX?=
 =?iso-2022-jp?B?UE45UkN1TjVkdzhlRGhLaGV5dHNNQ2h6VGVhNHhOdkN3aHdiODQyaHEy?=
 =?iso-2022-jp?B?aCtwL1h6NHdiMTl6UmxEOEVwMWJQeEwzSjRRa0IvamViVnNEQnJFQ2dH?=
 =?iso-2022-jp?B?QWh2bC9vNXVKZTVyQysyRWVOV1FRaENXaGVJc2tUMkVyMlFOOFlYVER0?=
 =?iso-2022-jp?B?VVVvajZTbGxrKy9UMUJIS2xYdXZiek9zN1RtRnlBRGFVS1JmVUNJUGw5?=
 =?iso-2022-jp?B?Mk4yWlJOUU04TldZWEhjTklQRVUvdWM0RFp3ZlJaOHQyNi9JdkpIU3c5?=
 =?iso-2022-jp?B?cUxYYmRlRW5aUjMxT3hNVmI4Y3hKbWh3QndSMlcyU0NvZGhFL3h4anFF?=
 =?iso-2022-jp?B?Q0dISmtXTko3TGxoU0RXczdOZE05eWl2K2lhQkZVaTF3VHErR3k4djVx?=
 =?iso-2022-jp?B?bXRDc2dNRldrMEVSL1VobHU1SFoyM3NXOHUveWpldnBwQS9zN3JOOWRu?=
 =?iso-2022-jp?B?UmVzVU9nOVlkSGFOY0JFdDVtQ1ZKVjAwWCtselpvRVNFaVNRODNVdkNk?=
 =?iso-2022-jp?B?YlQ4Vk9DdnlabTc5TmdHemhxQndESVFVRUd3ck83citOdGxKWXY4TnlY?=
 =?iso-2022-jp?B?c1hGanJjY0xQQkhQTXlJVWFKYkZkVUd0Y3RlUmUwQ2NXeWd5aHJXSHVt?=
 =?iso-2022-jp?B?a251N3lvdz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	QdugCDHed/7NcRYG3CBMq1Mw0CVXbFQr6VBCPbn7zon6uQmAGAUwKC33Mgg612e+eASKXiRK/8gRHS8fLBSoHrPVznh3Rlwb4AnAD9q+1OYNjbZ58jV6GRF4Ix7zFsTBimEWgzHjoj5wClwMpyFm6Yo4lBxMolM1hqXSe+fHZmjUrb/uKQKmjUtU9CoS7n2H5fjEcRH+GtCpgkEr9WHcNLM6TyzJXmXRtB+Z2MneSuLgWLTYedMgb51e2+XSAMxl+Z5UHkzJ7jqu3CfZVI4o7L3N8OAsoWLlBsMcSEnCdnCbJLBCBLyIZSq4QlYkuOcRORymz0axkj1G2wATagyD8Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28b6ba3-5ea4-42c4-e099-08df15495d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 05:54:55.2888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHPPxUTpsv/fY6arlo7nj7/RWAlTccCju4Fvm6GD6BKMxNgwhv0Jz4hLlifCSdaitJ1SLyIfo+r8TqEBTHn240YLtnbiE1p2NVGX1W/pFUvk4mImJ+Py7niv6NOogj7U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11510
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 05:55:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24228

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Monday, September 14, 2026 9:03 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: claudiu.beznea@tuxon.dev; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH linux-5.10.y-cip 00/14] mmc: renesas_sdhi:
> Backport old info1 register layout
>=20
> Hi!
>=20
> > > Some early Gen3 SoCs have the DTRANEND1 bit at a different location
> > > than all later SoCs. Series backports necessary patches to
> > > differentiate b/w old and new register layout. While at it, and
> > > since the code is aligned for doing it now, backport the patches to
> > > enable RZ/G2N and RZ/G2E though their own compatible.
> > >
> > > All the patches backported here (except RZ/G2N and RZ/G2E ones) are
> > > already present in v6.1 and v6.12 CIP kernels.
> >
> > I reviewed this series, looks good to me.
> > I can apply this if tests are OK and there are no other comments.
> >   Test:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284575
> > 0901
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

Applied, thanks.

Best regards,
  Nobuhiro


