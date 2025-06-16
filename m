Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE1EC71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 09:36:03 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.26514.1750066561145754268
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 02:36:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=WTqiyoIg;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACD17103972B5;
	Mon, 16 Jun 2025 11:35:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750066559; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TZ1+NE+R23OJxaPkt9o8mmvBOjAXpwmczip39OJMf3A=;
	b=WTqiyoIgX1KHVpN20X1HNA2SM4V5n7WCX2lAiaXk2diLkUAQloxZXSQTwxIjdjfIDtOzp6
	runulUrW80HTJy+s4QgW+CwOm1zvO3773t8VLha2oLknXofZ3ag3WU0SFBnaiyCjH+9XVn
	MohyR9oWeMtA6W488QV4Gbty5bxACovE053P5oBdV2PjA4j7AtX1iePP+ipqAMGEb6Sldg
	tTVUgrJ1aj/L8N7ABaVsveUb7qJf1lsCcJPh/F2OqQ+h1zo3B5QcS9iGykSKRurUz4CavU
	LFLjcOkvsIpOlIp+jD0alpKp6OVLTLafOmX1WabHlBPpmzNDLlRII+qHLQs3Sw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Jun 2025 11:35:57 +0200
Message-Id: <DANUTHR0IO7T.1O5DQWLF91XHA@denx.de>
Subject: Re: [PATCH v6 0/4] initramfs-crypt-hook patch
Cc: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
 "Heinisch, Alexander" <alexander.heinisch@siemens.com>
From: "Claudius Heine" <ch@denx.de>
To: "Cetin, Gokhan" <gokhan.cetin@siemens.com>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
 <cip-dev@lists.cip-project.org>
X-Mailer: aerc 0.20.0
References: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de> <69ab7fad-b2e4-4fe7-bb16-1d6e0bbb4d5a@siemens.com> <DABWFSN87AVE.H2RGOY175Z6S@denx.de> <a22f282c-efea-4cfd-9870-118e1950b828@siemens.com> <PRAPR10MB542211966641957AF9AD3C788075A@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <PRAPR10MB542211966641957AF9AD3C788075A@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 09:36:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19103

Hi Gokhan,

On Wed Jun 11, 2025 at 10:46 PM CEST, Gokhan Cetin wrote:
> Hi,
>
> One feedback from my side:
> `tpm2_createpolicy` is still used by the `clevis` backend and should be p=
art of the HOOK_COPY_EXECS, that patch 1/4 removes it.
> Probably overlooked because it has no direct use in the encrypt_partition=
 script.

Good catch. Done in v7.

kind regards,
Claudius

>
> Regards,
> Gokhan




--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


