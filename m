Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A927C433FE
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 09:51:08 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.90])
 by mx.groups.io with SMTP id smtpd.web12.18521.1665568263137867965
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 02:51:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Mq48ka1t;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.90, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8eyL6AHaiW1vXtM2hC6bXuF++0Q4oKC6zoH3JR0YwAucpMQNZE6GGs0UnJLvSLAv3qCiMnomhqVnn1LF/gNbZF8lSB6nH7mkylnn3zRW4vAyA2LKlYgihNEKK/W5HwzoZipPTBTo4Xlk5kBn5doJLC4ltYrcdeCZ9JMxrBFbdIRo7v58To13+oC58ChYBzN8KGWEl1TvX1p9qZkn73Hzwi9edg8S0P/DrwDluLbWlAI9VUs7GwptNgOty7mlbBR1jlZRDdoA745MXK2JQGY+6+F1fT1RbT8Ws5Z+dZtMaRTRxbSYOcDsagTntpwekdhIeMOuHwp7Y3vILtERuPovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66Z/8WBAMI3rc+OM8uZPBeFTd4N1maOvUMR9d4BOOeQ=;
 b=M3eb11hT3YVm1QDYvZo1oPYIgsKN58e6KRIRtz3OxW/snODBnpPguPWBXjTLjS3MgMbrv4dz8naCuWWm/P7uXt37NDjhgzGNzO0qdzyZQ/yiTbMOkHgZUYku5IU9UP7SoCMPel8fAEIhAm1O4kDDih6xEyE5AM2X63M5JvJZfOgW/EBpcCuw76QeeOKI9yWhRs+h7HzQ06i86N0diiqTYStw/Sctli4hSlonD33VUcz935kUchogdUBNemlzMt6i4kYdHgx0fWBRdpGpzOZQscZGzw+f8NZjGjQ0ZY+VCNzQjo0oz+X/jHSVZ5McLv6DuHF1j5GKbS9O13/RGTcOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66Z/8WBAMI3rc+OM8uZPBeFTd4N1maOvUMR9d4BOOeQ=;
 b=Mq48ka1tHXKo4NHQYtBvqlSzx2FjbtRJUNFc5qbb4V9CrimdjTlfRlRcvBY6j5Hq2yw/mV0KSIPKhGeRyzAwmie9+1Bc8JJaQSk/hPzP7UGB9rArrlwR4hYdM9fWuF4bZkQePFCB8HEY5xRhP8jtrAT13JWJOiYszQRCAhJAyjM=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB6141.jpnprd01.prod.outlook.com (2603:1096:400:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 09:50:58 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a920:4b7e:5340:eb0f]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a920:4b7e:5340:eb0f%7]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 09:50:58 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Hung Tran <hung.tran.jy@renesas.com>
CC: Pavel Machek <pavel@denx.de>
Subject: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Thread-Topic: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Thread-Index: AQHY3aJ1UOfjjk+7D0K/pBqB70He+q4JoSEAgAAJDPCAANotEA==
Date: Wed, 12 Oct 2022 09:50:58 +0000
Message-ID: 
 <OSZPR01MB7019463C819F66866FBCED43AA229@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <20221006114326.GA21855@duo.ucw.cz>
 <4d6db8d8-3d96-6969-f551-baa94f865fa3@siemens.com>
 <20221006220740.GA7670@duo.ucw.cz> <20221006223251.GB7670@duo.ucw.cz>
 <95aed7d4-b775-7273-9478-b0d9ca77938c@siemens.com>
 <20221007101932.GB25429@duo.ucw.cz>
 <66be9e25-7b51-14f1-6a48-352eb748f689@siemens.com>
 <8492e784-1af5-5584-1109-63c9aee53cab@siemens.com>
 <OS0PR01MB59228F2E10391C505F8C8CB586219@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <d0ace49c-29a7-baf8-ba7b-bc385df68492@siemens.com>
 <OS0PR01MB59225BD41E0A32CBD136C68386239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <af98d87b-b1cb-9123-fd61-c0e06004b7c4@siemens.com>
 <e93e0736-cb18-f42f-9c22-e9825b82cc5c@siemens.com>
 <OSZPR01MB7019765C0F247A3854D4380EAA239@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB7019765C0F247A3854D4380EAA239@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB6141:EE_
x-ms-office365-filtering-correlation-id: 7a4a1429-46be-4a2f-a5cf-08daac3743e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QTbqYSM/nAMvgHUB84y6MY5BPI7EWx9xi1DZcAD2K65liS+7Hzo+ncbi3fhw435LLf1KCHKh/azk67vXOgX4+7jroFh+PN9s7Q7u71ZB8bJ+kXqJfPYOC4dXVEKY25gpOuTnTOnpc9QDcfd5mUX47Rw+XyB4VLdoUrsCiQo+kVeHj/BwrqAFjq5V9bM2aBEWly/O24bliIsHV0n0YIj7VTUDSZ9ms/EvmAzVfW98nM/5noRXvjl3UuaGQfXUne9oHpcMKA1K0Yv+mtYYpe3aDHIynYxId/xhsi673+2H4iCS/jKbBEC4YOjKb18bi50I8lOkUtZGY4H1xySl1cnbMFjdc8jCpAltMowCWngNz2Xgwjt2b8AdUfID25lFd3RpXWK0fzuAPAaa+QOyAuAvk+Eeec/mEY/izaKa/0vELyADF/KOKRw3IwrdnePkSG7qhSikd/NwTPdWb5FHmHBfNWCYuBLh5yO4LxFUxuOEk/a5K5SbaxW1hXHkEgCszqRUf4b0er6NnMyBGY/8zvNzf5Em9tHqeyrimzdJyVzNp5RiF/jUAI7PKeo7lCL+jWqa8DZuFLXFl+rYfXPVfATAt0uZq1kZo0gEWnCtUPJ6MbtamYTLFN+jnKqsG/x8Kzz7WeyZbDUWsqdDC5dVVkLhm/O5xCCPRMnkPCApTL9Lo9OLY+e2aBAfLBfIjCFgW1eGuZNVYNtJ+tBm3LCS/fQO28AikCnuk57PMDHNePLtHXV7JlSmEff+F5ta5mAO0+1GUCPCOH41W/jEMg+mkIoufnoFNAIiNsB4eypvuXGJlcE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(9686003)(38070700005)(316002)(966005)(478600001)(71200400001)(38100700002)(55016003)(99936003)(122000001)(33656002)(66476007)(8936002)(86362001)(6506007)(45080400002)(7696005)(53546011)(83380400001)(186003)(26005)(4326008)(8676002)(64756008)(66446008)(110136005)(66556008)(2906002)(52536014)(5660300002)(66946007)(76116006)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?R8d16Q4iwbM7BLQYKuIMKPr/7Du6SU7L7FZGZreKWy4hX+UsJSrgysMfJRk0?=
 =?us-ascii?Q?rtWo83nGf4R+DgwpDM7t08OxoaoFskpPBp8nEqSh1ijb4C2U6Hg9czV0IJII?=
 =?us-ascii?Q?1Y12F4MMb3OJ+Y/GrEyw7Kxn/+QGYyOFK3QDyGzU/aoaNeUys07sC66W0XgO?=
 =?us-ascii?Q?wxCgDA2MqYkGcDqsqTbRCn25RimOt8AggShpSsscjV1QGdrgyo9hgF+7b8uw?=
 =?us-ascii?Q?zsR5iAZrFI0zslC8pAClmHfA6G4/hd7VLvG7VAKrxElchDUJZeK/Is4+Ufho?=
 =?us-ascii?Q?J3w0Qy+CAeCfD31zJseVjG3x5Ozjvq7hp4zPblREhuZsV8m9sonwQv3PWdNQ?=
 =?us-ascii?Q?U8zftzyGRlayf76E6bj4AEBReUYXnJxvoU/R4YFm/SjB9zL90Z22bF3kUOoy?=
 =?us-ascii?Q?eXgIoMKfFMPjk7aSrKT5iAZJ3VwN1vHMJepa1A2k2alnhYXxRWxb+kmk+yGh?=
 =?us-ascii?Q?ddvDl9ihFQm6fp2F21L6sFSjWSpXFMa09DvC+I7dG9kPxqWlJYn1FYcPs2tr?=
 =?us-ascii?Q?J3etTExGE+p8A16d1BcbZg2B6sIcoBlySf4vY8OSbqc5CjtVJ/++6U7K2/nF?=
 =?us-ascii?Q?KGJ/W9GesUMYoZyEuOEZxNADA7NFcJzWUvX8VWrE/R/+UI8eXZMKJTmoKyvf?=
 =?us-ascii?Q?ZW2U+/O/CvujgSa0UhJ7PyT6c7XZLyTGL7Reexw8nRMgyGfoggHVA3z45LDp?=
 =?us-ascii?Q?5gsm7+wXD7w+9AdmL8jhv1liaimSDYh2tpsbD/CTh9AqRqDGoejznU5cHjZ0?=
 =?us-ascii?Q?xWj05WCDDLo/riig1/Sv7Ff/qYaZu20MaAu9YI6A5PF7b2ov625XCf/XdxoF?=
 =?us-ascii?Q?tkUwbWINm8ds6gSgHn+so5otiYfNPLAzdumVKB6m0uDiRyVQhzjWMya2Qp7A?=
 =?us-ascii?Q?Bf2gEIbmSP86rs7AJjd4jrZcslNWMeuPbUzlLuhVpNsYLxwlAoa/t0O2GJks?=
 =?us-ascii?Q?+GiKzxeHlU7/CBfu7D+nkNngeg8giaYNUB5p3fcvOJ9L+sUGFXGvAfayKPz1?=
 =?us-ascii?Q?Mk7SYqbW7+ERLp+GC8THSNhMLkqDwgrNu/HwP6ouZSyySLYpcjF/Eivo3eJG?=
 =?us-ascii?Q?z9pmO5Pi9gqGfR6dd4v/LmFNdFxIN2pte0ukb20HhLKTx98Bl/m2Jd8QgJjw?=
 =?us-ascii?Q?b3t/DLbKyBRgtF0JFJhQh7XbAb/hNOoZEKJcxDyH3XM92RGKqbEgZniAiOUU?=
 =?us-ascii?Q?PL/yR/iNlcyNQYQcIJzA2h1VTWlM8epYei59eFiZ1wQeJBBNahD9NOAYO2pS?=
 =?us-ascii?Q?RMPkGY6EJYP8Birwm7hE6BSGLp7iKhvi9jFiWwbxkEFUlhotnXMUgwLNDU2S?=
 =?us-ascii?Q?nNZOC0CUtdqn5S7va8DwDt7pYKxwDol9rGXrV9B/ozTQ4qdb2EzaV4BkRwhf?=
 =?us-ascii?Q?0cdK1Y7m/qrKDCC4FuBdCqI7LLQ0S3T4dj6gXxIuQjtKJD0kanP1JwypcclB?=
 =?us-ascii?Q?Duu1YZwHKCZ/4JORetttLboY5nQsPSLfQDzBWeiT7wJx/rkH/nJBuQAX7dgp?=
 =?us-ascii?Q?i8W8NotL8+IbRR5QgDxI4zYi2dHCcgTr7CnQgBU/ZXOGhlAojmdaGn78FceG?=
 =?us-ascii?Q?pIJXhmv5v5zDwP7VCkLTxowTp29s+rMYTV6i0e5XJS4MNU3LgWZcJs+EYvwl?=
 =?us-ascii?Q?ByOeL3w8wHY+cydNTYDJDyw=3D?=
Content-Type: multipart/mixed;
	boundary="_002_OSZPR01MB7019463C819F66866FBCED43AA229OSZPR01MB7019jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4a1429-46be-4a2f-a5cf-08daac3743e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 09:50:58.8114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQCVuMaAu/2pQNDhQ7whkt65q41Fg54vqmnraYAsPhqxBnUTXmuatdwyA1cAC8l0go5MIZmqSfbYyp5fWY4vbr5dR4YuhrtTFAmCpMUaxlKqirobN/PMDDb7nnN8Wag9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6141
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 09:51:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9736

