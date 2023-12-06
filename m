Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1915AC4167B
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 07:34:56 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.26257.1701848090029329214
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Dec 2023 23:34:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VKbbQSnr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso6766446b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Dec 2023 23:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701848089; x=1702452889; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE/5ylDKM1dGNYL81+CZSyJ+Vk37lvh+Rd55/e/7CoI=;
        b=VKbbQSnrtpmw1dC0KXc1zt/TTveYn9csPzZT8VT8b1r8xlL3DgqmzmL9+so6zOa6v+
         loPfouuDGWSyDjLEiynZ1/O19HuC4awAhDlZ6W7mqTNp3qCW8u2u8i8Iyt4yxc4wwoLE
         w/jknQr2W45+3Nm734udrSp4iK3jsaBM802/DIRnrpsHETmNjsTp1EKZwzozhswmfTvO
         BoQ0lbpXmoZ54+onU5m1rRT29YBS4bzlwSP7HFFUrOIfeKVGKD9ZjmHLFoAaQcBqswzC
         QivESzohQQxSIQfWvL3ZTSN/W8QRmu4vQpZ5mAYRTpQKIDNZKHsVB4dX4IgjFfxuc+kj
         JmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701848089; x=1702452889;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZE/5ylDKM1dGNYL81+CZSyJ+Vk37lvh+Rd55/e/7CoI=;
        b=Zb26ySq5+1Io6jliBO+D6+yO3B6AoyK5FKVPGmY+0Owdd8LfdFFlXXF2eyM9gJUWvh
         fI2s/Im2NT5Z1KCzCKmPC4gxyhqHGntXUH9FOLSuXkubRJZGf1tGD4C3XzjbtFjK9YZf
         zVzFF+6JkMVp+bona4AgcS1qq3bdxDOCwuTXLH8s3/LKsTbgTCOqktKYiqu+I8r59cpO
         zMnC7wgtt7nL7H33h5k6KVg9VFYAHRmBKRiq3UZtTby8c1QADV4ZTZMYTpdZUSmCTAjk
         svbrpUEt5gOdsi2X0RlM9frE0BhgmXP979N6AGl+imwvNySQ5i1qwxtltQak8f282z/J
         YuIg==
X-Gm-Message-State: AOJu0YwuY+UeNNiD8bJkDDvu66VyRPWgMaTHDIYkMJqsGASKsdKiOJTu
	jFx5IKxHLL4DJoDEiutnGkreueFXBUAGqDVz1LEnIg==
X-Google-Smtp-Source: AGHT+IHxcev5by1FQCo3VsGM7rlL8f0KytuUcTn/u/KaduzpMubxW3MuG1R1r2PPabgGeoPAfsuntQ==
X-Received: by 2002:a05:6a20:a426:b0:18c:b464:ec5b with SMTP id z38-20020a056a20a42600b0018cb464ec5bmr488639pzk.61.1701848088474;
        Tue, 05 Dec 2023 23:34:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w22-20020aa78596000000b006ce7d989c9bsm1170124pfn.133.2023.12.05.23.34.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:34:48 -0800 (PST)
Message-ID: <65702418.a70a0220.6e0f.3ffe@mx.google.com>
Date: Tue, 05 Dec 2023 23:34:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 9 runs,
 1 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Dec 2023 07:34:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13797

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 9 runs, 1 regressions (=
v5.10.201-cip41-16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f

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


  Details:     https://kernelci.org/test/plan/id/657015ad1ed54a3901e13484

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/ltp-f=
cntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/ltp-f=
cntl-locktests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/657015ad1e=
d54a3901e13485
        new failure (last pass: v6.1.64-cip10-rt5) =

 =20

