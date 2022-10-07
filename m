Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78F5C433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 09:38:43 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.120])
 by mx.groups.io with SMTP id smtpd.web11.2663.1665135514059237490
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 02:38:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Tt7MldwI;
 spf=pass (domain: renesas.com, ip: 40.107.113.120,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRYy9tX9EPeQcEaTox1yV4f8XuINYRmi428ISdIgx1jDpyn4UwU88g44U17sli2BJQ7/Suz7VMcvMAI5tJwioWIcz52tVIjgXdcLNYbl7+aq/StAxa7o6mQ5nVkIpiScm0kIieIZ4on5JIoYB6NtkbI95VH9JZjmBEX9yoTXHybhNlNOTDZpG4gsWJAb99E+CZTyKPz2zhNR/lXaB1tzksB+4sgKKaesSo0KNjKyZ/J3l1BmOOjZJ4QG52Q42P2gMTMM8q2cigeQg+BNJAt73LdF5DoVJA4DO0kQE0uLD12bgdiomswlpWovF+ydz5G1TaolHNz/3oLcs1E5WLKtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIGXmyThsqX8Q5bPkR2wMrxflKhcGi2f8Z6e+LMYwLA=;
 b=llKof8H+YlcMzM6fqGtV+/XjI+JWNJdHBcx9393I87F877gbfWW93x8TDA0RYu5WXZj7656iQHySEtsJVfdwAv1hpFGXeB7FetNFpZ03l3JgY8aGPec8K8rOGJkpuV3Q3mD+0Hry5ohYrequ19sBFFv5fLOCJH2iT+IIS1hYOB6QP9IwY3PX4+Wqf6ng2ZqMGq3l2smahcA9v60pMtT7mCxa4O/7KZLHBrFH9+V3r/gh9st/AH2dQt1Vx4Mj5sQPVOzxTACWZONzM6xJYLd5ZknH41eWcbj0T5Fky85n3sedeG2yrsQ5vCD0rRfNRoJYeRiHdu2rBxTCyTWUQwZZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIGXmyThsqX8Q5bPkR2wMrxflKhcGi2f8Z6e+LMYwLA=;
 b=Tt7MldwI8r/ZXQePZWuHqew8p3cAgtmamOt/z1ff4h9olvhWpdPh/XUX3MEbliHnaBj7WO3agWvH8muy25zZIy4Ud++4b3N0XpgcUTOGEJY1aUeeYld/ZVC9gFA9m5AUdWogIhRRSidD66ARmCb3UGhPnJv+K/MMNRpKE0bb1bc=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYAPR01MB6060.jpnprd01.prod.outlook.com (2603:1096:402:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Fri, 7 Oct
 2022 09:38:30 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab%6]) with mapi id 15.20.5676.039; Fri, 7 Oct 2022
 09:38:30 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Michael Adler <michael.adler@siemens.com>
CC: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "alice.ferrazzi@miraclelinux.com"
	<alice.ferrazzi@miraclelinux.com>
Subject: RE: [cip-dev] gitlab test failures -- job failed ... pods not found
Thread-Topic: [cip-dev] gitlab test failures -- job failed ... pods not found
Thread-Index: 
 AQHY1LqD736Cemy9y0G88cTlOE3pAK331CBwgAAI/2CABgYSgIADZwiAgAFAkACAABeR8IAAEhgAgAABeBA=
Date: Fri, 7 Oct 2022 09:38:30 +0000
Message-ID: 
 <TYCPR01MB10588E92EA6072E454DE9C603B75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <20220930105048.GA19081@duo.ucw.cz>
 <1719A05389EC9CB2.16804@lists.cip-project.org>
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221004075301.etgur4dyb5dtrcct@backstein>
 <20221006115033.GB21855@duo.ucw.cz>
 <20221007065754.fysie7e4j2bvrvck@backstein>
 <TYCPR01MB105886D9FCFBCD0D2338B3037B75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221007092700.itoos26inn2uz3gt@backstein>
