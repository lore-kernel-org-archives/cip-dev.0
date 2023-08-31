Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B131EC83F12
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 11:37:55 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.90])
 by mx.groups.io with SMTP id smtpd.web11.14604.1693481864948853084
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Aug 2023 04:37:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=fAzAWxbz;
 spf=pass (domain: renesas.com, ip: 40.107.113.90, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3iGT07FePmzgjzCuGH8mb3Z2iku1+bCGLqXdB5mk8fsfuj5/uWBQVsMleX+mqLwlTJ82qg52xzeQ3DcmHLYsan295tobmkXqTpnDMC1kizrzhbTxgoj4+Egol5w+F82CAeY5FYjuJL7EL8F99RYi2WqVEHUVLsKKeFjSBwMeCBqFtE65llzYD5RNWAThTJdomlBOcYaHWC41ZTXUvvWA/BqkZcX1j40NZId5Nv8Wy8N8wqTJd1BikAtcwF/ayBqrKsTXRAjwmWaY6xqUS6mmZj7AB2aI8l5E6QTUQxL7YQ4G9HjGTCJqcnoxdwuXSukdymX7qQNktrFsvUydx7/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o8OjZvzWhSoDownKzhcWcC2gsIqjhXIV1YPMWK4iz8=;
 b=CXHETtxy1bHsNr0QU+oD6vS+nc6WX8iODKjnxdak4yhJ6bLvV8oAL9KMBUHklo/IXnm86CgsR7isKyol6/Z6Jzn/eQQ8SRL2m39IEvKGtr4U4PENFudA14DoXlfD3fDouYSBdYlGTNKJN4GI6nzA+K/xEeJBs3ve6mHJ4uTJdjEm0MI9AwfnEpbdycglVHUk+BYXlboHNciHnZSDZK1ICnqusRPrpm/bh9QUTMAU/21gG7U8cg9dktH31oUI4WAFm+VyDMaLm6hMmW7JBMiITTi8ynRDjaVwSGP1c+qe8iRiwyEuXwxgn1tLkKoSYHZ5/qiHY6QwWKA74/hD5NvKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o8OjZvzWhSoDownKzhcWcC2gsIqjhXIV1YPMWK4iz8=;
 b=fAzAWxbzgp1SGA7eHTl3Vw0twA7me1+pJTl+5EU3ZMWuiCWbGgiBsPAYg3aOMrWmXhD0VxmY0h45Y4N873jC4Iu1Y6J9E8PWM2BukeK2qMZ/0HDtaS3wXyQab80sjELXQvGi1QdU+m9hKaXl4TkgtzhnHq9/pU9yTCgynwqnevc=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB9971.jpnprd01.prod.outlook.com (2603:1096:400:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 11:37:39 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 11:37:38 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Problems with git.kernel.org snapshots in CI
Thread-Topic: [cip-dev] Problems with git.kernel.org snapshots in CI
Thread-Index: AQHZ0BbmHD34i/YNg0eSNmclUUl856/xhjAAgBGBDoCAASsSEA==
Date: Thu, 31 Aug 2023 11:37:38 +0000
Message-ID: 
 <TY2PR01MB3788787FC3B28A9D806A142FB7E5A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <1086cb49-013a-4776-89d1-11d372826eeb@siemens.com>
 <695be8e9-14a7-46a0-afc9-00aeb182d4cd@siemens.com>
 <b5def4f8-61fd-4238-892a-5cfae8bf9960@siemens.com>
In-Reply-To: <b5def4f8-61fd-4238-892a-5cfae8bf9960@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB9971:EE_
x-ms-office365-filtering-correlation-id: bfe2de3d-4653-474a-e993-08dbaa16adc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xfatsKYdYNThoc0SXZIE54vLoSfhehHs4PVWnFkxfdx0mOdoOaSXpV8EW/vLML5nFc1HWMGEJ/FBSu03SFs8KEivfA2PeGx3okdQJ8Vs2U7QffMBE8e/ueVlsncjyFe+Zo31rYBWFn2Ma6wr7O01N5sF1fG1UAKgs4d4eITU4AEuvIBR8hXR0V657xWveQKOsZMlanaMO3Xe4zipWSXJluhHyEAqCGgGDgdNq63NY0rlM+4iOCpLk04ecLRUvEnvfygebA788d4//LbIC2KwjPe9uyA9AjDhp4uN49J9a9KkNJoHPMyLMuyimkFyEg4u2dacNAnUVZqJB7iarMzfiyVL1SLxnxTAB0hpDxVPLLbh4g5fy/zUj/Q9kFxDeR2U2ED/N6FXa6ObWnakrMnMPWOj6O71DwLpI7aEMBGnIY7ao7Gg5MCWkcAlIqH36j1FJRAtsz4umd5EoQZqgldTt0mw1kQ3nXaj5zLCxzMe5sJfcyCnwTD75gibG8CSCAFd0t+ylmySXIJVJWNlBOYaxHQTF0AcMSorUilrYhuuOUMI4jpOQy3FNL++yTIg3R0hszFFUytrFqAANU1TcocUvWzxVHG0rCCCyvHZDTxA7n0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(1800799009)(186009)(451199024)(9686003)(66556008)(66476007)(41300700001)(86362001)(66946007)(2906002)(76116006)(64756008)(6916009)(316002)(66446008)(33656002)(8676002)(8936002)(52536014)(26005)(5660300002)(55016003)(83380400001)(38100700002)(38070700005)(122000001)(71200400001)(478600001)(966005)(7696005)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?8N8SVwF3fsEa47rgCxFlY4T+vru81lS/x3Gb86if8Ag3wuS9yRzYNgYa?=
 =?Windows-1252?Q?1ZVA5TOSVlx++1qnvrWV0/NUO2nFx/s2D7gNAifliLDO0dV7CRZcf+Wu?=
 =?Windows-1252?Q?b2GLvWz22ukJu0T3+MvVTY8Xr9veZ0py63gtrwR8V/t7jef5X59Viq1z?=
 =?Windows-1252?Q?G/HtbfoQfPHzPPTGE3tTeQ5zwPsmy0AlBV5h022NcMnlbtMCiQ2K0zsJ?=
 =?Windows-1252?Q?0sz1EkoJ022s8hVWDYge5f5LFqPJ3R737R7q8vDXnbiQtDx5watuvsio?=
 =?Windows-1252?Q?br6RlJSDEGnRNKMtnYL1AZb4UtteLGgJNdUK58rfQ6KEDYpCZjSupVvZ?=
 =?Windows-1252?Q?TUerRMWO9iZ/WoAjE//Q/9FJNbhYLp/ZttM5prh8FXXRHQCz3oKGCeVr?=
 =?Windows-1252?Q?OQ9KVd/bJSZl+Gg3nfGPOmVmD6scOWdWk3JEJkH0TaIthLKfOH4JRkSu?=
 =?Windows-1252?Q?fOCayhpvpA2gPQH5NGnVtxx/XzA+1ZfBA5n+XvxPa/5ozj2AGtmQ9KjC?=
 =?Windows-1252?Q?3wcOxxaMXe37++AqvH0PuvJb9vbAcjyIPNa8z1dtOV8L9RZvQn938+g/?=
 =?Windows-1252?Q?lzj9wmkr9XZWGKkCiLULCEPQTfxNJ64Jgo+xjEE5/VtJdXMGbLhh3ejW?=
 =?Windows-1252?Q?vlFv70WgDY16NV/DXfuUJwNfYfo4g/P8IqsjAkkVwV3Z0FllLCrAyQXQ?=
 =?Windows-1252?Q?UAM008eeAppy7vx5s79tuMrEUVckzE80ShRjA1yHNeTkIh6Ga5V6Epm+?=
 =?Windows-1252?Q?CZNm7rwowXnFC+/WMgcXX0AHFg/0uKswxgvqCtfzWf+cUScC3kkINZVd?=
 =?Windows-1252?Q?jld50lxe83rlqgjdrD1v/tnuBEw9o6Di8IIkwj/V/ArbHySCvq6yWP2i?=
 =?Windows-1252?Q?fNRiiQpdJrg8Z+rtMn5G7mjvodhZzgN79BYRB4D8RfZ9z6sPYT0qYVYc?=
 =?Windows-1252?Q?+pCnX3eCmMYWSgoQf0jcRyXAVo09bSatOrjwTWoAaNiy7gQ8oBzSk+Ez?=
 =?Windows-1252?Q?Gxjhkv7mxVmP7GaFQBTCOeuD19JzssziJ29dovy4uHR1ja3ILK12it41?=
 =?Windows-1252?Q?anwfF/lluUGZs9TetuILtF2PfYH0DzI5EY6WGSWfE/1lQJT6amwZEmuS?=
 =?Windows-1252?Q?c15FWiKW7hiyNzPaouQ6xFyooTTSKd8bbEeKOKg9WLsPgdGCVL0/RPQ0?=
 =?Windows-1252?Q?dCQRUDXTrO4mVT9XvcNUzQ15yJr9u4+63WDHej/xaDEh6LXoa85XKxci?=
 =?Windows-1252?Q?+XnoQOoNee4msy6EQcb3vGhygvO/FRwaZtp8a7B/ln5wUEgUdTcJR2bi?=
 =?Windows-1252?Q?q3QYGM00/prCkxm8A0jWg9GMXO+bW1LRppN0CZxhY6+FWIdKTL/nrapj?=
 =?Windows-1252?Q?m/4XieN2EPr0X3MXydtyFhpufKi137sd6q3wUlnq3oKkm23Dq+8nfKfI?=
 =?Windows-1252?Q?Zc1QEcfyZN9fgLpDEmCYBc04sRtnS4YNYPEHq3X+KSFN/xkWf2JkVS4b?=
 =?Windows-1252?Q?tOU+FPll3FVwMEBsdRdSOPrJSIGZfNN/fJnTZr6KbdWL0E9g8ikewHGQ?=
 =?Windows-1252?Q?RCrg9BaQmuzh9GQ7g1JwDGZCxocKDFErWgsw80bIYgMA5K5Bac9UjzQK?=
 =?Windows-1252?Q?RsL9yha/KZjHv3oFxwOw3INOxqLHwcjThShVP88p8RAZ/0yoUCIVWmiD?=
 =?Windows-1252?Q?mj6Tg8Np5aeyV4bZH4KYQdjAU7eg+CmNLuIuI1LzKu3txt7kxsUOHQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe2de3d-4653-474a-e993-08dbaa16adc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 11:37:38.4611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmnNwCY2HNzw9lI/pa5sd2uD5+zt6OSdHOShhP80qI1FURKOFO/P3xKkxcrr+iAN+y0dV+aPFTU7gqtGKuCi0QC1OjLy6FKbjsOcpMUJnYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9971
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Aug 2023 11:37:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12929

Hello Jan,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: Wednesday, August 30, 2023 4:08 PM
>=20
> On 19.08.23 13:49, Jan Kiszka wrote:
> > On 16.08.23 09:54, Jan Kiszka wrote:
> >> Hi all,
> >>
> >> isar-cip-core jobs are frequently failing due to fetching issues of
> >> archive snapshots from git.kernel.org, see e.g.
> >>
> >>
> >> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/488116072=
4=20
> >>
> >> Retrying those generally resolves this again.
> >>
> >> I think we tried gitlab as mirror in the past, but that also failed
> >> under CI load. Do we have any other alternatives? Would it make sense =
to
> >> make the tarballs as regular downloads somewhere available?
> >
> > What would surely help is having a download area - maybe on kernel.org?
> > - for ready-to-fetch tarballs of our kernel releases. Would that be of
> > any value beyond our own CI? I suspect uncached downstream CI would
> also
> > benefit.
> >
> > Download caching would obviously be another option.
> >
> > Thoughts? Other ideas?
> >
>=20
> Ping on this after we had a discussion in the TSC call yesterday. It's
> breaking way too often now.
>=20
> Options we may have:
>=20
> - ask for download area on kernel.org
Do we know that this would be more reliable?

> - host our own downloads on s3
Certainly an option. Is it only the kernel sources you are having issues wi=
th?

> - try out a git mirror (and its snapshot support) under https://github.co=
m/cip-project
We can try, but would this be more reliable than doing just downloading the=
 tarballs from our GitLab project?

> - use download caches in CI (and suggest downstream to do so as well)
We could save the whole Yocto downloads directory with Gitlab CI caching if=
 you like.
Or just the kernel tarball. It "should" work fairly smoothly.

Something like this:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/c62fced2cd86=
757aa0eebc14eedf04c203f34cde

Kind regards, Chris

>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center


