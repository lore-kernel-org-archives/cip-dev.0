Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511DAC433F5
	for <webhook@archiver.kernel.org>; Fri,  3 Dec 2021 20:02:59 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.91])
 by mx.groups.io with SMTP id smtpd.web11.16412.1638561776865454611
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Dec 2021 12:02:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=RATUGQFk;
 spf=pass (domain: renesas.com, ip: 40.107.114.91,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPOsfs7dButPAI5+eRDAZ7yuIfQGN5TIQAiocclFL0TTyDX8Q7UtVIfRPq+geNVWIxx3zwsPYCy0d2cs4SPRLMfLwtlQhowF4H/VJRfHD83OoFIjAOGQW1urInhUd4uAY4++1PjoOkk++FY30YyKopetg6CuRY9Q3j3Ll7xbPCq7BvME66/EK8HR1JOQe9v5J7Pk//2mP4K7zXSCTF99oXRLQLls5vLTxo3R9jIS/Jbxb8xh+pC2WOVD/auorZgv1eDkJkh61mvExPq0jwVMCT4ZObVW6Da1Wjwpczy7SMAOUcwJkmC6p1ZFatJNZtN0+RN/X1Eyb2efsRe+Bdh7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGkH4LBagIS0xmXNA190U/rzVUjXxoeIMGhHnaGIV0Y=;
 b=Vq5WKnEaQUh4godDBjD4e6Q6lx2yRxJDBqc4sNGSQAlj+x7mRDSE1pn9vtmKpV3ceEQOq8Z6BLrY7ZqA5dO0hiesI7/CXPRTMnM6pRuj+nlYakkAteMZxjFGUarTOy11mTeDr8WSXuV+xQqoKkQKGPaHjNAka+TRL5S8GwXXr0NLS1sFHEEGh2I/SnJ/08NSFhDTCyu2uvWYjBHDQzT4zDu0wRZ1lzZLvknsiRTzeM9o5OuoulcwvwROexKgWfzNvB/f2vNQrwNKH5Twry/zj/IuDwqTHCz3zNy+vFQP82jJa41Lp7Irw+xDvYMfa0Fv4UgSK0Ldqx7gzSwsb4RuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGkH4LBagIS0xmXNA190U/rzVUjXxoeIMGhHnaGIV0Y=;
 b=RATUGQFkRpOAXWsB9cE7OqxW5nW438OGFVHeBxft6SxX5rT+3aP4PxWuxqzfc4hqGZp+20Vn5l9JYT+RDt8+eqTdK6iE0w2eFx8t3iG49uRjhUB9aEer4UuE6m5s01s0Qzr5xz6EvHUng/zHinBhlXp9dzIgpQI/9/M46pHp9IU=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSBPR01MB3543.jpnprd01.prod.outlook.com (2603:1096:604:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 20:02:51 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b%4]) with mapi id 15.20.4755.019; Fri, 3 Dec 2021
 20:02:51 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Planned maintenance for lab-cip-renesas: 4-5th Dec
Thread-Topic: Planned maintenance for lab-cip-renesas: 4-5th Dec
Thread-Index: AdfdQY0ruckuk3pKRXmKZHiU8njZGQLPw/GA
Date: Fri, 3 Dec 2021 20:02:51 +0000
Message-ID: 
 <OSZPR01MB6877305DA1F2B361D1B4F200B76A9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <16B8F29B24FD30B5.32206@lists.cip-project.org>
