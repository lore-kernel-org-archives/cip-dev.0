Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDA1CD6120
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 18:47:22 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.71569.1696877238494054379
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 Oct 2023 11:47:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YZ0HTizb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-69af8a42066so2654331b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 Oct 2023 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696877237; x=1697482037; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XCQ8MxYq0JX12w7mbDu7gmU8bxf3OPUu+Eybi00kjg0=;
        b=YZ0HTizbPGYk0kZG/GeVUMcANJ6rbgMEBftirtab15/VFDgyMDmq8WldL0vgVUOoiU
         o6Sxm0gT1TqbX1hDHn10u8DMF8SskSxHudxLRJobddwAQWGka/s2lbxzWvIsS8+Kdrbv
         GBxK2Z4IHRJ2YZUtwVnfjwXx6Mr20Tw988+BF4bbuxMHHIwnmNQ7echpwaRhriZFuTPf
         0U+rD90DGQKhEUteOkMmdnx0APH6BUibwdfctaeKJSOfdqfH27+YuYpsELVJkVqUNqS6
         9sh47qBaSb/KALPH6YFqVcCRFFyQJA4v1ycu9viWSdsID5otMq41Nucq24SmQx+BNhxi
         GGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877237; x=1697482037;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCQ8MxYq0JX12w7mbDu7gmU8bxf3OPUu+Eybi00kjg0=;
        b=irbzxUgHLgkM16Cu/MePeArNr4dB4vdx22mfkW+hK7cbj0vea7LOCWI2c0+/7TgX8s
         5qk/ux7jUc+xZAqyNROj38n1yNkihvd/w5Ge2yW+h8x361OstEGeflcWDUaDfScVlvLT
         K3TayG4rqeD2kuE2SsVltmqXcSZIdVjEeyiELxSFnW+nou6+MsjYCzNQ0LqgCVieJeWU
         IeiP4XtCepURzlBXGLf0CWXvUSGeV1jo/8UjsrgAYLEKHrntgxjBZnzD2ymiJEDnruBu
         dyzRd/q+AXWEM4YDbzmM4W1h6ac19jOPiibiC9ygYXO20DTDTwUOvlmr7nX7U3lNSbWy
         l18w==
X-Gm-Message-State: AOJu0YwKTx69jBA+saf3IYq/kLGkX1987A7Z+uX6eiOQnHx8juZbhN2/
	risxAqzyqJYNNpuUfzYJnmN7CoXm9H6XkbfnBW4S0w==
X-Google-Smtp-Source: AGHT+IGikapJyGzpO/QI9VNhPjPPhtTrKYPtK188S0Coe24yN34lCr8hHs1kbH5Xm0Xf/mAF3gv15g==
X-Received: by 2002:a05:6a00:2e81:b0:68f:fa05:b77a with SMTP id fd1-20020a056a002e8100b0068ffa05b77amr16484310pfb.31.1696877237547;
        Mon, 09 Oct 2023 11:47:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x27-20020a056a00271b00b0069501bf29basm6744035pfv.77.2023.10.09.11.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:47:16 -0700 (PDT)
Message-ID: <65244ab4.050a0220.328035.f3a8@mx.google.com>
Date: Mon, 09 Oct 2023 11:47:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1778-g3b01feff09495
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-1778-g3b01feff09495)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 18:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13332

cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20-17=
78-g3b01feff09495)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1778-g3b01feff09495/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1778-g3b01feff09495
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b01feff09495bfdcf43283997a6ea6c6bf6c649

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65244022c444ac369eefcf09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
778-g3b01feff09495/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
778-g3b01feff09495/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65244022c4=
44ac369eefcf0a
        failing since 257 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-821-g39bdf0444b23) =

 =20

