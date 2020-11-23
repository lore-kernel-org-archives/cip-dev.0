Return-Path: <SRS0=sF5j=E5=lists.cip-project.org=bounce+64572+5832+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C88C2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 23:00:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E43206D8
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 23:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DZ/oMstB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E43206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5832+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vm3UYY4521723xeCc5ZLdFHW; Mon, 23 Nov 2020 15:00:51 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.99])
 by mx.groups.io with SMTP id smtpd.web11.44186.1606172450344623041
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 15:00:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJfE4RfgF5HDgXs9jNecwSGmZyBSOulwn4Z7mFpGc3UbYcEPem2Hx1ExhnW/1MQd+xffsuMBTqRmTm9eDwbd9agn9BT55Et+FcqCZfds+LWpq9IuIvDAzhOwZMKmf6oY0rrS7UZ8AGaJLZRiDgE4VH1y2D2GI/CP0R+XLQKXbdXT4HNDxdAUnbaZlJt7WV1q2PHmOOA4Z3/SAQSzLhLGX0Fs7NEotK5i/kbPZMMbut33MsFMMoaW8nD258gvRsAQsUwVI52lvdTjYpt+474w+NGVkQGMP+Dg4qQLJPrPV8FrjAJpQzDbFgFWzGmQrfCwdL2GN30lpmkLRH6a4D51TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMrtgnjIj137/qjXQa0nXdh6uXeISuRgDnT4r4QQ0mY=;
 b=DOXj+TEh5wmbIqG7DF64fVIGw8wBIvguZ6JQ1N04dUPcaMplcIA6BIB5KM9mKU9tMTDnRq6kJabvZUdBIL8cyyr+TMshObtY9t8/vZpkiIKjaj/EtwuCdT3ReN2W5gpVdu10wNkzzfjz5uevwj5pq3nUeYe+qkPXY1jjVpfKrphNu2zlzu/CjOF/l4GuPpMYs8twehyIL6hPkD/40h2HXJKfHCZIVX7YEIOOHIlylHuAEmmW2bNxRwu8iAwCr0NfkR9i3jeK1oZMv87Ug2imzgfhZMBg2Vd/qPRQCFe8CKgVhdZ+KG2XCJh+ktPpJJJBFlJuq2ks7FOXSvPQ5abYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB4182.jpnprd01.prod.outlook.com (2603:1096:604:4c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Mon, 23 Nov
 2020 23:00:46 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3589.025; Mon, 23 Nov 2020
 23:00:46 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/7] memory: add Renesas RPC-IF driver
Thread-Topic: [PATCH 4.19.y-cip 2/7] memory: add Renesas RPC-IF driver
Thread-Index: AQHWwdAfVGtdd6+dZUeV4uDONxNnA6nWUWTQ
Date: Mon, 23 Nov 2020 23:00:46 +0000
Message-ID: 
 <OSBPR01MB5048F8E3ED247EE8F532969EAAFC0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123193739.GA5619@amd>
In-Reply-To: <20201123193739.GA5619@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3911b90e-3875-42c6-e28e-08d890039d21
x-ms-traffictypediagnostic: OSBPR01MB4182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB41826B47E040DBA1FFE8CFC4AAFC0@OSBPR01MB4182.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 5tFzwWdscOB8ucobbgWTtwAn4DWTLna3xj1WFuSpxay8w8e5T5MNIWC/twC9NThBFDwh+eILKuedQF/t+gcH10VwanPniIrU9O/jFJlRRtTOu4Yf/t+cuoT95xVTjYMLGOOQP8h/nuJk9eYHfNx6S3dRO0QK5ez7OQA6hgLBmTFSAhChtM+0hn/IWGjc4DJbAghFVKpRENPP8uoxsJ6OeqDt9926fZzmHhqHWPQhBm0vfKNqmyPUTNBlKKMulLyRGlXHwVWADliaXrS1fMYVY0kcj20XsONHzq/pImzzfUJSlv55n2a2ZmJ4Cf7oJ+nGlZpeQBoeqYBtY0vhMG+Mfw==
x-ms-exchange-antispam-messagedata: 
 BAYm7mQb78F6EpN2PPICzLUp7gaOp4YOoCdFjOMVGmUk7laxtvH3c48y5q6Jv0udg+vxkJQQhi/+h5ye8ikhdB+ZUQqoVv9k3zADOYxYUCJ1N8IrXtrj/yWKs3/Q1ZezR5frQ5WS6tEOw9m47BiSZy9mYFRLF+FMo/yqJv+cRb+FDwsLvs/8Y3XaYkPFe2irZaXnjSW9rPYQRfPXN+1AYm1Hp0r31vYNZ4eDMi7PLLxhqniP6oNhpuuWwyGSn5wx4yzs/umZnEESVjo0x3bCqu8uBfhfyNEn7BW7WCzSzkDKr4ILpgeQ4kaypahHifwDqoI2orDGaH70ddx8+s2Nm9mOxocAghbn/OiaYcdwmcUvtLj1iuPSDY27o2/bkzFWWIEg9JpP9sPr3iMmYAsh3arJyT6lqN1aPfhtbVgUrZ25Vk0+KuCGqzTnx35oSSMMiFeSAkbeuQsVHqqZ3/uA59DbLzCFm3UtUZs632Vv04wC1ZheYqF+W+JJVHVYiQKYstqXSLfWm2II3+Z6c3lARJ7ZZXXY9rGe1kq5owMxjRpzh/ZUM0n/cfUyZjEDHjNIPJekiP3PyCqsIZ+iJuXuGC68PE706HZXtSLXt8uwPMwC2A2DVxrgaN5GgpVqd6YPAKXGsmq2u0UOBRxkyf8mb/d2wkDBKhQMjDsDZzCZ+4LKWUqk/CRGWHmpjZ+dVfKfmZqw0dSP9sCSab1XV2X+vCkFjGV3wJAN99BMbyVjmRzVXJX5b9f9TGeTDjgTyeYjgMG6ur9WJqICFAxHGh8jrg0wmebtSUN2+4dPhEUi/9KZ0HM1tIeye2J2pSP4TvA+0kyPxdMYC0dtCZVgpy8Ka9z1LEmi8wCIYMUUqkDUlCKC/VMQ7fZ35hYixXEUKVYG7DdQ/H28LdJyYUd1li/cSQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3911b90e-3875-42c6-e28e-08d890039d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 23:00:46.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Waku1i6KKeNl5nRKJbnHnhTw+LTHxgNvvvXS0vSJjVqmiKUW30KRJQEox6AedeFPx/6IaqZaBrXvmCuWjh+dnOBFg13GB7hKDIw2P1eFCxe4N22QRBPyq9p23p9Wres3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4182
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PqVgIX7bP3or0XMfy9I3TM12x4520388AA=
Content-Type: multipart/mixed; boundary="XgEPzsTwesmV5F2UkzDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606172451;
 bh=4MIWExXjuazWkKp0Afd9rl9LGmfLH7AwWIwxAigBkes=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=DZ/oMstBF7m9tUqwM+CZLu5Vtc8D2icrFMeXaiVwM5ogf2T7n7/im7Q+8/gn8/eKApk
 pMLG53CJtR3zIaqFcL3/VjxCORy6yfic7qMILXChdRleayZkKHwW4nB0561/tXrcbT8ZF
 GW8VJwFy4RWIWeQbb7rDTwhoRVqxYO8I3cc=

