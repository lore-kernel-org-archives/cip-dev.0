Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE84FD4F03
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 16:08:21 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43768.1773158897238694662
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 09:08:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=YCLoDt5l;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.68, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs+Bzk+s/wzqJMTqPSddvGm6JU1dgKVxYm2reGegfyoou557vhcNVplNMvmyF9OiaRinPfB/WKRQslgqRHYNN4ir4gePuocdJbE6M1NtKErpolRw08vNwbAqFcs8ZYImLEQz29+zGESFbTuzhsU6aevUxZ09L/49/uIp4TXjfHHsoSssKjMyKNnSJND+j30Y3cdOKVe1gA7Sn7g31Uii7GfQuYQiI4sEf5l9e+MfxRc7tk5QfbWEzeCEeGR5rRJfxSikDItnPR7UZFlNIsOKLfQkfEftln/x+kBWIX+rxrbU2ZKkT4/YVmaNUUzMoZ4MVxsrlWLpnWq3SEhLPNR8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K836C8d04XhG66ie0y4oIQANwXG/yTkxyFC55LNJrrI=;
 b=Zwj1Ha5XZZFHuoTHuRcv7DV2shzaI0CvfJRKI7Tn58cbltQfsoPwJdAk28Sth5Pa2pSaPji5GMUqZTByq96Z7uCY8wIR4eLdd8j9w6O1074a+0aZY38wjUfOzgX7wHAlkfMpnYlTLDOsvclA053ETeL0OrJ5pOd8pdVSQ6KzTvpwLZhCPNG+8UbiQGtbuWDAQA4jxMdGEsx9cmTfPkJ5sLIk91SgM5Dr3IE7qKIzMLAd/oifxZKbV/XT2Uzi902A4p73O4XR+T08+26r7DZB/Fja59F3xo8llQaHcTsvuypOScQouLdck2QNkOihEU6KQDitrb7Uj1TKW2bINAU/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K836C8d04XhG66ie0y4oIQANwXG/yTkxyFC55LNJrrI=;
 b=YCLoDt5lIdlVv1GfeIn/0Gj/+kyt4ATFaWL52dwl4LmTR5XSKrasiWjtWvNKK7V4+rcSqzOyNOfZ/VG/EbGRWA//tJtpZpOKMPehHdN5svgx4Sxjo7gMjPKAu5izvA0M5s/yHl9xiA444nLl1nuLa+O/TivakEU0/9Om3mdWS+U=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TY4PR01MB13462.jpnprd01.prod.outlook.com (2603:1096:405:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:08:13 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 16:08:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro.iwamatsu.x90@mail.toshiba>, Pavel Machek <pavel@nabladev.com>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 10/29] serial: rsci: Add set_rtrg() callback
Thread-Topic: [PATCH 6.12.y-cip 10/29] serial: rsci: Add set_rtrg() callback
Thread-Index: AQHcr9CnN28eZKG0bUGyU31Q6/6sPrWn78ug
Date: Tue, 10 Mar 2026 16:08:12 +0000
Message-ID: 
 <TYCPR01MB113328C3D06959DBB94D6BC118646A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
 <20260309142549.987737-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260309142549.987737-11-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TY4PR01MB13462:EE_
