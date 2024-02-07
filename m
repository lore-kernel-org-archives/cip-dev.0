Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBD9C4828F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 22:47:12 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.84])
 by mx.groups.io with SMTP id smtpd.web11.4489.1707346030194943390
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Feb 2024 14:47:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Nb/rc6pC;
 spf=pass (domain: renesas.com, ip: 40.107.114.84, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VevMAQQHpSWB3aU37My4R9GwNIi0Yod/FS1+KV4dduDMCDxGUak4jepNSly/vqeOmYzbbtFbNyhu49RYF/J7JFgFA3WAeWryiGDdVTpWd8PkbSeD/HUYJ0yRrAZIQwBbFZ9oQi3P4Xi4mMxkEuyE/WCZfDkoDBIm1hp7D0a7SdqvOS0jDPH+54tt+fIQWS5komUwhEwruAVecr4ITFmOtthysqHiT5pDD3B+rMsVAh8u4t3rvRtUQnzwdXtB602NiU5y0UX2xhCCxUuiJjIaqYj+tldbAuGNjf3R5ax4NjTQ0ROnRGWipt+1hjvvicDj90a6NBX6bDTKzcpCm5qbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjR+Nzf+NLcxLnqq5eSKr+wlsqlhBN75rluwEFm4zB0=;
 b=cWrEYGLQ3i6/yss1oUux3Y+rX9DGYSD1Tz7wMOMntWbxVxExNOhkvZ71nGgVLCUo/FlpgQFquWaeJIpnYxwgQGFrTwJiTtHn0Lrm7TV/VINWuCegNulUV4pwnO10bvH14NbalI3N6zYLw9yRZjOeHY95SMAHBNqhbRR3CMPTkZQrCLueNxgTggIO929mihJUkojASQhLtrgy97mCMLJAX4FWxgf3YNh3L1x+Zgp9isWbB56H+IolfS7dL0t/jx6ExgbDGAtJSX5k6T2aNEIeXOlRg8/w3zliV7LrQRziMiGHaX59amdjxd5YY3AYF3Y0NPV3544VLWax9s33ryjoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjR+Nzf+NLcxLnqq5eSKr+wlsqlhBN75rluwEFm4zB0=;
 b=Nb/rc6pCTd7yDWBmPy7rHTlNXncS+AEqjNYjksdv8KZG9zw1WCFvxSfV3LEJJ2Oxts22DvYd6bhBSL6SfAI7vZDEQveWuoIiiXCTynws99RHLWE7OoC6h5e3JuYvcRjZW8OeND0pROAPVkYY/4Ccb0mjfMCz++bc6ZM+THQzJDM=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB11988.jpnprd01.prod.outlook.com (2603:1096:400:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 22:47:07 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47%5]) with mapi id 15.20.7249.039; Wed, 7 Feb 2024
 22:47:07 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [ANNOUNCE] 5.10.209-cip44-rt18
Thread-Topic: [ANNOUNCE] 5.10.209-cip44-rt18
Thread-Index: AQHaWF5NoGcXN6haf0Cy1q+16iXwgbD/fgrA
Date: Wed, 7 Feb 2024 22:47:06 +0000
Message-ID: 
 <TYWPR01MB118627FE1C9D6E1D42F3F9AA3B7452@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <ZcEkEFRfo3D3n8lh@duo.ucw.cz>
