Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53A8C27C7A
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:06:08 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.96])
 by mx.groups.io with SMTP id smtpd.web11.184385.1692270358645014600
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:05:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=eVtXna/D;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.96, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDwtHyZ194TOoPRANneREKbkaqnfJd62OQJAngKslGQJP9gvMfW4GGF7ABbE9msuLnbAjaCUb8m3ym5EyXf+jKY+y2OUFRLhqrTNgtxO97dPyT0TagbRNplT+DDEg9DQSK9YG01zFdrDQr9c+/+Gfu9TS6ejTDGL/YhlZMeiRNczM2DnMFhzsdT9TA2FYU7HII0FebmgSCHEXXrPd0R+kPqKpvyR5bHEnUquhZzNqbOPfurmBwI4oOCVdDlGZAnPxth/DDQ7/aNPE6Za7lgzJjfoWpsyBjMocIuOlbhGYjhSf55fbywJM/VH7snwSQcwJ7xxGcYx3Rtzj616aD11jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eggzNOtmw4DPCc16004pqt67YrGEfusX9ZDr8aJJxeg=;
 b=d2LYcChWgMuocJyHS9rzfxq+uKI93CeEo2mpYC8fIwSXvUz2jA5djwr1t9wLnjUKIY9CA7XdV8TZhze+Ocd2lPcuXg8i3Oa9Si4uiH333WhdHGHReMW38CDiyhuG1U37ctki8IyQIoM+j/3TGiPDeH1VnWFq/lQJkv0SOFkQsdi95JCRRdx1FHl6UXAhrAHFYEk0V1jhPTCQet9hSSKyz3M7n4u0EgGK1Fe52MMhKO95ADcZ+zMczAHK9HUjxK0jNsSLwgXQ3kI+AX34EO7t8h8r49ZuGAr3BwQoNMAZAFVrzUMvNX0D1/WRJEOn3s09qVoX0X5YHnSP3IMN8orlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eggzNOtmw4DPCc16004pqt67YrGEfusX9ZDr8aJJxeg=;
 b=eVtXna/D9+SDtk/a9kE5AkMir60BRpG4dimoy6cminzC9i66uiTCaGourJWnO3kyvr1feNmF/QaDCmnBpE84WL8a0fZ9UJPpG9CJPjtu2SRlGSvHQ1V3HMZIiHDrUcQnu+gg3Myv0xA+KhMBYG04To+9Im+nDDz876lVh/tEm4E=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6152.jpnprd01.prod.outlook.com (2603:1096:604:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 11:05:54 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:05:54 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/31] Add Renesas PMIC RAA215300 driver and
 builtin RTC support
Thread-Topic: [PATCH 5.10.y-cip 00/31] Add Renesas PMIC RAA215300 driver and
 builtin RTC support
Thread-Index: AQHZ0EzL70DM7IunGUqTrgXXzMj1O6/uUnUAgAABvrA=
Date: Thu, 17 Aug 2023 11:05:54 +0000
Message-ID: 
 <OS0PR01MB59225D84CB8652CBA7F148AC861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
 <ZN389JxOHsu0Cnbt@duo.ucw.cz>
