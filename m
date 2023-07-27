Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA308C0015E
	for <webhook@archiver.kernel.org>; Thu, 27 Jul 2023 12:16:29 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.5891.1690460186903846726
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Jul 2023 05:16:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=c//R++U5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso5785105ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Jul 2023 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690460186; x=1691064986;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ohR3b0baOn/V0+PD3WlFQTtZzFch/qM2NtZTQP9bURk=;
        b=c//R++U5Ja7ajscGeLV1MLXjwqtZJLHbeOPyYYPy9bileTUy86VUnX6grSjljvQ/MI
         Vrivg1uddL8EVoxOimFlkucGUdCKGMiU4fxibCdri58UhcceEd5LNNfmeY8YEVF9wFtx
         dYLNXfFetm8K9BE1QkIg3Ve2vfyiomI/Nbo2kBQQtnP/I4RK7FCc5DvRvaVkxmVoi8O0
         /ujsrp37O5jIKun+SBNCvcju7icOVzBc/BDpD7AYjfySAl1lkMgvGM3clJW31S+TIorE
         u7r+uBSkboVJKvBVumzhuGMOS53//XnFM58uWS2YUDPxcxV1a5jMPutH90CE21fwRn/N
         lKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460186; x=1691064986;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohR3b0baOn/V0+PD3WlFQTtZzFch/qM2NtZTQP9bURk=;
        b=YLC4OHsoFP230hodGzyUABalPSfmuRQwe8yhS4rZ6BRoGUT9VI8f6DAr1LxdWE8ss5
         ladk2V5D6c+SLgOVJt6xBNCW0fDDCnyKBdqY39JdXj6VEpjb/vzRJqIW0gQaRf7kJqvD
         uCyGMtSE+QPjesQ1+iTLbDTHzc+jre3vjAPWMF3ZOMMcc0vl1u6tANfg6JN8Ku3B2NLZ
         gepo9ieSbLUCN5m2J7Y7iR23aV/J1cVOdebdhp2Tc1ZiTu7BeSNJDMcBZiDHvHV9y/Ct
         BSSK+qizn1gXqvEsDYPJu0SUDRvcgFYwrZQy+5HckrORLwchMwj3sHcIKr+4CaCgNPar
         hAVw==
X-Gm-Message-State: ABy/qLanY516+d7C2NIQGkCCZtgcvT+2wfhElNQ1BZlD3yXw5aDMVUEN
	xdFNG+MQDSa43kpJj0Yl27mzfPTMcUxfL/Ug8ay+OA==
X-Google-Smtp-Source: APBJJlFowPNF+YyrWtQFG20kTDuuoEMFZrXItn/kfpIIe08XgMwme2RC/p5c3tWV53R4YLSAT07SWg==
X-Received: by 2002:a17:902:c941:b0:1b8:2ba0:c9c0 with SMTP id i1-20020a170902c94100b001b82ba0c9c0mr4694296pla.59.1690460185991;
        Thu, 27 Jul 2023 05:16:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001bb9b87ac95sm1494439pld.103.2023.07.27.05.16.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:16:23 -0700 (PDT)
Message-ID: <64c26017.170a0220.eccb6.242c@mx.google.com>
Date: Thu, 27 Jul 2023 05:16:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.186-cip37-526-g7640d76efb649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 4 runs,
 1 regressions (v5.10.186-cip37-526-g7640d76efb649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jul 2023 12:16:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12516

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 4 runs, 1 regressions (=
v5.10.186-cip37-526-g7640d76efb649)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-526-g7640d76efb649/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-526-g7640d76efb649
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7640d76efb649f3c7f8a243e5a966ef7bd8bda13

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64c24dae6fc194fe9e8aceaf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig/gcc-10/lab-=
broonie/ltp-pty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig/gcc-10/lab-=
broonie/ltp-pty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64c24dae6fc194fe9e8ace=
b0
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =20

