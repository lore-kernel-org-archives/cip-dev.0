Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2F2C77B6F
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 09:20:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.4953.1681464025701063434
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Apr 2023 02:20:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 33E9K3lV023729; Fri, 14 Apr 2023 18:20:03 +0900
X-Iguazu-Qid: 2wHHOH2eUxpt457I7t
X-Iguazu-QSIG: v=2; s=0; t=1681464002; q=2wHHOH2eUxpt457I7t; m=Ngys7NzFqFTHOzTWSAft7wNaYqrbdDyPY41z7B7gvy4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 33E9JxLx001345
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 14 Apr 2023 18:19:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4KWsg29NkfNsO03Y+Yg48QDw0PkMGMd9w2ZMkb9e1npUvBtaJv0CdOH+/V3ztln8hdetysXaN90Mm6M//KGR2XlM3WKrDkAJdkTq9d4DE9hL+fB2pvsFpUYBmD96+jqpwIS7Dp5DLQL2x1sRxjyKSlOPqt745B+xkW72EYPtPrHVkH7Q+fusb5e4knDURLJPGlAriiN/lqsNvQrPhTevlfr6YEzab3yHzhXLsrghtmmaR3N74Lwd/PGzRspVdTVeHUGBIG46i71K8b/Gqb/w6zWVIm3PLU3fq9Iha+XOIuxodkixUV+Y0JohawafIkKRPw1SgbzfHVB/5dAspE+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQZKyyNdacYxiJtfDl9f8IewWYajum9q+cmKOYyPK50=;
 b=KaxyNHNzzDPbVBKEvRWoUKLmxCM4sZXHFMxv8smLYNaJeEhaBSqu0UgJDNj6O7MbIG9YH7g+j1fQ60n3Uo9e90Gw7R+6RsKlLbSOTJdnhZoC/V72P0yDQSY0/VdME37CVbvfHJXCjHoYxlOZe8f5sik8jF9xqLKPfS4uWpYazpHx5x8XPHpZFcOHirak/VGwq4HX6k+b0SukL/8FFoYlSPmVNLWYmETx2C19sODDk4l0QWo4h9y7qAwrHt8Kl4bkf0bM4qmh/xPOuz1jkCB/XvofD+M/aqikmX/1WQCYuLAp2AmtUjokBtiJfxcv7uQjVbvHyJIXMysxKUa1r1GB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <jan.kiszka@siemens.com>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.280-cip96 and v5.10.177-cip31
