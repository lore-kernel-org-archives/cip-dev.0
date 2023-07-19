Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE541C001B0
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 13:19:46 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.139])
 by mx.groups.io with SMTP id smtpd.web11.13483.1689772784750675313
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 06:19:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=fYA8HPm+;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.139, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoxVgcXaubkA7JA+DFRqbaOdEgCQTW3PLGfQB58F6s41+HO4UGev+X3ficbmvUvLhNeXUxYejyIlaR0j2uqjZj+QA0RYLGtaCDL1Ye8RrQKz8cV0a73Jj9E03ighyCO33HizF4OelH3j4fSQdloPqgWBKAUOLgko9M31w48FsPxLCrcFFdvVTQAvj9yOaWDOuWA6oQaghZCGFcozhQm16C0MAtVOYWF3fP59N585WoMHC+sD4AmL2wA2O0inbAGXDdTtvJRINd+gDPQkB55MNcReGpsHS8YmZBkd2pL63NLM5NuqecvJaofvSkbbRdcDzyj2ycpiB8p/5GJcgcWyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9cAMkBsH7xzNS0rm1WtqI4SOv4u4JFl1t1CL93d0us=;
 b=DLkqbSguOSezz4luDXAYAkFcs51AFWMFqDxbk46A9LSohYbQFS4AfgrmNRvbg72HTOFeMRQK8GwVqaCpMhhvFQrcpI45SoXyaEn6I+Hf8krj0j0cP7Ay19oGhutWZnH+udTjU2gjaqQjWW9qFsw7bEn2c0z/DPpta1pwkYeIpqmIn74/9rXRUrmPwZElBt+jfA2l8bGxLUq+h1RSbyUsE/FyTvFp//6zs+Gd/HOUxEHUycpmrjhQwoyrYhu1YtfVwPTobBqSTDh8FtECfQ6Eay4BZUTTSPUx4DnRFsO0u0yW0Z52Bb3dJuY3OLUqT+scJlXFS6YMaT77hbEtNRsZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9cAMkBsH7xzNS0rm1WtqI4SOv4u4JFl1t1CL93d0us=;
 b=fYA8HPm+S6+T2Ajpgr5L9Qc/CebwlY6MSI8znarOJVI8AEJ7Sih3FK7xMY9WwScx43+b6PHcsKyG6K/P5gFaxWSoSbMggWvV5K19l4HzBgK56IyNsU5CwZFbEgR4B0qZJ/hzB5TDTMZ85OD/FIb1KNMNvub5VhkpiO8bT8eIyB8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5359.jpnprd01.prod.outlook.com (2603:1096:404:801d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 13:19:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 13:19:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 05/13] mfd: Add Renesas RZ/G2L MTU3a core
 driver
Thread-Topic: [PATCH 5.10.y-cip 05/13] mfd: Add Renesas RZ/G2L MTU3a core
 driver
Thread-Index: AQHZuj0fKbplmhs6R02p7GEx7xzrfq/BD3kw
Date: Wed, 19 Jul 2023 13:19:40 +0000
Message-ID: 
 <OS0PR01MB5922D9826D87474A68DAD8308639A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
 <20230718140608.119449-6-biju.das.jz@bp.renesas.com>
 <ZLfX6EeK4JPuOsqZ@duo.ucw.cz>
