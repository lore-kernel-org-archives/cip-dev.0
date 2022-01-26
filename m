Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4671EC433EF
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 22:03:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web09.19939.1643234577154462648
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 14:02:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 20QM2nkn003536;
 Thu, 27 Jan 2022 07:02:49 +0900
X-Iguazu-Qid: 34tMJmyIPjzUU5iqX2
X-Iguazu-QSIG: v=2; s=0; t=1643234569; q=34tMJmyIPjzUU5iqX2;
 m=XTa1qgjm3i+RYtYZe2ORHUl3HqaSA7h7fwa631V4HCw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 20QM2l74040171
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 27 Jan 2022 07:02:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiDXXvw/N/fGXO0gujts2h5sUxFJfkuH+13UpnDT9eKo18hL8woUGjHVh9GX33rkCAPinPBvVA1sFPPoZKTo8wjWQNwJSXYUjb5sgdasWalbRYeS+fi2AY6MmcTEgIxHMHIp+fP9dMqMQV6cPc8JBEqvR1x9HnOa9dNkvb3LIYmxTTwmvS9CIbKqUvdYjljqEO2Skt4YeSOWW7nFgUJjgKadYPugtCq/c83XFdCLVEQ+zFsfbORF71BwSJV5frNa528XEy4DCCUCLojl+Un1yoGQdee8q4lOotj/3rCUtM85ibBIs7EKOad1oyymhVkUaq/X381vO5jJpPkqJguqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/Hcn36OrE7a67h9znLIuKuwW6mLquUfL53f+sS/dBw=;
 b=ExB3x5GfnDyzj4mVOurgt5SjmjNWFu7mJzdCCfYkvcgXppRLPZU/kWYyUXnDe4IyuOX4C9MRTFpBVBO9KpAgtV6d6EYHQ0kPCfN5O3yg4m9sPyAelWQSFGzDH7Wwx3cVLKOAE7gzIYt9S2rd5iHj4/iIzxXatYTCElBsAIzyoMnY04K5xkAfDEp4PLdIl+KCJXDA0J2mA1XNZJomQ9YfOw5CS0FINXo27CPl3CRr4t1FEuWQIaEYDrQxsWFWYC2554FT+T5eUkuV+1UVWgMLwAgifWB+uoqO4tvOnlXGM8rTU4FoKRbXDvNexYntIRgWC8wFy0Lz9XUYw/BH/YZCvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Thread-Topic: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Thread-Index: AQHYEvJ202eby2TASUy4nztI+sVchqx11GWQ
