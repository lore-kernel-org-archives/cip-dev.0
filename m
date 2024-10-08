Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EB3CFB45C
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 09:19:00 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.9])
 by mx.groups.io with SMTP id smtpd.web11.4856.1728379136601154697
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Oct 2024 02:18:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=FqKddcas;
 spf=pass (domain: renesas.com, ip: 52.101.125.9, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2U7YJT5SUFv7DtnZXzMupGhrux76GczgnBrl7sZa47KPRDNsChsWSSYMKJq/UdA9Ce9BdN7coRViy7Jbghcg5lsluA0iYSl5QL/8jV/Fja4LnI7rKU816SeE3GNyN8c23moLqVD9Ug1+vUWZTx8DwyUNa45D77g9DUI56g92DEo1qLX1ofz+xQ6EC8FI+a0jhFv0Gg3FKkiigDyPZ6wSSoVzWgvD0Zmj1yuGr7ub6bJzaj+PhIP83b+NvGMk7lqGJ15L/1oD5Be2sHg6JOClvhQqu0UVmI+TLfsmRzqVIIF9Ver6bcpEkQ8gSNY2Hb3mcVgX4e08Tjs9oa4Xlq8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnqO8hyNs8nzQQqjtexwucFY/dVrwowGJIYq1gTEYbI=;
 b=UWSmDKm52dyw2Gn2JE0S8rbLkdJE/V3UXcJdqXLgwgFLH0up09QOcb3pnc0qHO64KsjG6xevLSmTFIS5kxLZuIdvW0zpFnNXi/uWAjzrgUigPRHat2CClN/IFtMSjYVBDNaS3ShhfhcgP8W3o3mOQp8y9IDln33e8a3Kypx9rzwJBWaknN+aEtAfXnUQQmKpkUPLl6Wi/rydHMvb8vnlxeJfHgchpqYkEX9qaHy+wr6lfgyoFcl+m6k5v6mfXNzywar38xpu1ufhMiMxiSNBU2yQMsvtVViDEPNXKQXSXAn0zTX1v+yEM5++qFkLrNgIyeuhuMJUIGM6SX+Ur21SDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnqO8hyNs8nzQQqjtexwucFY/dVrwowGJIYq1gTEYbI=;
 b=FqKddcasxQvfioweKSCQ2BEX+G3JQHWiUbmMn9Q6ey5gH/JwBNFylFS+2X7m5YQElgY5mdXdiUxsVOuxkUVdN1924HbUukx9JJ8V+1XqzsV6gCpxUg+2eJmVUu6p4UQttvabWcRuzE11l1awDIh55OWnBp9l+e/7WsZyjHagGok=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by OS3PR01MB6087.jpnprd01.prod.outlook.com
 (2603:1096:604:d2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 09:18:52 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 09:18:52 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [cip-dev] -stable testing
Thread-Topic: [cip-dev] -stable testing
Thread-Index: AQHbFZL/wx1Wcc1WUky+/bpYJwlDlLJ7M7VAgAFmAoA=
Date: Tue, 8 Oct 2024 09:18:52 +0000
Message-ID: 
 <OS9PR01MB12389B4C51395BBBF26443D41B77E2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: <Zv6TWPUWmre9eyXh@duo.ucw.cz>
 <17FC29ADC3AB3834.19835@lists.cip-project.org>
In-Reply-To: <17FC29ADC3AB3834.19835@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|OS3PR01MB6087:EE_
x-ms-office365-filtering-correlation-id: a2f21ae2-52ca-43cf-1cda-08dce77a3a0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?U6no1xS+DfVgtBltA8neT1WKBtAIHRbDr5BNKst1K8GGVctgwvbXsQE2?=
 =?Windows-1252?Q?CTwNZxcdKtIBqYeFwabchZIQ4wv+SurSHLFdqfEY6TvKx/O7Ypex3bmW?=
 =?Windows-1252?Q?ap6+yV2klMCROBK6EuM9OIp5R8iw/GW8IJsfwvxWJF/oeytVs5V6Wduf?=
 =?Windows-1252?Q?MwbkHtWgPD7DByZhoe0272zmXTvO7TIss1Wp6OF2EFhg7fsPM6aHN6WW?=
 =?Windows-1252?Q?Lv4e3V7M4FIFmBeTXDicFUfzPkn7yDPBFM/WX/YN6Irj6R7z7OLeRZcS?=
 =?Windows-1252?Q?oVFAQvb9Bps1olonLVEMB2op26WdsP99fw9iUZDyuVKzGQ7OailbKhAf?=
 =?Windows-1252?Q?qLXlJn3Ouz8uoyYLV0URNfZhIU4br43hcd9RuGYHoFufQr3Vf51HkjrX?=
 =?Windows-1252?Q?mo8B06Mtr0Zq9+jbqWBYo3ZYiAC8ICHyEBHjE5hgfk+oFxw29RhxmF+2?=
 =?Windows-1252?Q?Srnxr21Um8uEU6SNWHsvs+87PAfJhHzICrGjkYI1m5bUzzGSfOI5dWXB?=
 =?Windows-1252?Q?Ey8D5ctuuWZSMaEbfchtR5zpLMJBBispL/OZ9BVkC5YVjPwOQ3RhUIIs?=
 =?Windows-1252?Q?8GfEiWJVVUICLlgolt+V+zE9uBDGCYdv6lxPOOh75/5qWO6reBXGWkBp?=
 =?Windows-1252?Q?sAm0u0iAofo9cIBAuEZDG7Q8cVlwL9dCOML1D5VaSMKgp4KMOvYujxl4?=
 =?Windows-1252?Q?ZVthhH0XJR58Xm6jpUlwxs0n+LOn1K9HuAAHKRENKjiMKaXe82iSUBMw?=
 =?Windows-1252?Q?T5tOxboJA8wqiPKalOC/Er24Jj8UkCEvdJExy2azWEPdAd5ehscQG1Xr?=
 =?Windows-1252?Q?UIcfe8F5yVtJlSAXGEsAcd9h35aWB+odLChEAYmdlzGRBLMPNS6f5GIH?=
 =?Windows-1252?Q?QOzxlRJUUx63XBAPFrTEO92fzDQp6++ODJfx+tb9SUQMmlnKJhBt3Q5F?=
 =?Windows-1252?Q?MSI/b3rOjXK7i2Y9yTnWIOxhupLFUgPHwDOVoAJX4KR5rdZl9nhRqg9L?=
 =?Windows-1252?Q?5NpaSDVISFHHsdXAh30+848GIXy3DjPioxKhfWTUC3LFlzS5TXeB2aF8?=
 =?Windows-1252?Q?yCN1NtCmSqxe1UOTcZR6mKro6iiQzbaTGPjvQW3H2lmeVAWxW9qyAHPZ?=
 =?Windows-1252?Q?0onk5oskwSohPIQtQ8+mhYqRaOU4T9lwY+L3GLUxdxVp8fmk3RYS2Usk?=
 =?Windows-1252?Q?L9GJKrDuWj2EXFCOv4geHOATeQO7qWq2I3BPgD+r2wG7SPzqfcRYpuVI?=
 =?Windows-1252?Q?RDO6okt5DZ2xvPnFZUnYvXL54KS5Tmx3NSRQIvJScoZwgHZop2Dh+0N2?=
 =?Windows-1252?Q?T9tcOwO6ftujMjxK/RQ5gFNo1nB4AcfHHbwHzz2RDuwAjOBbmqqXC70o?=
 =?Windows-1252?Q?KZlcWtrQh0rLPN9uhf7rAaSeg4t6gNjfsXe7OUdxqWgc8gPN5iwY/N/g?=
 =?Windows-1252?Q?LbzMFoNj8nfOqDnd26r8Xg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?Yb0oyFND0uFXgZm0vUdUfMyUb9cR7JAZAlq23Q92ZSBRsM8DhJT+P7Pq?=
 =?Windows-1252?Q?yGmJTnYDSULAQZntSUogcp4ZmFjMU30nNPYYPe675npCKHRODcOJDOcg?=
 =?Windows-1252?Q?+2zvKw2leoUN2P044IWFS3svnREVyxVeEC71vR0lL808QebkBpULehgS?=
 =?Windows-1252?Q?WQbeEVhM7y4iDy20kb7DsdtgPNtNuwjOC/4izKL6AyAsTLkGNItr5YkG?=
 =?Windows-1252?Q?dbbPIb9kw1OYCcZ3GaAh7tTPWvkeidHii7SdeCCn6xBG5K0ohSc6hq6W?=
 =?Windows-1252?Q?AbhmsS8EcyOz59yXmHCewIugSSITmY2wFMswezwsGzcfrTiK9tBspxI/?=
 =?Windows-1252?Q?jf6trudzNjgbI+qul8LA8tYBhtxbjsxy3dXYbynN0ypCpeKygRfLh/Nh?=
 =?Windows-1252?Q?HhL4G/wnqisWygrx2OcZ19cunq4HJLUJ/uOxeZ9WRb5ffje8JZltWvHh?=
 =?Windows-1252?Q?jCj+XT1p9z1RsGTO8mz2Z/C1ZXwtVoQY4GbToMt9Xih2oVf1FKmS8HKu?=
 =?Windows-1252?Q?IPtulAOg3y1SBNsgeZ/OyvziC7EL09aHLFaHdZo49dmG4/riS9fLTDlj?=
 =?Windows-1252?Q?hsgc7SX6WrCyzKT4iZQW1/dQBZ/O4rB7NPUorllO59N+jos7RhM9Ax74?=
 =?Windows-1252?Q?s63zdLjRZhMUMqe8PkAgMLa65Hqvnbaye90qr3hhF3VqEG3owwue5ru0?=
 =?Windows-1252?Q?i1rm0ovcP/+GsYSO1AVI+WPjsZLFEp9pS6iPleXiXDBnshaUNtZoXW1A?=
 =?Windows-1252?Q?gcXOtmbwaO3Kyf0wo6spE/tBiCIRkv0CyNdat5Zzv8IsUZppEwV1aC39?=
 =?Windows-1252?Q?y5nNUdcneybVgwG/iU/l5C2ICkeDkDOTBIoOmUVxyt5h5z56O8JLweOm?=
 =?Windows-1252?Q?7jeWBGzDgDGeJOSpl56PefijjSDttdbpMYZM0bSt9pM1+oB4nXLftjug?=
 =?Windows-1252?Q?LgTBtJF+/AZfXGIOBClR0WS2dYhnmESP1XHs8r8qc+vCk1KNejZR+2UC?=
 =?Windows-1252?Q?pTXhP/tXI2BMzlEmK6mekfH2o1Ae7XWKSuiULk2V1NC87gCnkXvCC58D?=
 =?Windows-1252?Q?dWZoaFM9o6uZZvBct1AG2b5LV2YxwvQbQS+xqWAdXN9m2zOQ8EwZ2WKl?=
 =?Windows-1252?Q?hMGRB/PmzpQjMkIycbFsKuGl5Gw690I116aPJlcDGiwq7GFp6wLKE5GB?=
 =?Windows-1252?Q?Uhopu+tVoAYU8lkJE3Jv8BDbqvQYk5HeUMw0ZQCL4KYd1vDo8HlIfbmS?=
 =?Windows-1252?Q?f0iW6puPPxmivZqOIZbw8V8+n2QHet4z6FpJQtjAk4d7GbNxBAfkFyAf?=
 =?Windows-1252?Q?A9YJFFNosHYXhWxmSNieTVuMYY9eqUdbLtIPthLU3TkXmA2pUAArzqyo?=
 =?Windows-1252?Q?ZINAD/YLVgwLN+RXSlsz3NCQ1+KVtovBhCyaBK9UbvP2/wxmRxGN4n10?=
 =?Windows-1252?Q?c9m18GPRUSWyJHs7MfcwSANSCUSXRPBh6velFfgDRO4CLC4RfhmKJWyJ?=
 =?Windows-1252?Q?4J0F3/OckxEQ+UdgsendmlfihQy+aBlMeBNq0JlVXvtXuBgBOHPxDVTE?=
 =?Windows-1252?Q?YAFhOAZVVJ0+B+64dhGr3LhBuDeGjLyLE45xKK1+k4VzF1UrIK+QDu3J?=
 =?Windows-1252?Q?g/o7Ep+6zTbyf+NT+wJjCqhlBWF97FhThtURKi5ihirA6A0z/bLLQNGs?=
 =?Windows-1252?Q?rkfH14LdGlOKv409f/tXPD1+mKV4q0duxe9snlQQiZ3kPvzhygxLmQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f21ae2-52ca-43cf-1cda-08dce77a3a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 09:18:52.5635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBEkmA896q7Fpvj/Z8NxZnc7+A05D3UsIzJ0sCtQ1+uFj2k+gVm280liJ7VwDbQO57JZ/yXdfWQXMFKkgkr2O8IHT2u7U17wGAjXDNWFLo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6087
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Oct 2024 09:19:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17015

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: Monday, October 7, 2024 12:56 PM
>=20
> Hi Pavel,
>=20
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Thursday, October 3, 2024 1:52 PM
> >
> > Hi!
> >
> > I'd like to test 6.6.54-rc2, but it does not seem to be mirrored in
> > gitlab, at the moment.
>=20
> Our gitlab setup only checks for changes every 3 hours.
> It ran shortly after you email, but I assume you've seen this by now.
>=20
>=20
> >
> > Plus, would it be possible to start testing 6.11 and 6.12?
>=20
> I've created an MR to add the kernel configs here:
> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-
> /merge_requests/104

This is now merged. Thank you Iwamatsu-san.

>=20
> Once merged we can enable 6.11 & 6.12 testing.

6.11.y [0] and linux-stable master [1] (which pulls from mainline master) t=
esting is now enabled.

[0] https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es?page=3D1&scope=3Dall&ref=3Dlinux-6.11.y
[1] https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es?page=3D1&scope=3Dall&ref=3Dmaster

Note that for some reason when our setup pulls the Linux-stable master bran=
ch we're not getting the latest commit (Linux 6.12-rc2); we're getting a sl=
ightly older version (Merge tag 'rust-fixes-6.12').
I'm still trying to debug why this is, as it's working fine in my local set=
up.

Kind regards, Chris

