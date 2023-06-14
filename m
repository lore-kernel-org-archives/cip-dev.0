Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E40EB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:44:16 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.102])
 by mx.groups.io with SMTP id smtpd.web10.12198.1686750250367897069
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:44:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Y9jPvr6E;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.102, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqSJuEFS5Efp1K5VfQni/fiGpFAg4dO2XbLKS5wKY8wFK+ET+Fy6BG60SfedDXyRQ0slZ5dXfCwnFWaoKlBg+/zAMoa5gargdx+I9cEb7LvoPK4M7BvDJZNa4olOApv+7nTs9MHx6ZnXbd8YSK81g666oPEtbnVVnKhVLRGg6vYVvs6UmdZA54utubD+2qd7QHKlHbGmOoUEgsKM0NpVGGL3xw2LWZq+yOw8ZqjxcXIutnfi3T3pffAIndjPippgHtPlkxxNiVqleDyHC60+JsTuGPIgyIBUgW2vht1TW1PHZcJFrnQ9l+8oIzZalYueDbAF5fevxcWPx0uAxXkNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9i1ybp4P+XLZ3CrEKjLsyKjgeTYZX44yqqHFWoZDPc=;
 b=MObqTK7DJ7p2fC0L/2RcKl6IRe85dszrLEAxiafU2l+V9NlP11QLBWChdiH5y9OSPeGzza/aeZjp1X/45vQI9z8a2SKYK3nEe5I3IaUsn4LAeboszXv9QYWvhbKGC7tdAxM6ANJH0RQnCcHZ9ANTNtkWOKpnlgkp8JGeDSv4HnNy+wq3/+5aatAD5NeLe0LjS/V7ljFuv5EfFioUMph6Yr7VhYN6udqOo7vDpkCZPijlg20exjnjuKSq5o/cwM4bWME2tUfiFkc+AaDuFX9mEhEZwFK1efwWtU+pfpm22a25qdcyhwZrll+eQujQKX/41CoIt2GHKJORLo339MovwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9i1ybp4P+XLZ3CrEKjLsyKjgeTYZX44yqqHFWoZDPc=;
 b=Y9jPvr6Ed+q+V1lSLqhMgaVn7HZdLugVx0oDWs40sF22dZmSLNknxCr7SMlYAwrPGBjxp7FwZxuMM+/L7yscr//MmaUNn/GNluNuzpWmjJEPCKZ3Wa5ldhw+eBvcpy7zEUmbVCMIsDqsc594BmJVGxxEie913JwFdhTCWixURaA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5357.jpnprd01.prod.outlook.com (2603:1096:404:801f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 13:44:06 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.047; Wed, 14 Jun 2023
 13:44:06 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 6/7] serial: 8250_em: Add
 serial8250_em_{reg_update(),out_helper()}
Thread-Topic: [PATCH 5.10.y-cip 6/7] serial: 8250_em: Add
 serial8250_em_{reg_update(),out_helper()}
Thread-Index: AQHZnqmdlW1UQi7xI0qlylHH7qxRu6+KTrIw
Date: Wed, 14 Jun 2023 13:44:06 +0000
Message-ID: 
 <OS0PR01MB5922D25C955039E88EA00B46865AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
 <20230613132339.150671-7-biju.das.jz@bp.renesas.com>
 <ZImUBg3er1tsqZzz@duo.ucw.cz>
