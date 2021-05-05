Return-Path: <SRS0=in89=KA=lists.cip-project.org=bounce+64572+6430+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE96FC433B4
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 16:51:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E0861424
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 16:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E0861424
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6430+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ls6YYY4521723xT55s12ARCv; Wed, 05 May 2021 09:51:07 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.11325.1620233465330362048
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 09:51:05 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 145Gp3dC027270
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 5 May 2021 18:51:03 +0200
X-Received: from [167.87.95.120] ([167.87.95.120])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 145GhiEg008799;
	Wed, 5 May 2021 18:43:44 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 0/2] swupdate-config: variables cleanup
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210505082158.18899-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <570b4004-2127-cc30-3970-274731b325e4@siemens.com>
Date: Wed, 5 May 2021 18:43:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210505082158.18899-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 45MUoGZVYeZigdWvBVUiKZTSx4520388AA=
Content-Type: multipart/mixed; boundary="5zG8dYkS38QihsCDMFmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620233467;
 bh=VtxJASAioadi9wLGoqXnw3A9GCEyV4HriQV+OMW2NPQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=vm85M2pk+ei/s6zcIm8GKJ9dUOkZ+PvjzKxBe+OTKMsMzgC/hIRDDFeCoeLMgebEm9B
 9skUBD1B+Pmke3F7xx5Rcsp1xC6C4yWYvYQHqyjVhw9xZWYDrstVf0csg3khUW6tPXylT
 7qJ+G5xrZDTHoK/agrYmcO7NIYPnNfeaR2o=

--5zG8dYkS38QihsCDMFmj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 05.05.21 10:21, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patch removes the variable U_BOOT from the swupdate-config.bbclass.
> It also adds the suffix `SWUPDATE` to the variable BOOTLOADER.
> 
> If a custom u-boot is used in concunction with swupdate it is
> recommened to set `U_BOOT_CONFIG_PACKAGE` to '1'. This now adds
> a dependency from SWupdate to u-boot-{MACHINE}-config for installing
> fw_env.config.
> 
> Changes in V2:
>  - fix typo in commit message
>  - use variable in kas/opt/*.yml
> 
> Changes in V3:
>  - remove variable U_BOOT
>  - split into 2 commits
> 
> Changes in V4:
>  - Add missing Changes log
>  - Correct commit message
> 
> Quirin Gylstorff (2):
>   swupdate-config: remove variable U_BOOT
>   swupdate-config: add prefix to variable BOOTLOADER
> 
>  classes/swupdate-config.bbclass      | 17 ++++++++++-------
>  kas/opt/ebg-secure-boot-snakeoil.yml |  2 +-
>  kas/opt/ebg-swu.yml                  |  4 ++--
>  kas/opt/qemu-swupdate.yml            |  2 +-
>  4 files changed, 14 insertions(+), 11 deletions(-)
> 

Thanks, applied to next.

We may eventually also want to do a renaming of qemu-swupdate.yml to
qemu-amd64-swupdate.yml - just for the case that there will also be ARM
qemu target to demonstrate/test swupdate.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--5zG8dYkS38QihsCDMFmj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6430): https://lists.cip-project.org/g/cip-dev/message=
/6430
Mute This Topic: https://lists.cip-project.org/mt/82599604/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5zG8dYkS38QihsCDMFmj--
