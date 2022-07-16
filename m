Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEB8C433EF
	for <webhook@archiver.kernel.org>; Sat, 16 Jul 2022 14:24:58 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.108])
 by mx.groups.io with SMTP id smtpd.web12.5886.1657981495179050624
 for <cip-dev@lists.cip-project.org>;
 Sat, 16 Jul 2022 07:24:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=eu/7rL0w;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.108,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIczz33pCxJH47fcQCnMUGHMdHJZyOu2O15/0dVrEK00na4dHOlFhOoVdlKIeaEe+XOjeUzARInroQe8OTcD4D4L5ueEt15sU7r/AOgEIQoJEqSq92d4z+uUF2ch1swkSFp/qeuv6+3CAaMwQ9/+kI5vuuiQEmLW61d4+zXjkr83u+VbKvDxMECHlSLpsvWmIKHJfZ72IlFWL/9uq28zwW8BIFV3DJGYPj0d3ziUfb998NSPWBDgutuhMAXWBSST2wP4uv2yvfmx8qyviUG0L0iaMXVOpUVH445XG6M/LFApgAd5gZvtj7PNKerA8tKi7TxlYh+W7f5Wd0b3iFtCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeqAst6wImn61doR7WC79oT10SAm/fM/BBoqHdxNh9k=;
 b=EC7ahp8D+TUdgKu6zX6pAGtIZ9rFdJGDoRCWYAWkikSBjYurHWEde8GF9EyJeQLI4TZeG1jAdy4bRvM3NUFR2hO596Zkj1deW8Ssghe2sM+AYlzqoKEq7m6TVsLLruO8beLDiHdBWPqjNWFF4koPjjGGoW5YzL8hUR3tOgChJVu8ifW/wDofVDSBh+Y94stUbTkp+oUHJDv0avTrgU3UhBYO3yF95a9RXu0q28pjACDskP8q4je1oRQrwyYyMj2y2L8YtwtILhvwrjsIfKpOyaDeWgQAcosSXnyky847cDZPkpuKZhUXXB8XiQATCMbBMyIbasnUrkJGnbWNSjLdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeqAst6wImn61doR7WC79oT10SAm/fM/BBoqHdxNh9k=;
 b=eu/7rL0w65AY1TnNz9JRLk7PAaXcp8D4NU+X6csCSLlcIFjpAA5YpovA53WBfrwWKeY5Kxne1REYsIPxv9D3SDFEc+QPWtrFbjUUFgVxj43ujia6f4XqBRd+s+//kw2d5ydaLzMe3iFlmJnVHvMVTbmNpxg3IPWlEpyMDJCFJCM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5332.jpnprd01.prod.outlook.com (2603:1096:604:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sat, 16 Jul
 2022 14:24:47 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.020; Sat, 16 Jul 2022
 14:24:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH RESEND 5.10.y-cip 13/13] watchdog: rzg2l_wdt: Add
 set_timeout callback
Thread-Topic: [PATCH RESEND 5.10.y-cip 13/13] watchdog: rzg2l_wdt: Add
 set_timeout callback
Thread-Index: AQHYmB4S+n+d+8/XtEarOeoUaQ5pjq2A2geAgAAzrSA=
Date: Sat, 16 Jul 2022 14:24:47 +0000
Message-ID: 
 <OS0PR01MB592259EB934097D164E3B4E2868A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
 <20220715073916.2321319-14-biju.das.jz@bp.renesas.com>
 <20220716110434.GC18467@duo.ucw.cz>