Thread-Topic: [ANNOUNCE] Release v4.19.280-cip96 and v5.10.177-cip31
Thread-Index: AdlusiGB3ubY2btcSJuKrWj0YR5+Dw==
Date: Fri, 14 Apr 2023 09:19:55 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420027E9F41EC6E859C71BF92999@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB8762:EE_
x-ms-office365-filtering-correlation-id: 81f8bfa6-6b5a-484c-2ba2-08db3cc9697b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PRLo646SdzstOHkCwS9zF2tNaMW1WbA7SkVCblhOp5D4LEU2py+ZpQCSKRLCI5YoeDBcPU4qJUjyMKsvPhgYmJncesOM5lDv21YbEKXw2loTdB0UANBHg5QczAgkiRIQW2uMtBfqQcYERWFtrWSSwl65f8W57TtjMCjsMKsX3fpbVM4Ycqu39YZlI+1/QDg806jkYHGNMy698QKCT916Aj+ZNo+wFDXaL3NbO6B29buw43N3y7hZGdF7BCd6plYMnwo3FhBI6R0MXSWMoHRhltK/j+/N63A7K62ko1f6rgb4JDM8R6bx3R25gRnmaYmtemZt1Ra4HTVGfdsdFQnQ1UrYDpzNExS+mtzinzu9lt6GP4PzY2akWoR1+wZ6g6URR5Xa/Yx6hGETMZJJY7PIa2QvmaXX0b1vutCRwniZj9nORH1Yf+idICEx598ZDukAFX+nUcm3ZsxJ6PxHAilrgB3mxELlsr1Q9ng9w63U1eNu7uyYI5VjQEb8TFpduJdkixZENRaESXrcYplESMSBMf/LI+ZObzWd9Zizm5+CxeSHBBI/X/sJBoRnWVni9y3ZB+HR3Sca2uDTbKtIsqZqp8S46gGomrCQEinGNwU2HsEQoGiSD8UWnpsQi4ScaoSoVatOTno9hY3tuTqUr0Owow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(33656002)(55016003)(478600001)(71200400001)(54906003)(7696005)(122000001)(8676002)(8936002)(41300700001)(38100700002)(66556008)(316002)(66476007)(6916009)(64756008)(4326008)(66446008)(83380400001)(76116006)(66946007)(9686003)(26005)(6506007)(186003)(966005)(86362001)(52536014)(2906002)(38070700005)(5660300002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WFpHeW13MWorNHVaa2xrcnNWUWVRYWEwTHJ0aTJNamYraVhuV1ZzazBy?=
 =?iso-2022-jp?B?TzF3eFRQZmhZbDU1OUVFZ0tueFF2K2V5ZlFlZklYT25DY1dSTzdDU1Zp?=
 =?iso-2022-jp?B?bFdOemNLMURwby9ncVFlMVVya29Jd3RyQjM3VUhEZnFCTngvRncvajNW?=
 =?iso-2022-jp?B?QlI3NjFuam5NVitUOFc5NW90dnVSc2d4cSt3a2JCem45bW5Lb1hGdjM4?=
 =?iso-2022-jp?B?cU5qeE5FeDcxNXh0SE5mbnRZVkU1ODd2c0dUZHNGTXc4WENZTlVJWGp4?=
 =?iso-2022-jp?B?OGxSUFpTcXMwdnRVdXNLMVpDQ001Mlh3bVZKNE9uN0c1WDJxcEpCenY1?=
 =?iso-2022-jp?B?bFY2RVlPTTVEMUUzTTJSY25XZ3ZNYk9ZdmZkTnRaOUFzUTlnNnZmWEI2?=
 =?iso-2022-jp?B?S0t1Z3dMMnVQc1FVc0JYNjNPOXBDRjE2ZDNydHRURDNIR0dGdnk1WDMv?=
 =?iso-2022-jp?B?Z3lVZGNwcGxYMENPcmdqejBIbTRPNW9WRFBxd2tuTlVXZVo5cU9vTm9w?=
 =?iso-2022-jp?B?NUxoWERIMVpRRnNZREFVOHpDaUswQzJYbHVCT3NtMjNSUCtFbVJoU1Ju?=
 =?iso-2022-jp?B?Q2x1Q3U0MGlVb3lMTDBYTVhVWG96WlJDSXRqRDJnL0JWajk3cTJMZUda?=
 =?iso-2022-jp?B?cnE3T3BqM3lZVEJ0SmNOMmxvYWo0di80TmZURUNFVlREWHg0WktmRUJC?=
 =?iso-2022-jp?B?czNDeUVOTGIzTkN2YUJseFZzU0pjYlJ4MUt4dEhVZlpxa3N2VEt6MzFZ?=
 =?iso-2022-jp?B?Tlh0MFh4bU5yR2tSdTBWN3pWM1IxaHlSaElmNnJha3JaenZRYjZSb3ZQ?=
 =?iso-2022-jp?B?V1A0QUVOQXN5ajBQMWZDRUVLMDZTcTRlQ3N0aFVGYVJONG9RbVhhL2dC?=
 =?iso-2022-jp?B?dkVEK0F1L3RCWUxObmppVzJOaVBFY3V2b216ZmpEbEp2VWZxcmZ3WDZw?=
 =?iso-2022-jp?B?MkpvQVNLMCtZTWhyNDJqcUJqbzBwbDgyUkpZNkx6ZHVVdW1pMXFrU0pr?=
 =?iso-2022-jp?B?c0VzejR0SlUwa00rWlNuRWxRRHUrZ3dsUEQzekhWdC9VSFNDZXJvK05O?=
 =?iso-2022-jp?B?aTU1WFpvTTJGajJMQVdydTNVNE1tVk03alNLbHBLOGdiN1pWUTY3ZTll?=
 =?iso-2022-jp?B?ZlNxYUVyS01aZ3ZpeEQ4b3dNRTZqSXRVWEdQQk5UdGs5VVIyR1cxcXZy?=
 =?iso-2022-jp?B?YjVNUUZvWFFQa1MrUjBjSjQ1NGdRVXNzdTVKTUVSSzNGL25mYmdMYTUv?=
 =?iso-2022-jp?B?UkxrVmFLdGZyeUFhUDg5dXBoUzJTaGE0L2hWTVhjZWpZQVBablhVNmlU?=
 =?iso-2022-jp?B?dDYyYlV0T2lPdDFuYnZpazgvak42anlKekRNYlRqT2hPakJJaDE0KzA0?=
 =?iso-2022-jp?B?cFJXZmd4WnVRTzhxR3lpd2x2aGZkaUNDUUlVYTVRQVJ2NUlCZzRhS1py?=
 =?iso-2022-jp?B?U29KV0xBU2dRTnptOFZMdzd1emFBdHRQd1dBT3RJeXVYdERuMXRPWnV2?=
 =?iso-2022-jp?B?S2FsMERZRTBta2R5K21qSUI5cGlYd3R3TkQ4NldnU0dzNVFNM0hHVUt0?=
 =?iso-2022-jp?B?eE1TVDlXaVo3WlBmVy9vUmF5QnAwc0Y3ZmZ1Y2ZMVEo3dmtXaXRCZElN?=
 =?iso-2022-jp?B?NFBSdXlJV1NISVE2OW41bmtvcVdPcTF1bEFVaDQ4ajRpVHphNlBFdCs1?=
 =?iso-2022-jp?B?U1hVdkp1aVpzOGhjUGQxVFZ3UXBvNkM4dFFMVG1KL0ZLTUQxT3d0cTJP?=
 =?iso-2022-jp?B?OHNObDBqRXliN2Y5SVpDK0M2SjU2M0hJUnBTNnUwYThlU0V4WnNFNDUv?=
 =?iso-2022-jp?B?NCt6RnhFc0VTWWU0SG00VTdhWGd2ZUJJWVBKNmJzOVI0YUNadlllQ3lR?=
 =?iso-2022-jp?B?MlZmWWpWaFJMd0pTOHl0Q2lmYVkxUkhNYkdtbVpFbkVFRFcvdVQwVWFP?=
 =?iso-2022-jp?B?Nmw1WkNzaCt0a1A3TkxXamk0d1lkQzhHODZvTFo5cXVvV0lQWjJVTUxZ?=
 =?iso-2022-jp?B?ZGMzVmtHd3pEd2hOV3ZEUjJ6YUFzUENCRG92ZnVSci9QS2lKYlJhZG02?=
 =?iso-2022-jp?B?MTFBbjJ3SjBDMDdmdDBiTkZUbElFZ2dyZkFDbERjcmtBLy9xTllMYkY1?=
 =?iso-2022-jp?B?bWtIRmFTVDZxQW9Zem1jdWtXYkExUWl4dmdZWWluSG9neDM2U0VtRDli?=
 =?iso-2022-jp?B?Y01ySXhmWDJtQWFtVWRhQXlxSUVaN1l3VW1DemllcHErQUM3T254ZjBQ?=
 =?iso-2022-jp?B?d3NRRWRTcFh0Q3NrdkhZSDV5WGtNT2VIck56MWVXK3MvVVlxdFVQQlRQ?=
 =?iso-2022-jp?B?a2g2aTVhVUNrZzVXSHQ1NHdTaCtxR2RpeFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f8bfa6-6b5a-484c-2ba2-08db3cc9697b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 09:19:55.8814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdtRZWbzEGB4RsfiYisf1BziGvdp8vY+RQNpNAqlZHw9KX+E/CXTRN5pis4mlPqKq1vyw3PvnZWo77QKm8akXiNn/GYOvw0HhFKj4nJoy/fosxznuzIkrh8jm0A14Kz6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8762
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 09:20:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11202

Hi all,

CIP kernel team has released Linux kernel v4.19.280-cip96 and v5.10.177-cip=
31.
The linux-4.19.y-cip tree has been updated base version from v4.19.279 to
v4.19.280, and the linux-5.10.y-cip tree has been updated base version from
v5.10.176 to v5.10.177.

You can get this release via the git tree at:

  v4.19.280-cip96:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      0f5788ca10e5121ce62a8a58a84c723b7d99607f
    Fixed CVEs:
      - CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in btsdio_=
remove due to unfinished work
      - CVE-2022-4744: tun: avoid double free in tun_free_netdev
      - CVE-2023-23454: net: sched: cbq: dont intepret cls results when ask=
ed to drop
      - CVE-2023-1670: xirc2ps_cs: Fix use after free bug in xirc2ps_detach
    added commits:
      CIP: Bump version suffix to -cip96 after merge from stable

  v5.10.177-cip31:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      deb75c99ed78d677587a345854b8a00fb2cac68c
    Fixed CVEs:
      - CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in btsdio_=
remove due to unfinished work
      - CVE-2022-4379: NFSD: fix use-after-free in __nfs42_ssc_open()
      - CVE-2023-28466: net: tls: fix possible race condition between do_tl=
s_getsockopt_conf() and do_tls_setsockopt_conf()
      - CVE-2023-1611: Kernel: race between quota disable and quota assign =
ioctls in fs/btrfs/ioctl.c
      - CVE-2023-1670: xirc2ps_cs: Fix use after free bug in xirc2ps_detach
    added commits:
      CIP: Bump version suffix to -cip31 after merge from stable

Best regards,
   Nobuhiro


--
Nobuhiro Iwamatsu


