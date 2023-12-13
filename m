Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B869BC4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 13:54:32 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.25245.1702438072932665708
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Dec 2023 19:27:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=OnxXL+kB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1321639-20231213032748c571e57b756fcee48f-pmz7gn@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20231213032748c571e57b756fcee48f
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Dec 2023 04:27:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5fIjh0ghlfgXMf8j1Wnwz6X8McOQbUtpm6ULLSfmfiQ=;
 b=OnxXL+kBuMKOahQolp0SDhhpfE7YKq5mxTjioxnRVPxduJo53ekWZqbcQeMPJeI2Cco7C8
 fU0YBZCRNwab86+VrJtg5oCTpAUz2/0cW5aUtFzwJMM/U+gdM/DGVdUapjJP/cBUSdYHLjF9
 J7FOC3YrBGnpE4azPJZxoi5+gU6qA=;
Message-ID: <9b8314f6059fca9fb270921b8ce53e2149ec40f6.camel@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-certificates*.inc: Add missing FILESEXTRAPATHS
From: Moessbauer Felix <felix.moessbauer@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, 
	cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Date: Wed, 13 Dec 2023 11:27:45 +0800
In-Reply-To: <20231212141556.1616031-1-Quirin.Gylstorff@siemens.com>
References: <20231212141556.1616031-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 13:54:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14069

On Tue, 2023-12-12 at 15:12 +0100, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> This allows to include the files in downstream layers.
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> =C2=A0.../swupdate-certificates/swupdate-certificates-key.inc=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> ++
> =C2=A0.../swupdate-certificates/swupdate-certificates.inc=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> ++
> =C2=A02 files changed, 4 insertions(+)
>=20
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-
> certificates-key.inc b/recipes-devtools/swupdate-
> certificates/swupdate-certificates-key.inc
> index d3d2e16..2c67e89 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-
> key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-
> key.inc
> @@ -11,6 +11,8 @@
> =C2=A0
> =C2=A0inherit dpkg-raw
> =C2=A0
> +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files:"
> +
> =C2=A0PROVIDES +=3D "swupdate-certificates-key"
> =C2=A0
> =C2=A0SWU_SIGN_KEY ??=3D ""
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-
> certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-
> certificates.inc
> index 6673383..564dda4 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-
> certificates.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-
> certificates.inc
> @@ -11,6 +11,8 @@
> =C2=A0
> =C2=A0inherit dpkg-raw
> =C2=A0
> +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files:"

Hi, did you check if this is compatible with sstate caching? We must
avoid adding absolute paths to the signatures, as otherwise this breaks
caching on the gitlab-cloud-ci runners.

You can check that with the isar-sstate lint script.

Best regards,
Felix

> +
> =C2=A0PROVIDES +=3D "swupdate-certificates"
> =C2=A0
> =C2=A0SWU_SIGN_CERT ??=3D ""


