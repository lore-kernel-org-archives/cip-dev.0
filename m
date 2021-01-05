Return-Path: <SRS0=opTW=GI=lists.cip-project.org=bounce+64572+6037+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A035FC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:08:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191DE22CBB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191DE22CBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6037+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id o6OGYY4521723xD3mkpboKuL; Tue, 05 Jan 2021 09:08:05 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.114])
 by mx.groups.io with SMTP id smtpd.web11.10.1609866456976193283
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 09:07:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knHWkg13vNcmDyuqIGh92qY2NjHLmj9bfvI37NXgb3Bz37RnJF6V5Z+v9M83zP92GENlmMW06mVUTevkuqtqfwnWGz/HWBodNOSIJqQuRmrK9GmOl6zrXcuIvQTkRmKbzXTSNdAQS6hiiZ0ir8t7WBvZDC7lLTbeEyOuiLPRoqvG0FOTEwQrc2NdNMxfegv77OMrhCHMyST+jn4CQgzcVE+6KYjyZnqf2hjFMwDSRbbCfLqPnQ/L9d5WvV04HekfypuJMOPx+/EBNc3GxCimAe0AOSvATZHyntkicOW9ZN03Mll7bXPsAG+c160YSjtb4Fo6ZwPYihAMQSxd4HxaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fMXMlyoQidCnylAGVNIzA4E8TQJaJoxwXEXwDKU7nQ=;
 b=mrpmPSvMUriT2LQQc6QFCd7OvO6/lD+Yhcqq2EJTKEbWH3+WHNjZvZ4nMeh9MCRNggTHMMVoP9doaMl7PaFEaaZsBhMSBkWg7sqEqEcHAyv2FN6fWTLB8EVfeJRY1FTxwciBTeWV/SwtGSSMnqhczj22QqbSCqRn8d4CB++nvPrW+kcduVe3O92wM6EG1zHPsvnG5hiFO5T1GaBc0MSJa0QExNCKSjIz0VDWkMvbrtWJJBJ9m59Th5USAtdWmmlqmudiCoxjAAc8rSarOfGGyT4Vi2wOjheA/nbV1cNxFuZGDrK3VwctOAMn9g5E4yO7t4WPE8tY+I/G2fTfCtGVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB4869.jpnprd01.prod.outlook.com (2603:1096:604:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 17:07:33 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c%4]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 17:07:32 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 08/17] spi: spi-mem: export spi_mem_default_supports_op()
Thread-Topic: [PATCH v3 4.19.y-cip 08/17] spi: spi-mem: export
 spi_mem_default_supports_op()
Thread-Index: AQHW44MSGS0HoYc/1UeV0PitgcK0fqoZQxaQ
Date: Tue, 5 Jan 2021 17:07:32 +0000
Message-ID: 
 <OSBPR01MB50486F2B0C70C69834330AA6AAD10@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105165146.GB361@amd>
