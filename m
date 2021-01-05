Return-Path: <SRS0=loZ1=GI=lists.cip-project.org=bounce+64572+6040+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D08C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:14:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968B922CE3
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968B922CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6040+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7q4MYY4521723x7N6PreBlbz; Tue, 05 Jan 2021 09:14:53 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.102])
 by mx.groups.io with SMTP id smtpd.web09.154.1609866892438277122
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 09:14:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1pIR3NDSnZsADQhkXmUMfg3cREoveTJd6t8ITzrRIlaR50/cNYpgvlFPQgo0FDJv7fqY/zrAJNICSh4EobQ3lKmC5eKEMoHGaGQck7i/FcFkwbGlZeYqk7IP6feD4CUUnrnbs6yg/WD7nc4OkNUoi4vLmv525PyJMdj2MlSmUdgwTf0tI58GMTNGWO6k5o4skxy52DdKFO6I9Ne+QZzQTtdNvQUCfJ7dryXTTXK4O6ZWjD1ODhJW+2QmwL5j+nXVPlBC+kXTZHRjlPZJpmBygWZGw9FFo5XS2pBOB89UoaeSPoS777LbeyM/9262zivcXmVs2kfv76s3fzCak9swA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33qF0RYtwqrmhH0Q9qlwV2gbos7qH6+DC3pCjE7jfn8=;
 b=ANxb/3Gs8F0IpJ77tnSB+11oBc6RVath9vQ+KhvmMNZvxkC7NeTTp5ufN4Jboy9Q/n8d/LguH5H2bAoW+NB/2I7TILSgPPVrxxorJ6KbryEd8cpQDuLnptqtouyCzIDjS2XyLBI0eMfppOltBDqE4ZxPc0TjQxTHRV14dbiNSOudQyvPSmcERPU6XXTinzCH0E8JY3f2+Na75PqMFKSo3REQngNarwQWCedc3qm83IjQscHCR6dm67/p+pEXObMNQmU07+umLon1AYWVeukeB4vkCW90+wHoAOoSVRcGMo+AEEXIKu3BUwZ5NuIxn+MPWNBV7Kwr7JbkeyEaodPWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB5224.jpnprd01.prod.outlook.com (2603:1096:604:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Tue, 5 Jan
 2021 17:14:49 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c%4]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 17:14:49 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 16/17] spi: add Renesas RPC-IF driver
Thread-Topic: [cip-dev] [PATCH v3 4.19.y-cip 16/17] spi: add Renesas RPC-IF
 driver
Thread-Index: AQHW44QE3u9nJqN+vUmBxSTOJuMnZ6oZRQLA
Date: Tue, 5 Jan 2021 17:14:49 +0000
Message-ID: 
 <OSBPR01MB50484F8DB372D0005DE09E1BAAD10@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105165841.GE361@amd>
