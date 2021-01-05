Return-Path: <SRS0=0vOR=GI=lists.cip-project.org=bounce+64572+6038+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E28C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:10:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2667E22CBB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2667E22CBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6038+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nhwWYY4521723x5bqYm6VLFu; Tue, 05 Jan 2021 09:10:03 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.135])
 by mx.groups.io with SMTP id smtpd.web12.60.1609866602722507580
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 09:10:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FElCpVkOuWPdJQFvdfZyLyGqi0LXTJKcx8XuaL0L/OfI7W2Jg7HNnlTmuygzemvJpEDSihiQbUfzcUM1SI1f/7aLC2DmU0EXOtVEo9QzcfZfBzZ8UZ11U6iMU1oIXfJ5uG6PqKyb52nVgbzQor0ir+e/mxmIKagQzdoFKG/LOD2HmVM6d0NP+AXForZhFr+BgbGwPDuJyPYCS7v5F53Qk3ide11woRTEoIutMB4tBf/Yvi4ddGligGOT6GgQYJWp0dv307GQaeovvHIdODm6aQV58cz5oemiY3MrTp0HNDDdF38XEq9fmAurqn5NJ51o/Y5rKMaQKdBaa9eq/p3V0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPYw8T+Wz+XCzq6dWooE5MIzNs0gapKVpb+dyL7M8Js=;
 b=cKISrVN2PDUfNJ/JbYqJLgNTRWwPqyzzsnYd6sd2Fx4dLtyXFegDw19IfKseKPjR7suulxpbW+wYqUfaiAao6fzrpIFvRLwg8X4HNmnbrkdnvmVGLYgvmQ9RzeP2xPPXk8LPqMZT1rTWUlwnrnTZTFmvaLPBMATBHeuicPNar1cz9XovX8g3m7gbYlQjowvG0WGthRElN6CqhYN5j1JEQMrAo1qnwKkzhzbFo6Hy/ubof6eMkwsmZy1pmyaKRLqxqzvEYjRm3BeRdfHAPkPtGLQoPWESHjk1Rz7Jfysj+7504uAYUtu7Mkj9BW8X/Rz8WcGeBsa/g64sf07UY5SzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB4869.jpnprd01.prod.outlook.com (2603:1096:604:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 17:10:00 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c%4]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 17:10:00 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 12/17] spi: spi-mem: Compute length only when needed
Thread-Topic: [PATCH v3 4.19.y-cip 12/17] spi: spi-mem: Compute length only
 when needed
Thread-Index: AQHW44NhCVEREsmEs0SmouhpytybNKoZQ4hQ
Date: Tue, 5 Jan 2021 17:10:00 +0000
Message-ID: 
 <OSBPR01MB5048B4F5E3E312D79D262992AAD10@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105165358.GC361@amd>
