Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFB2C46467
	for <webhook@archiver.kernel.org>; Mon, 16 Jan 2023 12:47:07 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.106])
 by mx.groups.io with SMTP id smtpd.web10.165386.1673873219614928894
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jan 2023 04:47:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ZqWimk9e;
 spf=pass (domain: renesas.com, ip: 40.107.114.106, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKvqMCZR1uudmykljb0gJ6UHEVrUzR6lInm9E6WyD7pgDoTDXsQlpoIN3GQ/03xZmT9uQeT6tHngPwjwZe5fxO9eSecn4c7WMZj4dpGEnTroqhTYX+JA/DCwxK4tjSO01Dw2c60q8ZyfWMMbXUST7UAhvPz7VovyogJteF/bDfROTJvv7yPYAio2h7XrFCccBKxJmUKfjIypnSE9rvgQW1UKct62bhsKqDweHvp6ZL+8z6SAhw38UUMgsUsG7VzyAwQ15GUCjLWh0aKZRNvUZLK8KSQ1HMAjHmW+wirFsn7NtaHOlWfib8a6Z/6W4U3NLWMfp+P+lUMyDOb0gZoMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uw2M5p85jR4QYWVlTlRPdarSqEpquih0k1p2Gm+pdb4=;
 b=bx8RpkPCQumzlZ4ewXZ1nO7Cb/DNVU45oG1INwVwnZzh1Ia4ejLNL0MAWjMI5An20wQYFBpgHBNreaZszKYvhFZd9Xu8/XtBoqaNne7sE16kbeusxrgtA9u7sa1tG7oKDVXoBIuvEmrZmKZJfkMAiAaivyLv89vJkxVDJKX+E5fjSIjmNwaYXEG6akVUjhY9k0vzKV/NHKd8wpvW36pepWqL9KCPxCQnx881maLoVUuz8bC4b+WSCQXO9u/ldDoK9kOK+HeK+w+hS6Lfg7HuQR9zZm/mAKzcFM2+wk5vhtn23BX0GENGH5X46EYhEqa+nCG9LDD+eF1op5xVsjugDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uw2M5p85jR4QYWVlTlRPdarSqEpquih0k1p2Gm+pdb4=;
 b=ZqWimk9e6G12+VX3XD9m5hBbBT14vKLRfCOJmvHz77RL28jqjtha4nSoXKXtyNBVwafWbFLagu/ZrN2Wa2Hp6QIYMEacJiLeUVCED4h3PQzSufqDMHT/ACGVPsDVgBdMpw2fc7qnG2UXPYwAOdL4W1xQKDdHrN9gT0PJH074jH8=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYCPR01MB9642.jpnprd01.prod.outlook.com (2603:1096:400:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 16 Jan
 2023 12:46:56 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::943b:564b:b02d:f78b]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::943b:564b:b02d:f78b%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 12:46:56 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: RE: [cip-dev] 6.1 LTS
Thread-Topic: RE: [cip-dev] 6.1 LTS
Thread-Index: AQHZKAKmIR1C9DY8uUGBbViY/USWrq6fs3EAgAEqk1CAABxsAIAABhrA
Date: Mon, 16 Jan 2023 12:46:56 +0000
Message-ID: 
 <TYCPR01MB10588119C91FFEBC87AA36208B7C19@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <c4648640-e690-5afb-85fc-85bb81889737@siemens.com>
 <Y8QvRNxsp0N3Sa2D@duo.ucw.cz>
 <TYCPR01MB105886142D52E992A8E3AC6A6B7C19@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <4afde947-2482-5c4b-6eca-ccd282b693c7@siemens.com>
In-Reply-To: <4afde947-2482-5c4b-6eca-ccd282b693c7@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYCPR01MB9642:EE_
x-ms-office365-filtering-correlation-id: d098f453-981a-40a8-9aff-08daf7bfc02b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NxNvoBZ2OeGSLo+5/XTeClYjYWwK8+4eYCObB+2cLhxLPCea2Ub+06o7uIQZBmkG/mtJIarWqbIaTcyDM6gB9zI7B4rusnZ+/Hos9He28MoP78je1qQ3A7bfVRwzfHQEOeBZWJ3KCsRgn2I3vuaH/qoCDisuU9os9RcakDH+rAGj0XQJQ1+WdDEEat/EBADWjic5eu1b0KFJxZdQpLbZS7GxAQmw+WC7Jipm/1drmCVlljJtkFwUDNXZaM3AoAvylI6kES4pFyf9A0ENsXvJzE6PFQ94+IDCF01pHhSW9zyv6XDZdOGN3jyqIQfUHUiEOeSCEslQsMgj+AtCxCAJPEjskJTcBIYwlY4gEAwMjCLP1unl3mlNxfGjXpCqHuM/BK5PMjenHYO6j2taN6S6+gr16IpNdFhOhge3iSoAEeQHMfd/xrezWd0ln1tv1Es7ATnxaYRPz3od6WpvUglD2rPFjaQbnzYP/dSOb6Sfgs8yGtM9QqkdETdOHuIwSddp50jElRUpBLjstgSOaoBojj7Es+GO5UAsU6yaRaS17/9LXu/6rDpOpV/Q99S0dHLjm93sFjuO5mVemBi/46rLxjxa5pE32f9o8end3XGNxmM6cHATCfzwluvg3iPL9tWrnc8PCAKm9oWRV/sgoCylrBn3mg69no1jdEdMLUNI/gvZjFo5OGOlnYQSYuhTIabn8hIqPNl6MC58IiFqCA3OdQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(9686003)(6506007)(186003)(55016003)(76116006)(86362001)(66946007)(66446008)(38070700005)(64756008)(4744005)(5660300002)(66476007)(122000001)(66556008)(478600001)(110136005)(8676002)(38100700002)(2906002)(71200400001)(33656002)(26005)(7696005)(316002)(8936002)(41300700001)(52536014)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?buwL1Ey9P5BScEYxH9croVqEmAb4gTOGeGQHNfbbEdc7pVo50s2heBk4?=
 =?Windows-1252?Q?NS87eglTKl5QlAXLCzkbHvCpqc0CgaJZiKaz9B0BpSd6OPpJ2t24W+5w?=
 =?Windows-1252?Q?61uc7hUfpog0dfGLX68PxkTwVVRjNbqGXVDi4UQ9ENCIgEbrQeIO2M+T?=
 =?Windows-1252?Q?yIv+numP8HjgzQ2VmIF2Rxfx+4u+vY0RUBXNxVKOBluKCGTTpl0fSbiS?=
 =?Windows-1252?Q?yuCu0Vqno5JgGP6kB70l+i+tYqGcQXqG3LT295XPopiIP+VFhDW/jko9?=
 =?Windows-1252?Q?eOjRFwzppEbhPimvq9xZFEwVnmjvBfISertCardr50I6m2DQvXPhzPx2?=
 =?Windows-1252?Q?z/ThhZuvik9l3iwhyDl/8Re8OKtDIAcmJQoI40IdXbqA7OXgTvZjahnE?=
 =?Windows-1252?Q?sWUKN80FU0fHmpex59g9Nvs7A6G9V0UmdPtjFoCJ7Bru24gMuxGxcees?=
 =?Windows-1252?Q?QolbWjHk5Av32L/OiXS7dJbCghABMb8i5Nu9DhIoUACojgtSCKIY6kna?=
 =?Windows-1252?Q?xs+ACdax3nyIHlsVYBo/Zj+2aMW6iEOv8l0B9xtwimeISiTyy7YAE8+B?=
 =?Windows-1252?Q?zBhsRzouPETx4LDwbYI/nPzGuBuaY3TZMpPHmT+na/1KgDo26yzVq9Mz?=
 =?Windows-1252?Q?OxSyAa+IZ7oWc8tsM2STCY81NOlosbrgV0Glntzg7T3yp32eS4v1kbmQ?=
 =?Windows-1252?Q?ausklIsGa+UyMnPCYDDi0BtchyniAoFTOSfpBSZCWeh3sFoSGqxtDv4i?=
 =?Windows-1252?Q?h8zJfP254KLpFfuDqzCLOwhncHEe/xFOmzS4Ss2xhAEwfHWxHDq+WFzl?=
 =?Windows-1252?Q?BgyW9KUiBXL74M8fNHMv34qmQqhEyLbPQ0IEHalS6TlXKzBiWE7IvDwc?=
 =?Windows-1252?Q?xOei+IyQH8jx8VyMOQfXdRlwhKKCoxRYPAS4ZyGUqtg6rHMcXaO+0VBS?=
 =?Windows-1252?Q?h+d0FkEyu6F8neP11WMgr8xsqSwR3sP9LrEUyzk/OK6HIKpDH8nAESKj?=
 =?Windows-1252?Q?vGLzPa3ig3StBy+erq3H830ijTNMBSsjyCm1M3aqgs8Cuyjgh//X0wRF?=
 =?Windows-1252?Q?WmvecXR3KBFnwBVD0bzYZlcaVkqVfD4nMjXCUjiAwApd0D+wLXQASl92?=
 =?Windows-1252?Q?yBYuf2HIjyX1oCATph93eDtiHr+wEGSW07RKwBgf/O/r/53GsfMoYTrc?=
 =?Windows-1252?Q?6XU7BN+YVdJybgB/mys22MFHMy5W66Urvl9Eul40taNSnC2DgrmiG6Af?=
 =?Windows-1252?Q?+/x1GpY9BXzwz204fvsYWOsTKVChekBSa7f30u0RfAIIvWB16TEiqkP5?=
 =?Windows-1252?Q?1NoeJ1lSEvDYu62Z9GwTSkZK7YK0nrqgUeOpbchCa451F530j7/NFb0C?=
 =?Windows-1252?Q?s2SEr5d1kgdt4Pfb72tUcSSaT/VRyKnZreR+UFaQaFz9+wODI0aMZ0F0?=
 =?Windows-1252?Q?J8UCCOveNSg711PSPLZ/3FTMiQ39gioe/Ze7uvFVNprGsLrBJkPWNqWv?=
 =?Windows-1252?Q?OcfbQHj/0sdtsgkz5SKUvelsSErCL3rzZ/THt+JQMiF3kxvFw5WXKkBL?=
 =?Windows-1252?Q?+bRx+de+IGJ2Piup89tqHqt6JGTyrjHJrQm5ZYT2d83GWNmfyBDciV97?=
 =?Windows-1252?Q?mCQtCP0zgnZ6zZIUp3ZtjeX5iO09IUa8+606xl22QpMRsdXNel7aIhCm?=
 =?Windows-1252?Q?62h80pwCgVZd8rjVwFM2hSgAYU4gFJuaVYeXsEII5zvJkF6kW3d6kQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d098f453-981a-40a8-9aff-08daf7bfc02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 12:46:56.0775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jaMSvdf03PIIUV+BvkgMEOQK31YYN5L8/Fc6qJPcM1DckVRK1oMYWiVVycw5P9tyJxTuGgn1OC1e5w8OqXhqxH2ZnqgJfnkHFSIm2jA2Kxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9642
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jan 2023 12:47:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10372

> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 16 January 2023 12:23
>=20
> On 16.01.23 11:46, Chris Paterson wrote:
> > Hello,
> >

[...]

> >> On a related note, 4.9.X was discontinued; I believe we should create
> >> configs for 4.14 and start testing that, to help with 4.4-st
> >> maintainance.
> >
> > Is there a reason not to test the release candidates for all stable ker=
nel
> versions?
> > (Currently we only test LTS)
> >
> > Our CI will be fine with the extra workload.
> > It would just be a case of someone checking the results and feeding it =
back
> to the stable mailing list.
> >
>=20
> Would we add value this way over existing kernel-ci runs - or don't they
> exist?

KernelCI test all stable versions I believe.

We have slightly different build/test coverage then KernelCI, so technicall=
y if we build/test as well, overall coverage would be increased.
e.g. we use the CIP kernel configurations, different compiler versions etc.

Chris

>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux


