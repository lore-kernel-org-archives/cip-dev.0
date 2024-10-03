Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DC4CF855D
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 06:33:32 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.39])
 by mx.groups.io with SMTP id smtpd.web11.5444.1727937203651637927
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 23:33:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=W4yF6q25;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.39, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXF9gWcX02DxWfL0d7dZBUo7+9TBc37jggLCGuWwvkEQIcR5jdky6QMT7pwHbXX8hQ31Qe7m0BtEh0bfM8UDsj3PWvuqfvaTfj/Ey7m1tglwXyi+MDv14L/eJjqwXqSmxCQx1Mukx+uB0gXeyRDBYVW5ctEQCPaacimz5c04m3NlWZWEiL1fGhXhFu3zYg4SQz1X1VOuUG1OtwZA6XhKieyD9Bbxnu93wSUw8EGo1Se1N+3Q59JQST7eFQMGmZMPfBXTh/26Z1oVd/BC0IQrsDUmBOTK2qgq6AFftZMYBDY52IRFYKCqOMrUWLZnSvPPzvjY2UESYLOncq3rBiz5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqQJhL/qJVK+YwYNuj5Dna2wOYvn9sVKEGOffyKxkXs=;
 b=ulFHKMO/me/3U+PMV46FIsAD6sk/7CdX4OjoKR9oM8D6q73SsLrkRg7IrPxojnt4d6xmAuz572xJuDquPQtaWkVUxQ+Yn134ADCDw8984+MuVvjkqYXRlNVSc/R5cxO02j0X7hv09G8zX1VMz+E3Y1B2szAUE4voX3rcZxPjKDykET+QFEvbQXyzpJx5qXgz4igfcc2sHlTHkGVuttF4eyAqinLBTA4+4/o6A4qqHxcvA3KlJ8AUzyS0WzS8IeT5uD4GI1waSQttYTDURl2fWRP4hH/oG5Y1Z6SBpIVqFrpJJNxQ98YGBNCH4/iSTOOjX9yT4Qv5jNBt+hKYxDRdAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqQJhL/qJVK+YwYNuj5Dna2wOYvn9sVKEGOffyKxkXs=;
 b=W4yF6q25zgP8GM3QbSLC+pZQ9xRVE9arbymz8bZG3JX5H2iQmCnBLwZpHkainnZN1EaUbN6lS1N+bit08HnYF1JomRKidDNkGUqF327yPQ4DYZs0mgJlZGMpc4HOggcewFrFUyXDssrax143sObAQxUIQpGxKo4p0/tc3pNqUuM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8414.jpnprd01.prod.outlook.com (2603:1096:604:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 06:33:18 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 06:33:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 04/16] ASoC: sh: rz-ssi: Add full duplex support
Thread-Topic: [PATCH 6.1.y-cip 04/16] ASoC: sh: rz-ssi: Add full duplex
 support
Thread-Index: AQHbFO0rxOz58TtMSEi4yafvX7BySbJ0f2eQgAAOW5A=
Date: Thu, 3 Oct 2024 06:33:18 +0000
Message-ID: 
 <TY3PR01MB113461820B06460141CB64F2286712@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
 <20241002170417.655339-5-biju.das.jz@bp.renesas.com>
 <OS0PR01MB6388D2FEC41845ECFA6EBE2F92712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388D2FEC41845ECFA6EBE2F92712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8414:EE_
