Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA192C7EE2C
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 01:37:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web11.2408.1685929046292355420
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Jun 2023 18:37:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.133, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 3551bFGj009530; Mon, 5 Jun 2023 10:37:15 +0900
X-Iguazu-Qid: 2wHHiO38AzznMLn6Tc
X-Iguazu-QSIG: v=2; s=0; t=1685929035; q=2wHHiO38AzznMLn6Tc; m=Ac/oS60Djr6HzU3Q86kSHohciBoz3wxqrPQumetQxjs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 3551bCSI010692
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 5 Jun 2023 10:37:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuVmns0oYoARZRS3lqDlMkfUIVNpb5vI0AZzPsGqLYCURtBeoXESlp9tuN4NP484p6NZrcUklCnkMZw00Qd9OoKEzYet8PlMuqvG4mRsp2leOepXb+y4DXA459b4eXdPYygwnJv6rlKtQVsuInq+UaRObTSSBMHzerciyA53y4g9zaFRym5xB+iI2SPBEDBTNV88RkMq4KVTeW06MBm9YtlAxo1Ko1f60v/CzlSnPlgpJySPloh7kAzIBMaXGT6+LXKub15ILLg+tV19/n2o/76nxymP8dP7kq6eQ8I5mn+bgmJxDgwsxNK3taVdoNGdxfXjBBN4r159PZ/hicLCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cr8hYmISegs43u/0iohtm8cEuI1/AULRU2yd9bLvn4o=;
 b=hygFxZzEVKPqZeDVpCfpH5dRIHtP83K4w5Mm5w/bz/9Eu03bsexMkYi1r7VkhdubfvtHLoI4mOBQKlPzamKIP4OBeGTNYxoePcUHytineiA9rcgM1hvfsORnl+f6LWZ4phXEdUEEpHLZ7I2fDQTOIwJnqkqtD7TUmw366ILVeOv8aUnAY8coHGuackcGToOnuyfvXsc4j9BbApwhxlLTSQnyhsBtDs3e+vKa1MSOSjULf5EOCgtjJhzviJYc482iNRPKGC7Y6NIeSUfrajFKa/JFChE6wTjG45mWN8bdNnLEyAk9EJXBAd6tOjo5lni0ZwmYznCtqyPW54WgCGqJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/19] Add RZ/V2M USB3.1 support
