Return-Path: <SRS0=O97l=GQ=lists.cip-project.org=bounce+64572+6069+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D60C433E9
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:51:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E146233EA
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E146233EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6069+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3GSIYY4521723xElNoxq3sMN; Wed, 13 Jan 2021 04:51:50 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.7311.1610541209965635322
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 04:33:30 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 10DCXRb9024660
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Jan 2021 13:33:27 +0100
X-Received: from md1za8fc.ad001.siemens.net ([167.87.63.52])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10DCXQCL008678;
	Wed, 13 Jan 2021 13:33:26 +0100
Date: Wed, 13 Jan 2021 13:33:25 +0100
From: Henning Schild <henning.schild@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Claudius Heine <ch@denx.de>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] swupdate-img.bbclass: add checksum in non signed case as well
Message-ID: <20210113133325.148b6f70@md1za8fc.ad001.siemens.net>
In-Reply-To: <29f3df18-a458-98cf-f2f9-d8493035dadb@siemens.com>
References: <20210111154856.6636-1-henning.schild@siemens.com>
	<59f30d0b-d20a-8087-4b28-5c0fd1f7853c@siemens.com>
	<5e854316-1b0c-face-c11f-380b556da8d2@denx.de>
	<e63169ec-9054-8a8f-730e-8de2addbb259@siemens.com>
	<2d5779df-0f43-4041-5ce2-c5a736364182@denx.de>
	<29f3df18-a458-98cf-f2f9-d8493035dadb@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xN5PsVHd2kof9eFXaQMZDlZJx4520388AA=
Content-Type: multipart/mixed; boundary="nEIBLkdGQrash1EvXenm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610542310;
 bh=TjvxCIR9R2n7fFfWF3zZBqh88AaKQ1BW/RGRI83o43c=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lkv7J1m8U6n9nZ6WABvBc9qhFx+7hpP/F0PYGbqUFDDMafi7KTISbVH8moR2H54y3bf
 B73ddFdOmLedWlVAMIzgfft31zetJdGsIWf0Rp/UtCwSrbiotjts/4qamFIeWIO9LszGm
 RbGcGGFN71AvSH5y2mmpqwMzSxR/3rMyNS4=

--nEIBLkdGQrash1EvXenm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Wed, 13 Jan 2021 12:33:12 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 13.01.21 12:02, Claudius Heine wrote:
> > On 2021-01-13 11:55, Jan Kiszka wrote:  
> >> On 13.01.21 11:52, Claudius Heine wrote:  
> >>> Hi Jan,
> >>>
> >>> On 2021-01-13 11:46, Jan Kiszka wrote:  
> >>>> On 11.01.21 16:48, Henning Schild wrote:  
> >>>>> From: Claudius Heine <ch@denx.de>
> >>>>>  
> >>>>
> >>>> Can you also provide a reasoning here?  
> >>>
> >>> I can, but I guess you mean that a commit message should be added
> >>> here. 
> >>
> >> ...or that you provide me a text I can fill in on merge.  
> > 
> > Ok here is my take:
> > 
> > ```
> > Also unsigned images should contain a checksum in the
> > swdescription, for instance in case `DISABLE_CPIO_CRC=y` is set in
> > swupdate and a USB stick is used for update delivery, only such a
> > checksum would protect against file corruption.
> > ```
> >   
> 
> Thanks, applied with this text.

Sweet, thanks!

@claudius this might be ready to pull into our layer anytime soon,
should be patch-free now

Henning

> Jan
> 


--nEIBLkdGQrash1EvXenm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6069): https://lists.cip-project.org/g/cip-dev/message=
/6069
Mute This Topic: https://lists.cip-project.org/mt/79598691/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nEIBLkdGQrash1EvXenm--
