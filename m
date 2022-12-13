Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B033C4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 16:08:38 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.113])
 by mx.groups.io with SMTP id smtpd.web10.77523.1670947709688239323
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 08:08:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=rNkGOUoe;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.113, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjRhBTelqb2pG64cRvx40S4vuAR8kUM8c6ap5ic3gc357TXYE3Esp2RCorCqYk11pghthtN1TtGLMIJqh0I94v/J8Ct/QrVyaswruLEDEMj4CSGmrOwGTYVxvDbBGCydvMm2TtlHu0+gIOUfNnpyQ4hlUfypwehuHQP3TGPPDULUr+OcUbo+Mz2wa7b15Ndc4Zgh5so9FoOqjjclphta6rCTN/0q/DcfK16g1P0lKrheoyUe7vNOS5xjPg287iWVeP0OBbrXMB4G23pqVU8tBNdLoRbg0/4sBFjYUwMqhf4gpwVhJryHTPnLg1TcUx2QxKiV9OggZRIuXQf8T4hpyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIEneaxgh/CeEgeGII+DFFWCx5Y+tFbhTvPrfjt3r88=;
 b=U3y5D9ZmA/ThBly1Hg/+bcH9WXiHDwGG7jRP9IrBRCO1fX5F91BK8xEQ+yU0jM1jCITe7CHQ9+KGUlJp+zvjGI/6yLhBNdCCynhO3uxWT0rs0OJdjT0nEhFO0Ov3Fa8tXcg8foNL7uk0Nu3uZU7vFt4mIe8vDAPVTRpPVrl0SmGbbhC0uoeYvqxdied1SZJcmcFlJ5dZuvh2mm2pfNQfJUA9NYTwMT5K3wwJ9d3iF6YPo0eyvVra5DcQ4ZVI7qxNTsmXo7QBISyUBAbqh0GpPLCz+GKsoAatWGVsIa09Dg4FuWISmSYRsEUtaC6FTGLs4lUG24pjo+6tEqJg90536Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIEneaxgh/CeEgeGII+DFFWCx5Y+tFbhTvPrfjt3r88=;
 b=rNkGOUoeAoevJI+DQjcbOJs/kSuJB5heKTuwTqoBrxShs0W6anS0UCNp0vt/bj7qCUhyfzGHDg71mOyRUYIrGOTvehxs9l+dBl8dcPeJ0GkjvqID/5uR/Aq1WeCnNRcFWl5cYwHznOHHqcLP78NrFVRg6jWyhCSGRlQUcp6My28=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8058.jpnprd01.prod.outlook.com (2603:1096:604:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 16:08:25 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 16:08:25 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: Regarding  commit eb69c07eca22ffd8621d9de9378e4b3ce7965190
Thread-Topic: Regarding  commit eb69c07eca22ffd8621d9de9378e4b3ce7965190
Thread-Index: AQHZDwY4hOYrVHZLX0+FYgabGelo+q5r8m1ggAAJJICAAABYgA==
Date: Tue, 13 Dec 2022 16:08:25 +0000
Message-ID: 
 <OS0PR01MB5922DBCB0457BB53965F363886E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
 <a633020e-7436-8d86-7eb6-34482af700a9@siemens.com>
 <OS0PR01MB5922918719AC879EDCDC70A586E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB592266CED3CCA24F54312A7E86E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Y5ii74pEmCLaW0P+@duo.ucw.cz>
In-Reply-To: <Y5ii74pEmCLaW0P+@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8058:EE_
x-ms-office365-filtering-correlation-id: 7a8e02fe-a128-432a-8176-08dadd24442b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8PcVw6Ya9L9Kj10bSd0MW4v/RQxxY81aiqpt9vNkplo+l0SeexND8xFxamwFVhNPhGtNhHvghGUNN+kuBJKGF+2ZPF+yecA1fNnKwkwXZg/qSo9hM2qd52jkG/+ip+ryRwMYrItEzIkXD3O44B6MIQtpHbULBkDb3P41Xuoezu4FODNFkh/VW9tIXyNnj7r/Fsp7vE5ekA0pUbmBOBzbu79F3j7ixi1Nr54jO9BHyrLKxyxJj8uBIAzoABFOEphgu0DVhJsmAoqoiCXEizZF2D7PcRbdgjuiJNAfDlnNExrA//r+lsKL/MNPgjN37MCc1oihA9zFYeWqq8yNNVf6Y/rgcTrhCZal6rZw3kXDvgBAc2b45a1+6sRaDpil1QOQT4gmaaOSE12laH6sRyDqnpT4iRp1aaIihuyytn218xjei1Xj2gGjHdxJ+Bof7kOPC3ZLR751hN81vGZPG1BpJCWYlrUcW4FnUd+UYyf16I7p5Lnun/wfsRJADS8sQhW2FAqiYvn2oLRmKFGQpTGF4SAzDDtxg2SUD1qg3w/kySPLghMiiikOOdkqDt/ePHjcxhmiM0OGVPrLkB7dKLF3kSxpcNSQwFsf35+IqPYMVmdaP0bFj6JSQrX+zbM9hE2q7De5+uqskm+0fj4rbP0AfxxiW0yvZzyDnIF9tFLCCxi0CHoUj7iUM3qMUgnDg2qkc5GEk9dZkWQjjKylbefrgQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(76116006)(66946007)(64756008)(8676002)(7696005)(2906002)(66446008)(66476007)(9686003)(478600001)(53546011)(26005)(66556008)(186003)(6506007)(4326008)(38070700005)(8936002)(5660300002)(52536014)(122000001)(55016003)(83380400001)(41300700001)(38100700002)(7116003)(33656002)(86362001)(54906003)(316002)(71200400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4YbNMlkDfV7dQXRYbEohzvBxjHKnuouIxhTeSMHB6ZxEXlB9GOHZnUlKjosH?=
 =?us-ascii?Q?INDayC4BgqDG54F+INoWqYC+WmP2eLwyVEsANIXRtWeYPUb9ilruKlKteIBE?=
 =?us-ascii?Q?ZjFtP4U51EyQ0fPjjIpJrbBztgA4tkY8YqZdj5ih6cShKALriPF8uhIuUfq1?=
 =?us-ascii?Q?6YsqFmjSoFkmWVDsSj9B5+uCA+x0dxACh4FQA3YghHMhfY648byFE7HW6WgM?=
 =?us-ascii?Q?3+X8r64LwwCueO2apzAsEzD4Bd1xxsnvrALSbuY1eHr7+Gspzh2RCV19fot+?=
 =?us-ascii?Q?mRroFFi/MfNwyFAg4GPu0BAKCc/k0q5CL7ZwwZvjY7iG+qBtqdETqWVWg/IH?=
 =?us-ascii?Q?7dJXxj6frdc4AafswCyjkMsCNxl3yP0QCvDNGzi/B5QVbLCrwHOSTsqRNHRF?=
 =?us-ascii?Q?Jluek1Fhjl4vmQwbXlfkQwSE0/eU2k+tdTPUapXuEVy/xZRduk8IlNks+m41?=
 =?us-ascii?Q?sLpBeSkreh3PprQhpGOMZ5ACf2AP8WlzuZgFTOKSKyhaWJI/C8JoNb3ESvNr?=
 =?us-ascii?Q?afLjfXLF/mEFibMB5B7MtqvU4AohVALiYw5JfAXNtldBfSFptdjxIoT1VOfp?=
 =?us-ascii?Q?xxJ+fJCtztiI0JR8ZSN3hg2Hz72HB+IRZ18SnUhIxbQGrE4cupm+Dvg/elkO?=
 =?us-ascii?Q?GKI1H0cK/ms1SA/C4e83UU4oIPBvMVpdkIqeUrF2VGiRhxTI4WhPMGapug1J?=
 =?us-ascii?Q?egi0MC33sFylVUOEdGJVffLazmvNErgNTNlQ7sSObl3VRc4rY0diQDLbCQX0?=
 =?us-ascii?Q?kZTQncI6L1It4ovERWzS8XtBUtZ3dVRGiUFBFV8EZMq7hAwb7aSHrglNWaXl?=
 =?us-ascii?Q?/QVUG+g++aZTWY40E2cmBJ117dcOEmdf4TKCKbIhZNcFEBHg6+d8lF8M3te4?=
 =?us-ascii?Q?YBViUfmkpx6BZUADPxZ+HRQReGcyBwweXFMg95b1SDSaJdb6r6qB35t+Stzc?=
 =?us-ascii?Q?KncY9UpbTZT8P+AR37io8DAhFaPPWuzztl+/0+RNm5B8YaMArUZKQiSQk8fX?=
 =?us-ascii?Q?1MA41COfYgVdj039yN4K+emQ65ILVdtqxod7wKbhCL73u/OmyJktV+8oqsXf?=
 =?us-ascii?Q?IGDdrzJ3DICvV8KCGTeIpE+ekm7z6nmgiZ2b0oDcd7ev443UCjg3Q/08lm39?=
 =?us-ascii?Q?lLiuKrZaPYeBk70EBA/Dt6JFTcKeLiJd6CYX5fMFk7AIQoBwK/yzBoBtyjBy?=
 =?us-ascii?Q?TnKsxEtcpwOk0RGsJfyftx4T7iKd28FHJxCVlpHr+LuLREhhRfhCKk/lAupA?=
 =?us-ascii?Q?/6qb188BVgmlxT5fHtnGc1+GE3i099WO7GWmejHaVqURUvC+6v8llLcy0N8O?=
 =?us-ascii?Q?g0h++Gl4lVL2I9A8EgS0xqf7HC30zDmyTN+HtIipEQ+bIPRCxw5LuVviPvEI?=
 =?us-ascii?Q?FTStcd3Yrie2ZscrUxdhBvABc4QqaLj3j5cORiDl2BgkMSeGza4QkhjUlE/m?=
 =?us-ascii?Q?mupK70BAZSFNn5zh1nUN+XBzlydeUrXTkTxhKNT6raVqYCC4P5llPWlPsMqw?=
 =?us-ascii?Q?AIIzSIG1wX3p96m0DIoeSeNAOHKJczMdUS/XZGCJyNG0m2hQuZso7e5fVtRH?=
 =?us-ascii?Q?Pi9DmQBGT3r4eZFu758PDGXggcdVWBnZYt+X9JR21IL0GoKGlmwR4e+euf9r?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8e02fe-a128-432a-8176-08dadd24442b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 16:08:25.8140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: un5aDNEa+/l7UjABPPEerH1qpAMfnwMSHjGfF/jIt8Pc+mVK6uvrkWzkh5Oc1ApBdQQJusGMOvXOcgvS/H56Sv9NXxl6sBK9wJVTKkLaRCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8058
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 16:08:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10220

Hi Pavel,

No worries, I am doing some testing with couple of CAN patches along with I=
RQ storm patch. I will post soon.

Cheers,
Biju

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 13 December 2022 16:06
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Pavel Machek <pavel@denx.de>; Nobuhiro
> Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: Re: Regarding commit eb69c07eca22ffd8621d9de9378e4b3ce7965190
>=20
> Hi!
>=20
> > Anyway, I will post this patch to CIP ML today.
>=20
> The code was moved around with
>=20
> commit 59a641368b460e4d1e8dc58a922915591303bd54
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Date:   Wed Dec 22 13:49:45 2021 +0000
>=20
>     can: rcar_canfd: Add support for RZ/G2L family
>=20
>     commit 76e9353a80e9e9ff65b362a6dd8545d84427ec30 upstream.
>=20
> Sometimes later, I see your commit:
>=20
> commit 702de2c21eed04c67cefaaedc248ef16e5f6b293
> Author: Biju Das <biju.das.jz@bp.renesas.com>
> Date:   Tue Oct 25 16:56:55 2022 +0100
>=20
>     can: rcar_canfd: rcar_canfd_handle_global_receive(): fix IRQ storm on
> global  FIFO receive
>=20
> ...and yes, it looks like we may want that one.
>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

