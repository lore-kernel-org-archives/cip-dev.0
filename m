Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4448EE14A9
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 23:23:31 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
 by mx.groups.io with SMTP id smtpd.web11.925.1694042600848769987
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 16:23:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=FKqsVxYN;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.52, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1d4e0c2901bso268153fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 16:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1694042599; x=1694647399; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8LtChZuM0AdCzD55V0Kr/u95V+LooSGltJuaZSJW9iw=;
        b=FKqsVxYNk9Mm90i0nwlcbtNmjDTq/n7BSpK42V4r2gQ0MrarfkJFiC4L8T3g0qreZd
         72xhrRxUhG/OGECIvnrw0PVOeGH1ikb3XkNbDmuY9NRuxMe5F+Tm1abOOR80VUgfOFQe
         2/IZI77Ov1qrFl0dvw5YLaxDJDROEFHY/I1nYqV1f/iPZPpx076rneVWLSjylWDa48Ha
         tbYoGD4/XkSCNj74Mu4Ei/97zE15afS55Q7oRyaxp9LTwzkWZPaFzhEkjq9CfIk2xLNd
         boWuxTGJXpL5A4cAbAzixM8jMGF6LKkRj0uwj5nTJtS+3LRx1Zr264ze/nlB7/YZKg9f
         l0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694042599; x=1694647399;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LtChZuM0AdCzD55V0Kr/u95V+LooSGltJuaZSJW9iw=;
        b=DRQHPnG6RIGKL1+KRjihGkoRAbuzRLrkw2x8r6YhPBWYPatD1mKtVR7P75AQXHMs4t
         PykRdTTS7OR+AJb/HHUOZzpxXUlMRc+EPKc8ZYKI6B46WSZvR+GBfM36C3heQQrgKTKq
         QdlItFgGdkxeuVQ0ryQKsDG489Wq5+KQOKZLBrvLm1wOJkeR60yBz91VJf0t7jqr+JrE
         S8WL33hOkpiHwMAfNCS766f9M4lb/q2wh0ulwN3dvGf0sgEOxfal9frUR05HY+gjO0iu
         wtobjjQcXoPSFBRCMUmcSRDtW9JOzKRGjPmeXliNHxyrLjSGrg0pZtc8+H4qakpS629E
         wdsg==
X-Gm-Message-State: AOJu0YwvBm7oiaQlhkz61B/iK2wcLSHZfBHss3aEQ3u8FezsdtaqPRXT
	MKvQnfIT2uAT7/igMrkgLTU7Es2tMeMh9sYBDMnKmQV6DhU1W+eh3dA=
X-Google-Smtp-Source: AGHT+IHWoMJ6qLJvwVsbTVZ8zNFNbV8sba2LpgzaZ7eX3Mctl9ZTIxjjZr8Tn/p4r7VnTkytASDTqxr+z8Qt5ZgAdyc=
X-Received: by 2002:a05:6870:2198:b0:1b0:18e8:9536 with SMTP id
 l24-20020a056870219800b001b018e89536mr22837666oae.52.1694042599358; Wed, 06
 Sep 2023 16:23:19 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Sep 2023 08:22:42 +0900
Message-ID: <CAODzB9qzhsHVN8-QuYhEVjhkOaNWV-ctoGC8F=AO4Vg-B7bgVQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 23:23:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12998

Hi !

It's this week's CVE report.

This week reported 5 new CVEs and 5 updated CVEs.

* New CVEs

CVE-2023-4206: net/sched: cls_route: No longer copy tcf_result on
update to avoid use-after-free

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux kernel's net/sched:
cls_route component can be exploited to achieve local privilege
escalation. When route4_change() is called on an existing filter,
the whole tcf_result struct is always copied into the new instance of
the filter. This causes a problem when updating a filter bound to a
class, as tcf_unbind_filter() is always called on the
old instance in the success path, decreasing filter_cnt of the still
referenced class and allowing it to be deleted, leading to a
use-after-free.

All stable kernels, cip/4.19, cip/4.4, cip/4.4-st, cip/5.10, cip/6.1,
and cip/6.1-rt have been fixed.

