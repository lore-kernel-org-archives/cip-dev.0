Return-Path: <SRS0=QEk7=IH=lists.cip-project.org=bounce+64572+6259+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91944C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 20:36:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA716522E
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 20:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA716522E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6259+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MK0UYY4521723xS0M4DnbUPx; Tue, 09 Mar 2021 12:36:43 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.428.1615322201609764050
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 12:36:42 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 228B91C0B78; Tue,  9 Mar 2021 21:36:37 +0100 (CET)
Date: Tue, 9 Mar 2021 21:36:36 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 13/40] media: i2c: Add driver for Sony IMX219 sensor
Message-ID: <20210309203635.GB7900@amd>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309163656.20944-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210309163656.20944-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Ye0L2458kkaP1RARiQmNvIcdx4520388AA=
Content-Type: multipart/mixed; boundary="npr8xS0MmdT7V8RtpTpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615322203;
 bh=WXstPWEjnklTyoQOqzyqFB9ZBSBt/Zt+k5LfxGjQ9dY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=U9Qie1cFVYIgmc+TC16h4MmRA7WCUROO8P+x/ePpIdRDwfV9efenU9CMmfinG5U/dLs
 Wj+kmBrsCHqpVRJmLazQ/u/mDWVg51MjS8yLHSVJ+Zqaf6RcpsVIXQczHB0Qb8fsa6QN/
 9GA7wFj2/9HUgY/9EP/e7ADPb5npQ3eoKzM=

--npr8xS0MmdT7V8RtpTpl
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline

--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +/* External clock frequency is 24.0M */
> +#define IMX219_XCLK_FREQ		24000000

MHz?

> +/*Frame Length Line*/

Make this usual comment style.

> +/*
> + * Initialisation delay between XCLR low->high and the moment when the s=
ensor
> + * can start capture (i.e. can leave software stanby) must be not less t=
han:
> + *   t4 + max(t5, t6 + <time to initialize the sensor register over I2C>)
> + * where
> + *   t4 is fixed, and is max 200uS,
> + *   t5 is fixed, and is 6000uS,
=2E..
> + * 1185 to 5333 uS, and is always less than t5.
=2E..
> + * For this reason this is always safe to wait (t4 + t5) =3D 6200 uS, th=
en

I believe this should be "us" or "usec".

> +	/*
> +	 * Mutex for serialized access:
> +	 * Protect sensor module set pad format and start/stop streaming safely.
> +	 */

This is not really english.

> +/* Read registers up to 2 at a time */
> +static int imx219_read_reg(struct imx219 *imx219, u16 reg, u32 len, u32 =
*val)
> +{

> +	msgs[1].buf =3D &data_buf[4 - len];
> +
> +	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret !=3D ARRAY_SIZE(msgs))
> +		return -EIO;
> +
> +	*val =3D get_unaligned_be32(data_buf);

That's really interesting piece of code. len is in bytes, but return
value is in 32 bit values, magic with be32...

> +static int imx219_write_reg(struct imx219 *imx219, u16 reg, u32 len, u32=
 val)
> +{
> +	struct i2c_client *client =3D v4l2_get_subdevdata(&imx219->sd);
> +	u8 buf[6];
> +
> +	if (len > 4)
> +		return -EINVAL;
> +
> +	put_unaligned_be16(reg, buf);
> +	put_unaligned_be32(val << (8 * (4 - len)), buf + 2);

Wow. When I thought above was interesting.... this is even more so.


> +static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
> +{
=2E..
> +	/*
> +	 * Applying V4L2 control value only happens
> +	 * when power is up for streaming
> +	 */
> +	if (pm_runtime_get_if_in_use(&client->dev) =3D=3D 0)
> +		return 0;

Is this usual for other cameras? Will not it cause problems to
applications doing autogain?

> +	switch (ctrl->id) {
=2E..
> +	case V4L2_CID_HFLIP:
> +	case V4L2_CID_VFLIP:
> +		ret =3D imx219_write_reg(imx219, IMX219_REG_ORIENTATION, 1,
> +				       imx219->hflip->val |
> +				       imx219->vflip->val << 1);
> +		break;

ctrl->val is unused in this case?

> +		break;
> +	default:
> +		dev_info(&client->dev,
> +			 "ctrl(id:0x%x,val:0x%x) is not handled\n",
> +			 ctrl->id, ctrl->val);
> +		ret =3D -EINVAL;
> +		break;
> +	}

Rate limit this as user can trigger these?

> +static int imx219_set_stream(struct v4l2_subdev *sd, int enable)
> +{
> +	struct imx219 *imx219 =3D to_imx219(sd);
> +	struct i2c_client *client =3D v4l2_get_subdevdata(sd);
> +	int ret =3D 0;
> +
> +	mutex_lock(&imx219->mutex);
> +	if (imx219->streaming =3D=3D enable) {
> +		mutex_unlock(&imx219->mutex);
> +		return 0;
> +	}
> +
> +	if (enable) {
> +		ret =3D pm_runtime_get_sync(&client->dev);
> +		if (ret < 0) {
> +			pm_runtime_put_noidle(&client->dev);
> +			goto err_unlock;
> +		}
> +
> +		/*
> +		 * Apply default & customized values
> +		 * and then start streaming.
> +		 */
> +		ret =3D imx219_start_streaming(imx219);
> +		if (ret)
> +			goto err_rpm_put;

Is it correct/vital that one error path uses put_noidle() and second
uses plain put()?

> +static int __maybe_unused imx219_resume(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
> +	struct imx219 *imx219 =3D to_imx219(sd);
> +	int ret;
> +
> +	if (imx219->streaming) {
> +		ret =3D imx219_start_streaming(imx219);
> +		if (ret)
> +			goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	imx219_stop_streaming(imx219);
> +	imx219->streaming =3D 0;

This error path will leave driver in inconsistent state. hflip/vflip
controls will be locked and pm_runtime_put() is not executed.

> +static int imx219_check_hwcfg(struct device *dev)
> +{
> +	struct v4l2_fwnode_endpoint *ep_cfg;
> +	struct device_node *ep;
> +	int ret =3D -EINVAL;
> +
> +	ep =3D of_graph_get_next_endpoint(dev->of_node, NULL);
> +	if (!ep) {
> +		dev_err(dev, "missing endpoint node\n");
> +		return -EINVAL;
> +	}
> +
> +	ep_cfg =3D v4l2_fwnode_endpoint_alloc_parse(of_fwnode_handle(ep));
> +	if (IS_ERR(ep_cfg)) {
> +		dev_err(dev, "could not parse endpoint\n");
> +		goto error_out;
> +	}
=2E..
> +error_out:
> +	v4l2_fwnode_endpoint_free(ep_cfg);

Is it correct to call endpoint_free on error pointer?

> +MODULE_AUTHOR("Dave Stevenson <dave.stevenson@raspberrypi.com");

Missing ">" at end of address.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBH3FMACgkQMOfwapXb+vII2gCgmQrEQkDJV9xVihyZPRJDB7tO
48oAnA7wkO0EmNgigzEQP5h36E9Ea5gp
=Dqdw
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

--npr8xS0MmdT7V8RtpTpl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6259): https://lists.cip-project.org/g/cip-dev/message=
/6259
Mute This Topic: https://lists.cip-project.org/mt/81205356/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--npr8xS0MmdT7V8RtpTpl--