In-Reply-To: <ZN389JxOHsu0Cnbt@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6152:EE_
x-ms-office365-filtering-correlation-id: 4f2aab83-8574-4944-f942-08db9f11ecf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Wxrnc0QbedCw1wgOpIn4IGFOI4gWrkTfz6hU7InxZgdc2ndlsnWqXY9GQ5/H3TeJlEjWtmGxfbg0ZQ4zTEhdDLWxxMHnf0UYP4S1eZ8J3xtAtRdaQk7lIOtzVHmN7PS+FxuCNLOc8FTJyjmGEPgmLS7DRVlPSK+jTa6pXz+ObMrWXKP0c8SAo6Z6KjLsrb9fKW+hG3ojRgEceSHQIt7dISS5hoLq1U0p0FOj3KAx/k90NR2+RWHogf+PltCuVGjQrJFHbAuj9v9UReE1gJJsy2czr90ZwVifyFaRJt9sv5cUrpNu9xRfzDn/QTiBJSBsJA1c8ioY1/8Eydfn7oO6Q5KpO5kqy7LMO3x/kAAL9yqdbvC9sGd6Bch7A53H/aqNQXpru54ovRaXSxhp9gkyaCAkr6AB3uuNObeN0lSXZbB8KagZjLbBSrE8nqPRMy5gekvRXTuPshnQOYqdxt6YG2m9FZK+vZrmjuoql7N9i3UmqzRdCgNconOwQxQ1c1NSc6AeyhIpqy3dnayzWXIs4BrAGzekkxLy13wF0NNX9CebLjiMZeSEE18W9JwHE/Ue2woY3SfX/OExoBN7yznBFcM379EWMsYv/1rII3esCV3D6dy5TqewibVxLhH3D+qg
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(1800799009)(186009)(451199024)(55016003)(83380400001)(2906002)(66946007)(66446008)(76116006)(66556008)(66476007)(6506007)(71200400001)(54906003)(64756008)(7696005)(6916009)(316002)(478600001)(52536014)(5660300002)(107886003)(26005)(9686003)(4326008)(8936002)(8676002)(41300700001)(33656002)(86362001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ShZk0/G4ozmgn+5aiwvQ+WmjFBUgGqz9l/Zr6PCXP0aLmbyjvx5Y4lPMqV3U?=
 =?us-ascii?Q?L3xAP6tLlqKEzIqrcuCPq+pnpt0WDDmSX97El0C6ki7H9LsQ3qHVlk3nRWSv?=
 =?us-ascii?Q?j1p6eJ07aC+aSFOek1kfR8wldAKdyCnJVhzwTenWzb00ZhFptM65fGX/wWwY?=
 =?us-ascii?Q?mxuZUoRV2M+y5PFDPwNq7kAUJtICS/NCoEpfs6Uu+hbcBTyHwtHHdN6XZdQu?=
 =?us-ascii?Q?z0G7na3CJ1AnsPzvfqe0bsBUVkX5GHn4hU2U5yViG0J1hSr7mUlLHj8FXvqs?=
 =?us-ascii?Q?RAT7XJ+o49pjwJSWSnREhJOFQ/Had7WlXuScBLedQLOzhhnhLLmjC6lGMFae?=
 =?us-ascii?Q?k9X01UcxPBAsepqrY0pCaZfeXGHLH6M01JTQnCDwXb2xUuKVK0i7lQ9rUVyh?=
 =?us-ascii?Q?hMGyle9GlAHqY9xBSqcG0U4K+nxdHQ0ErTIZrDpLtxP3vIX++xkuuBmBRGot?=
 =?us-ascii?Q?PE5rkzw6D00kbvbzfx/8XmWQY2CyxDPpZIXn6ppSUuPNOK/Kv6Xu3Av4HNYv?=
 =?us-ascii?Q?s1ZieebT3OwCdbzSuVRbjRl58al9Sfas8yRvau7AH653MIT6kNFV/THdWXyN?=
 =?us-ascii?Q?vlEgD0hTheg0eiPhOCuGOMAK+BsPOf/DmmZgQ+lIaZv218jLrVzV5omfVPAR?=
 =?us-ascii?Q?EUtnpYkSfZxbwrQY+RwYyuzb8FvvkDNdssMRfZ78N9Uxne47BL1cvjgT4XsO?=
 =?us-ascii?Q?MQECDNgwzAYAeNkmyLmddRWwC1s4cwIPj3tKuW9OgDvl6Wyfr3GN7ujMyVUr?=
 =?us-ascii?Q?HMINCP2KEGEc97U+bweoiKnISBgVxFK5yKPnER4owlx/goPSmuUc/EnvkRcy?=
 =?us-ascii?Q?aseNjt9Iv4Vv3aVbqdulESr1vgB6QbBMuag6awYLOSxPk7KRKwkCJ9Zhachn?=
 =?us-ascii?Q?3a3+SZnLErTwXZthCumn3l+4MNCzMRayAtaTDVnumg3ChTUi798H58cCm1ZS?=
 =?us-ascii?Q?lIKiIv3k2KnRPPn42mTP0O108kQb1KkdisW4HrEcrY/B9QKlisa7c0qofbt6?=
 =?us-ascii?Q?Tv7oi3dSUcPlfr/hyCPPIxPaLS/XRBoWOPOzmZULtWkWEYM1C5goV3SQbLKI?=
 =?us-ascii?Q?eMt6o1t+FiiftMFfsh4saJGh7QVdrztgBCBaV2dIyHh4yg1I2a7Yz4/u/ozB?=
 =?us-ascii?Q?IChXExvq1ZNptUsL/g7TyrXgBpcvcoX4dqxnSw+m1sPCd8ojpn1MU0KhKEgB?=
 =?us-ascii?Q?JO+Sml8v6EY7Y+zUb4tZOk0qEDn3xC+CkGTmWBEHkrFMJibmVWXlYK1xIMWa?=
 =?us-ascii?Q?j5DC+YybiCfWdDgp3Pi/+C7vbDAl5TMFjd6u9HJZjGwC6iEEK9E09xczIqeW?=
 =?us-ascii?Q?nyL0C4TP2oi0eaUmU3aegkg9g9Nw4KGB+PmxAeot6upQ503ITwobVWPcYSmV?=
 =?us-ascii?Q?RfU3kKTOOfb7K3j8Udbc80mb5WkC2K4EMFUiGAb6SCEVbFtPyLddGuzWM19A?=
 =?us-ascii?Q?w48d+plo89yt8V1vTc61xS8GrMXT/fZfu3+ipRU6+Nxlko3vB8aOKMyX2P4/?=
 =?us-ascii?Q?4JJaDdCe9BGHRE5mpBfqKfpx+nOaCwBNE2nyHcmvwlA9kReSA/n6IJMFEQYR?=
 =?us-ascii?Q?Ex6Gs8Kxq48LWBv0wZrzw8VwMbMSpKdEsOF67WK9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2aab83-8574-4944-f942-08db9f11ecf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 11:05:54.2001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z56nP0+xm5fBnwWFChDuCbSs0meIm2hpOa1eIm3l+XCD0bfvwubdTirhdIQ2zPXFinqfiYIaTltZCZu3mQLibsnYRX6Z6bq9IbDRMp+DEKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6152
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:06:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12755

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 00/31] Add Renesas PMIC RAA215300 driver a=
nd
> builtin RTC support
>=20
> Hi!
>=20
> Thank you for the series. I'll have minor comments on 6.1 version, but I
> don't think we should take these:
>=20
> > Alexandre Belloni (9):
> >   rtc: nvmem: remove nvram ABI
> >   rtc: rv3032: fix nvram nvmem priv pointer
> >   rtc: fix RTC removal
> >   rtc: introduce features bitfield
> >   rtc: add alarm related features
> >   rtc: expose correction feature
> >   rtc: rtc_update_irq_enable: rework UIE emulation
> >   rtc: expose RTC_FEATURE_UPDATE_INTERRUPT
> >   rtc: isl1208: quiet maybe-unused variable warning
> >
> > Bartosz Golaszewski (5):
> >   Documentation: list RTC devres helpers in devres.rst
> >   rtc: add devm_ prefix to rtc_nvmem_register()
> >   rtc: rework rtc_register_device() resource management
> >   rtc: shrink devm_rtc_allocate_device()
> >   rtc: destroy mutex when releasing the device
>=20
> Changes are not huge, but this seems to touch every rtc driver, and I
> believe is too intrusive. Could the isl1208 driver be made to work with
> 5.10 APIs?

