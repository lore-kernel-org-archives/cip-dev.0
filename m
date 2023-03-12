Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D33C6FD1F
	for <webhook@archiver.kernel.org>; Sun, 12 Mar 2023 09:08:32 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.63348.1678612105071200745
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Mar 2023 01:08:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6kLlVzjp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id cp12so6002051pfb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Mar 2023 01:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678612104;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mLAqhkdwSkGJbBzOLkTmLe4PWytzZzHucmLYGfK4C7E=;
        b=6kLlVzjprNT7OMzkMMlk2ZgFrDlkHqF/VwGY7IUHqdQVuqR1zMqCH/Xr0/GYeu9uxO
         bNyKBjjwPU9LLihIZ2M8juqq4X7aSkilo4AQCbtZpi4oGPOXslNU+/7TOOZLlWekIphb
         RyDBGC5M3Xv3NNDiRALIxHDkL7XNyHUCjyYeJ5pk9Nfpd9M0GLAUX0veiZBuLEynrX3S
         pB09Z71nVTIyfY0gBQ3RRHGzz8BiEKM5tKjKCmAfMrS/I7C3MCeU+WpnvUw8ocuUiAzn
         TDM9cPENKz6IVNPeEFngIOfEkLqMC+mnd+8r5MUDT4ngfvMQywy1FdlfGEG9au5Sg4Is
         dTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678612104;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLAqhkdwSkGJbBzOLkTmLe4PWytzZzHucmLYGfK4C7E=;
        b=Kf5+azhgj+syTCAOKouSxTh/MdYVLNgDyn9zoOYE+QFqm1Rkmb9HXHJJG+THPVLg6D
         1ClR9HHCqv1h0RUhIU4KrwbMCml592un8jV4tpNPcTFXRMxwhz+OwQ8wyD3uJC3Ae9CL
         FMx8+MZDDU7R5sGUAGHjmq39LtZAqQWwV97vZkptwGdwdkbfIMLpGF6aITEjJKlNtU8Y
         3zd55f04Z8bMrrlJw1wb20hB2QaqMQsjmWvw/SOgjkJ57bm3GmDSrDecloqCHtbzy1yj
         dudpaz6yeSQ0qB/uO5EJwdUjByHx/6qvNVqYUmlYwpkswwjzb6NoxfEWNGH2wQqzYT3K
         wnPQ==
X-Gm-Message-State: AO0yUKUeNM3hSFWmIHySXu42fQwLB09wEXUt4o4n6v55A44ya8jZw7eT
	G/oHcCsbLQSYMr825XKu0CXWlu+PrC/PKjKjb2Y=
X-Google-Smtp-Source: AK7set9EZrIZGLoUzhGBwavkvJ+XyaiC5SXqacYUPvO+F+uGcGv9H6LuI+T7agBJkBf8YOHf5Baqiw==
X-Received: by 2002:a62:546:0:b0:5a8:c3ec:e24e with SMTP id 67-20020a620546000000b005a8c3ece24emr21348368pff.4.1678612104242;
        Sun, 12 Mar 2023 01:08:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w22-20020aa78596000000b005a852450b14sm2427029pfn.183.2023.03.12.01.08.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 01:08:23 -0800 (PST)
Message-ID: <640d9687.a70a0220.86f44.3ec6@mx.google.com>
Date: Sun, 12 Mar 2023 01:08:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-638-g0d599cd2b6695
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 11 runs,
 1 regressions (v5.10.168-cip27-638-g0d599cd2b6695)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Mar 2023 09:08:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10989

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 11 runs, 1 regressions =
(v5.10.168-cip27-638-g0d599cd2b6695)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-638-g0d599cd2b6695/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-638-g0d599cd2b6695
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0d599cd2b6695e03b8e4b1bdf0c2663d16568070

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3cbaaddf6f785d91aeb370beb75d0623f8c48624 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/640d9046e0b38bb10a8c863f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig/gcc-10/lab-=
cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig/gcc-10/lab-=
cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/640d9046e0b38bb10a8c86=
40
        new failure (last pass: v5.10.168-cip27-109-g23841ec76bec) =

 =20