In-Reply-To: <20220716110434.GC18467@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 489769ee-b74a-403f-a1ce-08da6736effe
x-ms-traffictypediagnostic: OS0PR01MB5332:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dpVAxz7oDt8bta5HlSXWNvCIOZr+gR5ElaCBGGJKtteu84cmvEVQB9TzHnkr2XKeK4sIUqXQEj5DBvfM/UObmhq0aFTg88aLZCydWKLKUVjEBD89ww1xUqcEQHfm5ekS+xG+ok8+19c3bnus/+LLlzJ0rLe2IldlaWhLUYaKX/L8v+gpqfMQIPQOvk/W4RPKiG50Jkf5rLoBfz5tCOkjvtOFEOVYtArTkS83Q/lOE2FPHkqQDLxOSpT7TuzPnKLdato4jCv5LdrIdF2MNuJsRKN0XSLnuWcjkYLDtMiCAGGCeZ2FXJ1m82m25hLH/MUGK4dvN0K3+D1rAZKs2PPrzFjxuy4lTlsmGoRPs6N46GsY3AFd2tOpe41T27PaVNqZDbjUe9598CHPXgUrrkhK4A1ldjiOe2CLA4Gc7H1cItnxE8x6+P6FQQEgWHya+iexfbmA/krzCun9yJs3TNru1+25CdHqBCpPb0fNsb8Vp7SRi+LKREBsfI3bbRr1g5IhkXIzhkc/QHYAyaNoSqmrvKaTQd4M4V/vX3qDocpGvUTPPVlcjvPssKrWB8uKZB8Jo2kwHrRpRFRh+5B2jPu9bZWRsXOr9KcOPYWVcjx/rZvvaFkPSUQt7LdCGq+juaB9r4uOLEORNvHQwMyUBoXSmEeVUOcHCpRsow6EYNdGWDjqBFzNC3qK6tqvOnXE/eLc3Msf/HKGLPQtxCiiRgFNWG7DrBdFondm3lxWD4PLoHcznma3eRkmfotUAxaFng86Ff5JRXJyd77CR9SjL0gHnMs5inWyqHqZ+cgbIvJc9BP6OKxW9uxX9F7NsTM8SsCy
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(478600001)(6506007)(26005)(7696005)(71200400001)(55016003)(52536014)(2906002)(6916009)(86362001)(64756008)(33656002)(316002)(41300700001)(76116006)(4326008)(66476007)(8676002)(66446008)(66556008)(66946007)(54906003)(107886003)(38100700002)(9686003)(122000001)(38070700005)(83380400001)(186003)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?w1im1Ydo9JXLFppmFeOPciiO3qtwvgJO3AHzif/6Bc0srIOK1RaXidP0JJtj?=
 =?us-ascii?Q?/FzGO8Y/9sEQKwwFRkN6e2BmFMm8CgKYaLHz9BEO17iLrf6KOoMmHOe5r/jl?=
 =?us-ascii?Q?HsuXXY5lrwHXwc/AqdSj57uY5Z6ZjWGHzAcP0My3KJcg6nlqDKIfs3FPDl4a?=
 =?us-ascii?Q?LOYHlc7C/OjrehxpLS5DhtSNoQCBPggoqOJ8/0/xH6vPtXLXlG08Ftzt9yez?=
 =?us-ascii?Q?RBmWAtTkc1zEbeQ9RkyR22Q/qPoYPBcnlwdaQ8YpZgZDtkvn770W2aH3csJA?=
 =?us-ascii?Q?UGJD7fb1cxNDjBqCTbZWuMtEy/tpSSg6YLpUkJdyqQr2vaic1ccuTXj1J0eA?=
 =?us-ascii?Q?uUSdwrEl8gZ6zvjdd8YBFmMlgGPaFAJ9TLn1vwaOoyzqjxPWCmW5Ky03rhTK?=
 =?us-ascii?Q?Agx1013w2/qW3tiNtdWEqftZX8jj9QUXXxa+3hnr5OyQbvTQQc3xaftlJ88n?=
 =?us-ascii?Q?PeqmaESDkp/ugIjgoo+o6EsLu16z0K8SRY0XznMem/E2FalZ7Ol/YsvmvsnK?=
 =?us-ascii?Q?k6i54+8FizZruPPXZ/L8jhCvqk9QcBWUXYhbJAVAkRn5O+yoOOwySAvqvG7U?=
 =?us-ascii?Q?tJTKjuis76AWf0S8LF9c0b3oGj61S5tzKqK2AzCLZhCb6GZEoWJtnoa3/DKg?=
 =?us-ascii?Q?pK8xibO1RpZVVeaIbVUFKPVVXZRWwNIoJrhsPsqVq0n/DqFGjxCZDzR0Cbth?=
 =?us-ascii?Q?082uALLw4x00wPBQ0FbjFX1EnEE5dRwA/x8aSa52ft/sbXymleTHbnmYMV5w?=
 =?us-ascii?Q?ZBdF0O9vcQqvo9EwoNHqCUMzI4QU9b3wJLo0cNrPcKQcfLw/bgpZZNv9nuc3?=
 =?us-ascii?Q?yY3wtSI6CZYmKwIwipCNXMu5xOnxDqlRzNU2cPdMdDTIRYdiFF/lSH4q7Qz7?=
 =?us-ascii?Q?wCnP5Qckx0opTN0tzFRk1qlYoYT5mJXUO7AgHxwqlV+kJElP/UlzF9SKEMVY?=
 =?us-ascii?Q?olttDrO9IhUKiMIp8Mo8nUKG02vbhpMyWnfILlw3DcjdC+w9cblJnNOVYyaD?=
 =?us-ascii?Q?9lln5iqZ5fTykftcPUomCMPECRmFzs43QxKFHnH8a3mHOpYhaKryFuaVh5ez?=
 =?us-ascii?Q?szsLBO5L8s/ua24omFJXWFtnsF5fq9XIyWAYePjuHEO9OUZF/zrnBaHGUrTW?=
 =?us-ascii?Q?aUZfeRNV0evJUGyd9awnUtSlwEDzLSOfka+JTQUsnK7H/5ZE82bacyYS191E?=
 =?us-ascii?Q?Hju3DFbx6aglqCbLedkHH6XZG/4bZUsJM7cQbWl1K0wGRcbC8IJMOoDVIjz4?=
 =?us-ascii?Q?J4xsLu6I7gllJQcqOCpjfYE13CadgTeLyqrDD7hkMkF8YMsoeC1ZL/6w4DVy?=
 =?us-ascii?Q?/DZz6On39QICW5fTp3HRoQ0IXwN1eMWiUT7xQGZ7tfKsJywtsP/bBMWIQL/H?=
 =?us-ascii?Q?4nRryg6sHoZaG2VYznpphyEj3MQIlp78U0ECwMu8VeS2jsvSL0Eisu+Zou+F?=
 =?us-ascii?Q?L76uvzPpbMnXwzePhRvgJlRzoo1JxjiBfJoTQDGLFRU3gZuvPr55zvrNapiT?=
 =?us-ascii?Q?26s4vEP2OS7SEWLSdFGeSq6Y49VZ8yByICbC65hPh4AAIQI4o1SzMT226hc+?=
 =?us-ascii?Q?ikyVfgjtMqIKYcVwQXG+vdLdSztNDvkn8Y43rDLOXZQ8HCEH5mEzH8j9jvLr?=
 =?us-ascii?Q?gQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 489769ee-b74a-403f-a1ce-08da6736effe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 14:24:47.8059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 eIhEXyoTw47d9phq5D6useLEqov/gxBbSwwhP+Pk1Ew1WDDwsjFWQB0gugLK+j3VfraaUpgeNoE+eyoLLrfQ1Op0bIFw3efhyt1WzuAXEZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5332
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 16 Jul 2022 14:24:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8840

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH RESEND 5.10.y-cip 13/13] watchdog: rzg2l_wdt: Add
> set_timeout callback
>=20
> Hi!
>=20
> > commit 4055ee81009e606e830af1acd9e2e35a36249713 upstream.
> >
> > This patch adds support for set_timeout callback.
> >
> > Once WDT is started, the WDT cycle setting register(WDTSET) can be
> > updated only after issuing a module reset. Otherwise, it will ignore
> > the writes and will hold the previous value. This patch updates the
> > WDTSET register if it is active.
>=20
>=20
> > +++ b/drivers/watchdog/rzg2l_wdt.c
> > @@ -115,6 +115,25 @@ static int rzg2l_wdt_stop(struct watchdog_device
> *wdev)
> >  	return 0;
> >  }
> >
> > +static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev,
> > +unsigned int timeout) {
> > +	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +
> > +	wdev->timeout =3D timeout;
> > +
> > +	/*
> > +	 * If the watchdog is active, reset the module for updating the
> WDTSET
> > +	 * register so that it is updated with new timeout values.
> > +	 */
>=20
> values->value?

Ok, Will fix this in mainline.

>=20
> > +	if (watchdog_active(wdev)) {
> > +		pm_runtime_put(wdev->parent);
> > +		reset_control_reset(priv->rstc);
> > +		rzg2l_wdt_start(wdev);
> > +	}
>=20
> This code is quite tricky. AFAICT it is correct, but calling
> rzg2l_wdt_stop() instead would make it more readable.

From readability point, this code holds good as we need to do
Module reset for changing time out values for WDT.

But from code optimization point, whatever you suggested is ok.

What do we do here, readability or optimization? Please suggest.

Cheers,
Biju

