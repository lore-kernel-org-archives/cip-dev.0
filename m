Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF90EB64DD
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:42:58 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.101])
 by mx.groups.io with SMTP id smtpd.web11.185020.1692272574654800172
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:42:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=MWlb0+AR;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.101, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC+UDO+NgqKYT8wiI7yf0+NoD6VOKUiK/LA/uAsooqiS2pZ/A2zJJqDRGUJO9k43oFZ1XXaUnkx5BeAPmrL1euEIH45p+hrnLjMWYWbPwBUTiJnCrYJjHidZilxgreCQbSAn3tPlcv2cS3cT6O1CnKy7EFtGHtOvs39qcfScdCr0S2YAdhiUEjf/WCnpYQUhLuguxPsBqi4eKDEpOHLrvydwWelKPGYiGXTzwDwV+m2I4CKCo94TpzG/hl+9Sjgq7socWfNXdchs4awmbugfwmHkUy3aX8xfjveO0BGLD2r4qCdKv9YiD7WGO4HOyhs9iV2Cwa82Q16YlQgT03kx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHwHoTfLXkNZ5M58J0OVKxQSXv8aNbF3VNBHtNyBHyE=;
 b=XwYrWAEOvyd4hlVKdC1fOd1tuX5tQfsKdAwDs7oGHXcTm3cne2OjC2LtN9MAS8kGQphu3gptY1A5J/IoyoeclJ34GCaNV4c7ja+9AzbfKaW7V9puzbEIH7FWWKWog/zy3KNrv5Iesce1LaOLDVWBuN1Tf2mJ4iTURAZDDoDhtSaYg2KzJ7Ul6JiJwMJZSoBGvHRULbg+CzlyAczSRACgElvlLCTog3LbyPVseyJxbJhbH0YJkhYO8gMgiNnzbA5wcm2N5afwveuz6m8QKY0xbyzgqcFlo41XdhUaTSEKSNaHUUhdDuvmnKbBxk6QjWJA7ENQI7ZK38XzmW2sjuDzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHwHoTfLXkNZ5M58J0OVKxQSXv8aNbF3VNBHtNyBHyE=;
 b=MWlb0+ARTUGH2Q5Cew7sV2PzbB2zPN67C7Obg1rO6djQNfh1OZ3QLlzCP7rizUCeYFfCWZIPfEMXmFZOL3DWoXfFGnV2Db7s2totdo1Zv1n3jQm0Cmgmr4tgh68wurD2xg/lBy+00ieeGKtiO4UBVVF5DAgzwvGmlMLf5668H00=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8193.jpnprd01.prod.outlook.com (2603:1096:604:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 11:42:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:42:50 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 02/13] regulator: Add Renesas PMIC RAA215300
 driver
Thread-Topic: [PATCH 6.1.y-cip 02/13] regulator: Add Renesas PMIC RAA215300
 driver
Thread-Index: AQHZ0E100m17uQrRP0CVNaQTghHK2a/uVTwAgAAH+MA=
Date: Thu, 17 Aug 2023 11:42:50 +0000
Message-ID: 
 <OS0PR01MB5922BA551BDB1C3BDBA8EAC2861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-3-biju.das.jz@bp.renesas.com>
 <ZN3/SjL50ls+3dnD@duo.ucw.cz>
