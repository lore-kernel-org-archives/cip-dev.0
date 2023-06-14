Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA027EB64DC
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:51:05 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.12517.1686750655740508617
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:50:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=J7thIcio;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6667defb5a3so150607b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686750654; x=1689342654;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrWj4sWRCkKvByB0eDEuqZTtnh/sTUd/Lly1/aGUjKk=;
        b=J7thIciofNo5jF0f2Svhdt5oT2rmWBXZqr7WEyzNDapTieQ69GPE6wjImZiTRnqumh
         S088pTGI9o8Ef/fQMvl+MaC4ZRQ5zWsAc2y6SCMkfPE7JMBe7OrjDNeLohBTwuoWNHii
         9xVvNuq99NZ3ds8QTDSDxZDLmpe20T59ZgE2Eek4ozXI/gziqF8wKhvBUVXHSQe8os/J
         21TXEOW5PQ5HPxMegrsniVUDtRPojSjj/q+WksvfZU6uY+YRWSXJ44zY2AFw842JmUXN
         uVylXR7Hy/AnqfvILGKswCdQzhdg2BAWn4GHFUf30+5SoF/N6iaErLcPJg+vHTijOpVO
         7Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750654; x=1689342654;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrWj4sWRCkKvByB0eDEuqZTtnh/sTUd/Lly1/aGUjKk=;
        b=N4V7Tk3b/dvdNlpCgDyeJ1SlKBp97lr1D4TfT/l07LO3XjUCbZIDuV1OCU8CoRXO5d
         /l/q48S3KkSQA2jHc+QDSpWQtFqDltY2dJZ6937evv4YVYf8fuv05NgJSCAtQK1Ebchv
         vO2d2A8z0tCFCNesbK4iRD8wnxh5IbwYpAABRYLkx235Lvc4bA1+hxSRL4NCU7/AxLpN
         zsyeNkoO0/ZNRIM5afyfP/b8ivkV4EwDGtWflr7N2H5UqGkSizu39nrfYA/1326bjINK
         z/30z0mJ1TdjUhFptYvxi2l4Ugn3KrWer83AGJoHxZAX4e+pbZ3yi/0zIKJI/CCgMkOM
         VEwQ==
X-Gm-Message-State: AC+VfDwZGDEuaVB41hOMGvmGktXODPPq3BBrMnr7JosDJ7B+WenZkzKk
	GYJLIqLhhjj9yJfIMzD9Yh7TNT3kmogB6O5dD4pG1Q==
X-Google-Smtp-Source: ACHHUZ7XUBVez+LPcjXDdpYipk7Ot9o7bYG85N9Q7P2FZ6iXuXIViiUDqD+jFA4Qmg0WnkYtsbsPGQ==
X-Received: by 2002:a05:6a00:228e:b0:666:6b35:c909 with SMTP id f14-20020a056a00228e00b006666b35c909mr1685113pfe.12.1686750654495;
        Wed, 14 Jun 2023 06:50:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m14-20020aa78a0e000000b0063d2dae6247sm10445277pfa.77.2023.06.14.06.50.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Message-ID: <6489c5bc.a70a0220.dabe5.4994@mx.google.com>
Date: Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-g2391124f19a70
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 7 runs,
 2 regressions (v5.10.182-cip35-8-g2391124f19a70)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:51:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12036

cip-gitlab/ci/pavel/linux-test ltp-pty: 7 runs, 2 regressions (v5.10.182-ci=
p35-8-g2391124f19a70)

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
nux-test/kernel/v5.10.182-cip35-8-g2391124f19a70/plan/ltp-pty/

  Test:     ltp-pty
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


  Details:     https://kernelci.org/test/plan/id/6489b9a543ef33ace2306159

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-pty-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-pty-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6489b9a543ef33ace23061=
5a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489c56d45a6c64325306135

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6489c56d45a6c643253061=
36
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

