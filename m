Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B31C4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:50:48 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web10.22501.1702561839741338132
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:50:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wZkgKUBB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.49, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20311257937so1919485fac.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 05:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702561838; x=1703166638; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hCyXTe5uNFC8w0YOMEZeoSAeXzYcjFRcoWBHuFEgDCI=;
        b=wZkgKUBBCaUpQNJDbzXqipIawoewqHRkag46e94VSP5qU2ufgDjsMWWMgrktLGJ46L
         FLbQLaG2eXkSsKSrfqgr2GhZ/D1Ek8wFDLtXIQyYvLxnZmOKwycUHf3+Cpah6GibrmJ0
         RY9jmMBmq1iSutyJSvhy06zQa4W37oFASd9BOGOpNNub+aJeTiYCo68v0qLlNQasS0Ms
         I1a8UHoqz2LqooZ3O5hIV83nxdt2rJKAvApfTtNK27nzgCwEiGEM6V4n27MWna93uV0a
         6htSu9o/r/rI+eLRcKTBQ5WpaGAzisZ7FJ+v3fizcwhSvN64ymHrc9cEaHggZ3MtsOj1
         RrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561838; x=1703166638;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCyXTe5uNFC8w0YOMEZeoSAeXzYcjFRcoWBHuFEgDCI=;
        b=C6mKC2rXCl6mUCPu9GImk67bKdxEcqhCwj8z4lFWVdZVUliq/HpPYiMw2x6UxwN9xM
         QMg3YM7P3kZnKgethtcnuRUQRh7emj0L6CD55+wcfL0Oz66vU8YPVURHxU5adJtD9ZNR
         gcvkx/o49Stmq24rhX3Xa0LeolSSaRYiC2irCnkVOUSruCKYYGkCiD/Fa5YSGhSBxWrZ
         z/VJcxLZOeE8x+K1l9vFuDDMweBCHFRNQppOetn4PLCEWozvZqJ2jUeKDGlN5CSH2mgQ
         iBEeJezyOxPbM4bMDrbycFApVGwPhZm7jev0cfNKUj0hdLS6z4drhKVTGOCqoFxhTpDW
         Fr7Q==
X-Gm-Message-State: AOJu0YzPNCWB9HKcuxoqrGXRcGS6Cj5VAOSck2/YxCNvOSxKkWBVIUns
	s4aOw1ZwrU7WZVCh90Acbk1bQycRFWj6VXcWDA5Tgg==
X-Google-Smtp-Source: AGHT+IFLatWjO83UM0Av6U0/QRxtoCVXA54GVQxfXKkB9TVGvDx2EsW0lm3dWM2h2oFIVfSonSWApQ==
X-Received: by 2002:a05:6870:40ce:b0:1fb:75b:12ee with SMTP id l14-20020a05687040ce00b001fb075b12eemr11935263oal.64.1702561838537;
        Thu, 14 Dec 2023 05:50:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bs9-20020a632809000000b0059b2316be86sm11671204pgb.46.2023.12.14.05.50.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:36 -0800 (PST)
Message-ID: <657b082c.630a0220.30038.4445@mx.google.com>
Date: Thu, 14 Dec 2023 05:50:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 14 runs,
 2 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:50:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14105

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 14 runs, 2 regressions =
(v5.10.201-cip41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-69-g8f7b450fc28ed/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160

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


  Details:     https://kernelci.org/test/plan/id/657afea432f8d0140de13484

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/657afea432f8d0140de134=
85
        failing since 15 days (last pass: v5.10.200-cip40-188-g33d0b44cd71d=
, first fail: v5.10.201-cip41-197-g2d08925b44e52) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/657afa19c711682261e135c2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/657afa19c711682261e135=
c3
        failing since 15 days (last pass: v5.10.200-cip40-188-g33d0b44cd71d=
, first fail: v5.10.201-cip41-197-g2d08925b44e52) =

 =20