In-Reply-To: <ZLfX6EeK4JPuOsqZ@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5359:EE_
x-ms-office365-filtering-correlation-id: 5b70af41-980a-4dfc-49bb-08db885acf14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2VmMFGvnEw22wXAtj0DHgnPrXHuJS4y/o6cMdQISZttVlbm+xdNAggEZEJAaa2dR5gThEnOj7Y9Aq5Q8bnFwRsFFLrgA/H9pFY3UJ0okQe8yx49LYV22G7VJrE3sLRf/ue1ygiB6ZbPMlc3VwW+yakN2CG14STel7dDVERQxa2UTPDXOD1YBSlzpqSkqeRRcF3itnAt/7J63YVkDu9/P64MfAlBSbIvWRk74NeQfDAkCBpRT9CGQ++zwYc5gnhFRAdnMQ442DfrLtP9fqMln3laDEYFDk0nzkK0/oqQRK+vCYVSVC62ACnmU0RxflzpXZg5PA3pRq5pKpQ6H/nNWUOZqk5qlWxMqn04NWnBE63wNxaTTmK0lz+EotMys4Dzvwq3x9uPcQpz4mRx4ilK3pdB3pooHVc4vNLjxAwMuBWFIbAvFT8W4WLq0BIsQEKFylc248yIUdarC9k5A6DonfOqhqM9aRI/CPoOWvteK+Z96iLD0ZXXq3T6KNqUYpMh8jnb7P2KA9z1jp6ADOZ5j/fMnrnz8lc+aXD52Se5WPCX6yo9yt3DT9UYazo+8kWWcO036S5U50lGg0UWOO2FggwSmQEBLvlcHG++FT78aHeCuAdqxFGsRcDdrfk0gDmy2r95NOT4+sy1ddgbMrVMgvA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(6506007)(9686003)(55016003)(107886003)(54906003)(38100700002)(122000001)(38070700005)(52536014)(76116006)(5660300002)(2906002)(86362001)(4326008)(41300700001)(4744005)(316002)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(33656002)(8936002)(8676002)(7696005)(71200400001)(478600001)(83380400001)(186003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6Vl+GSUmwByRvDK2wcYNRyJ5jcbWsrl6Af98sD3+sBtKqoVGNKMDCBUatOag?=
 =?us-ascii?Q?/HtI0pS7LGwG7sjnkLVdd8NZDg0IDqr0XPXkY6ikgpZEn6opg/iydQw0/gxr?=
 =?us-ascii?Q?kj3hNZcX1Nqohj3KwCJv+n+DTRafXYrIsWNGsF3OlZoO9M6ib3ep+xs0bFZ7?=
 =?us-ascii?Q?PdGrC9EcQl5Mh5z9Sdo6G9yEGu/CrEPZG/mKkUyczTMebIMs+zxRHKKmEtzl?=
 =?us-ascii?Q?Gw4ph6umgRyh4LWyx9Quksgjc/3F0N6NdYGyhUPfd5vryuLoLU2160NRWsCd?=
 =?us-ascii?Q?Ldc9pux6VDPH+PIepaDqLmnawuRV8HpzMU0l1SF9TbHWAx8va8OgPWQ4eFd3?=
 =?us-ascii?Q?uwGTFKxvD2tLA4Xq1PA6AqQFL8vfyHV/yuCmOasNS8SOQ8pWplIr89ve5UBm?=
 =?us-ascii?Q?dU/qsmZ2f/n4SkULKdAnH6QrPBiJUrdI/XC+BfV0dIpf+0NH/rwU2Mxh21po?=
 =?us-ascii?Q?xNb6QDDjnsxlW4cph6BgTMAgG40Pa8yk48liYWaqiEgEZ35vn1AmfpKD4bfI?=
 =?us-ascii?Q?+eBZzCUpvStNACZ2RwmU5wuen8MF7DCQ4/5vRE2EWwyuvA/yGWZaEMqt2sYc?=
 =?us-ascii?Q?XAiZM8JZJb8Us96n9fG0kaHl5G8W6kW+OkCM9ZwJCdkAQ3jCR9s1u5XhO5GC?=
 =?us-ascii?Q?GP0GmDSP7GrLQ9atgtAuJa5YciyQ9DAomkdgwrtToJeG8XIXuBziAhWjHcxI?=
 =?us-ascii?Q?yryTBOM0l/HZGxYmMcSI2PwZagSMAjXmcwkxUMvfdBdD1+PVvYgvLszY23GN?=
 =?us-ascii?Q?m9rNyjdzZb3yKP389d6OZZHZpMzJXkWt0QXxA+l8rqv6qhzdoG+28Hx7xV+5?=
 =?us-ascii?Q?hh41MBGVl//p+2H2qMcrCHFzwXKynLUXYvq1M2tDsM3R9Lj0a8AvYhrin/dH?=
 =?us-ascii?Q?zxQRhhJx6ZGgGLU3eq8ebeHihGDWGs5SZR61+zj2AtsFOIXBiP8UH/y7TSJ8?=
 =?us-ascii?Q?ueFpVst41tJYDFHAqoqGVsFe7DzKgqItWUMLweATskl9YRCSod3ZxW1YDj31?=
 =?us-ascii?Q?WJT/JZ9q4K0UZvJH/X82FPmy3Yq2iv9AuCaxzARKH3Ummeo10obl85ZTx1mu?=
 =?us-ascii?Q?FYozQYqtkmdjNrDmonAWce6VMVnb7Vfd3q0pSybt7lRRDW1fgIRuekFjOOA2?=
 =?us-ascii?Q?L/kIH/o+zjzbJGTugFJA8m6SYL6aCGpd1JLbLVWa4hKyWscqforZC63uXlVF?=
 =?us-ascii?Q?Qdu8TGm4gWqYwyU14RebWcLv5xytqgoBWjk8eZw/MTYN7VKjxPxx/t8jL/Tt?=
 =?us-ascii?Q?q6k2FDyKDLJnmtp7gWQZ8hnImLgjppUYTSp2KAYW+sHTz0opMM/NfN5RW4fd?=
 =?us-ascii?Q?ITeA6lyMwrGb19fI9IdcT89+RlLM70a6fFWiseOUWhAigIe15ho28kqvPOo8?=
 =?us-ascii?Q?TzUaWIz3WlVCIli5IApcmvlqIL45lk2hLWllLclxtUc8lZR7llcBsniBquXO?=
 =?us-ascii?Q?8bYbbobNLHT628L3rHS9tmpL5fG/59FuZiyqEeO4f4KBQJTXll6IGnUh7gSV?=
 =?us-ascii?Q?fGikTQXKp6VuXDixCEIEndWTQdicKx5c+QhjZGo4k6QIJ9Q3Sso3iwlM6OzB?=
 =?us-ascii?Q?zBVglzzNkNqcRLIQXMU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b70af41-980a-4dfc-49bb-08db885acf14
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:19:40.5515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtB0TmTMPoL1cOQWElFLfFYl6scodZKyC3YO0BdKxueMtPtNw2ibcbEyBsqhZgahnJfa1/lWYEmVejfoVy9jS2tCQBG2XnpfNh25Ae1BF0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5359
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 13:19:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12427

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 05/13] mfd: Add Renesas RZ/G2L MTU3a core
> driver
>=20
> Hi!
>=20
> > +struct rz_mtu3_channel {
> > +	struct device *dev;
> > +	unsigned int channel_number;
> > +	struct mutex lock;
> > +	bool is_busy;
> > +};
> ...
> > +#if IS_ENABLED(CONFIG_RZ_MTU3)
> > +static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel
> > +*ch) {
> > +	mutex_lock(&ch->lock);
> > +	if (ch->is_busy) {
> > +		mutex_unlock(&ch->lock);
> > +		return false;
> > +	}
> > +
> > +	ch->is_busy =3D true;
> > +	mutex_unlock(&ch->lock);
> > +
> > +	return true;
> > +}
> > +
> > +static inline void rz_mtu3_release_channel(struct rz_mtu3_channel
> > +*ch) {
> > +	mutex_lock(&ch->lock);
> > +	ch->is_busy =3D false;
> > +	mutex_unlock(&ch->lock);
> > +}
>=20
> mutex is really wrong primitive for this. Use test_and_set_bit() and
> clear_bit instead?

You mean in this context, better primitive is atomic variable rather than m=
utex??

Cheers,
Biju

