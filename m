Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.686.1793395193295063728
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 14:19:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=VXhVoy5Q;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1793395181;x=1794604781;bh=TzfeKqixH655jIv0vNCkYDGU/skA+Oa7hWPWZ
	djTH74=;b=VXhVoy5QGsCeD7GjrrijKAwHCQ7TPKdhYzMFFGbDBX/Up8ZQf4me7kQ9S6tt8wPhB3v
	OZ/HyF8PimrxCQdg8+0BI5rlkMiK4AWK4frRe+ma1C38iygY9m6drgtLAqk9P7wQOSQOY3GKdP4dA
	z20T9Ac4ytaTfrl1eNNVVcdCKkjmX5Vs5cnG9Fh5VHidA2s4uDPnX8QTI6mLVDrImkmCz3xYJQ6r8
	sBgJ4XPl0D/Mpss4Ktj+a/J0g80op8oI8RTqMHDYMeCaEOMTXizFmbxIhRPuMr0TDZabwy6i9d8f8
	Dldc4uudEEXS9rrAqFsFTwX0S2QNxfykzRguqRJcPb4Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 69ULJfWu2475096; Sat, 31 Oct 2026 06:19:41 +0900
X-Iguazu-Qid: 2yAaKKNbLmmpQtpwiQ
X-Iguazu-QSIG: v=2; s=1; t=1793395181; q=2yAaKKNbLmmpQtpwiQ; m=YcHoZf92WGweEHewl3B8CnT3FFyKc3tVUioWfVUPClo=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jGYrr4chLz1xnZ; Sat, 31 Oct 2026 06:19:40 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIQN1HUsG9yDad+jI7JjF2Iy45unRZ2BhwIUms7Oq7IhfxpIgjCiW3JK9iI7PjQsDk6vdkCRrt3Gho11e48SvVhOxnV/rHX7zP/vWtSDyi1UJwPHiE5LrOoFf+TKWf/Z/ilvbKe5GqXJtKsht9/BQxlxcVY3OgOHw0qRKJ7VWBUVxuqIDVd9KBIzMu9o1A0klQ1Jjr9XFXjaKX45AbxIh6xS8NTcQWVArkimq7nAAh1anDJy94hi0y/rMWwG8iK7e3Qzdi7hhJYRYTKhTBk2RinWj31Fq97sBt/4iBMy/M1vJe6apcFIcgiXjsjXRFrj5Jj8Qa57WObp/E07g/htaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPCt8WSd0lM56Ko+qxBNRrM8WJQPPjVDIgFSLauTS9o=;
 b=qY5DB/+tlXDELuHc9zuLUOije5htUpb5Ecyuwmc+8zkXWNVFxYU3vPtd6RaaoLzTcbALOWQKteA7s0tkpLvMEQ/yPdI6/U3m4KA5aRiSj8hphsJnVyieQB9fPg6GjmLIOShpCFqTkvRP8r7t2khmI1jsVZz52oG3I06gDppwDX/usvU8Hsp4DQTTj3zJLppxhYuR4TbEFMZuvEP7QZs8ptqKnUuMxQcfDFACR0hb8inoLSEFCBHcpZLfi22DAjGZMEHhvXYnADBxS6jQ90ZUTAK6Vju1/CsYnhMgvjNXwKCRWC7popEOZBvd3r6uyci28FgOdZELpBzu5HGLLzxxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <uli@fpond.eu>,
        <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip] irqchip/renesas-rzv2h: Restore
 function parameter for suspend/resume
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip] irqchip/renesas-rzv2h: Restore
 function parameter for suspend/resume
