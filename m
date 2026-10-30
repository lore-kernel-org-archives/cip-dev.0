Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.935.1793396139921127854
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 14:35:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ZdVGgmvr;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1793396130;x=1794605730;bh=MJMsukdkOoISaF2weU0FbSFUV0gsK4u8ZmDHB
	m6bmKs=;b=ZdVGgmvraqoAh6Cke5YGQPO9w5RTb/GUcTehQa+PnOW/JA39QNIa7UiyC29gIP2vDf4
	AwrsyXtpJFdLP3IuKbbJQGSbeXKohH3ufcPYM/21aVVqjYeGW4dxLTEUpGeP+Jxuhlw7M4b9VEUyc
	iACs1tF5DXD4qOAKRDWjAReB1nBMYWoi+fsvhCfiIaIfP1QRHQ3PJNXMzEOwktMTTlniZYMd9rymQ
	VSsxkL/IQmI1wjfw8jRiYXB38Mvu6VLB0rTHqNiro2WtYJDKSm5gQoQnZcGrDM5dMBxsLorJ18FGc
	7UPNgVDhwGc/plMLXT09aFpfVEgWTg6hunmHP8nRfiHA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 69ULZTYJ973157; Sat, 31 Oct 2026 06:35:29 +0900
X-Iguazu-Qid: 2rWgAJSOTa8JxQqZTE
X-Iguazu-QSIG: v=2; s=1; t=1793396129; q=2rWgAJSOTa8JxQqZTE; m=xrKNsfMquZtMV5cd+g1Lohjh2HxIPjGvZchgqcGJJFM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jGZC429Swz1xng; Sat, 31 Oct 2026 06:35:28 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBRhb8Nb2CNcDxrkx2chhHSIiJs4iK6Qx2VkR3peUXvBwk5qUekwRMoOo4l7ERv2X1/KcR2Ec317XM1GIhw0vCEAFb904RuLUXC1w931qPKDyPwhhtESIyxVYam9nNfFf2XbtlUMX/knyXCH5K0xT5Ncyk/MNHNbBNTHNgYISa6HFhZ2WSLD7d2EHoTSVV1M/CJro/D9CQsxdMeggI/NPIFH07t4qRFAo4/kTz+4rciwZHzYO3hbxXuLBD2492ye1WqubblGoVYbM8OCe2TOMlpIVJ8YGDhWVkp03OHAu+cPX/7f8iskpnt1zMuYsqBjSKGuoly5QINswje5IBuJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErZioe8Sgjxxgo1A5StWO8X5rGvMafX6fCM5hbVWU38=;
 b=Dv6/c+q/d0e+/+3ue3HEzE+c5+CMsochDCzGIm2gGZgA7i3GtU/0z7D2OY+jYJm7rcsvs9a+fKhkfx1HrDkO78wqcV+4d/hb3Ntqf6cG0ZDZDOHksdq+wD/FG2clkabwhdHIu0/pO7E7AbnRKjqpL3B6ya+VS6L+NRKNEEJO24Z3BYWhKsKShpZ38KfTjZ1B+ZvEuXlVsr2nnZoVZ9w9vDjjnWCfMRHuFjlhQfXapz9D/F8aglSq7LZa90dOdQgnUcWuf97Lrx3FEGEuR2j6WGc9tC++WtDVULPwK6UFZW0xfwcZgJXucYlWcMSc9uueNtHFjB5/WbHgpVaPRig1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <garpurhnefill.emiliuson.d47@mail.toshiba>
CC: <uli@fpond.eu>, <claudiu.beznea.uj@bp.renesas.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.12.y-cip] PM: domains: Mark
 dev_pm_domain_allow_detach_on_unbind_cleanup() as inline
Thread-Topic: [PATCH 6.12.y-cip] PM: domains: Mark
 dev_pm_domain_allow_detach_on_unbind_cleanup() as inline
Thread-Index: AQHdZeOIPGn+3RpYH0yWx6k967zz6rcTieeAgAMT9IA=
Date: Fri, 30 Oct 2026 21:35:24 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818A94E9B4496C23991E5E9CD6D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1793085576-6789-1-git-send-email-garpurhnefill.emiliuson.d47@mail.toshiba>
 <auJ1r4H8R_vnwy5O@duo.ucw.cz>
