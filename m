Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B39C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 12:21:31 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.40])
 by mx.groups.io with SMTP id smtpd.web11.14424.1716553287384991502
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 May 2024 05:21:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=iGbNu+hQ;
 spf=pass (domain: renesas.com, ip: 40.107.113.40, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf74k1/UsT7jyqM48DNvDrHLYscybfEC8uvIs4oF/0N5Iku0wbA4q9/+ya8/aLwOByfJeFd7Fl12ChWe5OSliNT8i31H/dZF5fDAaz5Oznf51Cnh9ztQtyktGx+48Nfm+Or6tW8xKmMw60sT74cEvw49SZdcvIBJ4m1e09ew8ugdVga1K3la5DcYMs97PTr+/QGnVqFy7K8TMU5zdg2u8h6qYMUrB++NcVhIxRnVVXJoRFsmMpiwPIYHWyIsZZ1j+mKvIyyBGFRXKVuAgAJXfw23V/b2G/LvYj+Pj0IQQABB7UidHZeZ46WinIu3ttu3I7VTQHineVh30aM/Gj1HIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9jx3WCxzUxa+WqRd8zd1X8VIF2iAjWC0I5tsR2kRw4=;
 b=aMd7XEI9CV+WqcWK8FrZIe2iY8gfnyheMqHwyWfUfaogxDcsgvJJUKuSfOim74YXwth7BoMoZFRSiq9LsHjs6ik+xWh/ctxxrOT+jCwRp+aJhDqZMmuhEzQNLxClf8eNa3Qxw3GZ+3jpfC8IWeX9r92lXa0M1e9sZv3TRL5IafTHboH3trAIAGiYJBRuW6LakxBXxYaKWt2V5zYseOsBvGB1ZcbcFr0Jy+ASErCQhdOVBgxBVHpt9RwS0guv3w+tkxEtkcOcVtdzffNzpctfJu1Z4e1u8hyQ2ArD3BvhXLPO6WaqsN/u4UB5yYts+9Mt3N6+5OgXZC9seYqWSZHGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9jx3WCxzUxa+WqRd8zd1X8VIF2iAjWC0I5tsR2kRw4=;
 b=iGbNu+hQ9TGPuv2j2k39RfabvZrsvVEobU+LYUouyQxL1ECSvNGMkG3I9SueOLek0NbUeS4OjovLzMi6yqye0vcedG56zMqluPMUOFLGH18+w+4CcfehZSnaa4tfzY9Nvd/omzE0RXG1Vx4EXJNepMORS1TABPdnfhFJDYcLsGs=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYWPR01MB10034.jpnprd01.prod.outlook.com (2603:1096:400:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:21:23 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 12:21:23 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] gitlab -stable-rc: mirroring not working?
Thread-Topic: [cip-dev] gitlab -stable-rc: mirroring not working?
Thread-Index: AQHapuzrvr46zaW5HUiHSrZakm0AcbGmWZtQ
Date: Fri, 24 May 2024 12:21:23 +0000
Message-ID: 
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
In-Reply-To: <ZkTwEKwobEIumswy@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYWPR01MB10034:EE_
x-ms-office365-filtering-correlation-id: 5d3e892c-abc4-486a-4b7c-08dc7bec06a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?h27Lgz1ecKK43SJOf0aaUssvfMhBbFjgtGTJOrbZg+n5mmVUH0r6HD5s?=
 =?Windows-1252?Q?8UH2RRrIfF4F0DPGC2gG0hEzGaAaZLylZdY6nDWyo2G5EKnIyZQYtHcr?=
 =?Windows-1252?Q?mORy6+jSPCxDxMY32PHRXumiQRX7cGyVN1U4LrKqfamSX60x7kB8Ce0n?=
 =?Windows-1252?Q?N173ibnYH9zpYzqytdHxcVXPaFedFjL7eR/1kCZGLP+SDK/s1wK3iJyY?=
 =?Windows-1252?Q?g3kx6glzBBjza4TGinsi0ifDOon9fXum9Cc33ReR0PnrXtHkLLjyN47j?=
 =?Windows-1252?Q?L4cBgR8JUCi+7EamRhQ5EbujfpE3jsDVDNmQWU/dnqb7u4ulWE44H/Ou?=
 =?Windows-1252?Q?dVMnOHSXfCBEkBvmF+el+SjiLj1q9eUqmYInnv+VJKBC+6VwowyFmmAc?=
 =?Windows-1252?Q?81PHFm8janTKYRk8TkmVtJrnKbdrSUD2MGlTlK2h7eEdaFtogLqTdI5x?=
 =?Windows-1252?Q?CoH4btMJInGGBAcdfla5e9ct08Wkf7BlqfoNiNlTi0zX+cRjRaBFIgAR?=
 =?Windows-1252?Q?czLJA/kre3v6KDJBHKqE5xqlsMu1bgyM59NNxnT3UaG1O7gFrSJR7nVq?=
 =?Windows-1252?Q?63QjUkCOeI815S1mrd1xFMDlpJjHlDihCn+402nfwr58N79JRWwsSX8S?=
 =?Windows-1252?Q?gvwGePxfRS9YJxLwwnJvDNGV8PP8pnRFk/in2czfglebw1kTFg69+T50?=
 =?Windows-1252?Q?GIr64COYg+JmwWSSbYTqh/79R2/4t6C3QcSc+45c/SDrogCVLcw6V9h0?=
 =?Windows-1252?Q?6Jg6oOTM2Du51IhxhDtexbk1+/k0zUMK9IL6mhZoh9LtfpLLKV5LUSTF?=
 =?Windows-1252?Q?M4aHC4S7zFjdNRu220IDZVM4lXMJ+2yv8hamlla/z9I8TVBLuIP+LxTF?=
 =?Windows-1252?Q?G+IZ62NRl4re4y8CgROjaaIhhsdjAzEE0gTrRF/jE1gKPbC716sQ4hTE?=
 =?Windows-1252?Q?PlX5kcmio3HHXqUebvUGDKi3DSkfzPKEFYRC9I3vvUjpgpHMwCNLwJB5?=
 =?Windows-1252?Q?0qI6xvCM9xy9mcO8v4cP6+ESTFoDSofIMbVCO9wOO5mcG9nWHvt5VNVY?=
 =?Windows-1252?Q?YiJn6q4ngh59TbliWxQD/iPECyIhI+9Hw0N9W/2em1sj8hLnMNie/NsB?=
 =?Windows-1252?Q?nIgTOMkIVSEmYcv+t1EgRG+Ntw5Sev00agLgc7BuhGRqB87T7qBRjztd?=
 =?Windows-1252?Q?qpZJRWgXyd9HQ5KKwP8LZkq9LMia3fDCl72YdCQhcQkE+lXRcNUHHGUB?=
 =?Windows-1252?Q?0JlpiHk0FrPSQ9QimHeimwciFA/G6YdlVB/wdmTG+56CFzrFS2gcXcqF?=
 =?Windows-1252?Q?jA0KtoPVn+r3w0wPzbD1Icg80yjpd7HXeub1bQD6kzvgNHQX2nOE8goz?=
 =?Windows-1252?Q?ObpydP10mOr8MQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?ddJnACjj2GnRid7pkzZDpQFq6r98Dp+vLryU+hm4bGVvODJo9455ELlj?=
 =?Windows-1252?Q?iUHtUmCYPKF1KG0F8QFtT5kbVeF/8IMxLYUD9KgKbUhjurtzkAcwsL6V?=
 =?Windows-1252?Q?vMSkj/oXyA4K29ekw7X1uHXPgJXiZG3SWPwdnmXYdff0P0pq81luOrjN?=
 =?Windows-1252?Q?Tq5C1LBqiHlH83lX2zFFrgvyiFYimb3A+j35zRPJS1032mC28s1PMyrj?=
 =?Windows-1252?Q?3Majh4PuZ2Tbh3y4G+I38r77hAjv2J9/d8vZXZtR3G2u10X+s5Y/OiBb?=
 =?Windows-1252?Q?22AKfG2xjqPw6PmuUp/I7gbeZM0Rj7V1Y1yDR3ZMP77QtigsSXOogjCi?=
 =?Windows-1252?Q?Et86jg2Ck55Rk+52jPxDpe829kFHCI/w6m7Hfbk8BolZig8m4bBpCrAP?=
 =?Windows-1252?Q?uoUKrRWII1pRKy0Bnjtjk5+gg5SbqvMaEdFb+PG79qti/OROdSD9DNG+?=
 =?Windows-1252?Q?BZ+KNofxGd5+Ozp4y+RVEwHIVu8D19AK4xx07FO5R6sLkEINX4UX9EiL?=
 =?Windows-1252?Q?V49PqwlAESeEbluNEsj2SPw3SBRttkTxwh9fZ/m172SjJ48gaolfA23A?=
 =?Windows-1252?Q?rx6jtAjcxw7CvedXhI4Z1beELCOQX9FrRpz6WWnvnVb5KgrXGcEOLlXW?=
 =?Windows-1252?Q?v5+gzaIEhkr6GRw/77dRikM3IJkSRjXA8vfgEa0dAbjgO5q32PUEiIdf?=
 =?Windows-1252?Q?B3gZqhz9MjQtKwBjhxRCdAOmoo3R/ccL/kWywoa4HPzEtdlwnIixMsig?=
 =?Windows-1252?Q?a6usIDhQMvkeTO9LJxNkjtW6v8HIl5v9q5lEP+0MeC0qp+4iFrPGqITl?=
 =?Windows-1252?Q?CYgn8ZYnJZlS8/qGuqTZl7xPzGs7qTfv6nnzJ17FQ2EYjGre53nO+RSS?=
 =?Windows-1252?Q?qZOLDWG43jPt81xcUznNZiSEJ9Xs03BDE7ovIrV9BEqYlrij9i/xXx05?=
 =?Windows-1252?Q?C8n0IuqS9r4XuCNvap/P+H9P+6Jk8tD+h+CB6UWjWeWYRGM779ymf7DM?=
 =?Windows-1252?Q?oU2fNZGCPXFjWIWBcJetI8f+bnEuAESgTvfDorURgDLcdCtJzdCG19+7?=
 =?Windows-1252?Q?6WHQ9ZOwQcxltk1nkruzQdPNFO9doYQUC7ty/jsiR5+AuVqTzOTwrPko?=
 =?Windows-1252?Q?ilD+vqzUF0TMVtKE9maGoydl93qSmha9rpeohe8HNL+kctehhWTZmBjM?=
 =?Windows-1252?Q?xgMtfejvyDqO7G9Y6DTwV0bnJ9gXo+HCZmILAG4oc+9tb39yTEQnG/u9?=
 =?Windows-1252?Q?76dyT0Zoi/rRnt8shaB+C/xVBkLM/cqwVMuZtvblAv+nFiNnJt8UDlcC?=
 =?Windows-1252?Q?r7isfbUSKHyRx8GOAoqjKUzLGEvsYHnKwvTrgt0U57Ci11ZCxed6o3hh?=
 =?Windows-1252?Q?YFUs+XIhlhrCdUZksJACfBWUEZYqFFQa0xZKwu5L4n4OZ0Q9pwZX3APl?=
 =?Windows-1252?Q?kBrBbfKXXwTS6+0L4pPNN0av+DWk9GfwXZzvW5XDmv/952t8eZppMiH7?=
 =?Windows-1252?Q?p3AHfOnRNmJUD/pwmTgq6um3IqoKqZX0QwmUZpqnEZqyvOZLUrtpm4Y4?=
 =?Windows-1252?Q?5Yu99iEGaaPs1q2uEmxPTp+YiZsE8TsjybRgy6ieQO6TpIyupMlmewYM?=
 =?Windows-1252?Q?hpXBUdK937RDiG7WfvEOkpdT/R6JNIzaS2lhM+VlTITJh6zWcxt1lg1n?=
 =?Windows-1252?Q?rrq11vqmzlMHl4A1Ub1wzi06zo2tvSqkf3WUfrQ4hgaPeH6zBqFRfw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3e892c-abc4-486a-4b7c-08dc7bec06a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 12:21:23.3270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6wAqP6fdxaNbCznXRhpuirakKESjW25dpzQbzKR+xEzTupnCTmnJHPAqbr/S0/fS15wN42ZDWRjqndGMoh/eZ1ms8cy4Nz7Hs6O6u+FBPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10034
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 12:21:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15945

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, May 15, 2024 6:26 PM
>=20
> Hi!
>=20
> I'd like to test 6.1.91-rc2 and friends, but gitlab still have -rc1:
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /tree/linux-6.1.y
>=20
> Can someone take a look what is wrong?
>=20
> Plus, it would be cool to start testing 6.9-stable branch.

Support is now added:
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines?r=
ef=3Dlinux-6.9.y

The initial test results look okay, apart from one thing...

It looks like we're seeing a new failure (VULN) for one of the spectre-melt=
down checker tests - CVE-2017-5715.
We're only seeing this failure on the x86 simatic-ipc227e platform.
Failed test case log:
https://lava.ciplatform.org/scheduler/job/1138103#L998

I checked v6.8.11-rc1 and this test case passes:
https://lava.ciplatform.org/scheduler/job/1137807#L976


Perhaps this isn't a massive issue, but I thought I should report it anyway=
.
For now I won't mark this as a "known issue".

Kind regards, Chris