Thread-Index: AQHdaDZk9S84Tc9SmESoDP4NqAeueLcWC9UAgACMUtA=
Date: Fri, 30 Oct 2026 21:19:36 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB1481826FE52035C5E5AD68D56CD6D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1793341067-15723-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <auSUEvghM0rgNVT5@duo.ucw.cz>
In-Reply-To: <auSUEvghM0rgNVT5@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB11204:EE_
x-ms-office365-filtering-correlation-id: eddffde5-dffa-4b93-78a9-08df36cb8034
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|4143699003|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: EH+vE+9Pf6PoJrtdpGiEaLOBuk9JqfaBhFqbR6fSWwtxtk+64AzArxJG0OYvNDMK6JrnESBYCKWqz9cOt/dGvOClcYzgx9a0fsQrkXn29HD+nJJID68fGNddeDDmt6R/E4kTMl1tu4hDylrWFV3Heuf0fVBxzppQ3s4zjWosI8Q/zPWmGQzPJ9Wh1/sjZi2ekB73js817iLMXPjT/OCPGm5y46tuRIpKMw28GNbTV9FmwGKoADhDmjEv7LqH6DlgxylaXkfqv5AwUvpuJ8+mPztN3aiATp6gvryH8laWNEa7JRCJ+oHy9xeiIjl+qFoqNGaTQTmv5tz8sVkWCs+cQBYP3Xp+TdBfGcA0l24UCQGbcGLq51TYJ57zVEkykGCjRZG8/TE6IJC9hRq6bPqdq8YDQErtLKqf5tk4Atw/bENBkLYMJ16LSP78KwstjD2Fgi1mQyXxETOXezSDrBfvPMg5kqiW86YyStHVOE1CcBWlX9i8i9C4w76NLDunVE78JUrsH6MlHBkedkUJb4A7ftRHAW3XF+7WPCE1HpwDG9s6Jw21DylBro2wDo1BNK+hnC8mjvX/pJFMtYKFIEWy5+3gSh4CY89paIKYybXpaSnGH/m38KGfwyZ3KFpuA4pOmf0QS5Xuq6zOWGIhoapMfobkMWc8u4MVzZXNSsKwiJP/KMmn7U8Vw2wL+D/nqNQtuoT3otULsX1ULXp/M2aQ0z4pytDV1YQgivCovXw4u1o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(4143699003)(38070700021)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dlU4aFR2ZGgrMVY2ek41OUFoUVU2d09seWtlallnS29UdEY4S0d1RkNI?=
 =?iso-2022-jp?B?azRybVNOVkJzOGdPTko5R2ZjTERocWFzNVFmZllMV0VKZ0ZkenVBR2xi?=
 =?iso-2022-jp?B?aVc4SURyZCt6emh4TmUzUnBEcHp3WlEveitZRlQxSkMxZlhqY2QyZTVZ?=
 =?iso-2022-jp?B?QkNTeE9YejJhK0k2NW9vRzlsMFdxUzJpeFpQU2tERTcxWVJNVk1ERWN5?=
 =?iso-2022-jp?B?S005dSt5QUxjbTBQdldLVTBPNks0cVpuREU1ZWZiVWNxWTh6ZzljekRD?=
 =?iso-2022-jp?B?aW84YlN2ZitNa0d3SUxNTFlHVDdzM0k2ZFphMGpYZS9kMmRUaUI1bXha?=
 =?iso-2022-jp?B?S2YvUXRZUkF1dHgvUllTSEtRK21aOEsyZFJwaC9ZZktmYyttU2xJeVNo?=
 =?iso-2022-jp?B?WkpuVzZKS0MzdmJtNnlsc0xucGxuaENpMzFxME5JNVdBcnJxM1lIdGdq?=
 =?iso-2022-jp?B?VEQ4NjBNOFB5cmtLK2JrM3ZLWk1XLzRCZHVUc0JEUTlwN2J5dWJUSXBt?=
 =?iso-2022-jp?B?SFJ0K0h3RERXY1laTnl2OHFnRWFzYlQ0WDFyS1pncDlxVS9EeFBpY0E1?=
 =?iso-2022-jp?B?NzBIQ2xHK3R0VE03OWVrRGg5dmFSZXBqNXdzRGN0cy8ySys0TlZxRUEw?=
 =?iso-2022-jp?B?Wm04VW1VOTFaaXl6MGtxVHFoWDBRaG5IdVRScWxWaVhBRDh0d3hJMzd2?=
 =?iso-2022-jp?B?WGgwYktWSXNhNml2M0NUWGNkYlIyWk5ubFNIUzRTbUxPZVhEbzJ6cXJt?=
 =?iso-2022-jp?B?LzcycTd3cm9BN0VHenFpZ0lGN1AyTWN1MnRHRFBUSE1RaUxRVWJKY0Ra?=
 =?iso-2022-jp?B?SFk4MEpWc0VJSTJDNWthdFB0TUxuZEpNQ2l3dWg2VkZCRDVoSFJNbWtG?=
 =?iso-2022-jp?B?b0czNkNUUEZ1WmVXaXcrNjYydGx0Um9Da1p3bG56QzdCYVk4YVFKUEU0?=
 =?iso-2022-jp?B?YXNvMmpOak5MYm1yeEV2ZktZM2x0emJMWHJwdEdnYWt0OXRpWklRaHFN?=
 =?iso-2022-jp?B?dlNFOGEwUmUwZTFTVjBsMFREZVJmUUk5a2lmbi8xM3dZSEtTci9kVmxr?=
 =?iso-2022-jp?B?aE1BL3p2STkxclRmK2pxNlcvOFc4cGJQMjJPTDhWN1k4elV5UXN1b0pS?=
 =?iso-2022-jp?B?aE1YZHoyMW5kV0pGaUNxOGdCYjhUVnFQTC9LQXkyaU1YTjN4Z3ZDc1BV?=
 =?iso-2022-jp?B?TlRCcVhpSDZsZ1NLUFBuRmlHc2xFVENEV1ZCQ2dUeGJYOVZDZGtiNXRG?=
 =?iso-2022-jp?B?bVdrM1RpV2N5blZweHR5WVBpaFloWDlUVE8xL3RCVWIxNE1mU3pVd0lq?=
 =?iso-2022-jp?B?aFJlNTdjYjBleDJ5eC90L0RUZnZXZ1lOTGxUZDZXSEFYeHIzdU1FWm9u?=
 =?iso-2022-jp?B?Q1hlYTh1RTNvQ0x2bnZQZDliVDFWYTNzTDNUbDkySERBMHp6d0VYcjRM?=
 =?iso-2022-jp?B?MnpWUGpNYzRIWGk0bXJFRnRxTVlBTndmdUZWZDBUSm95N0xsMVNiaUtr?=
 =?iso-2022-jp?B?VWxzQkgxay9uNGtXZlV6ekhpWit4VEZoYkhiMnlpVXNjTHFMVzZSdXJq?=
 =?iso-2022-jp?B?aDg4ejJHVXh4WHdQTnFVdVVpbkxhMG9WUFhsS1ZQdmp1bFAxR0pOQjVP?=
 =?iso-2022-jp?B?RDJnLzJYd3M1NXU3czFPVjJmZ2VLRTZyTmJOMFFHY3VYZGo3aDJkR0My?=
 =?iso-2022-jp?B?ekQwWWRqdEN5NldjSzN0bzJkQjZjcEJCcFBIYWVhYXRmbnNyaUw0UlNR?=
 =?iso-2022-jp?B?MHRpNFV4a0VTenZtOFFFRjk4NVgvTERnTGpOazFqKzF4MWxuOTBGZVVp?=
 =?iso-2022-jp?B?VXRqZE9jMmtLUHlzenBielBuN2dLeUUwbHpCaU9UeDg1enZMdC9BWGJU?=
 =?iso-2022-jp?B?OUdkRHNoU2VWSU5jYzZwaTArZldIQmFsOUZaemIwU210UjU1TGVQK2Rn?=
 =?iso-2022-jp?B?UFRNZWxJRGtpSXNDYzVmZlptVGpXYmZibVZmWlJEVFd2eVdMeklLSFdD?=
 =?iso-2022-jp?B?c3hQREFQdVZxZkZiU0VrWVFtVkdtUFZFbXZMSTBvaldKZGQ4NVU1VU1S?=
 =?iso-2022-jp?B?ZkN6WWFmdjIwNWk1bFNlTlh0S3dJRTF5SUpnRmU5UUcxYnNNeDVUNHYv?=
 =?iso-2022-jp?B?TGpxYVU5Y1lPVzd6ak5PRzcvQlBXVnpidXpidTduNGZ3ekphTTV3Wk9Z?=
 =?iso-2022-jp?B?TGJnd013bjY0NHhyS2ZtUjBZS0tUWTd3M2NRV3NFT2RZWnZtSGh5dDJ4?=
 =?iso-2022-jp?B?bE1nZFVkeExvTEErNGFYK3BySmRlY3pVTzVBRytxVWRYU1h2MVlsTTl4?=
 =?iso-2022-jp?B?aGUzVXBXY3MxdVMzWmd1bjJtb0k0MEdnMURUbVlCbms0SEJsVlN4WUlU?=
 =?iso-2022-jp?B?aTNtRlQ0VnBURVQwMTFOQVR0MkJtT3dtUkVlL0ZFaGNmdVF1RmxGU3Yr?=
 =?iso-2022-jp?B?R0xtQXBQdmlKV3JuUHRzc1lORkJySWhEQnUyVjRqd01wYkgzcklzcGFk?=
 =?iso-2022-jp?B?TDAzK0RvZ2JpRzNsOUZHb3pSZFNlMnpsd0tWdituN0pxVlZEY25HRmM4?=
 =?iso-2022-jp?B?eWkxQW1Eaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3ICi1Xm10OVp64DUdybiDg9zNBpkdUXcWR/yEvExOXK9POHFqTwauVIoJbU0P7S54JoN+MdQwwTK4enzkH3Yy5fDYv4VPj5+KOcnBlkvH3U++CM/4YoiQe8jTvy8uZfhVGW+pelX7kTbVBBJJHK5CYG9XhAenHQDF7epW39v88gkhvCXg2Bo2KHkRRU05ZPYrytSbOY8FPNo4bc0YvZ8OMzcvWTxp2IFOvXZQXlySnjoEmwhCzqCCUZTnm4wBNEVt9fHi4QMnagQDZIsa/c9jo0OWL+6+o2lVbXz0pi3J2gDIgDZhAArpclvzCowiiNvbG5kATi0hJvVvP0OSUtt4w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddffde5-dffa-4b93-78a9-08df36cb8034
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 21:19:36.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKHV2lMiZf2g5jqfmym2XLXuzfXRMVG0sC+MqIZRiKlrkxul2oBZ0DiPYAbPRU4IP5RBe9TYc7DRnbbsU9Aof0Cb/bhQYcf30Zo6re7a+hPcO7WbJ5QnqR4LyBgQnrCq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11204
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 21:19:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24593

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, October 30, 2026 9:57 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: pavel@nabladev.com; cip-dev@lists.cip-project.org; uli@fpond.eu;
> biju.das.jz@bp.renesas.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip] irqchip/renesas-rzv2h: Restore
> function parameter for suspend/resume
>=20
> Hi!
>=20
> > Commit 20a4a45ee35f ("syscore: Pass context data to callbacks")
> > modified the callback functionality in `syscore`. This commit also
> > included updates to the relevant drivers; however,
> > irqchip/renesas-rzv2h was not included in these changes and therefore
> requires its own fix.
> > This restore function parameter for rzv2h_irqc_irq_{suspend,resume}(),
> > and use register_syscore() instead of register_syscore_ops().
> >
> > Fixes: f443abb80780 ("irqchip/renesas-rzv2h: Add suspend/resume
> > support")
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> > ---
> >
> > NOTE: This is an issue that occurs after merging v6.12.114.
>=20
> As this depends on 6.12.114, it can't be (easily) tested now, and should =
not be
> applied now, but I'm okay with applying it after dependencies are merged.
>=20
> Reivewed-by: Pavel Machek <pavel@nabladev.com>
>=20
Thanks, applied.

Best regards,
  Nobuhiro