--_002_OSZPR01MB7019463C819F66866FBCED43AA229OSZPR01MB7019jpnp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> -----Original Message-----
> From: Prabhakar Mahadev Lad
> Sent: 11 October 2022 21:49
> To: Jan Kiszka <jan.kiszka@siemens.com>; Florian Bezdeka
> <florian.bezdeka@siemens.com>; cip-dev@lists.cip-project.org; Chris
> Paterson <Chris.Paterson2@renesas.com>; Hung Tran
> <hung.tran.jy@renesas.com>
> Cc: Pavel Machek <pavel@denx.de>
> Subject: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
> isar-cip-core for RZ/Five
>=20
> Hi Jan,
>=20
> > -----Original Message-----
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > Sent: 11 October 2022 21:15
> > To: Florian Bezdeka <florian.bezdeka@siemens.com>;
> > cip-dev@lists.cip-project.org; Chris Paterson
> > <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; Hung Tran
> > <hung.tran.jy@renesas.com>
> > Cc: Pavel Machek <pavel@denx.de>
> > Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re:
> Preparing
> > isar-cip-core for RZ/Five
> >
> > On 11.10.22 20:51, Florian Bezdeka wrote:
> > > On 11.10.22 12:34, Biju Das via lists.cip-project.org wrote:
> > >>> Subject: Re: RE: [cip-dev] ldconfig segfault on RZ/Five was Re:
> > >>> Preparing isar-cip-core for RZ/Five
> > >>>
> > >>> On 09.10.22 10:42, Biju Das wrote:
> > >>>>> Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re:
> > >>> Preparing
> > >>>>> isar-cip-core for RZ/Five
> > >>>>>
> > >>>>> On 08.10.22 10:27, Jan Kiszka wrote:
> > >>>>>> On 07.10.22 12:19, Pavel Machek wrote:
> > >>>>>>> Hi!
> > >>>>>>>
> > >>>>>>>>>>> I tried, but installation fails - illegal instruction.
> > >>>>>>>>>>
> > >>>>>>>>>> Yeah, ldconfig is needed for installation. But I get a
> > >>>>> segfaulting
> > >>>>>>>>>> gcc binary.
> > >>>>>>>>>
> > >>>>>>>>> It crashes rather soon after startup, so I was able to
> trace
> > >>>>>>>>> complete path.
> > >>>>>>>>>
> > >>>>>>>>>> But I do have slightly different results then you (I
> think;
> > >>> I'm
> > >>>>>>>>>> far from risc-v expert). I did a breakpoint:
> > >>>>>>>>>>
> > >>>>>>>>>> Breakpoint 1, 0x00000000000385d4 in ?? ()
> > >>>>>>>>>
> > >>>>>>>>> I believe it should not end at 0x00000000000385d4 at all.
> > >>>>>>>>> The 0x000000000001537e jal instruction should end up
> calling
> > >>> 0x3806a
> > >>>>>>>>> AFAICT, but it calls 0x385d4 instead. It happens during
> > >>>>>>>>> single-stepping, so it should not be anything subtle.
> > >>>>>>>>>
> > >>>>>>>>> (gdb) disassemble $pc,+0x20
> > >>>>>>>>> Dump of assembler code from 0x1537c to 0x1539c:
> > >>>>>>>>> =3D> 0x000000000001537c:  mv      a0,a4
> > >>>>>>>>>    0x000000000001537e:  jal     ra,0x3806a
> > >>>>>>>>>    0x0000000000015382:  auipc   a5,0x8a
> > >>>>>>>>>    0x0000000000015386:  addi    a5,a5,1342 # 0x9f8c0
> > >>>>>>>>>    0x000000000001538a:  ld      a4,0(a5)
> > >>>>>>>>>    0x000000000001538c:  beqz    a4,0x153f0
> > >>>>>>>>>    0x000000000001538e:  jal     ra,0x38abe
> > >>>>>>>>>    0x0000000000015392:  ld      a0,0(s6)
> > >>>>>>>>>    0x0000000000015396:  auipc   s7,0x85
> > >>>>>>>>>    0x000000000001539a:  ld      s7,-406(s7) # 0x9a200
> > >>>>>>>>> End of assembler dump.
> > >>>>>>>>> (gdb)
> > >>>>>>>>> (gdb) stepi
> > >>>>>>>>> 0x000000000001537e in ?? ()
> > >>>>>>>>> (gdb)
> > >>>>>>>>>
> > >>>>>>>>> Program received signal SIGILL, Illegal instruction.
> > >>>>>>>>> 0x00000000000385d4 in ?? ()
> > >>>>>>>>> (gdb)
> > >>>>>>>>
> > >>>>>>>> Did you try to compare the call trace to QEMU, where we
> divert?
> > >>>>>>>
> > >>>>>>> Yes, that's possible way forward, but it will require some
> > >>>>>>> considerable setup on my side.
> > >>>>>>>
> > >>>>>>> If you have QEMU ready... objdump tells you ldconfig's
> > >>> entrypoint,
> > >>>>>>> from that point you can just stepi. In less than 200 steps,
> > >>>>>>> you should have sigill... and complete steps that lead to
> it.
> > >>>>>>>
> > >>>>>>
> > >>>>>> I've updated sid-ports (dropped the snapshot pinning), and
> now
> > >>>>>> I'm getting a page fault on the instruction before the one
> that
> > >>>>>> was causing SIGILL before:
> > >
> > > In case the requested page is a page with PROT_WRITE only (no
> > > PROT_READ) it might be related to
> > >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo
> > > re
> > > .kernel.org%2Flinux-riscv%2F20220915193702.2201018-1-
> abrestic%40rivo
> > > si
> > > nc.com%2F&amp;data=3D05%7C01%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.c
> > > om
> > >
> %7C4efefe2d9ed148944efd08daabc55ab5%7C53d82571da1947e49cb4625a166a4a
> > > 2a
> > >
> %7C0%7C0%7C638011161361337108%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> > > Aw
> > >
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&a
> > > mp
> > >
> ;sdata=3DmsPQCy0siXTQOmhj7gAtCK1zSQChGNg%2B2KcmAhQvH4k%3D&amp;reserved
> > > =3D0
> > >
> > > AFAIR all stable branches have that problem currently.
> > >
> >
> > Nice idea. I quickly hacked that on top of the rzfive kernel, but it
> > didn't change the picture, unfortunately.
> >
> Thanks for the quick test.
>=20
> > That said, being able to test linus/master would be very valuable
> here.
> >
> I will test this on top of v6.0 and update the results.
>=20
I did a quick test with the patches pointed by Florian but unfortunately ld=
config still fails.

Cheers,
Prabhakar

--_002_OSZPR01MB7019463C819F66866FBCED43AA229OSZPR01MB7019jpnp_
Content-Type: text/plain; name="ldconfig.txt"
Content-Description: ldconfig.txt
Content-Disposition: attachment; filename="ldconfig.txt"; size=25745;
	creation-date="Wed, 12 Oct 2022 09:50:03 GMT";
	modification-date="Wed, 12 Oct 2022 09:50:58 GMT"
Content-Transfer-Encoding: base64

