Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEB6C77B7A
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 08:27:42 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.3647.1685089653826437818
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 26 May 2023 01:27:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=PMgQo1lF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ae85b71141so4896535ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 26 May 2023 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685089653; x=1687681653;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lL6xqE2TWaKDoAGqC3xXYFwM/tF42aguqSbu8rar4jY=;
        b=PMgQo1lFKbqY6qJIaNvwUMfloWIoOMAouGpaGfj7jb2qVktZgO+Am3/mSAECpEh/g8
         6dq474x8ngDKGpfYWB8zxxTAOCfvKLJmBCLTYgr4YtbsXE0WrOV6kAqxIVVggNE++p/Q
         LQ7DgjxfhI2QHzTDFGZ3vwVl6ML7Et0+9u6YaHrjBaujaADYq5O/vtoRwMFYnLQwvSWa
         VHQlulNZwPNcSIQQc9awm/zu5zx9968DlWryq/oG0Nstp44dcH0jD9qZ/jm/boqnkVyI
         i0MI1tiNvYq+tgv39xF9EESpJgj2LZGKv7xkV7r0zsQlHnAIVCD+pwwjRY3yoPnoaQHY
         53Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089653; x=1687681653;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lL6xqE2TWaKDoAGqC3xXYFwM/tF42aguqSbu8rar4jY=;
        b=dtpJIdYf+McwX6LNLMyQHtJyAc/4NXXFX23PE6DbVGWO/S+3y76p1M/hWxfVBQtLw4
         xYnUXxvTTmPQ9+h/m2NlYGZVla9JIojFvxk3WnLv3imCRDxWXFt6xzRsnCtVUgaKd+LE
         fJbXNb4/HHS3x2iGutEiuh4q6jmnKbeWi2lGA99Wk/xVMHil4f8evVsGjhaK7rNOS1xd
         30VNtUoQgD2hloGVm4kPVeBQjD9EnXXCnsjUplhEd1HQgOLt3R5EMIe74acpjoPeWAWb
         uaLK/pWcYPr9ONVnoK9u/FA45J19PZ63OaCTvV0UU2QQXZrRFnbz7VtZjm1aJWifcciy
         wfjg==
X-Gm-Message-State: AC+VfDxvt4E7Z7nQ+mKtb/RnLKtZMEgZDwjJ+q6JFEetUKcjjHgexhYL
	FMsDWuqaATSrXhZB16rru6hGVVGUxtmVrMzZ8AlQRg==
X-Google-Smtp-Source: ACHHUZ50R94BJDC1OmEDnD/XxRrP4o2lC/aNQRLJZzwP7so+rRtKUYCjQEFRah8jOx2obC5Z4Nb6Ag==
X-Received: by 2002:a17:902:e810:b0:1ac:5c90:23e with SMTP id u16-20020a170902e81000b001ac5c90023emr2524336plg.7.1685089652916;
        Fri, 26 May 2023 01:27:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d70500b001acad024c8asm2696649ply.40.2023.05.26.01.27.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:27:31 -0700 (PDT)
Message-ID: <64706d73.170a0220.78d86.57de@mx.google.com>
Date: Fri, 26 May 2023 01:27:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-21-g090289427e8b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11
 runs, 1 regressions (v5.10.180-cip33-21-g090289427e8b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 08:27:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11654

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11 runs, 1 =
regressions (v5.10.180-cip33-21-g090289427e8b2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip33-21-g090289427e8b2/plan/ltp-fcnt=
l-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip33-21-g090289427e8b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      090289427e8b2be9dac126c4d1b760b100f2c6b8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  04e8f2f4fd9493f595b34320403cf6b4f1f6789d =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/647065247633d1dfb02e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6470652476=
33d1dfb02e85e7
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4) =

 =20

