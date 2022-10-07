Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED423C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 10:01:13 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.128])
 by mx.groups.io with SMTP id smtpd.web11.2790.1665136870976583529
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 03:01:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=g6S2jBca;
 spf=pass (domain: renesas.com, ip: 40.107.114.128,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAfviKhmqEPlBuR+/Krc4eFP/m7H7zJYZGxe5/nJeS2ExpHmWpGQPV56ghQA7iJyEvXscLY7KuPER7+Q2vweFvQobU5NCrugX3NJpJBDyQXLrbtdFFbP3NMum7TzMPZCeqx7eNM3oq9qEjlE76800TUJ1bB/LcAFYBQ8arYKj9cN/EMK+eWzvrbj9M6d9v5V7sWuWPwv3h+BL4zM4fpqsj85Rah63DfgmZnomxMAC4MafsV65QxQBDEoyVbYgOQ1tbaENMaTkYGCk7JhLX6RmldWyLO9Z7Z25rlBynJwe7PhGXj0WRj1XqbhDElP6odqlSUXTRAXuPfqugv0ljSkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCvPKNih56k833an+St+cHTKFG1ibCXGlg1WjsTXDGM=;
 b=HDN2lq20/d7ueg5v4FRloGlFTgs31TAS3401jlmTjZAOnL12b6h03m7L7Bbq0+OzRz88i695DOBxC1qGtjslCa5yxXjecKz3sNMiQL/bzVG6Fo6Rzg0bvW+19TnHbZF3CMQYgLMSN+ZEYzK6roeWFaYs15Awyw3fHY0uV7V7/YRhC9rRt1YaJWcMpKTKw6EEZ1wq4w7E52xNXVkldeX0gFx3XZm38IkNE85UfgN0WpCuIT7RY12ak2++x5RW0ZHGzRLp146RJsrnELd4SFAP3FlVAVYLAm3WkvCWfJ/nzVJoo989RihCWAxE+tMHdBygYtYKow48W4elFilIzlJzag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCvPKNih56k833an+St+cHTKFG1ibCXGlg1WjsTXDGM=;
 b=g6S2jBcaPyJRwkfaMNGmjjUbG1jq5pqhgq1KjAFwMbgslmwdqU+vgoJQGLCIvgYK5Y+4FnsQ9FuvNa2jGPurtDRld7rge7JDQ/btr0cyUpfXd05jPhCuRcj5yWJZeaLDLQAMNDy1QTubEL0/UYD/nv+UF1I/XcIwN2O2fmFrVzk=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TY3PR01MB10015.jpnprd01.prod.outlook.com (2603:1096:400:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 10:01:06 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab%6]) with mapi id 15.20.5676.039; Fri, 7 Oct 2022
 10:01:06 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Michael
 Adler <michael.adler@siemens.com>
CC: Pavel Machek <pavel@denx.de>, "alice.ferrazzi@miraclelinux.com"
	<alice.ferrazzi@miraclelinux.com>
Subject: RE: [cip-dev] gitlab test failures -- job failed ... pods not found
Thread-Topic: [cip-dev] gitlab test failures -- job failed ... pods not found
Thread-Index: 
 AQHY1LqD736Cemy9y0G88cTlOE3pAK331CBwgAAI/2CABgYSgIADZwiAgAFAkACAABeR8IAAEhgAgAABeBCAAAahYA==
Date: Fri, 7 Oct 2022 10:01:06 +0000
Message-ID: 
 <TYCPR01MB10588FE1F7EC3378E1C42AA22B75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <20220930105048.GA19081@duo.ucw.cz>
 <1719A05389EC9CB2.16804@lists.cip-project.org>
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221004075301.etgur4dyb5dtrcct@backstein>
 <20221006115033.GB21855@duo.ucw.cz>
 <20221007065754.fysie7e4j2bvrvck@backstein>
 <TYCPR01MB105886D9FCFBCD0D2338B3037B75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221007092700.itoos26inn2uz3gt@backstein>
 <171BBFEDD39FD303.15379@lists.cip-project.org>
