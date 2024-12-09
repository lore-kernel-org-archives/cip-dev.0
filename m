Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7502DE77173
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 06:58:40 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.40])
 by mx.groups.io with SMTP id smtpd.web10.95401.1733727513962125879
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Dec 2024 22:58:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=M5ctJ0yq;
 spf=pass (domain: renesas.com, ip: 52.101.229.40, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7t39brY5cXdhu80WrMm57lUuXsRpRNadq0FZFPvkCqkR1ZA7HE+sWOC+GCf4xdmg93Go7w7YKwjS7mMd61Ao6mUKxx+5TEzp3q13c8/RTJqBBP06Aa/w7lKv61dAOwVJaCljHTpSS9EKTVp2+IpeKcwR8M4XkWYbM13MM9X2x7ZZ5hxsqnpIdAyikhyIeaztIgK7S0iJ8Lci5ebE9VsPbyulnH4fcyrysEg+Ul5qdXN+egojXWccUVwtCQPChTuBXTuoAp2pex/a/aM+eW/x1LjEb8WRccLNjovvQ9trUaBP3rHZwkuJ/zlhPyMlBLsCzX0nA0sxnXIYsYTCxmpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2A9Jx4rbbJwVqCPsT9KjsfEjS4UKfU9sBRECPKiPAw=;
 b=jGR+MokWDqScS/9c/PN64SHxWbrkwwLWDjYf/G1kdjG0BW/GKXHQ0NEx5TSYqj9DeTR3iRt51Am8qLvxre85S88/2RoBfexOk+MnjnQcRF4qhTfswW7BvMV5aIA0f4rFa5QZS709V0ZeIOfzwkSBVYV860nJ1wAA0+ktTw+n0VtYic2fsSyGgmUknOKPCPqrPKr8fUR9AZ3LemOpKZFmofIzqy7fPRbQckBI9USNAh9iG3CY3P0D/6jwnwUz1Rdtmj96RJhTInwd/yplxwSM8EnBaISxMDjOFw7ZnwVN2yo6YBypV69XdvYwDg4PFEGud6Dsk3GWzYskRTxCuxvcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2A9Jx4rbbJwVqCPsT9KjsfEjS4UKfU9sBRECPKiPAw=;
 b=M5ctJ0yqh/UKgwJe6Au7QIAtArRiWax6rjrLRjuPQXBqy6x24HHg65GXSwXwGbTqtGZLGBMe/VvnDWEtjWsa9aEazpLB+DNg9FUa+z+jDxH+ItRAP2u7LKGUg5JRXTR4dWEofIlMG9qu9SlbIjqXR5UWPtQLry2+EfSd2yB5K9Q=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TY3PR01MB12070.jpnprd01.prod.outlook.com (2603:1096:400:3db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 06:58:27 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 06:58:20 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: Tests slow and failing?
Thread-Topic: Tests slow and failing?
Thread-Index: AQHbSVMt/qaHaZgTsUu1ANvQ+hmvGrLde6Qg
Date: Mon, 9 Dec 2024 06:58:19 +0000
Message-ID: 
 <TYYPR01MB12402A4E5D5A8F1451D39D537B73C2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: <Z1VmGEH8ErHlIt7J@duo.ucw.cz>
In-Reply-To: <Z1VmGEH8ErHlIt7J@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TY3PR01MB12070:EE_
x-ms-office365-filtering-correlation-id: df3f6348-681e-4ee3-f6ca-08dd181edd79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?S1+ZNQRGzqoSykDNe3rLJdPgi2rJIASEW7pAuXWvmrqjeL0JABT/9ShP?=
 =?Windows-1252?Q?fH9l9ONfBXEP47ZV6BjduaaRMj3tn8YYQrDuJew/zMmrrb/k2dGcgnxI?=
 =?Windows-1252?Q?ZEBN+Yl2TvQ1Vh1u67heakxe8iPHjZdwsgC4c++Ua3x8M5scRfnEupFF?=
 =?Windows-1252?Q?LzxLaFM5E0hoOLYX1iMBvBnDFAOckT1EQTM76EZuTgPpcSSPFRt4gXmS?=
 =?Windows-1252?Q?TUKbpys4BtDnheUZPioOmKNOK2IatU/SfBP+3Ujt6y9ISzFiX50AIEVF?=
 =?Windows-1252?Q?9pMMmOk2pC7HCOCcden4ERra3/FRI4dqLWmyNF/3/ABd9vbxjcXKb80S?=
 =?Windows-1252?Q?LAOPeVcPIWMigS3Ga7ik+Wvd7gJ883jyddZtcTlOS4fSzCmMfnd+pmgI?=
 =?Windows-1252?Q?GMWr5B8wDfNwtNCtO4Wlnolk+uopGtTQ2ME3hZr6eLVhbT7nY7onNYao?=
 =?Windows-1252?Q?8zoryL3jY8Y5hU7NrkOnhhimVxUbA6w+7LqDq+uA+n9GOr+o6ihb/Sb7?=
 =?Windows-1252?Q?v8cSj/sCtqYPmysB2UxPFLjJi+e+c7nU0ak5GLp/eJNnR6F1GpDeZw7c?=
 =?Windows-1252?Q?GQ+0cYrQFis/maTxNpnP/SOPy4/hWkX/qCgWrz9wFnppxU6LFCirhjQq?=
 =?Windows-1252?Q?ittFp10zvhWcph2lt7tFOrIY5gvJsy44nt5EAhCCZU1gAyABxXHIFVTi?=
 =?Windows-1252?Q?TL2752SaEkIdtxlFL7tk/+IgNXksqYwHC7ubum4q6yxKepuGdD4+esfe?=
 =?Windows-1252?Q?bBENvjR01p4xPaHGj3JI9TBOksyc2sufwhriPZdcGggz3Bknujd1aLqb?=
 =?Windows-1252?Q?wUKnsIeSvfvy/ypwWEn76+SqB9ZnDFkX3ZQQPinL6Gv508r9w983ITQZ?=
 =?Windows-1252?Q?8N0SJGgtcaSnBiAraCScp56QzHzYYBjUYEUqYCvga7vfv1SBdOeLqmJ2?=
 =?Windows-1252?Q?jyjZDnjc4662sphsxdlQQThtlwAuzouCDq/qwwK9eozxd0E993SpJpsp?=
 =?Windows-1252?Q?a4Rj9p73alEP4yHaT1/ilrkSgbXVpHUX1PITyNMZs1ZcYRFDEvZdkGLt?=
 =?Windows-1252?Q?NPhi632oJfJYVrjvhLVIimPKVTzFWo4CVxofrtcFtTG0rApOnG1DF3Mo?=
 =?Windows-1252?Q?jdA8TlTY03g7/mLjKS3WRUmTh70TNpy2VzPFNsXjwrpan4vsnw8AJysD?=
 =?Windows-1252?Q?ZE7epNUMjxi3alCIL/A9TqfB1Dj5V0I/PjiVnU3XsVxKZq3NEjKhwW1G?=
 =?Windows-1252?Q?2n9twVulg9xmsATl++/gWhEjldCurx7bKDwNF+8K8FLGP8eNfF/7EmBH?=
 =?Windows-1252?Q?BoSrZXKu4BQ+LXquL9dOvw/pmJ57u7qS1u9VEo26rIGbQhxDm5PJpFXt?=
 =?Windows-1252?Q?yPNFkK7UT4ZDwjW6gxEXobbUN13swjsqiS5XZdadeAw+1zka45E5r35S?=
 =?Windows-1252?Q?B6y7BOzLxxu+19Lrj0kyv4dMamEgL5B8eLxQszHlCUw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?gSSdrYwzrxlfs1Cn5eZNTeBwN7WyLbW3bfroKAzYue99Sc906LCbUepr?=
 =?Windows-1252?Q?TH6soQIqUq6V4v/m/A5KXJilyIg7UAiILmkVXtC+ply+BPuo8essvjPv?=
 =?Windows-1252?Q?iCuCSBr4VFMpBpu6ovh4pqurchZnZ/0b8TDjYUvZ5vmfYDayFnI68szN?=
 =?Windows-1252?Q?T5V0Iqz8Ds1AjYJrevrnNjind3RJwhY9PppCKMigRtWYb8EHjVBLVsCX?=
 =?Windows-1252?Q?y5DTjsLXQnlrPjgYFVxclBctxhCxCsv51iYXTd6GExqmlV20Zs/Sc+LD?=
 =?Windows-1252?Q?PUl8y81GgToeGn68EXQBH6aAARF2DOQ0P7JJZHhMppwNGA+mu/8Lm7mK?=
 =?Windows-1252?Q?OQxH2+uGsC+oU3l7MbagP+p3kLchoR7mLBuY20U69PUwWm4SCgYDyyyP?=
 =?Windows-1252?Q?L4d/U2c8791HmXTCM9V2AXcTNFxeDoEnNaqPYRBND1JqVbCYWYsDTC93?=
 =?Windows-1252?Q?vQNWc0BL6DwIElDU9JFGHcyCosLQCliPbSBAPpXQWtBEVoP37z2i+Xiu?=
 =?Windows-1252?Q?etlAhBfA9uOGp/CTZQAleD3+/Zjvs75K/u72JgLDil9v7nrVZLL6EMpS?=
 =?Windows-1252?Q?qGqsN4c9TKKIDFy3SL61LW+OxQ6bA16Hg50ioybS76NFr+1yaLhSjISd?=
 =?Windows-1252?Q?bgmVvEb6zAgGaNm2bn5cz4yHG2D0iX0A6JwDys6F5ldaJmKgVDcnJ+n6?=
 =?Windows-1252?Q?pF4/Ps8q6pLzeXIRqzS5vfkq6Br6VSBQtaHFkyxOba2TbNY5eAUICoO2?=
 =?Windows-1252?Q?kF4a14NL8k32EcQ3zlvX2/91SqlBxUXqDGJOoBMyYWvZB8sW08AHVI0S?=
 =?Windows-1252?Q?qKzM31Ns2JCP3hxno19LNers7dCOXpMsJHjPATmPoiZNZxm+eI/zSILJ?=
 =?Windows-1252?Q?SKD9ONs8KEnTqY50pHT33C3bDXiwHn3u1I/MzdaTgMwSRUCe1GlRqUC1?=
 =?Windows-1252?Q?kpoVcYUpSwVyZi35ZwS094Ey1baDE2zVONgl7I/vEi89PLFIT7eekBY4?=
 =?Windows-1252?Q?sraWDzAtI4NeMebIo0SMNKjyAgLkJzzbRq3NLdgP7h+WvFKmjVJhBqRr?=
 =?Windows-1252?Q?JqYt527mTzlCjEDGCKwtn5uzKGKyR3a22oRFnM5xsvn/4uh+mdNgwZ9o?=
 =?Windows-1252?Q?/kiGJtu/AKEVqM/QGnui5eXEOoe/lr/Bjjv22a5TvIkrfErzBwdLGGIc?=
 =?Windows-1252?Q?rc0PigPXi4V3Lhm0ZZ3EZ08cRQO1yZM6Fc5KqQ4fSKcUSwjsQvN+NbKf?=
 =?Windows-1252?Q?tZ8cecbVVoLvI0kupJAHXF5p3rKOydJKa0++dGqzrYnQizjRtTp6E3ol?=
 =?Windows-1252?Q?5+WoiAc4HpMUgyyeh67JaP8Kxj1XPVsFBa6DBvlWdObuV7T9LnbWPYn6?=
 =?Windows-1252?Q?JR2YzBIl1kd/JVug2M5P48i/h1Yy/UVpQrFtSjetNIJNUek75FEHKgkp?=
 =?Windows-1252?Q?hKru3LvfsA9Nd36aySgo6ofbW7B16CrjblK+Gu1S96F4vV0lT2vqV/8S?=
 =?Windows-1252?Q?5NKaZjYvZpDPqxKlDmyPnPLQpLX6u+GHYZqsmaHFCB0FMNe+/cjA7T8l?=
 =?Windows-1252?Q?SQEO6O3JhL7n74+1FRqxQdvsD9sIh2Vq+WWaM9iJI9ngnVXp5LQ8PX4A?=
 =?Windows-1252?Q?OEZVqTJDIb3sHych8cuDvmP1YrFLTGZb2ONNVuC/ke9l2zbGtRIBrTIP?=
 =?Windows-1252?Q?FdSVx0piPkHJ9hi/plzEcAYgSdNo94RB2kHs85D5MJVB3BZD1nWL7w?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3f6348-681e-4ee3-f6ca-08dd181edd79
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 06:58:20.0053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nnirvdxw0aOQqOiNWqp27MQ02HMTcCrRZ0SUbdL/8uO9TvHW/cuYYoKfAuFdCib4L04yP7EjAvg4HZ84LfTi4Dt1jmAnBQGBlvspIBrPaW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12070
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Dec 2024 06:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17379

Hello Pavel,

Thanks for getting in touch.

> From: Pavel Machek <pavel@denx.de>
> Sent: 08 December 2024 09:26
>=20
> Hi!
>=20
> I can't get 6.6/6.12 tests to pass. Not only bbb is acting up, but
> obsvx2 as well, and retries don't seem to fixing it. I tried to look
> into the results, but I'm getting empty pages, so I suspect something
> is wrong with the testing.
>=20
> Empty page:
>=20
> https://lava.ciplatform.org/scheduler/job/1228877

The status of this job is "submitted", which means it's in a queue.

If you look at the status page you'll see that all of the relevant device t=
ypes are offline so the jobs openblocks jobs cannot be processed.
https://lava.ciplatform.org/scheduler/

>=20
> 6.6 failing:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /pipelines/1577092627
>=20
> 6.12 failing:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /pipelines/1577095923
>=20
> My various pipelines failing:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/157840198=
8
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/157841662=
4
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/157850775=
5

It's a similar story for all of the above.

lab-cip-denx went offline on Friday morning.
lab-cip-renesas went offline sometime on Saturday.

You can see the status of each worker here:
https://lava.ciplatform.org/scheduler/allworkers

Denx are already looking into why their lab is offline.
I'll check the Renesas one now.

Kind regards, Chris

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

