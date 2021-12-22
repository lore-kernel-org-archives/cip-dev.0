Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E668C433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 10:55:01 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.131])
 by mx.groups.io with SMTP id smtpd.web11.17807.1640170498764850170
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 02:55:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=fniuQnqg;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.131,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMjC1cM14bpjnxs2zEJGk1Y/ErjGmN+n4HJtMIUx7W0wU/8hCM15kDu/xpYs09fhyCcI9/UD4+jac0hYo3DWP0DDBwoTJlY9ZMmcUt4W39K/Hava8vV8+uM4cn+jRGuKEEp+IQWvJ7YbPr7/NrT41ZGHmUDf32eCSh8UWLZ9hsJ4et3gfAJAJYgahd5O0Z/G9DiDuOMhlD9RVGtfthJpgjq8Ew9A+EAYBDLs11QhiI3djggrkYyfCg5lRuvLWAVgU9+zw2byu+57ufsOGIdwTcKo4BCFjMqGMtf1yVFseAKNtDNI/qxxU2ZPekkYgwXdCHAHY/EOm9edBpQGXbMXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlqMiazxt8QFuoO52gro4VMd4cVoeIWcf3rnm+oBn6g=;
 b=Mgizr8aLV8Y7Kbz8IUHs/jRHOXktrqIhKLriUtqB34LwSCSoFJLWDwSBMlmubws9HowI/7X5C7Afz73gqsWPXFK5SwB4Q8D7fToPKYu3t26NMPA4L8qWZlv8TfG4aFsspSa6NmGiW7dy2xCJx7UoHO/lxgUF0Q4uIEktKGZWi3MQNzkTMNc6zHEejxkizhPqj1wes7eyrPywqIXkMOTAusOuIcT9QuaQIJx7xeJFmFiwoHx7ch+kbQ9zSUmjDYnN5VASyl64xYyQPYAFIL4A5ZaVZErnnQV07EDn1O0N54gqxyk1WMzxi+JAPfy4hkxA5U8ZWiUA4giNfa6ljZjWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlqMiazxt8QFuoO52gro4VMd4cVoeIWcf3rnm+oBn6g=;
 b=fniuQnqgxP0nwzy75NzaPQ958wqQkfyaASwUOI9NwO3/vke6RviHHaUcWA48I5gJ1QMCF5r3GkamHohSCDiTfVBJGPFRdjW52awdXYuPc49um72rELVJIj9VeMfaSCZDae5abRbTcxLIJArvQXodDZPDQYUsZGrmeTrM71/3wGk=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS0PR01MB6164.jpnprd01.prod.outlook.com (2603:1096:604:c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Wed, 22 Dec
 2021 10:54:54 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4823.018; Wed, 22 Dec 2021
 10:54:54 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 04/22] pinctrl: renesas: Add RZ/G2L pin and
 gpio controller driver
Thread-Topic: [PATCH 5.10.y-cip 04/22] pinctrl: renesas: Add RZ/G2L pin and
 gpio controller driver
Thread-Index: AQHX9xkQf2H8GRALrkqibZCQ3OrLi6w+VeDg
Date: Wed, 22 Dec 2021 10:54:54 +0000
Message-ID: 
 <OSZPR01MB701945B90F24B86F0659F25CAA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211220133139.21624-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222094820.GC15186@amd>
