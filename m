Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90F6C4167D
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:37:27 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web09.319.1668033438803746717
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:37:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vFAfz95K;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id m6so121482pfb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3lryPbqIOYCFkuEFRxu8tqk6oSHdDAGmE6Y7cGguCB0=;
        b=vFAfz95KNv2dJxbAjWFA7G96OCM8RzJ7lpyTb9R8zq8ZbKJz/vVK7rt8Mr994+9Px1
         rVaP8qUigPp7hQ66OoRcruUC0v+U0FTEPLTVByfdaPUKz2pXdzEsKFyaRaEUNzDiTXvu
         kqCDshsjy/TwkinC8N/Kz16cwFTmSZ6VcBrkYIWJioARa/y5hmXqHzbBBCw5gXYo/zKa
         xdaPu7+HaXsWYayEXjqO8JZkgJWX7SMHgkyOvmXuJqcOPbTW5cvFh1FkHbHRVzmols87
         xvbmdM+r9nB3WSIEscAw8Hb2b+Jrl9s9WirzRPO5iP4/gCt9Q7OcUIX7BRvslzIexson
         iTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lryPbqIOYCFkuEFRxu8tqk6oSHdDAGmE6Y7cGguCB0=;
        b=UR/S1GPWDyTkxZ/VuwQ10wT8PUuVezllqp7eM6ZLN/p8JzVQghljQVi9PkaytWoHlZ
         DfEYToAc9noev5yrlbM3OyYSH/grzRd8yMf0xeaTO3gqXgdVjDB5iLqXH0Z9qx+52zEr
         mWP0NxGlogw7Gww3ghAO1hXEQ6gKpkotKwNJT4JUojbtm8zsjzqBPpkBNJCohLjznEUk
         4svCevPa+maAVxpDYzl85sdvKnK1LhXaHVerdrx/gM3imlUCdKJRtjCnG7Opksv92uOa
         jjcVe5OTF28yHVBZgrTZj/qUrjKr+4xD4Q39ncD3qr2luiUKrJfrQyorESWN8ZR9yCY+
         lNVg==
X-Gm-Message-State: ACrzQf3EGb/8UEGLsPEBP+qorAiMVO0R1X/i0In6V727t3F2mB+QpI9e
	p5tqkasJAQF7I8IV+gNPSj5mf0qVabw+y77uew0=
X-Google-Smtp-Source: AMsMyM53rIqaNxwu61mRPpj1oiiGtdbbweIMv140fHkmNVguTrEziinOUu7wo+F6bgq2HI2SJ8dJ1w==
X-Received: by 2002:a65:5644:0:b0:46f:e930:1968 with SMTP id m4-20020a655644000000b0046fe9301968mr40605676pgs.458.1668033437862;
        Wed, 09 Nov 2022 14:37:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z25-20020aa79599000000b0056c702a370dsm8730202pfj.117.2022.11.09.14.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:37:17 -0800 (PST)
Message-ID: <636c2b9d.a70a0220.447f6.e68f@mx.google.com>
Date: Wed, 09 Nov 2022 14:37:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-3-gc76f4e7e5c71
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 11 runs,
 1 regressions (v5.10.153-cip19-3-gc76f4e7e5c71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9975

cip/linux-5.10.y-cip kselftest-filesystems: 11 runs, 1 regressions (v5.10.1=
53-cip19-3-gc76f4e7e5c71)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19-3-gc76f4e7e5c71/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19-3-gc76f4e7e5c71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c76f4e7e5c7160107c9b5d8ec188f61fe326cec3 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/636c1e7636e0e3f356e7db5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesy=
stems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesy=
stems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/636c1e76=
36e0e3f356e7db5f
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =

 =20