x-ms-office365-filtering-correlation-id: 347df0e8-ae1b-40c3-1951-08dce3754505
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VElWUWIzWENQLzMwb3pxMjdzNENlUlBSd2g2VjFudkt1Z2NUc3Bjd2Qw?=
 =?iso-2022-jp?B?QzZyWXE1NGlFV1ZHbFBWUVBvOXR5emZrY0l1L1Q3clFYaFlQaDc2cUdC?=
 =?iso-2022-jp?B?OWhKNmh5WXl3bG5Hd2JDcTZWVVFBWWtWNmJFTmhzYWw0UjB0ME16Tk5h?=
 =?iso-2022-jp?B?Q2RhejVsbWtsWkJoWkJVS3ZaNktEZWx5bUJoNi85ZUtGODhWcXljazhE?=
 =?iso-2022-jp?B?NDVHVVNBbk5hUWgwcUlhVUlOR3A0ODlkZnlnVEl5MGRWelZIMEhzZ01u?=
 =?iso-2022-jp?B?N2JJQVlDUllNaXVpUTlmNTRaTHd6dmo3NEgzbk9rL1FpTGtNbzZ4UWZy?=
 =?iso-2022-jp?B?alFsdHhZL2RiQkMwQkRyZjh5czhqUFp3MjlZbFFjZGRtb0lYbEo0ZVZk?=
 =?iso-2022-jp?B?OXVDMUxzKzZENStNNTVZbkVHeTBrRHRXaWpHcGNlYnBvcmZpQW9Ib0dX?=
 =?iso-2022-jp?B?RVFvcUFBdUNQSFptWVpQMEhHTk1UOHkzU1UxOTllWHpzOWRvcTVFa01X?=
 =?iso-2022-jp?B?UGE5MVhwNGVoWWJTc3Z0ZEMrTkdVK21qVkNFYnAzNmxvZTFCY0VqTUMx?=
 =?iso-2022-jp?B?c1pRVzJrYTYrQVdBSEd1MS80cklndjNHZ0ZIcjAxWlZNRlBhM3ZNQy81?=
 =?iso-2022-jp?B?Qm8zMCt0RFJabkJmRXJnYmJhcTE0bjFMTXdmNS9zQ3pOTm9ZYlRCcWg3?=
 =?iso-2022-jp?B?L2RvZE9kam1TWTcybUNIQ2piR0NqMUE5dEV0cnczSXU0ZlEwV0hjV0J2?=
 =?iso-2022-jp?B?L2J6TG1JUFMxVHBWY0dQV1lRZUtZbUZYOUFVSW0wUEx5UmpOOTBUQnZw?=
 =?iso-2022-jp?B?NU9uRVRvN2w3Q1ZKTW41UG1aenZFMGRUeWJ0R0YxdC9ZV3ZLVnZWMFJJ?=
 =?iso-2022-jp?B?d1p4SXBGWnQ1dVVqNGttdEVLYmUwYnJkUzF1R0cwRDk4THhRUlMrem5L?=
 =?iso-2022-jp?B?b3ZQcWU3akVCdmRUblFMWENXWXBmOUZJTXUxTUdoU3BIR3pEaHlkUE16?=
 =?iso-2022-jp?B?NTVONDJyZmZtSjZPYWxjSlRIbzlWbGlzbDgzTmpONjE5enM2UnkwQW5C?=
 =?iso-2022-jp?B?eDlDMmtFL3pGaytSQzNHOGFIZHR3OS9EUHlFL242eUllaFRHNUlaWURl?=
 =?iso-2022-jp?B?bHhqS1pYMVpINUNZOS9wWHU3djZkcnMzdS9kcWpvNFpsSDI3RWQ1OTB1?=
 =?iso-2022-jp?B?MFRaczNYdCtuTGJzeFFOMEVsRGQ3N0J1MDZITW5McVlOSTNRbVFYZU1z?=
 =?iso-2022-jp?B?RWw1OWFIelhzL1E0RVRBQm9wL2hHMHFldzlWczF0QVlKWlMydUQvUFpj?=
 =?iso-2022-jp?B?TUcrclM0dWQvczNXbFVSNE0wbW9nNlBYdzNjS1BJRTZCSG1jOGtlbDU5?=
 =?iso-2022-jp?B?a2svMkw5MmMrOEFrU0ZaSnBqOXNGZmF6MmlvSmtZTlZDald2UGlqQlUx?=
 =?iso-2022-jp?B?ZGloejkxN3hQTVdGbWlTaVNSNGZ0QU9qNkhFV05zRCtoV3liNGtqVGJy?=
 =?iso-2022-jp?B?MFgrL3ErN1hQakFkVFA3RlpPVmtNZ01TMlo0OTZZRFIyRHgvY3VtczBV?=
 =?iso-2022-jp?B?NXRrcTk5clIwblVNdmQ5Z1FxVXN0T2RjTlFURUJmSmZoSlBSaUEvZlRs?=
 =?iso-2022-jp?B?T2FnTGNFeTRBRFEvbU0wQTN5bEZvWXRQYmtJaURaS2YwUWJHZ0pUdnVl?=
 =?iso-2022-jp?B?WCtPS3ZPTkhjYzR3ZGhSZ200cmc1VFd2N1kxNzhLV0c0eUNoQTd5WStn?=
 =?iso-2022-jp?B?eGE1Sm5CZGxNZDZiT2M4bHZzWmI2ci9sQXFBaWk1bVZvOXg1MTNnbTdu?=
 =?iso-2022-jp?B?enJXeUpLczY0YzdITTJrSVdvTy9KdHREVUhVMjRua3FFM1A1UlU2NTdB?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VzhaR05mNXdmSHBmTlhRWVZtT3ZHTnpqb1FwTVRoTUg2K2ZEYlNBNUxn?=
 =?iso-2022-jp?B?TW0rQjFFeXNwMkZiV215UkQwZEQvUURyNWVuYitwaDlXQU1aZ2F1STJF?=
 =?iso-2022-jp?B?L05QZXA5RkhwZnVxUXVJMnFvNkVLeUQzOUkzdjNFYWoycys3SG16bWNG?=
 =?iso-2022-jp?B?bVZOVGgrNmtlUXo4MmVkRngvYXdrMDdWc0x6WUpJYXRTY1FzNWtqdzU4?=
 =?iso-2022-jp?B?N3czUVgxaG8zdTM4ZExpY0VSZjVBbnlzeWo5dS81RzBodCt5NnZQeVpa?=
 =?iso-2022-jp?B?dURqTkVmZmtuejJTM1RMdktkaFhMK2xMZ2gzWWR2ck13TzFvU096Ymxh?=
 =?iso-2022-jp?B?U2RERU15eithVTRxUTZqc0NKaW4yZWJwWks2em5rUDdIQnlPTnEydGRn?=
 =?iso-2022-jp?B?Vm1HZE1QY1R3RUxhaGF2aFFxRTdOOEdCT2tqU01oaDdIK3lCaVVYVU9D?=
 =?iso-2022-jp?B?MllYSmNUWG00eUFEdm9VTThrMktnUWpKVHFOVm9NMEE2b0FSNkFnY1dj?=
 =?iso-2022-jp?B?bGxGYk1vejNhTEh0eE92MUZqK1ljWnI2b01lVjEwUEFEWWRqTHFBbFRt?=
 =?iso-2022-jp?B?OE01QnkreXVIR0lwYTBzWnpUeW5xaUNHY1M4cHhNSk5paVA3QVdrQVVK?=
 =?iso-2022-jp?B?UVJtM2xzVFBWYkNWTVJOcVcxUzRQUEtxRGR3dDI0dnZMeDJlbDVwaWVW?=
 =?iso-2022-jp?B?SU5rMUQ4RElHcG4zZ3lCZVhNT3h0QUlPbkhkNFZZUTg1aVlDa00yc2M2?=
 =?iso-2022-jp?B?WitpM3NjVzlYajNpaXM3VkRCSUFaWGRoN1dCZ044TmJlejNNTjM3N2Yr?=
 =?iso-2022-jp?B?aTU0TkFrdFN5Slp3M1BvVkkweWllWjllc1NqQ3JRbHdPaUNjeEZLMktS?=
 =?iso-2022-jp?B?T2JUeExFcEt0Y0dLNkk3L2J1MmJFV1VKSzFoUkZFR2NJUUlmMnF2N2NM?=
 =?iso-2022-jp?B?YTJlVEhZcmZHU0JsZTVvU3RRcVpOWGVhN3dWcm81b0ozTzBXcnhLSXlH?=
 =?iso-2022-jp?B?ZXZlaTNXc0U5NWNEaUwzdklKbkZIUUJSOFd6d3hpUkxNaC9ZalhoTU1I?=
 =?iso-2022-jp?B?c0xrZmw2OWd2K2JQNVV4ZFpBNkZ1SVJuWDBWaXFyOTUyYkhtbndvNHBs?=
 =?iso-2022-jp?B?NExFZFlEbUdibW96UWZDUTdmOHpibk4wbU9xTHJ0L1BjbWRSMXpRSUJu?=
 =?iso-2022-jp?B?RkQwc0Q0Q2RnNFdWeDZpYjFPbXV5WndEbDVFQTBQNUY5enFtcjh0bWxD?=
 =?iso-2022-jp?B?M21Ca1Z6VWNieW1oWk5JSVpzQXhOdUNVWUZuK1lpS0JoeVVXYVdvQkJJ?=
 =?iso-2022-jp?B?MHZtSm5ycStkSnptanI2NDdhZDl0ZVJMVVZBb1A2TWlubS95cEtySjJI?=
 =?iso-2022-jp?B?Rk85SlBsYWdkMnMrSzRQWi9sZ3V2dEswT2JSc1RpOFV3WU02WFJXOHZm?=
 =?iso-2022-jp?B?d2o0bXQ1S0NiS2w4NmM5MmxKZS9MZGtuVzYvUkRmc2hHTkh0WHJ4M3Mz?=
 =?iso-2022-jp?B?b2hMN05OUUIxL3lMeDNMU09MN00vS3drLzVxLzJKc0ovSHRCSnJENjNr?=
 =?iso-2022-jp?B?eHRaODcxc1RvdDJGVXVXRy8zaktabFJ3eXorcytGampVeDhGNGU5RmNZ?=
 =?iso-2022-jp?B?QTlXUE9yT0VaS0hoeE1iZGFNZ25ncGpUMXVtT0VPa1ozRkU0d2M4cjhQ?=
 =?iso-2022-jp?B?c0lpTDYzMDdNQ29iemZadHZjamFXbFFGWTA3aFR3Qi9uNlZ1ekh5WU9T?=
 =?iso-2022-jp?B?NmY3aXdOaDZkWUx3Z1BoY2svd0ZvNldEZHVWQ3VGSVY0NHJoRTJuQWRF?=
 =?iso-2022-jp?B?N0pISWpsZmlpTlJLV1VFdkNaa1F5UmNibTFEWml2YThsUGxCUk04QzBF?=
 =?iso-2022-jp?B?NmY3NFlmRDl4WTIwZUJXU01tODkzZEhGTkhsKzRieFlRTlVMUGFhMUhy?=
 =?iso-2022-jp?B?Z0RndjRqcVYvNUw4RURZaER0dHdNbXp1aHI2ZktOMjdCQ0FaZkFTNHhI?=
 =?iso-2022-jp?B?ODZQNmhzNVVaYlFMMzNjcU9EWkRMMDdNMDVtSzlQZ0QwNndBRThXNjB0?=
 =?iso-2022-jp?B?N0VHemlydEpYVWlKMTEwUmtuSWczZ0lRS05NN2tkd2tSZlBjQVQ2bTBp?=
 =?iso-2022-jp?B?eW9STVBsclNjNzgrREpocDZaS0owTGhQMG9BMnRqZTlVblRFVmk4cU9T?=
 =?iso-2022-jp?B?bXNLS1lKdFp4VGZwT3kzRGsvbjdkQ1hHTHdYZGczdTRWalNEQldvaWZt?=
 =?iso-2022-jp?B?Z1JYNnRsY21vWlRXMWlRK0d4ZGJ4RnpWbXVPdGdkRHRxeHhaLzllWGpG?=
 =?iso-2022-jp?B?b3JKd1NpcEFTVkFldERKQ2RDalRaT2NQWlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347df0e8-ae1b-40c3-1951-08dce3754505
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 06:33:18.8112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +SeiLbMfF4gsEmpDsmOIWeClLRxuv5lAd+QLWlrUj7Z3xRL+j6preItoMpQOAvXzgXfYcKXm7vuM0tJDFw0964x6bxGVDMTTETNDgWhcNjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8414
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 06:33:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16988

