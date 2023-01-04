Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C31AC5479D
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:22:03 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.11761.1672838522028309285
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:22:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=pxZfWgJX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so31776317pjg.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Jan 2023 05:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+A0q0iJDDWYN98zZfPfaw9cCz51XnE1dBX3w0jAUuPQ=;
        b=pxZfWgJXcp/bZRW5yMN9LLlSERNtHJzPV7QGDZF+udvdRNNu4RjSVRwyRNUuoIt2oy
         1/eRlR4i246mi8lDlHd4nyNzfhNv5J/Q2zLtOvKQx81lnCqbA6tyzzepemW8cbz04BVB
         P6FJKdFKIWy99iOLsBFxxsFtXjaVPIRd1HD09c9mfgGcAr2cY9U6DYUDC0eS+UcBFPHG
         S5O7vIgaYNbAQ8vfmwE3sppT5arSwDxuqDqm9VX3FiOIOUj6z33C85/vnQsCXQ158Hv+
         0icXQ45UwXBSC4HC2/RjhZy9L4wgc1jAqjYL3X1GB1Cs2qyOgy9DmXyXhsxwjrbJY4Jp
         9iUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+A0q0iJDDWYN98zZfPfaw9cCz51XnE1dBX3w0jAUuPQ=;
        b=5BvhVswHxoks4FUqP6xVKSU5wU7BwHtnabsaM5Co61e/oapSzfP5tZDddWrHaFVciy
         fxifljEvbUM1ae8wvDbQTfhp2elOiPBGpAsg9G2wHWjmUlT41ukrrXfmKr343zEpgUs8
         Qg/Wesl8cEBxlFT5TRrbHoCYNwraPnxqbhyOsIdcRmqFOxAkfJV4JvbVZSn29uZxIXgz
         v94oE+OWsxLud0p25/oB3msB5Lmz+ywBOZKe2Uh6nYR8FYnQSYhUin4nsDPf7kqZsjcO
         xNm8YhzrJHpQ20M86/jywChuozYZ2HWC7tAjOnM9sD2lKRyU2Mi8YFZBkf4QNYRxbQOv
         4VCg==
X-Gm-Message-State: AFqh2koIjkNq3CO6HDv2G5kDcf1/F3FpOEtS/WKJPjJECwYKaEY7ORRx
	Cu2b9EbEveFpsmxjYi2eyWGc+4D40RsJFtPBpLI=
X-Google-Smtp-Source: AMrXdXtFyHOxxKcTsN0T3VsIQCfW58DOsBtujZLFFDtTedL/EdptP0ITAyyxq8eQ/twHoSCe/zwxWQ==
X-Received: by 2002:a17:902:da86:b0:187:3921:2b1c with SMTP id j6-20020a170902da8600b0018739212b1cmr70542949plx.55.1672838521111;
        Wed, 04 Jan 2023 05:22:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001897de9bae3sm9281190pls.204.2023.01.04.05.22.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:22:00 -0800 (PST)
Message-ID: <63b57d78.170a0220.c50d3.d405@mx.google.com>
Date: Wed, 04 Jan 2023 05:22:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.161-cip23-65-gca8c192cb189
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 2 regressions (v5.10.161-cip23-65-gca8c192cb189)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:22:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10306

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 2 regre=
ssions (v5.10.161-cip23-65-gca8c192cb189)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.161-cip23-65-gca8c192cb189/plan/kselftest=
-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.161-cip23-65-gca8c192cb189
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ca8c192cb189c6be84da2274a96e73320a638b43 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/63b5705a0db50710a64eee56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63b5705a0db507=
10a64eee57
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63b57ac4e41db4cf034eee37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63b57ac4e41db4=
cf034eee38
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20

