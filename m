Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5823EC77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 04:26:30 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web11.242.1685939182919119640
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 21:26:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=WRm0B3Li;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.173, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-38dec65ab50so3812322b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685939182; x=1688531182;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aSnFPEIbbIURcfR1CrrsG8mudUlEqvNvsb1gI8BsQeE=;
        b=WRm0B3Li1yxhZq7blgBMclRk/1PqsvcHYy2eUWwVI2zPzBGlZ6KV8li9DVvcfU33nn
         4i5S7wokpVwyZ/StmnGRN47oEalDEyLHUs948pU3ukHdiYewHjBqa3w+eKGJ7yyUDuZ1
         Bf84xZ+Sr2Xeowau7mEmtl/sSpZSr3JLq1ZzsK7lIWBnKCQIw+o00b8brkemniB0KKK1
         KuiefBzVI4xJUc2owdpXu9ZlGgNy7PKScew9GrI2VR2fAKbR59X3qAccCrp/7iBdgIC7
         thazqfa7t4tHnW2+xE3Cq5z9m2DXa6z92dV1KBU0SQ2xomg7j1X8M8dV1I6tqwoEnzmW
         IyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685939182; x=1688531182;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSnFPEIbbIURcfR1CrrsG8mudUlEqvNvsb1gI8BsQeE=;
        b=eExEijrP/Yt/zBEK0jUmaVP667+bh/tEWshFURNx1Wmo1djhhE29LY+PZ1CuhPRvtr
         vxfFkn4ZDA7bvhFj6TeRNeA5AspLI9ylKOQ/cB2CD73Chh+pfd/NskOa1LE2hD7ol5Zf
         KCHGRrhVnp3BvUeqMezrdIuICwbLFvAC9Kuw5ZY+rr7alZ0vnyWhcAn9eqoVBK9Ob2Zg
         WU0K5i9sTEf/j2ROXu6fAx3gNSIlqWCxLx2Gcboau6hN9XUkE4ldcEyMvWt7+xItndpf
         bNCPz6E8NgSyTvKNw6uTi+qkqwDkM+gg6As5g86c//RPxXgU/VUNuMx1iihh8YrDTCV7
         k0rA==
X-Gm-Message-State: AC+VfDw1dqtiTOjbrLhR04Rt1O+rsIOxU1jyFHyW/Pn3TLOCgLaWcGfC
	6Ijxr5DvTfTebGKJO3nrtCd5ZVNujE9quQd9N1iRBw==
X-Google-Smtp-Source: ACHHUZ6xvIYyG3ijbbzelcbdaCPW7C8EpevPUCFHQdDoxlgHTRDvlEQjZcBXXndyZ0UaBveWsh8otQ==
X-Received: by 2002:a54:468a:0:b0:394:45ad:3ea7 with SMTP id k10-20020a54468a000000b0039445ad3ea7mr6767957oic.5.1685939181818;
        Sun, 04 Jun 2023 21:26:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709028f8b00b001b1f991a4e2sm1946047plo.20.2023.06.04.21.26.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:26:20 -0700 (PDT)
Message-ID: <647d63ec.170a0220.be074.2f56@mx.google.com>
Date: Sun, 04 Jun 2023 21:26:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gae79bc689058c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 12 runs,
 1 regressions (v5.10.180-cip34-19-gae79bc689058c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 04:26:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11775

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 12 runs, 1 regressions =
(v5.10.180-cip34-19-gae79bc689058c)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-19-gae79bc689058c/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-19-gae79bc689058c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ae79bc689058cc27e73e1cde11fdc558c96a2889

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d54fbe65422c528f5ded4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/647d54fbe65422c528f5de=
d5
        new failure (last pass: v5.10.180-cip34-213-g6582dd41d2c22) =

 =20

