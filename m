Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B3C64E66
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:47 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.92])
 by mx.groups.io with SMTP id smtpd.web10.3530.1648841234856147249
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:27:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=tge5QDF+;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.92,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T++eh/v7KhHAdUqgZ6RYDtEfmhBU6DJ08M23cIIlpYJKJO/UZ7kiassr2BsUD6F3pJ9C7whqxzGIbIokturM9Mf1DuLyErK2nrPJUx1QfriRJrfElumfg4uoYYLA9+nic3xXFQz53atDpL4Zy3IIMibGYjIPkhwoi1wflPRcpc8DoLuAvR7y0NhY7DtMK8Yq0I5obQuUuvNb5ntnjQja+OJpn3ZmB3NdMcDvd7jOUX0TBDrLxBtvUbw4NiAZhI6Q52yLazcQYotrZ6m84c+A4rbHJpgi2vDMkMk0m2irmTIG8Mr9+yqi++h0IpZ4AqkeZLX/Ek5B7Ra0Hui/EY8gyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOIwn0mgRWsLAvTPrRMGx+87fS3RYDiMpyKRBKSLk2s=;
 b=g/pE/OokzdYP9/35+uep4gSlrahZk4QHOYRYyy4gaX8godzwuhQggU3k0eyJV51PFaktC4/SIknpmk2+kn7O7mHMg7aGOPOi0Y+LV0ePPVIy06KJrCR9jg4hKUo6SoEFnBCwyiDceUnpbU7WImoDzbDDrFe17zGbhSKnh8iik0J6uNR9gVvRQCKE9+zUAJPY2nMDZopmNJ6gUR4gLG5f4hL+SKwfW9IPd/uHpZh+LGQHa7J7rBRbW6GHwOdEZoltVCwrFgXFUQrzqrQsvUI+uOosaz+x0hvUb+J7uGsINv2JgalXA5AsC1HhAUNI2iKs6XVLdrwLcQ6efhIKBFQSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOIwn0mgRWsLAvTPrRMGx+87fS3RYDiMpyKRBKSLk2s=;
 b=tge5QDF+VqUcORjTY/P58LTfy6bybmMyfhOCPE79JsnN86ebXVI/o6CKMj/wRMMbHjlRaV8N/hudtssO2rV58wqWOrGPhM2W9ZSpVtwRgBnPEkgeo+zTPWK1U8zGP3W6qDMTFqSwWSpJyLYFcN1IgToKs1AC+dc+HkHsTI4Bq8I=
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com (2603:1096:400:dc::9)
 by TYAPR01MB5040.jpnprd01.prod.outlook.com (2603:1096:404:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 19:27:11 +0000
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::9ad:c691:48a0:e92]) by TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::9ad:c691:48a0:e92%9]) with mapi id 15.20.5123.028; Fri, 1 Apr 2022
 19:27:11 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 15/39] mmc: renesas_sdhi: Add a condition of
 cmd/data timeout for retune
Thread-Topic: [PATCH 5.10.y-cip 15/39] mmc: renesas_sdhi: Add a condition of
 cmd/data timeout for retune
Thread-Index: AQHYROivIr8Thlyog06EzHso4Icx96zbcvAw
Date: Fri, 1 Apr 2022 19:27:11 +0000
Message-ID: 
 <TYYPR01MB7024CAF4BE277ECDFCB8E7B6AAE09@TYYPR01MB7024.jpnprd01.prod.outlook.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220331101831.GD21513@amd>
