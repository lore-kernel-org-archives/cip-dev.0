Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA15C001DB
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 01:58:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.79417.1691546316990780014
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Aug 2023 18:58:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 3791wOqq2197215; Wed, 9 Aug 2023 10:58:24 +0900
X-Iguazu-Qid: 2rWhc6jYx5CScTjXvB
X-Iguazu-QSIG: v=2; s=0; t=1691546303; q=2rWhc6jYx5CScTjXvB; m=FRnPFMMwcYy5RPw3VJY+3F5SL7Nxk8FGsH19F5N/Hac=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 3791wLZ7635039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 9 Aug 2023 10:58:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTw0tMyd1lF0bdtD8DFm0j7YSMkkNVFL9y+9aPTrYuR9MxIkUG/z2Nga3zoLnMRuxNxDbVnW875aRLkKA7yOLygJZBDQNgCo1upuoB23mUtKMfZ6WRIjCFq207bVDmN/8iel4olurLAUmL9hCjExZjfOIY1RDTYuQ2nlD7dDscIVVPlJGVLTQ3QH+dcBd5koum2o90ZkdHxGetiEFfENL1wPmX/khfTuXG3K2EH8o29evVZOoYl683y7GjS9fEa+QvGwS03qnz875TtKjkH/CS+npvHBfD2yhFoi2JInJYQaNVxgFApAlwutrSSfdLYhSIK83DvuBF5bAyfJI1Ujtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUtfKFcaeyvTdxjlA5htsxA7Q78Q0vWae1a1SAUPHD4=;
 b=YYC9/jgMWwR0kJKjYpIjaYDaB159iGTW5RBuKlV5kjzwxq2j8vjp27cBJFjQvkhL4YtWXs6gDkHdrLjq7DTsYddepKD2dtgVntZBQ2+LhLmfv6/A/eb9a7hN3FF7N0WkRqt4+30VwvM44n4ZwrCOkfsH4uRPD9r9k959jSX877DhiTtMRkwqxhCaX1oH/AYtTPuY3PzVpX3wUBExxk6In2TdMACogweiXUsHtGAwX8CfintmiwpsqTcI5wmolYC6gId9CSiPqgACn2FiMg4C7S1Uf6h/dBrWjzoaSBVJBLWBtlVm7nQiZ+BXKvOo+qvbrY3kK+tQ335D0oBC5NcWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
CC: <pavel@denx.de>, <fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L} MTU3
 support.
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L} MTU3
 support.
Thread-Index: AQHZuvGD9Mo8H4j9JkOQdisgF97/xq/C8D+AgB5jY6A=
Date: Wed, 9 Aug 2023 01:58:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420DA0FDACEADDE4A7BD6F19212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230720100350.247386-1-biju.das.jz@bp.renesas.com>
 <ZLl0jyHulqBdQ99x@duo.ucw.cz>
