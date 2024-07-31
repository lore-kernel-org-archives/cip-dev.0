Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7209C49EA1
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 13:08:28 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.43])
 by mx.groups.io with SMTP id smtpd.web11.42526.1722431299836473485
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 06:08:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=IGWCcUin;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.43, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvrPpoIdDmlOinDcM7cqZlZ/XhYLaDLPHtAM6gsmSDq+hPR5awtMisD0wiRfW1/s7iAa7cfnoVS5Z3xr5j1+0Fc4cy5O1Fol8v1ExiaSPnjWRxlezxZH2VKkNksRNyAYajHE46DdIDW7Zu85LGFTDZsZREvLzQu/obpdX6hAc3XZ64ghiPY65tUb7PvJdRi6aoAA4BGW+KBnWQMYY2Jc7cFwVFEXPu8FcC3Amw7bTGy51raI6whLfgOHzFTiVhGSX5OGp1lbVNzSTU8vR/1i9t0nCJr4Fx3I/S7czY0KrCDMbHXsmwDQs+iEP7u0DWGC/TvtLu+vVNTHCrVJZCUK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFYUIZTfVncMeIpye6g3XvylrBYAVMFgoM9XHzTrfC0=;
 b=YYnDvYaIEWMso4vCEk3LhetJlVlDiEDs2O84eZfZVtuEtuvBM+EI+oHEPWpjm6izx6gyuGw6c3q+hx3xdkPVbt6120OZSEMFfVqBhIpV/b/uuZRFyzOuPdwLksmAygkr3dubdnSDx2/6EjQvfek/LjmqBqibZzAU8Fz9mAKuCQerPrmsVL4S7XaE3oYn9TUlaJI2QpT5aRMxr2PqpHZjHEp6MDOLfhokgegxo2knp5Xvb2f5QACvA7FZdp0praWKFqIGZ7EbCBpge63X7ZoXsTcXEYUy+VhbLD9c6B58QtnYsEys8tIHsrwLcgHIDZozfsRh3v9/00N8VKK+XIuM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFYUIZTfVncMeIpye6g3XvylrBYAVMFgoM9XHzTrfC0=;
 b=IGWCcUinHrn0XSFRVl1xBn96pJlYuw+PJ4GaNeuGxSD/mukJkEGOWeVcPjYyVPlAOMB6GHSMgA9fTCp813L6zuEdVorZAysNyfS8EWr0XOPeD0aA5I7nqxJCQKB0AzA5RIhvF7BuxFw9PgHvoU922CzpLvgo7G6d8ValX4c93kE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB10397.jpnprd01.prod.outlook.com (2603:1096:400:242::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 13:08:15 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:08:14 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 02/13] regulator: core: Add helper for allow HW
 access to enable/disable regulator
Thread-Topic: [PATCH 5.10.y-cip 02/13] regulator: core: Add helper for allow
 HW access to enable/disable regulator
Thread-Index: AQHa4cznvSDg6CT1lUGoLEBt5qpW2rIPNFGAgAAASYCAAWpNAIAAMIcQ
Date: Wed, 31 Jul 2024 13:08:14 +0000
Message-ID: 
 <TY3PR01MB113464E2D6F6E1F59BD4C59BC86B12@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
 <20240729153504.510443-3-biju.das.jz@bp.renesas.com>
 <ZqjcY1fp1uw+HW5q@duo.ucw.cz>
 <TY3PR01MB11346EB79E7AB9D5CECF88C4086B02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ZqoMjD5bskPB3Qzq@duo.ucw.cz>
