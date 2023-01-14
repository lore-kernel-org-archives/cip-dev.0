Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B606FC3DA78
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 03:30:19 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.108908.1673667019170749268
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 13 Jan 2023 19:30:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=IUN+xOFi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id q9so16203801pgq.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 13 Jan 2023 19:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TkbbTAJkrZmKL3TjwpQugAn0RnjoHJm+LXy2In0vT3Y=;
        b=IUN+xOFiUxFXTzApWIMPJ6wh6rDK9/Lvje4mQ7VLR0E7QacSECFrTvGyyXVU8pBJUz
         ekmxhgoVDcC71OSpva84Xer6goZu7OXQIhLz2X9+lsaW1RoLRISTRxbq1aPC7U3dWRkk
         ptHl/oG4HvYxMeAcc32/Lylj/OYpbqni7j/Xhyl+DrAoVTLeW37JfUCCTq7uW8z4AS//
         4eKSYy9gWYhdO+KGl91sMPvcbfE0qefP2Ymv6Xdov+wcqi10aZglXBnQ+s0tZBT2iY9l
         302s4Mcms2b1cZwGoq2IeEjwJfck8mZEgO/2yQwijsB1GhP8ZWMvz/upjiN/ubpmK/q3
         0BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkbbTAJkrZmKL3TjwpQugAn0RnjoHJm+LXy2In0vT3Y=;
        b=xNrvHpcYTcc4D1PdsHUhCwgIy2t71sonhi4BmoaQIn9lzlzop5X9ANYmxGSyE24eyh
         h+Ox0UycP/RFCKVvbOBgzpbes743D42hlkFY6DCUPwxdM9sCaB2f4KLX6JsTVhJu7SsZ
         6FeYGe9m2x6Q9MPy1i0wtCL/FvPR6rCjoqS66hMtppXM0WNzP/Wc5PTYQaPGWb3dUt26
         vNHi3M9Qc+74Bq7kQwAOio/m/R12wf4K8we20VYtdPtlrNZDt/OG2Kdim4/Dg0D/qrby
         fo8LYmh0E2g9YSq+BrwXBYdDMuoQUU7aAD1DGI5yNaiihPV6oTfbdbcKttXX6vrCxWm5
         urtA==
X-Gm-Message-State: AFqh2krX+HrcoOs69ShkELsXtM2v2HIeC+k34HVeaJI+5586On8Hxezu
	J9TEXDs6oLw8bbLEb+ryN7Ewy6/L8Jj/DMsFZ88=
X-Google-Smtp-Source: AMrXdXsNw+RaUHp/Vo7v1G9HVCZjacHr8VAqgay/yUpyMlZHAKYlYOHUM3az7UCO8ddTpXC3N5ZWPw==
X-Received: by 2002:a62:8408:0:b0:575:d06d:1bfa with SMTP id k8-20020a628408000000b00575d06d1bfamr84913714pfd.2.1673667018481;
        Fri, 13 Jan 2023 19:30:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i24-20020a056a00225800b00583698ba91dsm14415206pfu.40.2023.01.13.19.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:30:17 -0800 (PST)
Message-ID: <63c221c9.050a0220.be96.7987@mx.google.com>
Date: Fri, 13 Jan 2023 19:30:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 8 runs,
 1 regressions (v5.10.162-cip24)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 03:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10356

cip/linux-5.10.y-cip ltp-fcntl-locktests: 8 runs, 1 regressions (v5.10.162-=
cip24)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.162-cip24/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.162-cip24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7ef5f1fda52a95426084959dac09acdb3c81327b =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63c2162e772ae4a8571d39c5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-gxl-s90=
5x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-gxl-s90=
5x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/63c2162e77=
2ae4a8571d39c6
        failing since 28 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.158-cip22-7-g92462fd9830b) =

 =20

