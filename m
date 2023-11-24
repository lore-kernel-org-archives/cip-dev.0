Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4FEC636D0
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:07:16 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.133843.1700827634709221139
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:07:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=AaYa2Q9U;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso1495058b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700827633; x=1701432433; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iW38q/KPiUq3CT9UNYBAyUu7IEjhpgJtdyRlws9xU3o=;
        b=AaYa2Q9UcoABqVmKe0SqsMNRZXtRur2y54fZ6DQv20ZY5D/0XKZZMSY7KMc+YkLQI9
         Gz68YSaWUoncGXRs2u30o8OVXzcDpBulkWgpUzhMbfypJA6q2cTssehgcan+c8wUQXrO
         BLqeyxjk99ljhMZe3fzW5lL7nDIi1Uqkd0lkdkGkchls8w56UU8KQT66nRfjYLhm0g7j
         GokLX+OGMfzWSTLigBQ9dGwNGmi8BWB/AeuhGyHBo3r7kem4LP+YW4e+tDWV4r+8xCz3
         s54H/kv5IZD7onBmPrJXRx+KrS+sRtcOj8k9yxwzxQi5xHCctYTEvdupf+D999EYHNuM
         /6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827633; x=1701432433;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iW38q/KPiUq3CT9UNYBAyUu7IEjhpgJtdyRlws9xU3o=;
        b=FnhcgaZ4PXQsnfFrR6uCxgoDquXZo4eiO0IUNYI1Jl831coudvolpROHFSoEarLSCl
         O3/wF2XH4IOtIUkuNrPXf4TcN8FHjxsZkt6tm8SljbSYPAlP6rpqcvkFaqF3Oph2tDZp
         KCdx4UKpVugd8n01ipTW1KHEsPCFdIv9/9HDES+fdyidCh4YisDI/NdR3TVdQHnkq2TI
         DqIRMHBqaZyzI4EubV1qT3X8opiGlLHhmZKtF1cZpLdhiN+K/iVxP8HYsiDXKv+8lnhl
         xPItnSd7Pft3e+7Zu5chinfIgINHFVJR/pLJmAHF5a+Zh8UE/Q3Z1b0I0LdJ0wk+kMmO
         qPfQ==
X-Gm-Message-State: AOJu0YwZMzIx3H3xZGMyenDZpf5d30hMN1euM5s0fh36pLSspA5F8Exy
	M9smQ1s4X8w5vlieOUU/4NjR1HcrWHqpd723s2o=
X-Google-Smtp-Source: AGHT+IFcnDKrzdLifVZb/fSItrS0uLaYmYFl6eX8XfFyMNgB2dnfx0Yu9R+bbPKH/dv0YH3+m1l+5g==
X-Received: by 2002:a05:6a00:e8b:b0:6cb:e1ba:5709 with SMTP id bo11-20020a056a000e8b00b006cbe1ba5709mr2706498pfb.18.1700827633582;
        Fri, 24 Nov 2023 04:07:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fc8-20020a056a002e0800b0068842ebfd10sm2739228pfb.160.2023.11.24.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:07:10 -0800 (PST)
Message-ID: <656091ee.050a0220.2de29.694b@mx.google.com>
Date: Fri, 24 Nov 2023 04:07:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip ltp-pty: 6 runs,
 1 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13734

cip/linux-5.10.y-cip ltp-pty: 6 runs, 1 regressions (v5.10.201-cip41-11-ga5=
39098fe70dd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-11-ga539098fe70dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a539098fe70dd29de0ce67ad5a39c40867ba5b2c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656083896a6e6babb27e4a7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/656083896a6e6babb27e4a=
7e
        failing since 14 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.200-cip40) =

 =20