I will have a look. If you see the patches most of them are bug fixes
and enhancements which cleanly apply on top of 5.10.

Anyway, will try to make isl1208 driver to work with 5.10 API's.

Cheers,
Biju

>=20
> Thanks and best regards,
> 								Pavel
>=20
> >  drivers/rtc/rtc-88pm80x.c                     |   2 +-
> >  drivers/rtc/rtc-88pm860x.c                    |   2 +-
> >  drivers/rtc/rtc-ab-b5ze-s3.c                  |   2 +-
> >  drivers/rtc/rtc-ab-eoz9.c                     |   2 +-
> >  drivers/rtc/rtc-ab3100.c                      |   2 +-
> >  drivers/rtc/rtc-ab8500.c                      |   2 +-
> >  drivers/rtc/rtc-abx80x.c                      |   2 +-
> >  drivers/rtc/rtc-ac100.c                       |   2 +-
> >  drivers/rtc/rtc-armada38x.c                   |   2 +-
> >  drivers/rtc/rtc-aspeed.c                      |   2 +-
> >  drivers/rtc/rtc-at91rm9200.c                  |   2 +-
> >  drivers/rtc/rtc-at91sam9.c                    |   2 +-
> >  drivers/rtc/rtc-au1xxx.c                      |   2 +-
> >  drivers/rtc/rtc-bd70528.c                     |   2 +-
> >  drivers/rtc/rtc-brcmstb-waketimer.c           |   2 +-
> >  drivers/rtc/rtc-cadence.c                     |   2 +-
> >  drivers/rtc/rtc-cmos.c                        |   5 +-
> >  drivers/rtc/rtc-coh901331.c                   |   2 +-
> >  drivers/rtc/rtc-cpcap.c                       |   2 +-
> >  drivers/rtc/rtc-cros-ec.c                     |   2 +-
> >  drivers/rtc/rtc-da9052.c                      |   2 +-
> >  drivers/rtc/rtc-da9063.c                      |   2 +-
> >  drivers/rtc/rtc-davinci.c                     |   2 +-
> >  drivers/rtc/rtc-digicolor.c                   |   2 +-
> >  drivers/rtc/rtc-dm355evm.c                    |   2 +-
> >  drivers/rtc/rtc-ds1305.c                      |   5 +-
> >  drivers/rtc/rtc-ds1307.c                      |   5 +-
> >  drivers/rtc/rtc-ds1343.c                      |   5 +-
> >  drivers/rtc/rtc-ds1347.c                      |   2 +-
> >  drivers/rtc/rtc-ds1374.c                      |   2 +-
> >  drivers/rtc/rtc-ds1511.c                      |   6 +-
> >  drivers/rtc/rtc-ds1553.c                      |   5 +-
> >  drivers/rtc/rtc-ds1672.c                      |   2 +-
> >  drivers/rtc/rtc-ds1685.c                      |   5 +-
> >  drivers/rtc/rtc-ds1742.c                      |   5 +-
> >  drivers/rtc/rtc-ds2404.c                      |   2 +-
> >  drivers/rtc/rtc-ds3232.c                      |   2 +-
> >  drivers/rtc/rtc-ep93xx.c                      |   2 +-
> >  drivers/rtc/rtc-fsl-ftm-alarm.c               |   2 +-
> >  drivers/rtc/rtc-ftrtc010.c                    |   2 +-
> >  drivers/rtc/rtc-goldfish.c                    |   2 +-
> >  drivers/rtc/rtc-imx-sc.c                      |   2 +-
> >  drivers/rtc/rtc-imxdi.c                       |   2 +-
> >  drivers/rtc/rtc-isl12026.c                    |   4 +-
> >  drivers/rtc/rtc-isl1208.c                     | 146 ++++++++++----
> >  drivers/rtc/rtc-jz4740.c                      |   2 +-
> >  drivers/rtc/rtc-lpc32xx.c                     |   2 +-
> >  drivers/rtc/rtc-ls1x.c                        |   2 +-
> >  drivers/rtc/rtc-m41t80.c                      |   2 +-
> >  drivers/rtc/rtc-m48t59.c                      |   5 +-
> >  drivers/rtc/rtc-m48t86.c                      |   5 +-
> >  drivers/rtc/rtc-mc13xxx.c                     |   2 +-
> >  drivers/rtc/rtc-meson-vrtc.c                  |   2 +-
> >  drivers/rtc/rtc-meson.c                       |   4 +-
> >  drivers/rtc/rtc-mpc5121.c                     |   2 +-
> >  drivers/rtc/rtc-mrst.c                        |   2 +-
> >  drivers/rtc/rtc-mt2712.c                      |   2 +-
> >  drivers/rtc/rtc-mt6397.c                      |   2 +-
> >  drivers/rtc/rtc-mv.c                          |   2 +-
> >  drivers/rtc/rtc-mxc.c                         |   2 +-
> >  drivers/rtc/rtc-mxc_v2.c                      |   2 +-
> >  drivers/rtc/rtc-omap.c                        |   4 +-
> >  drivers/rtc/rtc-pcap.c                        |   2 +-
> >  drivers/rtc/rtc-pcf2123.c                     |   2 +-
> >  drivers/rtc/rtc-pcf2127.c                     |   4 +-
> >  drivers/rtc/rtc-pcf85063.c                    |   4 +-
> >  drivers/rtc/rtc-pcf85363.c                    |   4 +-
> >  drivers/rtc/rtc-pcf8563.c                     |   2 +-
> >  drivers/rtc/rtc-pic32.c                       |   2 +-
> >  drivers/rtc/rtc-pl030.c                       |   2 +-
> >  drivers/rtc/rtc-pl031.c                       |   2 +-
> >  drivers/rtc/rtc-pm8xxx.c                      |   2 +-
> >  drivers/rtc/rtc-ps3.c                         |   2 +-
> >  drivers/rtc/rtc-r9701.c                       |   2 +-
> >  drivers/rtc/rtc-rc5t619.c                     |   2 +-
> >  drivers/rtc/rtc-rk808.c                       |   2 +-
> >  drivers/rtc/rtc-rp5c01.c                      |   5 +-
> >  drivers/rtc/rtc-rs5c348.c                     |   2 +-
> >  drivers/rtc/rtc-rv3028.c                      |   6 +-
> >  drivers/rtc/rtc-rv3029c2.c                    |   4 +-
> >  drivers/rtc/rtc-rv3032.c                      |   8 +-
> >  drivers/rtc/rtc-rv8803.c                      |   5 +-
> >  drivers/rtc/rtc-rx8010.c                      |   2 +-
> >  drivers/rtc/rtc-rx8581.c                      |   4 +-
> >  drivers/rtc/rtc-s35390a.c                     |   2 +-
> >  drivers/rtc/rtc-sa1100.c                      |   2 +-
> >  drivers/rtc/rtc-sc27xx.c                      |   2 +-
> >  drivers/rtc/rtc-sd3078.c                      |   2 +-
> >  drivers/rtc/rtc-sh.c                          |   2 +-
> >  drivers/rtc/rtc-sirfsoc.c                     |   2 +-
> >  drivers/rtc/rtc-snvs.c                        |   2 +-
> >  drivers/rtc/rtc-st-lpc.c                      |   2 +-
> >  drivers/rtc/rtc-starfire.c                    |   2 +-
> >  drivers/rtc/rtc-stk17ta8.c                    |   5 +-
> >  drivers/rtc/rtc-stmp3xxx.c                    |   2 +-
> >  drivers/rtc/rtc-sun4v.c                       |   2 +-
> >  drivers/rtc/rtc-sun6i.c                       |   2 +-
> >  drivers/rtc/rtc-sunxi.c                       |   2 +-
> >  drivers/rtc/rtc-tegra.c                       |   2 +-
> >  drivers/rtc/rtc-test.c                        |   2 +-
> >  drivers/rtc/rtc-tps6586x.c                    |   2 +-
> >  drivers/rtc/rtc-tps65910.c                    |   2 +-
> >  drivers/rtc/rtc-tx4939.c                      |   5 +-
> >  drivers/rtc/rtc-vr41xx.c                      |   2 +-
> >  drivers/rtc/rtc-vt8500.c                      |   2 +-
> >  drivers/rtc/rtc-wilco-ec.c                    |   2 +-
> >  drivers/rtc/rtc-wm831x.c                      |   2 +-
> >  drivers/rtc/rtc-xgene.c                       |   2 +-
> >  drivers/rtc/rtc-zynqmp.c                      |   2 +-
> >  drivers/rtc/sysfs.c                           |   2 -
> >  include/linux/rtc.h                           |  23 +--
>=20
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

