Return-Path: <SRS0=HQC9=H2=lists.cip-project.org=bounce+64572+6194+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE661C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 16:55:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0C964F0A
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 16:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0C964F0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6194+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IXZuYY4521723xVlA5VWqE7g; Wed, 24 Feb 2021 08:55:08 -0800
X-Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.258.1614185707453364909
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Feb 2021 08:55:07 -0800
X-Received: by mail-lf1-f42.google.com with SMTP id w36so4076473lfu.4
        for <cip-dev@lists.cip-project.org>; Wed, 24 Feb 2021 08:55:06 -0800 (PST)
X-Gm-Message-State: emhv0Q6yXtULeep45V69RRtPx4520388AA=
X-Google-Smtp-Source: ABdhPJyyG5hzOXoKT4VH2uegoQpIkkvOz6bfiPiiJ85dVO9zCATrKKZ9UDzpCt5nbX03YTf0tk2LwA==
X-Received: by 2002:ac2:4217:: with SMTP id y23mr18656693lfh.368.1614185705142;
        Wed, 24 Feb 2021 08:55:05 -0800 (PST)
X-Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i19sm588108lfo.287.2021.02.24.08.55.04
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 08:55:04 -0800 (PST)
X-Received: by mail-lf1-f45.google.com with SMTP id v5so4014175lft.13
        for <cip-dev@lists.cip-project.org>; Wed, 24 Feb 2021 08:55:04 -0800 (PST)
X-Received: by 2002:ac2:41d6:: with SMTP id d22mr14859363lfi.496.1614185703930;
 Wed, 24 Feb 2021 08:55:03 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 25 Feb 2021 00:54:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v65e+un0E5SwvhNShDz2MObJFZU7DsMvFXN077dSRQdEMQ@mail.gmail.com>
Message-ID: <CAGb2v65e+un0E5SwvhNShDz2MObJFZU7DsMvFXN077dSRQdEMQ@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-25
To: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Cc: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="W0dQ3Kp3NC40pQiE3DZ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614185708;
 bh=CLNg1dQny7Pmmsk5Lu/a5IEHBIHHQIQ8yue+epv3PWs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WSPwS5wzu4PX9ejjMgaa11Y/6Y3l4uS/bgLfGNY6QjNKSSeoaURc153YA6s0A7+cEPD
 AXM3tvbSVuUlj6u0qNMor7H15QKAS1GEP+w3AEV/418WQRNZotVXvzwClt0V+A1Dc8yY+
 sAviShDIxc+zT6dLtmTK1MBkoVWqWccFsuc=

--W0dQ3Kp3NC40pQiE3DZ7
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Five new issues this week:
- CVE-2020-24502 [e810: local DoS] - out-of-tree?
- CVE-2020-24503 [e810: local information leak] - out-of-tree?
- CVE-2020-24504 [e810: local DoS] - out-of-tree?
- CVE-2020-35501 [auditd: open_by_handle_at not covered by file watch] - no fix
- CVE-2021-3411 [broken KRETPROBES on x86] - fixed

Regarding e810, the Intel advisory [1] seems to be referring to the
out-of-tree driver, of which version 1.0.4 was released on 7/14/2020.

Also, a bug was found in the Debian import script. The script was not
picking up fixes which spanned multiple stable kernel releases. This
has now been fixed and a re-import was attempted, though it may be
insufficient to fix all the data already in the repository.

Last, CVE-2020-12362, CVE-2020-12363, and CVE-2020-12364 are now known
to be fixed by a firmware update. However to use the new firmware, a
kernel patch [2] is required.


Regards
ChenYu

[1] https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00462.html
[2] https://git.kernel.org/linus/c784e5249e773689e38d2bc1749f08b986621a26

--W0dQ3Kp3NC40pQiE3DZ7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6194): https://lists.cip-project.org/g/cip-dev/message=
/6194
Mute This Topic: https://lists.cip-project.org/mt/80881316/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--W0dQ3Kp3NC40pQiE3DZ7--
