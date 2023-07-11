Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921B2EB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 16:07:27 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.56.1689091638542279596
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 09:07:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=SuWemU/w;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso7505355ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689091637; x=1691683637;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7qFDmFl3y50VvYCVBSbur5WH2jTVN+KgcO2eiVD+hfI=;
        b=SuWemU/wS43ZoItS5NuUJ7nJS5Rz5DdGuFXMVxtjvQLXZcEyB9RbZEiC/m2y+ZPy3J
         sDnjPtpgzlIb/T4UGXFd+qdl4qp+qG/GvNRql+pTTCVKrHAjbWEekHGlUdQ0D5bD6UOW
         aC3vOUrHJj0uG1AFU4dgxsa1N2Xtzkd6QcAflXhMd40cnFbAdiPf6gVKbzhj9W9PA17n
         dAEopqxwjoEOFUqhNDRVTWzLgbNcocBPfTXf2pLbpvqCv0+JPVgY7O21h85zCaa3YVL5
         Mt2miu7paRseS3L3BxnouNQhyWDf4bkFDO2KVEo8walxHOz6+77lM0nWp1gtAxsFK5fO
         7Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091637; x=1691683637;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qFDmFl3y50VvYCVBSbur5WH2jTVN+KgcO2eiVD+hfI=;
        b=WPddJBt3t36cWUheiBOqFkvxzMUHj/OOCRf4+vn/tn29pqgBf6+LddrNAQ5lZX/maK
         r7J7UtqQOJejHMG2cnNYGTDM4SNGfQzdsM45G8znonZmtgQjVk7v1YJ5Tq1k9NCsF6K/
         O9dlqPYg2VNNOsyWsNxts3qohyiNImXXZIyS9M7Wtt4hEZKd1NHkPZ4iz/4cokqS0Xwn
         r0IWLgXZrydO3IDYcDRhX189b7Yh31kEmqu4HSTffRG/2YvsaGHMihhRmaqISyyKOc6m
         hSvN3dt2n9hUuYk+Nw1Wp+twRLgkYop/nmxnIR81Sx/26DnyUmBr+zDDnO/xK2szzcwG
         UuRw==
X-Gm-Message-State: ABy/qLa0UP0FibYWCMGtdAxob3+TbWb0kJznMNRabOEdW8oyD1FgWZWC
	zMA/pw0EgWs6qIC7WE7KDFTZ/B6GCIB4Pp/oNoeT0w==
X-Google-Smtp-Source: APBJJlGXGQf9eoNiUHsIaK3f7Y14Fr/bzD32aEqUWthx0l3i5oW4IS1EKI9Q/q6RBkBXOxjnFYXnGQ==
X-Received: by 2002:a17:902:ea0d:b0:1b9:cac2:362c with SMTP id s13-20020a170902ea0d00b001b9cac2362cmr9962622plg.4.1689091637565;
        Tue, 11 Jul 2023 09:07:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u21-20020a170902a61500b001b849932030sm2082528plq.198.2023.07.11.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:07:17 -0700 (PDT)
Message-ID: <64ad7e35.170a0220.80bac.42cc@mx.google.com>
Date: Tue, 11 Jul 2023 09:07:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-13-g8fae18103387
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-pty: 6 runs,
 1 regressions (v5.10.184-cip36-13-g8fae18103387)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 16:07:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12320

cip/linux-5.10.y-cip ltp-pty: 6 runs, 1 regressions (v5.10.184-cip36-13-g8f=
ae18103387)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36-13-g8fae18103387/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36-13-g8fae18103387
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8fae18103387e09e360941d7df884a2fc6010f66

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad70f751d34694f8bb2a76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/ltp-pty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/ltp-pty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64ad70f751d34694f8bb2a=
77
        failing since 26 days (last pass: v5.10.182-cip35-1-g7cde3fba93966,=
 first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