In-Reply-To: <20211222094820.GC15186@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98470264-ece6-458b-9c53-08d9c5397cf4
x-ms-traffictypediagnostic: OS0PR01MB6164:EE_
x-microsoft-antispam-prvs: 
 <OS0PR01MB6164DD73E9CB3654CAEBD2BCAA7D9@OS0PR01MB6164.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kjTnHDM7U32WOhBIu2ppU4wIhR/9sLzJcJu210q1Zz2zMmhuWLNnIrfQjr0dqdyW5r5X+jYZoR7/HF2ER8E4qkXKtmaIDZlOEvPy0Pv0eb7COXZqiu7SVpFavy4z45+PbNNDQyEabXB2obeh3hQ1b1qyQ8pcW8iiLmLkzlLVwRYQK3ytqUL3lUY8fPD0lmVeLRuBYVMW4oiWwFSJ1Uvixng/7fgYbple1BLkEFWJkPlezFmPYEiMoPJI7BqPUYl3JVl1cnDLINBsenrMMrJFjN5WXB68FFB4NypaefHz0HuxJfmmKjQCJZI4pjBTLE5THNvVjWJ5l1yirYPJv0Sspxmj58GrAsT8PXDN3JNZ3K3NcEZN9AglPfMNBD7r7GZ3OEcWFzJ9G0CCoLxv7CCFDNkdiAlPfi7KTyoli825QVsrijiVQ6+EthO/WCTtpqZCk7HXbRnPg4nE3O39S5N2WL0ibdmm+eiPaNEp/eEDJiAXjlJzmh2EkutXSsypeMYQ3hxa729ScjjclhLHIMTlxt2PoIRHFTg2NIxVnD5zWCKSESNIZote2+3K/lu8j+3C2VppL6YgKV7C+0kqXsGsnEwrt5NXfFwq4b/m3csDS1CPNwivK8AzboTeFCk4sv+vYhXS0pBVfy7iHiye6hIuZm1E9svSaKKqA6ADM/2eOVjA/sDOnP7qlbrTfhOe9JvldWNnFR1fNAQdy3WlMungGg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(122000001)(76116006)(2906002)(38100700002)(71200400001)(9686003)(83380400001)(7696005)(26005)(4744005)(186003)(86362001)(66446008)(38070700005)(316002)(54906003)(6506007)(33656002)(55016003)(4326008)(6916009)(508600001)(66946007)(8676002)(107886003)(52536014)(66556008)(8936002)(53546011)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7zqnRZoaOkVfbvCtZNz97E+CxddJ2gkKFsYaZUMJ7zUBJgbGx4QPpjRV2+ng?=
 =?us-ascii?Q?XyELLjukNEjET2ml50HAoRs6UZoGvUvksjCnD74m1mYvzQZXWjxyqmm7Ke9D?=
 =?us-ascii?Q?KBkwzKywasx4UUfM6XqOgCUK+BD51wQU+/zOqwYZIMyEWNh8FV5l9AvTu8Ha?=
 =?us-ascii?Q?1+xkbmkn9fh+ZcegeK8pf4BqV1vzp2Nntg2QhzQBhjILtitykX9p/IGLZfOV?=
 =?us-ascii?Q?iAGiT8sbvb4Z6JI3rT1sQqIPj4QuRXMkY84ofjkmIpDimgmILWBuChPTwWcj?=
 =?us-ascii?Q?TzeY2KpcARXYtpMZSrH3AM47DMmoZkwjJLUy4wg3aTUtxnuJskoRmRw+/i9G?=
 =?us-ascii?Q?L88+HeFzRO2iLumP3xC92TUlN2D+rcmlp43uzWF6vOEcBYoYi2HvI39rs9Hj?=
 =?us-ascii?Q?ndWL3tRKiIwk+8VNTd1ipZFdFh+hti4QBPkm0SVGfyRL7aNSA3/WlPXr9HqN?=
 =?us-ascii?Q?6b04DDjFLcbuHiUYHz+LfPBKWznccHtFOdZb1MvK0ia/1c9AyXS1SgqLntma?=
 =?us-ascii?Q?M5Mjy91OV9BOSkMQ/QJbA1+Av0OngbFGv+Tb8KMZPChUaeReMU6H4YA4atzX?=
 =?us-ascii?Q?tAti7/TFK+F6oFvl0LIbpGA6CjH7DDOzCcEcBafP5u/miqKRMCDbn1cb/kuA?=
 =?us-ascii?Q?+KzTWqZA2tQdACyq0gQCuuOJ1G3u6k0b8360YWohlNYpW+9PdUu+R3Jpik07?=
 =?us-ascii?Q?KvYvApk8KaweSKierVszpZVCDnnK2iFTU44CelJLcacqWNCLWSqCbwPmhQLb?=
 =?us-ascii?Q?HKp0dKZ1jvNtjJYBrcqz6996J18JmeOBpUmRqFeLoEVFDyprj0wI9aUpmrY3?=
 =?us-ascii?Q?P699hOFkRvqat3a0gRmIcqqkafdRDSTxwLgWu0rRW10UFP+17QtlaSaYz18W?=
 =?us-ascii?Q?vGFaXpaeMyL0XfRlSw3Vj/Uig6T/BsMpiKaa4HYU5svxIYdjCCX5CIN3Rkk9?=
 =?us-ascii?Q?NJvkMXYnrTxq8IY5aLbNA7CpeDiV/ud9y2m7T9NzM/swKx80oWf/Rc6r4pqc?=
 =?us-ascii?Q?tu6zvYAbn1dOWxEsq3h93eqd20kKndO3u8QpVSLssZUdBOIFn6R6s3POpdFI?=
 =?us-ascii?Q?rWCjyqHS1On+9+hjsY/dJLItP2Z/xqr7ReYRruEtAXbzKJZKUDzSMwWd5E+S?=
 =?us-ascii?Q?4m8kTgM8NquIJEfeDeU2OiAVmhoq5a+rOkOPhILLKUrPS+OnW1LOFKMIYnIK?=
 =?us-ascii?Q?KRLdEgbPzVXHBvATNtaT8kwt0MXJ5Z3lX9XEFrOY61mK95FV2QeltB2JFcJj?=
 =?us-ascii?Q?vQwtFtUscUIxqUk7IgycJVO9iCBnEJ4GrwZM05u/2+ilVfGiNGknXazkmReP?=
 =?us-ascii?Q?FrRu9V2xZeE3naP+d2Ckfz9NLDkR+mb3JZAgFc73x3GHm3TyW/CsK8OS7EWT?=
 =?us-ascii?Q?uvJM9my8mLKTO7v9cB/B6xGmsB28aTJYUHCuq/ExuRHc7RKVwnUfQPNhDgqQ?=
 =?us-ascii?Q?tfEA56iKLnHIJoks0xTU5j9Smc7n0CzeO29vT55pkkoJ096gQyO4QHRuEGj+?=
 =?us-ascii?Q?5zG4y4zjbP7DnpY2vDwvjA1uiWaEbwG9Z+UA9bLco7UtOttl3ep4VFC2XkwQ?=
 =?us-ascii?Q?SutWi7/IfOYN8hwhCN4QV1n/WfW5uZ61ul7Ys1IrxYg38Dp9QlXl/sexJOZt?=
 =?us-ascii?Q?21AalYCDxh8H1wAaKe7JLDV3V6/ihm4o/t+nm7gOyxrBWp0bqDFMR+qW3Tsi?=
 =?us-ascii?Q?gOAviEwOX3+NJK0X/G4ys6wRU3rRvgrYH9J2fcqq3Sqj+9ExzvCpgV0KVasJ?=
 =?us-ascii?Q?lzY72rMoJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 98470264-ece6-458b-9c53-08d9c5397cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 10:54:54.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 i53e+xy18W0n8BXwUD7O14tOb7ZiEeSw0jd0/zECrAaXPBXvnytKcrQF/IDjG1GjVjnmVk8WILWUuObLegasgiiNEnWcpT4fPdeY3LJP/rShat4lpinFooDl4vIcALmO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6164
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 10:55:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7232

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 22 December 2021 09:48
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 04/22] pinctrl: renesas: Add RZ/G2L pin an=
d gpio controller driver
>=20
> Hi!
>=20
> > Add support for pin and gpio controller driver for RZ/G2L SoC.
> >
> > Based on a patch in the BSP by Hien Huynh <hien.huynh.px@renesas.com>.
>=20
> > +static int rzg2l_map_add_config(struct pinctrl_map *map,
> > +				const char *group_or_pin,
> > +				enum pinctrl_map_type type,
> > +				unsigned long *configs,
> > +				unsigned int num_configs)
> > +{
> > +	unsigned long *cfgs;
> > +
> > +	cfgs =3D kmemdup(configs, num_configs * sizeof(*cfgs),
> > +		       GFP_KERNEL);
>=20
> Should we check for overflows here, too?
>=20
num_configs should take care while accessing the cfg.

Cheers,
Prabhakar