Date: Wed, 26 Jan 2022 22:02:45 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB625274BC4EFFA92D99EF211792209@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20220126202213.31975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220126202213.31975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82b3e989-4659-48fe-b117-08d9e117957a
x-ms-traffictypediagnostic: OSAPR01MB2306:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB2306AD58D80FEBDEC4DDB20492209@OSAPR01MB2306.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:459;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zeyeXgZHobFL3bE2VsIFx6PLkILycwnMNLeZUOlvIZwQbRwAcN7iIZn9v9W3x9qwWLHewrSgK1YPPBXBCEccwDYUIwbUKWuzxNUv2eWtEie+TChIOJwlwMiXaz+OMs7CDITVDKT6ReTCyksIVIGvs2hGu25OZdWHctAAszMXodQPmQGePVWMbyEi6UDSJJY86Mf+6P5qL95+I+Qzm6/XExjY9jFFoCDVyiVVhsnR/rfTloYgorXXTOf8KG7nBaBSy0nC3jdEzWcih+2fcoofN6teqdK50gqr5U43sQ30ISKXqZI3teeeOWb7gFqGnr5sJlFftuR/lsqWX2chOfCwZ4XcvFtWY2pkr19qMxKxcq5K1IE1MeW2KW9sXvVLbgFlv+50a+CU9wEHmnvaO2MzvZPl3uFVMvBa/+Hh6Y8pJJkaYawLehrY0sh0uGI4Xc5oVQVW9zsYRlgHqddzWTg+BgBmM05QAO52QoXnBEmL6j8rsWj4MUrNcqvTRZk04nQEOUE3qcJeTBGG3Vc3/AdI2P5MP+gdOFW1DA79cHWR/k+5x1WsyabDL0PX3a3ghU3bboG68DspCdIqHoOkippATwaeG0gIFsqv7dzUGcxD9bpzWi8KzVoj+FPE6f30SuykZqAhSPowlx3n3KUOdjTckZ5eF/SDAZ0ivwPlTOslJFvSy7WXxqDgMUglzQ9VIF0mFSuRFEzfDFpSJbTID4r4XNM/4H4CfcGYfB/bNjVweIl2lUjHkYg3PM5Js6WxkrsfixSctzFu/Zlwz9TnjgPM9EvPIQahp0fTmxL5Xjw0f/I=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(966005)(508600001)(8676002)(9686003)(4326008)(186003)(26005)(64756008)(122000001)(33656002)(66946007)(76116006)(316002)(66446008)(66476007)(66556008)(55016003)(53546011)(2906002)(86362001)(110136005)(71200400001)(52536014)(83380400001)(38070700005)(5660300002)(38100700002)(7696005)(6506007)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?c2xVclpFOCtNR0s1cEFab2doSHlCOTZXeXl1Qmx6elp5anZ4T0Vra2Vx?=
 =?iso-2022-jp?B?ZTZjY0w5UUI0cFJZWTJTYzVxdlExSTROUXc1WXVSalQ1VGIwanVRdG9M?=
 =?iso-2022-jp?B?OTVTZ1VraEN3MG1lNWl2cEFiQlNFOUNpbmZqNmhVM1VZcUE2ejArSTVF?=
 =?iso-2022-jp?B?LzVDaEhvdVJxY05qeGZoZ3VuMDh1TXFackFMY0ZZMVRteTc5Z1ZTSlR5?=
 =?iso-2022-jp?B?Nk41Zm93RG8rM2xjaElYN3ExalptZ2EzUnBweFRUeERINlM4Nmo1eFg0?=
 =?iso-2022-jp?B?bjR0YmNGZ09tTGY5UFJjQWw4d08vV1BycVdVMTBkMHkzNVlTZERDQXNz?=
 =?iso-2022-jp?B?R3R0azJxejdwM0U2dUtDckVlcWdFVnNNTDJvRlN3QVhYZS82Y0VNZHd5?=
 =?iso-2022-jp?B?VnRWLy82bHFmak1VZ2d1NVZmeTN6ODA5ejhoN0daY0tzbStyZEZUQ0RB?=
 =?iso-2022-jp?B?dVhrYStoRlU3YWpCZjhWZitET0N4U3dZd3l1aHhBTUZpUmYraXdFR2JB?=
 =?iso-2022-jp?B?c1VvbzlTRUZlM1Q5WVl4R1pWSjBtRnV2ZnhwRDRKd2ZGUXBSSlZoUE5q?=
 =?iso-2022-jp?B?cjhHTnFVRXVJVjh0Wk5VYkE5bThqTUxOVnBxeHo4SWQrQjhIQ29tT0xq?=
 =?iso-2022-jp?B?YVB0OWt6NlVkeVBuK3hWTWRXa2VyZ2RwVkx4YWFyZWhTb3BjYzcvVHRn?=
 =?iso-2022-jp?B?a3RaMm9ORzQ2aUNOME4yQzVKbDJXUjN1VHRheG4wWUxpaGpkTEZ6NEhi?=
 =?iso-2022-jp?B?akYrNG5UL3p5aEdyT0hGM1JON2VBdFZHM0RwK0dDL0s3dTBRNjU2M3Av?=
 =?iso-2022-jp?B?ckI5NUJRN0VaekIxM1oxRnB3T1Iwekc0U2p3V2V6U0tpb2xJR25HMVBq?=
 =?iso-2022-jp?B?VVdOYXc5Q240bUtibm5qZFFnbFJqdmdSMXhsYUdERHJFaVJ3UGFab0lq?=
 =?iso-2022-jp?B?WFBrRzZhR1VJNzlYRFhWNUp5ZmdUaE5XQnlLQlFENGZsVGR3S2FjVkdP?=
 =?iso-2022-jp?B?TzM4RVNFNWN1d0lsQXZEQUdDTFdOaWNoMTlJQjduU0dYWjJyekpOakFG?=
 =?iso-2022-jp?B?Q21QNVVzNlJTRDhXTDJOeVlpeUhpUjNXc0RjNjh2N2wxVDlVZk1pOTdY?=
 =?iso-2022-jp?B?SW81U0M4ZlkwYWw1cWZWVlM1ZVlVUVdtdGdnTVZwZEkrZjA1cW9KaU5H?=
 =?iso-2022-jp?B?dm5ONERuaEdiRzZMVytKTkxieEFVQlNZUlhFTVlFY0FuWGNRTFBNSys0?=
 =?iso-2022-jp?B?UWxnY1NYOXFiTmlMOVVsekZoVUxXSW5sYVFGREE2cFd4dThDeVBGK2c3?=
 =?iso-2022-jp?B?TC9tK1ZPYk9XQ2xkZ3g3YnBReXdiSFlzWndONE4rQS8yRXozMGg2RzVG?=
 =?iso-2022-jp?B?aUpndGNkbkxOYU9wbXBGZFRDcTh5YmpWeWJCMUkxNnEyOG41TUdKU3lX?=
 =?iso-2022-jp?B?cFV1TkZWU2ZuNHhyNmc5ZmI0c1NCcW1rTHVYcFlYNjZvTVRZWDZQbndZ?=
 =?iso-2022-jp?B?RTlZV3NKcGhCQXZwNGsrWUhHVjAvcWw3OXZSR2JSSENIZ29ZbWFjSFk5?=
 =?iso-2022-jp?B?L3k0VCt2Uk9Ib05Yc3JOcWFNVFdCY0tEN1BaSGNhQldrTVdaQml3Sml2?=
 =?iso-2022-jp?B?R2tSUFFKMW1zNXAvcVhZZVk0d2c4YkVVY21rWjdUS1JMdWxQRHdZbWND?=
 =?iso-2022-jp?B?cEI4TzgyeU1GaGZkd2dMWVgzMGdjdGxMbzNoRnVjeE9nNnYwdUtSeTdC?=
 =?iso-2022-jp?B?QkdrVWNFR1h0ckh1Z3R2aUUyaXQyOWs5TmRLM2owbDBSeDU3RUF1L0Ru?=
 =?iso-2022-jp?B?Z2NyZHBSY2NLMmE2ZVNNTHRJbkhJUG9TQXhEeFRDSStVY29sUERVdlRj?=
 =?iso-2022-jp?B?aTlhMVZSL3RYRnA5bjNuWE83R1ZSYTZUUU9lNlpMNm5iV2JDbVdUeFFs?=
 =?iso-2022-jp?B?MGdUdHNrdUlNRVUyckVRN1ZnYmZFNlBLZHdIUTd3dkprUkxIdlY3SGpy?=
 =?iso-2022-jp?B?aVcrcDhXdW9DN1JEMU5UYWxoRk85Y2puS2RnQy9uTzVYdTRId3ZkdHh5?=
 =?iso-2022-jp?B?MjZzSE1FcUZqcEVCeTFoa2s4czBaMCt5YmhydmZIbHIrWjlCaUpkdUQv?=
 =?iso-2022-jp?B?TEp4ZDUrUFhKSFdJRTRMZGNZZGtGZm8vNTZ0K1k4RGkybWVZblJJejcx?=
 =?iso-2022-jp?B?YmFCSXphYTNacjlaS3o4clNYWWZkQkR2MGkrbWdpVkNzVndsTTZSVk9B?=
 =?iso-2022-jp?B?Nnc3MWpHcmplcFJFUHZJSUcwWURDbE9yNmVoMlhxT2RVbHg1OHg2T3ZI?=
 =?iso-2022-jp?B?Ky80emNTZGJtdzdNZzQxODVtb2htYW9qTXFJZUJQcnBrOWxQWmtLdEow?=
 =?iso-2022-jp?B?ZW8zOGpXYlp2Q25sdWM4NW9JZzdPZWJML2w4ZTNWa0lxb1F5OTJQVXlD?=
 =?iso-2022-jp?B?U3lUelp6VVQ3aFlxOEt3d3J0S0pOV2UrVzNtWGNSS0NmdlF3T1VhYlZP?=
 =?iso-2022-jp?B?K2FDTGl5NzhMcUdSMUY5Vkx5WEdZWFRGdGIxZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 82b3e989-4659-48fe-b117-08d9e117957a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 22:02:45.7666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 /VudPO4He02CLbbJPsg9Gmp6we2/xBurA8mz4rr1XmU9qEDEop/zhcDKYAqPw2kKWDTuNLugfn/j+y8Oj6zgqN3yA/qAeCtXWWT++xqOxfOCdv9XvJRA2eaNPVckL+Ag
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2306
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 22:03:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7490

