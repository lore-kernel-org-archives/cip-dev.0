Return-Path: <SRS0=BFGc=GI=lists.cip-project.org=bounce+64572+6039+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7DEC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:12:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11A222CBB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11A222CBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6039+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id asmfYY4521723x7RGVnJKrtf; Tue, 05 Jan 2021 09:12:49 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.93])
 by mx.groups.io with SMTP id smtpd.web10.100.1609866768736192361
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 09:12:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2x5aw+UeJJ6dIN5G77KJ3/1MizD/PGn9+Woo1SX+wdp9EB0PQXOURtenXd2YBmLMP0xMqIY0TJuQNab62CPUzLV/EBvCGT4DvdQ+r/6TIEdr9QN+fGxd39xvalzucmL6AcnleP+ZJzVRzU0fiKsGrAM4K3kANCOZ+gRnaq52bqM62cgxCI6QsMB0fohnq/VJPrCMt8y6i6y8PEHPtAKDWZd/9lGFuQDbejUMgumqLnrskTrPuQnfyFPSOZZfRdDTvvshy2VGwsVM+8cDbYwJ76uRTKv+vPPUXK5YHFV1j9xg8eZ/epvkY9woZbIzeh0IbfvGiek+PiIG+T4lcueRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VonX4y25T5WbQU35NkPVXPBCfph2hFhLpW6V5FHo3zM=;
 b=c1Yl/zF1KBIZJSOw86kdqAiXzdS255a5AzdGEAJ8s9PvGBL9w9Vgl+XIM5fMzxFp6UcfnuPRmNng9sxKCRM2cEY4GtVZjnKUuVEgJ5i8Clv80AN+K0A+ywoyOoPIco1vtkCU8v6gKZHx7XVG3mViD2tYVik1VY/xqK2EybZ5Ed31+NeMOJuSaaIFdt2yqjKxsUgh9AsfIRc1je0wxaxaYhrUsWRy79sZ7KRtQh82agQeDBIm4H6Yj/jNeFcucovFu/tBeyBLkwUoMWYxqEg02nmEdTDmCbgOmIli3bM9UvI2DSjZne5IrUtK2VsY7LBlRb1R3Ih4xmqDcdpLbPJbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB4869.jpnprd01.prod.outlook.com (2603:1096:604:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 17:12:45 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c%4]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 17:12:45 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 13/17] spi: spi-mem: Add a new API to support direct mapping
Thread-Topic: [PATCH v3 4.19.y-cip 13/17] spi: spi-mem: Add a new API to
 support direct mapping
Thread-Index: AQHW44PhWK1J/vn2FkWP60XIEFUDPqoZRDgA
Date: Tue, 5 Jan 2021 17:12:45 +0000
Message-ID: 
 <OSBPR01MB5048032241A2E4B18A5FA97BAAD10@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105165734.GD361@amd>
