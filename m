Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70116CFB442
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 09:14:20 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.8])
 by mx.groups.io with SMTP id smtpd.web11.4606.1728378851323424543
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Oct 2024 02:14:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ZfLndXC9;
 spf=pass (domain: renesas.com, ip: 52.101.229.8, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG5Kyzk/tmRGKd/ektpIMvuzuGcjjSbfAYpKanFI174Hqam1ugd7OItP3gv3EH0ZR85Csr+m604Q2R1IcIafJLZcFCQ18BiNaMDGy6L/yxA8JnSDIMVXrmQJL79AkvDl9jkDlFXZeE4ROMt4ZBYrnOvv/zgWfD/t+ZSCawIpUO0B85V3JfV8P9+nC07QChSVgELXJKCfk/sveF959njCbGVqIMnzuzT/6DcF++TwJ3e+mBVKeACKw9+vqP0SlXFmtc2Duc0j/0+2jnfC3doqQexyDEPdinfpHuFdBPL7looaUTrieDZ5Onn2nh5p0OKVVQ+Sa+fMP5/mYDZTGwMulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adCuszUloF3FeLzWJVL6CjKtWBg830/UNe6cCytzazc=;
 b=tzqE77TdCfJr341c8DGqnldNhorGbwS6hp9pHdD+KEdnaD96Z5HSyw3jSnPFeZ98lIwquMfd4V7hqImt0hJXUn6bhNwIL8LXmlkGIg0egwqXzpCOKIhit/Cj+Xyr+Z2XG5ZSUWF2FHq70jHeRTxQ7ygXfoh+ttbQFxL3Bmbllev+ONzxKxCp8KL+cOovrL+5/4d0/D4LxxApyF16TZbFvOpL2cJJeY7k9zqnbWm1QfoGbbGidHBXEyBKq5oX/sOYM0xgLMWHRoSAqAgz35n3ixQJNCd7ImfaYevcJQzLd6n26GUyul+LcoGNLJ6WzFsdzimj2G7evOxqrFGKkyAu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adCuszUloF3FeLzWJVL6CjKtWBg830/UNe6cCytzazc=;
 b=ZfLndXC9M6H8QhvT084UjcM+tlg0/wkiKecIImwma+bufJGnvKZkTQhNcVB81hs6pbijja93Ohqnnil0b7kghfXiXlckEKD4ok1GhnbiXQ6yyjvYK/9HVIZqGCnlJ5F5TCn50UC8j8kWcvA8yzonkuosq51hb2h3hxKVd4CL1Y8=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by OS3PR01MB6087.jpnprd01.prod.outlook.com
 (2603:1096:604:d2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 09:14:07 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 09:14:07 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [cip-dev] -stable testing
Thread-Topic: [cip-dev] -stable testing
Thread-Index: AQHbFZL/wx1Wcc1WUky+/bpYJwlDlLJ7M7VAgAB+UwCAAObe8A==
Date: Tue, 8 Oct 2024 09:14:07 +0000
Message-ID: 
 <OS9PR01MB12389A1FFCC582BC18B0EAEB7B77E2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: <Zv6TWPUWmre9eyXh@duo.ucw.cz>
 <OS9PR01MB123890EF41652A158A7413EB9B77D2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <ZwQ1iAKODwEI7ReJ@duo.ucw.cz>
In-Reply-To: <ZwQ1iAKODwEI7ReJ@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|OS3PR01MB6087:EE_
x-ms-office365-filtering-correlation-id: 6ff380dd-59a9-4718-9883-08dce7798ffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?cgDMcUNEL8g2+8P8rv+XwF7C9YNYtKWI7XVMa7F8dLoGlG4oDFud2Pqz?=
 =?Windows-1252?Q?gKgMqrR210Pv/J7SHsEiRJm6Z+B19RemfBqNgrWPfMAypk+epvtP4/mR?=
 =?Windows-1252?Q?tq7L/dTuVq0SRIdBxh8NisTiDb5xy5lBNsOzj2O53/C0jQyopgSAt3+I?=
 =?Windows-1252?Q?u6WWxljDPkGKpsbaJumSZFRvwHMnkgZPuJspm7vdQYv9xlUsADQhkFp0?=
 =?Windows-1252?Q?UFE675dAFEwncMpXfbt/rBjUXfvusl7yVDZRT/UuGYx82tbMNs1ByZLv?=
 =?Windows-1252?Q?caBQO6QISbbOBPvwPnmzpBzr1CqFsZyeFV8GBYEdMDihixoC3h+bo8ZG?=
 =?Windows-1252?Q?EOOb8Lyb6th24rvc045nK86f27eEdzt7BdB1BJTC09FIUYM3ZfjaE1w/?=
 =?Windows-1252?Q?RriC5f7w4xrECcSz4JDd9M35rAJjRXmMVHblBtqrm0QA4vpMLPXt5FWM?=
 =?Windows-1252?Q?rxYLY8QaMW7tC24uOb+CJ/LgDe+CH2iaJEtJ8LiLuYFe0GOgUEWLkcB/?=
 =?Windows-1252?Q?yuf6cE2WASxFVJ7y8d/L8jsCNTbUT/9KW1x86/sfr9Eljtw4itAJ+NUp?=
 =?Windows-1252?Q?l+NQjiqVm0N6cvtBufqa8eAScjZ8CUIpOCSrpXiNDB3D+7D9THdFxZbu?=
 =?Windows-1252?Q?Oe0a7AnSkN1ommj2N1qRA+CDwTv8XYW/5rY5WFito/Ia+gVdAEF4Z+WY?=
 =?Windows-1252?Q?1RyvXNlAem0gLRiebLCbaZW48PKAHtjfRVVryYAq9g1hSHAifcf5K4X3?=
 =?Windows-1252?Q?doCjfW+cSftV81CDtGLwQ1gAIizj7u3Hg/07aBywYEySxE70RMNJ2mf1?=
 =?Windows-1252?Q?u2+KZzU7XqZDXv0t+v/aZxTqr8RkWykOzrdmWXkm0CYGJZ5X8p9MD4BS?=
 =?Windows-1252?Q?oQuOLtBRh7XncBpwVFjBhAxVSITYf3r5J356hCP8tpuAuM8GeiIYV3Wm?=
 =?Windows-1252?Q?RZGZupOj1Z2Jq4rvOestZ+EzuwAUsbqUaUKloJJB2R7VlECkDY6d1/tP?=
 =?Windows-1252?Q?Qw3DFSCJwwrWHbrDf2HXCbsCTBRr1K0AWzJjKqXb0+rBiQFEko/brc0x?=
 =?Windows-1252?Q?saJJcn12L88PkacOcn3sbErFFJ46/D3tpBbsozYmF3kPBP06hHSd8ris?=
 =?Windows-1252?Q?pMC7V2KAlYb4k2E9+wIRaSm/cFzMuYylEl36swrhrn+pJooZFfCv+KT/?=
 =?Windows-1252?Q?woYKILOJM3qJ11ZGcWp4SuFE2cUPlxFEMy7e7+gQzzH7wOA6if3kTIhv?=
 =?Windows-1252?Q?pLzFAaQiXu4QJ4UvRuJevg85HVuabsnc3fOfoiQ8m3/2pcPNeTvB5bdi?=
 =?Windows-1252?Q?FkH0LiYQcsSkQbGCI1abb6aDz2d3oU4H11wHLc5i7kzozM66GBwvdr7Y?=
 =?Windows-1252?Q?qh/gnyGPipLD5yoUrGcCiSTRPaGsnHZ6rlWJMtU+plo7YiT3bY0vPmc8?=
 =?Windows-1252?Q?Bwzs3B/kmgs31KWN/c32mQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?IH/vy/DWUGz/Qn954soZJm31M2KoIWY37ewQJ9cQYsCYYn6w7IEoYbJ1?=
 =?Windows-1252?Q?hxQBYISXpjT0ZK32X/gMgQ0MWxSWiLBS2mw13MfsPvajJsXFTs4rxQSz?=
 =?Windows-1252?Q?c0aIxCNNXtEFKH5z5MZY4DS9s0n8/Mj68MWcLVtxAkxzjDEBG6je8cD2?=
 =?Windows-1252?Q?srn7LVVSTWb/cImiwecKoU2lxgje2sQHqEJNivdkYkqt4WZimg9rcfPw?=
 =?Windows-1252?Q?EWARHHGFVJZZrPvJ9J/TQ2FMKmBsQIn7Tx/injQ/+i0unqk+/ONkGG8L?=
 =?Windows-1252?Q?ACpzGabyyIMaeyxCsBmNAn5knbfMgs5Q5ZIhUgsoCgO+SJGOnimMSjhr?=
 =?Windows-1252?Q?z5hq9i041AYcjXWt9M1vIbcCCq21LJ0YJGBSML1tstIg73BLbeLWqY5U?=
 =?Windows-1252?Q?z1f5+yKJcp+1wZ6eQBpr3p5JACUEG3bIuiOmsS+MK+XuzaRFC+mk2He8?=
 =?Windows-1252?Q?ifgxWDaJACxncSRCPVcQcSteYq5Gxrp7pAUOjDdrbmbEd9Qm6PXg/A3q?=
 =?Windows-1252?Q?bgMAaLueu9veioY6rV20kSa+2WNH0WvToo5j5EBJIw1seraqTbh0pi+m?=
 =?Windows-1252?Q?Euqx+K1fAyK5A2akEz0mOexE9Uq0hDl7KmJCHT8NMIXzA9wvb4lnxcl6?=
 =?Windows-1252?Q?68DjSR8KIW+2HKshllSkmmKczrGhzQyZnW/IWkQEFO/3G7VUy4pP0SUn?=
 =?Windows-1252?Q?TcCII/RUSepPcsKgrB1g3bW1SvHN2IgiWvPFcV8HG7DqkWcDGASo0TjG?=
 =?Windows-1252?Q?EJNOJSr7xfRTVTVNNUjoqkUvq6v+IzczTn0nPj7Utjzya7+yAQsKQhFn?=
 =?Windows-1252?Q?WuzkGx4Rt3M++K46qeQeEplC8dDbSV26vBBU8r3MMcYcAOl2seGAfyNP?=
 =?Windows-1252?Q?lSdbb1t9NwZm2rWYSZafzoNaDtNvZtnjU19KJTJE5iGQU76xZNfFvONq?=
 =?Windows-1252?Q?li//Q7Jgk9PZM8adBZP+s7xHJ6D7onOzHaO4n1briA2r946IDDmqEpXo?=
 =?Windows-1252?Q?7zo1VrM8WLD+NUKLtT74bAP1ZFmW8SuJgx4zjNYzr+2mxSvfrwSn+V0m?=
 =?Windows-1252?Q?GbA/iVVkzoteZPRz9AGrOgYDJFFrFNlZAC2pdfYbveTvjbHiTq4h1PTp?=
 =?Windows-1252?Q?WTBXzyE1e+0XxvrDHl8efcJEzqfyKGhGORZ+TwGAVIMohRXTJKPYBIW6?=
 =?Windows-1252?Q?fCu4gKGogKUseo0yoIIv3ZoVvdvmTvyq2TYRWd2XR0fklOxJmwMnRNkv?=
 =?Windows-1252?Q?I8BaBssCTECssDxdSLRn9f0wZt6/4vuKAR/vk5lKZvPtHRNF1548xtDG?=
 =?Windows-1252?Q?53wRbdo/paRFxDU4deyWFXPbZjmSQmbc8tdL7VdtpLyrmL0TFcHPDLWK?=
 =?Windows-1252?Q?+tu1kW3xRz/dOJBFdFaDPp/Ayn2AJBtv0rWGqHY3GKm4mDu7cH54XUVT?=
 =?Windows-1252?Q?Kk9pbA/E+n762dGBWicFRnXDbsJMUsmXfWaQcXLs4OL44Dwwz7k6HzEg?=
 =?Windows-1252?Q?YUCmyn8Q4Y3hgCuyj4hP+iEQ5UpOD11k4rD0rnbWwFrDCpy9faa3CBN+?=
 =?Windows-1252?Q?RATmXB8WPeZ+eHSuBgRaj7EhrKCCnrJWv+Qe4TLi1PpMj7K82dCKNtwT?=
 =?Windows-1252?Q?ZYj8jIHe1Ttmq/KnWg8kMTAVOaGNwR8vWyYS2Tfd2TIPttkmlJXh5NH5?=
 =?Windows-1252?Q?jrPS+m5sf3yeAgDk6eySBXWWA6oavh1EqPRhERX+SepLD96dexQA8w?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff380dd-59a9-4718-9883-08dce7798ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 09:14:07.2133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovolGAoOSR3grj0CXSsEYTpWSklZv3dRHoc3aVnVmB118QTfKcWKL8kelRX4fFHo/di5yN+/7HaUsrMhDw3srzzzFpY6M6JARuAkbzdUfuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6087
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Oct 2024 09:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17014

Hi Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Monday, October 7, 2024 8:25 PM
>=20
> Hi!
>=20
> > > I'd like to test 6.6.54-rc2, but it does not seem to be mirrored in
> > > gitlab, at the moment.
> >
> > Our gitlab setup only checks for changes every 3 hours.
> > It ran shortly after you email, but I assume you've seen this by now.
>=20
> Could we make it 30 minutes, or so?

I was trying to reduce the load on the upstream repositories.
I'll rework our pipeline to reduce the amount of cloning we do, then we can=
 do it more often.

>=20
> Alternatively, there's a button in the gitlab to manually trigger the
> sync, right? Is it okay if I just push it when needed?
>=20
> It is here, IIRC:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /pipeline_schedules

Yep, or you can just go to [0] and click the "New pipeline" button, selecti=
ng the "trigger" branch.

[0] https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es


Kind regards, Chris


>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

