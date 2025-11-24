Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB564CFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 15:47:38 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19745.1763999251404570687
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 07:47:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=D7GR7Dgn;
 spf=pass (domain: renesas.com, ip: 52.101.229.34, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1FD2ydKPXUUXQLO1jg7JUf62TEbC5bmLmqrHQtcciiETKlIXWGOGp0K1qQKtwjAKdotx6dT0jpivUNNsd5vO1emIUEvLNIKzzKOBJiOrEGPIp6OEI6sez5DHu8tIkT+kDSVICtDTpuICmxajAb4v3lyHk4TFN353S6QXnJFQrF5BRLQ3PYZElYwvAkawyz0r+w/SxvGMc6WZygY/4e6ak4HTiBH4iM38MW7C/6QU/0orUHt+z1KLTXBuYwYMEjxzt18DNG5vOo7XFEdEINdY/DR1ZpJa7IQh8sL6HyTg+RSHU8+eCgkB4f6tlGdkqiUAFZw5zfOLduLMVyHzLpyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//LdW0FEs2u0cieTPEPNbxxIt6IDSqBOSOwY2osIa+E=;
 b=DW5P1lsySaMt+V97/kkEP2VtwwCbYHlYNXcU+mKsgdPM5PP8fPvIda67P/K54dyph5PozV4JhuGoN8ZSJo+VLZSmA1w2cVMej/70E7XROqKg4eUcUf0FwYs72yTYkqs3NRcvAAsnNQgyHQBqD3WmP8pSoBu/jaXluoBfO8raJS/lFk6X81sj70GfYMFRDhdK+xSgWqtMlefn6k4ccH9yY5Tn0Z964h5WfH9YxjMnK4J0bqrNL2SR2z2mddVNNy+TGE+ZMYQMkUp52rWKRd9kF/NthC56ezhXnf+VxHWZxADR7YeVecv6fhrI2SeEwHhBvenTzstmrKuzlkiMdY7slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//LdW0FEs2u0cieTPEPNbxxIt6IDSqBOSOwY2osIa+E=;
 b=D7GR7DgnNc6oEJdNJPbPGKZrnGoI4Zl8wqqTREVjx9TQzod5dZ96I1HXZKN36LLp9l2Jdzxvo8OD7JwtfPHUeU+oKfLgi/7f6AjFVDbVPfaG4hu3lmescplw+cMC7po9Js+zfcLVs/5PhD8FmKDBYbKLpnmK3QjRpWBW5I6oy0M=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TYWPR01MB12126.jpnprd01.prod.outlook.com
 (2603:1096:400:442::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Mon, 24 Nov
 2025 15:47:25 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%2]) with mapi id 15.20.9366.009; Mon, 24 Nov 2025
 15:47:25 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: Planned LAVA server maintenance
Thread-Topic: Planned LAVA server maintenance
Thread-Index: AdxdWTn/5cm9ortBRKCZrYau+yF7hA==
Date: Mon, 24 Nov 2025 15:47:25 +0000
Message-ID: 
 <TYYPR01MB1513295AA34C3ED87B156ECA3B7D0A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TYWPR01MB12126:EE_