In-Reply-To: <16B8F29B24FD30B5.32206@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b53aa56-9f76-49b2-fe03-08d9b697e2f8
x-ms-traffictypediagnostic: OSBPR01MB3543:
x-microsoft-antispam-prvs: 
 <OSBPR01MB3543B6984F2BE82D27C9EAA4B76A9@OSBPR01MB3543.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3+wGrh4j9AP+KH9NabP1w1DVtPzvxP3AF1AY0/AYVB+Wtt2pviRGTPAS3Omd4hj+L9dB6FLEf+BlP4IZ/HUj7ci5MarN5tXtuSuuUfqmLvEwZMtE4ucV4/5nnzLaDPFEhNHPZFI3poMbCb8Z7VlhEy7A/b3mz9wrnKzwm/J8T0XStWbWza0IlT4dare+Ljj3frQ+9OyAABhPJVSX/4FqwadDSPqSZD4nvquPhhDI8xAcoQHESMIHmpWjAR+oQ16ZulPVMHbmnKanZQKFKh731G7rQ4XSqIxTcwHNS7Asbcw3nFXi/KBjTMuIoIhlHmqQEKBVRQg0x3Cya2rYqMgJ/x+0yNyxr6lIBKIQuC1r4wzXntsFwebkr8dPXdFvFDMPHznMBVlcWFGq2EcyDtUFe63zK6XZhvDl6wJmXRHPjuRX9IQxwV2bDTfD29b+yh+8XJJrlmUh3FwlRURpDS7ARjLCFBmvy3kzMXHtq5eBElmVfHqOxBj+pfWsQux8iQN+aBjPd2SRLRatBmcyCApOtzwZhsXdjjxF/M6L3IZlZSHxLQy9gz7t1kXGZUbFBjyAXKUGNSW2dHIAjPjZV0QMhXi+t+4k7v07ZJtecRZOiC/5MRUERF0WutSFhy3cjFHHvkYRM2sjyPI5gosP0b4z2zRbL7bn5ELHLC/hVXmU2NDh7A+XycMD2M7ljcgP0y4DxadEdBRcJICdQa/ekMno7w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(86362001)(6916009)(66946007)(122000001)(38100700002)(76116006)(8676002)(4744005)(55016003)(66476007)(6506007)(71200400001)(66556008)(66446008)(64756008)(2906002)(7696005)(52536014)(316002)(9686003)(186003)(38070700005)(33656002)(8936002)(26005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?JBIIVdKNsE80IXD2U9hFgRHQSwcGIIBtj3U1DUXImqcuhG90D2vD1+lD?=
 =?Windows-1252?Q?BJM4vsNdI/YsmlNOMIPEJEjAyoEVm/JzZd/8KgnVlzQ0VYFK3xpmckd0?=
 =?Windows-1252?Q?qS3pLmYHTfxS8+ZjwY3a5WYwIwhq/itaP3tADK0Z0i9yWcqnUuB/eqC/?=
 =?Windows-1252?Q?AxY+aD2q0BP4k5MkqkKKgl4tFbo53JKh+YzCbnBd7KIkHXmkVdXzqKIz?=
 =?Windows-1252?Q?cKHHaAiPz56BVC+ig3dJMqd7R8BXzz1lp3F/rQC+eV3pq7hjTBolp8NV?=
 =?Windows-1252?Q?3Xsu1XsVW0wHrvcFg7Gg+XQoVBWT9C/O8SBEXKVsHeFL5z3a4VtAzrJo?=
 =?Windows-1252?Q?QssrOWH8k7Jla+7hLCEPWsPhx1mR7baLZftxQH5VSlpcjPzUF30RxnIq?=
 =?Windows-1252?Q?uxhEEpAVvHXp7rjUjScmpFH1UETTWy/h+ocRY4N4/B8KjiMK8Y0aKC2s?=
 =?Windows-1252?Q?A7TutLHWVwZYyqr4tQ63/kY/V8/QnlfuJ+/6ElCqovac8muAwAV59kPF?=
 =?Windows-1252?Q?3sY/gSEzUH0gMoVF+oysYn2BS4JHDXKkxf0NnJ7nl22K9hvOS1tU0xF5?=
 =?Windows-1252?Q?WATL7LLU4L3erL6k2DRurtTh/5Y3DHikACUoefESz2nFnCNVjk3eu3PI?=
 =?Windows-1252?Q?OU57ambTVCtqwGDpAh6tOdX3gx3kNKZ3fuuB8mBqCPuRFdxdk5gIwAGt?=
 =?Windows-1252?Q?CmAkmyaKi6m3arKzSWxTCySDMPVTl/6wYGYwh35jp1l/eDl+hEqPl9YO?=
 =?Windows-1252?Q?aWHL8Kz4qvAUUAKYAh93kATNhOZ1qMdWiYLbGdhqx0B+BTPyXoXQW2VV?=
 =?Windows-1252?Q?r8P0wkqybzJk3GvvKcgBrAbfUkuwusQ/WRm9oaKv1p3TWjhXZRtiIT4j?=
 =?Windows-1252?Q?BWHN4OfM17YuNnCr6qXd6Y4Yd/J2WcRn1Xzs4JgsbY60rJfJJ+zfEr9x?=
 =?Windows-1252?Q?eZvlI/XAtg3ywJSaHMIMz6jUtK6Mlv5d4aah/TI04Wy8QtFBfHUKcp0x?=
 =?Windows-1252?Q?KWcVq6uh5/n9u8PR+RrMRb7PIzZKJxy5ZZSXs+dkU7qchKBvBDaK1g15?=
 =?Windows-1252?Q?pTtmhJY68WfjCP7UVY1QNyi6gikGrfotiq97pRjJrsVaESsp4OOw38gL?=
 =?Windows-1252?Q?6dk1g3B8muB3cRnvTYdCnmmOZQ4FLd6XGzXxFSNtqfIyFzq18ovqkikT?=
 =?Windows-1252?Q?JBJsC1glqdVh03DT+ElclQlaj+24RZqfBHkkYwwgEmOwoQUKg+/dqtC+?=
 =?Windows-1252?Q?hHVSEx1WF5uNFoMYKNB13booPgM4pwXUDZP4Bbfjwmm3QXezmTd/WXOv?=
 =?Windows-1252?Q?phwb1HtskOyI8TWSIg6hLA8suBErXTt93wHNMkuy+/N7QgvImjsLZhK+?=
 =?Windows-1252?Q?6mMOLQHVbwultmkp6d0Ts81NVCLzuciR8AAYIRZ4B+kouma84LLgtm+C?=
 =?Windows-1252?Q?OMR7/zLtC97ec0iOYr9YWUUQfHf8TJtXiSBvTDSt4vTJ9XriOEnREOKV?=
 =?Windows-1252?Q?ayCvupThtNRoN824lUAVZ+Ui2tg75kZ3MtPZaoIeJpcCL8IS0G/MVJuP?=
 =?Windows-1252?Q?ldjft2yxiRgUOeSK1TiNpQV4bqYBJsV9a8WSDP3i5Sn0j1FcXZWKtMta?=
 =?Windows-1252?Q?ofe40bS5bll6RP7nUq8FfKz0VeqqG0J7eDTSNPlM3A3R+SWOLM0NTMBI?=
 =?Windows-1252?Q?1CZU0JgPko2x1w+j7pe1TjZjOJeDmI/+5DLd5wg60iLUUt1cHf/icDOo?=
 =?Windows-1252?Q?lwEtJW/QFNbYfXwE8eKLznZtWLDa0IOlTqNUAdAGa/W26byX99JaKMpO?=
 =?Windows-1252?Q?OZ8erg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3b53aa56-9f76-49b2-fe03-08d9b697e2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 20:02:51.1266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 FepUY+WgOc9LAikJt5q5OA8bKlrqDQuXMl4iuU8sr0riC9eAopfeCCA6wAA4I9vfuuWk/kl0ej204vxKXzEldLQ/zcd7Fsp7Hff5h7Tg8lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3543
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Dec 2021 20:02:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7060

Hello all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 19 November 2021 12:33
>=20
> Hello all,
>=20
> Just a heads up, on the weekend of the 4/5th December the Renesas UK
> office will be undergoing maintenance on its power infrastructure.
> As such I will be taking lab-cip-renesas offline for the weekend starting=
 from
> Friday evening (UK time).

lab-cip-renesas is now offline until Monday morning (UK time).

Kind regards, Chris

>=20
> Apologies for any inconvenience.
>=20
> Kind regards, Chris


