Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9421C4321E
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 09:23:49 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web08.9159.1667553825183864431
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 04 Nov 2022 02:23:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=MWJCxcKU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id z26so4029380pff.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 04 Nov 2022 02:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/1j4FI+ADPOx4kvphkY9s2rZKo8uHOHwn/em3j2m0ak=;
        b=MWJCxcKUZ/gY8pYhghvULQFPXURW7hMgOys0cTXUPfgg+lGUuzBA/GM0l+zEYgIOkS
         wLYfNMoSNTcVWLpeIe2YGeQz7On0nqm/ZUD+FpU6Uy9N/L4jszXSzRzqv8VmHGQ4Tjb3
         LM8FAG0PlNe4ubAQZ4d8UyXNnKcMm534vTQbziVw8AfsqiNJyPoHWMT18OxnXErl5DUv
         vdo7Ua5U41nGVaeieQczQBgFYPY5nLgTYBsrCPM0X8fl8bkDCldNURFbpDoNgC3EMf00
         y/tPqNXC5qxPXFBKcBriSb5KZXYWiqToXzlzTAvJh/wvnEsU8d33iXG/pQzI3JHH6GH/
         UsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1j4FI+ADPOx4kvphkY9s2rZKo8uHOHwn/em3j2m0ak=;
        b=ygmYuYTRZQttC4ZDXOHxlc5SU0w1d6j4SDV+4WfrpcbYa/v4Eo5qznFY2PDN8rQSTY
         ugQQa8NH2aO9Pa1CTbniZCMLFZ6CvYkxEKEIpokONKPjyKSfGW+8vUY4JGOFClRykQMi
         /g8a3mQuaLnMlHS/uFH8eX0xan6TzDybfq46+m6AeMIi78vFfgf1Lmil7qranayxxEbe
         NPqKG0fYVAQWIn1yn+i2Ti8urGAvXUOtOu508EtsUf7/DTtnS8pFZ0F/XQbGqNTUkSuk
         U+q4MYEf3k/cpVm9LDbMuUuks8p3qruq+IBTGJ2vM6YTbfttfooCrxxzZincnECKn0gG
         D+ww==
X-Gm-Message-State: ACrzQf1XVhVHCuHKdV7+t2WYmE/YNpMVQ78qeb2BFhM7noQnHll8VwVk
	7KCMr62oVvnS/9rDN6vfLzu4OshDd+/zAA==
X-Google-Smtp-Source: AMsMyM6ai4hblB4BoVHsGdQyNjhU7oLVWve7rxCgbNJQQTECxKX11KArNd9szKIV+y+LK8Oppwb5eA==
X-Received: by 2002:a05:6a00:340f:b0:56d:b039:202 with SMTP id cn15-20020a056a00340f00b0056db0390202mr21144450pfb.2.1667553824526;
        Fri, 04 Nov 2022 02:23:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a170902c61100b0016d4f05eb95sm2050164plr.272.2022.11.04.02.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:23:44 -0700 (PDT)
Message-ID: <6364da20.170a0220.37364.40dc@mx.google.com>
Date: Fri, 04 Nov 2022 02:23:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lib: 6 runs,
 1 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 09:23:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9929

cip/linux-5.10.y-cip kselftest-lib: 6 runs, 1 regressions (v5.10.147-cip18-=
12-gcb2b164780be)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.147-cip18-12-gcb2b164780be/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6364d6c37a87d98cf6e7db7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kself=
test-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kself=
test-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6364d6c37a87d98c=
f6e7db7b
        new failure (last pass: v5.10.147-cip18) =

 =20

