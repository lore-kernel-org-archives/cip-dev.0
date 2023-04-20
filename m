Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F184DC77B72
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 15:23:48 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.11145.1682004219263380993
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 08:23:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=t2al6WoP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so1460437b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682004218; x=1684596218;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+nrtZSit75NLs2LTxTwlAQ1G+j2t+UXZ7oM2psbFYKc=;
        b=t2al6WoPQ1Qpr55H/qnzEmoDy1NhDML9PV21kxc54Op5Fo0fOotLf/E4lww0YXxxPA
         Xt6jmJU5NWQ0h/K3tBxwBn9F01GHQEP0o5vFKi3R4fHfn0Yt0nUAI0tC5s08IC/ssAqH
         fMret+Oq4WQWld+jelFuSvKSmlBXO5U9wQ+BPSn8FynFs+WHWbDEBnZgfQO2GUUy8e2F
         p7Yum62IYIyujN2sfRtEMVT8qMqfM4R3Ap68ctGKuFsPtC+9BziOhVSVH5BhSB0F0Coq
         6mvsVYtePPS0Kw6T4JQamb8ghQ7TBzZiOCg2dClaUGvRmN8x7p5MI78moYDUsG3wpmwf
         EjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004218; x=1684596218;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nrtZSit75NLs2LTxTwlAQ1G+j2t+UXZ7oM2psbFYKc=;
        b=ApFNM8xnjBS5YqccFZsi75dCV/LoFd/LuPsWFvmAGkdxig8J98wGgpA+ydnj5+BM3j
         8DFa1j1AuHfxw8OxyHxnoNbpwD5AYTAFTbQhf44sSCkLDPmzMmQzqUU7PmqwrUVrTtzT
         NwPNLqmTOEGINqOlvdZ2OZCOdW31YXfAsKUWYjFhG3ZM7K/6AVMy1/a/h/SyK1AJqboi
         4c6OYoI/mfvE0naWfTacflWsgHbjc710jqNdRrS2fdyGDdzd8HUNYkjBdK7C40ltJ9we
         i7LNu9NJYqNNMyPO4sO2nAr7uZVXHv/DUkMro3NL+HMhsLzdBjq2dItHEzaFqN31Flah
         rcvg==
X-Gm-Message-State: AAQBX9d7eQLzBP4tUa15QdHGNUITYe1k5nXgk4kZQhqQEk0QOTYG5iwz
	bTnfMXgAaORJDbY3VlxFW5LNsTVeDBJ2OXznAGhN5Gq5
X-Google-Smtp-Source: AKy350YvJ5Ilm7VRt9A2Av1hsWMSMb9OQIfmZl41yh9R8XD7Dg8O94iIbCLhElgK8RDyvJZFOIMu1w==
X-Received: by 2002:aa7:88d0:0:b0:636:f899:46a0 with SMTP id k16-20020aa788d0000000b00636f89946a0mr2168818pff.15.1682004218551;
        Thu, 20 Apr 2023 08:23:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w129-20020a628287000000b0063b599a28ddsm1398554pfd.55.2023.04.20.08.23.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:23:38 -0700 (PDT)
Message-ID: <644158fa.620a0220.a3265.2c81@mx.google.com>
Date: Thu, 20 Apr 2023 08:23:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.177-cip31-122-gfb6ca504156b4
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 5 runs,
 1 regressions (v5.10.177-cip31-122-gfb6ca504156b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 15:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11252

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 5 runs, 1 regressions (v5.1=
0.177-cip31-122-gfb6ca504156b4)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.177-cip31-122-gfb6ca504156b4/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.177-cip31-122-gfb6ca504156b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fb6ca504156b4789acc2b019a0aaeae91c6d73dc =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/644152f36f8997bf0f2e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig/gcc-10/lab-=
cip/smc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig/gcc-10/lab-=
cip/smc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/644152f36f8997bf0f2e85f4
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695) =

 =20

