Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E45C3DA40
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 02:34:53 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.1138.1687401292357403012
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 19:34:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=bcFp18Ou;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-666683eb028so3975211b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 19:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687401291; x=1689993291;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XloEIZbPGLf7cbAJQFlRI2uGjbTe4Cg7S2w2ToWQ4MM=;
        b=bcFp18OugS5jX0Z0VnqgLZ8hw/Lo18UCpwY1woO1cKJ9+u6E9QBizjjG5Laefr3zAT
         8Nr2koh4f+tn24W+rudpWVz25NTy+TdekOG2sW5MF4WiasT1wlVLedkAji9hty9MnSCe
         K7210QadR/vxF60l81/HQ7mzIPJfIp9S0KRgOwHKfFaw+sh9LoVxO54AYJgRMsbP63k3
         PiDKU569FCAPlWdNvdZAivQh75td8GIOLpOswbx4UT6htLO+xO013Z7JZzONM9tHBtRb
         /EOAsw1gNtAfeylNMYa7hnlv/pQ+ZYT62Rkk1Q4AsbvYInFBru5j9e3TFcgW4sah7//A
         jk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687401291; x=1689993291;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XloEIZbPGLf7cbAJQFlRI2uGjbTe4Cg7S2w2ToWQ4MM=;
        b=gIL1KyY0ZwHoAYeflpTgpL6rfsZ5EQl8T7ImKiY2oksaEG47e7FVIQuWLv1yl6LVNu
         +Dj2StZMb/xuAqwg7UE02dyiXTSk/8XQJu6pCLG1cOUAX1giOCOuk4j/TviLdfyc5kPg
         xEBzY3fSRSTG9wWFTCe/swWNcE4RgBlKnzLKC1eFG96npxcbDXybUeQRlvWWbC1UIjqE
         AgJkE6hlAWE6qPhiZO37OWyaPGSg+NZkzpQ+gkZT+JUJTAjZJzsnzDOm/fExvNRT9uuV
         4yA1fmYIGpK4JG6D5QWBAHsOfd2loRGgk0EiHeBn+BeyyibaaxHaDemRd1JXG9EvzWc/
         l43w==
X-Gm-Message-State: AC+VfDxqNJZgTqS1kDEwX8ix34WnHynYAyxw+ZwE2NY+j9qxpVNat+v6
	MZZ5o9ba7h/2ycyZ6z9PywY/zpfpq/zrZi6Bkg2RGQ==
X-Google-Smtp-Source: ACHHUZ7haGT6pWUFmA8ajyJ85qfgd2hFoVYlh2i4lu4HuFyK5MDMqWCxMAPZosxX4V92kydUfqazAA==
X-Received: by 2002:a05:6a00:2314:b0:665:d717:6ec8 with SMTP id h20-20020a056a00231400b00665d7176ec8mr12912812pfh.8.1687401291305;
        Wed, 21 Jun 2023 19:34:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h18-20020a62b412000000b0065017055caasm3460026pfn.210.2023.06.21.19.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:34:49 -0700 (PDT)
Message-ID: <6493b349.620a0220.863ab.8ce5@mx.google.com>
Date: Wed, 21 Jun 2023 19:34:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 11 runs,
 1 regressions (v5.10.184-cip36)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 02:34:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12110

cip/linux-5.10.y-cip ltp-fcntl-locktests: 11 runs, 1 regressions (v5.10.184=
-cip36)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f34f3ecd0387c3ad8b34bf65ac19ec84a38f2333

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6493af79623fd6a0d730614f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-gxl-s90=
5x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-gxl-s90=
5x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6493af7962=
3fd6a0d7306150
        new failure (last pass: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