--XgEPzsTwesmV5F2UkzDM
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 23 November 2020 19:38
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 2/7] memory: add Renesas RPC-IF driver
>=20
> Hi!
>=20
> > +EXPORT_SYMBOL(rpcif_sw_init);
>=20
> EXPORT_SYMBOL_GPL?
>=20
Agreed will fix that and squash that in the current patch.

> > +void rpcif_enable_rpm(struct rpcif *rpc)
> > +{
> > +	pm_runtime_enable(rpc->dev);
> > +}
> > +EXPORT_SYMBOL(rpcif_enable_rpm);
> > +
> > +void rpcif_disable_rpm(struct rpcif *rpc)
> > +{
> > +	pm_runtime_put_sync(rpc->dev);
> > +}
> > +EXPORT_SYMBOL(rpcif_disable_rpm);
>=20
> Should these go to header as static inlines?
>=20
Would be nice will make them inline and squash it in the current patch.

> > +static int wait_msg_xfer_end(struct rpcif *rpc)
> > +{
> > +	u32 sts;
> > +
> > +	return regmap_read_poll_timeout(rpc->regmap, RPCIF_CMNSR, sts,
> > +					sts & RPCIF_CMNSR_TEND, 0,
> > +					USEC_PER_SEC);
> > +}
>=20
> This can't be right. sts is used uninitialized here.
>=20
Third parameter in regmap_read_poll_timeout() is the variable in which valu=
e is read and the fourth parameter condition has to be tied with the third =
parameter (there are similar instance in the kernel).

> > +int rpcif_manual_xfer(struct rpcif *rpc)
> > +{
> > +	default:
> > +		regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
> > +		regmap_write(rpc->regmap, RPCIF_SMCR,
> > +			     rpc->smcr | RPCIF_SMCR_SPIE);
> > +		ret =3D wait_msg_xfer_end(rpc);
> > +		if (ret)
> > +			goto err_out;
> > +	}
> > +
> > +exit:
> > +	pm_runtime_put(rpc->dev);
> > +	return ret;
> > +
> > +err_out:
> > +	ret =3D reset_control_reset(rpc->rstc);
> > +	rpcif_hw_init(rpc, rpc->bus_size =3D=3D 2);
> > +	goto exit;
> > +}
>=20
> So we get failure in wait_msg_xfer_end(rpc); but then
> reset_control_reset(rpc->rstc); returns success and whole function
> returns success. Is that ok?
>=20
Good catch this needs fixing (upstream too).

> > +static int rpcif_probe(struct platform_device *pdev)
> > +{
> > +	struct platform_device *vdev;
> > +	struct device_node *flash;
> > +	const char *name;
> > +
> > +	flash =3D of_get_next_child(pdev->dev.of_node, NULL);
> > +	if (!flash) {
> > +		dev_warn(&pdev->dev, "no flash node found\n");
> > +		return -ENODEV;
> > +	}
>=20
> Does this need corresponding of_node_put()?
>=20
Agreed this needs fixing (upstream too).

> > +struct	rpcif_op {
>=20
> Weird formatting; we normally use spaces (not tabs) for this.
>=20
Agreed will fix that.

> > +	struct {
> > +		u8 buswidth;
> ...
> > +	struct {
> > +		u8 ncycles;
> > +		u8 buswidth;
> > +	} dummy;
>=20
> Are you sure this will be consistent accross architectures? Should the
> structure be marked attribute packed or something?
>=20
Should be OK as this driver is intended only on R-Car Gen3 and RZ/G2x (arm6=
4).

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XgEPzsTwesmV5F2UkzDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5832): https://lists.cip-project.org/g/cip-dev/message=
/5832
Mute This Topic: https://lists.cip-project.org/mt/78451541/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XgEPzsTwesmV5F2UkzDM--