In-Reply-To: <ZN3/SjL50ls+3dnD@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8193:EE_
x-ms-office365-filtering-correlation-id: 1765d2d8-4862-48ca-766e-08db9f1715bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 a9gURIoJSPsoD79ggL0TU/JeM/GdU8fLfGzT6IbCVX8TVHnMBE/D7/+kCzcGb1Spl8ViSXJh2uM3xC6acjArUA/vyDsD/WhGQTe9bcH7zY5tkEzI5lNWjE9eTzI61K+BHhbPUi9pnyo/MuIo7HhrSL1pvhANehwCGxTg60gVqrqDuNcNUtzIWz19o42s5ZgBvQ/YCkLxq4XvcPFqaofIEWANCq3DiRg8mK88Nx1WB3FPry6ottLBXgSGntUQdchQEwY4ampjD2EF0EA/ym1qqgpIZJTcDsmuLFTP9CJ8tsg3Qn++BqMLdBx7+mIPjRXtfHnaNG2gV7D7eY0/TCHvRgnaYpR0c9u6e3k7SlAqV1DyK9Qa90vrI7+ZQl9a5gPpmOD0fTQxmrpS0JaJA3mTT9F8ZElKWhfPEv0h7mSmYpBHAxyFdnwz+vklr/1tMgr7qkwrTRaYzs+JnTYWGCNReytNZMfgyuceVAM4GJJ2s16l3WsUh1NQF4l/CMVURek3g+ebIzVz6GyjKyC1/I5xoWIepoR+tgFHSbx2TImwzZSGL8OmpKIP2j9HieYVoSSPxx4uKGY5w86slHtcJptJTkA+Si+56ED4PIGAgob+IGc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199024)(186009)(1800799009)(66556008)(66446008)(54906003)(64756008)(76116006)(66476007)(66946007)(5660300002)(55016003)(41300700001)(6916009)(2906002)(316002)(478600001)(966005)(8676002)(4326008)(52536014)(8936002)(38070700005)(71200400001)(7696005)(6506007)(9686003)(107886003)(83380400001)(122000001)(33656002)(86362001)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?42u6cHfdWpqi/DD7XTxeyHKM+n07KWbxxqc4cvTJNHrR6K09nWvQorDEUFZn?=
 =?us-ascii?Q?cvce4ccUCrXkAfrLE3cxnfUfxr/njgneDY4OKnGpKeyKGHL1BaRmJFL2HWcw?=
 =?us-ascii?Q?xfja+pajrszMjH6c/ahlAtuJ2FsXzaCFQbngHuUq4D9RjqJFwpABeAGrmNAH?=
 =?us-ascii?Q?2otB5GV3Pq3KrgswL94B4QehQVr4BX+eIiuWafUgQPJtrY3BL9HKOms8NIsD?=
 =?us-ascii?Q?Z68vjcg3NFVwXYza+IaWpTNDh6YSi6kJ8s6B7xppJgQ7ycK7t6ErFT1VAp3z?=
 =?us-ascii?Q?BV0ssrfa7Ikpp2oV6lwlM3Il1xIqBX7gmeibIyG6rb0LZ3E3Ae9zyGDcitKT?=
 =?us-ascii?Q?51oZ2lB6F0uEpV4lB+mQP3Fr4KygG+WwHDb/EwmEqFErGi5Ay+6eXQPetcD0?=
 =?us-ascii?Q?d2yyFisynnb8feCeOW1ByoaaEM4WVuLsUYAL5GlAiiTFtjzs3GohOwuggzSq?=
 =?us-ascii?Q?QnwE6xMiIjd8slrQkft60zEvyAFZ5i5z81CD8nRy/6zmyRBrTzbGEEU+jd4T?=
 =?us-ascii?Q?EnzPqU/HtZ/CYDGJKVW1EuV19tWMoirGgSpYNYJcIn00sWOBPptOAyyVl9nZ?=
 =?us-ascii?Q?kMAEPbLg6pL7B48DvgRjmVBLMlTuTPyU6k3KZcFj7uiD6PWtMmNH5r29QOSO?=
 =?us-ascii?Q?pAo9Rs2SBu836H291uTYcgtdoBw+Oy0AXLEGP7p/1zAvwTGxiEyreSSX29G+?=
 =?us-ascii?Q?S41O5OmaPkOQ07hDfMflwihTx/h4kLi7LmcXSmNbhM2wkX2mRVtfiyhg4+GM?=
 =?us-ascii?Q?GFB4SnMJmhbJN3LrE7gnLuDVIAK04YH0lP/ZbZjg0EB+yuiVnqEuKSD2QFNi?=
 =?us-ascii?Q?U6VTKb8yZhYETSYvVVKnKGf9x0FC1lI40MVOJek6MXGqeEykSONZS5Q1A/sm?=
 =?us-ascii?Q?2Ps2HekEzpdGP7NWOPPj/pJOpeaGDEpCU3KTV78iUWQa2gnSmCE93oNZTWrX?=
 =?us-ascii?Q?N9bq1ON+zpxhA4/AYBdGb/+cBtJWED+3nh75lzeFYPFANl2oFIKksHU40381?=
 =?us-ascii?Q?IAllxnQEa/bhWvslhk7sRrazw+Az7W07ZUOflFT8bcDPtDFN/JmfrvXzVXgu?=
 =?us-ascii?Q?DyKnXyu0pdBBGJIgCYovkblF0Bgqee2nc0MGdm0vP7VZ7vx37Wg+dj0qolYu?=
 =?us-ascii?Q?+Ychn+aEf6hhHH1sSktjqGDgcrYg6VoSWU8kT6V/BYrELGl/n3lp2sTlYp6r?=
 =?us-ascii?Q?HJuARjoGAFAzXQ7UT5ZXzEsVn2jZ3ORyt4Rr4azhj8OwZnGzF/SzVXBQgV8n?=
 =?us-ascii?Q?Zbutm8ijFiV7lC7vSYBpbc+uNFSMygK86f9v8kdIei2Cn4s22qHvDP30J8Zp?=
 =?us-ascii?Q?YT+dA/noRZR4v3xnwgsWwGgWnfLZsc/aGB0mrK4sfkx/9LfamZfwWWLCxCu2?=
 =?us-ascii?Q?gtAgunEgR44AglvCilrBgoT1TuKoQ6Ung0Rp77r9zCRZU6WrOE7u6QyerwDy?=
 =?us-ascii?Q?HuFjC9q6Iz+PlEvR2/1UPuKKiFCdyqAgtz1e31N2/5uwSGFicalBlFhYWJHo?=
 =?us-ascii?Q?jJAQCGmk2RDs74aGf72JXs74QqHgaIDnRD94exprHLn1G0voIgORvS2vLATV?=
 =?us-ascii?Q?UDKqr58rdxOpj40UwxpdZXQQMOw7pVK6bWB/I7MS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1765d2d8-4862-48ca-766e-08db9f1715bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 11:42:50.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRrZj7j+X2qd+a+J5e/b+J02lutsglVzy1hQ87U8o41fZhJigUMO5+mjMedsslp9jztl3lLgeS3d7a5HDcXJCTb3WEK+wtYt8mZBc80TWHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8193
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:42:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12764

