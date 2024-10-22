Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F52CDD0DB
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 19:36:12 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.0])
 by mx.groups.io with SMTP id smtpd.web10.2998.1729625750778902622
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Oct 2024 12:35:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=opgafd89;
 spf=pass (domain: renesas.com, ip: 52.101.125.0, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ms8TKa0EQ3No5vd7DZ7iYpsEwG1mbPX/DxbJuIR30rDAZJ6i7C3CfyHJKU83l8Osh5qaM44J0psBZT0cXlHfcZbOinuUzjerv7r/r3K9Pj7tL1q9afJZWvovAi1TAy+v9OLXQgLpi7h/DjCficHsga6Ne826XpprVrh7YNrq/SFNMsdoNDxjdjLTK4Ahx4/Yif9B6/nf9UlSNAmfQLIsIR2L3zflyLOa0P2ixI04tbJU2zikYBNWeoaBfc7ompql1/OkBUsSSDil4QhX51FLwYYfxJkft0iKC+nmlsO8KTSPUBPLNjPycGVFi8mq/HZrT0y7tXNUl0xAr0nsSWx8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itqkulCGMod4xiL8LWQx+YTNV2q1avwW0dsUeTdvIo8=;
 b=on2CgkIsjb1T9tWuWzUp+PUV71VU1XAysXX8ANDThQ5QwIpQvCMT3Ch51tHlz1GIPn0wWAWOnFy+tbU31QweE81m692tSrgYoAhO+ywy/g9Tlrl9zq61eISe02Q/Hhz9ZvLmAa39Z/lZ9iftOpzhStCJivSAdNCZluT9x7JwbxYOEeTqfkgIqjRJKAxTdFp9mntxX2ILxPfVwtmDtPc00lDsvM095+fP19ZMe4SUbyeJoC7YgKBNrtjJQmU2VCv7w9f5/hpTLrcVd7QeC4WSqm+/PGLLtBPAasIISBxt95ze/Q3XrcABpb5hbxjWjzR/aQOPNyoeZANC63dwB/gcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itqkulCGMod4xiL8LWQx+YTNV2q1avwW0dsUeTdvIo8=;
 b=opgafd89GQG/GMC3xDHLNivdl018lvbcE+XtG+1Ufe2QD3pycEyVuyFIZ6i7QNytCUk/rLP/CNU3aqTQa4evv8r904oxZ9Kzl4bsFCwtMo+YgV9ilfPZRvVb67r7L3USGYoNiz1f7AJTuJ6gDDtZ3S+JSboC28a5wyi88HNV0M4=
Received: from TYYSPRMB0010.jpnprd01.prod.outlook.com (2603:1096:405:fc::13)
 by TYVPR01MB10685.jpnprd01.prod.outlook.com (2603:1096:400:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Tue, 22 Oct
 2024 19:35:46 +0000
Received: from TYYSPRMB0010.jpnprd01.prod.outlook.com
 ([fe80::f790:8fc7:6cea:6303]) by TYYSPRMB0010.jpnprd01.prod.outlook.com
 ([fe80::f790:8fc7:6cea:6303%3]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 19:35:46 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Planned LAVA maintenance
Thread-Topic: Planned LAVA maintenance
Thread-Index: AdskuXeAB2qSQwqCRu6Ppi1fWn2KlQ==
Date: Tue, 22 Oct 2024 19:35:46 +0000
Message-ID: 
 <TYYSPRMB00104FB6FD73998B2F47C93AB74C2@TYYSPRMB0010.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYSPRMB0010:EE_|TYVPR01MB10685:EE_
x-ms-office365-filtering-correlation-id: 32a644d8-4190-46ef-3436-08dcf2d0b9ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?VEAXnaH/MazPpxpCbwEsUWVrrw2GOmMNU4cGXwXx+VhPfZvm1tVU/IN01P?=
 =?iso-8859-1?Q?SKLjTh7IGEUSfRAOKvCNXins8uo3WjHZFhoZh9uuwcjrDC+jQA3kidaKl4?=
 =?iso-8859-1?Q?70nTr7tshQk68OTS+uLLgrwyyxDFqgbDaU7XhWAJx2cUOsx9CbcjkQ188r?=
 =?iso-8859-1?Q?QRY9ZpNjP4cN2YdlNtVpARIKtse9dm41bqrXE9YDY7Gi8qbmRNiZRV3Ies?=
 =?iso-8859-1?Q?Iebqei6I56E+ROlOVSfgMKokwnwfg3S83hMVY+eAGq7iwZyBCDKIJmfSmB?=
 =?iso-8859-1?Q?agSQnnVA10i0JnrCZbQS0923y0Oxwl3b1oYLLQoBm8wx6Np8b54U9sCKLY?=
 =?iso-8859-1?Q?cI82DuyU13kwVHzycSh3QvAgwiWXH/lPrhoA1VDbhPHTU06/PLcI512IAe?=
 =?iso-8859-1?Q?2OzeF+ljEV14hfIODUb3Ptd1eKp6tE63wzbp1S/tL9P4E42cV2YNCc3Gk2?=
 =?iso-8859-1?Q?EwkilpFecXgC+qg7Mz5MIKH+rHRwimexui1nBnn8inJ11XBzHYH1BaAk83?=
 =?iso-8859-1?Q?ryuh/LdVvUaRk7SwlGLGrKRD+CsE/QQ+78fbT98bkzekg2noa+bBFAfUB8?=
 =?iso-8859-1?Q?FUf3rKrdL+u2uEhSfitgmi9UozS8h2HmJTZYlF1HTjAv2ZPQcQKznQBHez?=
 =?iso-8859-1?Q?GbGhG0b9qTWNyXdIRsai407KgiyTSrUFi8WKXCt1+bM37CyJvRqcwSX/3u?=
 =?iso-8859-1?Q?Vfn4iINR1B9eclBWzsU15YmXvCs4DMMCzW2lD3RXlh6+mBS1ta9Th5axLh?=
 =?iso-8859-1?Q?dQno8wEVryCldLlgb0kJdbe0+TDMkM7YOhwW3BWV58RUWE8S0BdWDkeyPa?=
 =?iso-8859-1?Q?JyUZhbzNR0ZU8aYduBYPSxsxUIG2WDg9RWWs18HOzV69+3nSb1w6rLIwyg?=
 =?iso-8859-1?Q?7UoTRGeG9RcDnG3qY/X4zrkFRI+3PMH6175uROJrjBr1xTh4Cgw2c48kwP?=
 =?iso-8859-1?Q?BB1DODI0v+6DGayeFWoK+Hxp2Q1Jr/uf7v23XT16c1NB0gtGW/q1U6cR9X?=
 =?iso-8859-1?Q?NYyCd3GeVik4DK77i6V89yKLy+dkaLkrXTNLTxMD+43N4A2bApPJh8GEOn?=
 =?iso-8859-1?Q?5jJlpqq8jI1vop8LkvyfI7HVtIz1k+DblYXjYVq2YSe+Q0ZN3U+c+ie0Be?=
 =?iso-8859-1?Q?5itS+CZ/0F/P68qV/70U4eW6uh0vKWFZFb6isdPRtQQ9qfQOvtHAnoWBB5?=
 =?iso-8859-1?Q?beHduD794O5hpYSsoib6+U5F9AZesmNl49VpGEH5WxorcH0wZKCiPKO2oX?=
 =?iso-8859-1?Q?g4hEsNCS7UvaygWT3lADt2KFc/aTPti05FZPlTmSgovQtuGwQEww4c/RQc?=
 =?iso-8859-1?Q?izmvgCIF0uemw8CDFEJ6R7dpi5+Cgg+15edn+IBKcWn2Id+uE7q+JULvFe?=
 =?iso-8859-1?Q?cEOICjPa64VN7kiI8LxoDV68VMDH92gywq2sOLrgA4BH4EJsmGNnM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYSPRMB0010.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?S450PV4E3a/OtACGSQJpcbuAUJ1wL3MJ3gSVE0q8wl4YcQdMy1WZqGEnc7?=
 =?iso-8859-1?Q?vOQFTj3GDjWya4K2zTo5JIDDLJdLCy+zveXK3BQxUE675N2cRWJn2qVCgb?=
 =?iso-8859-1?Q?Cu/Dprj3iMrQ/z40W9EoZwTw/vqkHnvTQGe0hDQoTwrXih5Be+a4VWW+gd?=
 =?iso-8859-1?Q?ULTfoX9AHEVH6pWTcv8V0wU3WoWBXHBdo4sS3RQbtaqkT5sMrkI2wZWYse?=
 =?iso-8859-1?Q?JH9puRyCI1QqXjgwzYdaeoBN25sBwlTe5q/XptCERTZKyKKcYOnuTNrBFX?=
 =?iso-8859-1?Q?ikPnVpMQ3mp97mckYV3d9f/7CXC2/4O6Yi/o10MdTQdn4HXd+1fotQ0QtP?=
 =?iso-8859-1?Q?qXZfD4dchABEtFkrues7hhFTizog5hlFm67bQFjHC9rm+IdVdpI8p+Ok4P?=
 =?iso-8859-1?Q?OVh/0xbACAbNb9+suRwERj7q5lMmdCZiIs7Fm2/RxfdxQcQNDWxwcDQ4ln?=
 =?iso-8859-1?Q?9xNUJmy/7fnQv4ynUgBofuUoRG0Rk40W/0auoATfJWMV+owcaVd2hoLado?=
 =?iso-8859-1?Q?5359vadqmZsEpjDe+QVPqlVHjAiO08scmQHk5lpffcFjHFGexn/hB+XS73?=
 =?iso-8859-1?Q?Y4jMULRYDm72AGK5+rasuge5YevAfxYNOz9hMrj4pNTPBYrbgkj/QAGA6G?=
 =?iso-8859-1?Q?vskckZ7x///kQ9vmxJ9h09t1SzBtu76oqoJQWsGzWQetNNtEpvXVh5ioZp?=
 =?iso-8859-1?Q?fsE2ItibtpVwYwBdAG/n3TrCQc2xmEPO7SdgtZ+daDaH2ZRDBhC7KQd8st?=
 =?iso-8859-1?Q?/4/Qmy4XCISWMVOaOZECdk1+RBnb33/xYh7gPRYTbPjZdBG0iLCrcmj/Yu?=
 =?iso-8859-1?Q?sEZcfWC8JGVgchbJKxHTU1l6tQpHDoLRXuZItpO2qwHJtdRGSsrKisYd8Y?=
 =?iso-8859-1?Q?4sZhgAjDzY4BAw/yhWqOtQLCazOlS4GnuTuC5Ea+42Ob213LHe+XAJ2oBz?=
 =?iso-8859-1?Q?ad4NPe6rX6q+/ZuSGJrMIFbZSd6WRvbvpz6JzsDy/LIFMgkXH8ezgiPYzj?=
 =?iso-8859-1?Q?skM+qXGtHrm4r68UXNz57cpk0QTRLMt+w+V0Jdrgdtl23acpAGvbqZcvB8?=
 =?iso-8859-1?Q?hh9RCbDYc869drCg6TTFe/JLnStEZ12W1nyR8GJZng2Y77lxfQaPWW4+p6?=
 =?iso-8859-1?Q?+x4Ms3txi1GyjoHjZUpPxwQ4GjJ7q2RBwdK9bu0R52K5H9qrmSI8GV8K8s?=
 =?iso-8859-1?Q?NbkeoxYyUtqdVoEXYMpod1/0Bz2N+WfYJC3YG+9KeQL/3u8hTVWiOLYuGg?=
 =?iso-8859-1?Q?ahAM5bm8+Rh8RQUC9+BsYooy35dn2KuhScWfpLL4/a069ubTNY2ULCmG/I?=
 =?iso-8859-1?Q?uTR2mmSzPz8pkXuNsWHeKkz1Ipzk+wcTbvkFhTr612FRAnPDAp9ffr4zT2?=
 =?iso-8859-1?Q?abP+hpRBUI0QFEmJxMpTOQK9aGiGPe1g11G1ui7Oi2M3cWb5dxsq5RjhXW?=
 =?iso-8859-1?Q?soNAOFR+/ttlkY7GNk89M0QQDrrjRfhxt6Uk0+ASxHIoifwFMxV89z1TBl?=
 =?iso-8859-1?Q?Xiec58cBXpGLGGYnDeALBLlWB0XtdvsX3WmEtuSqzvoh49dg7JDMmrg76J?=
 =?iso-8859-1?Q?/N6haRxtPp7a1Sd7VSa349UWWhTIgdtRyQZkFWBF1ECRyKM7jafiSAHeIO?=
 =?iso-8859-1?Q?V1cAM5nJKTPwJ9gHqpuwAaQ7b7DDxW77IRzj13dFSiDxfpULFTQM1gbA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYSPRMB0010.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a644d8-4190-46ef-3436-08dcf2d0b9ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 19:35:46.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6hIJto0fnpHUDhxUIKUv0RJEdaW4JRcxtcUvFh2LNmoivPEsLHPj8BvnJIKuYRUAtzA8N1K21H6hap1D7LpQ4meNc38lQuEQMW40aY8Ii4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10685
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Oct 2024 19:36:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17069

Hi all,

The CIP LAVA instance will be going offline for some planned maintenance wi=
thin the next couple of hours, for 30 minutes or so.

Kind regards, Chris


