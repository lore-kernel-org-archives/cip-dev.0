Return-Path: <SRS0=BttO=H2=lists.cip-project.org=bounce+64572+6192+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B824C433DB
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 15:04:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FB164DDC
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 15:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FB164DDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6192+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cINTYY4521723xkMN2OyFljl; Wed, 24 Feb 2021 07:04:37 -0800
X-Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web12.8186.1614179076928741932
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Feb 2021 07:04:37 -0800
X-Received: by mail-lf1-f52.google.com with SMTP id v30so3508745lfq.6
        for <cip-dev@lists.cip-project.org>; Wed, 24 Feb 2021 07:04:36 -0800 (PST)
X-Gm-Message-State: BFqhlvMZPx98Z9PkfzszkCoSx4520388AA=
X-Google-Smtp-Source: ABdhPJzgYz/inCkOuwnuvddD3ZO0FCB4v2m6gUDHJ25ltWrGxvo97pF8HwHpG86pC1BAXJApF5quJQ==
X-Received: by 2002:a19:5507:: with SMTP id n7mr18950211lfe.228.1614179074295;
        Wed, 24 Feb 2021 07:04:34 -0800 (PST)
X-Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a4sm505333ljb.24.2021.02.24.07.04.33
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 07:04:34 -0800 (PST)
X-Received: by mail-lf1-f49.google.com with SMTP id v5so3451852lft.13
        for <cip-dev@lists.cip-project.org>; Wed, 24 Feb 2021 07:04:33 -0800 (PST)
X-Received: by 2002:a05:6512:11cd:: with SMTP id h13mr3936558lfr.233.1614179073593;
 Wed, 24 Feb 2021 07:04:33 -0800 (PST)
MIME-Version: 1.0
References: <CAGb2v64SEFQBXfGhC_WDP-2SyJbtAdzmsdZjbiygUhP9pE4a0g@mail.gmail.com>
 <20210211113902.GA30740@amd>
In-Reply-To: <20210211113902.GA30740@amd>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 24 Feb 2021 23:04:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v65vuSqpSbBYab6K3jX5Lb6Lu5ywZtCLJoWepDyNNw0f9w@mail.gmail.com>
Message-ID: <CAGb2v65vuSqpSbBYab6K3jX5Lb6Lu5ywZtCLJoWepDyNNw0f9w@mail.gmail.com>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-11
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="Dz8HEbL4TFOLZBAHByxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614179077;
 bh=It61QAH1Ul+995HJmXhKQw9bqA6YTPBrLVazniP/ppY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=o4WqVYfZf2vCtwm9eiJqyTOdF9ANfrD5TBSzgNTGl5PQITvTAvwfoAH3uOE8P+oYamU
 XhBy/qJYPNcm0TOMvgCAaCljgiEFzdwg2hxLV4G9SH0MuJse9HAbBVmkjw4PWPO52/ETQ
 xzKWP1vPlHQ9/nkm18TnW5Ie1jFoCJT5rts=

--Dz8HEbL4TFOLZBAHByxP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 11, 2021 at 7:39 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > Six new issues this week:
> > - CVE-2020-12362, CVE-2020-12363, CVE-2020-12364:
> >   CVEs from Intel Advisory affecting Intel Graphics Driver. Details
> > unknown
>
> It seems there's more for the intel graphics, but it is not mentioned
> in our repository. OTOH trailer there that these are rather old
> issues, fixed in 5.5...

Looks like CVE-2020-0544 and CVE-2020-0521 are for Windows. Debian lists
them as such [1][2]. Seems the Intel advisory directly refers to Linux
drivers by kernel version. Any other version string likely refers to
the Windows drivers.


ChenYu

[1] https://security-tracker.debian.org/tracker/CVE-2020-0521
[2] https://security-tracker.debian.org/tracker/CVE-2020-0544

> Best regards,
>                                                                 Pavel
>
> https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa=
-00438.html
>
> CVEID: CVE-2020-0544
>
> Description: Insufficient control flow management in the kernel mode
> driver for some Intel(R) Graphics Drivers before version 15.36.39.5145
> may allow an authenticated user to potentially enable escalation of
> privilege via local access.
>
> CVSS Base Score: 8.8 High
>
> CVSS Vector: CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:H/I:H/A:H
>
>
>
> CVEID: CVE-2020-0521
>
> Description: Insufficient control flow management in some Intel(R)
> Graphics Drivers before version 15.45.32.5145 may allow an
> authenticated user to potentially enable escalation of privilege via
> local access.
>
> CVSS Base Score: 7.7 High
>
> CVSS Vector: CVSS:3.1/AV:L/AC:H/PR:L/UI:N/S:C/C:H/I:H/A:L
>
> ...
>
> Affected Products:
> Intel=C2=AE Graphics Drivers for 3rd, 4th, 5th, 6th, 7th, 8th, 9th and 10=
th
> Generation Intel=C2=AE Processors for Windows* 7, 8.1 and 10 before
> versions 15.33.51.5146, 15.36.39.5145, 15.40.46.5144, 15.45.32.5164,
> 26.20.100.8141, 27.20.100.8587 and Intel=C2=AE Graphics Drivers for Linux
> before Linux kernel version 5.5.
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Dz8HEbL4TFOLZBAHByxP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6192): https://lists.cip-project.org/g/cip-dev/message=
/6192
Mute This Topic: https://lists.cip-project.org/mt/80553474/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Dz8HEbL4TFOLZBAHByxP--
