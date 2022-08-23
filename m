Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F869C32789
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 05:33:49 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web12.27989.1661232825535449675
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 22:33:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=4ayf75Hd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id jm11so11841305plb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 22:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=h21b1zey6N3DxnxCFC95S+OVwOE9xUbQjls/JmMe84I=;
        b=4ayf75HdCW6shKjf7KeIhgB7xcUB9UoAdzfWwRgysJ3zHVdhQuhUvNHs5oOiujKwh1
         /SyAt0f7t2IR1/no7FOyeFQGpjfxZu6kyAsr33vRAhz/DONT6EniRKjOeMbkAkkEXUyy
         31yLP9VGwM4kc00oXJhKhbzM5JndZJd+7sngMNPK4K1Ws8tfDrzOWv//MqJ18YAOujmr
         pGn5D0JvIXFnFT+MskrLaNUctZNkcVwPW4dqUg3Q1Z+QJSxk6t3E25dexKY9MDrZ1QRZ
         jfoUmQ47NqNwlzqKcg5S53JQ5YljGBT5jUOP/YRr66fpXHnQ79ltYzML5roDFbOCz9jG
         DJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=h21b1zey6N3DxnxCFC95S+OVwOE9xUbQjls/JmMe84I=;
        b=yyz8V82Z4o4Aa/hF4P9uE7LCj+jSxRejG65IHWfT94Ys1RIax3jORuzZsIm9p/qer/
         EqWNI26XaYgheZEg5PmHyb0/PKJTQKFpB5SYI8WeDckphwMPuf59LppiLwfoccImQQaa
         jN8e1bs4GtVTulfNAb0a62gl5dsVGl4vu6F0Wq3NOfelXbC6YkkrQ9pAiMLVP0Eqbwhu
         /U6kR3qjASZgaIv3L0y+mYM7O37rgHRyFMCXETlfgHcjg4qWbVBAVJzpUpyFapTz6jim
         iJ8h4Qejhnv0UygKU28Y+agmHQrYHmCy9PXcpzLfoVTOwbcaKT7wkGoBcbq7j8WAgfds
         0q8Q==
X-Gm-Message-State: ACgBeo02zXpjMFwAUpbrQE6LEs6iY6Vt9lihhlpFS7LiT1hOnrZyZ3HW
	XDvk0dzmipyGNcPXoSlHZRmAmqR32D4dPA6U
X-Google-Smtp-Source: 
 AA6agR5Un8QsAahe4y1qt3I2mmUo4Kf0GjPkkhBTe2vkg16/mEJWOe9LARsc8faskRf78Lfymz2nBQ==
X-Received: by 2002:a17:902:e848:b0:172:dda3:780f with SMTP id
 t8-20020a170902e84800b00172dda3780fmr11261974plg.66.1661232824704;
        Mon, 22 Aug 2022 22:33:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 d7-20020a170903230700b0016d338160d6sm9461223plh.155.2022.08.22.22.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:33:44 -0700 (PDT)
Message-ID: <630466b8.170a0220.a6167.141a@mx.google.com>
Date: Mon, 22 Aug 2022 22:33:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.136-cip14
Subject: cip/linux-5.10.y-cip kselftest-lib: 10 runs,
 1 regressions (v5.10.136-cip14)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 05:33:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9310

cip/linux-5.10.y-cip kselftest-lib: 10 runs, 1 regressions (v5.10.136-cip14)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.136-cip14/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.136-cip14
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cf2009ac91c8812c08044a33e89c1a53727345bb =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/630456355620367ad2355645

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.136=
-cip14/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g1=
2b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.136=
-cip14/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g1=
2b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/630456355620367a=
d2355646
        new failure (last pass: v5.10.131-cip13-84-g3b53e4dbd9f41) =

 =20