Hi Pavel Machek,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 02/13] regulator: Add Renesas PMIC RAA21530=
0
> driver
>=20
> Hi!
>=20
> > +++ b/drivers/regulator/Kconfig
> > @@ -1016,6 +1016,13 @@ config REGULATOR_QCOM_USB_VBUS
> >  	  Say M here if you want to include support for enabling the VBUS
> output
> >  	  as a module. The module will be named "qcom_usb_vbus_regulator".
> >
> > +config REGULATOR_RAA215300
> > +	tristate "Renesas RAA215300 driver"
> > +	select REGMAP_I2C
> > +	depends on I2C
> > +	help
> > +	  Support for the Renesas RAA215300 PMIC.
> > +
>=20
>=20
> "Say M here ... the module will be named..."?

Ok. Will fix this.

>=20
> > --- /dev/null
> > +++ b/drivers/regulator/raa215300.c
> > @@ -0,0 +1,190 @@
>=20
> > +static void raa215300_rtc_unregister_device(void *data) {
> > +	i2c_unregister_device(data);
> > +	if (!clk) {
> > +		clk_unregister_fixed_rate(clk);
> > +		clk =3D NULL;
> > +	}
> > +}
>=20
> This one looks suspect. Should be (clk)?

This is fixed in [1]
[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20230817&id=3De21ac64e669e960688e79bf5babeed63132dac8a

>=20
> > +static int raa215300_i2c_probe(struct i2c_client *client) {
> > +	struct device *dev =3D &client->dev;
> > +	const char *clk_name =3D xin_name;
> > +	unsigned int pmic_version, val;
> > +	struct regmap *regmap;
> > +	int ret;
> > +
> > +	regmap =3D devm_regmap_init_i2c(client, &raa215300_regmap_config);
> > +	if (IS_ERR(regmap))
> > +		return dev_err_probe(dev, PTR_ERR(regmap),
> > +				     "regmap i2c init failed\n");
> > +
> > +	ret =3D regmap_read(regmap, RAA215300_HW_REV, &pmic_version);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "HW rev read failed\n");
> > +
> > +	dev_dbg(dev, "RAA215300 PMIC version 0x%04x\n", pmic_version);
> > +
> > +	/* Clear all blocks except RTC, if enabled */
> > +	regmap_read(regmap, RAA215300_REG_BLOCK_EN, &val);
> > +	val &=3D RAA215300_REG_BLOCK_EN_RTC_EN;
> > +	regmap_write(regmap, RAA215300_REG_BLOCK_EN, val);
> > +
> > +	/*Clear the latched registers */
>=20
> "/* Clear". I would not mind checking errors from regmap here.

OK, will fix it. I checked most of the drivers are not doing
Checks for regmap in kernel. As you suggested will do it here.


>=20
> > +	ret =3D raa215300_clk_present(client, xin_name);
> > +	if (ret < 0) {
> > +		return ret;
> > +	} else if (!ret) {
> > +		ret =3D raa215300_clk_present(client, clkin_name);
> > +		if (ret < 0)
> > +			return ret;
> > +
>=20
> dev_err_probe would be consistent/useful for the other returns?

OK.

>=20
> > +		clk =3D clk_register_fixed_rate(NULL, clk_name, NULL, 0, 32000);
>=20
> Elsewhere, you use 32767 for a rate.

I need to check with hardware people, whether 32K means 32000 or 32 *1024=
=3D 32768? and then update.

Cheers,
Biju

