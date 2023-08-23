Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C621EE49B0
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 09:59:06 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.128])
 by mx.groups.io with SMTP id smtpd.web11.7996.1692784742378206857
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Aug 2023 02:59:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=DV7ceTbK;
 spf=pass (domain: renesas.com, ip: 40.107.113.128, mailfrom: fabrizio.castro.jz@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHanbCZnkm0msrggKYHZji3D6cLTVlVY0Uj6kqsw270Q1FSKN97EDPcEeTWav6sP5AOxdKWPBhZduXa0sYTHXByUIaRihSte7EbPk8/Qn7lRaDiE1LU60j9g4r8PQIxr5Q2IkTHF0QNbf1ut/BxOWrK6qlVgPE/xD/Fr3mkZkRfEfI45/SN5lJFoZzNsbqGQ0gkMVy6vhYKPoODuNpMAafjVq01z9A3tfRKw/Zv+JwnQTUMc1Vts7S6H/eGSmh4/gtrlBdzH4dxBzHp8nF8E5xvfwKZmj6iV4YQN8FguZkI9FP+rtcsJMH5rfB9FqtiHp/jERjGZ22fMCEtb9TD4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UMkPxwduCn0DjJFxan95KeFuyoDQcSP5XpiqKYbIlQ=;
 b=TvaeWibHaHVBgmZqYih9aYt1I3JGxUFis2Ah9eoitPmt7B5Dsn9XDF33N8kZhc1Plyj62xQ5sl1dZkx7oHGrUjecguo3AwFomWixDZ+dZwWVarftHx8fxrV/X9fTnLrsg7IqdJzkVf4vnf8s7+4HsU02scnK3FcxEOeyA46yqMa2Ej46iH02CMCkYsVjm8VFmUohB80uYNPiIYbtF3lypx2VVQsuJDPRv1hrdhuTCHqVnSb2Gc00pbAlKV0CB6FNsjDJbZ+/HEpMaarTKpOTNs9lipTQk3jisM3wlNMLCM6G/uYZYQ7fhqA1sxR1fbNu+LtzHh3gLFj+3pk2FZNbyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UMkPxwduCn0DjJFxan95KeFuyoDQcSP5XpiqKYbIlQ=;
 b=DV7ceTbKyepuAhP2nntvkDppC23z5urdsXsdOmSY517l4uXL11p3+9ggeOfRZOfaiknbQBVZo7iPgWIAArKjuxghXm8zwWxGjTEQHhlCXJw0lj6REk7OrjtgpxsiXc7wiiit9iAthtZKAkQjGXiSsmAy7Uft4AuopLUI/8uQhyU=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSZPR01MB9517.jpnprd01.prod.outlook.com (2603:1096:604:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 09:58:57 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::20b:248d:188d:a7ec]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::20b:248d:188d:a7ec%3]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 09:58:57 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"biju.das@bp.renesas.com" <biju.das@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Thread-Topic: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Thread-Index: 
 AQHZuY0J+7CeCYEopkmf+IJ+KNnWna/CbewAgAADHYCAMjSlQIABqbkAgAACKLCAAXbPgIAAFUXA
Date: Wed, 23 Aug 2023 09:58:57 +0000
Message-ID: 
 <TYWPR01MB8775C482AFA4BBC4E060DF96C21CA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB94206BB60C37FC05D49F8641923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZLkHg75tYMjt6rhq@duo.ucw.cz>
 <TYWPR01MB87755C152C51606BBB7FC52FC21EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <ZOSKNusPvGn/Huuz@duo.ucw.cz>
 <TYWPR01MB87751FAD44B308A8317216C9C21FA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <ZOXGb3YJEo3jCtQI@duo.ucw.cz>
