Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1D4C282DE
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 01:34:54 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.69])
 by mx.groups.io with SMTP id smtpd.web10.47230.1741634475410814162
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 12:21:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JGtpq657;
 spf=pass (domain: siemens.com, ip: 40.107.22.69, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQV4EqRczsjvWMjtY/IZj21wcJEnZGQQuIOe03S7KXeqg7J3hL52bXp4B0pcUNERXF8KyCFeEVwHDwC7iloyKf9NMafxE5LyDQqKl2RVuolaWGtCmSjNx5WpLquex4QQ9esA3lwRsfgl/xl3mzQCZc9ZExT9RTVqQ/HoCnEcPvE5RCG/gOSr9hXGkJLhJP03sUqePVnAjjMogy9dgR4A75nc75i5jn8vVltvtJdY69nNtaNo0m0H+E43MLY6+Y7J0LqU+UTDPsGnOWWfII58mrDAol8Qhjd7YmQLam25vsm2rr7vu1iyGoK1VG+wuse4y8EbCXRolKglknTCWAmtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbZoPsd0JSFV+q5q6riNHVnS3EQMkjE11dIHPIqytCY=;
 b=uoZaSBERVwUDhuqV12auolqZxOoBEvlTLP783jqutiKrJFmd049STBQiRiPQaJB0jZJr7xFSEKaF7j56u6/G01Ao7pnAW7DDXHtzdCtjFsNJR7QcMkhq7T3slG+j1qdYORKy8Y4TAizYfxe281CMPk9YsnzfD8Zb8iU03fiDS4VAMSGTdcT9QI8All1wOyBimD13kn7Qwz63iiSLHOQxnDuOLnhCGfK8x8G6ZUaIk2SGxi6Ea7ltoLjnk6Ov/Wxx/QWJJa8ZAQChuMCvsS1VZ+nm7GBci8Uybb9OvHJGL0vIRW/UD3yiBUyggvTQaKpYfO99Q2ZP+GPEzfsDZde/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbZoPsd0JSFV+q5q6riNHVnS3EQMkjE11dIHPIqytCY=;
 b=JGtpq657slLFQyNSCFe5IJgkh8N2We0Cm26hD1UPxH6U6seWwGKNUkjGRQ7dKsvCBA6xmMaHAXi1c2ULK5ywoR4NMxjEHLKQJUUIWoYl+nueQuA4UUcq7gz8NkAzvFdYtQ/EFGrCLx4EsXL8k+EUY6seVeMZ1pnGhQAmuhoehYgiMcVL3CbdTafkZ84YpoOke5NMF7dAQi0h41p/CHwtIOY4pcumZYRtxBRI7qmfSq6Ar3Z8n0uSklOGm8ALtf1IbCpSQ1n33rBdAgxnj8iPlEPsrbyLokCWu8MYyWT1NXDFKRDHvkeSC+rFVS+jX0zkaQXL1y6ombYu7mJkJcpUkA==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by AS5PR10MB8078.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 19:21:12 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 19:21:12 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer provider that hooks sign-secure-image
Thread-Topic: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
Thread-Index: AQHbjns5YmpFem/SVkKzaVXtmh0o6LNl/UcAgAAA94CAABsI8IAF8QkAgACw7jA=
Date: Mon, 10 Mar 2025 19:21:11 +0000
Message-ID: 
 <PRAPR10MB5422A552AB83D38C445E1C4180D62@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
 <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
 <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <38368d3f-3c33-467a-8e0a-8fce11de6415@siemens.com>
In-Reply-To: <38368d3f-3c33-467a-8e0a-8fce11de6415@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=c41fb5c2-3a55-4abb-948a-b74854b20f93;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-10T18:41:56Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|AS5PR10MB8078:EE_
x-ms-office365-filtering-correlation-id: 4a496001-d715-4b10-3ba2-08dd6008b801
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?NfevjYjbr2OqmEmvgTgM355hOtSUdXfN6WjeN6okXTawygm2VAkSy0pLEx?=
 =?iso-8859-1?Q?YoCh7bxg2daXPQxCvzfj/sljIdtrnB4f9r0KOG90bkK8fSase5dkZ2LyKp?=
 =?iso-8859-1?Q?LdtUajOyaRVFyiFCv174Tf6Zy0iAd9LD0n/tEuE0zDKN6j79lnXQQCR40W?=
 =?iso-8859-1?Q?QfLnrjdlzDp7UC25kZl1G2NjnhOXsi3UNDdoe21fzygQiaIQchc3+CIkIk?=
 =?iso-8859-1?Q?ag2hD+67OL9un4EJPVtsX+1G7Cu6QoMMPWRDrLC4t7slo/Vn17nt66B2C6?=
 =?iso-8859-1?Q?DiUVUQH6noEydJfHjW505JhY1v26My05LQjrqcXzcga3MERmVWsNuFrhUO?=
 =?iso-8859-1?Q?WyploeJsi8nUygwIsV6QB5HB26AHqxc+pcZeSLRrhQTH7cI3sJFkg0Ai9i?=
 =?iso-8859-1?Q?HEAYrMCsmCZBzw59vNEN2EcdvR9JTjgrUtSgXvZZt0SLdHiPyqQqTiFC5y?=
 =?iso-8859-1?Q?1A+R+UJvPg7qUjTeu3JmvEDQM5imCQxQ8vx4xCQCSZXVzBpr4oobR3FT8q?=
 =?iso-8859-1?Q?KDOMXSzeGMqFb3C74lqnjY2ntS+NdtZzQaqr9hfTC5kLgF9JtzilDfHTBK?=
 =?iso-8859-1?Q?EL036/87aQWTAezKwtsPr5vPZli3ovb9D9rYltPT0C/FNUKBqszSTAY//y?=
 =?iso-8859-1?Q?PC02pJj0Xjwg303a9tF/fY+cDGnVRuE9ELHRzwMC+G5qILZa9brG0EGqYE?=
 =?iso-8859-1?Q?Dps2xcFIiJdUTRfPC6uMZvAEzbPwG8LSyjm/IRnfNqvi7MYYUNW5E/D4Qe?=
 =?iso-8859-1?Q?oFhOTrPrq6Hh4gpqjqHvjNWZRS3nY5vvs1j91PylkzIjwe3lhboX58/lO5?=
 =?iso-8859-1?Q?jk3mFfZc8GJuhXfixC4EXdFuFiZEeJ6pvhH2Wa/KG/iUgxUAVJrgChKZNW?=
 =?iso-8859-1?Q?ryGeYzys5HrnJPh1yhn1pl3fQCanVg0P4DDXbedjqj6B8FtmnOPb78Qxfd?=
 =?iso-8859-1?Q?uqGXWPWO7lGQTzAAPbjWgSOkMvLvEN/+DZ5OsIMjnbjGW1w7UORIXOyB4i?=
 =?iso-8859-1?Q?Qkdirue96bLQ9rR0n2ON2UVN2rqlgtmps3eB3fxIMdhZwHcd60PW62m1++?=
 =?iso-8859-1?Q?oX0SAX/emkWAMit9aiCvZq1ZVvPiQdCrUwFUMGHCDARMa6gOnBR4PmfxjK?=
 =?iso-8859-1?Q?04WSio6o9be6sFelV937Z0d+eOi7zcMp43RRoCpLGd4Cdvc7gXCXpSwxYK?=
 =?iso-8859-1?Q?6VfLGieNrZOYeVnZNjIenmOItx4S+/UA94ufGBiMMfovDFmSoSNldJ9p5E?=
 =?iso-8859-1?Q?tu8/HyB2dQW+yVIrKCjD6P9vR8ppnNbo0ZNNZdCLms82wx79OKbVxxtkZP?=
 =?iso-8859-1?Q?V60DY4GVnH+8SsZTDal1sIln6/2vPJpN1ve+4uQw97TL+7asK/19rc3q9s?=
 =?iso-8859-1?Q?mF0ydlaAwUD/MFF/ldLUDulHcy2qRxqPiKPym1PtLtm4CcqfKDveovpaIt?=
 =?iso-8859-1?Q?0+yfeMviILlye6YFjBF7mVf65BiOWTM+fqzALHmZTTH0oUJy28ntfI3g/l?=
 =?iso-8859-1?Q?KcexHBol7VOrCmuimMvOeP?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?DrtAp3lNNHQ01SqwU/II2sRpa6+hzDfdm/xpw/hIHnqXwh1kbje+YohboS?=
 =?iso-8859-1?Q?cjZKwOKZFta48jj5Z0j2k8Dthc/9AYffBSXBmybzhUuk+x46/igsbGS7Yi?=
 =?iso-8859-1?Q?cLHoif34EjceP/E0Udhlh3gFNrIpvnJ3bczX7tVTnASMv30qVVa6TK49iS?=
 =?iso-8859-1?Q?BaKk7h4fpwBFsHfPHyIG7VQNvVcFLrPwcSMycm5Lw+TrArMC0tmOnyeLra?=
 =?iso-8859-1?Q?YIz9FHa0PhGblKhGYYYOUU44FOJOJ1PTMPc7ctEt3p1Y1psJRFlOZzbLHB?=
 =?iso-8859-1?Q?LOm58dx70PybarDbgNwRhbMAQFCyZHX/7YBkyXNEVlKI/pU1+SHp02k0dT?=
 =?iso-8859-1?Q?7/kvF1fvZplKESgaWj2gPEIhULcbY78vss2bVz3Dvyv9I6D0ynnL7zKcmf?=
 =?iso-8859-1?Q?PAOb4M1p6ha4PildNGmEaeqJ3Pq7aseJTpEleAiYgK2E+O/EOAPiUfZuG/?=
 =?iso-8859-1?Q?09cx+fFnYgN94yUKFr5g8YL7XOCGvY0IG0pxURKUI+HIcleb+WCdTIH0Ff?=
 =?iso-8859-1?Q?IYcpaFrINw0u8v6dMnuR0B4gCXyViQE7W9vMZND69pJnkPucoS77JssIcu?=
 =?iso-8859-1?Q?H5ojjC9M0d6/UPLkGz6mUmRM9FGS825xLl/kRAEd71AjQuV4eXJ0xr+gpD?=
 =?iso-8859-1?Q?shz9+YOAcjgaqH3ZgF5FWWgjH/R/Oyl7/G46aeEr+VEaWR9l3Sh/n0/nml?=
 =?iso-8859-1?Q?PUWCDY/5bG3GaPWqX+41zybJAe/cORyJQgKBuJyTVKgiN585DBlsLaJLAE?=
 =?iso-8859-1?Q?J1llJcJwC4JPe9fPaH1WB73xjp76TC6k+a9FoT+RiyTE4mWIcJ7WY4cZcf?=
 =?iso-8859-1?Q?ljOl0csLEssM1WFcp8Eo62U66SKPDkfTjEgJh4+dyh6lgoRPHttScUmsSe?=
 =?iso-8859-1?Q?sqlABVwiug6PUkeBuSowSdlf4C22VQbRTTrIPzjaOzCbmer4olKp7dYD/Q?=
 =?iso-8859-1?Q?5saPeprdjmUaJBKTGNLAeqULa8xXoAUahbsCk8gm8YFNxm8KHmauwthIO8?=
 =?iso-8859-1?Q?X4ho/vz1yKfXd2FL3L/vrXHhM69bUR2QtMBbDlsWOq+VEKls7u1eLQma+p?=
 =?iso-8859-1?Q?HQf6DgFTZiFSpliuhEy/I95tNxKpEX4HMYQwfLcwqsx5Ae+5eXloWTl0xo?=
 =?iso-8859-1?Q?YbVoAfVh2v04L6NCs0BqgosDBJomJSj2z0KNmGy1mOiGPT/kZQvpXqonhs?=
 =?iso-8859-1?Q?emqqAG86rg1AEqCXHMuUDnhvGh62AxgWMJspBgk/3D06NQn5RAwt39SG2d?=
 =?iso-8859-1?Q?SD6XXWOKDtHyr66psSTcIak7zRf0/F8xFoT6XNednUwbpZCcqaPemizd4W?=
 =?iso-8859-1?Q?PQ8kp7WzsnedkT85yivi3xISvLxOdmKE5jMz3eFnmjUNkKmJUkftY6hMvD?=
 =?iso-8859-1?Q?NJxwmalI1tSo5MX1y1PbSWMszKjRSkfIa92gsCfXp//sz9z+wgvKBwET2n?=
 =?iso-8859-1?Q?FB54PJ+ygFHyjeDqEBDPJ2g0tjpMvMZloXsJkWRh+U63Fg5eMkEGvdk0tx?=
 =?iso-8859-1?Q?3nThdqd712N239BLY6pD73CjmNfHESrdUNgQpc8TgPB9G02tQ1/PTmkcQE?=
 =?iso-8859-1?Q?8ClGSVG/DgprEoSU71wJCHvpjoeoKs9X2xCJc1YKJ8M6PhIDiVwYnc9r4N?=
 =?iso-8859-1?Q?0VyEqBhPm9He7eCguaDbMuPHM05saEoKC+?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a496001-d715-4b10-3ba2-08dd6008b801
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 19:21:11.9537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esFhgi/cw9d5/puTVpFq6T1P9CC033vN8V5pOb3PY0sAgs+TO4P6vy5ErE+fLIVrhQ+16VclLuI6sENMpDC/DYhE3xbhzbXT9Ho/0lfTqns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8078
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Mar 2025 01:34:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18080

> Things I would change:
>  - ebg-secure-boot-signer -> ebg-signer-pesign/sbsign,
>    PREFERRED_PROVIDER to select, default on sbsign for now
>  - secure-boot-secrets -> secure-boot-signature-provider
>  - secure-boot-signature-provider should deliver all what is needed for
>    both variants: certs, keys (where applicable), core signing script;
>    for file-based keys, a standard core script should be provided to all
>   implementers

If core signing script would be part of the PROVIDER recipes, maybe, first =
thing can be the fixing of `signwith` parameter on the wic plugin, as it is=
 already a customization layer of this chain (as already done with swupdate=
 class and swupdate signer).
Or, as you stated, I agree to have both tools available depending on the ne=
eds, and until we experience pesign for a while (or other options if availa=
ble),
we can just provide our core signer script from downstream and don't use ex=
isting one as there is no direct dependency to it as of now.

secure-boot-secrets can be revisited, providing only public certificate is =
still possible by implementing another provider, but making SB_KEY optional=
, (or separate -key provider package) could be an option for reusability of=
 existing recipes.

On downstream, additionally, we use secure-boot-secrets for signing out-of-=
tree kernel modules (by providing a kernel module signer which depends secu=
re-boot-secrets),
so I would prefer to keep them separated from the secure-boot-signature-pro=
vider package.

Many thanks.
Gokhan

-----Original Message-----
From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
Sent: Monday, March 10, 2025 11:09
To: =C7etin, G=F6khan (FT D EU TR C&E) <gokhan.cetin@siemens.com>; cip-dev@=
lists.cip-project.org
Cc: Gylstorff, Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to sign=
er provider that hooks sign-secure-image

On 06.03.25 14:46, =C7etin, G=F6khan (FT D EU TR C&E) wrote:
> Hi Jan,
>
> I haven't had a chance to try it directly, but past complaints about usin=
g OpenSSL provider/engine together with sbsign's OpenSSL3 support have held=
 us back from maintaining/implementing an custom OpenSSL provider for serve=
r side signing.

Would be good to have that a bit more concrete. I suppose there is some ove=
rlap with what was once done here:
https://github.com/phrack/sbsigntools

>
> In this scenario, pesign is used only for import/export of attributes/sig=
nature and this feature makes integration with other tools much easier.
>
> Since I observed similar signing patterns and toolsets being repeated in =
different projects, I thought we could upstream it. It is still possible ho=
ok different signer recipes/scripts in downstream layers by configuring it =
on partition's source parameters or installing a different signer recipe so=
 this is not blocker for us and could stay in downstream.

I'm not against making users' live easier if downstream has common needs. B=
ut the way things were modeled here are not clean yet. And they should not =
(yet) simply replace the existing sbsigntools path - we have not enough exp=
erience with pesign in the field yet while it broke over older versions of =
EBG.

Things I would change:
 - ebg-secure-boot-signer -> ebg-signer-pesign/sbsign,
   PREFERRED_PROVIDER to select, default on sbsign for now
 - secure-boot-secrets -> secure-boot-signature-provider
 - secure-boot-signature-provider should deliver all what is needed for
   both variants: certs, keys (where applicable), core signing script;
   for file-based keys, a standard core script should be provided to all
   implementers

Does that make sense? I may miss some details that you normally only realiz=
e while trying to code things yourself.

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