In-Reply-To: <171BBFEDD39FD303.15379@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TY3PR01MB10015:EE_
x-ms-office365-filtering-correlation-id: ed979c05-68b9-43bd-5eb8-08daa84ada0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZoIhBI5utG4yyIZn11609iFI5cJ/Yx1Covy8sbYAqXPjglDbo7smg2m3YtjBLs9/JzZFQYtFsbG6j8zsy9cZXonD9U3pIptAJKHmD5XjrUJL8IrUJ+Z6qak2SJ1JBRq6cfeIfJ+V7K/gzAFec3vHzcxAX500z1HR6Nuv0hcjXU19ox0NjAKu2coyitbbN6w4xGFPcMg0NJNU+nGUeTIXotu4z0YRxX39uyguxNJHIdO4SLtQKZLqWDCi7A5zKrHhDegzoM1nhQr7BxFTvaHjzA08rL6/wJvN+G9c5ODo1i94plvnltbrsgpF4PC0Y34z34BjJcsnZ5UfwYzcZd52FqGgTHlUzZSEKvNKbbrgJIgUS7oI5YfFfY1ICgWmyCzboYHTaI5/hiT6sCbvRK0LcTO7t23hs25OY/Jv9hxKAN0V7ylyN7tEzLO+j7Pq1XsZcdeFrwhUymQ2Wod4EcJdghuT2b/vOzXQXFHxgHLL0neehUUkQixdxOV2aZhS5T1TEarc70kfM2QYad/jE0VqJzNQ7O+k8yZxJrrwua8r+NR9/ANpEtnYS/0eDZb+36WYJA7NuKiJVeMLiJiwPpqLdg75EtZQdv2603TkH3TSRzdA9b47EJyPrjSQILR3Abfp+eAir2LbEze6HbJnF6TbKiAw+A3mnOa9FEdrzi/M6EDT9Rl7OYdVkXPbq7mFg5aqbnFkD8eCZsV4kDqHssZmvBVxj5LXEMiEFo/RGGfqqB3izHzZRNdQSb75cD6BgJeQlETdROSkfEJfVAtawahNyckvw0J9IuuklVOxG6zx4PA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(966005)(55016003)(26005)(7696005)(9686003)(6506007)(122000001)(38100700002)(186003)(8936002)(33656002)(38070700005)(5660300002)(52536014)(2906002)(86362001)(41300700001)(66476007)(71200400001)(76116006)(66446008)(66946007)(316002)(4326008)(110136005)(8676002)(64756008)(54906003)(478600001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?smghQmeNA/910fKlBuzVXhRX0Tb/NRVFSUqIO4sg+YRa64pVD9fCb40l?=
 =?Windows-1252?Q?6M4icuHg1P2cgIUpnvQH8Py8vtR3w6iaT3DBjGd5izlDCQ+IOVVA2Q0R?=
 =?Windows-1252?Q?fjEhitDc60sEG6cjeqtN7WAJPMBQxyvQgVQCzUIVTYp+wWdZQi7mbkDr?=
 =?Windows-1252?Q?Vd6PphdnICgmosHS6eMEkgbQl5j6l7F0xsSED3U3G3xQAZ+C3ioPzYyM?=
 =?Windows-1252?Q?O5PgdKK/7fPGQ0CTn4fk4y7k+L9Lc38Q94sm2r5sG4CO9o/1N32HZKDE?=
 =?Windows-1252?Q?F2eDGWvZdlkRcvqr+LBuvWOoblxmbPE58FDwf9/gobob2x2TlKOsdAh2?=
 =?Windows-1252?Q?b2ktu6b3lGTcZT4xijHNJMAHZdLuyZ98c29muH9DOJOZfsHhquWNUwZW?=
 =?Windows-1252?Q?+YPHT3evXsubRBQbYc0/jNQjViwKHaInv3bYoS11E3o3sYET8NrJdKpf?=
 =?Windows-1252?Q?LtsWHtpVeDqjUllqVrjzGb3NBsUbbp1qeoJc4yDmCFnbJBpbip10ZIf2?=
 =?Windows-1252?Q?vKg3wYOObCb5FuXyAzbaSrYwFiXizMggxgstMPiPmzceJX6jzlH5sxXZ?=
 =?Windows-1252?Q?IC1c86DDssXIk2pHIU91+9u2y96wL6SUWy2J55xzHouqvghiZ0nAqnF5?=
 =?Windows-1252?Q?pgtaNuPm40Elt9rJYehmPJ4W5n2ysO55VLgZBx4Yn4yKLN+xiYr7wx9B?=
 =?Windows-1252?Q?g+k3hpaw/GVfJnahEifsBuGdm+kmXla4PUznFtKmNc2MayrUssDyfGwq?=
 =?Windows-1252?Q?DMaBGwJDE0Dyqx+uiDRcp68G+rUyrQgJVxZO9L3tVuWVkW8Yhy21SCvL?=
 =?Windows-1252?Q?uptw3It6tUipt/wy9VmBl29ufgw/U2a9g1JN0P8wQF7Tf6jXMb4lMKZF?=
 =?Windows-1252?Q?a3hOOFabj6bTonSxH5rY4eJ1+xa0dgrdU/TwY8VCKzsoGbBvp+yU+BXi?=
 =?Windows-1252?Q?fB7hiPfyHCE5G7ckovW9yAKMOLQT3doBhMtvJxZ+/w2mk9wOkOgqBUKh?=
 =?Windows-1252?Q?Pa1ysPQBLOleJOHlYA7VxF4dziDRDCRVYucnREvLiNw45RYlmILTa0Gf?=
 =?Windows-1252?Q?zg4vLUHBnjdAHvjnEOGALowitlpB85F843vGgm2nl3J5GNs9Hzdh1K7U?=
 =?Windows-1252?Q?thzz2oHr6SWfbjOSR9ADMZa3+sin3U7P0OIv1tDCU7uYL+mDHqL2sj/8?=
 =?Windows-1252?Q?/9uEDrWzqyobbBFxpkaWtkmHVqHG4nMeBXhnzWZU0KYhjoV2ZILk1gKt?=
 =?Windows-1252?Q?GOAYjh80DTYBfaRVex58StRPVoOCCPTUitpIn7ex6Y3q2Ef4pCORgDXr?=
 =?Windows-1252?Q?OV607T1oknSB3wNyVQvZ/Wz9O3oM82JCjtoEmwpMv93eBV554gQqCISn?=
 =?Windows-1252?Q?uk0++VdTxEWv8WfNpF/DAcu8kX7ekVN+7+e+h9Nr19o3l13LO0yDBiVH?=
 =?Windows-1252?Q?e9/j7/6hnmwAw8o5hkll1Jggj/jyTiCJB8uuVyx9jeYy23Hw+Zbe/GX2?=
 =?Windows-1252?Q?9YMzPZRSoyw8B3YUeedQsOhw3UhjWloalf1xx7lefP1JIVftBew8vnpH?=
 =?Windows-1252?Q?baRZdzseGWoCjFsno7ZxaxfHC2p6APvVgiIRGOOnrHlb2Y3bAP9X0HOg?=
 =?Windows-1252?Q?f65B8FrB+vTKm1ov7Y7v//Z96k/uwD4+itJf86jhnyP2tyfCmTLsgXeT?=
 =?Windows-1252?Q?hOvNe2+kq9d0dLzLaXr9Tv+ivJMnocI0sBzGYWfhBmMv0agSE7k/tg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ed979c05-68b9-43bd-5eb8-08daa84ada0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 10:01:06.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 EO6slzW1m/52MbAiXciDSWA2yr2QNyyL829jaO8ODmiM0fOHmtxvEYjDaa+gPHyBYyjo40irtiz1IwN2H5PmecBonsFSwIuIOum6TpiDgpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 10:01:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9675

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 07 October 2022 10:39
>=20
> Hello,
>=20
> > From: Michael Adler <michael.adler@siemens.com>
> > Sent: 07 October 2022 10:27
> >
> > > We need to find some sort of solution for building our CI build conta=
iners.
> >
> > Why not use the shared runners provided by Gitlab? Apparently, there's
> > even a dind capable runner (tag gitlab-org-docker).
>=20
> Yea I was actually just looking into that :)

And indeed it seems to work fine:
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/jobs/3141334688

I haven't tested a complete pipeline yet, but alas I need to go offline for=
 most the day now.
I'll look again this evening.

>=20
> > If the Gitlab runners work, the next step would be to make sure we are
> using
> > the same version as Gitlab.

Working version from above is gitlab-runner 15.4.0~beta.5.gdefc7017 (defc70=
17).

Kind regards, Chris

> > Since we're back to using the exact same versions as in the previous cl=
uster
> > (which did work for us!), my guess is that
> > the culprit is outside of our cluster, e.g. Gitlab or (less likely) kan=
iko.
>=20
> Agreed.
>=20
> Thanks, Chris
>=20
> >
> > Kind Regards,
> >   Michael
> >
> > --
> > Michael Adler
> >
> > Siemens AG
> > T CED SES-DE
> > Otto-Hahn-Ring 6
> > 81739 M=FCnchen, Deutschland
> >
> > Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hageman=
n
> > Snabe; Vorstand: Roland Busch, Vorsitzender; Klaus Helmrich, Cedrik
> Neike,
> > Matthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesellschaft=
:
> Berlin
> > und M=FCnchen, Deutschland; Registergericht: Berlin-Charlottenburg, HRB
> > 12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322