H Nobuhiro-San,

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: RE: [PATCH 6.1.y-cip 04/16] ASoC: sh: rz-ssi: Add full duplex su=
pport
>=20
> Hi Biju Das,
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Thursday, October 3, 2024 2:04 AM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: [PATCH 6.1.y-cip 04/16] ASoC: sh: rz-ssi: Add full duplex
> > support
> >
> > commit 4f8cd05a43058b165b83f12f656e60415d2ff5be upstream.
> >
> > Add full duplex support, to support simultaneous playback/record on
> > the same ssi channel.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Link:
> > https://patch.msgid.link/20240715092322.119879-1-biju.das.jz@bp.renesas=
.
> > com
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  sound/soc/sh/rz-ssi.c | 257
> > ++++++++++++++++++++++++++++++------------
> >  1 file changed, 182 insertions(+), 75 deletions(-)
> >
> > diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c index
> > d502aa55c5a8..6972b70baf73 100644
> > --- a/sound/soc/sh/rz-ssi.c
> > +++ b/sound/soc/sh/rz-ssi.c
> > @@ -53,6 +53,7 @@
> >  #define SSIFCR_RIE		BIT(2)
> >  #define SSIFCR_TFRST		BIT(1)
> >  #define SSIFCR_RFRST		BIT(0)
> > +#define SSIFCR_FIFO_RST		(SSIFCR_TFRST | SSIFCR_RFRST)
> >
> >  #define SSIFSR_TDC_MASK		0x3f
> >  #define SSIFSR_TDC_SHIFT	24
> > @@ -131,6 +132,14 @@ struct rz_ssi_priv {
> >  	bool lrckp_fsync_fall;	/* LR clock polarity (SSICR.LRCKP) */
> >  	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
> >  	bool dma_rt;
> > +
> > +	/* Full duplex communication support */
> > +	struct {
> > +		unsigned int rate;
> > +		unsigned int channels;
> > +		unsigned int sample_width;
> > +		unsigned int sample_bits;
> > +	} hw_params_cache;
> >  };
> >
> >  static void rz_ssi_dma_complete(void *data); @@ -209,6 +218,11 @@
> > static bool rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
> >  	return ret;
> >  }
> >
> > +static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream
> > +*strm) {
> > +	return strm->substream && strm->running; }
> > +
> >  static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
> >  			       struct snd_pcm_substream *substream) { @@ -304,13 +318,53
> > @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int
> > rate,
> >  	return 0;
> >  }
> >
> > +static void rz_ssi_set_idle(struct rz_ssi_priv *ssi) {
> > +	int timeout;
> > +
> > +	/* Disable irqs */
> > +	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
> > +			     SSICR_RUIEN | SSICR_ROIEN, 0);
> > +	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_TIE | SSIFCR_RIE, 0);
> > +
> > +	/* Clear all error flags */
> > +	rz_ssi_reg_mask_setl(ssi, SSISR,
> > +			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
> > +			      SSISR_RUIRQ), 0);
> > +
> > +	/* Wait for idle */
> > +	timeout =3D 100;
> > +	while (--timeout) {
> > +		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
> > +			break;
> > +		udelay(1);
> > +	}
> > +
> > +	if (!timeout)
> > +		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
> > +
>=20
> There is no check for timeout, is there a problem?

