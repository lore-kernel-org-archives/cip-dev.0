Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C741EB64DD
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 06:28:35 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.127])
 by mx.groups.io with SMTP id smtpd.web10.82679.1691562507448649152
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Aug 2023 23:28:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=U99Y1co3;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.127, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iqb9mUDOGajEnOqH8om0thEFh0LmtJqva66RQB8N9OqE3VDZA6sO0Trg9uuO3h1ZOZmk2PenBCkLY8iQENorQDKWDoiJHZAqkwxQGt1d3WfJ+ZJV7Z6H2tOSq0KGvJyozjEPJiMn2Yo0gdB2jh85dQFUkjeXdTPHWGupDXtDxEKCAIzsDrMGoexr34yZqVQm3kwN1ceqQMTo/prEIrJUvCnTjGW1sMmZm5vhzeeVOaASZtlm1XOUM6zHi+3qUL8SAKrX3SyKvXSSN/w00FZki3G9Jq5A1ocw68hZJa2PZ6cl6ykuIUS/2FTNiNmCIepjMENACGe6AFk2EXURmzMb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt8krpRcjYKqhvvUfG3M26NbCrYk7ho5m2nEToVx8ss=;
 b=eo4ne52/IEmMBbXVCOOtnVTRabRGU0pBBAZmu2T+/KshjT0Pf4t7No+BAWW8NkfI7mXMeJXBStPORgOBrIQh4n6rj9row0hs3hh2OLF47hOb0ZYnNag+6cZGPdWX1K3DUxDXL2hTem86vkZlgNEUjCL7XtjMHUkhM8LGn7tCGxHcFktGgkNxTUT1vg0Nxo7iPR3661nwmEFTmwkLFyAf7q2kg0UCKnedOfjDj3GQTYbLxmA/PwfTxcry2GrAiJosGOybU9WTKWjo0TaIjhKZ/fgZDMUO02iQGWqT/obpF8e1RMMXQa5yZXG/YL522+hHlNYnhZh7Tx7k8mn4miyZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt8krpRcjYKqhvvUfG3M26NbCrYk7ho5m2nEToVx8ss=;
 b=U99Y1co3l2ip9/h9UJ4jaHbtOI4/yuv1EczSiMDBCobBth1jrpT+bRPASdYyLj3glIlXszVGY/lembU0YDNwvpuPaLbFT2pAp6tiLcmlhsMUPrJHS0zVVaY0GJ/MI6F2awQC8c7juL4tlfO0Dzcqlpx7YGo2hN5jJlz6Mu6DDL0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5358.jpnprd01.prod.outlook.com (2603:1096:404:8025::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 06:28:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f4c1:5f6e:abd1:2bf9]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f4c1:5f6e:abd1:2bf9%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 06:28:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "pavel@denx.de" <pavel@denx.de>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L} MTU3
 support.
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L} MTU3
 support.
Thread-Index: AQHZuvF9FkHOtGi3QUO62QHXQdArNa/C8D+AgB5jzwCAAEnOQA==
Date: Wed, 9 Aug 2023 06:28:20 +0000
Message-ID: 
 <OS0PR01MB592269E73058D45F9362C0938612A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230720100350.247386-1-biju.das.jz@bp.renesas.com>
 <ZLl0jyHulqBdQ99x@duo.ucw.cz>
 <TYWPR01MB9420DA0FDACEADDE4A7BD6F19212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9420DA0FDACEADDE4A7BD6F19212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5358:EE_