In-Reply-To: <auJ1r4H8R_vnwy5O@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSOPR01MB12283:EE_
x-ms-office365-filtering-correlation-id: fdc8cd5f-d1fa-47ab-771c-08df36cdb542
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|261021121427099003|261028144727099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261022105027099003|10067099003|11063799006|4143699003|6133799003|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: d6HQYkhA0sxvz0kk3icztM1GpjBWo3hqY5F+eE2ScLJVSbIh65xluRFfUmWBjxXcBh+nNjAGNygOBnfe/vRfJX0SgUneNkdzALN2iFCOKIpGC4nVSNEZ4Km9GIrwsh+eq3AG9LrvMIW3FpCwQtyCMoTfjAtTP6qqSgmkBd2b571BTEhYuTG4643kJLO90yu34lAkb+WdpN54TFEDcyFkgJj/McfjjB/q54QQcUAvZ282RLLO/pudN1fW/8goS889TBvjV8iEY9sNLXNW/BP6gqc/ZDVbN89enVivBRfmjyLaRfdb8rfJ2Vt7S7P/H9IWMWO+ZlGYJ9qGTMVkl0mtS+TdAp7iEcPn5/RwWWlu8ydnCQ1tmetFLruNXboW2CnD3U9/aW9uZP48hkQ4w9w1diYcWCW9zuIpK51rNKyF6KAOAiDpTzb3BgfrQ6BRYRtzgcFtm5lpJwPpc7bObPlpCF+Gf1QEdWh21lQ+Vg7DL6hR8RuY7GgeysOiLV+STLonz+WN1rHxb14CtbxzPSqVtFf5DTktxGukPecGjoNABD6DCYrMdL+eP4nSItr494DAU6+zMVgwpVpkK3CAIDbhjfbxkBQ6dL9tpYINsmBQh2PO5139v0bgKV+AL2ZbzChIDcjUecRJhpm3MVW+7t8kbegUeO7DC/yDco6nh8QjDKoUIVjuYyKCajvbMOeuaor9gSBkoo07YMnXfJiH12BIHH6M5cpbuwEz8zvF+bGxW8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261021121427099003)(261028144727099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(11063799006)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?N0tITG1venA4UVVXbXR4SFNERnFZVFlzUXVTOWRmNm5LakEzRk5EMjFt?=
 =?iso-2022-jp?B?cnprMFdkTWhzc1E2VU9UWGEvQStOanVkQmhvRDkvMC9HK0dzZnR5ZTVX?=
 =?iso-2022-jp?B?aXM4V0w0SHVnQXdIdTRKcm9oK0JBMHhqNCs5ZDZkKzE2T2lLcEZkUllM?=
 =?iso-2022-jp?B?WDkrSFhVYWtlaTFKZ1BwaDM0YnpKV0FGQUF1Ujg3S1VIa1RlNlVpOWV1?=
 =?iso-2022-jp?B?aXg5b1c5WHZtd1pKV3pna3cxRDlMc2xxZU5GWkJ5aUwza1cyalBrY2tL?=
 =?iso-2022-jp?B?cXhBUklUcXJqYWlJRiswR0Q5b1hFR0tCOC9uQzYxYUljZVVUck5lMzJz?=
 =?iso-2022-jp?B?cHJjamhBY1Q4ekl3YkZVSDhqRlN3dkE0TXNMOG5GajQwMnZsemVlakJ0?=
 =?iso-2022-jp?B?VENYSEJvQlJzRGRRTmZWRWpuOElYeDFreWhrTlM2VDI5S0xaTklhemx1?=
 =?iso-2022-jp?B?SVlQOHpYako2N2U5ZmdYVEtwQ0lldktOQ09BRGxOMU1hWW0xejF2dVRy?=
 =?iso-2022-jp?B?QmVDTzZ2akdkclh4TWE0bElPa1BhcDYyckUvaEE3VFlPalpVRnd5UFJn?=
 =?iso-2022-jp?B?cDZxMlhhWDhycG1kclp1K25IY0VFKzJYZ2xQMXYzakx3MjZHc210SzFI?=
 =?iso-2022-jp?B?b2c1SmVrSVh3TmlwdzRWU01mQWxHK3RtRlk3WmVuL1ozZU9JRVZVbzJI?=
 =?iso-2022-jp?B?dkQwZUVFSnI3YlN5dk9QZEloU1ZlTmtPVkQvNEtiK3ZuZnQ4WTNZcGVR?=
 =?iso-2022-jp?B?VnlNMGpVVTlKVlJKZjM3K0FoazlDbGpMbW1LVEFFSWVpeE5mMXVpZUNz?=
 =?iso-2022-jp?B?dkpPb0NwdEJSTUtLN3ZCMVNsMVVENmRyUnovOEhQNU5vR0I2b0w5UURt?=
 =?iso-2022-jp?B?VllvNEZ0WjdTTmpGNXc4ci9JdEo2QWpoSHE0dUNxU056YTk2Y3pqUWxj?=
 =?iso-2022-jp?B?Z2YxTTBwazBzTVNuMjRQcEtBTEdHNzdIVVNWRTBrM0dvWXVxUS9SaExQ?=
 =?iso-2022-jp?B?MHJQUnJ1bDNpRzEzaG9kamlWNXlJc2xrSVh1aW5DMExiYWNKT1VGUnNu?=
 =?iso-2022-jp?B?VC9INXFGUkRyZzRFb0JDSDZNYzM0SjI5Nm9GQnd4Rnh0dDIwQlBIZHpa?=
 =?iso-2022-jp?B?NXNsdG5YWml4MWZWSFgvMGFjNTkrQ0dmM051UkN6S1FWd0lNY2FTMCtF?=
 =?iso-2022-jp?B?aU5JZ0FDUWkwY0h3eFpHYS9STVdvVWpieEFycUhWZ1dDT1FFSHNlVnRJ?=
 =?iso-2022-jp?B?WTVUY1J5SnM1V091RFBQaHpwR0ZJbk5ueTNmQ0crKzZnR2pjQktjQjhm?=
 =?iso-2022-jp?B?TG9OTWdFcG9mSXhNL3JxV1FaWkljV1l5TGJGSG01ejRNbG5wMTQ0SDNC?=
 =?iso-2022-jp?B?a3BLUFFtMlhXbEZFT1lJT04vSWJTSkUvUEQ5Qmc5cHFKUXFGRm4rWmcv?=
 =?iso-2022-jp?B?V2w3VGtMTERWcXRZSlpLMXgwTlRKY0hhcWZDOHJiWjBJNXdYK0IzeTNT?=
 =?iso-2022-jp?B?djJlc1piZnkvUXB2eFpmS0xLcC8vb0VRMnp2YWVBWmFuclNvdmdNSlZo?=
 =?iso-2022-jp?B?YlM5OWFLMUdEenhUQTloT0lPc1ZpYUw5WU00WDd3ZG0zaGt5RkVPUmJx?=
 =?iso-2022-jp?B?cnhkMUpEeG1IeCthRWdndE1YSVlmSzlUQ1VsUjM3VFRoNkFoWmQ2TXRv?=
 =?iso-2022-jp?B?YmRtS0JtZ3lBSXFZZkk4d3R4UEhYZXBrT2U1cDM4VVVIclcwM2xIc3Br?=
 =?iso-2022-jp?B?K1lJZFVGVHR1bklYc3d2VW1JS3Z2K2xhZ3dkSE8xc2x4NEdORUdjN1lw?=
 =?iso-2022-jp?B?Zko5QmNsRVNVQlJackJTbXpuc29OOE4rVGYzdlFvYmNnVlRDSXZmU3pZ?=
 =?iso-2022-jp?B?aGF5RktEb1BVOEUvQ244b004aVVHb09OUzZyR2lTdE00YkhHZXVsVkd2?=
 =?iso-2022-jp?B?SFUzbmFSMEIyendEMUxjVjdjc1ZvdE1PUDRvQTgycnhQdjl0RzZnY1A2?=
 =?iso-2022-jp?B?VFlISHlMTDRNSUhPR3pFYWxVTTN6OENvcE9KWXlQRDBzYUZNQmh4NXRh?=
 =?iso-2022-jp?B?aW1mMFdqMzJPSGFNaU9iejFKbFNOQ0lvZ1pRY0E5V21mOFdMUmdwUkkx?=
 =?iso-2022-jp?B?M2RHNDVUMFpIaWU3Y015Smp2Q2ZMOHdiREZoMzdKYnhlMUNXYytsMWxC?=
 =?iso-2022-jp?B?YnFUVGordlNEcG1aY1BHZFYrZFV3SkJzZXRYRWEvR0VkL2gzdWJtNFZx?=
 =?iso-2022-jp?B?SzRUNWpLUzVZalVtZlBFWUZXOGhaaC8vTk1ZcnZuRlFBT1gzNUhnLzI4?=
 =?iso-2022-jp?B?WUEzQUF4QzRHOEtMQTVlQmJVLzRhdUZNbkY4ZzM3R08vdWJLUCtYd3hH?=
 =?iso-2022-jp?B?MVNhQU85VFM1TjFCWTJCdGxzVHlkWDFhenpXUEpBcjNSV2xZVXNCYTRS?=
 =?iso-2022-jp?B?MmVLRFVpZVZyUXQ3ZmdzM0x2ZFNoV2p0Mmk1bVkxTTNSZVJ2anc3UzRU?=
 =?iso-2022-jp?B?eE51SlR5VmlSZ3NVcDNuampGT1g1VXduTjRVYjJ4a2p6MU5POE9XYmtQ?=
 =?iso-2022-jp?B?Y0VpVDZvMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1jlSDi98HVBdLCU72wrgwCXCE5pks2aBi8vXjX857ZHstSEVw4Zc/L1jQtSX3or7zRK+P8NbRjPc1iq4SbRhg1QWWfkAzLYJ9wUwWWMmRtYXCgyCTXX+3MKYL152rdkcQJp1xqcB0Kv46Oc8K5Daum0Jfpdr/LgEPuU43+kjn5ozK0MwDoWANbp85k4mkW5dT3RClIWZnTBRobXWyid+I1MbuBBYu3vn9q/ZcPOPTvJ3Fs1Nl/KgFLu3Ry/8qRtQsfnOapSAfMV0+Z3WZtMrt2lsq4g6aZ6G3zNvotBHD17sSosl9naYhEZOzh1J4ptDT3Zs2MTQi+IpLTXU6+A71w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc8cd5f-d1fa-47ab-771c-08df36cdb542
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 21:35:24.6583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1VBDjPfT7EWqF3UL6h7sZGYv1mE0/xH5SDCpLS5AUC8fUHflm3CBnRi9Pk674N+3RnGQvdugDedM4/03DnNdopW/+J0E+870rLRGSYP7SD2oFWRAGZXd45ntMUKbojq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12283
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 21:35:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24594

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Thursday, October 29, 2026 7:23 AM
> To: emiliuson garpur hnefill(=1B$B%(%_%f%=3D%s=1B(B =1B$B%,%k%W%k=1B(B =
=1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <garpurhnefill.emiliuson.d47@mail.toshiba>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com; uli@fpond.eu;
> claudiu.beznea.uj@bp.renesas.com; cip-dev@lists.cip-project.org
> Subject: Re: [PATCH 6.12.y-cip] PM: domains: Mark
> dev_pm_domain_allow_detach_on_unbind_cleanup() as inline
>=20
> Hi!
>=20
> > Building with CONFIG_PM=3Dn and CONFIG_PREEMPT_RT=3Dy triggers a
> > -Wunused-function warning for the stub implementation of
> > dev_pm_domain_allow_detach_on_unbind_cleanup() in pm_domain.h.
> >
> > This issue only affects the -cip tree. Unlike the surrounding stub
> > helpers, this function was not declared inline. Mark the stub
> > implementation as inline so unused configurations do not trigger
> > compiler warnings.
>=20
> Thank you, applied.

Thanks for your review.
I could not find your commit in linux-6.12.y-cip, so I have included this w=
ith your
Reviewed-by tag.

Best regards,
  Nobuhiro

