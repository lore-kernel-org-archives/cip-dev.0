Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEF3C04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 15:37:39 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web11.163881.1692200258393144398
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 08:37:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=LMOPnJCG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.50, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6bcade59b24so5445932a34.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692200257; x=1692805057;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RAmWS0p7E7hbl2e6VQPCDd6OOnPgPK9EFU4QMHq82Kw=;
        b=LMOPnJCGse1hploEwVo2CYDy9mpnUS8il8eVLds0vorL074kNTa2HxdCDQLWeDbQI+
         3EhaDdpgQ1xySbAhZgQrd/lpx/oNNgfBfHpAcBSDQjariBTTzqIbJtiRhSnt1hC59dcX
         wED0EtHqrADjVMSXYN8QT8lujn9ZE5cuJDmZiZXqJ2GJBG2hIYEy2Zz/vKLl/mX81idt
         s4KPU1VGKHLHwv3xVXpG2ObOTo4w84xDhQ5+1ZhGW42j66jNNmsFwKfvkyadMpGmAxe0
         yt+Sse9L5IMIVm4n2VI0NFA+HQl9KGHPlX2BWSO74SAfRYjzh+rffWfKHRoSUC8wMX16
         0Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200257; x=1692805057;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAmWS0p7E7hbl2e6VQPCDd6OOnPgPK9EFU4QMHq82Kw=;
        b=FH5o1Kr3+dp4SuQAeV3XR7TVwCRycmH/hDeDVqq1G4eEsqVB4MsjGKNW0Ixwt+peKn
         N9Oy2fBB/CWIGOJK2VWJiq9zMsCciKwSSwCa9GP/rxl2eUNj/FIFOzM3naTy5RaV6zem
         Pz9Wal8X7OfAW6q3BfMfbFCnwZ73jRm2hf29bYoJlEIrNbcRXTPyidH+Yj0vQk17WDHP
         gDYMValsMO65DAqnlnbJquu6K5PJ/G66riqyktjUI0ImGYmzynx4xyGy29IJmxjrHlKR
         LRgfl+J5E6YiWOsSdKouIXB+KQ/wl9eI5hoQzZC+mQV5OOMxLXM4ADURkhrPRquUBAnK
         X6ZQ==
X-Gm-Message-State: AOJu0YzYqw/w3ogUgxmQVKNvMuX1/Dg+k+cc0k3VJAFZ8SdWuUgx+5QU
	naprgh+/0jWMwjaPApS2le/GAGHn5iHH4RA6HErNrA==
X-Google-Smtp-Source: AGHT+IHJOLYShLXhv1sxGVMIamMD6Sxk+ddSc/FbBucO0caicqGqj5n1/yjxT/ukY4QLyzVjPqr96w==
X-Received: by 2002:a05:6871:71e:b0:1bf:11f1:4724 with SMTP id f30-20020a056871071e00b001bf11f14724mr2737125oap.20.1692200256963;
        Wed, 16 Aug 2023 08:37:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b001bde440e693sm6135629plc.44.2023.08.16.08.37.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:37:35 -0700 (PDT)
Message-ID: <64dced3f.170a0220.18d6d.c365@mx.google.com>
Date: Wed, 16 Aug 2023 08:37:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-3262-g667bb8d8b2cb
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 1 runs,
 1 regressions (v4.4-st20-3262-g667bb8d8b2cb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 15:37:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12736

cip-gitlab/ci/pavel/linux-test ltp-mm: 1 runs, 1 regressions (v4.4-st20-326=
2-g667bb8d8b2cb)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3262-g667bb8d8b2cb/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3262-g667bb8d8b2cb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      667bb8d8b2cb1a46bab0ddda1cf60f6e73eff4c6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce0356cb606bebc35b1fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64dce0356cb606bebc35b1fd
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =20