In-Reply-To: <20210105165734.GD361@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34bed123-bdba-44e3-8cb5-08d8b19d1ece
x-ms-traffictypediagnostic: OSBPR01MB4869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB4869EB0C9145DA725A1BFDC5AAD10@OSBPR01MB4869.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 EqoMR8JWemRLGu5Qq2Xf5imNGXtWJ46xlJD34faXYTCvH7ytGc4w1Wi8SfYroWkF5sLZJsMTn3bJ14AVVtzxA2U8d+8UaRwguihFN0kin5SglZrK+uvsXBkg34G+qy5t5mdAiFxSBzuVa/FvHFUgLJneTT1gVoTnLTKOAauQKIW81hrxHQQBZM2cRMSX2w7cnT/gNoAFjiZAJfeynjwUUgZ3Njm1MO6J0W3XndmjVuACjDum6ZYxk6duTq4R4ckyouxeGGhdYpFL+KYGj337sEguCM/YlPr61/HU0Ob83qM/kEDuMCztfVAZWWyxH03Zz1Ri3G1LzBEx6r1FhaVEa54jpS5yZhQ1TVZa2XeFz4cy1AbcW+aGq8SFpl5VCTfgwado8sXPGlgy4+eQRc/sBA==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?f4KWXbn/ygnYizV9jJoTjq7h+iQJ2abWkp6EIV5laGpQSuWtKTOQ6bcpNf1J?=
 =?us-ascii?Q?g1SCFHWavWv5+imTaH5CSv08hQmYxBU6ixRQ2npi0MvbyzisGqm4sXOpmQg7?=
 =?us-ascii?Q?zAC3nMQ8twL6dt7wHNA57zTlXxw5ypRKVEzYz0i7v8uUriI3cWS+zBhOAiq1?=
 =?us-ascii?Q?WLTQLpr1IDyKytl+3JvnQkttX4Kp6p29t98q6VeXnYeKa8TqsCxtDpzRjYfh?=
 =?us-ascii?Q?1ZXPQyMYycgaEajINh1k6poGSdo8RH8OohiPPZ7ojMDgH5wJt0Zpsy7asBJi?=
 =?us-ascii?Q?M2CnhR/dp9UvSpMBQFLB13AAVNpAZ3VIL0BW6OSohd7lBLuct4s64PVZAtkM?=
 =?us-ascii?Q?6klGgn5DP66xEXQa+VpPD8rh28ZfpyzvbyxuHHSuYAb0ZDttnUgKCD3sHpXj?=
 =?us-ascii?Q?d23a43dJGv1jc/1JjlOZi0MsbF9liyhkbpedoyISGxQ5zRYqgzaLztC6R+sk?=
 =?us-ascii?Q?1eS/4Ec3h4uaviJiGac7dmwW8Cx4UKvy7AidGd+UWEqFhnSyfOF60HYpFcXl?=
 =?us-ascii?Q?EHUd56CgbxVqZ/Kg664Ip7gE+o0Y9YfpecaRxvuD6f78pK6YV4tLVft/cu6Z?=
 =?us-ascii?Q?HIwFuj7KvxJewK7Td77r6eA5dsJPkqmKEf52BHrqs47f35wWQtOXPmfYD2f7?=
 =?us-ascii?Q?4M153wTnjnJGe8DBu2gdaqpMFQZ+1/s183i/ALJSf/sWUrOfjsVwUatCWLOy?=
 =?us-ascii?Q?Ve9FIVqCDg+gMWm4q2RkRuwVLZeKlLUqP9KxQc7fxDQLxqOP9eksmceE4D5I?=
 =?us-ascii?Q?DtUBVLvsw2Is0sETyF5vCuTKGXXpadV9Em//0mgvmNojyxJ6yVfm0SdPm74r?=
 =?us-ascii?Q?C9oD9dSP/zTFGrzJsQpfSQGSkmG3Qp4Wn3m3gEfIR8xc9plVeTeUHhI6G8RM?=
 =?us-ascii?Q?TcqRWShKZAu/g+DOj4jnvO8SPP0dK/DZjzuzuAtEWcdvp63RWdhFHZym+hPr?=
 =?us-ascii?Q?nxnkv68hBhb3tdcGw82iPSNVJHwYIdziL3H16wO0N/I=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bed123-bdba-44e3-8cb5-08d8b19d1ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 17:12:45.6910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfPmh5D55yB9VOA9aafkcQMGl8Qc2vU1qs+aq2dGNeYuLmjs9OqoS54Vn2PBbxV9+9zd9IGhqyi1WVhav5YHaMZ54unrW/8PM9pvCO8c/YOwJbtttAUUrnV3XFIBancG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4869
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ER7GzxgyL5fVDwGE2rjZo9ETx4520388AA=
Content-Type: multipart/mixed; boundary="dnFiiPCxwNNmLih7bXts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609866769;
 bh=RKaYZcbX3KQNLXdWbidKL2m9+vwu9fNXHqNdgNae0a4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=og/+uxGNCgoLvaxtsWUo1S5Z2rX3LO/wYV0XPTRmFPVAXzhzjnnkn6f0+XrtzRjuvhs
 jk2lVYikykFERwknqWCLKH7ZiXy4MEpItmCzPJnS/tyCKQ+y8ZAtpZdggmwVNLyaKPcfd
 qksVWg+MyWem9H9oNWJiZTbtOOkSw8CBIgg=

--dnFiiPCxwNNmLih7bXts
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 05 January 2021 16:58
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH v3 4.19.y-cip 13/17] spi: spi-mem: Add a new API to s=
upport direct mapping
>=20
> Hi!
>=20
> > From: Boris Brezillon <boris.brezillon@bootlin.com>
> >
> > commit aa167f3fed0c37e0e4c707d4331d827661f46644 upstream.
> >
> > Most modern SPI controllers can directly map a SPI memory (or a portion
> > of the SPI memory) in the CPU address space. Most of the time this
> > brings significant performance improvements as it automates the whole
> > process of sending SPI memory operations every time a new region is
> > accessed.
> >
> > This new API allows SPI memory drivers to create direct mappings and
> > then use them to access the memory instead of using spi_mem_exec_op().
>=20
> This can be refactored to remove if/else nesting.
>=20
Agreed.

> > +ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
> > +			    u64 offs, size_t len, void *buf)
> > +{
> > +	struct spi_controller *ctlr =3D desc->mem->spi->controller;
> > +	ssize_t ret;
> > +
> > +	if (desc->info.op_tmpl.data.dir !=3D SPI_MEM_DATA_IN)
> > +		return -EINVAL;
> > +
> > +	if (!len)
> > +		return 0;
> > +
> > +	if (desc->nodirmap) {
> > +		ret =3D spi_mem_no_dirmap_read(desc, offs, len, buf);
> > +	} else if (ctlr->mem_ops && ctlr->mem_ops->dirmap_read) {
> > +		ret =3D spi_mem_access_start(desc->mem);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret =3D ctlr->mem_ops->dirmap_read(desc, offs, len, buf);
> > +
> > +		spi_mem_access_end(desc->mem);
> > +	} else {
> > +		ret =3D -ENOTSUPP;
> > +	}
> > +
> > +	return ret;
> > +}
>=20
> This can be
>=20
>      if (desc->nodirmap)
>      	return spi_mem_no_dirmap_read(desc, offs, len, buf);
>      if (!(ctlr->mem_ops && ctlr->mem_ops->dirmap_read))
>      	return -ENOTSUPP;
>=20
>      ... normal case goes here...
>=20
> Same refactoring can be done for dirmap_write.
>=20
> Code works either way and is not too bad, so... up to you :-).
>=20
Agreed. Do you want me to do this as part of this patch or separate patch ?

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dnFiiPCxwNNmLih7bXts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6039): https://lists.cip-project.org/g/cip-dev/message=
/6039
Mute This Topic: https://lists.cip-project.org/mt/79450077/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dnFiiPCxwNNmLih7bXts--