In-Reply-To: <20210105165358.GC361@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb29e82c-2353-4c08-4432-08d8b19cbc55
x-ms-traffictypediagnostic: OSBPR01MB4869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB48699183E4FCF4C218124169AAD10@OSBPR01MB4869.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 ME7P4vfTooUTd43ao7Xtyd3IUX0rYMhqmwFPUOWMAaoIzDY/ogI2W/vtx1xI3pdZ9hzvGClhPsA6djHmshM1VJ4eJg0ZRgzBvRXWDbvHucVekyR/FX+EoQ6qPoRuHTJRAVN9PaTUT7jLcmJs0PVjrLd7NW1wL+/rDQ7X56ebkHHyavYDMYR6Ipm9EDR+LrGjIkjcX2F9OmQjUI/POEMjYthbBZgwGetlF38ZA4JpuH4vtkEAfVTbxQFYr6/CrsNlWF/0/qePDmpvcThkcMtdgSAUxXBCxcp9qWiw25/U9kHvZtN+tDH/Qw6ZhYYSZu4fSeDrExjOTg4oeydBPPInZkC5ff9zC/8ckkHeH+U1nsw7E58BZESZtpTLih+OlaqvM+b7o7fblbZSGHHEt49n7A==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?pGO3ULV2XnCt+yMAW3A9s2H5siQ/cBWgDepjwIBH4HL4IT3mhQYLZ6ms1JLS?=
 =?us-ascii?Q?0Pwr0lsPjSy9/5XxXMfwTaoVXkyY7Wm+jjqWUoHE+47u/CqXOZ/t8AD3bhyW?=
 =?us-ascii?Q?qRpmrkddPeCOzgZsKvdXWDzqMzSYnPgz+DA+JEYdAmyLlMrt42OZIsFGkyH4?=
 =?us-ascii?Q?Zm0tzYJ62PMfxsQy4eU1wqUfzEDyiGp/R5eo2+1Le7jffkv1FZo5Ip342GUd?=
 =?us-ascii?Q?H52TAA+sH+OV7vJdeO+iOzbhW3kB6kgk4TnAA5a86H3/fLzzjRqnZ8sIzfMt?=
 =?us-ascii?Q?oZJMa1MhM79hrZ9kZVM6UU96RxISYm0hYditoC1DPO6Le5FXcNBzf6+sRSzg?=
 =?us-ascii?Q?ocB6AhlsO735oB0QoefVTJVYtMnP2UVxOxrKghWpYVBKyVkIs77ADeih+QR8?=
 =?us-ascii?Q?empw9Wwfga3TW/9c8/fglZGcH4+6rYUiijuTIC8SnAzpEzCfESKxSmacdOD6?=
 =?us-ascii?Q?Pe3PQqTPaWLulrVrriiQP5iO+zyE9TVtQkYM7AgD0st/xk/xXcG5EPj7tqdE?=
 =?us-ascii?Q?Xc87AWigMmemskUiusnGH9bOdr21D3CX4H7vomE2YfpT/QJRw73lgNJIBAg9?=
 =?us-ascii?Q?LoHPOqP3dNf+ZUsi6ap3FmLvZTm8QfzYdzGFS0IeDSij7j6npnSdhNLev7eX?=
 =?us-ascii?Q?0aHDvzaEv2uwChsTjp8Kd2szcG2YP6ckYMRS7LEP8icgLwDTuEzbymlEBHwa?=
 =?us-ascii?Q?jMzvdHDotw+8TRj3Ac87bnTt9r2vChNDEZemvLeewf7D9xSgKVTe7vXBNIQs?=
 =?us-ascii?Q?K1HLrhK9TOj+U0T7BW45J+a0r5lOp/mJAPYz94Bq2pJSpLn2qGXBk6C1Ob6s?=
 =?us-ascii?Q?PodBshoAhCOpg+vYQzGoQA1oH8cXbkhZQCY8Ihui9ADvd4nwIEpoDQywvern?=
 =?us-ascii?Q?qBRh5Y7FmdtEPjePeizl2IsDSiPCSfi9PMmxtsrglk6JzoV8t8/RZPVJqLmF?=
 =?us-ascii?Q?TTerJIYLM4b2AOkn79nP3E9psEhE1meGpMaxpMookXI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb29e82c-2353-4c08-4432-08d8b19cbc55
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 17:10:00.4015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuWWpZroew8DMe7RWxe67JvrkDYUt+MOXfPu+HhMkAwKEZJVlafzD5eTJhQpZUqZBVlkhjfw6qjGq+VmLUW7II7nJ02o8VMHuNyAfCj+CN6SzPo77bCevzvFY/x1ZBeg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4869
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4hprfPu6hfJO4qTwAgl6lJFIx4520388AA=
Content-Type: multipart/mixed; boundary="BM0o6s2gUbRyBVmq2Z7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609866603;
 bh=2jHJq4bXIgPf0qDKwtdpZQRtLWPVqefeGttT6dmUM/o=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=YAfhjVoBTRYd+zwjSFKBCBFLt8wKIuCfOpviwZwiOytF5B99vv+DeDv2Spfj1hqpBrL
 rZKj6/M5TtqsDH0ChtQFVZhljLxLU5Wu6enmnKqyC7ohAk2NVQHoBwDipO0bQQpZgS17K
 34bHPwLPClRQ+4NMHAbJlKIcph3ui0baFAI=

--BM0o6s2gUbRyBVmq2Z7W
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 05 January 2021 16:54
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH v3 4.19.y-cip 12/17] spi: spi-mem: Compute length onl=
y when needed
>=20
> Hi!
>=20
> > From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >
> > commit c0e035ac56680e74b27fc218c07e70f4b9b8b7a5 upstream.
> >
> > When adjust_op_size is defined, len is never used. Move the len
> > computation where it's actually used.
>=20
> > index 59f7aa117a10..02cf8c3f7350 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -412,12 +412,13 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, s=
truct spi_mem_op *op)
> >  	struct spi_controller *ctlr =3D mem->spi->controller;
> >  	size_t len;
> >
> > -	len =3D sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
> > -
> >  	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
> >  		return ctlr->mem_ops->adjust_op_size(mem, op);
> >
> >  	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
> > +		len =3D sizeof(op->cmd.opcode) + op->addr.nbytes +
> > +		      op->dummy.nbytes;
> > +
> >  		if (len > spi_max_transfer_size(mem->spi))
> >  			return -EINVAL;
>=20
> If we are doing this kind of cleanups... I'd move "len" declaration
> inside the if, too... Not that it matters much.
>=20
Should live without this change, will drop this for now.

Cheers,
Prabhakar

> Best regards,
>=20
> 								Pavel
>=20
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
>=20
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index c3a08afb6edf..bc64b4223913 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -410,13 +410,12 @@ EXPORT_SYMBOL_GPL(spi_mem_get_name);
>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>  {
>  	struct spi_controller *ctlr =3D mem->spi->controller;
> -	size_t len;
>=20
>  	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
>  		return ctlr->mem_ops->adjust_op_size(mem, op);
>=20
>  	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
> -		len =3D sizeof(op->cmd.opcode) + op->addr.nbytes +
> +		size_t len =3D sizeof(op->cmd.opcode) + op->addr.nbytes +
>  		      op->dummy.nbytes;
>=20
>  		if (len > spi_max_transfer_size(mem->spi))
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BM0o6s2gUbRyBVmq2Z7W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6038): https://lists.cip-project.org/g/cip-dev/message=
/6038
Mute This Topic: https://lists.cip-project.org/mt/79450076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BM0o6s2gUbRyBVmq2Z7W--
