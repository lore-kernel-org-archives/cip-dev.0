Return-Path: <SRS0=HEeh=II=lists.cip-project.org=bounce+64572+6266+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20EEC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 09:37:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E162664FF3
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 09:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E162664FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6266+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UTyYYY4521723xqVpHmxjIeC; Wed, 10 Mar 2021 01:36:59 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.130])
 by mx.groups.io with SMTP id smtpd.web11.6663.1615369017419995688
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Mar 2021 01:36:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko4WqED4BuE/CA7rW/YVktQofaFFNp7otU0Hps2VyoksRedZIXuxRHQQGmn/zG5qCo3uzxhlX1fdG3foJONiyTsvANOgsO8NZv56YrMPLOvvlVOcvxaH6cqPIouEOccrxh7nw41IcYyRygznLp6XDLv4AF9M/2SEITAML55ITZEHubAV4Qmec3fSUzqEFYEvZ6eDjbZtZV68nRss0yq0P3OnrzCCTHpCWoB4BPNI/+iq3yuKI3MNLFN5yXRMeHYa87DfOpAuaZSxm4L1gzXzouSR9ugUZi2XfL+M+PoxzbXdbbklho7EKu9omfMa8N5+vnUItVD5mqvUjlE2PyztMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNGWR4j1jTia4sTtKakBBeYYuKeCCcifPCe+P+sQwak=;
 b=VUi22jPT9h9Oy+O4ncP44n8R2PVZUvAOWqJkKoJlipEwOynQO6OIj+xNxANHiZ8nb5cv8CE7ZV0BBCYZ0YxEeZXLpVKa9kHc8FZhHPPAz8IpbTrMmf2Ticscs0ril+nVY2w1Bh4BGrjnZS+qftiyzQXNJCes6gJgnM4UunCAC+DWCPR2KeMHOhWevVwHwphycJQGvIl5ia8Iwjx8FUUrfLrUh7Ls/8ThSLU6itVaeSmKdNpx5OaEPrWfX+NJID9OXbSxr/IYEM6qEk2BEI2DHb6+rtJeXsysYslTAHllTiim4HOwRbScAF7lCE+SY/WiMmVWPh1ljUVO5lCae7PPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSAPR01MB4867.jpnprd01.prod.outlook.com (2603:1096:604:6f::14)
 by OSBPR01MB3334.jpnprd01.prod.outlook.com (2603:1096:604:4a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 09:36:54 +0000
X-Received: from OSAPR01MB4867.jpnprd01.prod.outlook.com
 ([fe80::24cf:baf6:7ab1:2ede]) by OSAPR01MB4867.jpnprd01.prod.outlook.com
 ([fe80::24cf:baf6:7ab1:2ede%4]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 09:36:54 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 13/40] media: i2c: Add driver for Sony IMX219 sensor
Thread-Topic: [PATCH 4.19.y-cip 13/40] media: i2c: Add driver for Sony IMX219
 sensor
Thread-Index: AQHXFSPscDJRSPeKnUKXJrfStjkqy6p870yw
Date: Wed, 10 Mar 2021 09:36:54 +0000
Message-ID: 
 <OSAPR01MB48672E161C93582BDF81A520AA919@OSAPR01MB4867.jpnprd01.prod.outlook.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309163656.20944-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309203635.GB7900@amd>
In-Reply-To: <20210309203635.GB7900@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 324b0170-dc1e-480a-bd75-08d8e3a80a87
x-ms-traffictypediagnostic: OSBPR01MB3334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB333424C86D6C1F2DD7971EA5AA919@OSBPR01MB3334.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 03nD8IjRvXeDmsmH+eVC1ma1h8LpFjqke9vFt1vbLOvz1GxBOKx4WcPcpXmzrfEHVIYl9hxX5Deq0x7aHDiAPqbFkTS/n+TNZ7nSHi7AT4cHsbL7laq9OUtJ1ObqFe090efi5AIDd1AVzywXsLaC3MftDhPGeWwCNGfPPsFugXhrTQZqBJvQBb+CZIdhC8ExqW3WseBoj1gqOwFcQId8wBV57pAw1UK1s64S//rjUMwFsyoy7JjBsNQGeFeZFwGVBoXgxnN2K3Bk4mD4Z/OzvU87gZX2M2vT1jGXACRzSpvfRxQBNc8quctn8dDNwcpOH9MbHvulsDMWt2QwMX9O6+7bXIDoHcajgDQTicJxOEeRPazNna286nGKLDsBcXdBiXB9LnQqUYpVVNyLLnlBSvnkZM8lbQ1/ELn4iWOcLJA1BuoHMMAmeb72x5Muh+/VoqfqSPx/TFSmIhalL+DJb6qOKxoogHq8Cb5NN/wJfosqd/AI3kFJmJbH5dxXSDF5sDH02BQ9C/W059+eocuLf0gNPqFhHhRkBKpYKJ8yPAt5jRyPZ2+VMXfjuMTYBcFueujkHrmM06VJfTVJIKzfsHD4Ipe4ct8Y9I3enEWoD8E=
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?MArl1OImARtwtkvMmOYMEKC1txpl7EUb26pp3ZiaeUy6lVwug0MxftKMcjKB?=
 =?us-ascii?Q?A0IKW+rQrXuq2CLf/1ZywJvVmWUGRsmhnC8LVWkZQzoM0J4UscgagQv3+hr6?=
 =?us-ascii?Q?D9KVOBuPSluMrXQOYVngeanFMS1IkcUE88c6OFTYc6YfjO5akCMgdkEGCr3X?=
 =?us-ascii?Q?ChTMdoNbuVtUH4v0oHBXESc0aK8Nyi5MKmCt+YgazQQW4L+8sVHoEcYD4hi9?=
 =?us-ascii?Q?VejvH6AqdpfGrSlfap3B/F5MSef4sqqMcKTrhsuCJ9ROvCE/7B1pjXWfCmIF?=
 =?us-ascii?Q?XvqYu2r4fIbkmKOVeK//PkiKhXYD/VYgRnBOO/v39XqrgMqSwtKHxRi51iXh?=
 =?us-ascii?Q?XcQoP+5ihiNXC247+LO2a1IXjgfUSEn9wdve7MoPcx1XSc4rzUlabaVVBJPu?=
 =?us-ascii?Q?Gjpkr2V99gy2LyQmwTFqfPnf5SQuEmlQAvE0rc5ILZ91EXFAeyOc59DtI1z4?=
 =?us-ascii?Q?W+q9pUPmX8EP4toM56+RhbeTRdkl/ubY3g86ucdjh1SeJDkXtAUbwZBtnHOr?=
 =?us-ascii?Q?lMqHtP2gOiZDFiVtD3lG670s25W+nho1y2tGgn/Vmz5zQT8N2eK2R21S3815?=
 =?us-ascii?Q?4PKKjjvnW3Y5RdmnUfemp1eiRt9HLyQUA2INqNm3lD5MB6xcM91OapUd8kNB?=
 =?us-ascii?Q?ufoVPZST3h1WNG1Q+shs4m2m5jW5Pgrto+eCei4QEs89emZKi0HGc8ZViSdi?=
 =?us-ascii?Q?QjOVZBozl5ZLduo685dydYKhuajjJq5SuCQy1wXUL28GFTTmCDXv1vKUlGbF?=
 =?us-ascii?Q?3l80d6LzS8m9xHSJaT0/hyA68pqT7XIV5LzUJuua0z3K6HbQBvvh1C/jtRw9?=
 =?us-ascii?Q?5rsBgzdTwXZARLggVNb96j0vJM4onF/WQ0Z/S3OMXXZ5CMb2xITDctEPBkCp?=
 =?us-ascii?Q?RL7QoPns9Lzx7dqpe5hap+sOghQvYfId9ivTuHAvEyXDM12hMIQ9/ALZV7YI?=
 =?us-ascii?Q?LDhXFtLBlgKPyuPOJyRJ9pWu4wT0xTo6kw4PAr4WZ6/J5//W/r7l85nGlASl?=
 =?us-ascii?Q?pfuePQ+bgFwb/tMPhRZr0Zzntu5jSE3MkZvzKDV0gVWM+2xRqbydD0yZOV3x?=
 =?us-ascii?Q?r31TD7Be24OuQE4PxZR+WEmuHT9aexyK1GdImuQmwG7zEPOzZAzUIzXvyw6C?=
 =?us-ascii?Q?8d+pOkkRtjzHqtk0fjpm0PYGBKVGpiZAZCi2icU24HJ3vC+9NZNaQemaE1d+?=
 =?us-ascii?Q?Ib6q/tl9Xku9PxUgjhHzCpvZsU/XZPzdK0DDNugk6MZex5spm/GHLAISO4Wl?=
 =?us-ascii?Q?aLhZuimmqKqdmmrfwhnvQ/V2wdKCg3aRD6ihA6doRKVixgGno7816v9yKnib?=
 =?us-ascii?Q?lCWdjQAf8aYnC2ZQqNYhE15h?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4867.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324b0170-dc1e-480a-bd75-08d8e3a80a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 09:36:54.2314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /t/8iN7S9p3gLaFuE5BSb3hWaJ3xZ5Yg5GkdW6lQj6ygZjqn24g2Y2f0wrdoq95Bpko65BcvCArsRTLVxaeHahvR4rlUdlCqFxMZJeXJox06UjQMHyQkR3TEc3zyqjxm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3334
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 11UKgnOFluOyBKBhtI52zSS9x4520388AA=
Content-Type: multipart/mixed; boundary="pUmd5VNOpSYzuAk0lmnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615369019;
 bh=8APB7htEl/mFiiZ4/t05lpOc+kk30bL0WUyWfMQruoc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=mpW5+vnbK+ha8V9r26WT5TCtuOpiD7oLxMh9oUGa5xVsZD2XXn4oGjzHgZcW1U4J3wa
 Ui1qfgNO0Xxd78aoHf/hcYBcv+F/Ye07esQ9RC68mD4AT/PDTjPlUIjSbWAdcHdqOrXqa
 EXw2FZ+aWUrf9Pt6Jv55xzcVv2JGs5tlxtQ=

--pUmd5VNOpSYzuAk0lmnt
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 09 March 2021 20:37
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 13/40] media: i2c: Add driver for Sony IMX=
219 sensor
>=20
> Hi!
>=20
> > +/* External clock frequency is 24.0M */
> > +#define IMX219_XCLK_FREQ		24000000
>=20
> MHz?
>=20
> > +/*Frame Length Line*/
>=20
> Make this usual comment style.
>=20
> > +/*
> > + * Initialisation delay between XCLR low->high and the moment when the=
 sensor
> > + * can start capture (i.e. can leave software stanby) must be not less=
 than:
> > + *   t4 + max(t5, t6 + <time to initialize the sensor register over I2=
C>)
> > + * where
> > + *   t4 is fixed, and is max 200uS,
> > + *   t5 is fixed, and is 6000uS,
> ...
> > + * 1185 to 5333 uS, and is always less than t5.
> ...
> > + * For this reason this is always safe to wait (t4 + t5) =3D 6200 uS, =
then
>=20
> I believe this should be "us" or "usec".
>=20
> > +	/*
> > +	 * Mutex for serialized access:
> > +	 * Protect sensor module set pad format and start/stop streaming safe=
ly.
> > +	 */
>=20
> This is not really english.
>=20
> > +/* Read registers up to 2 at a time */
> > +static int imx219_read_reg(struct imx219 *imx219, u16 reg, u32 len, u3=
2 *val)
> > +{
>=20
> > +	msgs[1].buf =3D &data_buf[4 - len];
> > +
> > +	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> > +	if (ret !=3D ARRAY_SIZE(msgs))
> > +		return -EIO;
> > +
> > +	*val =3D get_unaligned_be32(data_buf);
>=20
> That's really interesting piece of code. len is in bytes, but return
> value is in 32 bit values, magic with be32...
>=20
> > +static int imx219_write_reg(struct imx219 *imx219, u16 reg, u32 len, u=
32 val)
> > +{
> > +	struct i2c_client *client =3D v4l2_get_subdevdata(&imx219->sd);
> > +	u8 buf[6];
> > +
> > +	if (len > 4)
> > +		return -EINVAL;
> > +
> > +	put_unaligned_be16(reg, buf);
> > +	put_unaligned_be32(val << (8 * (4 - len)), buf + 2);
>=20
> Wow. When I thought above was interesting.... this is even more so.
>=20
>=20
> > +static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> ...
> > +	/*
> > +	 * Applying V4L2 control value only happens
> > +	 * when power is up for streaming
> > +	 */
> > +	if (pm_runtime_get_if_in_use(&client->dev) =3D=3D 0)
> > +		return 0;
>=20
> Is this usual for other cameras? Will not it cause problems to
> applications doing autogain?
>=20
Above check is to see if the camera is turned ON, so the application doing =
autogain should be fine.

> > +	switch (ctrl->id) {
> ...
> > +	case V4L2_CID_HFLIP:
> > +	case V4L2_CID_VFLIP:
> > +		ret =3D imx219_write_reg(imx219, IMX219_REG_ORIENTATION, 1,
> > +				       imx219->hflip->val |
> > +				       imx219->vflip->val << 1);
> > +		break;
>=20
> ctrl->val is unused in this case?
>=20
Yes, for the H/V flip it depends on the format code set.

> > +		break;
> > +	default:
> > +		dev_info(&client->dev,
> > +			 "ctrl(id:0x%x,val:0x%x) is not handled\n",
> > +			 ctrl->id, ctrl->val);
> > +		ret =3D -EINVAL;
> > +		break;
> > +	}
>=20
> Rate limit this as user can trigger these?
>=20
Yes can be triggered.

> > +static int imx219_set_stream(struct v4l2_subdev *sd, int enable)
> > +{
> > +	struct imx219 *imx219 =3D to_imx219(sd);
> > +	struct i2c_client *client =3D v4l2_get_subdevdata(sd);
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&imx219->mutex);
> > +	if (imx219->streaming =3D=3D enable) {
> > +		mutex_unlock(&imx219->mutex);
> > +		return 0;
> > +	}
> > +
> > +	if (enable) {
> > +		ret =3D pm_runtime_get_sync(&client->dev);
> > +		if (ret < 0) {
> > +			pm_runtime_put_noidle(&client->dev);
> > +			goto err_unlock;
> > +		}
> > +
> > +		/*
> > +		 * Apply default & customized values
> > +		 * and then start streaming.
> > +		 */
> > +		ret =3D imx219_start_streaming(imx219);
> > +		if (ret)
> > +			goto err_rpm_put;
>=20
> Is it correct/vital that one error path uses put_noidle() and second
> uses plain put()?
>=20
As per my reading https://patchwork.kernel.org/project/linux-omap/patch/201=
80518173008.73291-2-tony@atomide.com/ its OK.

> > +static int __maybe_unused imx219_resume(struct device *dev)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +	struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
> > +	struct imx219 *imx219 =3D to_imx219(sd);
> > +	int ret;
> > +
> > +	if (imx219->streaming) {
> > +		ret =3D imx219_start_streaming(imx219);
> > +		if (ret)
> > +			goto error;
> > +	}
> > +
> > +	return 0;
> > +
> > +error:
> > +	imx219_stop_streaming(imx219);
> > +	imx219->streaming =3D 0;
>=20
> This error path will leave driver in inconsistent state. hflip/vflip
> controls will be locked and pm_runtime_put() is not executed.
>=20
Good catch, this needs fixing in upstream.

> > +static int imx219_check_hwcfg(struct device *dev)
> > +{
> > +	struct v4l2_fwnode_endpoint *ep_cfg;
> > +	struct device_node *ep;
> > +	int ret =3D -EINVAL;
> > +
> > +	ep =3D of_graph_get_next_endpoint(dev->of_node, NULL);
> > +	if (!ep) {
> > +		dev_err(dev, "missing endpoint node\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ep_cfg =3D v4l2_fwnode_endpoint_alloc_parse(of_fwnode_handle(ep));
> > +	if (IS_ERR(ep_cfg)) {
> > +		dev_err(dev, "could not parse endpoint\n");
> > +		goto error_out;
> > +	}
> ...
> > +error_out:
> > +	v4l2_fwnode_endpoint_free(ep_cfg);
>=20
> Is it correct to call endpoint_free on error pointer?
>=20
Yes the core handles it.

> > +MODULE_AUTHOR("Dave Stevenson <dave.stevenson@raspberrypi.com");
>=20
> Missing ">" at end of address.
>=20
Yep needs fixing as well.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pUmd5VNOpSYzuAk0lmnt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6266): https://lists.cip-project.org/g/cip-dev/message=
/6266
Mute This Topic: https://lists.cip-project.org/mt/81205356/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pUmd5VNOpSYzuAk0lmnt--
