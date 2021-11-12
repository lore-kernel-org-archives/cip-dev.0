Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F4C433F5
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 11:58:38 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web08.14714.1636718314259257552
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 03:58:34 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1ACBwWNR017121
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:58:32 +0100
Received: from [167.87.35.150] ([167.87.35.150])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACBwVCw002383;
	Fri, 12 Nov 2021 12:58:32 +0100
Subject: Re: [cip-dev] [PATCH] recipes-core/swupdate: Update the SRC_URI and
 SWUPDATE_BUILD_PROFILES append for buster
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
References: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
 <20211112115017.401779-3-Quirin.Gylstorff@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <f2229bac-71c2-16c4-985d-6962d7f0af65@siemens.com>
Date: Fri, 12 Nov 2021 12:58:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211112115017.401779-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 11:58:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6890

This should not be have sent.

Drop.

On 11/12/21 12:50 PM, Quirin Gylstorff via lists.cip-project.org wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> When we build the swupdate debian package for buster some build
> dependency packages are not available in stable buster repo, hence we created a
> patch in cip-core upstream for buster build, here we hardcoded the distro
> for buster build hence it is building fine in cip-core not the downstream layer,
> added the OVERRIDES for BASE_DISTRO_CODENAME to select the particular base distro.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   recipes-core/swupdate/swupdate.inc                     | 2 ++
>   recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 8 ++++----
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index a469587..191aa2b 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -13,6 +13,8 @@ HOMEPAGE= "https://github.com/sbabic/swupdate"
>   LICENSE = "GPL-2.0"
>   LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
>   
> +OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
> +
>   def get_bootloader_build_profile(d):
>       bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
>       if bootloader == "efibootguard":
> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> index a451b55..e62230f 100644
> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> @@ -35,14 +35,14 @@ SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
>   # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>   
>   # modify for debian buster build
> -SRC_URI_append_cip-core-buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
> +SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
>   
>   # disable documentation due to missing packages in debian buster
>   # disable create filesystem due to missing symbols in debian buster
>   # disable webserver due to missing symbols in debian buster
> -SWUPDATE_BUILD_PROFILES_append_cip-core-buster = " nodoc \
> -                                                   pkg.swupdate.nocreatefs \
> -                                                   pkg.swupdate.nowebserver "
> +SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
> +                                          pkg.swupdate.nocreatefs \
> +                                          pkg.swupdate.nowebserver "
>   # In debian buster the git-compression defaults to gz and does not detect other
>   # compression formats.
>   GBP_EXTRA_OPTIONS += "--git-compression=xz"
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6880): https://lists.cip-project.org/g/cip-dev/message/6880
> Mute This Topic: https://lists.cip-project.org/mt/87004225/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

-- 




With best regards,
Quirin Gylstorff

Siemens AG
Technology
Research in Digitalization and Automation
Smart Embedded Systems
T RDA IOT SES-DE
Otto-Hahn-Ring 6
81739 Muenchen, Germany
Mobile: +49 173 3746683
mailto:quirin.gylstorff@siemens.com <mailto:quirin.gylstorff@siemens.com>
www.siemens.com <https://siemens.com>

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P.
Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany;
Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB
6684; WEEE-Reg.-No. DE 23691322

Important notice: This e-mail and any attachment thereof contain
corporate proprietary information. If you have received it by mistake,
please notify us immediately by reply e-mail and delete this e-mail and
its attachments from your system. Thank you.