In-Reply-To: <ZImUBg3er1tsqZzz@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5357:EE_
x-ms-office365-filtering-correlation-id: ed8b4938-b81f-460e-d96a-08db6cdd6c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8DQqBP0lrcuEcovhr6tXmGT0X9u1VX84qqXg0sOQkEdQi6RMWoqhXP19JhMHSsuuFweHJbmwSgl35N5gT6RqmhEUDjR83cAMIi+X1tTuG6pkMy0afErI1PCgH198MtCVFcPuKRo6b6TqpgppxoCQj3eu7PeeboL7WZJJSExbwQ1Zwo/Y3zMP/BCuyoUAQua8oEJwkkKamBOzhfSS7+lA/ySjOF0dDADZWTBKAKqx5nw9Mb1jVGBxOQJlH/ZBMiWo9DFXxiSfLQEb45ySAwjrHcRIC9KqOlWrg1TBKW8Hn4Sr5pNyVsuaLWu/esd5qSEmgKydCFVLQBa4EXUbos/nyPF0kYo4m3yr3qpBVnrk+VZJM81jVO2gMpWEXchboLXY7MvSA2ck2AvcB2mFB88d9jk149X0a9YtXaHi+gV0sBaIfdhYmR7D6LsbACa2nGAm4ej/oGgJg58o1/ElUJvrvPC2G7hDkXePICLSvDvps3ej8WSgDTb9cHtxPhWv7l/64gWROZhIJrqbuS8CnM6VVMGFX0OxxkGcsz0YQJiuhmnsNxE1wnUOUsA1lWQe+78CbOS07b+IAfngg54v1s47N/E0njE38sST4b+Qw0+y3IQGiA2WDSKFCpiRUhUdI5nx
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(7696005)(316002)(41300700001)(122000001)(2906002)(9686003)(6506007)(86362001)(186003)(38070700005)(26005)(33656002)(107886003)(55016003)(38100700002)(83380400001)(5660300002)(8936002)(52536014)(76116006)(66476007)(66946007)(8676002)(478600001)(54906003)(66556008)(4326008)(71200400001)(6916009)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?B71H13NVoW+gpB+bhwXtSAM0jJy/My+eY5/hEchN97HWst5MZpSWQMMJ9U0u?=
 =?us-ascii?Q?kL9eLVXNd/PdQXz7ui2KQfUCe8JEhx0q1NTxUAGC1+WDokde3GJJvfJ0+I61?=
 =?us-ascii?Q?eWOnOzfUt+EpE6ttWgqbWL+dbMZePU5/BHmg9/cB0FNaVQ5GB9AcHAcG35R9?=
 =?us-ascii?Q?ZZEzlj9Mb4/vJP6erOJ1ky7+F2xCsTQQbScXnGDSxd4J8T1ucKzikd72b3yC?=
 =?us-ascii?Q?BdwQPDtoYyS521xmRjdmbFixoxZVjOX7+Tj1sLV5Xz0ZnElQfglD8Jvy7s8f?=
 =?us-ascii?Q?ZKcp/zNeqQcw0kBOy0Wfu0dP5GdXfqoGgldaWDlIk+OuDG9wApRGl9Evk0Rn?=
 =?us-ascii?Q?h1lOogioZqDnFNBBE11hly1aq0/SZl0HIyTsA7JopV4DzgLpd1RtVaBh/x48?=
 =?us-ascii?Q?BkLs7ynFvs9BYv23PvHKkHMcdQecPzN9gmqChv1HLL6DkRJR2+cWP+UoRo4y?=
 =?us-ascii?Q?rmLhReqBX6SP/HObDKUhfQgsqeOyw2JIRb4Hyt8xXOWz0ive767hk+1d+dbE?=
 =?us-ascii?Q?sExwsbHhu30y7STM+52tfoNj90oQBQqLUsGJk/jMIxLVml1C9zSe1XlSfujQ?=
 =?us-ascii?Q?inS+F6hLgijRHoCuTUPjtHHjMkXSDOGVydWdGN1Wh2tJhOi+6yGRkT9tU8yG?=
 =?us-ascii?Q?igNlyxxqTcfdfZQHHjpyocjhnH5jQXWVpfWCBv3NTFsN05Op5Vi0S6qWR6vW?=
 =?us-ascii?Q?6Y0KKHvWOsWxRpmYB5pis1/UGvSlGObAkSHp1i2KfK9YAcyfsNBVfQnKvjdV?=
 =?us-ascii?Q?v61eTf7Jg9taN8i6JAxp+4iOLdcCaenKGh6qd70WT7vi06uvzHr1u2xyKVuF?=
 =?us-ascii?Q?b6ANcrEfD71BAZuuFvq6XGmEgpwXOqchxzT4Hr80/b7G7OSqGcasXmB9r944?=
 =?us-ascii?Q?FBOxnDwV/b986UEPuH9OKmztAlBOKnwrlsUfX9fskN2YvvLlD5j5//f3Bsmq?=
 =?us-ascii?Q?oW8QlD7lN/9TlfF3faDalZYDCkxmxRW6YRkvPWy1UqlrvX+fBAxa/EUERH+l?=
 =?us-ascii?Q?70CD2MpZizFVfMYvHyhZ+7mk9fXjoyebOmtw9+dTRQlh2huJ/6MX7sk9PbSi?=
 =?us-ascii?Q?cqabsDrlIKyysJsLlWzZhQfqGZxGvYxlfA1hQlY/u7+xLt9pQgPPTecB6hTG?=
 =?us-ascii?Q?vaWnVRwey78U0nT6Ls5XW1kPmDkwExXgvslb+fQzHwlRPLtvb0HkkFd65H5T?=
 =?us-ascii?Q?IFGUQsp/XVt5eUVhU0ZKhI8aBSFAsBDHk870UQoUmYV29BoZ6YSRMKj3E7cx?=
 =?us-ascii?Q?s7zkagjNagLs7TQSI0xWJ9Ew3tqJzAR75W73Q1k5zZRWZ+vwamQDHkPcNuhd?=
 =?us-ascii?Q?c1ga6DPtsgThLlLpSCBJiLd+npad32MEmhHeIZH6FR5QpJ/4bpy/nK+JsX8a?=
 =?us-ascii?Q?JXZVDABbCmaDS1lgH0GzriHp5ANc9KLG00QUU7ZYxZObP9Y2l01hYNzju/mV?=
 =?us-ascii?Q?Ep1AsVNE8GybplRV4NZrX8sNDSUh4yf2gVXbkQnV8kJZp/j8k9WfCfq6/Efi?=
 =?us-ascii?Q?MqPhmoz8Btqo53faw3RTj6bSzDs+oKTqgPa/cnV/UA98UwKvBE1ij2eiBK75?=
 =?us-ascii?Q?jSVheBT2S+iHvJLHUIcPeJ/Cq2mK9b6y3s4xiKlsmu1qDLudtl9CRaS+UPJ9?=
 =?us-ascii?Q?WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8b4938-b81f-460e-d96a-08db6cdd6c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 13:44:06.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIxj2ih9XL39h+hHoISLobjZoTELV0QLjambDyDX/jky38mM3rTs0NaVs/erHZ93rqT2U1d0WXGa98ITSQLasGi4Afzm7ttqr2P4rfowjg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5357
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:44:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12030

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 6/7] serial: 8250_em: Add
> serial8250_em_{reg_update(),out_helper()}
>=20
> Hi!
>=20
> > As per RZ/V2M hardware manual(Rev.1.30 Jun, 2022), UART IP has a
> > restriction as mentioned below.
> >
> > 40.6.1 Point for Caution when Changing the Register Settings:
> >
> > When changing the settings of the following registers, a PRESETn
> > master reset or FIFO reset + SW reset (FCR[2],FCR[1], HCR0[7]) must be
> > input to re-initialize them.
> >
> > Target Registers: FCR, LCR, MCR, DLL, DLM, HCR0.
>=20
> So how does this work? AFAIU looking at the previous patch, FCR is write
> only, you get IIR register when you try to read it.
>=20
> > +static void serial8250_em_reg_update(struct uart_port *p, int off,
> > +int value) {
> > +	unsigned int ier, fcr, lcr, mcr, hcr0;
> > +
> > +	ier =3D serial8250_em_serial_in(p, UART_IER);
> > +	fcr =3D serial8250_em_serial_in(p, UART_FCR_EM);
>=20
> So here you read IIR...IIR is @0x8 where as FCR is @0x0c

No, you are reading FCR.

>=20
> > +	serial8250_em_serial_out_helper(p, UART_FCR_EM, fcr);
>=20
> ...and write it back to fcr?

This statement is correct.

Cheers,
Biju