x-ms-office365-filtering-correlation-id: a453bdfe-7d26-4ce0-859d-08db98a1d31c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lq6q8k1By0T100NqOanefd5N+bq6+UIUZ8jMf+DIqRrBcU3fERtFSS2wt2q4j4KqA49seY5WJDXojwTVAZw/jzImCmUB93bDeFIA5+9T4jLgr42+dtEABBjwfrRoXOUsUYngMU/SoRA2bRzO81iaUNJPYAUWIhOpPn4934YuSfsM5ukfGObZ60as0GLqGuTSzbDSn/u2fMQ8NzcBRpwxg00a4eHAyr7dgRUInBom+vL1BPRZtohAFp2NNjgK15Yuu/ivL0ba2OSbe7sb61kD5G6wuSfzK+7vjpjyVEDA6tw1RkxOlR4CYbSzufPJgQ4ZUq4fFd9xNwQPW7pbMYkef3tVzKOVXtIs4VZja/uChnX/+QpetK6IAuiCHiZTlDOCUsBkpH9PKLrHBYl7kICZ8RoMZjsu062tgLL/qiFG7gy+l8Lea3ybxtriJqLsCjvLcAOEPx1Y9lAQSKZ6+b7B1iNpioL86Kp3ALgw12Slq/LsKtSN5FZt6jwJ2dT+VTgFTtz8paE05b6+5ymEKFyinTdxVHhx7LhrgXExYcboUoVYj0oPYfmI7nvqLTkVew6SQfaa+g7xlSZWLlioyFlzq50p+ITMQAqa0P4x0KOA/MZex81QCOHZ7NXstdr6NVsk
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(186006)(1800799006)(2906002)(38070700005)(8676002)(55016003)(8936002)(52536014)(64756008)(5660300002)(41300700001)(122000001)(66946007)(76116006)(66446008)(66556008)(83380400001)(6506007)(66476007)(478600001)(107886003)(54906003)(110136005)(86362001)(71200400001)(316002)(38100700002)(4326008)(53546011)(33656002)(7696005)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OGI4WnJOQTlwUVNocEt0czV5VFJRcS82Smk0RE0xUkxaQ2RBVUdCeEZ3?=
 =?iso-2022-jp?B?UW95Mml6V245dXlmQXprVFZLdTI1UjdyTU1waFo5UkdNSW83RE9vNWQ3?=
 =?iso-2022-jp?B?OURkSXIyL0Npb2Z1NW0yYWkyK00xekV5U3JkelpWR2lkc0FPYmV0Y3hC?=
 =?iso-2022-jp?B?VDdFNW84WGFCbnl4b3BaVzlsOVNITzJSSDFaNGgxeW1NM3ZrdmRDWlFK?=
 =?iso-2022-jp?B?STRKODlaZSt6djhvRGZXWUdHRDVBUGZiUzdBMitobzMrUTNTNTBrOXFi?=
 =?iso-2022-jp?B?Tkk1MHc5SDNkYmRlZEFlVWJGdXFJQTR1b3QwM3BxQlo0Nit2TTh1N21p?=
 =?iso-2022-jp?B?Y2hPbDkzN1IwRkh3M0ZFRUhLS0N6K2VwT2dUMjVteW9UYlE0TzNWVysz?=
 =?iso-2022-jp?B?aHc1K05zL1ZYRGZxMytMUkUwSXFjM005a2I0aWNmZG9XMTJxSndvVDNZ?=
 =?iso-2022-jp?B?UUh6R3RrSUE0amZyT0MzN0o1d3lRUEx0UExWd3d2VEkydGZ2UTBjZkFo?=
 =?iso-2022-jp?B?YXFnaDdpc1FTNmE5LzZoL3JFY0NYc0hFMGxlbFd1bEVlUFN4UndYSGZD?=
 =?iso-2022-jp?B?dWl4bTJlOEowV2FvUC9LeGpFdjc5elNSVWQ5SllGZFNxL2hpbTJrT2ph?=
 =?iso-2022-jp?B?M29sSjF5NDhFa25UeHRuajFvWnNzWGFDUXc1SGxjK1BLSFIzYThZMUty?=
 =?iso-2022-jp?B?ZVhXVDFLNUdlUk5TZnNMRWhjdVdjOU1XVHpHa2FMbjdlNStwNWhXYXBY?=
 =?iso-2022-jp?B?eXFIN0g2b1pmS3hIMUpjM2Y0UzNBaHBnVVFlUWEyYk4xaklHQ2RwQ3c5?=
 =?iso-2022-jp?B?cFNZNDNka1FScjV5QldjUDlYZ1RRa2kwTXVWaTRlSTdUYTBzbnFjMDVW?=
 =?iso-2022-jp?B?RS9QbUVoWXZFWDIxZnl1bW4vTVQydHdreGNGa1c1VFV1cXRyYUlKenF4?=
 =?iso-2022-jp?B?TGQvZFYraDBIYmE4TUNzdjZTck1XUVdEckNueHBuUUpQeHo0aEFvaEY3?=
 =?iso-2022-jp?B?eWJCSm53bnpNaTBhRE1pcEVUVmZJcmRKSml5ZjhRWVBsNWlWcFVCTndD?=
 =?iso-2022-jp?B?UEo1dGRTbXV0RnpNRWlBRm5aT1VPMi96NnY0anFTT2lkWXN0T1A1em8y?=
 =?iso-2022-jp?B?dEtrcGJsbFlSNlFEbmxmRlFLVUVQeWY1T0R2SGM0eFpocnpNZi9zNjAz?=
 =?iso-2022-jp?B?SExYZ1FWeVgreFByc0s3bHRnc3YxdTZuZWZEcEhSeTVTMmJXSVNkZVE5?=
 =?iso-2022-jp?B?c2IrOElyNjliWGcvcXRIMmI5WE5wRW1DUUJ0M2R1UENycWJ1RGlTdzIy?=
 =?iso-2022-jp?B?NFRBZ3U1NjViVnkwY0EzbU9GNVhVeVZVTkk1alQ3b3lpeEJXYkRuQ3Jy?=
 =?iso-2022-jp?B?aG51M0dnc1NjUzNJUlh3NkFVbkJycEVhRTdpRk9MNHYyWS9PRkxYOTFH?=
 =?iso-2022-jp?B?cDR2aURTSk0xc3JxbjJuc2NUS3RPQ3c4ZG4rL2RqSXlsTTFBZ0p1bjBV?=
 =?iso-2022-jp?B?R3FOZE5oeXkvRTJxT01nVnFHOTdyMzlWbUpUNXExL3lsaFNiTkFhWUEy?=
 =?iso-2022-jp?B?U3dlRXNxSEdQeG5nRFo5MCtYTldIOXZqcXBjV09LbzVyOVJhNnB3Mi90?=
 =?iso-2022-jp?B?RjdXK0RVTGxQQWZpSTlVQ0duY1hna1dsLytFSDQ4N2JJSnZmR3IxNFdO?=
 =?iso-2022-jp?B?WG9OYjlWY0ZrWUxpVjNWdTRPanZMTE9QZTJXR003a3Fqbi8yaWlLb2w2?=
 =?iso-2022-jp?B?eEhRbE1oc21kcyt1bTV5bjdmd0s5TUdSMHlGOGVBc1ZFQ3lBTDVuN0Vz?=
 =?iso-2022-jp?B?TGhlUG1QNlpGYWFQWFlsbnZrVVR2bGxWL1VodmhHK09nbC9TdlVqbTdH?=
 =?iso-2022-jp?B?YWpiUlhLV3UvVHpxenpwMlpLdnd5bVgxemN6ZWNqcU9SNU1nOXZEZUxt?=
 =?iso-2022-jp?B?OGh1WGhMSldITkZsekNqd0ZTOEppZWVMNjNrMllRYXVhVGR0bktHUHpO?=
 =?iso-2022-jp?B?TzI1SW1PbXZPSnk2elZwWWZCVXNaYVJPUk1lRGhKeUUwNnhpelBEcjBI?=
 =?iso-2022-jp?B?VG0zWGVlZkZFRnlkN3N3YjJRV3lVRmpiWllWMVJiOVBWMkIwOHlwL216?=
 =?iso-2022-jp?B?YVFnRUE3NnVLWm1zdHc0NE5ZUU1lczluc2FnLzN2amlkK21adTlJTXJv?=
 =?iso-2022-jp?B?SGNHY1VsSmhGVDhDN3lnbkpYNlN4Q1UyWUFvM1F5MkRUVXJ2NGY3MlM1?=
 =?iso-2022-jp?B?T1JRZTFQU3FacG5jRWQxM3IyNlV5blR0S24xTlNjN0tVeTdvaHE1dWM3?=
 =?iso-2022-jp?B?TzQ5Nw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a453bdfe-7d26-4ce0-859d-08db98a1d31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 06:28:20.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqA9HDdOyISAUOPEKCtLP8PDaTxqgFuuUK+ABXJP9ddrDw66BuRYOuLqIVu/xbSiR2lCM9OE01FPyg5MWn0jPrg761+m23x5CZlYGQ3zJCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5358
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 06:28:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12584

