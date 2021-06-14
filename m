Return-Path: <SRS0=142T=LI=lists.cip-project.org=bounce+64572+6513+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BF4C4743C
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 11:18:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BE4610A0
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 11:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BE4610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6513+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id u8yNYY4521723xfOCUmn3Nkx; Mon, 14 Jun 2021 04:18:48 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.28502.1623669522793702667
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jun 2021 04:18:48 -0700
X-Received: from mail2.siemens.de (mail2.siemens.de [139.25.208.11])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 15EBIebc024844
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 14 Jun 2021 13:18:40 +0200
X-Received: from localhost ([139.22.37.189])
	by mail2.siemens.de (8.15.2/8.15.2) with ESMTPS id 15EBIcoK024210
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <cip-dev@lists.cip-project.org>; Mon, 14 Jun 2021 13:18:39 +0200
Date: Mon, 14 Jun 2021 13:19:26 +0200
From: "Christian Storm" <christian.storm@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev][isar-cip-dev][PATCH 2/2] swupdate: Add option to use swupdate-handler-roundrobin
Message-ID: <20210614111926.qqfyezqnp6pbslk4@MD1ZFJVC.ad001.siemens.net>
Mail-Followup-To: cip-dev@lists.cip-project.org
MIME-Version: 1.0
In-Reply-To: <20210611142112.2453-3-Quirin.Gylstorff@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by thoth.sbs.de id 15EBIebc024844
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: q49YggIIfI1HGJA3GJ8gHjdEx4520388AA=
Content-Type: multipart/mixed; boundary="5vOUFZnthGLrRgKMla23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623669528;
 bh=Yr94LQCYaBBa3PbjjX1u1b9opmhBitirXO2NXd8gT4U=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qQee8tvtrnhPRbByQEK3OjH+gjViuVhGjM8IqhJYoAb1xOOgTe7tjSElrnzu94UtmAy
 N8c6x9rOBShXE70h5sW/7Vlc6hYkIhX+J1Fp5S9/fAz9m2VoPh9DJ3VANqxMqBFuKHGCN
 fGq/I7YdE/ViUnBjt4j1ON4bGf2YpTHbg9o=

--5vOUFZnthGLrRgKMla23
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Quirin,

> --- a/recipes-core/images/files/secure-boot/sw-description.tmpl
> +++ b/recipes-core/images/files/secure-boot/sw-description.tmpl
> @@ -14,16 +14,22 @@ software =3D
>      name =3D "secure boot update"
>      images: ({
>              filename =3D "${ROOTFS_PARTITION_NAME}";
> -            device =3D "fedcba98-7654-3210-cafe-5e0710000001,fedcba98-=
7654-3210-cafe-5e0710000002";
> +            device =3D "sda4,sda5";

Did you intentionally go from UIDs to PATHs?
Why not uniformly using UIDs?


> --- /dev/null
> +++ b/recipes-core/swupdate/files/secureboot/swupdate.handler.efibootgu=
ard.ini
> @@ -0,0 +1,20 @@
> +[image]
> +chainhandler=3Draw
> +
> +[image.selector]
> +method=3Dgetroot_rr
> +key=3Droot
> +
> +[image.bootenv]
> +ustate=3D1

Are you sure you really need setting ustate these days?



Kind regards,
   Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M=FCnchen, Germany

--5vOUFZnthGLrRgKMla23
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6513): https://lists.cip-project.org/g/cip-dev/message=
/6513
Mute This Topic: https://lists.cip-project.org/mt/83469366/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5vOUFZnthGLrRgKMla23--