Fixed status
mainline: [b80b829e9e2c1b3f7aae34855e04d8f6ecaf13c8]
stable/4.14: [226d84d54a9339b7045aff36c8f56d6ee9270476]
stable/4.19: [ad8f36f96696a7f1d191da66637c415959bab6d8]
stable/5.10: [aaa71c4e8ad98828ed50dde3eec8e0d545a117f7]
stable/5.15: [79c3d81c9ad140957b081c91908d7e2964dc603f]
stable/5.4: [1c8262f31fd2d23d1cfd2539715d976c2a99e582]
stable/6.1: [d4d3b53a4c66004e8e864fea744b3a2b86a73b62]
stable/6.4: [a836184b670f59e24d3a0f7c07115ec6e6ce6900]

CVE-2023-4207: net/sched: cls_fw: No longer copy tcf_result on update
to avoid use-after-free

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux kernel's net/sched: cls_fw
component can be exploited to achieve local privilege escalation. When
fw_change() is called on an existing filter, the whole
tcf_result struct is always copied into the new instance of the
filter. This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in
the success path, decreasing filter_cnt of the still referenced class
and allowing it to be deleted, leading to a use-after-free.

This bug was introduced by commit e35a8ee ("net: sched: fw use RCU")
in 3.18-rc1.

Fixed status
mainline: [76e42ae831991c828cffa8c37736ebfb831ad5ec]
stable/5.10: [a8d478200b104ff356f51e1f63499fe46ba8c9b8]
stable/5.15: [9edf7955025a602ab6bcc94d923c436e160a10e3]
stable/5.4: [83e3d4b0ae373dcba30c68bf28f8d179191a297a]
stable/6.1: [7f691439b29be0aae68f83ad5eecfddc11007724]
stable/6.4: [7d848d718aeb3b482e177b682dd04e76dd413afb]

CVE-2023-4208: net/sched: cls_u32: No longer copy tcf_result on update
to avoid use-after-free

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux kernel's net/sched:
cls_u32 component can be exploited to achieve local privilege
escalation. When u32_change() is called on an existing filter,
the whole tcf_result struct is always copied into the new instance of
the filter. This causes a problem when updating a filter bound to a
class, as tcf_unbind_filter() is always called on the
old instance in the success path, decreasing filter_cnt of the still
referenced class and allowing it to be deleted, leading to a
use-after-free.

