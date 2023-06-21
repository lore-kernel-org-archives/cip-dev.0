Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4985EB64D7
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 23:08:02 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.web11.1650.1687388879109616092
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jun 2023 16:07:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=fdDfnQh6;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.47, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-560b7ac3cbfso768939eaf.2
        for <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 16:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1687388878; x=1689980878;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ijlPXFp04O4VweKiLlLoIgWuhL0jOxBHwC44xiKu1zY=;
        b=fdDfnQh6sp1R/puGHAADKlf2Dau0k+wU6lC+LjmZ7JBV1fhhp2wpkF4a5uLbPXQz5u
         doR5CZy+CFTHzkSeRlz4OT9okE98GucFWUqsNpagHBoq+w6y189kG7jYSdsBX/DazJSF
         lqCjc7NPaZs/8+HBkWfRADqz09qA0hFYPvW2Fq8vPEZ8B/Q8oJPaahrC2Yk9LTaTRtim
         tRo1LfvuXWXg5ljUUHUT+KsidbReqHjEdnGEXGxMhsFLaH23AJh8kSKkSOXCAWgMftcc
         mloMmrD7zFuRlm9cdnUriyGlT1EHUpA73by3UP57Tabyo2REILbFBQ37/Uvu+dSl3vt0
         Olpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687388878; x=1689980878;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijlPXFp04O4VweKiLlLoIgWuhL0jOxBHwC44xiKu1zY=;
        b=gE0kvo4CFlh8z94lDWYCxoDCQh4KjjaJHw7vpXIvrpmfN6YRRnApiO0q3q1/0mXXqU
         Xs/nfTm7c8q549tdJWsjWp5ZIBy8XSxpTMtycVcW03JXQ48DotQauvk2wvZEqE9NMkt7
         WrsXPEJx71wLBe9AdTUwUELX706qLTIvqyFhdjMuy1H6yPh9BTB6sgI0XN6lT++P1vVj
         AGeh3NAQAKdMLFW5kFd9PRY4pzC9zsAkXemj8jF2/zuouE0+sStta33r0RrO8PubZjVi
         4gWxJ9eENR6tsZPkPTCI2XZYTZYc8k1bS3a4VuAkZV+UIdhQob+NNs4AbhTFBY1VM82v
         zWbw==
X-Gm-Message-State: AC+VfDyV8R3R8AvaeT/yTLdavpuIYQebUjxHEv8/4TGbygaPHawA1Tll
	K8C8l0WgD1Hhjz+aPm/XLldpFdPvwht3JWXYoi278pmJldaOv+zYRyo=
X-Google-Smtp-Source: ACHHUZ7dvrXBOq4oWC1SS36kEwyVvcoGU+UxBSYQtjRgvPQXM0yhqUWBNS3V7rdqq8JlXIoLegckeN89kSjJijiQ+J8=
X-Received: by 2002:a4a:a592:0:b0:55b:2f80:39e4 with SMTP id
 d18-20020a4aa592000000b0055b2f8039e4mr10507759oom.4.1687388877510; Wed, 21
 Jun 2023 16:07:57 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 22 Jun 2023 08:07:20 +0900
Message-ID: <CAODzB9qJgXQ-X3MA3dqckiAsp1Y_zA4DVC12r5XL=EAYo549HQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 23:08:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12104

Hi !

It's this week's CVE report.

This week reported 11 new CVEs and 0 updated CVEs.

* New CVEs

CVE-2023-3268: relayfs: fix out-of-bounds access in relay_file_read

CVSS v3 score is not provided.

An out of bounds (OOB) memory access flaw was found in the Linux
kernel in relay_file_read_start_pos in kernel/relay.c in the relayfs.
This flaw could allow a local attacker to crash the system or leak
kernel internal information.