In-Reply-To: <20220331101831.GD21513@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d85cc79-b78c-4e71-11b2-08da14159ea1
x-ms-traffictypediagnostic: TYAPR01MB5040:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB5040C4B20E2C74FF983D5B35AAE09@TYAPR01MB5040.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +wM7L4N1DBl+xOq2Y4vt0kfLiYK7M8X7quYhTNFV9kqGbpX/840gMEffBTUeeZUMalEeqACqKMSdkWMVsYEUdIvaDKKj+ojmZCwQsjF6LUIr+UD1l6PqG7nGLhI4r+PM5qlwQ9uE91iVSLTrsOoDuLF/LX7AMc631GIaANA68t6/sC49Pe3AyUMiLlOwMFQNkQVALsLz27bPWjn/nBn/CT44I+CmNyGt8+GIkgevfB9NDLlZJzD3/CnvjwlIaeJ33VbN7XlByqxJCGBq/9xZ4Y6DOo18qpeAz8EveKrMOx/p+caMJFONUW/rQfwwvy6UH+bRrZ/W+Uf0f/mHLKclX1jtl8s84EBnwGEU57keZzfWRP6LCr3T1COSO//A5DB+gVy+wVDyaeGf1RlY26EtCIBrtxmukWgvtjxVzyKo9CN1ZdqmToNe08wxsRoBRvGGZCS2TKuYbChPD4PrtPiqZgleu4dxYXKpKRRRohffccPpwg7s3ax2NNPro4eG5qQslx/ay/wG5LifLsFc9vlKdutZI3Ji909tYUAIOb750qEiF1quD4QSM2BIlZughDAm1FwjEnWqWr1UXg+Ui01aSaPi89iqISYZvqcwyJ91L6lXgphmund6e0ABnVAgGLSQxYPSZ2mZ8zpKvcRr37LcmwDubcWN7EQld1f+12Sq6liKzOSGxmRtnyaqjJv6Bkq8id73hbS1/B+AECu6FhPKMQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(66556008)(66476007)(66946007)(66446008)(76116006)(52536014)(6916009)(316002)(54906003)(55016003)(2906002)(53546011)(7696005)(9686003)(508600001)(8676002)(4326008)(64756008)(6506007)(71200400001)(33656002)(38070700005)(186003)(26005)(107886003)(83380400001)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tLhIAwlvmi8MF7CH2M904dfRJvL5i+zr85Q/bAESy3eNeYej2w/xtHUGVx21?=
 =?us-ascii?Q?KEALiCp9UO4wsQ6pei7asYg1uF0sSMr8CIp0ohJHxo9S3JfCphDUozwg78DJ?=
 =?us-ascii?Q?FNGDARtAC/GI0EC1EdU9VXJ90SQWB2fubZ5ogONF574yi6K3bFMJKwBNEV1I?=
 =?us-ascii?Q?LCN8IzrEJZDAjT9LWp31caBEVyBfh4iCTQmPdc9LUO1GMAnK6Tx573cEZ2bn?=
 =?us-ascii?Q?aPC6ISQ1gsR/QL4mXnATBTIvAB5U0Nx4oDr+X/puG+3EEtTD9BoGxo+FQPO/?=
 =?us-ascii?Q?a5CFMXL1UVyadFnj8FLKtGaqrd4skYETY4EqqPpU87/Lmo14oyhg47r7zgSr?=
 =?us-ascii?Q?L7pYzhtCQHRIuSLkRYeVV/HKHfJF2TkvjGD3AIFdKFnUuqfjREGc+RtCUuyd?=
 =?us-ascii?Q?UnLW+Cq1feEVo5wJblyoFkQotBWyGkNrf82FVFRd+o7GIH6V1xptqmKIO8Ul?=
 =?us-ascii?Q?Efca8Ht/ioB0j5OhVkpx9g8Y20OhctISXgE321vVEeGX1sHXCbhGR04WUP/C?=
 =?us-ascii?Q?5L9Li8N2yBCX3HptNWXcoZZwGOV0PTwfZ3k4ISTH67NX1pQiDytAwsuHxas5?=
 =?us-ascii?Q?h/WFy7Gi2yInvPOjKLFeXPXsGuxQWLoRFGDzCy1QRf4ARAV5sn01BNntSYhT?=
 =?us-ascii?Q?6B0FcIH916dbVBoSdYl6qKhpArX36fWL9iWpKVRpsVIOMOv4/X/MRpi6MAwB?=
 =?us-ascii?Q?0m06VDNm04YDczzAY5huhs0s7C9hnmtd7GPw8Muqw+7/MAj+K0hnJsKfRIyq?=
 =?us-ascii?Q?nOInz/COu4cgwhWz+sxlyzRSwy4woE05trGXD4Q3NnZifCwcS0rQk2p78GK2?=
 =?us-ascii?Q?uReZay52RSo+rKYueicBN5AbqRR9Gs6cyj5kLgXG2NcuPfesO32gJ6yrmhd4?=
 =?us-ascii?Q?ncopDU9yujwWZAHSA2yUNF6FsXMIsRDtckeZkgwP7h2Th4PLnLbXLlcKI00h?=
 =?us-ascii?Q?VS5LRoNAPgsPiTBN6JfiG7ogbN2M4Mfs+J2P6nFiLJUZjRHh0OnXQqVxJkbB?=
 =?us-ascii?Q?3GrnTCnRUcn0BX3MhPVsBQN/5odJh8I6dVe9QDxtOp8CAphxNua17vB6bFWI?=
 =?us-ascii?Q?ChzLTAp2f/wmaiBo/qoh/xJCzUj3QKm4ZbUgWtfcXDoTnqELkUYeMlLSS3sH?=
 =?us-ascii?Q?I7vjotwlnsoimgBDOWwiiqbAUXPeYd4uHQz27KTsE1l0mqmp4yJ45zGiGTag?=
 =?us-ascii?Q?sv116k+1Zmutt7snWZzsUZDl8h7Utn816QQ3uTRSQSQ6jKpmFjYlAK4KFpAO?=
 =?us-ascii?Q?BHOIgYwCAmD6O4N1Wa3hlyKddRz9gXVcJJ/oLXSgyjW8k7+EAKzqCx0p+NO0?=
 =?us-ascii?Q?fWt/rDxfJ8oBAVBFXnhQilfWMziFAp0dvgAArIDbBhbs5201a0NHAhaQLbNS?=
 =?us-ascii?Q?ae1VvgEzvEPV3XLDvSydt0sThHi/Vt1OAChK8kDgx3iIlIMG6ybV3lqn89G0?=
 =?us-ascii?Q?WQd5vDOb+8A454PB2yr+OvzLspuHqTc+uiFSClMK6r/NV1V0MJuPSU8o3lyJ?=
 =?us-ascii?Q?5f5n5k57yCQ96caybVVPl6IwZ9RG0CuOLZbMSaf3dfFebkt0AVLv36EzJCxy?=
 =?us-ascii?Q?lpfOcCbgT9sRKu077kE0jE9Ub2knpvF5ARRxjwHikS1F9zLf7x+6P2Z0siRZ?=
 =?us-ascii?Q?/7sUoBqlIYKPRmy+Jlh6FTY90U/9QiGzG74p/dI7kv6gji5+dPPeofL4rehe?=
 =?us-ascii?Q?v8mT921ZNUxYTTar8pNMMYNaQ7nW9wkehHGgjcMY79aG3HjnJ3Qb9Uohnnzj?=
 =?us-ascii?Q?axcZpLPTcVnJKR4o068FZdNoa7rS8rc3sANs4cKm9Z5ShqP+IMYr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9d85cc79-b78c-4e71-11b2-08da14159ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 19:27:11.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 vmsGChYigrb9o3fAn5zoe8lvmlTk24OG5AKPvUkJXqJ6qD98VTiE6/cY6A9IwLRxH/VapcUin2+Fa9AV3HbIE7G/Ep/IPNTh0MPafWrsaAl6j1Nx91oI04ot3WUkn8T5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5040
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7907

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 31 March 2022 11:19
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 15/39] mmc: renesas_sdhi: Add a condition
> of cmd/data timeout for retune
>=20
> Hi!
>=20
> > commit ed2fab9a8229cc70fe03032e48d0ec375df6013e upstream.
> >
> > According to the datasheet, this controller needs retune when cmd or
> > data timeout happens. So, add a condition into .check_retune().
>=20
> > @@ -790,11 +792,19 @@ static bool renesas_sdhi_check_scc_error(struct
> tmio_mmc_host *host)
> >  	if (mmc_doing_tune(host->mmc))
> >  		return false;
> >
> > +	if (((mrq->cmd->error =3D=3D -ETIMEDOUT) ||
> > +	     (mrq->data && mrq->data->error =3D=3D -ETIMEDOUT)) &&
> > +	    ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
> > +	     (host->ops.get_cd && host->ops.get_cd(host->mmc))))
> > +		ret |=3D true;
>=20
> I'd preffer simple "ret =3D true" here.
>=20
Agreed.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

