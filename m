Return-Path: <SRS0=YTyt=7A=lists.cip-project.org=bounce+64572+4625+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127AC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 07:14:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EA0207D4
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 07:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Txd2X6kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EA0207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4625+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5ueRYY4521723xzYqMpQZxyA; Mon, 18 May 2020 00:14:23 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.36968.1589786061250610594
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2020 00:14:22 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 04I7EHYm023828
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2020 09:14:18 +0200
X-Received: from [167.87.94.217] ([167.87.94.217])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 04I7EFGn006819;
	Mon, 18 May 2020 09:14:16 +0200
Subject: Re: [cip-dev][isar-cip-core] Integration of test and security dependencies with cip-core
To: daniel.sangorrin@toshiba.co.jp, dinesh.kumar@toshiba-tsip.com,
        Chris.Paterson2@renesas.com,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: cip-dev@lists.cip-project.org, cip-security@lists.cip-project.org
References: <OSBPR01MB2053900CD653D4E5CD4278EAD0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <52a7bbd6-1d6a-53e9-6e17-f6516f374060@siemens.com>
Date: Mon, 18 May 2020 09:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2053900CD653D4E5CD4278EAD0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gbzmJ2PFQL7l7oaRpAiTZF2px4520388AA=
Content-Type: multipart/mixed; boundary="HUgJr49i1ifhPJf6PID1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589786063;
 bh=+bATG0M98ep48R1sYV/9zka2UaNhws407xLSeqC1Ka0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Txd2X6kno3xhCp864xxrTGH0r8Wg4sb4KRzNlPLvNiICgVRXbBN+mKR1xDXr9013jmC
 ZEXLGogGNOEGHJ6EFaudAHsFtQOWFQ/Zt1Ta3hW8zFzktGeGDW/si5XR6uIXKSuxNBWhc
 28+XGVNsJy8Di9Zsum/PxrD7j9xwB6gFpRA=

--HUgJr49i1ifhPJf6PID1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi all,

On 18.05.20 08:37, daniel.sangorrin@toshiba.co.jp wrote:
> Hello Dinesh, Chris, Jan:
> 
> # BACKGROUND
> 
> As I mentioned in our last technical steering commite meeting, our gitlab-ci scripts should be able to produce multiple OS images. For example, the testing team needs to have python and possibly other software including the tests themshelves; and the security team needs to have extra packages and probably lots of customizations.
> 
> # CURRENT STATUS
> 
> At the moment we have what I would call "target images", which contain:
> 
> * something close to what I would call the "CIP Core Generic profile":
>      * the ISAR core packages
>          * I think these are basically debootstrap minbase (isar/meta/recipes-core/isar-bootstrap)
>      * some extra customizations
>          * https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/master/recipes-core/
> * target-dependent packages (kernel, u-boot, firmware, etc)
>      * these are added using KAS opt.yaml syntax, instead of using a meta-layer
> * options
>      * opt-rt: will use a kernel with PREEMPT-RT patch
>      * opt-stretch: will use stretch as distro
>      * opt-4.4: will use kernel v4.4 instead of the default 4.10
>      * opt-targz-img: exports the image as a tarball for LAVA
> 
> On the branch, iec-evaluation there is an initial implementation of the security image:
>      * https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/security/iec-evaluation
>      * at first they added an opt-security.yaml file:
>          * https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/a8216d4ca5eed4d73dff2e00601dea7c9d733f45
>      * then they changed to use recipes-core/images/cip-core-image-security.bb that extends IMAGE_PREINSTALL
>          * https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/3461a50297e370210d76d85d434fb625c8c4248c
>      * see the original thread here:
>          * https://lore.kernel.org/cip-dev/TYXPR01MB180817C883F874B321DBA264E1FD0@TYXPR01MB1808.jpnprd01.prod.outlook.com/T/#m752a116d8372222d727722f4fe18ca19d94838eb
> 
> # MY PROPOSAL
> 
> My proposal as the next task for the CIP Core work group is to add metadata for releasing these images:
> 
> * target images: isar debootstrap + customizations + kernel/u-boot/fw
>      * [NEW] release them as bmap images for our reference hardware boards
>      * [NEW] create a page (gitlab wiki) that will contain links to the latest images and how-to-install readmes for each reference board
>      * [NEW] refer to that page from the CIP wiki page (https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cipreferencehardware)
> * [NEW] testing images: target images + test dependencies
>      * release them using opt-targz-img so they can be used in LAVA
>      * add the test dependencies
>          * packages: python2.7, python3, ...
>          * tests: LTP, ...
>              * method 1: build them on a separate repo and include in the image
>              * method 2: build them with ISAR (new recipes) and include in the image
>              * method 3: the artifacts are downloaded by LAVA <-- My preference

1 or 2. We can start with 2 and factor out 1 when it becomes too large.

You do not want to create the tested image only in lava "on the fly", 
you want that locally as well.

>          * How to implement this
>              * method 1: using the opt yaml format <-- My preference if we only need to specify packages
>              * method 2: creating a separate meta layer
>              * method 3: using a new image (cip-core-image-testing.bb)

Define a test image, that is cleanest. It shall be derived from the base 
image and contain all packages needed for testing. We do this internally 
as well. That image is selected by a kas option: opt-targz-img could 
become opt-lava-img or so.

> * [NEW] security: target + security packages + security tests and dependencies
>      * release in two formats
>          * using opt-targz-img so they can be used in LAVA

opt-lava-img -> select test image (with extra packages), switch output 
format.

>          * as images for our reference hardware boards
>              * add to the gitlab wiki links to the latest images and how-to-install readmes too
>      * How to implement this
>          * method 1: using the opt yaml format
>          * method 2: creating a separate meta layer <-- My preference if it gets complex

Something for later. At this stage, it will only increase the CM effort.

>          * method 3: using a new image (cip-core-image-security.bb) <-- Current method
> 

A new image recipe together with a new top-level kas file to select the 
image - and likely more. I can imagine that a secure core image will 
eventually not only affect the image recipe but also configuration 
options of the build, filesystem, secure boot etc. So, something like

  - kas-cip-core.yml
  - kas-cip-secure.yml

could make sense as entry points.

> # FEEDBACK
> 
> Please check my initial proposal and send me feedback.
> 
> Thanks,
> Daniel Sangorrin
> 

All that said: Nothing needs to be set in stone upfront. We can adjust 
the modeling as the usage evolves and the variants threaten to increase. 
But specifically due to the last aspect, the matrix should remain as 
small as possible.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--HUgJr49i1ifhPJf6PID1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4625): https://lists.cip-project.org/g/cip-dev/message=
/4625
Mute This Topic: https://lists.cip-project.org/mt/74286250/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--HUgJr49i1ifhPJf6PID1--
