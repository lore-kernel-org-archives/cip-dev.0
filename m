Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4379D65C62
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 15:13:47 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16838.1765984420870698686
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 07:13:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=a2hfc0IH;
 spf=pass (domain: renesas.com, ip: 52.101.125.13, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPzLVfm+FyOIaL3eAtsuaIkT9wElmB63zQ1LAHendZqX7qd1w7VTtYg0RLaX5ZQCuFr03XsjG1SbRNF3Fj7tUSDMY5MDwzkWAy18dev+ZsaHPRKlEJIWjKyVlevfWq4yChCEiefJfczRTudH0hMNcmTTNFwK7gQCNqMFg0yvhb86OaZnjbGAs6+tzSBmuOFSBmRUXuAe6FQokirxvkR4nCLBANiLawQDw+OYMz8RlgyleGhUFsGV6oBiMylkJSwvNzJtxYDhbGlNYUQ/1nVsHvjbNZ+yw4LvB2H+bhic1M1c/fjYcKYU1Pthdk+6YnnPiHMrFagecqv+y1iWPM5NDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiPbOJairddrW1HmFBVFoyHkYG3lw0tsigHX67zLM9o=;
 b=cXnBtVSDenoSIs9H2qunJiZnJtbmwumoQTq24/3rpVYRJvX0IRb81TVMZlwBlVuk4E+SmBj8Henw9KFQnVaT0ewAm7cg6vpAPfa1nouS8VjmBH9GW33bJw9yDTsrNr+2YyeuS94QsYNXT7TZHo2xePM9fdYeHZ7r+iRxmRAJ8GrcQ9qLPCY9BoAisswV2JxjxKLcoMB8Kj1E2+hNlt2v2Bte7Ksep37Vc1rv9ZfACF5KI2q9my+jBImY8lBsiADljc4o59+EvRT2n2dDD9sUrRu7fx0WfLYHMIUeB/BUzSmrVzYSgopUQwCX3bk0RUglbLmF4Sc2GvKVa4Sq/PTsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiPbOJairddrW1HmFBVFoyHkYG3lw0tsigHX67zLM9o=;
 b=a2hfc0IHBxfHpbx6HegS8bQmGBSGpPUZzleoYL8gQ4eCKHdG168c9PxDScVDBwgXs7mO6AvYcnGekveX+z6hb6DUGCRXoTH8YcHPW4RnEP1HumqHj+62jVfcFQQhXV5Iw4obq2tdTIYwmBlkhseszDZlivYAEnHQywsobHRxjMU=
Received: from TYWPR01MB9277.jpnprd01.prod.outlook.com (2603:1096:400:1a1::12)
 by TY4PR01MB12879.jpnprd01.prod.outlook.com (2603:1096:405:1e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 15:13:32 +0000
Received: from TYWPR01MB9277.jpnprd01.prod.outlook.com
 ([fe80::b8bf:9f91:41af:6596]) by TYWPR01MB9277.jpnprd01.prod.outlook.com
 ([fe80::b8bf:9f91:41af:6596%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:13:27 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Pavel Machek <pavel@denx.de>, "iwamatsu@gmail.com" <iwamatsu@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H DMAC support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H DMAC support
Thread-Index: AQHcYLdMr6+DiXojL0m3X6wpcTUvPbUOSTKAgBfBqTA=
Date: Wed, 17 Dec 2025 15:13:27 +0000
Message-ID: 
 <TYWPR01MB9277CB6CCA408B8B70158CD1D3ABA@TYWPR01MB9277.jpnprd01.prod.outlook.com>
References: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
 <CACe6DC4HpsHngXRgjpt+MmR1Qi211fgDWv=+3vx7n9d9EXq=6Q@mail.gmail.com>
 <aS7YU1FbxmmtywFT@duo.ucw.cz>
In-Reply-To: <aS7YU1FbxmmtywFT@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9277:EE_|TY4PR01MB12879:EE_
x-ms-office365-filtering-correlation-id: 1d998270-8b7d-4c65-7b80-08de3d7ed464
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?bSsgZERje6eB+JSh1NpTWqBWSqFFGY8pZ0tG61xymMlAFtAXn3ZDoJSyWMY3?=
 =?us-ascii?Q?vEXsLTNpca9Y18gPLSxdL/kKClqXIgpOITscDBk37Xewx7JgUnT/73nNNnHh?=
 =?us-ascii?Q?TnreihbkuzQiHmAUzcuLgA0zeYvXh25CZCpd3BUvixB567CjDkSb+GWf/TZ2?=
 =?us-ascii?Q?R/MbP7E3PhEADZSmtxH9plRhzlUjrq/XEmswa8IheZ/PnGyZVyO/oPEtWJir?=
 =?us-ascii?Q?2z6OYx8+ckfcE+9o5yIRn2BC0HL3BhaFlgPTqIgiTV2XJjp1yCU7Ve1rlRwa?=
 =?us-ascii?Q?Jtv1cDJ4iA4UWSgGbDFfOi2d1g2vA580X5Aa3rr/AVWERcNK0TicoPKob6OS?=
 =?us-ascii?Q?PTn8HolVFWS+1SMEmRPQhFTjOP/wyVvScZWUCwJwJ1m+veeGi2UlNzVFLktT?=
 =?us-ascii?Q?IoTeyhuGpOS/XF7WRsTxhVbZyitwKtCzW95VtUs+dz4V+AcXizDxq+tAVl/P?=
 =?us-ascii?Q?alRX4psFZpBL+SgEF8y7T7zkZzmAnKEEpZowHMDd4aNkRu8RDPOOi4EYQEiZ?=
 =?us-ascii?Q?M0L359VuH+tQ2M0I5VlkV8vOXjRrE13avOpI+0AT0qUWJhThY+X3jpJ+qT0R?=
 =?us-ascii?Q?t9PzUAi0JV67z9OP6UYq192JggKFMT3vhI4n4wo43zTFeNFW5bMMoIRcWdVE?=
 =?us-ascii?Q?Nv+i7lZEkurcgkdYjg7nBDtWME/DgGYZ+eydlrlS5NTuFIClmeZ1UysfCa5a?=
 =?us-ascii?Q?JL9IJzwzsE+AXd6Ibcw6CaZB7NiXPA+eC9qB/ubYBmGu6BEB4t3V9E973dC/?=
 =?us-ascii?Q?FA8PMAkIXsW5aakwBP5mRl/1LwHeMgTwBlzBuf6M8+5tgyq3yliHstyFt7V8?=
 =?us-ascii?Q?FuRAYdNezjiS5jQ0xDfbDmZMCRPZp2OeOSozdc5XEYyv/B+5Al+xfyqy+Yaj?=
 =?us-ascii?Q?mFyXsx6f38lK63kChbxuUSBIFvsKFSf6QIgfDHHzSoNqWNPmsmqBEBHXZYsM?=
 =?us-ascii?Q?CWANlClkiY3ZhVhNQom8wz5gELXwBP+0XpPfeEpOPAn5tNQBqW1Onu5iREN6?=
 =?us-ascii?Q?Onj+v3l0td2FZr8sd5B48PK0yDv3XmwNQi7Iwtt7GN9fg9wRY0MsqzK7dHQ4?=
 =?us-ascii?Q?cnYAs80gJZ7obwJyy0Jn9GcdiGDFq62wAfLWXpDRWB2LVv331k6QvAV4VXV5?=
 =?us-ascii?Q?NSoqF71tVjih0TVh3aMtaOGBaAPNDMxhnN2RfDar0dcxhWusjZt0JdzLZJ80?=
 =?us-ascii?Q?z0OqhaoUTwYjILjXyEUsLidgUR8X1XM4pAcBPppRL/etRKmREMPvSHeUxNZj?=
 =?us-ascii?Q?C+Lhysrwb6JZgowfZPynPovuoXyWalCrY9sppitUfpxkHUEV69OANdzqzVW/?=
 =?us-ascii?Q?f09g27bIALiEzhKziJG2JVn92HKTZeP4eWyTN5qQIxA8dvpLrddF9hyuPYVu?=
 =?us-ascii?Q?NMu4LW/XTN4NNbg00233ELGIxtxQYdnS4hXRm844wJP2VmI3jJ5iRSjV1FH9?=
 =?us-ascii?Q?ih88VBFxvJjp0K+du41dkzvLFyJ8g3xfdPa5w9mQ9wVpuFdAWDx354qzcN0h?=
 =?us-ascii?Q?d+zxTqHC7baHLAd9NxLzPcYJ+iO03hfN82aR?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9277.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?G8X0QTq6lm3wioy0bnKAy7uWsu7cAzaikLvSjdGJ7rCG9jI57oI5BjnbJ9Dv?=
 =?us-ascii?Q?CcEzxKjxemmCpzLmDj75VMyBrKA2YR7kWxuSeumavWFjgr/VEoi98giN+Y5m?=
 =?us-ascii?Q?uzl28bG/tHXZsGNRXibs9PGlnAirfaxGHxiC0Q6lpOgFJOFkdLZ50xxDye57?=
 =?us-ascii?Q?SBAmADUHZuQw4/FeTPoumBV/kaN7r1MArEB19hrK1zJ2tP3Iz3LVxrFIpviC?=
 =?us-ascii?Q?fWetANy9DKmdmsfdh+RZ6g3AY6VGxWVLJCCc5YCjQc94TKWbedLUvJ24j3Ln?=
 =?us-ascii?Q?DHm+9UDXIBUtgFKeYgUZEaWzwDDLgLXNsCjEUEaxfQenHnb2XjiY4Qrg2HWE?=
 =?us-ascii?Q?Lt/s9g/Ml1O1SI2XAtMp2QFzVmbbqYK8Oy8y0WEOHOwc/6ekPbwnhSPA5Rfm?=
 =?us-ascii?Q?kzWoOUvl90YkYf3mhr+A1rGkFgUPZQfq5MphRTa0yC4bXmlOJPhZeY2bgVun?=
 =?us-ascii?Q?0pZ9zeZJ+fCRuAecEfHhIA1HcOH+gWZkLobZEGsHIM6i1/yAcNynoTV4Jr/K?=
 =?us-ascii?Q?AvyjX/PJ2OuIi/7fI5q05JhQO8h4aHPt75BWN1DMo/rb1tDGvzcBEvJArwOa?=
 =?us-ascii?Q?GCHff37efrxcB02Kolf/U+UfphssKny1CH3d/EHgTt49V1y1WpuME/jDtUGQ?=
 =?us-ascii?Q?SoQx29SSC1OH7eDRPUnYgTdWU51AXUjzMyuad48ChaF+HCiCEAxNLLFfHRFc?=
 =?us-ascii?Q?w9HZETs70Npfoqc/gkLO7gXk9OiyJmQmBEMOY1ZTXsuSQL+chdUWnYeHOA0Q?=
 =?us-ascii?Q?OW3L0ApZP5aGg76afzF+c4CqiucUgpel/Iq0rLKWJ8A5IXh9ruuGw+gNJG66?=
 =?us-ascii?Q?dCu564Y5d5KN4maYMgqaNSo2nyNFA4fjI6Lt4/VM7ya7wUdNH53FRxtBuqt1?=
 =?us-ascii?Q?S+CakNiEyjFQmGCucwQ3ve+fQL1+DaXLnwwp19guSMwdkSjDCtkUFEyhL4V0?=
 =?us-ascii?Q?ppfpjuuxSZyuTiKKBZFatJbL5/R5K6hDvbB/PcWY0sIuZPbmlUNtMFhQEvU1?=
 =?us-ascii?Q?Zywi1cN5t20gHj3xym1M+yT1P1cOf9rwvld2hso3GDybgsx1PlioxLfL0r14?=
 =?us-ascii?Q?OKlE8V+6EJ7ktrf46JBe5k6NiC4/v+u9iSEboalLSG9fznbyk8lUkr1OM9/O?=
 =?us-ascii?Q?grG+gUyCT649bSpsX9JBfsvoHNkTAQqqIALbBqYPbi9HrJkBdaoAHFH7pM+z?=
 =?us-ascii?Q?68Bf0lilELIESuSqj1lBOEsVaVMVc6ky98JAWBujMxU0lGNWYzcCBfSzNtmK?=
 =?us-ascii?Q?H+trvAqcM/lCANHm8Q256Y06eSopHyEoh9ailf8wAAG3ccdkJEeVo4Apel1N?=
 =?us-ascii?Q?lkD2ogwFErxdA8A5RpjQkS01fWwa19YksF+9/d8CIg3ITTS4YT5DG/g0T51Q?=
 =?us-ascii?Q?UwyKHChs8WCCcv8sKjiEj14Gh06iaqV8NRuVKW+Z3Aw7ZPX0lUmvZaUh4lQj?=
 =?us-ascii?Q?RbI4xVvXDj++3aSo+2ADPavHPBjxRo1tXZS/Vbdhw9xS9UAgMpo0Y26I+gv2?=
 =?us-ascii?Q?zFuyg1ewUty993amXhK/LM5bTWDj0O1VV3IagXO0jy1Zt026I+w4qg7OVele?=
 =?us-ascii?Q?jpadmjQFJsER68HFkmwb7fLV5C0+8PZ7Os2iYEsqzFI/9960Q8fP6xLrksqR?=
 =?us-ascii?Q?BA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9277.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d998270-8b7d-4c65-7b80-08de3d7ed464
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 15:13:27.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ygZ1Yw2mhhHRrHQoRKl1RjvIRPuXokITLYWNk6dACdn1yKU8jS6yfOlXUrUatTtN+XoguLXrNXErwLvI5an/nBjtBT3jeTfklPTBmTImUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12879
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 15:13:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21120

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, December 2, 2025 2:15 PM
> To: iwamatsu@gmail.com
> Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>; cip-dev@lists.cip-
> project.org; nobuhiro.iwamatsu.x90@mail.toshiba
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H DMAC support
>=20
> Hi!
>=20
> > > This series adds DMAC support for the Renesas RZ/V2H SoC.
> > >
> > > Upstream commit 1b86d3ecde5c ("dmaengine: dmatest: prevent using
> swiotlb
> > > buffer with nobounce parameter") was cherry-picked to allow dmatest t=
o
> > > validate DMA controller functionality with and without swiotlb. The
> > > remaining patches add the actual support for the RZ/V2H DMAC.
> >
> > I reviewed this series, looks good to me.
> > I can apply this series if there are no other comments.
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> Thank you, applied.
>=20

I just noticed that all commits in this series were applied to 6.1-cip,
except for this one:
https://lore.kernel.org/cip-dev/20251127112941.55300-7-ovidiu.panait.rb@ren=
esas.com/

Could you please check this?

Thanks!
Ovidiu


> Best regards,
> 								Pavel
> --
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany

