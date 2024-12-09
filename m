Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DE4E77173
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 07:16:10 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.25])
 by mx.groups.io with SMTP id smtpd.web11.95498.1733728565834311535
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Dec 2024 23:16:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Bh/G9VhA;
 spf=pass (domain: renesas.com, ip: 40.107.74.25, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtT9CGKvL/u6BWLkhOdplMxNsOIg/m4WTaWYq76x7bANcR6qg4EZLmnJjstDsNdPIL+rNWeHoflbQwC/nYWASzWAhsAxfDGA8Oj3RbyMdopS01Qp2Nwlx42zPsaVyatV2/WDIH9Ga0Mr+K8eho7afijMF3YAK7ThBD5XAjKF2osG1f+wYpZF0LW9Cd1h0EExp+Mkxq0cKo7k5gkL2u6Dn78MsXXBqpC7dP4JSiQCitRly+xSkCX31oHvRZ2sFvjOJ0vAqBnjxdzjZ0DHp7uLw747xhIIQHd6HWmhd9Xvzf3m72rPH8HiZwP3IzXdqSiHRAkWVw1klmEfZ/kr3lgKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvz0ORlXsxL0LXLAnysshsbTnV4VkscD6t7qD0IXw1k=;
 b=YwICDqFQbN8ckyOaAOCFjiAILLuIfXw9oVkfqV51h3us7ZvMlweufhRgpOYT2MNq0xzTZUvvdW6egKPESPloq5ZxqtBRdvS8NkU+N4aPLB2HTWoNy0ecXkruls5E9hjvr3up7VMuMqefqg7ponZenD6DQEnnWgZ5PQxIHh88djnQprMHkdvRDakZ33/+u4w3ggalmRrXbGUFMxi17zgrN+tU6tEesCS+vgK4NH3bEcFu+894xJxiNvaWjM/4Uj3vPY0EQNh44LhY9lXGydM4x7E4D2D6Cr1q5xSJf7WaQHN7JU5kyvfOxx024O5hnx3DXn5azD0WqIdHnc23VsSC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvz0ORlXsxL0LXLAnysshsbTnV4VkscD6t7qD0IXw1k=;
 b=Bh/G9VhAukYckQLKPxBeaFA+GqEm8DX9VxOMOIUNuLPlZPLarjTfOwQAMWrvUHHmbUejOqry59pRyF9AIqdYd63LoikuS9TU+7Mum//N3ZFY4xcEhnFlsS0zB6taoAbi4IaBvVK8rcNVGHWnryD0efchfjj2WvnlEAWgaXe33Sw=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TYWPR01MB11249.jpnprd01.prod.outlook.com (2603:1096:400:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 07:16:00 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 07:16:00 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>
Subject: RE: [cip-dev] Tests slow and failing?
Thread-Topic: [cip-dev] Tests slow and failing?
Thread-Index: AQHbSVMt/qaHaZgTsUu1ANvQ+hmvGrLde6QggAAFZLA=
Date: Mon, 9 Dec 2024 07:16:00 +0000
Message-ID: 
 <TYYPR01MB12402F607BBCE85DD04A4C5AFB73C2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: <Z1VmGEH8ErHlIt7J@duo.ucw.cz>
 <180F6FFD2D29AC17.8554@lists.cip-project.org>
In-Reply-To: <180F6FFD2D29AC17.8554@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TYWPR01MB11249:EE_
x-ms-office365-filtering-correlation-id: 83a012ab-d0b4-4623-4fd1-08dd18215556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?aub3yZjemfZOSR8XGVI1TRB3y8njhjl1W2UvjNTNmbJbIBtVDp4Qf4e2?=
 =?Windows-1252?Q?0MQHYGXSApBQwBonVCvifpGb/1w+BNPS25QWe7//+6pHCmP3vm4eEKv6?=
 =?Windows-1252?Q?d/C/APk6ZoiNk1XL4Tt0W+rEJqJyWtPYC02FYM0RxpiBwpMGRaPsvyUZ?=
 =?Windows-1252?Q?PspdgG6KK2TP+wuHxg5TRe10Y9xNqRmzxkS0GDExGPn+mpNCl4l+9ZaH?=
 =?Windows-1252?Q?PSZ051y/uYlsWKaGFZTw3XqB/keAW7L9Q/kHQ/vsweNji9suSMWPCmTa?=
 =?Windows-1252?Q?mhsr6OXqZkTX6lYH6F/fFmjzaA/USqKVb99riVspuoHzu746vJ7xiucR?=
 =?Windows-1252?Q?FQW20JpnOc+QTrLZKU4gIBeXlZ2ARzlMQTGMcS/yXuhWRLyfSjz4UjaY?=
 =?Windows-1252?Q?5uClodhHvOrbUZxlVinaSW3D2e67N+IuZs8+7pK9RDzkui2EjtXq/7fa?=
 =?Windows-1252?Q?gWVB6EegoQp0wpYG3tYo7zGaOQ8jQHYtBrfgwsU08pomMoxe92f9ES9G?=
 =?Windows-1252?Q?C7zyK5SB2DNdzwXQOyk1qKzzDFUwPp5mHUs3vsiBjjOZ4oee6X6yfYTl?=
 =?Windows-1252?Q?xC7jf4mIku8sJUceEM98CnO2x8s0VOJoT16zK1zviP7tpDbHzLSrZQDK?=
 =?Windows-1252?Q?R9ZCX1akgWvWCSIWGEgREC7GL5yGm2+sG8Nv4Yh5fGB/W8dHEp38NOJt?=
 =?Windows-1252?Q?msSzxqaMIdxrOO684z2nvO5fYQuIALWRPKhE7LWZuuzTGH/qTMHK2An9?=
 =?Windows-1252?Q?WaRmwPq41rsAfFZ5+1MHqN0TM1pJS9gupyqQKRXw3TVSbzPPzLFfHTSN?=
 =?Windows-1252?Q?x9COQE/9R6SEbNAdyc0n4RtpE07yznjOaT0aEMElIKmIG0/xD9nSSr7c?=
 =?Windows-1252?Q?JtEVqwzIKSBYJMztcHggJ1FVcVsPnB8ppmn6RnfFBEaMk+o6Cwqn5pwG?=
 =?Windows-1252?Q?aKxViEydfYq0QwhgDLBZ5T681L+Uh7tln+lPxakDe/mrWk/kp+dNKzKW?=
 =?Windows-1252?Q?NMTtzIx638p4s5O0AQkY9S2J+fsq4KeevoifcDrophpl3UTaf34WToxD?=
 =?Windows-1252?Q?z0snq++J8WrZ5LAFvoIFwkPhGWUMHkVuS1q5i2jkyuyLCoaR0xhDJXEB?=
 =?Windows-1252?Q?kRtisTTpD3z3dCV1TsOtoefHop7Wc9pqRdrU3mzCsXaTIBGWZj+BGNOG?=
 =?Windows-1252?Q?kcY2C1VCEGq6tOrPbuRkFapLBftGwStQbSaP9zcD3pFThDKltT48I17m?=
 =?Windows-1252?Q?t0Ux/7aWEhfK0vFgnddFj4pFkrpsSiqB1/4bQd2Bw5Ma5+7b74LPj2P5?=
 =?Windows-1252?Q?kSLJsFfWCm1DoIZhn5rkXTlMY7RbzGuuo4zGP9CIYfJ5xxjPIk9S5ymn?=
 =?Windows-1252?Q?qZv/wasBgIlrLkyfFc7xZ8VA9D+jcpj1Wg5vFNVZw9l8OiUodQfRyTrf?=
 =?Windows-1252?Q?kDNkquHwQaRGXiE9B4MT0S2vK4NMvxMy5EhC+vM0pyw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?S/Pr1mNuYNjOxPsRl2C9sbP0waC0cAWK0uFgQ3x5/GY/neCw6pZS9ydQ?=
 =?Windows-1252?Q?v8f9xEJu4JmASLXfi3i0sK4AI7S6JVrfPcv2UxBdC7aLVQG27cSsjSHe?=
 =?Windows-1252?Q?lOFMa+3TxP1G44nOkF6kdkLjw5W+KNFMpDPinA8j/ZySxPcRGrgWqx49?=
 =?Windows-1252?Q?lC5xDZyAFmHKEhrLEMNq2xjYeWQ01TbzWf31KEpmSdxUqhF1f6QSH+ML?=
 =?Windows-1252?Q?3gqd9Ou3T7y0fQMwW4HomYtGi6AI8gd/rr8D6nnTtE2Jlc0HODPye2Df?=
 =?Windows-1252?Q?Q0BH8YU2GxQ+a2HZYe9Fv9iBpQLlbbVFLuvhnG0NcG86HQ3ZMX7n50UA?=
 =?Windows-1252?Q?jAeLKYfYcwVIckcxjqQ6Ps2sPPomVMdt2Pwm6fiSSHoqg3l21Ei2k1dk?=
 =?Windows-1252?Q?tCC359FPIy4CKSZWCHn5mBWdIfJEb4DYjAUJ1i4lCMBHllPBiXNmAoJO?=
 =?Windows-1252?Q?6slt92X0VSdnlnRIjZ0f0MLukHLlTvjWV7RyfpTYguuDuKu3Z6gYxjQs?=
 =?Windows-1252?Q?g4tOO0nt8Zp+ljKPZWoaELx9HyR7MegiIqdN+dlRkOCQJvogq2stVyIu?=
 =?Windows-1252?Q?RmBC+pOe9TatCQ/DjmFK2L+7I1kXbA0VwAGpJOyuujKfmGALoNcyNHI2?=
 =?Windows-1252?Q?87807UoQPx89cGjoWlQz+Wby+c4hvraWveXv7UQyE4zQ97LJ2L26pzxh?=
 =?Windows-1252?Q?1GKYa+fqRmNamLEDLKZqBVw45s2S4fcU5xs+f4UwE5MsG3/D5xCNHkG2?=
 =?Windows-1252?Q?LEkKFfSxHhDBiXhkKilnA8I99e54rlHjR4K+ea4ZzBTsfEGyQCumPSGE?=
 =?Windows-1252?Q?JBNWUtsE+QtrVktEhD3yXH4xzDTbsAAYSieT69rfpLXFvrr0OpfhXH4s?=
 =?Windows-1252?Q?fTL+RH8zS2nQq/Fm7UxVGDoL1vKTW2loWqvFrx0vZvYkZ9SfF7eGEZsU?=
 =?Windows-1252?Q?zBTnsKRnZ/4C2WFO62SqzKvrORFaCci+oIyrIrw6J6vxXyOh7TIR2wwg?=
 =?Windows-1252?Q?9gSlE+qwAiRuxjGnXjfaYkJY9mmf9KKqQ55lJbsQb+gq3jP1Re23BWo0?=
 =?Windows-1252?Q?C6j3wzd1iVFemEgqYM5G4+4h4REc4Z9X8g04BRpvRnzkZohnNirSecF/?=
 =?Windows-1252?Q?la4wdnn4LsBOG4Q7Vw+FPbd9ZjSb0zFu1V0qhcsEF8fkUVMGZnGPISZv?=
 =?Windows-1252?Q?37BSp/JtgVJlSl3BagD8eNV3oXs6k5gvwMYF42s0bgLpMFpcIU9TNZse?=
 =?Windows-1252?Q?TdsubeZenA5F/aLCPY3vzkdtK9iRXWjParDZTEsQ2KpsXWESraVqgWWY?=
 =?Windows-1252?Q?RdgkWOB5pwvxXnx1c6rT7TLoIaAdfdIxYt7RTkB6Atxl/szo2ycyqWSI?=
 =?Windows-1252?Q?EcH65Dm/z/jdcIdo5i960wekwcsVW8wjzkhC/jp8QrFO0CheyUv3tGQs?=
 =?Windows-1252?Q?hutzVSys0Zp4HsXk3SBPzfWVDsOET+MWVhqBZOrgn7p+L1zLSwH1pDuG?=
 =?Windows-1252?Q?INwwmi9zX9FDIrDxRjFhoAcNP8H/eYTHOX2dEz0f55RsZrLFcT6yajen?=
 =?Windows-1252?Q?dmqafOnQyiRZ5g+gmntUDLdu8bXIzKJE/QHjGVT6vmSFvRu+5RN6aXWs?=
 =?Windows-1252?Q?DaVXpgXe1nGIkN2GdbyaHxeVYTHtCjib6cupFu2gsEpZoSZAFKsFF6t8?=
 =?Windows-1252?Q?/cW5gidQXI+9soNBrJO6Crsv+EZlcbHyJp+56lvTSOTET0BiEN/q2w?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a012ab-d0b4-4623-4fd1-08dd18215556
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 07:16:00.0881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHYEt21yKCKhWAIr5X7yaJELJ2db0s55HhkXjra4EsmbJpNbeVqkdevaxCj8wQRmtJJ6Ae0VnSvFNDVy6NvS5SgNPaShCTtt7ZYghXIcvTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11249
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Dec 2024 07:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17380

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 09 December 2024 06:58
>=20
> Hello Pavel,
>=20
> Thanks for getting in touch.
>=20
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 08 December 2024 09:26
> >
> > Hi!
> >
> > I can't get 6.6/6.12 tests to pass. Not only bbb is acting up, but
> > obsvx2 as well, and retries don't seem to fixing it. I tried to look
> > into the results, but I'm getting empty pages, so I suspect something
> > is wrong with the testing.
> >
> > Empty page:
> >
> > https://lava.ciplatform.org/scheduler/job/1228877
>=20
> The status of this job is "submitted", which means it's in a queue.
>=20
> If you look at the status page you'll see that all of the relevant device
> types are offline so the jobs openblocks jobs cannot be processed.
> https://lava.ciplatform.org/scheduler/
>=20
> >
> > 6.6 failing:
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > /pipelines/1577092627
> >
> > 6.12 failing:
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > /pipelines/1577095923
> >
> > My various pipelines failing:
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-
> /pipelines/1578401988
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-
> /pipelines/1578416624
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-
> /pipelines/1578507755
>=20
> It's a similar story for all of the above.
>=20
> lab-cip-denx went offline on Friday morning.
> lab-cip-renesas went offline sometime on Saturday.
>=20
> You can see the status of each worker here:
> https://lava.ciplatform.org/scheduler/allworkers
>=20
> Denx are already looking into why their lab is offline.
> I'll check the Renesas one now.

lab-cip-renesas is now back online.
It looks like the big storm in the UK caused a power outage in the office.

The backlog of re-submitted jobs will gradually clear, although the only x8=
6-openblocks-iot-vx2 devices we have are only present in lab-cip-denx so we=
'll have to wait a bit longer for that backlog to be cleared.

Kind regards, Chris


>=20
> Kind regards, Chris
>=20
> >
> > Best regards,
> > 								Pavel
> > --
> > DENX Software Engineering GmbH,        Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