In-Reply-To: <ZqoMjD5bskPB3Qzq@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB10397:EE_
x-ms-office365-filtering-correlation-id: d1f92fb1-73bf-4b5c-643e-08dcb161d646
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?MCOtnFTi6SyzvYgK2tHfsRka4GqOsCOw2vBWK7p6TBWavB/z7kXXk5VqoaEA?=
 =?us-ascii?Q?3C3U7iqkikvxnBfz1FZ+UK1vOyk/JkBUDISUA0QEoWyMlI+6JMa6CEkUmuq1?=
 =?us-ascii?Q?wDs3ktYzu1zRcKTKArMWis9fEp8NoXpoH2IS5ScxQ3ahBpuFl1Y+3iq/SQlY?=
 =?us-ascii?Q?sNRDpXeAMadsH86n4zmS6wrInvEesVYzGF/MmsA6zsP7EyTM9kRMagioaJX1?=
 =?us-ascii?Q?9TfzLkh/Q7v6fVIsRf7NtiednpO//la9kT4w3iPYNuYma3LC/LWHqWfY3mzm?=
 =?us-ascii?Q?IYyv0q8gjHXtJ2nMbYlSzsq2t1Bns3LYhDgQf3e4iIGunNz5bDO+hcdpooaJ?=
 =?us-ascii?Q?xE5mOt053tWhDjNxEdU441UxhOotqDN0abJauXkLMZrKTJHGUzYISvbGnsK3?=
 =?us-ascii?Q?ag0+kqPimlY6k2S3hmY0VYdy8XUF9Lu9OUCmLPcf/+kN3Q/x2gkkpKxJc4Z6?=
 =?us-ascii?Q?I1xb7krU4fiuSn5qS8rbGKJNYt94NO1HWSCXn3eo4hiYMbkUZNBt6fvtMWIs?=
 =?us-ascii?Q?fhw29haAAJ9ibcSBLIGfwBfHkIvxEhTIDmlT7vZVBnCGsR2biqk3j0g9blyV?=
 =?us-ascii?Q?qe5RFf+ApdXd/nflcWjY7Zq3ew+4llc/PkW/0ts6CASZ9Q07ekm3BxxDW1sK?=
 =?us-ascii?Q?5ZQ/NT95bk5q2xtv3FCi1moyIqw/KETOIjGgdndtH21NOc0V+uss1KoVsyc5?=
 =?us-ascii?Q?QcV44X6JznczQqUtZ9F4tVzwmthVu39jfGqkXsn3YjFJo98olcyAD+Dmom5K?=
 =?us-ascii?Q?iw+w4Wv9xOy7xmHN6HKoL6/CFIHgvorJBHoi94+Ewk+NZVlkxYzfqmxHbD7U?=
 =?us-ascii?Q?yseDUQn72Wb/1xd66BIP/vXUWppw8g4ooTnhzZLx3xgtTJixEQAaYiRGoWfA?=
 =?us-ascii?Q?a4gTR7LZqtQqMbL5VXmSaEgzNNIuH/h+Js9V1lbSjrDlSbi3+a1IzLR4XsLo?=
 =?us-ascii?Q?Q8Y59cU3mcNIPnmMRz/6mBaq8xqdftI6/10jfrK/iraMxi+qP6bsqH47RTXI?=
 =?us-ascii?Q?HYfH4URGRian4l48n2nFXMIngeOyev3S/ZpHQAc5Q5pyLFu6cptABdbG/cE9?=
 =?us-ascii?Q?zuHfCRh4Xli5kphz5TVOEfRu81uyJ6UBM1hK/PnNRnct8uMJRukKMx1CAOeK?=
 =?us-ascii?Q?ZqPxXnfPLlaFdReXrTz5+eInnugYFk5KYNykF1QlEwXAtKSmV42BRhMx8suk?=
 =?us-ascii?Q?ghgimYe5LPWO0mmepY5lJVHHboQWURuh6ZyKLqERZJGSoCCQc+pPI6VxQ/+m?=
 =?us-ascii?Q?NaFK8MlLh7DmDoToxKUVPfXH3HJnbko5c9fc4shtjRPDi0lXGU6+WmLrBuXY?=
 =?us-ascii?Q?/6U9Cf2J+oreIb/ctYb+/EJjkW81hJh8klsOFiMAVLPq1z+Bow9ib1KJcegJ?=
 =?us-ascii?Q?PpCc3IuRomq5snFhQa/U5cBAxCCP0gV3qa47U2ny2FYYzX9WRQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?U6VZsJzAlozBA+KRZU7epKvi5mbJ7rVXeiGB8hExzCyMtoRRrm7Re5OEhi0I?=
 =?us-ascii?Q?BJox0ZJfLNuUeYAiloN29zbBFLGRQLPWrtXGyvulQBv5/fXCbAvAby1cmpUY?=
 =?us-ascii?Q?ln/dBojlSPNh/4kC81gTf4njzQgQ03E4uWHDCn3YSVf4R5giaNHA7iLcF05w?=
 =?us-ascii?Q?tIZqi2skrU+ClVvQxJAwoKkVGzpSZ68LxvPknoFeVY06x5AfSC2Kle1qzKht?=
 =?us-ascii?Q?ed1zAhBELKywJ36FMSHlqmRx1fFsvNn9QQ8hBueyE/+b/yY3hvAe4u+yB98F?=
 =?us-ascii?Q?rzlZs6bJD2s0QAczdXlVW8gDmxYX6ATR0KRYMezIr/Q4g6EQyTT+yxbPone6?=
 =?us-ascii?Q?WhiNxsWxzjk6nJltn1oZ5qxq3wqGi4Anp16O7YLD5YsZMd/XEcv5XBO9YfD0?=
 =?us-ascii?Q?wJ/QFzS8XJHjKApSNoyiisdp/nixd5cfIqTSNTwsyUF/ooeq38UIJTOTL/qW?=
 =?us-ascii?Q?626Uj+aIMXn2BoVH3WMreR1pUJcx/a3AoRHFmc3k7U9OcHT5D+oBxCKw+m6g?=
 =?us-ascii?Q?pz3Ey34mvEWCBj6dTNHFgrvP7MQWJuLCNNgc2JKuGIo7RznhZfDNJNYvMifW?=
 =?us-ascii?Q?riEwMVPFK6nBMWCy4ttFy8NNkmzwuBxjjMNxrr3pbH9dUnNaS3DrcARjZMYw?=
 =?us-ascii?Q?tx0TlaSWjrIKd7fTpPfonpeg6PPJpFXU0od6V5Xni7EhGpMv55f9HccH8xd6?=
 =?us-ascii?Q?m3u3ssBYj2ijKCwGkiwhRTo5GGQwWgzZiQuBxP/jB2upPr0pDmFWc4ftNV7b?=
 =?us-ascii?Q?eynbKJA37vhYv9kBbCQb16tPjcWMsGNNvycF4GfCJ/4vXtAWPxrg2olHbHVm?=
 =?us-ascii?Q?U/W5x4/YMef9pITmhN3zQmztviWqTGQ3sFcO3NxNNWCQ5Xef/4qIxc9q45gK?=
 =?us-ascii?Q?gFYeNOlx+4yT4CLITINgxyvrZ4wVqeTYaGM8gr64jSTBQ/p3Rq4ksySWALfF?=
 =?us-ascii?Q?orV114/uJRPpDkVpKKgd4D8N7XcHRHqR/rQwAhQmI6x9n+N1CjLVxXsrY9Wu?=
 =?us-ascii?Q?ErQsvzgSC9kgBTvYcX8zlgZ5q0Z42SlslY+7hwtJ0nUyEpREmzdRXUAYgrB/?=
 =?us-ascii?Q?/Tx9S0vM0fOKZ5WaHYfW25PQGvPdrTIKkseDu452VBOJ8LjHNl2N7SN7P1cf?=
 =?us-ascii?Q?/mQxziSEmIi+iIbmVMOU63EF/3Xl4CJ9q8WLkjG5/rjN7gqk9g2CTQuqrVLr?=
 =?us-ascii?Q?8bBxr9CFnMHZnCMQgcnloMterInN/hkA8NoBVTv6FCcTAW5iJ8hWcAX69Vp6?=
 =?us-ascii?Q?WZx9XM9+yxOnpFa4WC0pxigdE9DNixvWQrDfMMCBySDLVJLu3wFJ+hQJ6C0D?=
 =?us-ascii?Q?rAVdnlI/xML1BER03jLEUaUajzyWsO6fka7si9aHjUXH6cvzRgOCFDQSn5sP?=
 =?us-ascii?Q?sJyRR736namKvF1WBrxeesA1ZY7ZvVgP+nH/UlvJEgo12FoBqNVd+QKb+f4q?=
 =?us-ascii?Q?Dj8jZYV3+rfmycUooyuTIjYZcByphhx9cPKD116l1fXdZqBIKLempTMziUo+?=
 =?us-ascii?Q?7wCCR0xb7BrYMBIW7ak/XhOPjmhMBv7ADnjNYk+yyjF9M0GsrhwrIXxVZf3e?=
 =?us-ascii?Q?JV14Gb4dNxjJ4VDHdd5fo+8mFyChmwlIMB/KdL2kIDLTdYxg+4ucrMt2xugX?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f92fb1-73bf-4b5c-643e-08dcb161d646
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 13:08:14.4529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjLwwX3IAjzr4OqdkxWIaSE4KOJZBxcJykR6iu+1bXZBvxuA2jcuywAQDvHZjNEoyc47lpgli62D2RCsdGSZrUdoKtmUT8oRdVh5R5f48JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10397
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 13:08:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16695

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, July 31, 2024 11:06 AM
> Subject: Re: [PATCH 5.10.y-cip 02/13] regulator: core: Add helper for
> allow HW access to enable/disable regulator
>=20
> Hi!
>=20
> > > > +++ b/drivers/regulator/core.c
> > > > @@ -3244,6 +3244,34 @@ int regulator_list_hardware_vsel(struct
> > > > regulator *regulator,  }
> > > > EXPORT_SYMBOL_GPL(regulator_list_hardware_vsel);
> > > >
> > > > +/**
> > > > + * regulator_hardware_enable - access the HW for enable/disable
> > > > +regulator
> > > > + * @regulator: regulator source
> > > > + * @enable: true for enable, false for disable
> > > > + *
> > > > + * Request that the regulator be enabled/disabled with the
> > > > +regulator output at
> > > > + * the predefined voltage or current value.
> > >
> > > "Unlinke other functions, this can be called ...".
> > >
> > > And fill in the blanks. "from interrupt context"? "with interrupts
> > > disabled"? I'm not sure what real limits are. Probably can't do that
> from NMI?
> >
> > From interrupt context provided the callback function does not uses any
> sleeping calls.
>=20
> So the contexts allowed differ based on what low-level driver is used?
> That's quite unfortunate...

The only limitation is it has to be exclusive usage. Other than that it is =
for generic usage.

Ie, can be used for regulator_gpio_enable or regulator_regmap_enable()

Currently regulator API won't allow you to enable or disable() in atomic co=
ntext.
But this API allows to you do that.


Cheers,
Biju