VS1Cb290IDIwMjIuMTAtMDAxODgtZ2JkNzRmYjJhNzgtZGlydHkgKE9jdCAxMiAyMDIyIC0gMTA6
MTA6NTEgKzAxMDApDQoNCkNQVTogICBydjY0aW1hZmRjDQpNb2RlbDogc21hcmMtcnpmDQpEUkFN
OiAgODk2IE1pQg0KU1dfRVQwX0VOOiBPRkYNCkNvcmU6ICAyOSBkZXZpY2VzLCAxNyB1Y2xhc3Nl
cywgZGV2aWNldHJlZTogc2VwYXJhdGUNCk1NQzogICBzZEAxMWMwMDAwMDogMCwgc2RAMTFjMTAw
MDA6IDENCkxvYWRpbmcgRW52aXJvbm1lbnQgZnJvbSBNTUMuLi4gT0sNCkluOiAgICBzZXJpYWxA
MTAwNGI4MDANCk91dDogICBzZXJpYWxAMTAwNGI4MDANCkVycjogICBzZXJpYWxAMTAwNGI4MDAN
Ck5ldDogICBldGgwOiBldGhlcm5ldEAxMWMzMDAwMA0KSGl0IGFueSBrZXkgdG8gc3RvcCBhdXRv
Ym9vdDogIDANCmV0aGVybmV0QDExYzMwMDAwIFdhaXRpbmcgZm9yIFBIWSBhdXRvIG5lZ290aWF0
aW9uIHRvIGNvbXBsZXRlLi4uIGRvbmUNCkJPT1RQIGJyb2FkY2FzdCAxDQpCT09UUCBicm9hZGNh
c3QgMg0KQk9PVFAgYnJvYWRjYXN0IDMNCkRIQ1AgY2xpZW50IGJvdW5kIHRvIGFkZHJlc3MgMTky
LjE2OC4xMC45NiAoMTM5OCBtcykNClVzaW5nIGV0aGVybmV0QDExYzMwMDAwIGRldmljZQ0KVEZU
UCBmcm9tIHNlcnZlciAxOTIuMTY4LjEwLjE7IG91ciBJUCBhZGRyZXNzIGlzIDE5Mi4xNjguMTAu
OTYNCkZpbGVuYW1lICdyemYvSW1hZ2UuZ3onLg0KTG9hZCBhZGRyZXNzOiAweDRhMDgwMDAwDQpM
b2FkaW5nOiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIw0KICAgICAgICAgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCiAgICAgICAgICMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQog
ICAgICAgICAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIw0KICAgICAgICAgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCiAgICAgICAgICMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQog
ICAgICAgICAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQogICAgICAgICAyIE1pQi9zDQpkb25lDQpC
eXRlcyB0cmFuc2ZlcnJlZCA9IDYwMzg2NDQgKDVjMjQ3NCBoZXgpDQpVc2luZyBldGhlcm5ldEAx
MWMzMDAwMCBkZXZpY2UNClRGVFAgZnJvbSBzZXJ2ZXIgMTkyLjE2OC4xMC4xOyBvdXIgSVAgYWRk
cmVzcyBpcyAxOTIuMTY4LjEwLjk2DQpGaWxlbmFtZSAncnpmL3I5YTA3ZzA0M2YwMS1zbWFyYy5k
dGInLg0KTG9hZCBhZGRyZXNzOiAweDQ4MDAwMDAwDQpMb2FkaW5nOiAjIw0KICAgICAgICAgMS4z
IE1pQi9zDQpkb25lDQpCeXRlcyB0cmFuc2ZlcnJlZCA9IDIyMTI5ICg1NjcxIGhleCkNClVuY29t
cHJlc3NlZCBzaXplOiAxOTg0NzE2OCA9IDB4MTJFRDgwMA0KTW92aW5nIEltYWdlIGZyb20gMHg0
ODA4MDAwMCB0byAweDQ4MjAwMDAwLCBlbmQ9NDk1NjQwMDANCiMjIEZsYXR0ZW5lZCBEZXZpY2Ug
VHJlZSBibG9iIGF0IDQ4MDAwMDAwDQogICBCb290aW5nIHVzaW5nIHRoZSBmZHQgYmxvYiBhdCAw
eDQ4MDAwMDAwDQogICBMb2FkaW5nIERldmljZSBUcmVlIHRvIDAwMDAwMDAwNTdmZjcwMDAsIGVu
ZCAwMDAwMDAwMDU3ZmZmNjcwIC4uLiBPSw0KDQpTdGFydGluZyBrZXJuZWwgLi4uDQoNClsgICAg
MC4wMDAwMDBdIExpbnV4IHZlcnNpb24gNi4wLjAtcmM3KyAocHJhc21pQHByYXNtaSkgKHJpc2N2
NjQtbGludXgtZ251LWdjYyAoVWJ1bnR1IDkuNC4wLTF1YnVudHUxfjIwLjA0KSA5LjQuMCwgR05V
IGxkIChHTlUgQmludXRpbHMgZm9yIFVidW50dSkgMi4zNCkgIzkxIFNNUCBXZWQgT2N0IDEyIDEw
OjQ2OjA0IEJTVCAyMDIyDQpbICAgIDAuMDAwMDAwXSBPRjogZmR0OiBJZ25vcmluZyBtZW1vcnkg
cmFuZ2UgMHg0ODAwMDAwMCAtIDB4NDgyMDAwMDANClsgICAgMC4wMDAwMDBdIE1hY2hpbmUgbW9k
ZWw6IFJlbmVzYXMgU01BUkMgRVZLIGJhc2VkIG9uIHI5YTA3ZzA0M2YwMQ0KWyAgICAwLjAwMDAw
MF0gZWFybHljb246IHNiaTAgYXQgSS9PIHBvcnQgMHgwIChvcHRpb25zICcnKQ0KWyAgICAwLjAw
MDAwMF0gcHJpbnRrOiBib290Y29uc29sZSBbc2JpMF0gZW5hYmxlZA0KWyAgICAwLjAwMDAwMF0g
ZWZpOiBVRUZJIG5vdCBmb3VuZC4NClsgICAgMC4wMDAwMDBdIFJlc2VydmVkIG1lbW9yeTogY3Jl
YXRlZCBETUEgbWVtb3J5IHBvb2wgYXQgMHgwMDAwMDAwMDU4MDAwMDAwLCBzaXplIDEyOCBNaUIN
ClsgICAgMC4wMDAwMDBdIE9GOiByZXNlcnZlZCBtZW06IGluaXRpYWxpemVkIG5vZGUgbGludXgs
Y21hQDU4MDAwMDAwLCBjb21wYXRpYmxlIGlkIHNoYXJlZC1kbWEtcG9vbA0KWyAgICAwLjAwMDAw
MF0gWm9uZSByYW5nZXM6DQpbICAgIDAuMDAwMDAwXSAgIERNQTMyICAgIFttZW0gMHgwMDAwMDAw
MDQ4MjAwMDAwLTB4MDAwMDAwMDA3ZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdICAgTm9ybWFsICAg
ZW1wdHkNClsgICAgMC4wMDAwMDBdIE1vdmFibGUgem9uZSBzdGFydCBmb3IgZWFjaCBub2RlDQpb
ICAgIDAuMDAwMDAwXSBFYXJseSBtZW1vcnkgbm9kZSByYW5nZXMNClsgICAgMC4wMDAwMDBdICAg
bm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDQ4MjAwMDAwLTB4MDAwMDAwMDA1N2ZmZmZmZl0NClsg
ICAgMC4wMDAwMDBdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDU4MDAwMDAwLTB4MDAwMDAw
MDA1ZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDYw
MDAwMDAwLTB4MDAwMDAwMDA3ZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdIEluaXRtZW0gc2V0dXAg
bm9kZSAwIFttZW0gMHgwMDAwMDAwMDQ4MjAwMDAwLTB4MDAwMDAwMDA3ZmZmZmZmZl0NClsgICAg
MC4wMDAwMDBdIFNCSSBzcGVjaWZpY2F0aW9uIHYwLjMgZGV0ZWN0ZWQNClsgICAgMC4wMDAwMDBd
IFNCSSBpbXBsZW1lbnRhdGlvbiBJRD0weDEgVmVyc2lvbj0weDEwMDAwDQpbICAgIDAuMDAwMDAw
XSBTQkkgVElNRSBleHRlbnNpb24gZGV0ZWN0ZWQNClsgICAgMC4wMDAwMDBdIFNCSSBJUEkgZXh0
ZW5zaW9uIGRldGVjdGVkDQpbICAgIDAuMDAwMDAwXSBTQkkgUkZFTkNFIGV4dGVuc2lvbiBkZXRl
Y3RlZA0KWyAgICAwLjAwMDAwMF0gU0JJIEhTTSBleHRlbnNpb24gZGV0ZWN0ZWQNClsgICAgMC4w
MDAwMDBdIHJpc2N2OiBiYXNlIElTQSBleHRlbnNpb25zIGFjZGZpbQ0KWyAgICAwLjAwMDAwMF0g
cmlzY3Y6IEVMRiBjYXBhYmlsaXRpZXMgYWNkZmltDQpbICAgIDAuMDAwMDAwXSBwZXJjcHU6IEVt
YmVkZGVkIDE4IHBhZ2VzL2NwdSBzMzQ2ODAgcjgxOTIgZDMwODU2IHU3MzcyOA0KWyAgICAwLjAw
MDAwMF0gQnVpbHQgMSB6b25lbGlzdHMsIG1vYmlsaXR5IGdyb3VwaW5nIG9uLiAgVG90YWwgcGFn
ZXM6IDIyNTI4OA0KWyAgICAwLjAwMDAwMF0gS2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD0vZGV2
L25mcyBydyByb290d2FpdCBpcD1kaGNwIG5mc3Jvb3Q9MTkyLjE2OC4xMC4xOi9tbnQvcnpmaXZl
LHZlcnM9NCx0Y3AgY29uc29sZT10dHlTQzAsMTE1MjAwbjggZWFybHljb249c2JpIGRlYnVnIGxv
Z2xldmVsPTcgZGVmZXJyZWRfcHJvYmVfdGltZW91dD01DQpbICAgIDAuMDAwMDAwXSBEZW50cnkg
Y2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMzEwNzIgKG9yZGVyOiA4LCAxMDQ4NTc2IGJ5dGVz
LCBsaW5lYXIpDQpbICAgIDAuMDAwMDAwXSBJbm9kZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6
IDY1NTM2IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzLCBsaW5lYXIpDQpbICAgIDAuMDAwMDAwXSBt
ZW0gYXV0by1pbml0OiBzdGFjazpvZmYsIGhlYXAgYWxsb2M6b2ZmLCBoZWFwIGZyZWU6b2ZmDQpb
ICAgIDAuMDAwMDAwXSBWaXJ0dWFsIGtlcm5lbCBtZW1vcnkgbGF5b3V0Og0KWyAgICAwLjAwMDAw
MF0gICAgICAgZml4bWFwIDogMHhmZmZmZmZjNmZlZTAwMDAwIC0gMHhmZmZmZmZjNmZmMDAwMDAw
ICAgKDIwNDgga0IpDQpbICAgIDAuMDAwMDAwXSAgICAgICBwY2kgaW8gOiAweGZmZmZmZmM2ZmYw
MDAwMDAgLSAweGZmZmZmZmM3MDAwMDAwMDAgICAoICAxNiBNQikNClsgICAgMC4wMDAwMDBdICAg
ICAgdm1lbW1hcCA6IDB4ZmZmZmZmYzcwMDAwMDAwMCAtIDB4ZmZmZmZmYzgwMDAwMDAwMCAgICg0
MDk2IE1CKQ0KWyAgICAwLjAwMDAwMF0gICAgICB2bWFsbG9jIDogMHhmZmZmZmZjODAwMDAwMDAw
IC0gMHhmZmZmZmZkODAwMDAwMDAwICAgKCAgNjQgR0IpDQpbICAgIDAuMDAwMDAwXSAgICAgIG1v
ZHVsZXMgOiAweGZmZmZmZmZmMDEzNjQwMDAgLSAweGZmZmZmZmZmODAwMDAwMDAgICAoMjAyOCBN
QikNClsgICAgMC4wMDAwMDBdICAgICAgIGxvd21lbSA6IDB4ZmZmZmZmZDgwMDAwMDAwMCAtIDB4
ZmZmZmZmZDgzN2UwMDAwMCAgICggODk0IE1CKQ0KWyAgICAwLjAwMDAwMF0gICAgICAga2VybmVs
IDogMHhmZmZmZmZmZjgwMDAwMDAwIC0gMHhmZmZmZmZmZmZmZmZmZmZmICAgKDIwNDcgTUIpDQpb
ICAgIDAuMDAwMDAwXSBNZW1vcnk6IDc0NzgxNksvOTE1NDU2SyBhdmFpbGFibGUgKDczODdLIGtl
cm5lbCBjb2RlLCA0ODk4SyByd2RhdGEsIDQwOTZLIHJvZGF0YSwgMjE5NUsgaW5pdCwgNDY4SyBi
c3MsIDE2NzY0MEsgcmVzZXJ2ZWQsIDBLIGNtYS1yZXNlcnZlZCkNClsgICAgMC4wMDAwMDBdIFNM
VUI6IEhXYWxpZ249NjQsIE9yZGVyPTAtMywgTWluT2JqZWN0cz0wLCBDUFVzPTEsIE5vZGVzPTEN
ClsgICAgMC4wMDAwMDBdIHJjdTogSGllcmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4NClsg
ICAgMC4wMDAwMDBdIHJjdTogICAgIFJDVSByZXN0cmljdGluZyBDUFVzIGZyb20gTlJfQ1BVUz04
IHRvIG5yX2NwdV9pZHM9MS4NClsgICAgMC4wMDAwMDBdIHJjdTogICAgIFJDVSBkZWJ1ZyBleHRl
bmRlZCBRUyBlbnRyeS9leGl0Lg0KWyAgICAwLjAwMDAwMF0gIFRyYWNpbmcgdmFyaWFudCBvZiBU
YXNrcyBSQ1UgZW5hYmxlZC4NClsgICAgMC4wMDAwMDBdIHJjdTogUkNVIGNhbGN1bGF0ZWQgdmFs
dWUgb2Ygc2NoZWR1bGVyLWVubGlzdG1lbnQgZGVsYXkgaXMgMjUgamlmZmllcy4NClsgICAgMC4w
MDAwMDBdIHJjdTogQWRqdXN0aW5nIGdlb21ldHJ5IGZvciByY3VfZmFub3V0X2xlYWY9MTYsIG5y
X2NwdV9pZHM9MQ0KWyAgICAwLjAwMDAwMF0gTlJfSVJRUzogNjQsIG5yX2lycXM6IDY0LCBwcmVh
bGxvY2F0ZWQgaXJxczogMA0KWyAgICAwLjAwMDAwMF0gcmlzY3YtaW50YzogNjQgbG9jYWwgaW50
ZXJydXB0cyBtYXBwZWQNClsgICAgMC4wMDAwMDBdIHBsaWM6IGludGVycnVwdC1jb250cm9sbGVy
QDEyYzAwMDAwOiBtYXBwZWQgNTEyIGludGVycnVwdHMgd2l0aCAxIGhhbmRsZXJzIGZvciAyIGNv
bnRleHRzLg0KWyAgICAwLjAwMDAwMF0gcmN1OiBzcmN1X2luaXQ6IFNldHRpbmcgc3JjdV9zdHJ1
Y3Qgc2l6ZXMgYmFzZWQgb24gY29udGVudGlvbi4NClsgICAgMC4wMDAwMDBdIHJpc2N2LXRpbWVy
OiByaXNjdl90aW1lcl9pbml0X2R0OiBSZWdpc3RlcmluZyBjbG9ja3NvdXJjZSBjcHVpZCBbMF0g
aGFydGlkIFswXQ0KWyAgICAwLjAwMDAwMF0gY2xvY2tzb3VyY2U6IHJpc2N2X2Nsb2Nrc291cmNl
OiBtYXNrOiAweGZmZmZmZmZmZmZmZmZmZmYgbWF4X2N5Y2xlczogMHgyYzQ3ZjRlZTcsIG1heF9p
ZGxlX25zOiA0NDA3OTUyMDI0OTcgbnMNClsgICAgMC4wMDAwMDNdIHNjaGVkX2Nsb2NrOiA2NCBi
aXRzIGF0IDEyTUh6LCByZXNvbHV0aW9uIDgzbnMsIHdyYXBzIGV2ZXJ5IDQzOTgwNDY1MTEwOTZu
cw0KWyAgICAwLjAwODI5Nl0gQ29uc29sZTogY29sb3VyIGR1bW15IGRldmljZSA4MHgyNQ0KWyAg
ICAwLjAxMjY0M10gQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcCAoc2tpcHBlZCksIHZhbHVlIGNhbGN1
bGF0ZWQgdXNpbmcgdGltZXIgZnJlcXVlbmN5Li4gMjQuMDAgQm9nb01JUFMgKGxwaj00ODAwMCkN
ClsgICAgMC4wMjI4MTddIHBpZF9tYXg6IGRlZmF1bHQ6IDMyNzY4IG1pbmltdW06IDMwMQ0KWyAg
ICAwLjAyNzU5N10gTFNNOiBTZWN1cml0eSBGcmFtZXdvcmsgaW5pdGlhbGl6aW5nDQpbICAgIDAu
MDMyMzU2XSBNb3VudC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAyLCAx
NjM4NCBieXRlcywgbGluZWFyKQ0KWyAgICAwLjAzOTU5NV0gTW91bnRwb2ludC1jYWNoZSBoYXNo
IHRhYmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAyLCAxNjM4NCBieXRlcywgbGluZWFyKQ0KWyAg
ICAwLjA1MDM5MV0gY2JsaXN0X2luaXRfZ2VuZXJpYzogU2V0dGluZyBhZGp1c3RhYmxlIG51bWJl
ciBvZiBjYWxsYmFjayBxdWV1ZXMuDQpbICAgIDAuMDU2OTExXSBjYmxpc3RfaW5pdF9nZW5lcmlj
OiBTZXR0aW5nIHNoaWZ0IHRvIDAgYW5kIGxpbSB0byAxLg0KWyAgICAwLjA2MzI2MF0gQVNJRCBh
bGxvY2F0b3IgdXNpbmcgOSBiaXRzICg1MTIgZW50cmllcykNClsgICAgMC4wNjgzMzldIHJjdTog
SGllcmFyY2hpY2FsIFNSQ1UgaW1wbGVtZW50YXRpb24uDQpbICAgIDAuMDcyOTI4XSByY3U6ICAg
ICBNYXggcGhhc2Ugbm8tZGVsYXkgaW5zdGFuY2VzIGlzIDEwMDAuDQpbICAgIDAuMDc4ODA3XSBE
ZXRlY3RlZCBSZW5lc2FzIFJaL0ZpdmUgcjlhMDdnMDQzIFJldiAwDQpbICAgIDAuMDgzMjU2XSBF
Rkkgc2VydmljZXMgd2lsbCBub3QgYmUgYXZhaWxhYmxlLg0KWyAgICAwLjA4ODMwMF0gc21wOiBC
cmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAuLi4NClsgICAgMC4wOTIzNzhdIHNtcDogQnJvdWdo
dCB1cCAxIG5vZGUsIDEgQ1BVDQpbICAgIDAuMDk3MzQ2XSBkZXZ0bXBmczogaW5pdGlhbGl6ZWQN
ClsgICAgMC4xMDczNjRdIERNQTogZGVmYXVsdCBjb2hlcmVudCBhcmVhIGlzIHNldA0KWyAgICAw
LjExMTA0OV0gY2xvY2tzb3VyY2U6IGppZmZpZXM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xl
czogMHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDc2NDUwNDE3ODUxMDAwMDAgbnMNClsgICAgMC4x
MjA3NzVdIGZ1dGV4IGhhc2ggdGFibGUgZW50cmllczogMjU2IChvcmRlcjogMiwgMTYzODQgYnl0
ZXMsIGxpbmVhcikNClsgICAgMC4xMjc5NjVdIHBpbmN0cmwgY29yZTogaW5pdGlhbGl6ZWQgcGlu
Y3RybCBzdWJzeXN0ZW0NClsgICAgMC4xMzQ5NjhdIE5FVDogUmVnaXN0ZXJlZCBQRl9ORVRMSU5L
L1BGX1JPVVRFIHByb3RvY29sIGZhbWlseQ0KWyAgICAwLjE0MDcxM10gRE1BOiBwcmVhbGxvY2F0
ZWQgMTI4IEtpQiBHRlBfS0VSTkVMIHBvb2wgZm9yIGF0b21pYyBhbGxvY2F0aW9ucw0KWyAgICAw
LjE0NzI2NF0gRE1BOiBwcmVhbGxvY2F0ZWQgMTI4IEtpQiBHRlBfS0VSTkVMfEdGUF9ETUEzMiBw
b29sIGZvciBhdG9taWMgYWxsb2NhdGlvbnMNClsgICAgMC4xNTUyNjddIGF1ZGl0OiBpbml0aWFs
aXppbmcgbmV0bGluayBzdWJzeXMgKGRpc2FibGVkKQ0KWyAgICAwLjE2MTU4Ml0gdGhlcm1hbF9z
eXM6IFJlZ2lzdGVyZWQgdGhlcm1hbCBnb3Zlcm5vciAnZmFpcl9zaGFyZScNClsgICAgMC4xNjE2
MDBdIHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJub3IgJ2JhbmdfYmFuZycN
ClsgICAgMC4xNjY5NjddIHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJub3Ig
J3N0ZXBfd2lzZScNClsgICAgMC4xNzI5NzldIHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJt
YWwgZ292ZXJub3IgJ3VzZXJfc3BhY2UnDQpbICAgIDAuMTc5NDQyXSBhdWRpdDogdHlwZT0yMDAw
IGF1ZGl0KDAuMTQ4OjEpOiBzdGF0ZT1pbml0aWFsaXplZCBhdWRpdF9lbmFibGVkPTAgcmVzPTEN
ClsgICAgMC4xOTI5NDhdIGNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIG1lbnUNClsgICAgMC4yMjQw
MzNdIEh1Z2VUTEI6IHJlZ2lzdGVyZWQgMi4wMCBNaUIgcGFnZSBzaXplLCBwcmUtYWxsb2NhdGVk
IDAgcGFnZXMNClsgICAgMC4yMzAxNTZdIEh1Z2VUTEI6IDAgS2lCIHZtZW1tYXAgY2FuIGJlIGZy
ZWVkIGZvciBhIDIuMDAgTWlCIHBhZ2UNClsgICAgMC4yNDA3MjBdIFNDU0kgc3Vic3lzdGVtIGlu
aXRpYWxpemVkDQpbICAgIDAuMjQ0MDQ3XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZh
Y2UgZHJpdmVyIHVzYmZzDQpbICAgIDAuMjQ5MzU1XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBp
bnRlcmZhY2UgZHJpdmVyIGh1Yg0KWyAgICAwLjI1NDY4OV0gdXNiY29yZTogcmVnaXN0ZXJlZCBu
ZXcgZGV2aWNlIGRyaXZlciB1c2INClsgICAgMC4yNjA4NDFdIEFkdmFuY2VkIExpbnV4IFNvdW5k
IEFyY2hpdGVjdHVyZSBEcml2ZXIgSW5pdGlhbGl6ZWQuDQpbICAgIDAuMjY3Nzc2XSBjbG9ja3Nv
dXJjZTogU3dpdGNoZWQgdG8gY2xvY2tzb3VyY2UgcmlzY3ZfY2xvY2tzb3VyY2UNClsgICAgMC4y
ODY2NTFdIE5FVDogUmVnaXN0ZXJlZCBQRl9JTkVUIHByb3RvY29sIGZhbWlseQ0KWyAgICAwLjI5
MTEyNF0gSVAgaWRlbnRzIGhhc2ggdGFibGUgZW50cmllczogMTYzODQgKG9yZGVyOiA1LCAxMzEw
NzIgYnl0ZXMsIGxpbmVhcikNClsgICAgMC4zMDAyNzVdIHRjcF9saXN0ZW5fcG9ydGFkZHJfaGFz
aCBoYXNoIHRhYmxlIGVudHJpZXM6IDUxMiAob3JkZXI6IDIsIDE2Mzg0IGJ5dGVzLCBsaW5lYXIp
DQpbICAgIDAuMzA4MDkyXSBUYWJsZS1wZXJ0dXJiIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYg
KG9yZGVyOiA2LCAyNjIxNDQgYnl0ZXMsIGxpbmVhcikNClsgICAgMC4zMTU3MjVdIFRDUCBlc3Rh
Ymxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6IDgxOTIgKG9yZGVyOiA0LCA2NTUzNiBieXRlcywg
bGluZWFyKQ0KWyAgICAwLjMyMzU2Ml0gVENQIGJpbmQgaGFzaCB0YWJsZSBlbnRyaWVzOiA4MTky
IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzLCBsaW5lYXIpDQpbICAgIDAuMzMxODUyXSBUQ1A6IEhh
c2ggdGFibGVzIGNvbmZpZ3VyZWQgKGVzdGFibGlzaGVkIDgxOTIgYmluZCA4MTkyKQ0KWyAgICAw
LjMzNzY2Ml0gVURQIGhhc2ggdGFibGUgZW50cmllczogNTEyIChvcmRlcjogMywgNDkxNTIgYnl0
ZXMsIGxpbmVhcikNClsgICAgMC4zNDQyOTddIFVEUC1MaXRlIGhhc2ggdGFibGUgZW50cmllczog
NTEyIChvcmRlcjogMywgNDkxNTIgYnl0ZXMsIGxpbmVhcikNClsgICAgMC4zNTE2NDRdIE5FVDog
UmVnaXN0ZXJlZCBQRl9VTklYL1BGX0xPQ0FMIHByb3RvY29sIGZhbWlseQ0KWyAgICAwLjM1ODA4
MV0gUlBDOiBSZWdpc3RlcmVkIG5hbWVkIFVOSVggc29ja2V0IHRyYW5zcG9ydCBtb2R1bGUuDQpb
ICAgIDAuMzYzMjI5XSBSUEM6IFJlZ2lzdGVyZWQgdWRwIHRyYW5zcG9ydCBtb2R1bGUuDQpbICAg
IDAuMzY4MDYzXSBSUEM6IFJlZ2lzdGVyZWQgdGNwIHRyYW5zcG9ydCBtb2R1bGUuDQpbICAgIDAu
MzcyNzU2XSBSUEM6IFJlZ2lzdGVyZWQgdGNwIE5GU3Y0LjEgYmFja2NoYW5uZWwgdHJhbnNwb3J0
IG1vZHVsZS4NClsgICAgMC4zODE1MDBdIHdvcmtpbmdzZXQ6IHRpbWVzdGFtcF9iaXRzPTQ2IG1h
eF9vcmRlcj0xOCBidWNrZXRfb3JkZXI9MA0KWyAgICAwLjQwMDExOF0gTkZTOiBSZWdpc3Rlcmlu
ZyB0aGUgaWRfcmVzb2x2ZXIga2V5IHR5cGUNClsgICAgMC40MDQ1OThdIEtleSB0eXBlIGlkX3Jl
c29sdmVyIHJlZ2lzdGVyZWQNClsgICAgMC40MDg2MzddIEtleSB0eXBlIGlkX2xlZ2FjeSByZWdp
c3RlcmVkDQpbICAgIDAuNDEyODk4XSBuZnM0ZmlsZWxheW91dF9pbml0OiBORlN2NCBGaWxlIExh
eW91dCBEcml2ZXIgUmVnaXN0ZXJpbmcuLi4NClsgICAgMC40MTk0MzldIG5mczRmbGV4ZmlsZWxh
eW91dF9pbml0OiBORlN2NCBGbGV4ZmlsZSBMYXlvdXQgRHJpdmVyIFJlZ2lzdGVyaW5nLi4uDQpb
ICAgIDAuNDI2OTU2XSBqZmZzMjogdmVyc2lvbiAyLjIuIChOQU5EKSDDgsKpIDIwMDEtMjAwNiBS
ZWQgSGF0LCBJbmMuDQpbICAgIDAuNDM0Mzc2XSBORVQ6IFJlZ2lzdGVyZWQgUEZfQUxHIHByb3Rv
Y29sIGZhbWlseQ0KWyAgICAwLjQzODQ4OV0gQmxvY2sgbGF5ZXIgU0NTSSBnZW5lcmljIChic2cp
IGRyaXZlciB2ZXJzaW9uIDAuNCBsb2FkZWQgKG1ham9yIDI0OCkNClsgICAgMC40NDU4OThdIGlv
IHNjaGVkdWxlciBtcS1kZWFkbGluZSByZWdpc3RlcmVkDQpbICAgIDAuNDUwNDI4XSBpbyBzY2hl
ZHVsZXIga3liZXIgcmVnaXN0ZXJlZA0KWyAgICAwLjU1MTQxMV0gU3VwZXJIIChIKVNDSShGKSBk
cml2ZXIgaW5pdGlhbGl6ZWQNClsgICAgMC41NTYwMThdIGNhY2hlaW5mbzogVW5hYmxlIHRvIGRl
dGVjdCBjYWNoZSBoaWVyYXJjaHkgZm9yIENQVSAwDQpbICAgIDAuNTcxMTY2XSBsb29wOiBtb2R1
bGUgbG9hZGVkDQpbICAgIDAuNTc3MDIxXSBDQU4gZGV2aWNlIGRyaXZlciBpbnRlcmZhY2UNClsg
ICAgMC41ODA3MjBdIGVoY2lfaGNkOiBVU0IgMi4wICdFbmhhbmNlZCcgSG9zdCBDb250cm9sbGVy
IChFSENJKSBEcml2ZXINClsgICAgMC41ODY2NTddIGVoY2ktcGxhdGZvcm06IEVIQ0kgZ2VuZXJp
YyBwbGF0Zm9ybSBkcml2ZXINClsgICAgMC41OTIxNTNdIG9oY2lfaGNkOiBVU0IgMS4xICdPcGVu
JyBIb3N0IENvbnRyb2xsZXIgKE9IQ0kpIERyaXZlcg0KWyAgICAwLjU5ODE4M10gb2hjaS1wbGF0
Zm9ybTogT0hDSSBnZW5lcmljIHBsYXRmb3JtIGRyaXZlcg0KWyAgICAwLjYwNDQ1Ml0gdXNiY29y
ZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1YXMNClsgICAgMC42MDkxMTJdIHVz
YmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiLXN0b3JhZ2UNClsgICAg
MC42MTYxNDBdIG1vdXNlZGV2OiBQUy8yIG1vdXNlIGRldmljZSBjb21tb24gZm9yIGFsbCBtaWNl
DQpbICAgIDAuNjIxMzQ3XSBpMmNfZGV2OiBpMmMgL2RldiBlbnRyaWVzIGRyaXZlcg0KWyAgICAw
Ljc0NDYyNl0gc2RoY2k6IFNlY3VyZSBEaWdpdGFsIEhvc3QgQ29udHJvbGxlciBJbnRlcmZhY2Ug
ZHJpdmVyDQpbICAgIDAuNzUwMDkwXSBzZGhjaTogQ29weXJpZ2h0KGMpIFBpZXJyZSBPc3NtYW4N
ClsgICAgMC43NTQ3ODJdIHNkaGNpLXBsdGZtOiBTREhDSSBwbGF0Zm9ybSBhbmQgT0YgZHJpdmVy
IGhlbHBlcg0KWyAgICAwLjc2MDU2N10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNl
IGRyaXZlciB1c2JoaWQNClsgICAgMC43NjU3NTZdIHVzYmhpZDogVVNCIEhJRCBjb3JlIGRyaXZl
cg0KWyAgICAwLjc3MDUyOV0gcmlzY3YtcG11LXNiaTogU0JJIFBNVSBleHRlbnNpb24gaXMgYXZh
aWxhYmxlDQpbICAgIDAuNzc1MjIzXSByaXNjdi1wbXUtc2JpOiAxNSBmaXJtd2FyZSBhbmQgNiBo
YXJkd2FyZSBjb3VudGVycw0KWyAgICAwLjc4MTA0OV0gcmlzY3YtcG11LXNiaTogUGVyZiBzYW1w
bGluZy9maWx0ZXJpbmcgaXMgbm90IHN1cHBvcnRlZCBhcyBzc2NvZiBleHRlbnNpb24gaXMgbm90
IGF2YWlsYWJsZQ0KWyAgICAwLjc5MzQ3MF0gTkVUOiBSZWdpc3RlcmVkIFBGX0lORVQ2IHByb3Rv
Y29sIGZhbWlseQ0KWyAgICAwLjc5OTY4Ml0gU2VnbWVudCBSb3V0aW5nIHdpdGggSVB2Ng0KWyAg
ICAwLjgwMjY0OV0gSW4tc2l0dSBPQU0gKElPQU0pIHdpdGggSVB2Ng0KWyAgICAwLjgwNjczN10g
c2l0OiBJUHY2LCBJUHY0IGFuZCBNUExTIG92ZXIgSVB2NCB0dW5uZWxpbmcgZHJpdmVyDQpbICAg
IDAuODEzNDgwXSBORVQ6IFJlZ2lzdGVyZWQgUEZfUEFDS0VUIHByb3RvY29sIGZhbWlseQ0KWyAg
ICAwLjgxNzc3N10gY2FuOiBjb250cm9sbGVyIGFyZWEgbmV0d29yayBjb3JlDQpbICAgIDAuODIy
NDY1XSBORVQ6IFJlZ2lzdGVyZWQgUEZfQ0FOIHByb3RvY29sIGZhbWlseQ0KWyAgICAwLjgyNzAz
N10gY2FuOiByYXcgcHJvdG9jb2wNClsgICAgMC44MzAwNjZdIGNhbjogYnJvYWRjYXN0IG1hbmFn
ZXIgcHJvdG9jb2wNClsgICAgMC44MzQyNzJdIGNhbjogbmV0bGluayBnYXRld2F5IC0gbWF4X2hv
cHM9MQ0KWyAgICAwLjgzODg1MF0gY2FuOiBpc290cCBwcm90b2NvbA0KWyAgICAwLjg0MjAzN10g
S2V5IHR5cGUgZG5zX3Jlc29sdmVyIHJlZ2lzdGVyZWQNClsgICAgMC44NDczNDddIGRlYnVnX3Zt
X3BndGFibGU6IFtkZWJ1Z192bV9wZ3RhYmxlICAgICAgICAgXTogVmFsaWRhdGluZyBhcmNoaXRl
Y3R1cmUgcGFnZSB0YWJsZSBoZWxwZXJzDQpbICAgIDAuODczMzgwXSBncGlvLTM3OCAoY2FuMF9z
dGIpOiBob2dnZWQgYXMgb3V0cHV0L2xvdw0KWyAgICAwLjg3NzY5NF0gZ3Bpby0zNzkgKGNhbjFf
c3RiKTogaG9nZ2VkIGFzIG91dHB1dC9sb3cNClsgICAgMC44ODI5MTBdIGdwaW8tMzYzIChzZDFf
cHdyX2VuKTogaG9nZ2VkIGFzIG91dHB1dC9oaWdoDQpbICAgIDAuODg4OTQ4XSBwaW5jdHJsLXJ6
ZzJsIDExMDMwMDAwLnBpbmN0cmw6IHBpbmN0cmwtcnpnMmwgc3VwcG9ydCByZWdpc3RlcmVkDQpb
ICAgIDAuOTAwMDQxXSAxMDA0YjgwMC5zZXJpYWw6IHR0eVNDMCBhdCBNTUlPIDB4MTAwNGI4MDAg
KGlycSA9IDIzLCBiYXNlX2JhdWQgPSAwKSBpcyDDoVsgICAgMC45MDc2ODddIHByaW50azogY29u
c29sZSBbdHR5U0MwXSBlbmFibGVkDQpbICAgIDAuOTA3Njg3XSBwcmludGs6IGNvbnNvbGUgW3R0
eVNDMF0gZW5hYmxlZA0KWyAgICAwLjkxNTQ2MF0gcHJpbnRrOiBib290Y29uc29sZSBbc2JpMF0g
ZGlzYWJsZWQNClsgICAgMC45MTU0NjBdIHByaW50azogYm9vdGNvbnNvbGUgW3NiaTBdIGRpc2Fi
bGVkDQpbICAgIDAuOTI2NDQyXSByZW5lc2FzX3NwaSAxMDA0YjAwMC5zcGk6IERNQSBhdmFpbGFi
bGUNClsgICAgMC45MzIwNjRdIHJlbmVzYXNfc3BpIDEwMDRiMDAwLnNwaTogcHJvYmVkDQpbICAg
IDAuOTM5ODY5XSByY2FyX2NhbmZkIDEwMDUwMDAwLmNhbjogY2FuX2NsayByYXRlIGlzIDUwMDAw
MDAwDQpbICAgIDAuOTQ2NjU4XSByY2FyX2NhbmZkIDEwMDUwMDAwLmNhbjogZGV2aWNlIHJlZ2lz
dGVyZWQgKGNoYW5uZWwgMCkNClsgICAgMC45NTI5NTFdIHJjYXJfY2FuZmQgMTAwNTAwMDAuY2Fu
OiBjYW5fY2xrIHJhdGUgaXMgNTAwMDAwMDANClsgICAgMC45NTk2NjBdIHJjYXJfY2FuZmQgMTAw
NTAwMDAuY2FuOiBkZXZpY2UgcmVnaXN0ZXJlZCAoY2hhbm5lbCAxKQ0KWyAgICAwLjk2NTkwMl0g
cmNhcl9jYW5mZCAxMDA1MDAwMC5jYW46IGdsb2JhbCBvcGVyYXRpb25hbCBzdGF0ZSAoY2xrIDAs
IGZkbW9kZSAxKQ0KWyAgICAwLjk3NzYxMF0gcmF2YiAxMWMzMDAwMC5ldGhlcm5ldCBldGgwOiBC
YXNlIGFkZHJlc3MgYXQgMHgxMWMzMDAwMCwgNzA6YjM6ZDU6MWE6NzA6MDYsIElSUSAzNS4NClsg
ICAgMC45ODc4MjZdIHJlbmVzYXNfdXNiaHMgMTFjNjAwMDAudXNiOiBob3N0IHByb2JlZA0KWyAg
ICAwLjk5MjczOF0gcmVuZXNhc191c2JocyAxMWM2MDAwMC51c2I6IG5vIHRyYW5zY2VpdmVyIGZv
dW5kDQpbICAgIDAuOTk4NjU0XSByZW5lc2FzX3VzYmhzIDExYzYwMDAwLnVzYjogZ2FkZ2V0IHBy
b2JlZA0KWyAgICAxLjAwNTY4OV0gZWhjaS1wbGF0Zm9ybSAxMWM3MDEwMC51c2I6IEVIQ0kgSG9z
dCBDb250cm9sbGVyDQpbICAgIDEuMDExNDYxXSBlaGNpLXBsYXRmb3JtIDExYzcwMTAwLnVzYjog
bmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAxDQpbICAgIDEuMDE5
NjkwXSBlaGNpLXBsYXRmb3JtIDExYzcwMTAwLnVzYjogaXJxIDM4LCBpbyBtZW0gMHgxMWM3MDEw
MA0KWyAgICAxLjAyNzU5MF0gb2hjaS1wbGF0Zm9ybSAxMWM3MDAwMC51c2I6IEdlbmVyaWMgUGxh
dGZvcm0gT0hDSSBjb250cm9sbGVyDQpbICAgIDEuMDM0NDU1XSBvaGNpLXBsYXRmb3JtIDExYzcw
MDAwLnVzYjogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAyDQpb
ICAgIDEuMDQyNTYwXSBvaGNpLXBsYXRmb3JtIDExYzcwMDAwLnVzYjogaXJxIDQwLCBpbyBtZW0g
MHgxMWM3MDAwMA0KWyAgICAxLjA0ODc1M10gZWhjaS1wbGF0Zm9ybSAxMWM1MDEwMC51c2I6IEVI
Q0kgSG9zdCBDb250cm9sbGVyDQpbICAgIDEuMDU0NDI0XSBlaGNpLXBsYXRmb3JtIDExYzUwMTAw
LnVzYjogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAzDQpbICAg
IDEuMDYyNjMzXSBlaGNpLXBsYXRmb3JtIDExYzUwMTAwLnVzYjogaXJxIDM3LCBpbyBtZW0gMHgx
MWM1MDEwMA0KWyAgICAxLjA2ODkzNF0gb2hjaS1wbGF0Zm9ybSAxMWM1MDAwMC51c2I6IEdlbmVy
aWMgUGxhdGZvcm0gT0hDSSBjb250cm9sbGVyDQpbICAgIDEuMDc1Njc2XSBvaGNpLXBsYXRmb3Jt
IDExYzUwMDAwLnVzYjogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJl
ciA0DQpbICAgIDEuMDgzNzQ5XSBvaGNpLXBsYXRmb3JtIDExYzUwMDAwLnVzYjogaXJxIDM5LCBp
byBtZW0gMHgxMWM1MDAwMA0KWyAgICAxLjA5MDEyNV0gcmVuZXNhc191c2JocyAxMWM2MDAwMC51
c2I6IHByb2JlZA0KWyAgICAxLjA5NjQ0Nl0gZWhjaS1wbGF0Zm9ybSAxMWM3MDEwMC51c2I6IFVT
QiAyLjAgc3RhcnRlZCwgRUhDSSAxLjEwDQpbICAgIDEuMTAyOTExXSBpMmMtcmlpYyAxMDA1ODAw
MC5pMmM6IHJlZ2lzdGVyZWQgd2l0aCAxMDAwMDBIeiBidXMgc3BlZWQNClsgICAgMS4xMTIyODNd
IGh1YiAxLTA6MS4wOiBVU0IgaHViIGZvdW5kDQpbICAgIDEuMTQ2MjY2XSBlaGNpLXBsYXRmb3Jt
IDExYzUwMTAwLnVzYjogVVNCIDIuMCBzdGFydGVkLCBFSENJIDEuMTANClsgICAgMS4xODMzMTVd
IGh1YiAxLTA6MS4wOiAxIHBvcnQgZGV0ZWN0ZWQNClsgICAgMS4xODc0NTZdIGkyYy1yaWljIDEw
MDU4NDAwLmkyYzogcmVnaXN0ZXJlZCB3aXRoIDEwMDAwMEh6IGJ1cyBzcGVlZA0KWyAgICAxLjE5
Njc2OF0gcnotc3NpLXBjbS1hdWRpbyAxMDA0YTAwMC5zc2k6IERNQSBlbmFibGVkDQpbICAgIDEu
MjA5NTQ5XSBodWIgMy0wOjEuMDogVVNCIGh1YiBmb3VuZA0KWyAgICAxLjIxMzQ2Nl0gaHViIDMt
MDoxLjA6IDEgcG9ydCBkZXRlY3RlZA0KWyAgICAxLjIxOTY0NV0gaHViIDItMDoxLjA6IFVTQiBo
dWIgZm91bmQNClsgICAgMS4yMjM2ODJdIGh1YiAyLTA6MS4wOiAxIHBvcnQgZGV0ZWN0ZWQNClsg
ICAgMS4yMzIwMTRdIGh1YiA0LTA6MS4wOiBVU0IgaHViIGZvdW5kDQpbICAgIDEuMjM2NDkyXSBo
dWIgNC0wOjEuMDogMSBwb3J0IGRldGVjdGVkDQpbICAgIDEuMzgwMjk0XSByZW5lc2FzX3NkaGlf
aW50ZXJuYWxfZG1hYyAxMWMwMDAwMC5tbWM6IG1tYzAgYmFzZSBhdCAweDAwMDAwMDAwMTFjMDAw
MDAsIG1heCBjbG9jayByYXRlIDEzMyBNSHoNClsgICAgMS4zOTA5NjldIHJlbmVzYXNfc2RoaV9p
bnRlcm5hbF9kbWFjIDExYzEwMDAwLm1tYzogbW1jMSBiYXNlIGF0IDB4MDAwMDAwMDAxMWMxMDAw
MCwgbWF4IGNsb2NrIHJhdGUgMTMzIE1Ieg0KWyAgICAxLjQ2Nzg4NF0gTWljcm9jaGlwIEtTWjkx
MzEgR2lnYWJpdCBQSFkgMTFjMzAwMDAuZXRoZXJuZXQtZmZmZmZmZmY6MDc6IGF0dGFjaGVkIFBI
WSBkcml2ZXIgKG1paV9idXM6cGh5X2FkZHI9MTFjMzAwMDAuZXRoZXJuZXQtZmZmZmZmZmY6MDcs
IGlycT1QT0xMKQ0KWyAgICAxLjY0MTQ5OV0gbW1jMDogbmV3IEhTMjAwIE1NQyBjYXJkIGF0IGFk
ZHJlc3MgMDAwMQ0KWyAgICAxLjY0NzU1MV0gbW1jYmxrMDogbW1jMDowMDAxIEcxTTE1TSA1OS4z
IEdpQg0KWyAgICAxLjY1NDYxNl0gIG1tY2JsazA6IHAxDQpbICAgIDEuNjU4MDIwXSBtbWNibGsw
Ym9vdDA6IG1tYzA6MDAwMSBHMU0xNU0gMzEuNSBNaUINClsgICAgMS42NjQ5MDRdIG1tY2JsazBi
b290MTogbW1jMDowMDAxIEcxTTE1TSAzMS41IE1pQg0KWyAgICAxLjY3MTgwNF0gbW1jYmxrMHJw
bWI6IG1tYzA6MDAwMSBHMU0xNU0gNC4wMCBNaUIsIGNoYXJkZXYgKDI0NzowKQ0KWyAgICAxLjY5
OTc3Nl0gdXNiIDMtMTogbmV3IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyBl
aGNpLXBsYXRmb3JtDQpbICAgIDEuODc0MjYzXSB1c2Itc3RvcmFnZSAzLTE6MS4wOiBVU0IgTWFz
cyBTdG9yYWdlIGRldmljZSBkZXRlY3RlZA0KWyAgICAxLjg4MTM0MF0gc2NzaSBob3N0MDogdXNi
LXN0b3JhZ2UgMy0xOjEuMA0KWyAgICAyLjA5MTQ0Nl0gbW1jMTogbmV3IHVsdHJhIGhpZ2ggc3Bl
ZWQgU0RSMTA0IFNESEMgY2FyZCBhdCBhZGRyZXNzIGFhYWENClsgICAgMi4wOTkwNzddIG1tY2Js
azE6IG1tYzE6YWFhYSBTQzE2RyAxNC44IEdpQg0KWyAgICAyLjEwOTEzNl0gIG1tY2JsazE6IHAx
IHAyDQpbICAgIDIuOTE3MjEzXSBzY3NpIDA6MDowOjA6IERpcmVjdC1BY2Nlc3MgICAgIEdlbmVy
YWwgIFVTQiBGbGFzaCBEaXNrICAgMS4wMCBQUTogMCBBTlNJOiAyDQpbICAgIDIuOTI3NTU1XSBz
ZCAwOjA6MDowOiBbc2RhXSA3ODMxNTUyIDUxMi1ieXRlIGxvZ2ljYWwgYmxvY2tzOiAoNC4wMSBH
Qi8zLjczIEdpQikNClsgICAgMi45MzU5MjNdIHNkIDA6MDowOjA6IFtzZGFdIFdyaXRlIFByb3Rl
Y3QgaXMgb2ZmDQpbICAgIDIuOTQxNDExXSBzZCAwOjA6MDowOiBbc2RhXSBObyBDYWNoaW5nIG1v
ZGUgcGFnZSBmb3VuZA0KWyAgICAyLjk0Njc4Nl0gc2QgMDowOjA6MDogW3NkYV0gQXNzdW1pbmcg
ZHJpdmUgY2FjaGU6IHdyaXRlIHRocm91Z2gNClsgICAgMi45NTc4NjldICBzZGE6IHNkYTEgc2Rh
Mg0KWyAgICAyLjk2MTg4OV0gc2QgMDowOjA6MDogW3NkYV0gQXR0YWNoZWQgU0NTSSByZW1vdmFi
bGUgZGlzaw0KWyAgICA1LjU3Mzc1MF0gcmF2YiAxMWMzMDAwMC5ldGhlcm5ldCBldGgwOiBMaW5r
IGlzIFVwIC0gMUdicHMvRnVsbCAtIGZsb3cgY29udHJvbCBvZmYNClsgICAgNS41ODE0NTldIElQ
djY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBldGgwOiBsaW5rIGJlY29tZXMgcmVhZHkNClsg
ICAgNS42MDc3NzZdIFNlbmRpbmcgREhDUCByZXF1ZXN0cyAuLCBPSw0KWyAgICA1LjYyNzYzN10g
SVAtQ29uZmlnOiBHb3QgREhDUCBhbnN3ZXIgZnJvbSAxOTIuMTY4LjEwLjEsIG15IGFkZHJlc3Mg
aXMgMTkyLjE2OC4xMC45Ng0KWyAgICA1LjYzNTQ5MF0gSVAtQ29uZmlnOiBDb21wbGV0ZToNClsg
ICAgNS42Mzg3MDVdICAgICAgZGV2aWNlPWV0aDAsIGh3YWRkcj03MDpiMzpkNToxYTo3MDowNiwg
aXBhZGRyPTE5Mi4xNjguMTAuOTYsIG1hc2s9MjU1LjI1NS4yNTUuMCwgZ3c9MTkyLjE2OC4xMC4x
DQpbICAgIDUuNjQ4OTY1XSAgICAgIGhvc3Q9MTkyLjE2OC4xMC45NiwgZG9tYWluPWV4YW1wbGUu
b3JnLCBuaXMtZG9tYWluPShub25lKQ0KWyAgICA1LjY1NTgzNl0gICAgICBib290c2VydmVyPTE5
Mi4xNjguMTAuMSwgcm9vdHNlcnZlcj0xOTIuMTY4LjEwLjEsIHJvb3RwYXRoPQ0KWyAgICA1LjY1
NTg0N10gICAgICBuYW1lc2VydmVyMD0xOTIuMTY4LjEwLjENClsgICAgNS42NjcyNTBdIEFMU0Eg
ZGV2aWNlIGxpc3Q6DQpbICAgIDUuNjcwMjU1XSAgICMwOiByei1zc2ktZGFpLXdtODk3OC1oaWZp
DQpbICAgIDUuNzE1MjM1XSBWRlM6IE1vdW50ZWQgcm9vdCAobmZzNCBmaWxlc3lzdGVtKSBvbiBk
ZXZpY2UgMDoxNy4NClsgICAgNS43MjI2MjZdIGRldnRtcGZzOiBtb3VudGVkDQpbICAgIDUuNzI2
ODc1XSBGcmVlaW5nIHVudXNlZCBrZXJuZWwgaW1hZ2UgKGluaXRtZW0pIG1lbW9yeTogMjE5MksN
ClsgICAgNS43NDM3OTBdIFJ1biAvc2Jpbi9pbml0IGFzIGluaXQgcHJvY2Vzcw0KWyAgICA2LjY1
Mjg1OV0gc3lzdGVtZFsxXTogU3lzdGVtIHRpbWUgYmVmb3JlIGJ1aWxkIHRpbWUsIGFkdmFuY2lu
ZyBjbG9jay4NClsgICAgNi43ODQxNjldIHN5c3RlbWRbMV06IHN5c3RlbWQgMjQ0IHJ1bm5pbmcg
aW4gc3lzdGVtIG1vZGUuICgrUEFNIC1BVURJVCAtU0VMSU5VWCArSU1BIC1BUFBBUk1PUiAtU01B
Q0sgK1NZU1ZJTklUICtVVE1QIC1MSUJDUllQVFNFVFVQIC1HQ1JZUFQgLUdOVVRMUyArQUNMICtY
WiAtTFo0IC1TRUNDT01QICtCTEtJRCAtRUxGVVRJTFMgK0tNT0QgLUlETjIgLUlETiAtUENSRTIg
ZGVmYXVsdC1oaWVyYXJjaHk9aHlicmlkKQ0KWyAgICA2LjgwNjExOF0gc3lzdGVtZFsxXTogRGV0
ZWN0ZWQgYXJjaGl0ZWN0dXJlIHJpc2N2NjQuDQoNCldlbGNvbWUgdG8gT3BlbkVtYmVkZGVkIG5v
ZGlzdHJvLjAhDQoNClsgICAgNi44NDQzODFdIHN5c3RlbWRbMV06IFNldCBob3N0bmFtZSB0byA8
c21hcmMtcnpmaXZlPi4NClsgICAxMC4wMzU3NjhdIHJhbmRvbTogY3JuZyBpbml0IGRvbmUNClsg
IE9LICBdIENyZWF0ZWQgc2xpY2Ugc3lzdGVtLWdldHR5LnNsaWNlLg0KWyAgT0sgIF0gQ3JlYXRl
ZCBzbGljZSBzeXN0ZW0tc2VyaWFsXHgyZGdldHR5LnNsaWNlLg0KWyAgT0sgIF0gQ3JlYXRlZCBz
bGljZSBVc2VyIGFuZCBTZXNzaW9uIFNsaWNlLg0KWyAgT0sgIF0gU3RhcnRlZCBEaXNwYXRjaCBQ
YXNzd29yZCDDouKCrMKmdHMgdG8gQ29uc29sZSBEaXJlY3RvcnkgV2F0Y2guDQpbICBPSyAgXSBT
dGFydGVkIEZvcndhcmQgUGFzc3dvcmQgUsOi4oKswqZ1ZXN0cyB0byBXYWxsIERpcmVjdG9yeSBX
YXRjaC4NClsgIE9LICBdIFJlYWNoZWQgdGFyZ2V0IFBhdGhzLg0KWyAgT0sgIF0gUmVhY2hlZCB0
YXJnZXQgUmVtb3RlIEZpbGUgU3lzdGVtcy4NClsgIE9LICBdIFJlYWNoZWQgdGFyZ2V0IFNsaWNl
cy4NClsgIE9LICBdIFJlYWNoZWQgdGFyZ2V0IFN3YXAuDQpbICBPSyAgXSBMaXN0ZW5pbmcgb24g
U3lzbG9nIFNvY2tldC4NClsgIE9LICBdIExpc3RlbmluZyBvbiBpbml0Y3RsIENvbXBhdGliaWxp
dHkgTmFtZWQgUGlwZS4NClsgIE9LICBdIExpc3RlbmluZyBvbiBKb3VybmFsIEF1ZGl0IFNvY2tl
dC4NClsgIE9LICBdIExpc3RlbmluZyBvbiBKb3VybmFsIFNvY2tldCAoL2Rldi9sb2cpLg0KWyAg
T0sgIF0gTGlzdGVuaW5nIG9uIEpvdXJuYWwgU29ja2V0Lg0KWyAgT0sgIF0gTGlzdGVuaW5nIG9u
IE5ldHdvcmsgU2VydmljZSBOZXRsaW5rIFNvY2tldC4NClsgIE9LICBdIExpc3RlbmluZyBvbiB1
ZGV2IENvbnRyb2wgU29ja2V0Lg0KWyAgT0sgIF0gTGlzdGVuaW5nIG9uIHVkZXYgS2VybmVsIFNv
Y2tldC4NCiAgICAgICAgIE1vdW50aW5nIEh1Z2UgUGFnZXMgRmlsZSBTeXN0ZW0uLi4NCiAgICAg
ICAgIE1vdW50aW5nIFBPU0lYIE1lc3NhZ2UgUXVldWUgRmlsZSBTeXN0ZW0uLi4NCiAgICAgICAg
IE1vdW50aW5nIEtlcm5lbCBEZWJ1ZyBGaWxlIFN5c3RlbS4uLg0KICAgICAgICAgTW91bnRpbmcg
VGVtcG9yYXJ5IERpcmVjdG9yeSAoL3RtcCkuLi4NCiAgICAgICAgIFN0YXJ0aW5nIEpvdXJuYWwg
U2VydmljZS4uLg0KICAgICAgICAgTW91bnRpbmcgS2VybmVsIENvbmZpZ3VyYXRpb24gRmlsZSBT
eXN0ZW0uLi4NCiAgICAgICAgIFN0YXJ0aW5nIFJlbW91bnQgUm9vdCBhbmQgS2VybmVsIEZpbGUg
U3lzdGVtcy4uLg0KICAgICAgICAgU3RhcnRpbmcgQXBwbHkgS2VybmVsIFZhcmlhYmxlcy4uLg0K
ICAgICAgICAgU3RhcnRpbmcgdWRldiBDb2xkcGx1ZyBhbGwgRGV2aWNlcy4uLg0KWyAgT0sgIF0g
TW91bnRlZCBIdWdlIFBhZ2VzIEZpbGUgU3lzdGVtLg0KWyAgT0sgIF0gTW91bnRlZCBQT1NJWCBN
ZXNzYWdlIFF1ZXVlIEZpbGUgU3lzdGVtLg0KWyAgT0sgIF0gTW91bnRlZCBLZXJuZWwgRGVidWcg
RmlsZSBTeXN0ZW0uDQpbICBPSyAgXSBNb3VudGVkIFRlbXBvcmFyeSBEaXJlY3RvcnkgKC90bXAp
Lg0KWyAgT0sgIF0gTW91bnRlZCBLZXJuZWwgQ29uZmlndXJhdGlvbiBGaWxlIFN5c3RlbS4NClsg
IE9LICBdIFN0YXJ0ZWQgUmVtb3VudCBSb290IGFuZCBLZXJuZWwgRmlsZSBTeXN0ZW1zLg0KICAg
ICAgICAgU3RhcnRpbmcgQ3JlYXRlIFN0YXRpYyBEZXZpY2UgTm9kZXMgaW4gL2Rldi4uLg0KWyAg
T0sgIF0gU3RhcnRlZCBBcHBseSBLZXJuZWwgVmFyaWFibGVzLg0KWyAgT0sgIF0gU3RhcnRlZCBD
cmVhdGUgU3RhdGljIERldmljZSBOb2RlcyBpbiAvZGV2Lg0KWyAgT0sgIF0gUmVhY2hlZCB0YXJn
ZXQgTG9jYWwgRmlsZSBTeXN0ZW1zIChQcmUpLg0KICAgICAgICAgTW91bnRpbmcgL3Zhci92b2xh
dGlsZS4uLg0KWyAgIDExLjQ2NDgxOF0gYXVkaXQ6IHR5cGU9MTMzNCBhdWRpdCgxNjYwNzU3OTEw
LjgwNzoyKTogcHJvZy1pZD01IG9wPUxPQUQNCiAgICAgICAgIFN0YXJ0aW5nIHVkZXYgS2VybmVs
IERbICAgMTEuNDk1OTk0XSBhdWRpdDogdHlwZT0xMzM0IGF1ZGl0KDE2NjA3NTc5MTAuODI3OjMp
OiBwcm9nLWlkPTYgb3A9TE9BRA0KZXZpY2UgTWFuYWdlci4uLg0KWyAgT0sgIF0gU3RhcnRlZCBK
b3VybmFsIFNlcnZpY2UuDQogICAgICAgICBTdGFydGluZyBGbHVzaCBKb3VybmFsIHRvIFBlcnNp
c3RlbnQgU3RvcmFnZS4uLg0KWyAgT0sgIF0gTW91bnRlZCAvdmFyL3ZvbGF0aWxlLg0KWyAgIDEx
Ljc2NTAzMF0gc3lzdGVtZC1qb3VybmFsZFs5N106IFJlY2VpdmVkIGNsaWVudCByZXF1ZXN0IHRv
IGZsdXNoIHJ1bnRpbWUgam91cm5hbC4NCiAgICAgICAgIFN0YXJ0aW5nIExvYWQvU2F2ZSBSYW5k
b20gU2VlZC4uLg0KWyAgT0sgIF0gUmVhY2hlZCB0YXJnZXQgTG9jYWwgRmlsZSBTeXN0ZW1zLg0K
WyAgT0sgIF0gU3RhcnRlZCBGbHVzaCBKb3VybmFsIHRvIFBlcnNpc3RlbnQgU3RvcmFnZS4NCiAg
ICAgICAgIFN0YXJ0aW5nIENyZWF0ZSBWb2xhdGlsZSBGaWxlcyBhbmQgRGlyZWN0b3JpZXMuLi4N
ClsgIE9LICBdIFN0YXJ0ZWQgTG9hZC9TYXZlIFJhbmRvbSBTZWVkLg0KWyAgT0sgIF0gU3RhcnRl
ZCB1ZGV2IEtlcm5lbCBEZXZpY2UgTWFuYWdlci4NCiAgICAgICAgIFN0YXJ0aW5nIE5ldHdvcmsg
U2VydmljZS4uLg0KWyAgT0sgIF0gU3RhcnRlZCBDcmVhdGUgVm9sYXRpbGUgRmlsZXMgYW5kIERp
cmVjdG9yaWVzLg0KICAgICAgICAgU3RhcnRpbmcgTmV0d29yayBUaW1lIFN5bmNocm9uaXphdGlv
bi4uLg0KICAgICAgICAgU3RhcnRpbmcgVXBkYXRlIFVUTVAgYWJvdXQgU3lzdGVtIEJvb3QvU2h1
dGRvd24uLi4NClsgIE9LICBdIFN0YXJ0ZWQgTmV0d29yayBTZXJ2aWNlLg0KICAgICAgICAgU3Rh
cnRpbmcgTmV0d29yayBOYW1lIFJlc29sdXRpb24uLi4NClsgIE9LICBdIFN0YXJ0ZWQgVXBkYXRl
IFVUTVAgYWJvdXQgU3lzdGVtIEJvb3QvU2h1dGRvd24uDQpbICBPSyAgXSBTdGFydGVkIE5ldHdv
cmsgVGltZSBTeW5jaHJvbml6YXRpb24uDQpbICBPSyAgXSBSZWFjaGVkIHRhcmdldCBTeXN0ZW0g
VGltZSBTZXQuDQpbICBPSyAgXSBSZWFjaGVkIHRhcmdldCBTeXN0ZW0gVGltZSBTeW5jaHJvbml6
ZWQuDQpbICBPSyAgXSBTdGFydGVkIE5ldHdvcmsgTmFtZSBSZXNvbHV0aW9uLg0KWyAgT0sgIF0g
UmVhY2hlZCB0YXJnZXQgTmV0d29yay4NClsgIE9LICBdIFJlYWNoZWQgdGFyZ2V0IEhvc3QgYW5k
IE5ldHdvcmsgTmFtZSBMb29rdXBzLg0KWyAgT0sgIF0gU3RhcnRlZCB1ZGV2IENvbGRwbHVnIGFs
bCBEZXZpY2VzLg0KWyAgT0sgIF0gUmVhY2hlZCB0YXJnZXQgSGFyZHdhcmUgYWN0aXZhdGVkIFVT
QiBnYWRnZXQuDQogICAgICAgICBTdGFydGluZyB1ZGV2IFdhaXQgZm9yIENvbXBsZXRlIERldmlj
ZSBJbml0aWFsaXphdGlvbi4uLg0KWyAgT0sgIF0gU3RhcnRlZCB1ZGV2IFdhaXQgZm9yIENvbXBs
ZXRlIERldmljZSBJbml0aWFsaXphdGlvbi4NClsgIE9LICBdIFN0YXJ0ZWQgSGFyZHdhcmUgUk5H
IEVudHJvcHkgR2F0aGVyZXIgRGFlbW9uLg0KWyAgT0sgIF0gUmVhY2hlZCB0YXJnZXQgU3lzdGVt
IEluaXRpYWxpemF0aW9uLg0KWyAgT0sgIF0gU3RhcnRlZCBEYWlseSBDbGVhbnVwIG9mIFRlbXBv
cmFyeSBEaXJlY3Rvcmllcy4NClsgIE9LICBdIFJlYWNoZWQgdGFyZ2V0IFRpbWVycy4NClsgIE9L
ICBdIExpc3RlbmluZyBvbiBELUJ1cyBTeXN0ZW0gTWVzc2FnZSBCdXMgU29ja2V0Lg0KICAgICAg
ICAgU3RhcnRpbmcgc3NoZC5zb2NrZXQuDQpbICBPSyAgXSBMaXN0ZW5pbmcgb24gc3NoZC5zb2Nr
ZXQuDQpbICBPSyAgXSBSZWFjaGVkIHRhcmdldCBTb2NrZXRzLg0KWyAgT0sgIF0gUmVhY2hlZCB0
YXJnZXQgQmFzaWMgU3lzdGVtLg0KICAgICAgICAgU3RhcnRpbmcgU2F2ZS9SZXN0b3JlIFNvdW5k
IENhcmQgU3RhdGUuLi4NClsgIE9LICBdIFN0YXJ0ZWQgS2VybmVsIExvZ2dpbmcgU2VydmljZS4N
ClsgIE9LICBdIFN0YXJ0ZWQgU3lzdGVtIExvZ2dpbmcgU2VydmljZS4NClsgIE9LICBdIFN0YXJ0
ZWQgRC1CdXMgU3lzdGVtIE1lc3NhZ2UgQnVzLg0KWyAgT0sgIF0gU3RhcnRlZCBSZXNwb25kIHRv
IElQdjYgTm9kZSBJbmZvcm1hdGlvbiBRdWVyaWVzLg0KWyAgT0sgIF0gU3RhcnRlZCBOZXR3b3Jr
IFJvdXRlciBEaXNjb3ZlcnkgRGFlbW9uLg0KWyAgIDIzLjQzMTYxMl0gYXVkaXQ6IHR5cGU9MTMz
NCBhdWRpdCgxNjYwNzU3OTIyLjc3MTo0KTogcHJvZy1pZD03IG9wPUxPQUQNClsgICAyMy40NjI1
MjldIGF1ZGl0OiB0eXBlPTEzMzQgYXVkaXQoMTY2MDc1NzkyMi43OTE6NSk6IHByb2ctaWQ9OCBv
cD1MT0FEDQogICAgICAgICBTdGFydGluZyBMb2dpbiBTZXJ2aWNlLi4uDQogICAgICAgICBTdGFy
dGluZyBQZXJtaXQgVXNlciBTZXNzaW9ucy4uLg0KWyAgT0sgIF0gU3RhcnRlZCBTYXZlL1Jlc3Rv
cmUgU291bmQgQ2FyZCBTdGF0ZS4NClsgIE9LICBdIFJlYWNoZWQgdGFyZ2V0IFNvdW5kIENhcmQu
DQpbICBPSyAgXSBTdGFydGVkIFBlcm1pdCBVc2VyIFNlc3Npb25zLg0KWyAgT0sgIF0gU3RhcnRl
ZCBHZXR0eSBvbiB0dHkxLg0KWyAgT0sgIF0gU3RhcnRlZCBTZXJpYWwgR2V0dHkgb24gaHZjMC4N
ClsgIE9LICBdIFN0YXJ0ZWQgU2VyaWFsIEdldHR5IG9uIHR0eVNDMC4NClsgIE9LICBdIFJlYWNo
ZWQgdGFyZ2V0IExvZ2luIFByb21wdHMuDQpbICBPSyAgXSBTdGFydGVkIExvZ2luIFNlcnZpY2Uu
DQpbICBPSyAgXSBSZWFjaGVkIHRhcmdldCBNdWx0aS1Vc2VyIFN5c3RlbS4NCiAgICAgICAgIFN0
YXJ0aW5nIFVwZGF0ZSBVVE1QIGFib3V0IFN5c3RlbSBSdW5sZXZlbCBDaGFuZ2VzLi4uDQpbICBP
SyAgXSBTdGFydGVkIFVwZGF0ZSBVVE1QIGFib3V0IFN5c3RlbSBSdW5sZXZlbCBDaGFuZ2VzLg0K
DQpPcGVuRW1iZWRkZWQgbm9kaXN0cm8uMCBzbWFyYy1yemZpdmUgaHZjMA0KDQoNCk9wZW5FbWJl
ZGRlZCBub2Rpc3Ryby4wIHNtYXJjLXJ6Zml2ZSB0dHlTQzANCg0KDQoNCkxhc3QgbG9naW46IFdl
ZCBBdWcgMTcgMTc6Mzg6NDUgVVRDIDIwMjIgb24gaHZjMA0KWyAgIDI2LjY1MDE2Nl0gYXVkaXQ6
IHR5cGU9MTAwNiBhdWRpdCgxNjYwNzU3OTI1Ljk5MTo2KTogcGlkPTE2NCB1aWQ9MCBvbGQtYXVp
ZD00Mjk0OTY3Mjk1IGF1aWQ9MCB0dHk9KG5vbmUpIG9sZC1zZXM9NDI5NDk2NzI5NSBzZXM9MSBy
ZXM9MQ0KWyAgIDI2LjY2MjU2NF0gYXVkaXQ6IHR5cGU9MTMwMCBhdWRpdCgxNjYwNzU3OTI1Ljk5
MTo2KTogYXJjaD1jMDAwMDBmMyBzeXNjYWxsPTY0IHN1Y2Nlc3M9eWVzIGV4aXQ9MSBhMD04IGEx
PTNmYzdiNDBkZTAgYTI9MSBhMz0wIGl0ZW1zPTAgcHBpZD0xIHBpZD0xNjQgYXVpZD0wIHVpZD0w
IGdpZD0wIGV1aWQ9MCBzdWlkPTAgZnN1aWQ9MCBlZ2lkPTAgc2dpZD0wIGZzZ2lkPTAgdHR5PShu
b25lKSBzZXM9MSBjb21tPSIoc3lzdGVtZCkiIGV4ZT0iL2xpYi9zeXN0ZW1kL3N5c3RlbWQiIGtl
eT0obnVsbCkNClsgICAyNi43NjkzNjddIGF1ZGl0OiB0eXBlPTEzMjcgYXVkaXQoMTY2MDc1Nzky
NS45OTE6Nik6IHByb2N0aXRsZT0iKHN5c3RlbWQpIg0KWyAgIDI2Ljc4ODk2M10gYXVkaXQ6IHR5
cGU9MTMzNCBhdWRpdCgxNjYwNzU3OTI2LjExOTo3KTogcHJvZy1pZD05IG9wPUxPQUQNClsgICAy
Ni43OTU5MzBdIGF1ZGl0OiB0eXBlPTEzMDAgYXVkaXQoMTY2MDc1NzkyNi4xMTk6Nyk6IGFyY2g9
YzAwMDAwZjMgc3lzY2FsbD0yODAgc3VjY2Vzcz15ZXMgZXhpdD04IGEwPTUgYTE9M2ZlNmYxOTZl
OCBhMj03MCBhMz0wIGl0ZW1zPTAgcHBpZD0xIHBpZD0xNjQgYXVpZD0wIHVpZD0wIGdpZD0wIGV1
aWQ9MCBzdWlkPTAgZnN1aWQ9MCBlZ2lkPTAgc2dpZD0wIGZzZ2lkPTAgdHR5PShub25lKSBzZXM9
MSBjb21tPSJzeXN0ZW1kIiBleGU9Ii9saWIvc3lzdGVtZC9zeXN0ZW1kIiBrZXk9KG51bGwpDQpb
ICAgMjYuODIxMDQ0XSBhdWRpdDogdHlwZT0xMzI3IGF1ZGl0KDE2NjA3NTc5MjYuMTE5OjcpOiBw
cm9jdGl0bGU9MkY2QzY5NjIyRjczNzk3Mzc0NjU2RDY0MkY3Mzc5NzM3NDY1NkQ2NDAwMkQyRDc1
NzM2NTcyDQpbICAgMjYuODMxNzc4XSBhdWRpdDogdHlwZT0xMzM0IGF1ZGl0KDE2NjA3NTc5MjYu
MTE5OjgpOiBwcm9nLWlkPTAgb3A9VU5MT0FEDQpbICAgMjYuODM4NTUzXSBhdWRpdDogdHlwZT0x
MzM0IGF1ZGl0KDE2NjA3NTc5MjYuMTE5OjkpOiBwcm9nLWlkPTEwIG9wPUxPQUQNCnJvb3RAc21h
cmMtcnpmaXZlOi9sYXZhLXRlc3RpbmcjIHJvb3RAc21hcmMtcnpmaXZlOi9sYXZhLXRlc3Rpbmcj
DQpyb290QHNtYXJjLXJ6Zml2ZTovbGF2YS10ZXN0aW5nIw0Kcm9vdEBzbWFyYy1yemZpdmU6L2xh
dmEtdGVzdGluZyMgbGRjb25maWcNClsgICAzNC4yMzI3MTJdIGRvX3RyYXA6IDMgY2FsbGJhY2tz
IHN1cHByZXNzZWQNClsgICAzNC4yMzI3MzddIGxkY29uZmlnWzE3N106IHVuaGFuZGxlZCBzaWdu
YWwgNCBjb2RlIDB4MSBhdCAweDAwMDAwMDAwMDAwMzExZjAgaW4gbGRjb25maWdbMTAwMDArNjgw
MDBdDQpbICAgMzQuMjQ2Mjg1XSBDUFU6IDAgUElEOiAxNzcgQ29tbTogbGRjb25maWcgTm90IHRh
aW50ZWQgNi4wLjAtcmM3KyAjOTENClsgICAzNC4yNTI3NDhdIEhhcmR3YXJlIG5hbWU6IFJlbmVz
YXMgU01BUkMgRVZLIGJhc2VkIG9uIHI5YTA3ZzA0M2YwMSAoRFQpDQpbICAgMzQuMjU5MzM0XSBl
cGMgOiAwMDAwMDAwMDAwMDMxMWYwIHJhIDogMDAwMDAwMDAwMDAxNDVhMCBzcCA6IDAwMDAwMDNm
Y2RiM2NhODANClsgICAzNC4yNjY1NjddICBncCA6IDAwMDAwMDAwMDAwN2ZlNDggdHAgOiAwMDAw
MDAzZmIyODM0NzIwIHQwIDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDM0LjI3Mzc5Ml0gIHQxIDog
MDAwMDAwMmFlMDQ0N2JiYyB0MiA6IDAwMDAwMDAwMDAwMDAzZmYgczAgOiAwMDAwMDAwMDAwMDE0
YTg2DQpbICAgMzQuMjgxMDAyXSAgczEgOiAwMDAwMDAwMDAwMDE0YjBlIGEwIDogMDAwMDAwM2Zj
ZGIzY2M4MCBhMSA6IDAwMDAwMDAwMDAwMDAwMDENClsgICAzNC4yODgyMzZdICBhMiA6IDAwMDAw
MDNmY2RiM2NiYzggYTMgOiAwMDAwMDAwMDAwMDE0YTg2IGE0IDogMDAwMDAwMDAwMDA3ZTU3Ng0K
WyAgIDM0LjI5NTQyN10gIGE1IDogMDAwMDAwMDAwMDAwMDAwMCBhNiA6IDAwMDAwMDNmY2RiM2Ni
YzAgYTcgOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgMzQuMzAyNjQ2XSAgczIgOiAwMDAwMDAwMDAw
MDAwMDAwIHMzIDogMDAwMDAwM2ZiMjk4YTkxOCBzNCA6IGZmZmZmZmZmZmZmZmZmZmYNClsgICAz
NC4zMDk4NjZdICBzNSA6IDAwMDAwMDJhZTA1M2Q4NjAgczYgOiAwMDAwMDAyYWUwNTNkNDkwIHM3
IDogMDAwMDAwMmFlMDUyMzcyMA0KWyAgIDM0LjMxNzA4Nl0gIHM4IDogMDAwMDAwMmFlMDUzZDM4
MCBzOSA6IDAwMDAwMDAwMDAwMDAwMDAgczEwOiAwMDAwMDAyYWUwNGY4NTg0DQpbICAgMzQuMzI0
MzA2XSAgczExOiAwMDAwMDAwMDAwMDAwMDAwIHQzIDogMDAwMDAwNmE5MmRmNTJhOCB0NCA6IDAw
MDAwMDAwMDAwMDAwMGYNClsgICAzNC4zMzE1MTZdICB0NSA6IDAwMDAwMDAwMDAwMDAwMGYgdDYg
OiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgMzQuMzM2ODMzXSBzdGF0dXM6IDAwMDAwMDAyMDAwMDQw
MjAgYmFkYWRkcjogMDAwMDAwMDA2ZGJmZmU5YiBjYXVzZTogMDAwMDAwMDAwMDAwMDAwMg0KWyAg
IDM0LjM1OTAyM10gYXVkaXQ6IHR5cGU9MTcwMSBhdWRpdCgxNjYwNzU3OTMzLjY5NToxMSk6IGF1
aWQ9NDI5NDk2NzI5NSB1aWQ9MCBnaWQ9MCBzZXM9NDI5NDk2NzI5NSBwaWQ9MTc3IGNvbW09Imxk
Y29uZmlnIiBleGU9Ii9zYmluL2xkY29uZmlnIiBzaWc9NCByZXM9MQ0KSWxsZWdhbCBpbnN0cnVj
dGlvbg0Kcm9vdEBzbWFyYy1yemZpdmU6L2xhdmEtdGVzdGluZyM=

--_002_OSZPR01MB7019463C819F66866FBCED43AA229OSZPR01MB7019jpnp_--

