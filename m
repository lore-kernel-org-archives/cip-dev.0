Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03409F433C6
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 21:11:10 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5782.1776287459578828443
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 14:11:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=AxBbrnBm;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D37B5113EDA;
	Wed, 15 Apr 2026 23:10:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776287453;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kgNafYhcB1VskY+JmuiJF7faFJF1Q8c7G56z/4YhGLY=;
	b=AxBbrnBmI6c4a4FU4RgPI7HFjmqF2ceZOhi50d/yba4Oj9Aqgq/yPCpCU5iLyIt0c6IoaR
	9+lIffuqaFcu5chq4nJWs16yY/yJe4hWvHYLsobKJwQGoVEcxpW/f25n7kEjZfxm4UwO2u
	xaoLRJ8UVdIADHT2CYJMFRtwYCpYYXPr/WlZj6/RYgoPu8JxO84G2PvABBN8JfL3VyoVGa
	r1dUKDKHZmo/qYODmF4lbEhlHW4Zkx/qGIgThPIMgvNlRZ2ZmlnsgrypjQ5Jl8PB8/Ai5e
	PiJ7+MLZParbnQaz31AflD/2RqEUgeKUQYYeGIwOUCeyBgqjx0JrBqRu7JFGFg==
Date: Wed, 15 Apr 2026 23:10:51 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 09/11] arm64: dts: renesas: r9a09g077: Add TSU
 and thermal zones support
Message-ID: <ad_-20dt189BuoPg@duo.ucw.cz>
References: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260410170215.393698-10-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUw2zTv/EhYzo2Dc"
Content-Disposition: inline
In-Reply-To: <20260410170215.393698-10-cosmin-gabriel.tanislav.xa@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 21:11:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22732


--FUw2zTv/EhYzo2Dc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> The Renesas RZ/T2H (R9A09G077) SoC includes a Temperature Sensor Unit
> (TSU). The device provides real-time temperature measurements for
> thermal management, utilizing a single dedicated channel for temperature
> sensing.

Just... You have passive trip point at 95C and critical at 120C. IIRC
critical simply triggers system shutdown, and that can take time, so
temperature may rise above 120C in this configuration.

Is system tested for stable operation at 119C for extended periods?
Because that's what this configuration means AFAICT. It seems little
high to me.

> +			trips {
> +				target: trip-point {
> +					temperature = <95000>;
> +					hysteresis = <1000>;
> +					type = "passive";
> +				};
> +
> +				sensor_crit: sensor-crit {
> +					temperature = <120000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,

Best regards,
								Pavel

--FUw2zTv/EhYzo2Dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCad/+2wAKCRAw5/Bqldv6
8pZ6AJ4/1rQQAPa+nVQynsFxvpXxB5FXpgCeLdMTMI5o98F/dWqOeQEbSHLDge8=
=jUiL
-----END PGP SIGNATURE-----

--FUw2zTv/EhYzo2Dc--