In-Reply-To: <20221007092700.itoos26inn2uz3gt@backstein>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYAPR01MB6060:EE_
x-ms-office365-filtering-correlation-id: eca0468d-93b3-4997-7d09-08daa847b186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 uC0Fz8RoeYU7bDeB0jtdWsG0skQqd0kv3jyM+Fdd9F7jOrL8dRHVMA/PyEHvFrzlWR7XMKOaii5citcgPUKnqhKR5bu+AOL1xcrRJV9PSoVXikhVw5jkDWuJCkpJqBendz0Zj/vwoAJZfrRyc795I+6d+sEFVJ+M2otDZ3w0qzKLE1eFRkbEexy3uCtScDILqk8m5/ZctedxVT4yDiMMHOLfrKrHBD6i5JCgKD8Fmb/T9/piUoE0UOIuYkVm0saNfbtKq/wHUybQJucCDYuP56XCzHj7fHiW8i/0ba6GMBdBzRfVzMwY1L9xM4sq+8/XxzBQerd94T78hO7m+LaF6Eyp6XCIFmKBtKY2rT3EvXsV2gZ5NA8OpeTVsx+t5plLl97ldxAmR/Vuy/F4pciafNCrl9IZoIUQ8ceiGLB3N4yQGzyBk0nm7kKmr0XyLO/718VOK65GBrhlBo9YBTN1ayLkX+6FPyOe6EmhI7XTvErBpnPqH+XuGGym7Scp73LQGV9oURikiOuBQIKxy44JAPlxAiLgRcWr0cz7/zOSuTyd2l02Zr1JT+LuJzcaSLyvvvXck57wA4JMRCPxYqgHhZ9ItTfCg1rGJXXYty3QEoVqcPKG++sNkS3VSgvbSfyQdRYF9mhZkMJVSPFX6zNlLmOfyWA6iIW9WmQT7FJ44qH9JfYy4uO1YrwnLqA4TyolYV500mui0DUco/B5xjNIZLXSV36ndQEhqzGDf5Z9VF5YPhbIvCJ0/jjukW8HHQw+x/jbR/s8TxYlRdKQPMg4vA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199015)(2906002)(52536014)(6916009)(5660300002)(54906003)(8676002)(33656002)(66946007)(76116006)(86362001)(38070700005)(41300700001)(66476007)(64756008)(4326008)(8936002)(66446008)(71200400001)(66556008)(26005)(316002)(186003)(38100700002)(7696005)(9686003)(6506007)(55016003)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?lpR+tcS8jChr+S+F9Pd4zrYPhyO8VpgflDJBeu87bw0WupFEB/fB48G8?=
 =?Windows-1252?Q?lJdTzJG3F9grwaHppPM+uSEdx8FMxMGvcHI5mpfsaDCiSeg5NOSdoCyk?=
 =?Windows-1252?Q?E83y0nAZSfkRvK60UaqogqXPoh7Jsc4B1T+GBN65bSIHPLXrLmjHKJDq?=
 =?Windows-1252?Q?cZrFiFSgIVJLzvqD+uXsDtJDtd9XQ1C7IML7UE6rcUJ5VBkeJii8It6W?=
 =?Windows-1252?Q?xjf2v6UpRcn9SSivtkEHIglM711mdWfUWQcJRHQuGsjxSq/kn4YmYK8T?=
 =?Windows-1252?Q?Z4YesOR0KUGj6e20KXM7crqGNPJiyADuYXRZZjs1EyIheMdmvYkOTo3b?=
 =?Windows-1252?Q?z8AnRphOOLiAX8SSrkyLdXGc0NHebXTAmhYPQVQCgLLz57+RBIo9j6xX?=
 =?Windows-1252?Q?NzKDpAwmVkO5LM4djG6i/FjQByC4jEa3L1EyghR5c+qW/4zjx8Dj7BfR?=
 =?Windows-1252?Q?Of7NEHz/ckZsOUGTWFGtFId0iJoR5jDFdX2y1t8vOOX2JzGb/va1aGAr?=
 =?Windows-1252?Q?BPG8kObpufDVLFk+cx9gRWhqG6eC7BU32eQT741wRf/OaqkDobhPq1Og?=
 =?Windows-1252?Q?hbSGRsIvnIWA+EUWn582bFaX2DlaEjbU70IL5Fhie281R5HBUFlYY3fe?=
 =?Windows-1252?Q?/RAVjrJx9YDEOY4IhMEeiHEHlwacT7pRF7PqfMC4keA3ZVVeF+uovf6i?=
 =?Windows-1252?Q?c/XRIvBZIDwxwrt4X0RlHsNOkGeib9XSOT7H1nc4xdq+bUJ/SYh4kx72?=
 =?Windows-1252?Q?r5F35YXm8gHwr3rSn1pWWTc/1sAE9BKYGQirrGqwBOMbWNCRpVhA6LEx?=
 =?Windows-1252?Q?tUfVjqYlMNZb0iJtDxKuoS3JdocQz1/UiFTacqVaCLncWLF2yFMpnKEw?=
 =?Windows-1252?Q?pSkn4U3E1dzHBpTy9wPNYDJWQZCYxc9EV0FdSoYXbuLjQ8z/8Aofgba9?=
 =?Windows-1252?Q?f8xhLwfe4RXdsmRRLU9B6bAklGR+jzW3dWpEt7pM181Y7eTIq92bLz1f?=
 =?Windows-1252?Q?1u4gcgKw5IMzKN4ivGtMhlhwexjveiVxA8mXIecHKNCh6Rb3460kgNMv?=
 =?Windows-1252?Q?o1tivBSBcFylPo4kmfoUrmTALVSFdoypjbayJ+QIXKnThGCo8MZqhMgJ?=
 =?Windows-1252?Q?kFDjEpoiMzRZSoXipD1Gg27PVuHsiokziizfLbxFK6j/mlhgwNYFg7Ha?=
 =?Windows-1252?Q?Ev0VoecV4E18GKqHVdTkdfetbrFaSU7+rCoHUB+gYFO5TGtLGD7FIjiQ?=
 =?Windows-1252?Q?hkNPbFYdeHofx9Favu5TzODYxiHnWN7W2oMT3RC2Y+c+UbT4v+255n0V?=
 =?Windows-1252?Q?HHPuKhg4S2M7Qwy2HCNsY+24bboa445HDbpU7+1NVGO3vm5Q2/Bl7BEx?=
 =?Windows-1252?Q?bScTA2C1b1wId4PheMwakE3Kh4JUxbAV2K1/o0VAn8ewntxOXt3sIwhD?=
 =?Windows-1252?Q?imYVJPi0+u0zaxKL1iu+YHtNEpnkz11ZC3d1q+YjJRT6swhrLE5v368I?=
 =?Windows-1252?Q?JwB2e6BKXuQbeIs2TCRZKrjdcIwm5ZLc9DBOXIVDmNKHbdO+64dd9d3/?=
 =?Windows-1252?Q?Q6pX/AWF2UsdPkAGHN490WHVxqwHcHmR2Nyi/jnjcg5qHeWtikxRAm85?=
 =?Windows-1252?Q?L8TekkO48R2lavPvAf5IOCgmqYlSWRdaAsqMe1LfNNLCbPHFudfIPjI5?=
 =?Windows-1252?Q?UK9h4XBPoxaoGx//EhYdn+nQxmfPvfA07izRtlXfb0MQfthL1hZCmQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 eca0468d-93b3-4997-7d09-08daa847b186
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 09:38:30.0247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 FeFfUZ+FN+7T3nsX7MeGBeqpmmMakSJPLAk/boZZXEvl3ElYFWTfU+b5RFN5es2aV3AOful7RPQPqaU7UkIR/kxl00oQyYLuNY0H4buveW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6060
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 09:38:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9674

Hello,

> From: Michael Adler <michael.adler@siemens.com>
> Sent: 07 October 2022 10:27
>=20
> > We need to find some sort of solution for building our CI build contain=
ers.
>=20
> Why not use the shared runners provided by Gitlab? Apparently, there's
> even a dind capable runner (tag gitlab-org-docker).

Yea I was actually just looking into that :)

> If the Gitlab runners work, the next step would be to make sure we are us=
ing
> the same version as Gitlab.
> Since we're back to using the exact same versions as in the previous clus=
ter
> (which did work for us!), my guess is that
> the culprit is outside of our cluster, e.g. Gitlab or (less likely) kanik=
o.

Agreed.

Thanks, Chris

>=20
> Kind Regards,
>   Michael
>=20
> --
> Michael Adler
>=20
> Siemens AG
> T CED SES-DE
> Otto-Hahn-Ring 6
> 81739 M=FCnchen, Deutschland
>=20
> Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann
> Snabe; Vorstand: Roland Busch, Vorsitzender; Klaus Helmrich, Cedrik Neike=
,
> Matthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesellschaft: =
Berlin
> und M=FCnchen, Deutschland; Registergericht: Berlin-Charlottenburg, HRB
> 12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322