In-Reply-To: <ZLl0jyHulqBdQ99x@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB9317:EE_
x-ms-office365-filtering-correlation-id: 416cf82b-130d-414b-6e1e-08db987c1b1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 muSEeOr+okGQAzyZRSQI5uIrBRAlmC/XBN4aLi16KADaIy5Bhpho9VHK7kAIfXNPaDQP+ibu+Hgv6pQCJU7SthH+8SF3Roys9yXxVa/F5MzWnTBpF+vQa4MdQD3hJWpLfmERzxw915DnNqOTjeBRXL5os5LDjqTGhy+X5oRKIlD+/N0mLN4QnkxKvRjo9O/ltRS5xQ/9TFHh69Pk6EQj40wxauBnU4NONlgp1tksDYDyLMISjMzDG3ORCN1K+02vRHs98/V0GqbnirHjloBBtm14siL0U9dtzyLypCKp7uALllfW6e1XMHASoHNjxVY2IeRQoi876GxZ6X2yHrnufwa2/fNeAQ2tLwlqlWg4mDNTrn7Se05FEkJt8SS1nZ50eFzY7MEKANaG+pa9rw/OyQKuNeV8qNE/pmUSDy9eNe9UTzdbrmtLEhgk6dow2WcEAAdXjYNc6HdMUe5PXkPxt6zLabfEuHtuxffmcnOKVJwZ55ZxhVRRiX5YpVI+p3NAWSokRQ2jJvL23QCYIl6aV5gt7f7UtUOr7wt+z8mMui6iw0EL4I09Hn4VRM7F8LnOYq831hsY2jxFAGQf/+yCOiI0vwFF+S+h95SS6AdlwUv6nxtP2RyrXk9sEa4wcLNHGKntI0MTN5TM4JXOa09MBg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(186006)(1800799006)(451199021)(2906002)(316002)(8676002)(8936002)(38070700005)(5660300002)(52536014)(41300700001)(33656002)(86362001)(55016003)(71200400001)(110136005)(54906003)(38100700002)(122000001)(478600001)(53546011)(6506007)(26005)(7696005)(9686003)(83380400001)(64756008)(4326008)(66446008)(66476007)(66946007)(76116006)(66556008)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Z0QvSldiYUljekJ1NDNFRURtNnZ2Q2wydXlWU3AyZE9SR2xpKzNVQXVU?=
 =?iso-2022-jp?B?aDhra3YzYzJldkRzbXNXZ0FidUpsejVFQWl1SVRHRWxGOFhoNnU5cVpr?=
 =?iso-2022-jp?B?VDRlVmlpWWxjTFBVNk9UT2NpRGY3S0ZDSGFXbTFaSkt0N2FLSjUwRlJM?=
 =?iso-2022-jp?B?UGNDQktMTGQ5aUJuQnhMdmhVWnFlb0pUS1RoSHF3Ymd4dytSRGNmbGhm?=
 =?iso-2022-jp?B?Mm5WUkJkRkxhWFBuUFFvaEJ2VFBFVENBam9qaDdzYzJYRkJ1b3B3WTZE?=
 =?iso-2022-jp?B?SWV0MDBubjM4bVdQa21XWkkzZ2pIRmZXZ2xib0NZNTR0WnlhQ1FRNGJR?=
 =?iso-2022-jp?B?aHlBdVZTa1lZMHByay9DUS9MY1NRb3FNUldrTWU1UTg5K0YyRUJoM1ds?=
 =?iso-2022-jp?B?QjgxSjhPYzl4ZTZuQ1VITW85T1pDc1hnaXdZY0pUMVdQTkdSdmVWZUc4?=
 =?iso-2022-jp?B?cXNzZ1Z4Zit2NVFvT29JOGpBb3VMakVkTjdnNzdPNmtUM0wzblUxeUti?=
 =?iso-2022-jp?B?c3cyZi9ueWNaeGFxUEJoeVJnSWlyMTJ3a2xRcStqRXZXT050RUk1aWk4?=
 =?iso-2022-jp?B?bHRIQ1lJOU4rYVR2a1E4dTl0djEwYjBTSzJWRGVSVWRnOFYxSmFOYzFl?=
 =?iso-2022-jp?B?TG5kZ1p6Snlmbkk5Ulh3ZmlWaUJwRzVFaXJPVm1nTjhqUkt1N2dIdHR1?=
 =?iso-2022-jp?B?bEJ0UFNNZ0J5dVR2SVBTTzJIbVpJUTM0SDBHei9BUjh2NktNRjlaSzZG?=
 =?iso-2022-jp?B?NklabTVOSDRLQWZkeXZhTnFUaFZOU3RUa2xxU21ETjF6UExlMzlZcHp4?=
 =?iso-2022-jp?B?QjBOMFRVMXNtRGYwV3d0UFZNZWk4VW9CRjJCSXgxODNxSldIMiszOFFw?=
 =?iso-2022-jp?B?OEViOER6WlZIelYzYVRwQkVvdlMzTHJtSGRVUG1ic2dIVndja2ZISXIy?=
 =?iso-2022-jp?B?YzlqMEY4bDJoelFzbldoNW9KWjhuMWtIRkkyUUJFcW5LNmxOTEFVODJy?=
 =?iso-2022-jp?B?bmg5V2U0RXZMeDlId2RkdjdLTFVqWWRoS0xJY1dqdUVyRlZWUUZkc2o0?=
 =?iso-2022-jp?B?NkZXREtWYko1S2w5NnNVczBQTnZUT3c4cjg3U1ZJNlFrMGtOYUZOcVdB?=
 =?iso-2022-jp?B?bTAzSUtxU2FXdkgxcTlyTXl3Qi9PRzdLSHJTeXphRVRmNENyV20yb1Vl?=
 =?iso-2022-jp?B?WVVGbk1MZ3JzdDFxUFA0ZUlaYXB5RlA4cmoyZnF4eTcrL3NZRlQzd2Mx?=
 =?iso-2022-jp?B?QkNMeEJFRXJXMUEvOEVPOERydG9hZEhQOHRRNTlKbEZpTGQzc3VxVUJN?=
 =?iso-2022-jp?B?L1hxRGJEZyt0UUlhWjY1Z2tJRTZYbTFIVTJkQ3dEWW9SRFQrR1QvUnY1?=
 =?iso-2022-jp?B?Qi93YWo1clVWMTJUa3V2bVR5a2FXb3Fxb29QUitSYkJ4UjltNjZ0UVFG?=
 =?iso-2022-jp?B?RXJBc3RTTis4VGRHdFg3aFdlWG5IckZobXNYZ0xHMUhsMWp4NnpLK2hB?=
 =?iso-2022-jp?B?a2lFRjAxOTBUM2I0bWFHNmN0dWJ1UUJRNmxYUkxXdWNNc3QyNDhRc1Nt?=
 =?iso-2022-jp?B?MWRRbWZVcVhHU1lYR1BONHJuazMrVEk4TkcyNnFKYVcyUFk3ckpTV2Z1?=
 =?iso-2022-jp?B?K2M3L3lyMWdxUlhHbHVuRm4vdUpLQVp3OVRFYU9WeVAzWDBNNkhXN2Zl?=
 =?iso-2022-jp?B?bmV0RmNQbGVvaHpyUzh1SDNvY2pydzZzU0VmV0dKaW5BZEFpRVMreFdP?=
 =?iso-2022-jp?B?QldycVBleUlDclpRWWNSanAvMFBjeWVJM3JhMUo5RTZYZ2FNSTVpMjFt?=
 =?iso-2022-jp?B?enZuTXM3YXlhWWV6ZVJDdGJXUUc2MVByZ3NQWXdYbzhEZnJJalowUndh?=
 =?iso-2022-jp?B?UzY3YzAxNGkyeTB1b1hESXR0SWFxYVEyemtUSTVtakpHeTJUcnRTcDRO?=
 =?iso-2022-jp?B?M3hkUmkrbEV0ZUJtWW1xcm9odGpFd3lqSVU2WG5MRHhpNk1qUXhtNUls?=
 =?iso-2022-jp?B?WTIvM1JzaExnVUVvZzB4VHVwaDBiVTNpWXZiRG45R1hQMG45QmxsTGd5?=
 =?iso-2022-jp?B?QnZmZWhwemFZRTI0MWRZSlAzNUtkTEtMcUlqM09yekNqakhydDdQb2JI?=
 =?iso-2022-jp?B?UndVRGhVMjFWd0RNdUFrZlRuTHZGTDVudFhtTVhDZnp6dWxYSUxlbTh2?=
 =?iso-2022-jp?B?M0lUQXBMbThoZmUwWHoySENOVXYyREV6Si9lSjRKZE1YRzRNbzRjNjI4?=
 =?iso-2022-jp?B?eXBKRXFFdXM3SXlzTkhQd1c4SUpDakRIOW53OGdxY0xZakxKN1pjRi9a?=
 =?iso-2022-jp?B?bXhYQko5Y2I3NVdSeHB5OHA1THNSMVhVMVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IW659TwuDF2CHjdFPTIqNEEpi/3tuViC1Ylz0FQJdTPJnNldaXYiQnBsGzug4pfbnGailqtWPPvDs19AuzCPSGATipxXboSwOWzEmliWOp0oJbeTNtssspoK/24TGM2wtBEKTk+pZOffuqpj7Y/Sv+nLFBqdjFHGx4sMO8ctp+YwHnQKGulKNK2XQROdigKmx5yCBxfgn2jfpVj7QQGpmVP9sQ8zPQfPCNZJM38EAsHZZPCdPwYahOhkjE7+Q3bRYiNDeNA8WNj5y3WIW8yUV5gSD1/xz+dES8V/zHaKhCa9E+ddZv+RZlSnAslgV47+ITpjnrXqkPk5igFAMuM3ICw3qB1kYYVJUXZIz4wTft6bJAB2X/Ed/+Y55vvQN+q/GRjiift2EpKT67MGZcvMwO6Gihnc3nCkW1thaLA32N2tgTU9nlKceAa3bYDtv+G+4xzxzGLAa7/nNsfXxLjLvBhkd3UxSRl6c/+173EZgfeuZNttpU+FUGJxrA1kF/ebevgG3sYXoflQue2BtfKdUkh3k0tZWvGNd94WBAMPXgZ2nqWBAlHydD1csUCiyWlOkOAHxEE1VLAlmHG2a8M40z9789/hyEh2aSE1R1qe5LmwZO5EbbTWKqc6i5SkNkQAEW42ELTLHnz2wcUel86DCBmahZjYs1XzrCPgOXrih/PKlVYFuP61GyBdyOBI2ijwRLPLmirWqESOVnKivDEqJGXZnAKy9x3cMayEZ7XQxLiOmD//FhK51/0pOHH15nyzgZH1pgntOKT6e07kraTC/mnEVyyNvMAFToTR76/rYQDzQnkzDyPysDTXmwVZLybXM+4lsBvprbt0SKoIEIWN8qwksVnM6FCHmjJjn9ClSCNLg24qzJlZc1KPB72kWPbMp5d96Uvd4tgN1TsjpZCqJg==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416cf82b-130d-414b-6e1e-08db987c1b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 01:58:20.1249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cd5GHQ5a1avUmcDNCJkQbqF0amBgKHQ3IQwkuPmDIyxX+mmUpwNir4poAuatgai2j86tjwGNbRBbw0/Ur7jMo0B0e67nV/aG8JvptJd6GqUg+1JMcmZupmDR84tyi1Un
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9317
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 01:58:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12572

Hi Pavel,

It seems that the following patches have not been applied in 5.10.y-cip tre=
e.
Do you forget these? Or do you have a reason?

  arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
  arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
  arm64: defconfig: Enable Renesas MTU3a PWM config

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Friday, July 21, 2023 2:53 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>; Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L}
> MTU3 support.
>=20
> Hi!
>=20
> > This patch series aims to add support for RZ/{G2L,G2LC,V2L}
> > MTU3 core and PWM driver.
> >
> > All the patches are cherry-picked from the mainline except
> > patch#11-patch#13. The trivial patches#11-#13 are cherry-picked from
> > next.
> >
> > v1->v2:
> >  * Add WARN_ON for rz_mtu3_pwm_get_state() in patch#8 as suggested by
> pavel.
>=20
> Thank you for the update. It passed testing, so I applied mainline parts =
of the
> series to 5.10. I added Iwamatsu-san's reviewed-by tag from the previous
> iteration.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


