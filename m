Return-Path: <SRS0=MrTF=E5=lists.cip-project.org=bounce+64572+5835+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08C5C2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 23:08:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1116C20691
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 23:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OyMdVQzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1116C20691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5835+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iMfvYY4521723x5e5X55mUIM; Mon, 23 Nov 2020 15:08:55 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.91])
 by mx.groups.io with SMTP id smtpd.web09.44219.1606172934142295381
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 15:08:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY9wIh6WDxHt8YLKJqBoynQL36VlmVFDlWN2bKJxI9hUSmu1ycqEvfx6baKHIv/svPqfLCtdS8YO9iN5gcNVuQtvS8Ue3HnDTMDYYkh7M8RBKLuqJybxMKoYX+RJkCnU2C10ZhgPt69wo7r1bz9GOxUxVj8EAVVOZ3NSRVEeg3PJwqoMRjNmaPlc589XmedmtMv8zqeCwJyjize9FMNUCFidJwIt5jBPZmTUAnLjBHJIltA0aTdaY7DJU6MU98QzSwOpC+tj5frHHIa69SKp+t7qSBmEzNZwwhp/FR9P2UjEbJesckEGBQ81lhT+qzQ3jovkm8djyTiyJ22ZlXiZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4iYCC4SqR/ndYG6ItI04hE8SG724JOROIAlMyEIsi0=;
 b=bSMcHM1Q6Dwe2Y9KqtoLlJfHzyrgldTnDk5mOnk54vFLxrtEcZ1inTro1g0VVzX9Ci7NcL8pk3T6UChhZVEvTmdiBGiepHwwy0qonFpe+/r9+DIK1BYqaklJk8A+4f/UKkOu5EAtJC8E7FXhLUkLYPgu6LMBH2nd/PQusMpuQF8yVDYx+a3UwTqOi9GWckeRlConcW2iVu1lAgDBjfzweR7D00BLV1Nqrh20bZEuILl3UIVmXigUtDkuYFcBqBkoctVK1Iq5n6WPIES2hjh7CvKYvqP8RJRsWPUJxX0GWjKyav2aCFiGMqZgy7i0m27FcyhH92T705XJTn1AGmWEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSAPR01MB1905.jpnprd01.prod.outlook.com (2603:1096:603:15::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 23:08:49 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3589.025; Mon, 23 Nov 2020
 23:08:49 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 6/7] spi: spi-mem: Add a new API to support direct mapping
Thread-Topic: [PATCH 4.19.y-cip 6/7] spi: spi-mem: Add a new API to support
 direct mapping
Thread-Index: AQHWwdFYqUdDcGS40Uu9ou5BP6xR1qnWVsaw
Date: Mon, 23 Nov 2020 23:08:49 +0000
Message-ID: 
 <OSBPR01MB50488503FB81A06962ACEE04AAFC0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123194626.GD5619@amd>
