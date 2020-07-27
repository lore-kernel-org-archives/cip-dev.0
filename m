Return-Path: <SRS0=+5n6=BG=lists.cip-project.org=bounce+64572+5030+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E594C433F4
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 14:34:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8885207FC
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 14:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CLdDvqUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8885207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5030+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qu56YY4521723xOW7KcU7YMN; Mon, 27 Jul 2020 07:34:28 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.56811.1595860467018693580
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2020 07:34:27 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 06REYNqd027188
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2020 16:34:24 +0200
X-Received: from [167.87.246.21] ([167.87.246.21])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06REYMik015108;
	Mon, 27 Jul 2020 16:34:23 +0200
Subject: Re: [cip-dev] [isar-cip-core 1/3] cip-security: Add packages for IEC-62443-4-2 evaluation
To: venkata.pyla@toshiba-tsip.com
Cc: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>,
        cip-dev@lists.cip-project.org
References: <20200727114135.368-1-venkata.pyla@toshiba-tsip.com>
 <20200727114135.368-2-venkata.pyla@toshiba-tsip.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <79d0ae51-9d84-ce85-d6fc-95bb22bdc2cb@siemens.com>
Date: Mon, 27 Jul 2020 16:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727114135.368-2-venkata.pyla@toshiba-tsip.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SAYlDzBKI7GVsSbLvwz67EQtx4520388AA=
Content-Type: multipart/mixed; boundary="MKf8OYvLGlk7HI0G0Zlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595860468;
 bh=ZrUd03u2JWnku4tbWGeIyQlnhcEXbUAcPvg67w0hbHM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=CLdDvqUUKPw0BeTk8OKK7l2NZjESbz0Qt0uEDUdQBvrcDaUL2FtXRY/zSKXjE33HbQU
 ALvHcuuHgPG5ks/F37PM2aSM0hqDvv8phtwPn+EKzwVD9SjrnCSAGwYaL6aljXKxPvAb6
 e7dAgkYYc3qAtgFB0bT8KZfGrpjw/DpmaEA=

--MKf8OYvLGlk7HI0G0Zlu
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 27.07.20 13:41, venkata.pyla@toshiba-tsip.com wrote:
> From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> 
> Identified security packages are added to the target image
> and that will be used for IEC-62443-4-2 evaluation
> 
> Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> Signed-off-by: Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> ---
>   .../images/cip-core-image-security.bb         | 36 +++++++++++++++++++
>   1 file changed, 36 insertions(+)
>   create mode 100644 recipes-core/images/cip-core-image-security.bb
> 
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> new file mode 100644
> index 0000000..a17c522
> --- /dev/null
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -0,0 +1,36 @@
> +#
> +# A reference image which includes security packages
> +#
> +# Copyright (c) Toshiba Corporation, 2020
> +#
> +# Authors:
> +#  Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit image
> +
> +DESCRIPTION = "CIP Core image including security packages"
> +
> +IMAGE_INSTALL += "customizations"
> +
> +# Debian packages that provide security features
> +IMAGE_PREINSTALL += " \
> +	openssl libssl1.1 \
> +	fail2ban \
> +	openssh-server openssh-sftp-server openssh-client \
> +	syslog-ng-core syslog-ng-mod-journal \
> +	aide aide-common \
> +	libnftables0 nftables \
> +	libpam-pkcs11 \
> +	chrony \
> +	tpm2-tools \
> +	tpm2-abrmd \
> +	libtss2-esys0 libtss2-udev \
> +	libpam-cracklib \
> +	acl \
> +	libauparse0 audispd-plugins auditd \
> +	uuid-runtime \
> +	sudo \
> +"
> 

Still no CI for this. You can send that separately on top, the series 
looks fine otherwise.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--MKf8OYvLGlk7HI0G0Zlu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5030): https://lists.cip-project.org/g/cip-dev/message=
/5030
Mute This Topic: https://lists.cip-project.org/mt/75820361/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--MKf8OYvLGlk7HI0G0Zlu--
