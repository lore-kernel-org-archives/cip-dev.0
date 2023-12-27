Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F6C46CD4
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 15:40:11 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.127])
 by mx.groups.io with SMTP id smtpd.web11.103474.1703691608157379063
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Dec 2023 07:40:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=CVcl2Oob;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.127, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8C9iY0F0BeAwZQxg+ohTuePsGzyoKcNRRn30YQA/DwWm9pxvfUAZXI7Fi5ZSMSeUdzrmHxJDA7l2DAfJ3tGAbQQUx6MsLkYm+OkyXxAXt9CF56e9aDwLFceWX+ICsqhpN9GNliXCjVADgv0gATb95sMRe/E3taAgcX0ssDA8YAwVlPqzKSrQMwYpI2qlkRiA0F/VJi90FJsVDZD+NVZxpqEUifmua4wldnYyuVYmQDtJHRbtjzCdRlT319zazaRzvk/paB+JA2tO8WbfTK/+d3oaqyZ2A9YOsTykKxV9GIwhXHf/cAVy9SLaogrDdKk7M/afL/MDsv2H62DSNAlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1Vtt81NjcNtLYwxW76Dab0tuVvQNdinvjFp1J2NonI=;
 b=jAjpMD2U5Ou+40BOYcjLKD7dlNfXhGNlQD70mqVgO5pCLAKoLIyBZes7AiqAhb2ESUxLxSkTdBpjoS3MRbtTnG61Fy9K9Dcb3msTrUt6x/ZVlSvmQ4w4USGvVOCPnAmat3pJZW9A1vSBoGKAzrOwRylR7mUwEwRFxuTOqxvWcNBiIshMLUoYbYN7pj7uiOKxdO6eMn+F5DQBLoIAV+tatiqBTUvz0ZveWp85400kntKAgcRWxOhBIMX0wde+kbep9Hyrou7vu+hzKzDBlrpSsa65jCl+cgWJ6KmP/sM3jcKmkte7L/4LsnqMKI3lRQl/mKsfL53BAU6zpZYeFA1iPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1Vtt81NjcNtLYwxW76Dab0tuVvQNdinvjFp1J2NonI=;
 b=CVcl2OobQgjcv6if3jxeYkIy9c/NM58otr7UTXXmA+9pYUP7C5QWHhJyA9Hv6Pym8AAIkBrl4YKm87Rsw5UA9ou/UNWNCli66xE+Vry5WagSHiiA+02ZROPzIC7i5j8dVo7Bu3IRaO++dKjeMoHGy7MpZD7QsrBwUsCQ7PDwBdQ=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSZPR01MB7913.jpnprd01.prod.outlook.com (2603:1096:604:1b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 15:40:03 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926%5]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 15:40:03 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH RFC 00/30] Add support for Renesas RZ/Five RISC-V SoC
Thread-Topic: [PATCH RFC 00/30] Add support for Renesas RZ/Five RISC-V SoC
Thread-Index: AQHaM5k3+GkHfSn/K02qVWBhyLszJbC76+0AgAD3AVA=
Date: Wed, 27 Dec 2023 15:40:03 +0000
Message-ID: 
 <OSZPR01MB7019ABB8A7A2E7C282994DC0AA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZYsbtHsG+SLme8vl@duo.ucw.cz>
