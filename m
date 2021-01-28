Return-Path: <SRS0=pC5b=G7=lists.cip-project.org=bounce+64572+6146+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC25C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 28 Jan 2021 04:01:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A6264DD6
	for <cip-dev@archiver.kernel.org>; Thu, 28 Jan 2021 04:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A6264DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6146+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HwWZYY4521723xayumG0oPIt; Wed, 27 Jan 2021 20:01:40 -0800
X-Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web11.19113.1611802009993825825
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Jan 2021 18:46:50 -0800
X-Received: by mail-lj1-f176.google.com with SMTP id l12so4561351ljc.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Jan 2021 18:46:49 -0800 (PST)
X-Gm-Message-State: lEfCILwok0hwUiJ5kZL6RCkQx4520388AA=
X-Google-Smtp-Source: ABdhPJyQ9Ia08qCjq6kjGDpyWBl0HpEXQ3KO3NY3RN17T1WNG30vvSNNMjFkAe5bRAE2iSBlmnpH4ctLreIQj0NtJWc=
X-Received: by 2002:a2e:9ccc:: with SMTP id g12mr7054427ljj.282.1611802007738;
 Wed, 27 Jan 2021 18:46:47 -0800 (PST)
MIME-Version: 1.0
From: Chen-Yu Tsai <wens213@gmail.com>
Date: Thu, 28 Jan 2021 10:46:36 +0800
Message-ID: <CAGb2v67U62fBOE-OxbfGkOa-SJhmiJQQCXDvJ3bd44sWhsoTig@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-28
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="NVOvWhuWA3bww0IREgcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611806500;
 bh=Gbob4KytLaRIrwDupzupPB0HB8cdpXDi54tdGpx64Vg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=H1e11qv7ZHeLX8hgklNGKyAPi0r0nSivud3li7uFhggQo8iuwZJIHUCcFvegr7Scv4U
 950Hip7S+qQVHJ9K7VOhAb45n56cV82BHG4nqEjgS9owcF/xHJTGlY9eP3E1y9v0f7cp+
 2YXOCUTqPXh/HtY+AqS1yTg+FAHIMhceGjs=

--NVOvWhuWA3bww0IREgcA
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

One new issue this week:
- CVE-2020-35513 [nfsd: incorrect umask] - fixed in all branches

In addition, the fix for CVE-2021-3178 was backported to all stable kernels.
The security concerns for this issue are being disputed though.

Also, information for CVE-2020-27066 still hasn't been disclosed, and
the affected commit is still unclear.

Last, for CVE-2020-27825 the Fixes tag was incorrect; it is actually a
Depends-On [1].
The issue is known to affect at least in 4.14, 4.19 and 5.4. A sample
backport for 4.4+ [2]
was posted, but a proper backport is still pending [3].


Regards
ChenYu

[1] https://lore.kernel.org/linux-arm-msm/20200915141304.41fa7c30@gandalf.local.home/
[2] https://lore.kernel.org/stable/021b1b38-47ce-bc8b-3867-99160cc85523@linux.com/
[3] https://lore.kernel.org/stable/YA1GU+xjL+zUDIjN@kroah.com/
  * All from the same mail thread

--NVOvWhuWA3bww0IREgcA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6146): https://lists.cip-project.org/g/cip-dev/message=
/6146
Mute This Topic: https://lists.cip-project.org/mt/80176441/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NVOvWhuWA3bww0IREgcA--
