Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B207CC61DA4
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 15:11:26 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.16897.1675350683164690084
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 07:11:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=florian.bezdeka@siemens.com header.s=fm1 header.b=P15uxD+j;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-68982-20230202151120883795f06b02c8809a-sre9k_@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230202151120883795f06b02c8809a
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Feb 2023 16:11:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MM0RD606jOOnVCLfb5yycBl/V2z7fRTNkXhHut8Nb3s=;
 b=P15uxD+jc95ssWhuMYb0qyH++w2hWTJUf0AF/2Zx3wCO52B3gf19PfU0uoeJxvNkKM9kdI
 0OOcR0JkoYQMIXsc9z/5U8XjE/zmKUAGtmwfDHz6w8wtsx2BBCLNcJ2e6WXz55TpFLNHrlTx
 cwcdHVQKT/39fi5E6pECGsp/kHGf4=;
Message-ID: <0b9cea9cb50626a59ea5818fc3e7ed582c2265ba.camel@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Enable Images based on
 Debian 12 (bookworm)
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, 
	cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com, 
	jan.kiszka@siemens.com
Date: Thu, 02 Feb 2023 16:11:19 +0100
In-Reply-To: <20230202150811.824615-1-Quirin.Gylstorff@siemens.com>
References: <20230202150811.824615-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 15:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10570

On Thu, 2023-02-02 at 16:08 +0100, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> This will add prelimitary support for the debian 12 aka bookworm.

Following the Isar mailing list I will expect some trouble now. The apt
keys fpr bookworm part of Isar expired... Fixes are available but would
force isar-cip-core to migrate to bitbake 2.0.

Let's wait for some build and test results and see.

Best regards,
Florian

>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - Adjusted blank lines
>  - Change Submit subject from "Add bookworm" to "Enable Images based on D=
ebian 12 (bookworm)"
>  - Replaced "+=3D" with "=3D" if append was used
>  - drop pinned kernel for qemu-amd64 secureboot
>  - drop Hihope build as firmware-ti-connectivity is not available for boo=
kworm
>=20