Hi,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Thursday, January 27, 2022 5:22 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
> make sure we free CAN network device
>=20
> commit 72b1e360572f9fa7d08ee554f1da29abce23f288 upstream.
>=20
> Make sure we free CAN network device in the error path. There are several
> jumps to fail label after allocating the CAN network device successfully.=
 This
> patch places the free_candev() under fail label so that in failure path a=
 jump to
> fail label frees the CAN network device.
>=20
> Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
> Link:
> https://lore.kernel.org/all/20220106114801.20563-1-prabhakar.mahadev-lad.=
r
> j@bp.renesas.com
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Kieran Bingham
> <kieran.bingham+renesas@ideasonboard.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

LGTM.
If there is no other opinion, I can apply this.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/457=
123034

Best regards,
  Nobuhiro

>=20
> diff --git a/drivers/net/can/rcar/rcar_canfd.c
> b/drivers/net/can/rcar/rcar_canfd.c
> index 52629c6c1970..6c8e7a51b04d 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -1640,8 +1640,7 @@ static int rcar_canfd_channel_probe(struct
> rcar_canfd_global *gpriv, u32 ch,
>  	ndev =3D alloc_candev(sizeof(*priv), RCANFD_FIFO_DEPTH);
>  	if (!ndev) {
>  		dev_err(&pdev->dev, "alloc_candev() failed\n");
> -		err =3D -ENOMEM;
> -		goto fail;
> +		return -ENOMEM;
>  	}
>  	priv =3D netdev_priv(ndev);
>=20
> @@ -1735,8 +1734,8 @@ static int rcar_canfd_channel_probe(struct
> rcar_canfd_global *gpriv, u32 ch,
>=20
>  fail_candev:
>  	netif_napi_del(&priv->napi);
> -	free_candev(ndev);
>  fail:
> +	free_candev(ndev);
>  	return err;
>  }
>=20
> --
> 2.17.1


