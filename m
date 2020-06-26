Return-Path: <SRS0=8Vpg=AH=lists.cip-project.org=bounce+64572+4839+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D65C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 10:41:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCC72070A
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 10:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bz5UZQou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCC72070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4839+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YrxnYY4521723xrpTpoQk4T8; Fri, 26 Jun 2020 03:41:27 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.4975.1593168085714241477
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2020 03:41:26 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 05QAfM50018974
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2020 12:41:22 +0200
X-Received: from [167.87.241.222] ([167.87.241.222])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05QAfMas006634;
	Fri, 26 Jun 2020 12:41:22 +0200
Subject: Re: [cip-dev][isar-cip-core PATCH 1/6] opt-security.yml: Sample settings to install security
To: cip-dev@lists.cip-project.org, venkata <venkata.pyla@toshiba-tsip.com>
Cc: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
References: <3ec242c02a3948fe9194df2517cbe0ad@toshiba-tsip.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <c6c696ce-2ed6-4ce8-9c02-687ffbfc206b@siemens.com>
Date: Fri, 26 Jun 2020 12:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3ec242c02a3948fe9194df2517cbe0ad@toshiba-tsip.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nbpPmVYdpmkX009rg7kiRV53x4520388AA=
Content-Type: multipart/mixed; boundary="6SSDqf9k3Ta0n7khsFUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593168087;
 bh=x+gue92VDXfkELGuhmJwAYqcPqIJLhrpD8JSi4yJJYw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bz5UZQouiZumUs4vhW16l59FrXupaVO2L0ngSkX0lJSJ1fIgZv6d9YBHQ+hGxNaCOQ6
 oRFPscjKYOoWDn5U7TNTPwZJ3qJI7Vu9yO0xEsJtiQGet+c8Nc1yqfmCSlQQOwe1g+7LI
 StSPxfMlBh0UqQP/Wi4danI8KMed4qM9ugc=

--6SSDqf9k3Ta0n7khsFUQ
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 26.06.20 08:44, venkata wrote:
> From: Kazuhiro Hayashi kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>
> 

This line seems to have been mangled. It should be in line with the 
Signed-off-by.

> opt-security.yml: Sample settings to install security
> packages
> 
> Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> ---
> SECURITY.md      | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
> opt-security.yml | 34 +++++++++++++++++++++++++++++++
> 2 files changed, 86 insertions(+)
> create mode 100644 SECURITY.md
> create mode 100644 opt-security.yml
> 
> diff --git a/SECURITY.md b/SECURITY.md
> new file mode 100644
> index 0000000..a8bccc7
> --- /dev/null
> +++ b/SECURITY.md
> @@ -0,0 +1,52 @@
> +How to customize images for security features
> +=============================================
> +
> +This is the "temporal" document about how to create and use
> +the CIP Core generic profile images for security feature evaluation.
> +
> +Official manuals
> +----------------
> +
> +* isar-cip-core: https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/README.md
> +* ISAR User Manual: https://github.com/ilbers/isar/blob/master/doc/user_manual.md
> +
> +Assumed environment
> +-------------------
> +
> +* isar-cip-core: master branch
> +* Host: Debian 10 buster amd64
> +    * Installed packages: `docker-ce`, `qemu-system`
> +    * Users who does the following actions must be in the groups `docker` and `kvm`
> +
> +Create kas file
> +---------------
> +
> +Create a kas file named `opt-security.yml` to add security settings.

That file is added by this patch already.

> +
> +Add security packages to rootfs
> +-------------------------------
> +
> +Set `IMAGE_PREINSTALL` to the list of packages required to enable
> +the security features. This variable can be set through the kas file.
> +
> +Example:
> +
> +```
> +local_conf_header:
> +  security: |
> +    IMAGE_PREINSTALL = "openssl"
> +```
> +
> +Build images
> +------------
> +
> +Build images for QEMU x86 64bit machine:
> +
> +    $ ./kas-docker --isar build kas.yml:board-qemu-amd64.yml:opt-security.yml
> +
> +Run on QEMU
> +-----------
> +
> +Run the generated images on QEMU (x86 64bit).
> +
> +    $ ./start-qemu.sh amd64
> diff --git a/opt-security.yml b/opt-security.yml
> new file mode 100644
> index 0000000..7c6b39c
> --- /dev/null
> +++ b/opt-security.yml
> @@ -0,0 +1,34 @@
> +#
> +# KAS configuration for CIP Core generic profile to enable security features
> +#
> +# Copyright (c) Toshiba Corporation, 2020
> +#
> +# Authors:
> +#  Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 8
> +
> +local_conf_header:
> +  security: |
> +    # TODO: Add sudo or sudo-ldap
> +    IMAGE_PREINSTALL = "\
> +      openssl libssl1.1 \
> +      fail2ban \
> +      openssh-server openssh-sftp-server openssh-client \
> +      syslog-ng-core syslog-ng-mod-journal \
> +      aide aide-common \
> +      libnftables0 nftables \
> +      libpam-pkcs11 \
> +      chrony \
> +      tpm2-tools \
> +      tpm2-abrmd \
> +      libtss2-esys0 libtss2-udev \
> +      libpam-cracklib \
> +      acl \
> +      libauparse0 audispd-plugins auditd \
> +      uuid-runtime \
> +    "

Shouldn't we target for a security image (recipe) instead?

General question: What is this series targeting? Seems patch 2 and 3 are 
left-overs from the development. Is this an RFC series only?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--6SSDqf9k3Ta0n7khsFUQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4839): https://lists.cip-project.org/g/cip-dev/message=
/4839
Mute This Topic: https://lists.cip-project.org/mt/75119562/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--6SSDqf9k3Ta0n7khsFUQ--