In-Reply-To: <20210105165146.GB361@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1500b4da-e1ab-47ab-648f-08d8b19c645c
x-ms-traffictypediagnostic: OSBPR01MB4869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB4869EA71A7CB5FAA07C5797AAAD10@OSBPR01MB4869.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 OEBbDpW13PrPlUtBNQ9jbY9c+DhEx2tAgNBe7ilP/DnQpKlpFJWB17nW7xNMiYECX2v+YuEZKVuYmparxoIjgVkjCUQTscKQ7CRh24x8CP2fGOvnn+o/ukfDQb2oSDDD/4CXpdtteyS/DQ75H/7iYk4/wuIVngzU+HRSseQpDa/2Bg0O4uopcFaV6Ls4LQbrDz0JQHQd8azNyRoxmw85bH30SFWvAQKdG6FojuUjX/94GBBgPtjILGngFy74Vqd5ytw61UnXwhJx4scpPK9hkxcqFN95fVBzFKY4ahgf9q6W+7nuWXjWGGVShGzz2uuGwj80P+BPXTn/65gs8Tl9U5+SJ8VGXizc9111zobTuSmT7Dx5n0+4RBuLXXYrB4TBv4eMSwwgP7fytkhPIktQEQ==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?GecJSjPxbrisqS/79ImkzVeUAzX38zqJaK+m3R/U9gcOLOfF50pvmRs97r0Q?=
 =?us-ascii?Q?GoFWXzxbkr8SkOMilJjRrTIMjOzfABlU3bcbsmBYMWR7dWCUobjxotNNuP3G?=
 =?us-ascii?Q?3CDDXN5yzZZ6G6YC6QTH/9vMSdigV0BhOTOXLA0xYwDxObula0giFj6Mutqx?=
 =?us-ascii?Q?Lp2vIz7YEqySwjSZ6TnPMSl0kVya/bESxhf3255aeh7qP19u7huDyf+TPOOP?=
 =?us-ascii?Q?dDrB9a0z8v2HKSwnhK1RAFzqY0zQ7aKiAO2aJwwn69w8OfyKs3vtbVNMvMc0?=
 =?us-ascii?Q?Dwp2f95OlA6EzJ8t37rcTpU9YrZpdsy+gmDSzh+jhG/zuO5uCKM9XKHBI8QT?=
 =?us-ascii?Q?ixsry20NrHp+h1sa9WZMZ8vDr7HJsAOpXsum4rIdSJwhKkD8r/1xV8s52Etl?=
 =?us-ascii?Q?NyHr+ueARDDs9X5Jk5g0fFcLXj5vhVKOwrmn6yARqFrOMNPCyrbYUFGp+azX?=
 =?us-ascii?Q?ikSRp49vINb1QYPuy+rVvXp4tRB/vPmFaOoVXZ+YPddAJ2XtJRwzbOuCW2bz?=
 =?us-ascii?Q?lX+zXbgpUKh2zNa4sPaOJb/O9IK6+Bh+e8r9jAoTk/kLZqHtqWpudvJELbyO?=
 =?us-ascii?Q?pde0hsBjufV9vo5t9caz81jp0ssLIv0mML5KInbKHRzjYNaX8X74N1/GTw31?=
 =?us-ascii?Q?Zu9qqJnImdGDjFHaqCVy7+6qW2EdhYaVyg3deF8KGL+IUYCT1xcvANbHA9fV?=
 =?us-ascii?Q?gskXgu4fRRul3yON4Jd8dQaiXdKiGQIk98fMgx72SFnsNoZf5kPASH36grXi?=
 =?us-ascii?Q?LbkJRHfLBSYY5crNrE8cpDADhEf7+MrMSVpD+IfCPE8c5NiVFx00cYVFioiE?=
 =?us-ascii?Q?L3eofrGH+yFqPNTWwBJf63B6MP5BgrzEMfHpMBnTbCPYRZu+2qclbWLYm5Y2?=
 =?us-ascii?Q?Z6np9STs//SE++O0nXSHLde/MNat9JlWq52qFJIwbzx+9tUHchd3dFYYbpTf?=
 =?us-ascii?Q?PakoGSWpgJ+3EstS4gH/ULvzv/le8fxoL3T2WCGkIFE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1500b4da-e1ab-47ab-648f-08d8b19c645c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 17:07:32.7247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocopW4bmkX3pei1VMNDwgRFPgFXMA3dRr+BZtKonOPOypKTbFSWZrRsIIZklm81L1gMsdux34Pfydo2KGP8czqeUH9BrRdUN0efDlGrNsjxXIm4VcGHXhJzVC4nI5Es/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4869
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VomZl2s4xZhLjBeJPdKEI9Orx4520388AA=
Content-Type: multipart/mixed; boundary="KQb8vC1u3aaqNAKmD7bx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609866485;
 bh=55UOgjpiVoRiz5iPWCRTnnY512/pu17Ts3C4jrRL54o=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Z/7doMEuXu7rzXNNvVnoISQRclrfSyDhT/AUwVlfE00fsHYL6UegZBj3gNueHfdNIkf
 98t5rju7ftzX1uib0mVOhIrdQ0T6wRgcvfmO9504lDNPZL4NswJ4fniaFf6Q2kK1Kzf+7
 8AQ1wTp+xt6qqS5xlehi97oWm0wPKGdHM/M=

--KQb8vC1u3aaqNAKmD7bx
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 05 January 2021 16:52
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH v3 4.19.y-cip 08/17] spi: spi-mem: export spi_mem_def=
ault_supports_op()
>=20
> Hi!
>=20
> > From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
>=20
> > This patch also squashes upstream commit 72e6841608b9 ("spi: spi-mem: F=
ix
> > build error without CONFIG_SPI_MEM")' in the current patch as commit
> > 46109648052f ("spi: spi-mem: export spi_mem_default_supports_op()")'
> > introduced below build error when built without CONFIG_SPI_MEM:
>=20
> This puts function definition directly into header file; I don't think
> that will work when multiple files include it.
>=20
> Adding "static inline" is the usual solution for this.
>=20
Agreed will fix this.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
>=20
> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > index 80db2de83402..253a8d451d4c 100644
> > --- a/include/linux/spi/spi-mem.h
> > +++ b/include/linux/spi/spi-mem.h
> > @@ -239,6 +243,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_co=
ntroller *ctlr,
> >  				     struct sg_table *sg)
> >  {
> >  }
> > +
> > +bool spi_mem_default_supports_op(struct spi_mem *mem,
> > +				 const struct spi_mem_op *op)
> > +{
> > +	return false;
> > +}
> > +
> >  #endif /* CONFIG_SPI_MEM */
> >
> >  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)=
;
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KQb8vC1u3aaqNAKmD7bx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6037): https://lists.cip-project.org/g/cip-dev/message=
/6037
Mute This Topic: https://lists.cip-project.org/mt/79450068/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KQb8vC1u3aaqNAKmD7bx--
