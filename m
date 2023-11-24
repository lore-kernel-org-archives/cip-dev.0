Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C49C636F2
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:07:16 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.134059.1700827629660243025
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:07:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Cq6ErBnE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so1768526b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700827628; x=1701432428; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9cjKecnLduX9TmQSnXIgAC1InPEfig5vGgDqFjlfxgM=;
        b=Cq6ErBnEbIwgCSjAQtebkvjQ2hEXx1S11HIZNfXL33/JeGkT9+PTtjPUJwoCQM8WIX
         9av5hA+2mQLoAwlC7o5o3M/YyZ8Rd9EQWfehW7/WX4cwNsKnq97UOpnf9iCdwsQrzopE
         WPhKiqcYZl210UicqIT8ImjqnKZfvWnIlTs6OTIHHgUq0TCmqF0P+q7IGXYE0CcCxDkc
         i3ePuQOUyknF/v7UeQwH8+J4JvLTTcTW/4cy0ZrXzI9GnhwHlSFWb/p0IpAACArUEXu8
         Z+BhTQSngx2gsei8mq55KJu+XhpOAspNyqWDtgDyvbRxZJXjQHb0M1DS0RqqHqH6GNgs
         rVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827628; x=1701432428;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cjKecnLduX9TmQSnXIgAC1InPEfig5vGgDqFjlfxgM=;
        b=DCeiZPlQWG8nlP+63XJbmjALv4lJLs9k46zH7nrev6I4Hly9dfPneEBYuP5EJSkcFR
         3hxZi2kS959fulMej42j2/uPg4x/MB8DliajKGO1pPBOJ2K1tiEd4od+K/xJkzBA2s3/
         niJ3UtZ76zk9VMJxbEicQZ/aZAgAGLD/ibww0WhY/a0lUfTlTieoA5JEydIxUBBxpixh
         trQ8/26zjyQNWDqbnSGt6YpsVDcqp2DNEKA7iHJeQV60055t3THnZgHC0YudKO1CkNVn
         2JbXTUCVAnFQOFUgZZTeI4O3BJAcvmGzptNpZHoc5lkcRy/ClKXsUGAaRY2q/qtBI7yG
         adHw==
X-Gm-Message-State: AOJu0Yz14EvUPlefkcKT4BKtMeE8uHnpa8DSA6SDSCEcQ6CqIyZCsegG
	ARbQjYeq18JiIAhB/HGolZrkWdBJw4T0oT5+ygE=
X-Google-Smtp-Source: AGHT+IGh/CHz1phTdO0nfNW1hM+NwZTdRR/B3T0b6eUI3AcaCCMItO9EfMO7afQ/29dce+5NwcckEw==
X-Received: by 2002:a05:6a20:8418:b0:187:5302:4b2e with SMTP id c24-20020a056a20841800b0018753024b2emr3443543pzd.41.1700827628417;
        Fri, 24 Nov 2023 04:07:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t22-20020aa79396000000b006be0fb89ac2sm2742650pfe.197.2023.11.24.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:07:07 -0800 (PST)
Message-ID: <656091eb.a70a0220.66dc5.65a7@mx.google.com>
Date: Fri, 24 Nov 2023 04:07:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip kselftest-futex: 9 runs,
 2 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13729

cip/linux-5.10.y-cip kselftest-futex: 9 runs, 2 regressions (v5.10.201-cip4=
1-11-ga539098fe70dd)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-11-ga539098fe70dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a539098fe70dd29de0ce67ad5a39c40867ba5b2c =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/656090a15c8a3339a47e4a8b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex=
-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex=
-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/656090a15c8a33=
39a47e4a8c
        new failure (last pass: v5.10.200-cip40) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/656084c2614f8ca53b7e4aa7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/656084c2614f8c=
a53b7e4aa8
        new failure (last pass: v5.10.200-cip40) =

 =20

