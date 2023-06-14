Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668CEB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:51:05 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.12520.1686750656622150194
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:50:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=WHq9ZMnw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b3dd3ca7adso22765045ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686750655; x=1689342655;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V1PFCieu0Cv/JCT28mi8x+cEFoFnARcP+Q9SrWhlbJ4=;
        b=WHq9ZMnwFL2Hd2nVUpuhqIR33c2OUH3jLsw0DUGgM3bWymJN9Ex+xbjkLZQ32mZ1eD
         BNaPzB/3KQGGAZqm25noMLLZuJKm+HCbIh0jgwjTPYFjQXVt/iJsJBrwVFGEsY3vWSl/
         WEfee4ec5O1SUfZsmqkYjqS+MVvWjVYwecFHEcauhEei+UDxLz2RFVXvwWY4Z75K4j31
         A3oGbfIsjJfphsdiqsXa+LuA0RG+fyefGmN7Yx6PJ6HBOzfY6yezJrqZDPP5osy7YkPg
         owEk3Nfc4B8hmVA4ezkMlq8ZP1X6BjOQaiIjF47NkCOEivFpZFWELFcvgdcl+9KtMWS8
         okWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750655; x=1689342655;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1PFCieu0Cv/JCT28mi8x+cEFoFnARcP+Q9SrWhlbJ4=;
        b=VevIaACp41PtbfWSedQFjvL8RQ0NmI2rjDwH4w8hgC6QD/voraUDqrLWvTqPDZ8Mdj
         CqRAg/1TMJjX3HYiv1bc/8uGwdklDpJGEIBBomQVlLzbTtGV4zwPuy/GpxYZl+2cvj7h
         2ztVXBPWcGSEsm8cyZNE69ABY1ec26U/mpC4pguCkX8y3GBlecOLQ9PvvAkHBM2Gm/FS
         eYP3h0swLZ4vr/Y1GxOEt3xm9YpIN1N0P47hdgXRcBeNyfymbIjLiXn7WCdaznxLseGA
         VVK1TSycIyqdBnivPU+7nULIHwvmU6I9xhV25eY6yX+kKBEWxNWKc8WegbAl3ho7Qxz3
         pKzA==
X-Gm-Message-State: AC+VfDzdoLHXFGO2AmZVU/rbLWMkSShptTx8HonSaEep28lNuKFGPnYo
	lQ5KOVXZEc5hkz70pibEz4yj1a3m96dkmCWg7Qf8TQ==
X-Google-Smtp-Source: ACHHUZ4boe+bPkFTG+MRzeENWeGt1PfayLBlamEV+/7nWK5EkEYkKwmwQSUzp03oeCRBw/Hp/LjzJg==
X-Received: by 2002:a17:902:d894:b0:1ae:5f7e:c117 with SMTP id b20-20020a170902d89400b001ae5f7ec117mr11873738plz.60.1686750655290;
        Wed, 14 Jun 2023 06:50:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f55200b001b042c0939fsm12193221plf.99.2023.06.14.06.50.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Message-ID: <6489c5bc.170a0220.dd73a.7b1f@mx.google.com>
Date: Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-g2391124f19a70
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 10 runs,
 2 regressions (v5.10.182-cip35-8-g2391124f19a70)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:51:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12037

cip-gitlab/ci/pavel/linux-test ltp-timers: 10 runs, 2 regressions (v5.10.18=
2-cip35-8-g2391124f19a70)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.182-cip35-8-g2391124f19a70/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.182-cip35-8-g2391124f19a70
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2391124f19a7085376080a6a95b6e45ff525076a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b9ae43ef33ace230615f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-timers-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-timers-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6489b9ae43ef33ace23=
06160
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489c57f45a6c64325306140

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6489c57f45a6c643253=
06141
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