It is decrement operation. So !timeout is the check for timeout.=20

>=20
> > +	/* Hold FIFOs in reset */
> > +	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
> > +			     SSIFCR_TFRST | SSIFCR_RFRST);
>=20
> We can use SSIFCR_FIFO_RST instead of SSIFCR_TFRST | SSIFCR_RFRST.

OK. Will fix this in mainline.

Cheers,
Biju

>=20
> > +}
> > +
> >  static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream =
*strm)  {
> >  	bool is_play =3D rz_ssi_stream_is_play(ssi, strm->substream);
> > +	bool is_full_duplex;
> >  	u32 ssicr, ssifcr;
> >
> > +	is_full_duplex =3D rz_ssi_is_stream_running(&ssi->playback) ||
> > +		rz_ssi_is_stream_running(&ssi->capture);
> >  	ssicr =3D rz_ssi_reg_readl(ssi, SSICR);
> > -	ssifcr =3D rz_ssi_reg_readl(ssi, SSIFCR) & ~0xF;
> > +	ssifcr =3D rz_ssi_reg_readl(ssi, SSIFCR);
> > +	if (!is_full_duplex) {
> > +		ssifcr &=3D ~0xF;
> > +	} else {
> > +		rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN,
> > 0);
> > +		rz_ssi_set_idle(ssi);
> > +		ssifcr &=3D ~SSIFCR_FIFO_RST;
> > +	}
> >
> >  	/* FIFO interrupt thresholds */
> >  	if (rz_ssi_is_dma_enabled(ssi))
> > @@ -323,10 +377,14 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi,
> > struct rz_ssi_stream *strm)
> >  	/* enable IRQ */
> >  	if (is_play) {
> >  		ssicr |=3D SSICR_TUIEN | SSICR_TOIEN;
> > -		ssifcr |=3D SSIFCR_TIE | SSIFCR_RFRST;
> > +		ssifcr |=3D SSIFCR_TIE;
> > +		if (!is_full_duplex)
> > +			ssifcr |=3D SSIFCR_RFRST;
> >  	} else {
> >  		ssicr |=3D SSICR_RUIEN | SSICR_ROIEN;
> > -		ssifcr |=3D SSIFCR_RIE | SSIFCR_TFRST;
> > +		ssifcr |=3D SSIFCR_RIE;
> > +		if (!is_full_duplex)
> > +			ssifcr |=3D SSIFCR_TFRST;
> >  	}
> >
> >  	rz_ssi_reg_writel(ssi, SSICR, ssicr); @@ -338,7 +396,11 @@ static
> > int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
> >  			      SSISR_RUIRQ), 0);
> >
> >  	strm->running =3D 1;
> > -	ssicr |=3D is_play ? SSICR_TEN : SSICR_REN;
> > +	if (is_full_duplex)
> > +		ssicr |=3D SSICR_TEN | SSICR_REN;
> > +	else
> > +		ssicr |=3D is_play ? SSICR_TEN : SSICR_REN;
> > +
> >  	rz_ssi_reg_writel(ssi, SSICR, ssicr);
> >
> >  	return 0;
> > @@ -346,10 +408,12 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi,
> > struct rz_ssi_stream *strm)
> >
> >  static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *=
strm)  {
> > -	int timeout;
> > -
> >  	strm->running =3D 0;
> >
> > +	if (rz_ssi_is_stream_running(&ssi->playback) ||
> > +	    rz_ssi_is_stream_running(&ssi->capture))
> > +		return 0;
> > +
> >  	/* Disable TX/RX */
> >  	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
> >
> > @@ -357,30 +421,7 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi,
> > struct rz_ssi_stream *strm)
> >  	if (rz_ssi_is_dma_enabled(ssi))
> >  		dmaengine_terminate_async(strm->dma_ch);
> >
> > -	/* Disable irqs */
> > -	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
> > -			     SSICR_RUIEN | SSICR_ROIEN, 0);
> > -	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_TIE | SSIFCR_RIE, 0);
> > -
> > -	/* Clear all error flags */
> > -	rz_ssi_reg_mask_setl(ssi, SSISR,
> > -			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
> > -			      SSISR_RUIRQ), 0);
> > -
> > -	/* Wait for idle */
> > -	timeout =3D 100;
> > -	while (--timeout) {
> > -		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
> > -			break;
> > -		udelay(1);
> > -	}
> > -
> > -	if (!timeout)
> > -		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
> > -
> > -	/* Hold FIFOs in reset */
> > -	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
> > -			     SSIFCR_TFRST | SSIFCR_RFRST);
> > +	rz_ssi_set_idle(ssi);
> >
> >  	return 0;
> >  }
> > @@ -513,66 +554,90 @@ static int rz_ssi_pio_send(struct rz_ssi_priv
> > *ssi, struct rz_ssi_stream *strm)
> >
> >  static irqreturn_t rz_ssi_interrupt(int irq, void *data)  {
> > -	struct rz_ssi_stream *strm =3D NULL;
> > +	struct rz_ssi_stream *strm_playback =3D NULL;
> > +	struct rz_ssi_stream *strm_capture =3D NULL;
> >  	struct rz_ssi_priv *ssi =3D data;
> >  	u32 ssisr =3D rz_ssi_reg_readl(ssi, SSISR);
> >
> >  	if (ssi->playback.substream)
> > -		strm =3D &ssi->playback;
> > -	else if (ssi->capture.substream)
> > -		strm =3D &ssi->capture;
> > -	else
> > +		strm_playback =3D &ssi->playback;
> > +	if (ssi->capture.substream)
> > +		strm_capture =3D &ssi->capture;
> > +
> > +	if (!strm_playback && !strm_capture)
> >  		return IRQ_HANDLED; /* Left over TX/RX interrupt */
> >
> >  	if (irq =3D=3D ssi->irq_int) { /* error or idle */
> > -		if (ssisr & SSISR_TUIRQ)
> > -			strm->uerr_num++;
> > -		if (ssisr & SSISR_TOIRQ)
> > -			strm->oerr_num++;
> > -		if (ssisr & SSISR_RUIRQ)
> > -			strm->uerr_num++;
> > -		if (ssisr & SSISR_ROIRQ)
> > -			strm->oerr_num++;
> > -
> > -		if (ssisr & (SSISR_TUIRQ | SSISR_TOIRQ | SSISR_RUIRQ |
> > -			     SSISR_ROIRQ)) {
> > -			/* Error handling */
> > -			/* You must reset (stop/restart) after each interrupt */
> > -			rz_ssi_stop(ssi, strm);
> > -
> > -			/* Clear all flags */
> > -			rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ |
> > -					     SSISR_TUIRQ | SSISR_ROIRQ |
> > -					     SSISR_RUIRQ, 0);
> > -
> > -			/* Add/remove more data */
> > -			strm->transfer(ssi, strm);
> > -
> > -			/* Resume */
> > -			rz_ssi_start(ssi, strm);
> > +		bool is_stopped =3D false;
> > +		int i, count;
> > +
> > +		if (rz_ssi_is_dma_enabled(ssi))
> > +			count =3D 4;
> > +		else
> > +			count =3D 1;
> > +
> > +		if (ssisr & (SSISR_RUIRQ | SSISR_ROIRQ | SSISR_TUIRQ |
> > SSISR_TOIRQ))
> > +			is_stopped =3D true;
> > +
> > +		if (ssi->capture.substream && is_stopped) {
> > +			if (ssisr & SSISR_RUIRQ)
> > +				strm_capture->uerr_num++;
> > +			if (ssisr & SSISR_ROIRQ)
> > +				strm_capture->oerr_num++;
> > +
> > +			rz_ssi_stop(ssi, strm_capture);
> >  		}
> > +
> > +		if (ssi->playback.substream && is_stopped) {
> > +			if (ssisr & SSISR_TUIRQ)
> > +				strm_playback->uerr_num++;
> > +			if (ssisr & SSISR_TOIRQ)
> > +				strm_playback->oerr_num++;
> > +
> > +			rz_ssi_stop(ssi, strm_playback);
> > +		}
> > +
> > +		/* Clear all flags */
> > +		rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ |
> > SSISR_TUIRQ |
> > +				     SSISR_ROIRQ | SSISR_RUIRQ, 0);
> > +
> > +		/* Add/remove more data */
> > +		if (ssi->capture.substream && is_stopped) {
> > +			for (i =3D 0; i < count; i++)
> > +				strm_capture->transfer(ssi, strm_capture);
> > +		}
> > +
> > +		if (ssi->playback.substream && is_stopped) {
> > +			for (i =3D 0; i < count; i++)
> > +				strm_playback->transfer(ssi,
> > strm_playback);
> > +		}
> > +
> > +		/* Resume */
> > +		if (ssi->playback.substream && is_stopped)
> > +			rz_ssi_start(ssi, &ssi->playback);
> > +		if (ssi->capture.substream && is_stopped)
> > +			rz_ssi_start(ssi, &ssi->capture);
> >  	}
> >
> > -	if (!strm->running)
> > +	if (!rz_ssi_is_stream_running(&ssi->playback) &&
> > +	    !rz_ssi_is_stream_running(&ssi->capture))
> >  		return IRQ_HANDLED;
> >
> >  	/* tx data empty */
> > -	if (irq =3D=3D ssi->irq_tx)
> > -		strm->transfer(ssi, &ssi->playback);
> > +	if (irq =3D=3D ssi->irq_tx && rz_ssi_is_stream_running(&ssi->playback=
))
> > +		strm_playback->transfer(ssi, &ssi->playback);
> >
> >  	/* rx data full */
> > -	if (irq =3D=3D ssi->irq_rx) {
> > -		strm->transfer(ssi, &ssi->capture);
> > +	if (irq =3D=3D ssi->irq_rx && rz_ssi_is_stream_running(&ssi->capture)=
) {
> > +		strm_capture->transfer(ssi, &ssi->capture);
> >  		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
> >  	}
> >
> >  	if (irq =3D=3D ssi->irq_rt) {
> > -		struct snd_pcm_substream *substream =3D strm->substream;
> > -
> > -		if (rz_ssi_stream_is_play(ssi, substream)) {
> > -			strm->transfer(ssi, &ssi->playback);
> > +		if (ssi->playback.substream) {
> > +			strm_playback->transfer(ssi, &ssi->playback);
> >  		} else {
> > -			strm->transfer(ssi, &ssi->capture);
> > +			strm_capture->transfer(ssi, &ssi->capture);
> >  			rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
> >  		}
> >  	}
> > @@ -732,9 +797,12 @@ static int rz_ssi_dai_trigger(struct
> > snd_pcm_substream *substream, int cmd,
> >  	switch (cmd) {
> >  	case SNDRV_PCM_TRIGGER_START:
> >  		/* Soft Reset */
> > -		rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_SSIRST);
> > -		rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST, 0);
> > -		udelay(5);
> > +		if (!rz_ssi_is_stream_running(&ssi->playback) &&
> > +		    !rz_ssi_is_stream_running(&ssi->capture)) {
> > +			rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
> > SSIFCR_SSIRST);
> > +			rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST,
> > 0);
> > +			udelay(5);
> > +		}
> >
> >  		rz_ssi_stream_init(strm, substream);
> >
> > @@ -825,14 +893,41 @@ static int rz_ssi_dai_set_fmt(struct snd_soc_dai
> > *dai, unsigned int fmt)
> >  	return 0;
> >  }
> >
> > +static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi,
> > +unsigned int
> > rate,
> > +				      unsigned int channels,
> > +				      unsigned int sample_width,
> > +				      unsigned int sample_bits)
> > +{
> > +	if (ssi->hw_params_cache.rate !=3D rate ||
> > +	    ssi->hw_params_cache.channels !=3D channels ||
> > +	    ssi->hw_params_cache.sample_width !=3D sample_width ||
> > +	    ssi->hw_params_cache.sample_bits !=3D sample_bits)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static void rz_ssi_cache_hw_params(struct rz_ssi_priv *ssi, unsigned
> > +int
> > rate,
> > +				   unsigned int channels,
> > +				   unsigned int sample_width,
> > +				   unsigned int sample_bits)
> > +{
> > +	ssi->hw_params_cache.rate =3D rate;
> > +	ssi->hw_params_cache.channels =3D channels;
> > +	ssi->hw_params_cache.sample_width =3D sample_width;
> > +	ssi->hw_params_cache.sample_bits =3D sample_bits; }
> > +
> >  static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
> >  				struct snd_pcm_hw_params *params,
> >  				struct snd_soc_dai *dai)
> >  {
> >  	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> > +	struct rz_ssi_stream *strm =3D rz_ssi_stream_get(ssi, substream);
> >  	unsigned int sample_bits =3D hw_param_interval(params,
> >
> > 	SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
> >  	unsigned int channels =3D params_channels(params);
> > +	unsigned int rate =3D params_rate(params);
> >
> >  	if (sample_bits !=3D 16) {
> >  		dev_err(ssi->dev, "Unsupported sample width: %d\n", @@
> > -846,8 +941,20 @@ static int rz_ssi_dai_hw_params(struct
> > snd_pcm_substream *substream,
> >  		return -EINVAL;
> >  	}
> >
> > -	return rz_ssi_clk_setup(ssi, params_rate(params),
> > -				params_channels(params));
> > +	if (rz_ssi_is_stream_running(&ssi->playback) ||
> > +	    rz_ssi_is_stream_running(&ssi->capture)) {
> > +		if (rz_ssi_is_valid_hw_params(ssi, rate, channels,
> > +					      strm->sample_width,
> > sample_bits))
> > +			return 0;
> > +
> > +		dev_err(ssi->dev, "Full duplex needs same HW params\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	rz_ssi_cache_hw_params(ssi, rate, channels, strm->sample_width,
> > +			       sample_bits);
> > +
> > +	return rz_ssi_clk_setup(ssi, rate, channels);
> >  }
> >
> >  static const struct snd_soc_dai_ops rz_ssi_dai_ops =3D {
> > --
> > 2.43.0
>=20
> Best regards,
>   Nobuhiro


