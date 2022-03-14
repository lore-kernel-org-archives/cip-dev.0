X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web12.24436.1647251581904079423
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 02:53:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AuV0XhZo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id bx5so14011314pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GLKcvtqwbko+DUU1gql2zJR8JFhnYxO7cR/t5/U1O58=;
        b=AuV0XhZoE1QTZ9yLBoWSNnMy8X1BXPgXI57Hdd8Sw0AVuQCkPvT6CIP87nTuEhRSmx
         oHUYaiCxbPPU24XLw2I6fQ9dDoxgdY4GnOq9xLiRBKEejGpL7iZZS5AdGagAvF/1vQHS
         I4McvpiPkDBS8Ra/xNq7rV9EBQ8xHeT2hGRh6dTjXRNjeIpo2akSujxH7g8JHvDJ8+QA
         0fVNfUsnXHJMkaW7Joem8Jw4V3a1/byOd/eThR61LlCHfLP+LHxp2KnM936tCAIZy9QU
         mv5mAC2HZy09M7W4WuTcqTIsQPECeCPcEEZV6/2WuiyFRn2YyxjIu/zLV4naZcgeL8DD
         ld+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GLKcvtqwbko+DUU1gql2zJR8JFhnYxO7cR/t5/U1O58=;
        b=a7OLkxqaQa9hlpcz/YOfIytZlYtmcbvqp+L2zTjwTiBKp3L82g7iWPKdPJohGD0uAq
         ZM2t7qLJJlp14bvQe6PxFPVcbsmQ00SRJM6eRVafHosOt2sOWoYcxL8BX9vLMqKYUIGx
         v2KsTE88REMlolT/Sh8tK6VVUDj0ANj6Q3vwQHCXix7IUCz7CUNdm30wOnyhJ+PUSaZR
         sMmNyvvCs4MMfrzBn6jLnclYMJ8hs8DP2Myt3VFUwM4PfbWnrUZZMpuiS0QhK0831Hv+
         CNaldK3P5VKV60wMgkhfbToab6DHXjtxuZ1nsUFkqVJziqWjTQ1YKOaC2rYxed/Ya0aI
         i5zg==
X-Gm-Message-State: AOAM532lVy8+xttLNbTZeAbXWd61GUXLgy1vDiiOT2Munb0JH2itBLLw
	k7UFS+IB0QrFqARC3XNzDehKm4o4zSNPbRTgx8c=
X-Google-Smtp-Source: ABdhPJzpjKANSOWSzyIiPRWaiSlzyq5vb+RBUmEsCJq30Ff5Rbr8mI98TO2j4AYnvDIZSAON6fZmsg==
X-Received: by 2002:a17:90b:1d84:b0:1bf:6760:7bb with SMTP id pf4-20020a17090b1d8400b001bf676007bbmr24410070pjb.95.1647251581183;
        Mon, 14 Mar 2022 02:53:01 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a00231200b004f72b290994sm19340679pfh.180.2022.03.14.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:53:00 -0700 (PDT)
Message-ID: <622f107c.1c69fb81.2ee69.0ba6@mx.google.com>
Date: Mon, 14 Mar 2022 02:53:00 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.104-cip3
Subject: cip/linux-5.10.y-cip kselftest-lib: 4 runs, 1 regressions (v5.10.104-cip3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip kselftest-lib: 4 runs, 1 regressions (v5.10.104-cip3)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-10   | defconfig+kselftes=
t | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.104-cip3/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.104-cip3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      811c07d2359f700f05d08c49b9d8c4333322bf90 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-10   | defconfig+kselftes=
t | 1          =


  Details:     https://kernelci.org/test/plan/id/622f00a985c65c60e5c62973

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.104=
-cip3/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g12=
b-odroid-n2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.104=
-cip3/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g12=
b-odroid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220228.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/622f00aa85c65c60=
e5c62974
        new failure (last pass: v5.10.83-cip1-178-g2cf1d12aab81) =

 =20