All stable kernels, cip/4.19, cip/4.4, cip/4.4-st, cip/5.10, cip/6.1,
and cip/6.1-rt have been fixed.
It was introduced by commit de5df63 ("net: sched: cls_u32 changes to
knode must appear atomic to readers") in 3.18-rc1.

Fixed status
mainline: [3044b16e7c6fe5d24b1cdbcf1bd0a9d92d1ebd81]
stable/4.14: [f0f874147a5b00eae875c24281531f8de7900079]
stable/4.19: [4aae24015ecd70d824a953e2dc5b0ca2c4769243]
stable/5.10: [b4256c99a7116c9514224847e8aaee2ecf110a0a]
stable/5.15: [262430dfc618509246e07acd26211cb4cca79ecc]
stable/5.4: [be785808db32b595728c4042d002c83d0dd4b66f]
stable/6.1: [aab2d095ce4dd8d01ca484c0cc641fb497bf74db]
stable/6.4: [4b717802428fa02cbcbb61209f638f65f9cd4710]

CVE-2023-4622: af_unix: Fix null-ptr-deref in unix_stream_sendpage().

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux kernel's af_unix component
can be exploited to achieve local privilege escalation. The
unix_stream_sendpage() function tries to add data to
the last skb in the peer's recv queue without locking the queue. Thus
there is a race where unix_stream_sendpage() could access an skb
locklessly that is being released by garbage
collection, resulting in use-after-free.

It looks as if Linux 4.4 is affected by this bug too.

Fixed status
mainline: [57d44a354a43edba4ef9963327d4657d12edbfbc]
stable/4.19: [bd6303bef49970ac7f9278a94473b587e19d1ee2]
stable/5.10: [c080cee930303124624fe64fc504f66c815ee6b9]
stable/6.1: [790c2f9d15b594350ae9bca7b236f2b1859de02c]

CVE-2023-4623: net/sched: sch_hfsc: Ensure inner classes have fsc curve

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux kernel's net/sched:
sch_hfsc (HFSC qdisc traffic control) component can be exploited to
achieve local privilege escalation. If a class with
 link-sharing curve (i.e. with the HFSC_FSC flag set) has a parent
without a link-sharing curve, then init_vf() will call vttree_insert()
on the parent, but vttree_remove() will be
skipped in update_vf(). This leaves a dangling pointer that can cause
a use-after-free.

This bug was introduced in 2.6.12 or earlier so all stable kernels are affected.

Fixed status
mainline: [b3d26c5702c7d6c45456326e56d2ccf3f103e60f]

* Updated CVEs

CVE-2022-45886: A use-after-free bug was found in
drivers/media/dvb-core/dvb_net.c

The mainline and stable kernels were fixed. Applying this fix to 4.14
and 4.4 will fail. Because these kernels locate dvb_net.h in
drivers/media/dvb-core/dvb_net.h instead of include/media/dvb_net.h.

Fixed status
mainline: [4172385b0c9ac366dcab78eda48c26814b87ed1a]
stable/4.19: [7bb9c6e05efcecb15b0354d574efbc36ca321d75]
stable/5.10: [2ea7d26ed851db7176e4bfa8174c8a1380255bbe]
stable/5.15: [50831747cb3a880dd4bdebe3fc3c81de9e21582d]
stable/5.4: [ed47886a73dbc0477ae09a4a979e27317cf2b52d]
stable/6.1: [93b5dfebcb1821dde466e29404fcf1fb919f4c72]

CVE-2022-45887: media: ttusb-dec: Fix memory leak in ttusb_dec_exit_dvb()

The mainline, stable kernels, and cip kernels were fixed.

Fixed status
mainline: [517a281338322ff8293f988771c98aaa7205e457]
stable/4.14: [cf412b0543b77d01f74ae2303d7f8a97e6bff686]
stable/4.19: [3e5af0745a4702ab0df2f880bfe0431eb30f9164]
stable/5.10: [eb37fef417a246fe54530901a3ea9c0abc914fc2]
stable/5.15: [d6c47b23599253d7d866e1e8d60cd410855c1be5]
stable/5.4: [08b20cb8e5b9d69bb3b83c1ad30a702767a9f0ef]
stable/6.1: [ea2938c27b0212aaab6702c16b7385e073b35643]

CVE-2023-31083: BUG: general protection fault in hci_uart_tty_ioctl

Fixed in the mainline.

Fixed status
mainline: [9c33663af9ad115f90c076a1828129a3fbadea98]

CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in
btsdio_remove due to unfinished work

Added a commit 73f7b171b ("Bluetooth: btsdio: fix use after free bug
in btsdio_remove due to race condition") to mainline and stable/6.1.

Fixed status
mainline: [1e9ac114c4428fdb7ff4635b45d4f46017e8916f,
73f7b171b7c09139eb3c6a5677c200dc1be5f318]
stable/4.14: [95eacef5692545f199fae4e52abfbfa273acb351]
stable/4.19: [af4d48754d5517d33bac5e504ff1f1de0808e29e]
stable/5.10: [da3d3fdfb4d523c5da30e35a8dd90e04f0fd8962]
stable/5.15: [8efae2112d910d8e5166dd0a836791b08721eef1]
stable/5.4: [a18fb433ceb56e0787546a9d77056dd0f215e762]
stable/6.1: [cbf8deacb7053ce3e3fed64b277c6c6989e65bba,
179c65828593aff1f444e15debd40a477cb23cf4]
stable/6.2: [c59c65a14e8f7d738429648833f3bb3f9df0513f]

CVE-2023-37453: out-of-bounds in read_descriptors in drivers/usb/core/sysfs

The mainline was fixed.
This bug was introduced by commit 45bf39f ("USB: core: Don't hold
device lock while reading the "descriptors" sysfs file"). All stable
kernels and cip kernels are affected.

Fixed status
mainline: [ff33299ec8bb80cdcc073ad9c506bd79bb2ed20b]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
      :masami.ichikawa@miraclelinux.com