In-Reply-To: <ZcEkEFRfo3D3n8lh@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB11988:EE_
x-ms-office365-filtering-correlation-id: a1c19fae-cd88-4d88-fb28-08dc282eb630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LxPxh6gLGARqVu0APkyU4hSRtMMv4QtBJx7kOD+sJ+vbwzQy4CkNnAghyUziASPWmj94j9G1MaC7fL+iB/TKBis9l26lL3RO1j7feqK7rB0/GT5hkzAsbq1D7HH6yGgi4HtXwyYybweVOq8T3XPRuumuoiUgWDSE4O5tX7QHYrfJn9ZqATG/viEkUcywHoJ+gHfMgA/6oNEYSiNGYuvuuxdPgE7/PktVfBG2VWAYIng/zamTGm0b5bcAFx+Lfr6lzTfD5y8UEpBaGew9/2iFrCRVNTxFuJVX30oFbaVEqOhIVEM54xMdLQ/jTi8f7qehpg0Dyst4nRdbc252ps6QGNAxNuPd7joQWtl58exqwQKcZYdVAC67JT42GYg9Vvvyh7zq5Vq3geWIjtuGJCsvr+4nmvIQPY9IcnBTZuPh4hMTFKVfywOkskjgZ/eAcvY2tQboNVsUGcC3qUul0bH/NrplNc0jwEpX7/85GSRZuE2iN/e6ChbKhVLuHLeSLgxrqIwZjPQKqfocGYuvCzLhSQbmmn9Nkwyp6evdDXs0Vha9doGKq69/FOKjwsPL7H6XdR18aeaqikgXAT1BreOlsRk6ktatMHr/WjkUzdnqlNs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(38100700002)(55016003)(84970400001)(122000001)(41300700001)(966005)(478600001)(110136005)(2906002)(4744005)(76116006)(66476007)(64756008)(38070700009)(316002)(66446008)(66556008)(66946007)(71200400001)(9686003)(33656002)(6506007)(7696005)(8936002)(8676002)(86362001)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?ExEe6yn+D5530CyaiNo0oWyBpcgTmh5+12hTisY7B+EEYNHpuMpu8viC?=
 =?Windows-1252?Q?M7ENXSpPC1Ab6OYsR39vqXxfjHBYE0JPH8TYTculM3T03EONMxwh/GdI?=
 =?Windows-1252?Q?GCGLFe8HA2BtnEEZrY0/FDGu01MaPpw1r9aVq3ej+86Mi1/DF9BjdLJI?=
 =?Windows-1252?Q?K7jgk+nTbICQdHQAm7yRJt18LmyWK3wwGH02qtSLq/U/8qZWL2Z2B8z8?=
 =?Windows-1252?Q?DHtwDW0nC2SwChWsV9c96uYU4ASWh6T0YOzFc55yOsFG1hbEjYIAvB5C?=
 =?Windows-1252?Q?8278AfykVi3r0g/H8FZcNAi/kimedCTsDvRphbdaAx5wh92ucqJlO6bO?=
 =?Windows-1252?Q?ZWEfVV84742mtVyLEN8kET4+PZMX2j0tX4iwl5MW9mFpBmyEJ14rnhyd?=
 =?Windows-1252?Q?SPKpslUHcg9Y4nFNAFw/XkEj6+O6P6g5TXDIqXtkdeJpACWwvPjTJVgO?=
 =?Windows-1252?Q?EWLBSk8RqLe8LLdoJCdZzdSxDdUG+MazvGN8LKlJAO+j+JY6/494nw4k?=
 =?Windows-1252?Q?kYN3PiLWBkQoMNis+ALcJff93EzL5YeGRdAo+YdvEQq8w7HrPwngPczJ?=
 =?Windows-1252?Q?tfi5QCLzkgWN1aLJRIUm01ONeqiX93hm6TQOoYPx3vYSN2gh32SJpiLB?=
 =?Windows-1252?Q?NcWcn23pVHji9HtW1Ky+DEOhZe/B6EgY9OjFDIS2XzRl0Jw7S6/Yl1m6?=
 =?Windows-1252?Q?qzjf+Fpjt6rtzMpWuxrF0RgM1CJ7eGt29k7SVIZu1l7aBjia+zXqZAH7?=
 =?Windows-1252?Q?fFNe6l2bKp0o4J8yAKJeob660ZF13tkyfaaQmjyInpzw8iI+TxmDmvBj?=
 =?Windows-1252?Q?pEvb05bp3tu/ejgCDLVPmVLymfSlkQ+Pe4lf4iqkmu0aRq9bPXpMPKGh?=
 =?Windows-1252?Q?8FalIlVbVL7dtiTFeFkRqIrnKBJqSj3/lu93IzESQXL6R9FQpjgMDUmz?=
 =?Windows-1252?Q?7vuiQ/ptoqckWFiT/oART0/0BZ9nw6XDO5rAJbWBtA/c1/iLLv0V0kS9?=
 =?Windows-1252?Q?FYa4c7PXgaJx5b64UfWPOS56B3QCQEhXpJgLEaVos5q5hd9sHdv+60lA?=
 =?Windows-1252?Q?5PkjECBMp5F7rAlCO1YCv5DmmM2vvRUSw3knF9FPjZq5jLiVnGW4vWMs?=
 =?Windows-1252?Q?Ek3ZJWGjxUewumw6cI/Vl8r9yiWzxT7e0qpRjetwHn/A0EujhkVVv76L?=
 =?Windows-1252?Q?0S2Jgj9RO11UPrySKuu2HlW0Gc7By7l8nhy5+6WN8UEVUomXlcDuSb88?=
 =?Windows-1252?Q?9N2lj3iRqsx+mDULioyF15sxaeMDmxbRB9r6VArrsFX71NQrAf6Gr/Bd?=
 =?Windows-1252?Q?4kEW0XlPbn/clMUgUqkNhFtGqpTDrSVLCP1EdnzBu7ebfLBUn1/WQXIc?=
 =?Windows-1252?Q?6vpZCnvPNmxq10/MoNqDWPSXbZnsUA6BuTb6hqFmtBbY8j6Yp2VTzJrY?=
 =?Windows-1252?Q?LPIr5W9phUtp498ssOiOfA3RCXIhFpQ9TuTmg5iak7RgPjpzPO5NQyPS?=
 =?Windows-1252?Q?xAdMtzNEcJ4G9FoimsNVMeAus3vHXVESVZBdEk6XJ3jKkcVoD3VM4mvA?=
 =?Windows-1252?Q?UzHvtJf929A0SYNvXjQ78mf+3/KT6uDp5MjlshetV2qqGQ8pq8wg+sS3?=
 =?Windows-1252?Q?TYEoSRnwoNNBICYdlx3k7wknfViRjVtgVmnVaRiqXafjjnjwRqjudrtb?=
 =?Windows-1252?Q?nXTyHmjbIXsuBeefyq66yiEBf30pZYNNlyJ3u2d6PnWIRvCgccUoxg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c19fae-cd88-4d88-fb28-08dc282eb630
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 22:47:06.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuIMZlEnytkJsiuJPi2zQc9wIaswacSDSeFNqJ79WUVYT1xCFOtWUC+kYqcSKQxwYkGnF7t0+fEu/VEXOtkLLEpQ73+K+lZ0+mNGZYp9CJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11988
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 22:47:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14914

Hello,

> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, February 5, 2024 6:08 PM
>=20
> Hi!
>=20
> New realtime trees should be available at kernel.org.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-5.10.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-5.10.y-cip-rt-rebase

Test results:=20
- Dashboard: https://squad.ciplatform.org/linux-cip/linux-5.10.y-cip-rt/bui=
ld/5.10.209-cip44-rt18_d814befd1/
- Summary: No new regressions

Kind regards, Chris

>=20
> And their content should be identical. There are also tar archives, at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
> Best regards,
>                                                                 Pavel
>=20
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