In-Reply-To: <20201123194626.GD5619@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c2b32b9-297c-4af7-1d59-08d89004bce1
x-ms-traffictypediagnostic: OSAPR01MB1905:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB1905B4385EFA6DE54CA9162CAAFC0@OSAPR01MB1905.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 p7lZHxMz7T/eHq0PT99iaegKDBp9WurUbsbKLrNgDqznsEX1T4EfZTIDCoWbhEA7i3GaxWp2ymiYalFWJHZ+aAwf7VzMJiLGv2mOVHTK8WTJigzH27oi0NblCcHVLU0USS3U9ija9Uv2MJj/AGcQCoCRiyqHYsZQiKtIGI8vk3N2jE/tMfXNSD/WSslvJ0WYgRV5geQUvkETGOSX+lKW5ggoh97rdM344M7Vg33abTn6mPQyMTf/xXmIINdNL2Y26xlh8FcT8VZAYMAFADpxcdnitbLqfnyKwnLPVdsHvGEkwpdCLP8kmPuFkU1s2rb6HJTl4MVvCQwz3+fApNev/A==
x-ms-exchange-antispam-messagedata: 
 U4B2dmjwEuOOuCcN0zN2BFtxdC7xP70fZdN0F5LPs2WSGiuubGYdjd1XSjZKg5JO11pQyDD7dpm98iibt44w920apLoFsdrszs8u6bAxph7tu4Xpk8HHuigePNGuYhpWFQGxWk3RBKa1gg/yh+GUEv0QQxUuNqGDkm6GMlGfq9I6nbPuHRXnfbJy9f+bn98scBXQzkTY7E2CYg5tkLsrlKAeSNkqvMA3jpgxH1nGOCOkpt310nR1P8R9h8miVG1Nnz/WnB6q9XFgh6l5M3U7DBnO9iT1nfCqneQ4YPKqKeIFJDPVSUSeBAff1iBF1RbBsV72hqD0ELZqF1tePIpZMEvNPVpvbsa/8Z6+w9Q/iqit1J3Qs0kJYjw95pFLNnGis2oMUZZYAt+cwU+jLO0/i19YiE3a/GWNYOW291kw/YXS2musRCBFyx4XmrizQkH5/ZfcUoK3PUM+X1TFZDTedLpmHp+OLQdncB/iI8BkI04wHWD5B99tB+ZE3DsIxyFTszCJjMR4kIb2Fu7waExJDQ3wEU9a8pO0WSSW/EobfqSpT4omFKw3MVEhY8JxMBEkqNmhC4vGt3OeetASfVS38JavCMC73a0OJkx8RqU9bsL4CvXKEBnPem/2eH/uwyHy6yZgLu0/+8RzhKlmftJIwaFHuiz/3OenWZsxA7r0zpSjnoO6hv9VPlgLYjht7R7DzNvpgNNNgDQr4mbDAV19X/3YtjPhDum86xju4erdt7RaOmWYlNWpFt+YzVjidcJ8L+HjOXa3HM9qTosneXwbMg2c9WGwrvVfYCYvuBw+MAbHGwWBBrSgqZ+v2Kgk/3WqAdkq/7ezd0dfM8p3i6sG3EKiDrdDuVF3CwfaIkXszXPmkHLbkGI81ExU5s+8R5HC+CriZpJ+s2YgoGBzr1/DEw==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2b32b9-297c-4af7-1d59-08d89004bce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 23:08:49.4534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2DjPA82dKIKJkcp6xVh5twVgU6UNZO8uCAInQbpLsbxD4y0M1zwACH1xBhhqp7oWSHW+Hh3eDI9h8pSGdIm17TwUl3z/WCfPD/E7+FgHo2jmZOY9JGfg718DJLi9Hid
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1905
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wBnbekrL51ortA2mt7Dqqsw8x4520388AA=
Content-Type: multipart/mixed; boundary="zyiTMMrGilgf1odqXZld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606172935;
 bh=hdPMR3eE+qyk6uI4FCGX51oBrnn5r4hLxLySKCjJhps=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=OyMdVQzxa8uPjK9LdoO2gIqfVSruC0BXW5wAQLH3pzqsuA8Dl72ootSfi4A5+j/GzpO
 fFb76PgLIP+Gh0RfK80+n8RY7JoyPS3vCw8lnzavyvuohJtyuy2kHv9yYU25mQQKzBVmO
 WgjjrxEOg8hYAJNIiLnoUxtQbktOSvHdgrk=

--zyiTMMrGilgf1odqXZld
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 23 November 2020 19:46
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 6/7] spi: spi-mem: Add a new API to suppor=
t direct mapping
>=20
> Hi!
>=20
> > commit aa167f3fed0c37e0e4c707d4331d827661f46644 upstream.
> >
> > Most modern SPI controllers can directly map a SPI memory (or a portion
> > of the SPI memory) in the CPU address space. Most of the time this
> > brings significant performance improvements as it automates the whole
> > process of sending SPI memory operations every time a new region is
> > accessed.
> >
> > This new API allows SPI memory drivers to create direct mappings and
> > then use them to access the memory instead of using
> > spi_mem_exec_op().
>=20
> > + * Return: the amount of data read from the memory device or a negativ=
e error
> > + * code. Note that the returned size might be smaller than @len, and t=
he caller
> > + * is responsible for calling spi_mem_dirmap_read() again when that ha=
ppens.
> > + */
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
>=20
> I'd do return ... here.
>=20
Agreed.

> > +	} else if (ctlr->mem_ops && ctlr->mem_ops->dirmap_read) {
> > +		ret =3D spi_mem_access_start(desc->mem);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret =3D ctlr->mem_ops->dirmap_read(desc, offs, len, buf);
> > +
> > +		spi_mem_access_end(desc->mem);
>=20
> and here.
>=20
Ditto.

> > +	} else {
> > +		ret =3D -ENOTSUPP;
> > +	}
>=20
> To help with if/else nesting. spi_mem_dirmap_write could use same
> treatment.
>=20
Agreed will fix that and squash the changes in current patch and post it as=
 part of v2.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zyiTMMrGilgf1odqXZld
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5835): https://lists.cip-project.org/g/cip-dev/message=
/5835
Mute This Topic: https://lists.cip-project.org/mt/78451547/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zyiTMMrGilgf1odqXZld--