Hi Nobuhiro-San,

> Subject: RE: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L}
> MTU3 support.
>=20
> Hi Pavel,
>=20
> It seems that the following patches have not been applied in 5.10.y-cip
> tree.
> Do you forget these? Or do you have a reason?
>=20
>   arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
>   arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
>   arm64: defconfig: Enable Renesas MTU3a PWM config

These patches are from next. For testing I have added here.=20

Pavel wants the patches to be picked from mainline due to CIP policy reason=
.

We need to wait for another 2 months to get these patches hit on mainline, =
So that proper commit ID can be applied in backported cip patches.

Commit-IDs in next can be changed while applying to mainline.

Cheers,
biju



> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Pavel Machek
> > Sent: Friday, July 21, 2023 2:53 AM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>; Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Subject: Re: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add
> > RZ/{G2L,G2LC,V2L}
> > MTU3 support.
> >
> > Hi!
> >
> > > This patch series aims to add support for RZ/{G2L,G2LC,V2L}
> > > MTU3 core and PWM driver.
> > >
> > > All the patches are cherry-picked from the mainline except
> > > patch#11-patch#13. The trivial patches#11-#13 are cherry-picked from
> > > next.
> > >
> > > v1->v2:
> > >  * Add WARN_ON for rz_mtu3_pwm_get_state() in patch#8 as suggested
> > > by
> > pavel.
> >
> > Thank you for the update. It passed testing, so I applied mainline
> > parts of the series to 5.10. I added Iwamatsu-san's reviewed-by tag
> > from the previous iteration.
> >
> > Best regards,
> > 								Pavel
> > --
> > DENX Software Engineering GmbH,        Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


