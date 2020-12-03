Return-Path: <SRS0=QY9z=FH=lists.cip-project.org=bounce+64572+5936+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A230CC64E8A
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 09:26:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B633720C56
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 09:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B633720C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5936+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TgfvYY4521723x0f6HOUhMIR; Thu, 03 Dec 2020 01:26:47 -0800
X-Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web08.7749.1606987606715072912
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Dec 2020 01:26:47 -0800
X-Received: by mail-lj1-f173.google.com with SMTP id y7so1751256lji.8
        for <cip-dev@lists.cip-project.org>; Thu, 03 Dec 2020 01:26:46 -0800 (PST)
X-Gm-Message-State: 4a1KJl4BaZZB68cs3g7oGvKpx4520388AA=
X-Google-Smtp-Source: ABdhPJxzXbEzS97jr2xWzduQdWIzkeVyo9AEJdDo7eYF6iTvcHFkymlXKjN854sAZyJZF+88nioccQ==
X-Received: by 2002:a05:651c:1206:: with SMTP id i6mr885585lja.269.1606987604430;
        Thu, 03 Dec 2020 01:26:44 -0800 (PST)
X-Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p8sm306738lfk.109.2020.12.03.01.26.44
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 01:26:44 -0800 (PST)
X-Received: by mail-lf1-f46.google.com with SMTP id v14so1726259lfo.3
        for <cip-dev@lists.cip-project.org>; Thu, 03 Dec 2020 01:26:44 -0800 (PST)
X-Received: by 2002:a19:ad41:: with SMTP id s1mr991793lfd.571.1606987603883;
 Thu, 03 Dec 2020 01:26:43 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 3 Dec 2020 17:26:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v65t+cryAJ+POQX74MH4st7pcf3X_WQohEWJ6j7bMVRQqg@mail.gmail.com>
Message-ID: <CAGb2v65t+cryAJ+POQX74MH4st7pcf3X_WQohEWJ6j7bMVRQqg@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2020-12-03
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="UtsCpJA2vWyXyJrwKgm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606987607;
 bh=mlxI+He95RcvxOA02/BoTYwqW7NQWz7Ael0V0vXZl/M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MbqLnOJDVGDmAFywcnrT2G9yJ3PPopsv2277aducNioNN9quOoiNHmLgJ+wG3QDrfoK
 vPV+UbcK2zkJHpYlg26cYUria4+sZO3wGAqoMyxp6oUMnXO7WUhpGxqmv3PjR22n93SR2
 y+i63zRIiTylYtU4gJqMLHuhZLIny2LYDmo=

--UtsCpJA2vWyXyJrwKgm0
Content-Type: text/plain; charset="UTF-8"

New issues:

- CVE-2019-20934 [fair scheduler UAF in NUMA code]
- CVE-2020-27815 [fs/jfs: array index out-of-bounds]
- CVE-2020-29368 [mm/THP: COW race condition]
- CVE-2020-29369 [mm/mmap: race condition between expand functions and munmap]
- CVE-2020-29370 [mm/slub: missing TID increment]
- CVE-2020-29371 [fs/romfs: uninitialized memory leaked to userspace]
- CVE-2020-29372 [fs/io_uring: IORING_OP_MADVISE race condition]
- CVE-2020-29373 [fs/io_uring: mount namespace escape]
- CVE-2020-29374 [mm/gup: get_user_pages() and COW ambiguity]

All are fixed in all relevant stable kernels or (CVE-2020-27815) have
fixes queued up for mainline.

Old issues now marked as fixed:

- CVE-2020-10135 [bluetooth: BR/EDR Bluetooth Impersonation Attacks (BIAS)]

Fixes found from backport request.

All in all no action is required for CIP kernels this week.


Regards
ChenYu
Moxa

--UtsCpJA2vWyXyJrwKgm0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5936): https://lists.cip-project.org/g/cip-dev/message=
/5936
Mute This Topic: https://lists.cip-project.org/mt/78681021/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UtsCpJA2vWyXyJrwKgm0--
