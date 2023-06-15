Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F64C001DD
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 10:38:10 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.14943.1686825486441885636
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 03:38:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=wo/IL3ro;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-666a228d244so251087b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686825485; x=1689417485;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cwjlCMMIss4IGXaqFOQUtCgJtjNVj4xCxnN+imbikSo=;
        b=wo/IL3rom28BAex+8VnFGXrPAct6yS86o+h+QGIgUWKLxrt7k93be9mbBJwf2xmfrJ
         so/3+8iUyA65mrEalBhCJ+vk6UQfjYXeNK68D4gVObx1tJRmwV8wYN7n90PSWtxxnw+0
         nzq5p8ZTPiNO2CFhs2U7DpARhH3C61JN0QspzDrNXQ1CtfhvLgaFMhT9+pA88f0zx8rX
         mI2SKDCBEshbS5wHT8wZCpPW5pEKVhZRj9jLOxD1QoxRtM3qnGRB7lReYjQlW0xLUwir
         18149GlSCsfZu5SxrjZn3+wSOmol7HoBhsB1BZ5uc2w6rKJyV3uwW685qHMJHOshbJKH
         gkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825485; x=1689417485;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwjlCMMIss4IGXaqFOQUtCgJtjNVj4xCxnN+imbikSo=;
        b=REWkmI9FzU33S3Sbc78nY7BO/+FYV1XSlUG0kxTy6CVOTI8CXc6t8PMFkVL+CBesQB
         hvaNLJ8QzkfHd+j3/nGEu7OKeGc1oUb0t+4XUZUL/hHmnAwLBSo0U5lVvMNfJfV3nicO
         ih97Vo/bYhWWcuLiuwObKBopUwIc1HzbRjrzsIpGNPZ/jCJxyswpptaULU0X8JaAfA+0
         9POSgvzOMZCPDGk7z8843OPubBeBU/2SlwlbsyKBN7GcKYPiIY/ufiWKdS4DkmwSxe/9
         1vMZ6Hv1gAYDQ80z8Z3tePd/Sm4EdJPBHzvGdB4P+qLf2jCBhSZKgTRaruGgMzu8wQQ7
         0bZQ==
X-Gm-Message-State: AC+VfDzRuYAN2uBXzhC0tgOyAWLtY/6GFK3VxV/MAx4COoqFB4ONFR/I
	TCeL7WChkNRiwJzcHwGSNzi/vp9dWNiXqz2IS6oN7w==
X-Google-Smtp-Source: ACHHUZ7ypUgZ8IlM2oLWINUgAjkcPxhr85s6kxSfH7zZ8JFpwG3YPQP7/6/EiH/2IFpaiifIpUPlhw==
X-Received: by 2002:a05:6a21:670f:b0:116:5321:63bf with SMTP id wh15-20020a056a21670f00b00116532163bfmr3574354pzb.41.1686825485158;
        Thu, 15 Jun 2023 03:38:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902968300b001b0266579ebsm13696228plp.194.2023.06.15.03.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:38:03 -0700 (PDT)
Message-ID: <648aea0b.170a0220.257dd.be23@mx.google.com>
Date: Thu, 15 Jun 2023 03:38:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gdba81ae6f2be
Subject: cip/linux-5.10.y-cip ltp-ipc: 18 runs,
 2 regressions (v5.10.182-cip35-8-gdba81ae6f2be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 10:38:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12054

cip/linux-5.10.y-cip ltp-ipc: 18 runs, 2 regressions (v5.10.182-cip35-8-gdb=
a81ae6f2be)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | omap2plus_d=
efconfig        | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-8-gdba81ae6f2be/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-8-gdba81ae6f2be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dba81ae6f2be7f7d87f3a29a8566758d2e0017ae

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | omap2plus_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/648add3f383089f2563061a0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/648add3f383089f2563061=
a1
        new failure (last pass: v5.10.180-cip34-26-g462b2292d23e6) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648adf8e728c47c96b306180

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/648adf8e728c47c96b3061=
81
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =20