In-Reply-To: <ZYsbtHsG+SLme8vl@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OSZPR01MB7913:EE_
x-ms-office365-filtering-correlation-id: 0ac86975-fd47-4761-47c9-08dc06f217d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Zfgfmj3fdj4T1y+DtKmnfWQJN4qvH77dWabgJIG7up4ytR/+YtvQzgjJnV3hRyEeC8JSirRJQeKHMrQXMV3+Eo+d+mfLdmrTdPFW31rV9q315+KOspiJCBArrwf/y0NY3XoKN2cXBFq9mWo5g+5GaWj6bJ/6d6rwt5ZtfB/ZFckVtwXikMr3vblnq8AcuuIWDV7XrtKy7N2mKcVvK7aBnPLvZbNVjJ8XtSSYWqe46V/O7/0fbY7iFMHwqeiF99J1C/urJqkhHXWFEms5WeKK36Uo4O0arrahisuK3SmilGvyVxxPva+IGxv7my/CB6eGLE2By/3zjPqf+d4u8raKh9Mui14ArFjaGqT8xf5MdYCwoLkh9zGNc1mYXZxFsF32cehbAk4gSQdOnR9RAKj6JZkl7wvV7hsT4NKuI94IdNqfGiTiJqr1YHwiWuduPKzJYuHwciGlJiwyiegiiiQtb4EXFAZOuqZIEu8rREAQHSAt8xOeqL9mG36IaDMPw9CXGBnE/nU5/tHQAb235TeKB5FcXkf9HCPqhKM4UWSegEX0oEzDQT4hPDNg88u9Y4pXbVV7doS4W0NcWvhwbkYxsr2HG0XX/yPFqTTCBKj3Gz4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(122000001)(2906002)(33656002)(38070700009)(86362001)(41300700001)(66556008)(66446008)(66476007)(83380400001)(64756008)(54906003)(66946007)(316002)(76116006)(6916009)(7696005)(6506007)(107886003)(26005)(966005)(478600001)(71200400001)(55016003)(52536014)(5660300002)(8676002)(8936002)(9686003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SpVOfENdCKS8RAMyd+dPKWU3V4PjlvXV1IhlPBYGTr7mbY/h/wZA0c/KB0ks?=
 =?us-ascii?Q?bKkDy2jf0/et0Q+cMQQaQIztQfn23OOfq5rfn+T8sq+xEE+STR/NJ/lG6lJj?=
 =?us-ascii?Q?EugGm8JCHQmtdiTFJAnGCPzw+cr3zMgU9yFK8yA32J3YtB8qjvGr3li1wOOn?=
 =?us-ascii?Q?79v6y+i8hvnMVuCQDB6pmxRBY8oUkPFv9bvTcK6Xf/KNBQ/T3/+11X20Q+rn?=
 =?us-ascii?Q?DfKQ8ILwMFOkXyb5IkQtQTZyB61alIi/OTjW2Orka5pCLnER0Lm4M6xdeIFB?=
 =?us-ascii?Q?LQg2ePQWXK7nwvGgrdR3sGCA4V1MHrmMIUFUovHDTkWoRMs5/nGD7wqUjYMU?=
 =?us-ascii?Q?i1UogzQ+mTE76pbY1jQ5pjKwh1+z4LVi0ewqZMdHhyxLDOZf1LPjqf9yDfLX?=
 =?us-ascii?Q?b4SpIvFhFXigdOM7XNhsPdpf/AVcrmKxbMQOAvBjpg+nGMgS/Y37Qd57ocYb?=
 =?us-ascii?Q?Z/Xm9sttamyd2pmJ8VShUt7sRTabri8OXss2BccrmaJlEzXl77xBs9/evrd4?=
 =?us-ascii?Q?Wo/NcaxHPj2ejNcrOFfFNFwLTj49bTWGxIOvEv9gjjH/5LzSJVfuzoHHfaD5?=
 =?us-ascii?Q?Op4YuBHLTK1lkFl+cm4J2Wgj3u3uNPCbG7+IkRzOxmSapCLduy8VLg2/o9ee?=
 =?us-ascii?Q?wR3ywUV3Pb9fNYXO+/CZfqUyQYrT94dR4Y6Lsp6d5w9Lt6Eo/H6Ms4nT0JjK?=
 =?us-ascii?Q?q96M84bTQEZoN2IxtJZYnQEwbKkMdmM1nlDCgiqLxNNEJ9lq0gHg0DEqKNXb?=
 =?us-ascii?Q?NpdFGEsM8Uw5nJ9jpmrUN3wBLikxGngCuELfGklpgZi5jgKMky0KmV/ziGDN?=
 =?us-ascii?Q?b85gYyU7Onh/w3jmg3a39LQBgCqkEsbnRl43Cl1GCqhdJusws/WzM5o6c7Px?=
 =?us-ascii?Q?CFufvLAlHzb1drGS/99yqPxahakhE7/eZ5Nsg1bYb5evc1bkvu3H9OdsN51r?=
 =?us-ascii?Q?J5FyGi3Hs9+cSnyZhxDCvjmXWMdCqhEPeebKOUQqNSnZRM6BNQ4SpMyQiLtg?=
 =?us-ascii?Q?iXgW2r2gAw1xd03uEz0X+CAhgymWQTn93etUP9hLukkwAO6gtrcwKxBlxGGa?=
 =?us-ascii?Q?e6ENtywrE7goHt+dY6bKAHQY6XxJQoKeW9wE7TIaLh/cTqFSLKf2YjiIsS9u?=
 =?us-ascii?Q?8ivPkOxhL5OhBlTrsllVlZvBUWpBFw/9LNRtSWTWXQYXvQz9berRV5ERKWLT?=
 =?us-ascii?Q?GqrKmkL9sXi2aXyT90KaTBb+fGV+waAybvMPWwRdvWDqIgj3EIgxwxInaDF4?=
 =?us-ascii?Q?76ZUIPg+dnMDStd0tq7wr745dszzdpy4qrAtsV7AN+51AlEinKfLIlLKIWyL?=
 =?us-ascii?Q?oBK7JuwXy+Btkiz1mdTw9e9T2eOhyUm+Z2FIf5FUoRC7p83Kcoy7F6iewoMI?=
 =?us-ascii?Q?qvWZnIIih0hIo7e2Xvn7TuSY2SHuSoak5cOodebVifhT5QsL0m6JIQJshV1t?=
 =?us-ascii?Q?2AvagQE2UHiuKPEZ+D7Sj+1O91jSLL2sv1jwqrsF9nVt0HmSal8K5GV7EYIS?=
 =?us-ascii?Q?CIwt9nwpqVTSOG2Pkc0RH6CHSgg8F0qCsOsgUHK2ygJO0r2GdvEZ9gfQ317G?=
 =?us-ascii?Q?hBULCrrLFswGnBiSdyP9FT2FTsSgQUlriEjtL3bcHmjG2RtijCUspVzFHVR4?=
 =?us-ascii?Q?oZIk4c9gycrzEGny7wQz3dU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac86975-fd47-4761-47c9-08dc06f217d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 15:40:03.1283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzi7z2kYyYtxLBdNAMqZBBXHvaEJFbx8FGcqyX4kxQAUZX7r8464K31RWUXd9zfcH3bdEOir7kll1NMFDx4srin98BCTYJv6DA/wIYjSDtSTcDUvaXD2AhIOs6OmNKSK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7913
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Dec 2023 15:40:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14200

Hi Pavel,

Thank you for the review.

>=20
> Hi!
>=20
> Ok, so I went through the series, and there's nothing too horrible. I'll =
have some comments sent to
> individual patches. I'm not a great fan of 5/, as it touches generic code=
, but.
>=20
> Testing did not reveal any breakage... which is not surprising as we don'=
t test r-v at the moment.
>=20
> > Sending this series as an RFC mainly beacuse, as the kernel image is
> > not generic to all RISC-V platforms as the HW is noncoherent.
>=20
> I don't understand the "image is not generic". I see the hw is buggy and =
needs the workarounds
> provided in the series, but kernel configured for your hw should work els=
ewhere, too (slowly), no?
>=20
For the noncoherent issue we carve out a chunk of memory from DDR (done by =
OpenSBI) as shared-dma-pool, below is the node passed to Linux
    reserved-memory {
        #address-cells =3D <2>;
        #size-cells =3D <2>;
        ranges;

        pma_resv0@58000000 {
            compatible =3D "shared-dma-pool";
            reg =3D <0x0 0x58000000 0x0 0x08000000>;
            no-map;
            linux,dma-default;
        };
    };

In Linux we enable DMA_GLOBAL_POOL config, so that all dma'ble memory reque=
sts happens only through this region. The DMA_GLOBAL_POOL config is compile=
 time check rather than a runtime check [0] so for non-coherent platforms f=
or example which want to use DMA_DIRECT_REMAP config the image built for RZ=
/Five wont work.=20

[0] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/=
kernel/dma/direct.c?h=3Dlinux-6.1.y-cip#n239

Cheers,
Prabhakar

> > Complete defconfig file for RZ/Five can be found at [0].
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