In-Reply-To: <ZOXGb3YJEo3jCtQI@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSZPR01MB9517:EE_
x-ms-office365-filtering-correlation-id: 090061cd-ab17-4932-fc48-08dba3bf9185
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 X0lPxjdhCaLsu6NZ+UxSRbwt52ENRzX1xJ/iB7l1yowtZRyGdnj79WHggYGSAZZD0/ietxeG1VPy45BP/MHvaNlXZ5cw3WngMROHFT6WeKNr8cQf/e2iqp7u7T+UnCE5Tg3d1NzVFAVDW8b2Nsi5tPwwL6Ra5So8M2eWd5n4rYb4NDLB1YdZLri+BSCtE8j3D63wF7jyVbu8V6Xe204Id45pujTeNeQIEPlitVoY1rVEXk7p7N7tTX1wfj7SxIdTrDkuNvpwwUndsFFDqNJJC3/y0ga/tebZ6ycMbwdb/oeLrHnck4ViEEQ6JgqfNyeSO87Vggj0IoOG+a7DCgx5mSUgihQrbQppb25Lk1KPf3/CN8f9LBjzsLrwvoe0Il+Iuh8EDScLLIAHNDms+ti3DoOnYfd+jaxLiXRJenwVIMcnkoFVogYe16hX1VV+WXG05vM84iZ735idBMUKXFX1YfqhlGZenGReV3ZatlMZitAY0oWcRjmfT+WMUDGc0zcOl0Y0HDSmvHXbexpt4Xi2ytKrCGt3vtn65Hl83uosnp1vY9/GAEQFa8TMgPdKCcucgPv33JVAlKkD2Ud3S5gSJuGWNXYxVIg6mgtOe5eNCv3X6SJUv2zoQCE4vlxswMla
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199024)(186009)(1800799009)(52536014)(2906002)(64756008)(6916009)(66476007)(76116006)(33656002)(316002)(66446008)(66556008)(54906003)(66946007)(8936002)(5660300002)(8676002)(4326008)(4744005)(6506007)(7696005)(53546011)(9686003)(26005)(55016003)(41300700001)(107886003)(71200400001)(38100700002)(122000001)(38070700005)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wkc46t9ksEkaAlRVkpv1n+woutnpwssCgeK8q/VpeydT4AgnSmrlIgGZdN+2?=
 =?us-ascii?Q?LYAKZRKmhiNkYXllLno6suv0l2CnXXYaCi5Fp30njW1oQqcuRirENKngvKDV?=
 =?us-ascii?Q?GCGjuCcHazAxM42wy2rccPkwhcwERJFBSnzCWkotLQ1/jsDx2vHyyoAqrTdD?=
 =?us-ascii?Q?/QqSuq/oO+Zhu9duBA1impYqdyxIOhirWaTmgjLjUa0QVUn4OClXLAqymuu3?=
 =?us-ascii?Q?WK6gy3JM3EGlTS3suaIrIEQYRkGKqprEuUNW9IxIb+0fjrxWHASKgaiZ+Zab?=
 =?us-ascii?Q?9WggCjAIW5Ule7ssFDdoCSIe8e/1A0CX3w18ZyfPtsXbR04v+qG0PTAPyjeB?=
 =?us-ascii?Q?TpAuOdvvefnfp/BNlo733hq35fdUqZmAhVO63YW0OpvgV1miirZmXnz5KqVU?=
 =?us-ascii?Q?IkEdlNaXcLijmQ20f4HuqRRmZOaht+PWZHKIY57qOA6ekDxpOc3b9P8Yr5Cb?=
 =?us-ascii?Q?DK+8GFDD2leVolyNBvg5JbWzFhm3MFn1T8VDAZmhOS1VzCKbq5R5Bcy03sbf?=
 =?us-ascii?Q?TGhuJBINh88Ab7oYxo6FVL9+X6GMhYVLaTOnH0IS4/hqLlEQclgct4Z2Gdmj?=
 =?us-ascii?Q?Tnkep2sdcjYE9Ffov/fYkqfrIM761IsWu91i08Iqg1U6OtUrZ4GmnWDESwIg?=
 =?us-ascii?Q?XzpOmMKJxka7rm+ucO5f+wM25LWMCJ3BqL/rVQ8+Je/20B+eqXRQA7pgtgr8?=
 =?us-ascii?Q?sXwjIPcJIK1KBXSSCHGGPJXdsv1F0LATRvG4VIxzQHiNBFuPBm7Y6tzVLRrX?=
 =?us-ascii?Q?St3dXyC51lV3Z3jOkPLM+S9vof/dazXHVGOaDODmsr+XmTcQUYrHY4Qcn71Q?=
 =?us-ascii?Q?eH+PzDbMu0kZaQmHB2klv2agrMcs4pH6uQLH20MpLPdmrXn3u0SipCFRVmvE?=
 =?us-ascii?Q?1qmLU7tXA7Gh69f0hG5/aHvdGn9bHC8CxBAmTVER6Z4pf5Cw8MV77ya4WSmY?=
 =?us-ascii?Q?lg6MGU0yNrHUWo47SX8VjfmWHnlvlieMwC4XQc9UraPc8Gayfu1pb8kjiDqo?=
 =?us-ascii?Q?Ic5ooKq5MWTe09oTG6A+3Mx/eJF0gZ+cEvwKDL4VyF4Hoi8SuX0g8+KcbgT4?=
 =?us-ascii?Q?j6uStP+GbXTmTzt8K6hZbrGntEy2vw6NmU8ANTzlS2shjt9dX91tnV+1QzOo?=
 =?us-ascii?Q?EqEssxBGEriKj3TBGV0PsWo8UmxkhVEUaHB5c0nSaRf9ZcqA0X7uBD/T/oLv?=
 =?us-ascii?Q?l2RFcTouz1TLFgG0/RS3TGAzDMvYlqvmhA+o7TpsIFcS8vJXctbng4UGTKuF?=
 =?us-ascii?Q?VCFMYg6di/0PFOypK3mWdVFcgvyqSx5V9CDDGgdSilv7o1uTT3d/YvQ+ix3O?=
 =?us-ascii?Q?BB1j4EbvBao3VVx2BhBXZU7FDFdw5nfNGzDIg2aVR5cG87akf4guHVZyoCJe?=
 =?us-ascii?Q?SSEpnEUrZRasMGD0Dm/CsFgu3UXDabBfU9t/rIBUGl5DcP4R6tbggmma5yzh?=
 =?us-ascii?Q?O64PDNr4UKuBP8JEyZ9p2ucjd/Iu7tV1tsnxxppgbLn4UtAOIM/vjE5Z0teJ?=
 =?us-ascii?Q?8CgoDjxhQQPEWj33Uig13k2bmFV1CGMIGbrezNRDk9cSBLO0PmUB0U78lLw1?=
 =?us-ascii?Q?UwMOwm7L618zijCWliIAhI5xYu4Xf+pqjfuZriKkT5+dkBUpFr2ODiyPvwvD?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090061cd-ab17-4932-fc48-08dba3bf9185
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 09:58:57.8157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ey10VMknWT9++99jokLfRdCWKOdIPlxd19Ec3zEEhzwH0Ut40+4clDF3084Tk9DnM3FVl7rHtaVA2rInosG1QnUzz35QahWO257ltvDddY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9517
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 09:59:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12836

Thanks Pavel!

Fab

> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, August 23, 2023 9:42 AM
> Subject: Re: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
>=20
> Hi!
>=20
> > > > Patch "arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC
> > > support"
> > > > is found in v6.4.
> > >
> > > Aha, let me investigate, it looks like I got confused between
> > > different patch series.
> > >
> > > > Could you please apply them?
> > >
> > > They were already reviewed by Nobuhiro-san, let me take another
> look,
> > > test them, and probably apply them with the other batch.
> >
> > Thanks.
>=20
> Thank you. I added Nobuhiro-san's reviewed-by and pushed the patches.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

