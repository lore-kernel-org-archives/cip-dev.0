Return-Path: <SRS0=XwY5=IQ=lists.cip-project.org=bounce+64572+6293+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B347C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 08:47:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B3464EF9
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 08:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B3464EF9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6293+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UFLfYY4521723xz1aGhhQvUI; Thu, 18 Mar 2021 01:47:49 -0700
X-Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web08.6364.1616057268455075336
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Mar 2021 01:47:48 -0700
X-Received: by mail-lf1-f54.google.com with SMTP id m17so3280993lfg.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Mar 2021 01:47:48 -0700 (PDT)
X-Gm-Message-State: 6Mg3ofJIxe0scaYYJONZAcuAx4520388AA=
X-Google-Smtp-Source: ABdhPJxxGsFOoNlkcSKFpmTcgmOPFpSKS+ZMneXq/8tWUnWtrpxglXY4gqDDTupttsJUowNz0uMBFA==
X-Received: by 2002:ac2:48b1:: with SMTP id u17mr4922912lfg.627.1616057266091;
        Thu, 18 Mar 2021 01:47:46 -0700 (PDT)
X-Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id z64sm142985lfa.92.2021.03.18.01.47.45
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 01:47:46 -0700 (PDT)
X-Received: by mail-lj1-f169.google.com with SMTP id 15so6588074ljj.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Mar 2021 01:47:45 -0700 (PDT)
X-Received: by 2002:a2e:2d02:: with SMTP id t2mr4539777ljt.488.1616057265542;
 Thu, 18 Mar 2021 01:47:45 -0700 (PDT)
MIME-Version: 1.0
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 18 Mar 2021 16:47:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v65+YuY7fMz949oJYTBMY8aQ2j841JKHvsutgzOc-n4vOg@mail.gmail.com>
Message-ID: <CAGb2v65+YuY7fMz949oJYTBMY8aQ2j841JKHvsutgzOc-n4vOg@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-03-18
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Content-Type: multipart/mixed; boundary="qGWnaxWMP2ZiuEmD0EJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616057269;
 bh=rpvpAhoDZtnnvwnm6aYZkrQv8XnCYtXDrl6I+Cunfj0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cEXlPXUVPo1hRiBqYHiXE6qP9i6G99F6jnUIOd/eKrwekBXU8IqJIsehSXevulpfOHV
 O4r2z0u/pGLgxeIqb73wgKiQeUSqyikYp3lfivo11ywodzgvzAyavjlED9Eg7eq7jw5Ch
 AudET+b3VwTOwXcgIc8EgSr4yh7+OSOz2OE=

--qGWnaxWMP2ZiuEmD0EJS
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Six new issues this week from the Ubuntu tracker:

- CVE-2020-35519 [net/x25: buffer overflow] - fixed
  Looks like a few configs still have X.25 enabled:
    4.4.y-cip/x86/plathome_obsvx1.config:CONFIG_X25=m
    4.19.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_X25=m
    5.10.y-cip-rt/x86/siemens_i386-rt_defconfig:CONFIG_X25=m
  Maybe they should be revisited? cip-kernel-config also gives warnings
  for CONFIG_X25.

- CVE-2021-20219 [improper synchronization in flush_to_ldisc()] -
likely RedHat only
  Report mentions incorrect backport in RedHat kernels.

- CVE-2021-20261 [floppy: race condition data corruption] - fixed
  No member enables this except:
    4.4.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_BLK_DEV_FD=m
  which should probably be turned off.

- CVE-2021-28375 [fastrpc: allows sending kernel RPCs] - fixed
  No member enables this.

- CVE-2021-28660 [rtl8188eu: array access out-of-bounds] - fixed
  No member enables this.

- CVE-2021-3428 [integer overflow in ext4_es_cache_extent] - unclear [1]
  Requires a specially-crafted ext4 FS image, so we likely don't care.

Unfortunately Debian's Salsa service, where the Debian kernel security
issue tracker is
hosted, is currently down, so we only have one source of data this week.


Regards
ChenYu


[1] https://lore.kernel.org/stable/20210317151834.GE2541@quack2.suse.cz/

--qGWnaxWMP2ZiuEmD0EJS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6293): https://lists.cip-project.org/g/cip-dev/message=
/6293
Mute This Topic: https://lists.cip-project.org/mt/81424743/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qGWnaxWMP2ZiuEmD0EJS--