x-ms-office365-filtering-correlation-id: dead6f23-b7af-4a25-47dd-08de2b70c3ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?IqTjKFFs3ayh7ugo7qA4DcHgndv/pGLeH5BuDfmkHUL3OuxF5ZCcYFhIez?=
 =?iso-8859-1?Q?HLqJrzExga+xL0f9+b5YISAt2JnWGwAslXwAXB5isX9lMw7sD8utvLvNZH?=
 =?iso-8859-1?Q?x61Pq/wa0L1QWZT6DdnB538F+bLP3QreloXK8LQnguBMLN5R4CrPBsxotC?=
 =?iso-8859-1?Q?Qat5plaaYtx5UQRggFswFVMk0IxiRmscDL8bozFV6p9hrZrD8z+s596Tog?=
 =?iso-8859-1?Q?IDD2SkQFDJdjjqtY/QxEEVPI/UTTfnYSEumdKql2c42eMyeXs9sFiH9zpd?=
 =?iso-8859-1?Q?C1SreFxl0tQU2wfX+v2YNkMRjYiHycjZeQCkqEUyB1bQcD3BFDWuT+AuQV?=
 =?iso-8859-1?Q?CHO37693Egv4RQ9wvWd5hdJDc8YPllM+YslTdKxMLsvfxQ2/w3kSNn0fX9?=
 =?iso-8859-1?Q?z6GK2CQ0efbEScjBSp/623ObW4Wh081ole89yKktl+SMgCTecKGLG4Jrpp?=
 =?iso-8859-1?Q?ee3heAC67DhJFjAmAkWbGrxIgBsiS+dAB0NuIgtwET6sat8YSvDnuvltcN?=
 =?iso-8859-1?Q?KoXt3hTLfNT+dmB0YmS9u7La9tn8eIbSb/5J7MG7ogl4PcvM0mYVk00KmC?=
 =?iso-8859-1?Q?ey1YdHioMpqUfAL01rEGetZmN+pAa7sD0tU+Vv5Qokn36Hn/b1cpTrBflE?=
 =?iso-8859-1?Q?YJ/2MEQEDhTmvoZx0CFxyd89KD/KIsLD69uxm28+Nj7OabC+e6Fyt5rz/o?=
 =?iso-8859-1?Q?1XxCU2tSMEaSSwiKYLY1mO34Ks3qqdRfT4uP0tmeyyXni87lR/l371p+qW?=
 =?iso-8859-1?Q?+yCQBS/2dfbS8S6qbWC23Nj2cMeY3kCrdovCr8LGyQ87ebzuTxV56Wml0A?=
 =?iso-8859-1?Q?r3bHmC2cZua2GHLTM6JcQ+D8Vm2l+IFL4pPpHa+L6mkPcJO9rSzcIrLdRc?=
 =?iso-8859-1?Q?ByryWpkh7IeJ55gW1GFLtQgThtoeaTkpx6Np4R7fMe5mFRkEpRh89GcZBP?=
 =?iso-8859-1?Q?Hvc+vzkQmOlA/X3nL9pgTkO0SE6gRj3edDfqHifAOjpNJ1C8vsrbdAjub4?=
 =?iso-8859-1?Q?dfjN0KQLB5wkRZINHnjLNsKhFlVZ04tTtHqAm2SX02WQYRYTq2J8YxkeJA?=
 =?iso-8859-1?Q?2mJYtbUiy2TD8p1weXwfiM7LmqUZGN+OG80iW6iHu/lm6rpntkWbZNI2et?=
 =?iso-8859-1?Q?KQH87nz0gcfDy6f3XCdptXhScOXtNec3hoRuO7G5jCuR6ec9MfYHX9Eq32?=
 =?iso-8859-1?Q?gtBijm1nVWeHfKc0aCUE10OG/hnuxbEUfsSeoHZdWTISS+z4awEa4wLyPv?=
 =?iso-8859-1?Q?xjB+g/wTYJJ8r987qI6qyczOOP67aE/uY/3zMZkLeUizARkkPpPaoXskB6?=
 =?iso-8859-1?Q?pvCE7BSm0ZNRi4NpV8DajfJY0bgro55eIZ+A8pZC8O43YmAjyu8e7sQudc?=
 =?iso-8859-1?Q?BbPBsKq/WyrTo29Rj6o61PprurYBbKlUlIzCWYMR6+pm3mnw2Ub68Mb1wZ?=
 =?iso-8859-1?Q?eg+XY/foTEd0PYHCKIHLbC8tcDxPFeNL6tEjfzLlLjWHCZLYAelBVl87av?=
 =?iso-8859-1?Q?fUypcmXaUIkdrHG4Pms7TT?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?cZB/O5GXtRCzs/4TihDk1kXLZpD4qSIPDx8rR3dgiXpgiB9mbf0VTrMo42?=
 =?iso-8859-1?Q?rCqZ1W3cuy9RjTTxD6I3DJA3eHSVPv8eam/QV7BBOyh+Ii6g78aucT0k+0?=
 =?iso-8859-1?Q?RXSuumS9hUD6jTPiCQqP+kHH31qKhKF6m9UhL32TeJkFJbTVGM1z2XE5uG?=
 =?iso-8859-1?Q?fydKxvKfKTvYI1TzcXgrj+l49j20sjpDkS1cOam1vDgEghtczFgI0A8GJH?=
 =?iso-8859-1?Q?rvq56XhAgiEg/RfDq7tEVhmd5bkCnoNWOA6wssFM5k4yo7DeBZJN86JzID?=
 =?iso-8859-1?Q?Jxs5yOoKtTgPJAgzX80237qfM4ZGOa30XeVxbzYTRkGVRUXp7I3Ez3Trwk?=
 =?iso-8859-1?Q?s1d0qvfNQLr8gwedLFmLuLvg/+HSm4Uc9AUdAIph1qWmPAEs/EvexAPfqS?=
 =?iso-8859-1?Q?qCoSVM25sUX/xjSD0U4Pc7bGm9oIM/47f2vX8PjreYLt+mDNDllBjY23kA?=
 =?iso-8859-1?Q?vXiej6PSqq4NH/ITEPdFbEo/LtG3eMHsjMzairk9u20P6Qv/eXeRpM+nXq?=
 =?iso-8859-1?Q?I8G48Ol6fC5GF5dTLJMBqjlwrgHVTmEv/YsCAyjDqHDWhINAon4hi3RIVk?=
 =?iso-8859-1?Q?doZzCUhehy53L4YVwonbg+f5/njtGqwMlbXxdKGSiZt0zFbgA9RscZGI3l?=
 =?iso-8859-1?Q?nT9jhWqjkbLqaEBpA9J2I9SQUskuwmn2jSU8Avo5dCNyN6RrMpkgreNAy7?=
 =?iso-8859-1?Q?2TJRZuwKGw3IsS0KKIZOQXsFGQulFiMStMedIer/G7ohsb1PaaE7bxaaJM?=
 =?iso-8859-1?Q?3bcK+HopqDB9vLqIHvW6K8AeoCbY5F7LJ7Oq2cLauqCFV0i18AKho40U/1?=
 =?iso-8859-1?Q?NJ5DjukOj1eKFd0EAk5YXOSQ5whl2WN871EHbI6Xvos6m4HnXMU/lEuDNC?=
 =?iso-8859-1?Q?Y+njL1C9LryPEI/vHwzPZYCM4osMtgVNdR/TzpzzC+nr8cSHVW07Q9OlWu?=
 =?iso-8859-1?Q?OkGeDsxARSnRw1B0ZNHtjMTrnKUyp0QUekFb8AjXDFZtV6yOhbFqvgP1vx?=
 =?iso-8859-1?Q?tWOBZMFZbim0SU8IlEOnB+REJLbUgTmr2nA7eqAIuKXviQBus9ix2ajIHI?=
 =?iso-8859-1?Q?CzgiaPklE8fUrKHTU95u6FQi7QJjGXxvhMuJR029krBSxAKsXFQUl5yYQy?=
 =?iso-8859-1?Q?nRoDiyL7j+TbPdDZikd1q6sTnKX77mbJAKdQuZx9Ou4xBJxhiMxFJYE/ue?=
 =?iso-8859-1?Q?HJNdC0vRSiJN0X4K1NCTLa1gGJtj7O+rUtaqo65Kon4b4nqqEQswF8PJqC?=
 =?iso-8859-1?Q?VAUZ1EKGSFSTIhHsLb9S28MaYfhCTKztYOHTYXQvipVBxNKe/59W90eTCX?=
 =?iso-8859-1?Q?hd0I7x/xrwYdD5hTp4hLQBIygJueWh+XjJvH7V9C49kmrgBbXfZdvMOADy?=
 =?iso-8859-1?Q?fQHLMhP+NfIr5cqWTO04MBj8faup9uT11dXHY5c3p4TSb7PsVLTIWqtlMF?=
 =?iso-8859-1?Q?ImQnLq3aK9990amj1llx1pFH/pjPYbzxSjn5o60YeMuRT4Qmw4rmIFJPOs?=
 =?iso-8859-1?Q?q52P2sjDe2JtefsPpJob4ti73By7oCrmBtAiBYfs3ZP5YgXzHpwFN3pPpS?=
 =?iso-8859-1?Q?PtwCt9rpFHym+maRqTrzpiVBT8oipepv6X+NWQJDQ469rd1YklWfFDvAiY?=
 =?iso-8859-1?Q?ZYbAvw6Ak9PbPOSswUMr1iv9bZdH3gP3m7oH6W1m949z4sfY/b5naYZA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dead6f23-b7af-4a25-47dd-08de2b70c3ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 15:47:25.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZZlEbfeCuJq7WZj9/05Z3rwAOdS935/B7ZrG2Mw+DlcBAzj+SqINE6Xc1sSfFbT5pWqIpAtk7E9k0sPbhMhTkdIWhKjHPQofS52x/6nGZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12126
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 15:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20717

Hi all,

The CIP LAVA server [0] has scheduled maintenance on the 26th Nov at 0900 U=
TC.
I expect that it will last approximately an hour.

Once the server is running again the labs will also need to be updated and =
re-connected which can take a little longer depending on the labs.

Sorry for any inconvenience.

[0] https://lava.ciplatform.org/

Kind regards, Chris