Thread-Topic: [PATCH 5.10.y-cip 00/19] Add RZ/V2M USB3.1 support
Thread-Index: AQHZlJpZyBCCCVApWEqRfxpzfPzI3q97b2fw
Date: Mon, 5 Jun 2023 01:37:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420A65185CE82FEC2EEC4B9924DA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS7PR01MB11485:EE_
x-ms-office365-filtering-correlation-id: a79f3ea5-c9b4-4b35-ada0-08db656561d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eKDiQcf5Mh3S03MXuCrt+DdKuTeuyqzmptbqNirpDdQueSCjl8TxYgbELplGbCZazZ0CaJhCP4IovzlqghfPBV5h82WTvhv5cKhtgKMtEAQ4zYG+2eAPvFLTstT5jYVEiGTIqiJaPzuRrvGCvx1a0oGad22aFyDhCZfL3s62uV/SA6N9jg+NkJBsTQ7noe266eum/BH0+eGybFmYUTVF6jtvOt1ieSb7Vq63gXqCUg/NXJQqJz7IxBnAPUM8vpu7/8jxjugM+vJ+o0v/D/5xY/XvG+Azt7NHT1nMX4meYw2VK+50j9WcWNUIjhEfpV6iDFebfyMhxGjkCw3HXsdKPAWdeRF0LrGIb5tcRYF+WWjRTQscvN8PHbCZXsVqwpMcgpQLcO8TcSlus1lI7e+aNq1bb3XpwofDWwjYvRX09ebj6XY7MGZs7UorKfhIJrZIHqGGmZsIGf9MJWzGQmJvW+FiGHwkSSbM66MnaiZzO4xm7ppk9WsCcdP8gxeukXNIshygCFa7YvvzBh6d7ofFXnoG8mqptbuocXcR6zgZJRlEwelYXw3k35PHhx/3EtPXMoAfwISQr6zbox4a8WoEh6UMMJxLfrGKhZ1ySZZAG6VbYvyMOrNuw7rnf3qAttE0
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(83380400001)(966005)(110136005)(33656002)(478600001)(55016003)(8676002)(8936002)(38070700005)(316002)(41300700001)(52536014)(66946007)(76116006)(122000001)(4326008)(66556008)(66476007)(66446008)(64756008)(86362001)(5660300002)(38100700002)(54906003)(7696005)(71200400001)(2906002)(186003)(26005)(6506007)(9686003)(53546011)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MC9LY3R6M3h0K2lkZklDWFFDOTlzeGlod253OFQ3RnQ3dC95UUZDZmw2?=
 =?iso-2022-jp?B?Q21TWlR4REFKWkgxUmtRUWVSaFdQVXdiM1JNOUtXMkdlRms0RHJ2MzJj?=
 =?iso-2022-jp?B?T0tYQndwVXNtME1VQStyMzNldUtwVjd0dG5GbE9jenBaZ0RyV0tYbGZE?=
 =?iso-2022-jp?B?aVlTZEpocWVaRUptSXo0WW45emlJOE1Hd1JSR3Nsb1VHM2JLZTNTZDVk?=
 =?iso-2022-jp?B?MmxnMU1wY3BJZmR6WnlTZ3JjZlNMUFF6VEpKeHpIcG1LSVBKTy9MT001?=
 =?iso-2022-jp?B?VjhPaUY0emVtU2VaTVFIWVkvaFlXRTI1c2VpcXVUUEhEd0JZK2xGMzVS?=
 =?iso-2022-jp?B?OU9seTNyWk9NMGZlbUIyQlZ5eFp4TWJoWEZzRGxGcGRGeUgvNGZEM3ZX?=
 =?iso-2022-jp?B?b2orUlltdU4rZVBRLzNQMGs0K2tNVVJVTmJHVjBXNDJSaTl6VzQzcC94?=
 =?iso-2022-jp?B?V0lmaFRjemwvN2lqOUNueUVKOTJKeHd5TndDOTk3bkd4UEJFbDhSS0o4?=
 =?iso-2022-jp?B?d3MxSlFubTkyQlpnTmtPRXFTaWVNczBTVHJJaU5FWURHUUFFczVrYllv?=
 =?iso-2022-jp?B?eXZaMDc5WE1VUWZ0a2FoZW9PL3JsZDVycTV4eE5RQ3dPUGtMZUVtSlZC?=
 =?iso-2022-jp?B?WjlhTzFUVXd4L0xPZkt6ZGJNSGt1dlh3NEVUT0RheUcyeXNYc1FiamlR?=
 =?iso-2022-jp?B?TTlqUm80VFdEc0V3a3AxQkhRTEtOeFNpbXIyR0hXelBsS3Y3MS9MYVhO?=
 =?iso-2022-jp?B?RXZFSzUxelNqME9mT2xlUi8zQUcvK05wZFRwS3E0UVFSdjAvb1ZIQzFL?=
 =?iso-2022-jp?B?TkVDN2tQaTViZFBlTXJoYXc0YlZnN2ZuVjE0ZkRmVyt2bW43NVVnOFl1?=
 =?iso-2022-jp?B?UyswY0IvUFNhZWRJT2JmaVptSXFXZEdkaFB2ZVNzUUM5L1VDTjl6cndM?=
 =?iso-2022-jp?B?WTRiZXZ1UWk4S3lTM041Y0lSQUt4Q1RTeC9JWTl3c1plK3R6MmRPRjJ6?=
 =?iso-2022-jp?B?V1ZUKytKNDM5cFZnZ2dOS2ZwZUhIL1k1TCtETzUzT1A5ZzVrdHdacUls?=
 =?iso-2022-jp?B?N0pEcExsYXhSTlFrcndlaUd1dXRkRzdCZDE4VEpSeVFaNml3a2FtT3hk?=
 =?iso-2022-jp?B?OURuM3YzVkNuTVBVNG1QeUxlcWlpZVpWTjZZd05MTkdVbFVHay8wY1Js?=
 =?iso-2022-jp?B?a1VjUWh1RnI1bk0xTlRuUnlMZXQ2c0pYazRmV245YkZPNWVXWkMvbVll?=
 =?iso-2022-jp?B?aGlTVXViT1B0bXIraUFTb3JNbjNrN1BNdU5qNTdxRCtVZTZzTFJjVWpH?=
 =?iso-2022-jp?B?N2IxOFV1Q0RqSFFhbCtJUzlaNlU4YVlrdUxHcUdJYmNrRWpxam5tTUdJ?=
 =?iso-2022-jp?B?ckIvK25lZDN4TU9TVlA1TDhUUjQzaWZEaXFvbUpHMHBSMWpRMkY4QWpk?=
 =?iso-2022-jp?B?ZXVGYnl2aXFUWGlzSFYwTjJSZEZqSTJJc2I3WWw2a3NpcmFNNEN4WHhk?=
 =?iso-2022-jp?B?NG0zdnd5K1Jzc3FOT2pOZGxCZlJzSnVJRXBUN2FxZ0FFaER6c2xhY0cz?=
 =?iso-2022-jp?B?MXQraWhKMU1UQzRFbjd2d1czdHlyVXZET01Ka2hBakRabDF0UkErWWp1?=
 =?iso-2022-jp?B?eW9JbGVaUWVxSmZqcGpaQXh5cS9mQ3dIUms0QSs0Nlk1ekpuRkZBNWhk?=
 =?iso-2022-jp?B?WmpWUGlsNmNMK2FMenFsNjZLYUpSM3lqb25WQWR4TWlMT1ZoYkt6OWpD?=
 =?iso-2022-jp?B?UlNmMVV0QVpKTnZRM1NaS0IyWTJsazZVSkxOeGU1K0IzSjYvWC9sMmJP?=
 =?iso-2022-jp?B?em43UlY0ZEJsZUw5U2lKY0t0My9GQlZrYlpVQTZuVmJEbVg1SlFuSStu?=
 =?iso-2022-jp?B?K2pDYzFnc0pNRE5xOVJGQ21UR2tvMWlSUStBSmZGQ2drbFkyZFhPK0Vs?=
 =?iso-2022-jp?B?MHVSeGZEMEM2c0lxbUw5aEJ1dVQyRjlRWm93SU4xYW5LaEg2R1NiQUdW?=
 =?iso-2022-jp?B?ZlppNDBrZGc5dVA0YzVzREpHcEJvNEJoTVo2U2laL09JUzFRbk9VQjFY?=
 =?iso-2022-jp?B?dkN3ZDlIbEJiK0hvUWExR2hMd1NDbXFFRVJvWEpWOVExMkZNUmwyZDlU?=
 =?iso-2022-jp?B?MTdaT3BNTTNWMTByVGRWNkZ0M2VvNXd6ZGp5bHlkakY5NXJ3OHRwSzdK?=
 =?iso-2022-jp?B?NkJDcEVSS1RkVWpHOFNSQTFuNTNuSFlEZjJoaWpMcUsydDh5STllVUpW?=
 =?iso-2022-jp?B?Ti81YWJzVnZaREdjU2x4Zzdoa09jYjFtN0VWZmhSR0NRSzZIdHFNanQ0?=
 =?iso-2022-jp?B?enl2Z3p4REpwZXdhSjV4UjBNcGZTL0pOL2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	b3uxtktRtUPcL5L+NRAGgrVaTPqUkNXm2vuc9fP3zzbWjA2JNG4flYtcXkYyYXiEKR95i5MZDkV5XOBRAIgxjEcgRM5z242ehnkC+nTXp89Lz94o5x3W1BPykwKfhXDo9i/DhKrMjTYgNGbDKmFweePtOuGX9cFM4weVRfeJNr2/tlwK671EMBwuny0NADgo0zIyJcWiJiF9MwYk0o0UofcUA5IgScmoL3IwZRMOZnV3BTK9PiYD11M0a3wRy7AC80SImOc8ReKuJqkHYjN/mHH+nhYOuqM2kbLnCDi6E7lpFodejRlr/yaWrzZIa8rlifjQ/ZIawT+WZizLI2q/+Q0auy83kd8mzwA8DfKSbrIH30DcNA0yeXoYMC5xmb/O/mEUvC8Xohq3DX26sGlyT04QaMYt5R8VdYEAeG8/uHMp98PJCRrCyvXgFVlhMmiaN60R547e0oorx9CvWN31/UltsXpD+hu8mnKdW8cp4Xe3pbOF7LMsagOgTPhWFO+9+zx+hItL3j8EiHfxj8mqcoogJBAasHUjslQLCbHguUEyJdJH8pbVbtwvy5gIKtxzF3SSkUsU8NNp2sCi78kSK7qxj1N+cyAprZpzKmqJpv+ZkT+3X3ZKR0Bf5trcPhAhbWoKDSvTFKvpODItJb80PpPd/jOzRW7h87qy0vdDf9QRpki4ybjaXrn3nIdfRH13deLvOr7SqHabiMVmvUgz6ySoBGDbkNYQYNBFG12gY/8pg3Y5+jDwr0fO4oFXtTmRmXrEtSAm45Xx5TVfcp3wdo1ox9Vid58UnsK0tOqRG5BcSMqdapFmCRpBrMGcdj/NdnN6qkVyLCseF11+2NR62Kt+AzSMhaD9t8xYPY6ykUkkE3k9hC9oDyYxcZIvbAifjq+kbGWIIt0D81jNu5xX3A==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79f3ea5-c9b4-4b35-ada0-08db656561d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 01:37:10.9985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUVCRURwdVRaOZRjpFmJ/9tj/3JM9qso3CmMs4sf96t7NIyqoIYsQvU/pwPcPao7Zexpl/kV8jS8wPTFZZ42AkJFyYNy2fkScUh+rFh3qVmSZappw/gB1SCegWfcw0t7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11485
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 01:37:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11768

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, June 2, 2023 12:04 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 5.10.y-cip 00/19] Add RZ/V2M USB3.1 support
>=20
> This patch series aims to add USB3.1 support for RZ/V2M EVK platform
>=20
> All these patches are cherry-picked from the mainline.
>=20
> Arnd Bergmann (1):
>   xhci: split out rcar/rz support from xhci-plat.c
>=20
> Biju Das (14):
>   clk: renesas: r9a09g011: Add USB clock and reset entries
>   usb: typec: hd3ss3220: Add polling support
>   dt-bindings: usb: renesas,usb-xhci: Document RZ/V2M support
>   dt-bindings: usb: renesas,usb3-peri: Update reset, clock-name and
>     interrupts properties
>   dt-bindings: usb: renesas,usb3-peri: Document RZ/V2MA bindings
>   dt-bindings: usb: Add RZ/V2M USB3DRD binding
>   usb: gadget: Add support for RZ/V2M USB3DRD driver
>   usb: gadget: udc: renesas_usb3: Add role switch support for RZ/V2M
>   usb: host: xhci-plat: Improve clock handling in probe()
>   usb: host: xhci-plat: Add reset support
>   xhci: host: Add Renesas RZ/V2M SoC support
>   arm64: dts: renesas: r9a09g011: Add USB3 DRD, device and host nodes
>   arm64: dts: renesas: rzv2mevk2: Enable USB3 DRD, Peripheral and Host
>   arm64: dts: renesas: rzv2mevk2: Enable USB3 role switch
>=20
> Christophe JAILLET (1):
>   usb: host: xhci-plat: Remove useless DMA-32 fallback configuration
>=20
> Geert Uytterhoeven (1):
>   arm64: defconfig: Enable RZ/V2M xHCI and USB3.1 DRD controller support
>=20
> Phil Edworthy (2):
>   dt-bindings: usb: renesas, usb3-peri: Document RZ/V2M r9a09g011
>     support
>   usb: gadget: udc: renesas_usb3: Add support for RZ/V2M

I reviewed this series, looks good to me.
I can apply them, if there are no other comments and issues.
  Test CI: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/=
889078814

Reviewed-by Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