This bug was introduced by commit 8d62fde ("relay file read: start-pos
fix") in 2.6.22-rc7.

Fixed status
mainline: [43ec16f1450f4936025a9bdf1a273affdb9732c1]
stable/4.19: [ed32488417669568308b65ba5d45799418f9ed49]
stable/5.10: [1b0df44753bf9e45eaf5cee34f87597193f862e8]
stable/5.15: [0b46ee654a9dcd330e8183856b88505a9f633f7d]
stable/5.4: [bc0905a76531fa10fd12d661328636453a36f4ce]
stable/6.1: [f6ee841ff2169d7a7d045340ee72b2b9de9f06c5]
stable/6.3: [35ca4fb494c0c9f226fbcfa1c1688e6cc1e5062e]

CVE-2023-35788: net/sched: flower: fix possible OOB write in fl_set_geneve_opt()

CVSS v3 score is not provided.

An issue was discovered in fl_set_geneve_opt in net/sched/cls_flower.c
in the Linux kernel before 6.3.7. It allows an out-of-bounds write in
the flower classifier code via TCA_FLOWER_KEY_ENC_OPTS_GENEVE packets.
This may result in denial of service or privilege escalation.

This bug was introduced by commit 0a6e777 ("net/sched: allow flower to
match tunnel options") in 4.19-rc1.
So, 4.14 and 4.4 kernels aren't affected.

Fixed status
mainline: [4d56304e5827c8cc8cc18c75343d283af7c4825c]
stable/4.19: [59a27414bb00e48c4153a8b794fb4e69910a6a1b]
stable/5.10: [7c5c67aa294444b53f697dc3ddce61b33ff8badd]
stable/5.15: [45f47d2cf1142fbfe5d6fc39ad78f4aac058907c]
stable/5.4: [94a00f1142c581fe01d17d7beca314592f85e83a]
stable/6.1: [eac615ed3c6d91f1196f16f0a0599fff479cb220]
stable/6.3: [900fab73a9cd3dd6a3a69f89980f8f3c9a738d5a]

CVE-2023-35823: media: saa7134: fix use after free bug in
saa7134_finidev due to race condition

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.2. A
use-after-free was found in saa7134_finidev in
drivers/media/pci/saa7134/saa7134-core.c.
This bug was introduced by commit 1e7126b ("media: saa7134: Convert
timers to use timer_setup()")in 4.15-rc1. So, 4.14 and 4.4 kernels
aren't affected.

Fixed status
mainline: [30cf57da176cca80f11df0d9b7f71581fe601389]
stable/4.19: [95e684340470a95ff4957cb9a536ec7a0461c75b]
stable/5.10: [7dac96e9cc985328ec1fae92f0c245f559dc0e11]
stable/5.15: [2f48c0a463a37ac76ac089ec7936f673b9a0a448]
stable/5.4: [a4b6ab360f56ccdcde29eab29f493d8c464c3ffb]
stable/6.1: [5a72aea9acfe945353fb3a2f141f4e526a5f3684]
stable/6.3: [3a60e51489a3ec61565f5bc53f726ac9ccc6083c]

CVE-2023-35824: media: dm1105: Fix use after free bug in dm1105_remove
due to race condition

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.2. A
use-after-free was found in dm1105_remove in
drivers/media/pci/dm1105/dm1105.c.
This bug was introduced by commit 34d2f9b ("V4L/DVB: dm1105: use
dm1105_dev & dev instead of dm1105dvb") in 2.6.34-rc1 so that 4.4
kernels are affected too.

mainline: [5abda7a16698d4d1f47af1168d8fa2c640116b4a]
stable/4.14: [df01f9c146ce2134de4daf393e29e18d6d5866ec]
stable/4.19: [722c156c6eab40a6e7dda98dfa66724f9d5aeceb]
stable/5.10: [e9d64e90a0ada4d00ac6562e351ef10ae7d9b911]
stable/5.15: [c94388b5b9098db82d6ba4627ef6e41a35870818]
stable/5.4: [cd1583caed7ea879ecb638ed876960e41363b7b6]
stable/6.1: [305262a23c949010a056bd81b6e84051fd72a567]
stable/6.3: [d730bc84064364cafdb20c6ee7fda2cd7416407a]

CVE-2023-35825: Duplicated of CVE-2023-3141

This CVE is a duplicate of CVE-2023-3141 so that CVE-2023-35825 has
been rejected.

CVE-2023-35826: media: cedrus: fix use after free bug in cedrus_remove
due to race condition

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.2. A
use-after-free was found in cedrus_remove in
drivers/staging/media/sunxi/cedrus/cedrus.c.
This bug was introduced by commit 7c38a55 ("media: cedrus: Add
watchdog for job completion") in 5.18-rc1 so that 5.15, 5.4, 4.19,
4.14, and 4.4 aren't affected.

Fixed status
mainline: [50d0a7aea4809cef87979d4669911276aa23b71f]
stable/6.1: [2cdc8f729d953143b3bbdc56841bb6800752de7f]
stable/6.3: [565c863bd982584aa4393f7bdb345dbccb3ad488]

CVE-2023-35827: net: ravb: Fix possible UAF bug in ravb_remove

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel through 6.3.8. A
use-after-free was found in ravb_remove in
drivers/net/ethernet/renesas/ravb_main.c.
This bug was introduced by commit c156633f1353 ("Renesas Ethernet AVB
driver proper") in 4.2-rc1.

Fixed status
Patch was sent to lkml but it hasn't been merged yet
(https://lore.kernel.org/lkml/cca0b40b-d6f8-54c7-1e46-83cb62d0a2f1@huawei.com/T/).

CVE-2023-35828: usb: gadget: udc: renesas_usb3: Fix use after free bug
in renesas_usb3_remove due to race condition

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.2. A
use-after-free was found in renesas_usb3_remove in
drivers/usb/gadget/udc/renesas_usb3.c.
This bug was introduced by commit 39facfa ("usb: gadget: udc:
renesas_usb3: Add register of usb role switch") in 4.19-rc1 so 4.14
and 4.4 aren't affected.

Fixed status
mainline: [2b947f8769be8b8181dc795fd292d3e7120f5204]
stable/4.19: [ad03fe033a71ed1fd2cb68a067198ae0e342f991]
stable/5.10: [36c237b202a406ba441892eabcf44e60dae7ad73]
stable/5.15: [1e58fb6b1cef4d5e552a0c3038bf946890af6f3b]
stable/5.4: [0fee5030c09401818c17be0786f2684c1cc1e440]
stable/6.1: [df2380520926bdbc264cffab0f45da9a21f304c8]
stable/6.3: [231598b40a070a6bf780c0df1ff5ae3e57102900]

CVE-2023-35829: media: rkvdec: fix use after free bug in rkvdec_remove

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.2. A
use-after-free was found in rkvdec_remove in
drivers/staging/media/rkvdec/rkvdec.c.
This bug was introduced by commit cd33c83 ("media: rkvdec: Add the
rkvdec driver") in 5.8-rc1 so 5.4, 4.19, 4.14, and 4.4 aren't
affected.

Fixed status
mainline: [3228cec23b8b29215e18090c6ba635840190993d]
stable/5.10: [de19d02d734ef29f5dbd2c12fe810fa960ecd83f]
stable/5.15: [cac0f4f36e226c79c83d01dddc049ac59d2de157]
stable/6.1: [6a17add9c61030683b9c1fc86878f00a2d318a95]
stable/6.3: [2115e94838adc9d1e7b75043c9f26abcc910f6fb]

CVE-2023-3312: : fix double IO unmap and resource release on exit

CVSS v3 score is not provided.

A vulnerability was found in drivers/cpufreq/qcom-cpufreq-hw.c in
cpufreq subsystem in the Linux Kernel. This flaw, during device unbind
will lead to double release problem leading to denial of service.

This bug was introduced by commit 054a3ef ("cpufreq: qcom-hw: Allocate
qcom_cpufreq_data during probe") in 6.2-rc1. So, before version 6.2
kernels aren't affected.

Fixed status
mainline: [ba5e770c9698782bc203bbf5cf3b36a77720bdbe]
stable/6.3: [d9bad836cf156ee87d577f0bd1ed01501b31a253]

CVE-2023-3317: wifi: mt76: mt7921: Fix use-after-free in fw features query.

CVSS v3 score is not provided.

A use-after-free bug was found in
drivers/net/wireless/mediatek/mt76/mt7921/init.c. When
mt7921_check_offload_capability() is called after release_firmware()
is called, mt7921_check_offload_capability() accesses freed memory
that will cause a kernel crash.
It was fixed in 6.3-rc6.

The mt7921 has been supported since 5.12-rc1-dontuse. So before the
versions don't have this driver.
The mt7921_check_offload_capability() was introduced by commit 034ae28
("wifi: mt76: mt7921: introduce remain_on_channel support") in
6.2-rc1. It might be this commit introduced the bug.

Fixed status
mainline: [2ceb76f734e37833824b7fab6af17c999eb48d2b]

CVE-2023-3220: Lack of return value check will cause NULL pointer dereference

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel through 6.1-rc8.
dpu_crtc_atomic_check in drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
lacks check of the return value of kzalloc() and will cause the NULL
Pointer Dereference.

This bug was introduced by commit 25fdd59 ("drm/msm: Add SDM845 DPU
support") in 4.19-rc1. So, Linux 4.4 and 4.14 are not affected.

Fixed status
mainline: [93340e10b9c5fc86730d149636e0aa8b47bb5a34]
stable/4.19: [c746a0b9210cebb29511f01d2becf240408327bf]
stable/5.10: [e9743b3052e125c44b555f07f2876a4bdccfd983]
stable/5.15: [c7ee1772e3c36fff8e13daa5ce1ac61426544a33]
stable/5.4: [dadd30fcc7e3e01561ef3624f6c0e323105ab523]
stable/6.1: [dd49cef313e6a62541b55e739261c5943cb06c47]

* Updated CVEs

No updated CVEs this week.

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