x-ms-office365-filtering-correlation-id: e45306be-1cec-4ce8-f7f0-08de7ebf3af9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 RCSnhLTLOnTMd4UH4KZIrd6cfgbhqry6ZeNX3Sd5j8lGc+ue/fvntqLgpsmyNuat7F2r65j0RuDQ06XDExMgCTNatU0DVPuxf/uZmQpQ93w6JmqMtUNeqiLce6Agh3EMmft70dCuTVEJHiGZicApiQAlzLevnaEKfkNZ8KrycS31h9ry9ILhABxVpH9YAEe4n3JHi58JXFgfesGf7FrJJxG8mQp2QUUktaqnm4fTL3pGoWwREAOQUweCDUbPdizr5WrJSb4y21TNaPDyX3zBPdlxGCl3It3Ensve4MfQWqBHCFESOCIVkXs1qwO4oRAJqj+3Pm63+DGmqmrIQ9vTkCzHg9GLlO0Uu2P+pFURRhIv6snzuFBb2v7+BZEorkkXIQ5CWd90PCSyeAa8u2mKstEWJR4z1ANPF85mMgKwS4AyInmsnUfV7de6fpPEQgNgy2u1aBmnU+28odCg2GHhh6goXtA+DTAD4YA6P3vgd5/GgUpHHMvYGV3lEeaMK0IqsE92cmkGFv82YNSlhh3/6UO2rahKJeLsXidCO3LUp/9dYKFZyYtAT/WGWv0XCqLyfb4WmzlCdPgrhTA/vOOT9l5gqgQ2Iyji4/bpww5u26y6KDuqBfnrhBHL9sHosCByK5mkNcaKk9Bvsduqw9gbxRFcqXJCNoJGIf1g/UHGFjs75J7AplsrX79eUVcusRWzycyMjjSYAzRr2W0pgED8dLMFhhsn5yk3ocZCDP4zhUy6eTXHLh8ko5HaraNM1f3+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UT/PSAaTWCCEbk93n8y2UI5RM7sk//pZtcTk0o41xTGmlS9vVPYC7KvnrYbu?=
 =?us-ascii?Q?jHHuSbNm4WU/zi7zalkMdNL9R6KLsCM1SP59XWS0eVVxerTrcMMo3/YZkk/g?=
 =?us-ascii?Q?gIv9+mVM0xXGoF1LPhwcNPmhI7Sglyjd3gNfc2dhEr3aQ9gVinUWReyIejoN?=
 =?us-ascii?Q?0A7qnGF0j3bk7guLaYz9SuNWhZx5SsmT+/YJ0rmzbC/yOIzVWpexnroMuj9P?=
 =?us-ascii?Q?f+FVh9yDElGoUSWq6DbB7a3BdCWLirtkrsFOpXTOxqwR9Us3bfR9QRL2fE1O?=
 =?us-ascii?Q?IXSnIBwcxf7k5lXKWc3xPvQycHvArmVTNQhcERXcb1KexVqu+FXau2uacaxs?=
 =?us-ascii?Q?V6rCmYHPoPaA/1m8tJsWMYAczFeHiuov3z2Bxpu4jnoKdTxnF1W85kAqXKKM?=
 =?us-ascii?Q?Wv2sKwXG/bo5Jp3d8rcqCy6mjjOPiOLdL1b6IjE5ju8/efh/ige3vv97Zu5P?=
 =?us-ascii?Q?7nHdnwmn+Bmaev6NhBv7GQOJTXwASUQti3PWsU4rVW0wAsEQLOaGeB2YVd09?=
 =?us-ascii?Q?glMleyFTgJ1NV9kKcoCVGPXrnT4HpMtPGIVMjnKzhE3EVQTk+wX6a75OCdz+?=
 =?us-ascii?Q?AkdwszFx1CQjOaZCBFZRU4nWYKZ4N5xRbr33eff7Ntk/uTg7kT92N3T2l+rJ?=
 =?us-ascii?Q?oxVYker7zC6SOBfX/aCBn/39D8DR4nDJCrBxQYQZ4CvmODL860OZyxw44nWS?=
 =?us-ascii?Q?H7tZEm4C+SVSnwqv/Y84Jvof8kisOsx4+QmfP5wyx+aPbNygdw1n/y7vY4Hr?=
 =?us-ascii?Q?H4Rh7xedUNCn7cwpNCzpE71ofXChKvJHn5kAQmESkmEPUZpKsP/XybLjQnh1?=
 =?us-ascii?Q?ANpM867QgIEBGHzXS0Vhbz6p1FdGr+7rTIbZEf8Mdql066GxgKvtVLnUTOcD?=
 =?us-ascii?Q?2dcCjEEGoCOuGSy6eMDNcZ0qrQCwACeJIWAZns1xA2CHqMiLEiaBBzxI1nmk?=
 =?us-ascii?Q?NO+9SwL/jrUV6WoZKhJhFSYuxGhwLrYedgr59/A5wcAjHWBmZWAUUtQ4ZYIl?=
 =?us-ascii?Q?0LHBYk4emILYW7T+wyutzri9Etbb50Rt6hswkice0YYZMaxZr6dZTlBep+U0?=
 =?us-ascii?Q?ShCBuo49ccZC+hpldWlLAxrApxdFTXsi9cmw+CQdGZYxPNaboTW3JWP2Whf7?=
 =?us-ascii?Q?kf1DW2KYetyw0aMQsAwL5VWGweyMpcddXkDcN4hYOA11oYJdwLrY1jKy/biZ?=
 =?us-ascii?Q?bs6cquz6MJkcCCvAsHCqoRlq7UZcujv89vpq2UGimk2Vuo+GCH8Wyp8/NhI2?=
 =?us-ascii?Q?cDnAXdQaOTY/HyZw8yt7O7Px7CTHDukIjBYGO4s+ygGS0lt4kQOYv6I0ZMGO?=
 =?us-ascii?Q?QNtYD47WO0d1spNMydVDg0yTb3hDYUaSpbhjqF+8sL4OsgBLtQMCrs6vwVRX?=
 =?us-ascii?Q?sp+za/GDYkEJwVS8Hhx18+S0XR4z7oQd5dSsdJW0frTT/FN14J5NrsMATV/0?=
 =?us-ascii?Q?0mqW1opXT82S2rYBmKSBr63T+d/xSUKS/L7hT+1fkl2ea8omtZLfHb9aVsbZ?=
 =?us-ascii?Q?lDnD+pYR5yd8z8aNxqE0b+64JTtLxIPWEOwZCxjqiCk6fxslsLlj4MMdKrzb?=
 =?us-ascii?Q?J31XGbvYWdgn7KLdhHvaLH1EGwKKDAGcClIPBeAaT2XyWHIC7ADYq47CS+nW?=
 =?us-ascii?Q?QDzP8kVT3cyMnBrgDhxcTqO0nEGIMydbGK7thM+EFhMcT/VQbhz6SM8XwwgR?=
 =?us-ascii?Q?dMxh8fQOEZTOUAI8fjzAVUkp5azSNEWm90BLBGqbXvlCI/RZkEaqx3tZjwUr?=
 =?us-ascii?Q?h0Y82d5B0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45306be-1cec-4ce8-f7f0-08de7ebf3af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 16:08:12.6024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0e04mkuvawway/ck6fsnNqby20fscb+XfwFEqbw/7I+6RCOx195ax7S+m39ABIYtXc3f9+xupM7Ti8T7vGaQfr7rJE//DipDJt0c62DyfyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13462
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 16:08:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22241

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 09 March 2026 14:25
> Subject: [PATCH 6.12.y-cip 10/29] serial: rsci: Add set_rtrg() callback
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit b346e5d7dbf6696176417923c49838a1beb1d785 ]
>=20
> The rtrg variable is populated in sci_init_single() for RZ/T2H. Add
> set_rtrg() callback for setting the rtrg value.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Link: https://patch.msgid.link/20251129164325.209213-4-biju.das.jz@bp.ren=
esas.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/tty/serial/rsci.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c index =
aacd20bcd1c1..4d2572d63180
> 100644
> --- a/drivers/tty/serial/rsci.c
> +++ b/drivers/tty/serial/rsci.c
> @@ -151,6 +151,22 @@ static void rsci_start_rx(struct uart_port *port)
>  	rsci_serial_out(port, CCR0, ctrl);
>  }
>=20
> +static int rsci_scif_set_rtrg(struct uart_port *port, int rx_trig) {
> +	u32 fcr =3D rsci_serial_in(port, FCR);
> +
> +	if (rx_trig >=3D port->fifosize)
> +		rx_trig =3D port->fifosize - 1;
> +	else if (rx_trig < 1)
> +		rx_trig =3D 0;
> +
> +	fcr &=3D ~FCR_RTRG4_0;
> +	fcr |=3D field_prep(FCR_RTRG4_0, rx_trig);

field_prep is not present on 6.12, later patch#29 convert it to PREP_MODIFY

I will send v2, squashing this patch with patch#29.

Cheers,
Biju

> +	rsci_serial_out(port, FCR, fcr);
> +
> +	return rx_trig;
> +}
> +
>  static void rsci_set_termios(struct uart_port *port, struct ktermios *te=
rmios,
>  			     const struct ktermios *old)
>  {
> @@ -454,6 +470,7 @@ static const struct sci_port_ops rsci_port_ops =3D {
>  	.poll_put_char		=3D rsci_poll_put_char,
>  	.prepare_console_write	=3D rsci_prepare_console_write,
>  	.suspend_regs_size	=3D rsci_suspend_regs_size,
> +	.set_rtrg		=3D rsci_scif_set_rtrg,
>  	.shutdown_complete	=3D rsci_shutdown_complete,
>  };
>=20
> --
> 2.43.0