In-Reply-To: <20210105165841.GE361@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c487ab01-e502-4664-5898-08d8b19d687c
x-ms-traffictypediagnostic: OSBPR01MB5224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB5224160766C44927C72BF4C9AAD10@OSBPR01MB5224.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 iVdiUL4LyJIzsT0Hfl3COpNKyCM4gTl9D1kI7xcG7g8sOZ2gsexkQ/MpXkmeQjbNRFl4AHpq01Gg3+TrWvJJ33dUnF3lQHDjqr+CJfNxAjGwshuaPRLIJ9xQZKffFi3LqH4UtC574jEwmfTaPliBNwuE+gJ1De8ji5ypm35kzwUW9XLGTkJi4bZXGeQS0esJBpzgzyu1UT+kreR7YEOPFeFwYgMy10q1YAe46GRfLaV3xzYis9wAmb/JBiB0ESdmq027uuXMVZhcwNFPewIu/3IFaqvQUnMnMDX32G1B4PVOLBCzwKHKKlTFv+7Xv/gAMGOLGH/50su+wIYtJs26qf//q1pSP3cZ4rsTJwVpZlrBIY/qyq1fa60Dl/zfIFNYRA76DS1EHZFH3ulv5e4rBw==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?l8hVRKPmowUrgFsOzmx46688G1XxwIhVGKxhk4NFmL1iiWnNaZ2TGx/oAKOR?=
 =?us-ascii?Q?GhrR+HBE9FvHa7Kkgtxjkmrn5Mk1eSPE9Lo/TEPhVofxHFwDXmnXramOnzCl?=
 =?us-ascii?Q?nWRi9UMuY5vzBvauH3GiS7ziEB1/LGPWdWup4yoL1jDUqC0gC05Yef3zul52?=
 =?us-ascii?Q?sHCrVYgSUSl5VhI4Z/Gk7Yi12jPhim6rC8OWScgQRCrXfLzJPI05IMxl8skL?=
 =?us-ascii?Q?tLQbnIlWuv7n3FTfFm1CgOYxt6rv3bvaW6zaegv8mLbHVQANvUZPTsjSwfYh?=
 =?us-ascii?Q?TzwUyJ0RM+RR5Nn5zAHXPbwmIRtn4sYQAzz7CisH5GSDHhuRcYKU1biMOzNx?=
 =?us-ascii?Q?3m81Z+KH6SOOdN20w21looCg36NMcWLLYUzKacXLLIj6+Qn9/swRFgyh8CCV?=
 =?us-ascii?Q?GVzN7acHNb9CY2xfTT1/lmC1+MOBrx1Fdf3+ZoTdK4y2DzgxpC22GojN7H6m?=
 =?us-ascii?Q?YswcjDzJ8UrXJfuK5DcmvZ0KA9btt/Njt/0vPUTztNtoBiXzUDl+3PU2dN0w?=
 =?us-ascii?Q?+4DJL/mEg9nXbvWkp7+CBggPTCpz47JKMkTX/dXiU4xBertvycKbGXZYxpPt?=
 =?us-ascii?Q?2Ck5nCSzhBNmKDjz77ZnDKyHG2x13fMjRcvqCnD9/qxIBdwcLk6/BnuAVq2L?=
 =?us-ascii?Q?KHDh/QtYhDyKYeTxg0HBhvD8wTBOxLjguvE+qmnd9uK7bkxJbxT1X7cp35Gr?=
 =?us-ascii?Q?kXeG/I04TUzXBDSdzTvInZiSIc+PL2bgpJrbBZBUSm+pl8vzXqE9e6aIdZut?=
 =?us-ascii?Q?cHDWN/atDyFy5Ua8VkTK4Y7IyI9ZqFR7kvHywxVK7/uu18JTq8d7kwfmQ2El?=
 =?us-ascii?Q?Y4+UMApDWmeH2UMRuQVS9bRfdvaDPfH/C3uZvynb4ML6YqZ1q5VJaKuz/sMg?=
 =?us-ascii?Q?FNROnfzFJyPDzSTX6I5MruCFtuvpkBc/tGjv1WKkM7XHxRbdQcH4YwHhS3QZ?=
 =?us-ascii?Q?d+nACh9ZjyFioLPaqvpqVDhuAyCoXGUH8zejkJI6Yos=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c487ab01-e502-4664-5898-08d8b19d687c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 17:14:49.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYW+WqRC5lPLriCKC4GMKgYxZCKy/lIP9TTZvQn2NqnxfxQ8qx1OBd6aGRR8YB2HuDsXk5a8hksjSpXFwKZ+ZniuAT0xqCvXXnm7lCJ8K7lnWcV3nrzYchp2jLjhu/wG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5224
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 93ydC9cdgDdRXymUhhrjpf3Hx4520388AA=
Content-Type: multipart/mixed; boundary="4QKDXOFM4FKBwUIS84Cw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609866893;
 bh=hf3pk5SmIo1SrBvMeGEKxTjpmY/ZSVaYOUkewBZ//HQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=A7bMdmIwwu7DBg0BjMz44fwYc77ZJm+zxihKVgb8PrWFrOrqiCnwgRTwKaGKRrVNXk5
 wdZdHtZo7m/JKTW9y1GnMNgm9h6ErCtr9W3BrwaclWIzXcTpTyY1cr+V/xtxFbFuh+YQ/
 wi/4VeBsdOVOVVrHqZ9wNcflplvl5v7hOxw=

--4QKDXOFM4FKBwUIS84Cw
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for review.

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via
> lists.cip-project.org
> Sent: 05 January 2021 16:59
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 16/17] spi: add Renesas RPC-I=
F driver
>=20
> Hi!
>=20
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int rpcif_spi_suspend(struct device *dev)
> > +{
> > +	struct spi_controller *ctlr =3D dev_get_drvdata(dev);
> > +
> > +	return spi_controller_suspend(ctlr);
> > +}
> > +
> > +static int rpcif_spi_resume(struct device *dev)
> > +{
> > +	struct spi_controller *ctlr =3D dev_get_drvdata(dev);
> > +
> > +	return spi_controller_resume(ctlr);
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_sp=
i_resume);
> > +#define DEV_PM_OPS	(&rpcif_spi_pm_ops)
> > +#else
> > +#define DEV_PM_OPS	NULL
> > +#endif
> > +
> > +static struct platform_driver rpcif_spi_driver =3D {
> > +	.probe	=3D rpcif_spi_probe,
> > +	.remove	=3D rpcif_spi_remove,
> > +	.driver =3D {
> > +		.name	=3D "rpc-if-spi",
> > +		.pm	=3D DEV_PM_OPS,
> > +	},
> > +};
>=20
> #ifdefs here could be reduced...
>=20
Agreed will do this change once we get the ifdef dropped in upstream.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4QKDXOFM4FKBwUIS84Cw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6040): https://lists.cip-project.org/g/cip-dev/message=
/6040
Mute This Topic: https://lists.cip-project.org/mt/79450083/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4QKDXOFM4FKBwUIS84Cw--
