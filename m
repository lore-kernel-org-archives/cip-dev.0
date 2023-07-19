Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C4AC0015E
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 14:52:07 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.15753.1689778323867858162
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 19 Jul 2023 07:52:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=KdLhitB5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-668704a5b5bso6967374b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 19 Jul 2023 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689778322; x=1692370322;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WdEB9y54DM1ryMtHvjJijnfxv65+cIEr85eJkuvfPwE=;
        b=KdLhitB5WRoWKcor6cTOfY4yvgNVNFLNRN53t9QIrmXw82eL+DmoSkxD6GMlQF9hql
         ujSUl59lmdRrfRTA5iOkv1dIt5SkUm00iqwc3khZ4C/15kz2UT3B0u+LTW57TiOW7CeU
         SVqlDNs63qBpRYYBfFcxCLlQnN23poRkWxblTC5F8AQsfLD8Am0wxzoMWqQc81yTV5V2
         elwWjNaS12UIYc6ixxrK0vwchPYJO9DIrABoSwanOQg+UjG6EXuAkVQ++a0HO0C1QD8O
         +SUsNROv0fE2/GOoMJSxhJbKpxWsxN6x0agdSsbVDvLqHwLZA9d6tl7mDJuLHYX7ghhf
         K0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689778322; x=1692370322;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdEB9y54DM1ryMtHvjJijnfxv65+cIEr85eJkuvfPwE=;
        b=IAvCTY5NtnTtlzJnHq8BdEmoQajF2aix8y/u3/Obw3jv79bkKC7+Rz4XwU9fxZkZbM
         weaKtVgdym4+O1MuV0VeBNO30D1pnpi6kZoetAYBpec0ciG9TYZWHiG4bbUPv4NWl5iX
         PgCZV2MRwhnJkZzMQAzjOfNrgt6tSiSnVAd9h9IJdHLZRpINjFBL72mlVxx1hRQDg4vy
         ZSGpy32TIocbK+xw6yoUbYk5BiOZ1BMYscjuKPkWcEe63REyO3Fw2OToRxb9Z4tGw1L3
         volYnIYDkqaTmCmn3+aHVt0Vccm1T9EZKblIlUuO6qaYhURqgpR7IGeDgFVVsva0awHo
         0oIA==
X-Gm-Message-State: ABy/qLYOxkv2GaLRp0Wz0NqZGCZ9zN5EG+7wCDgC2oHcNLp879m30qNy
	gOiu4+ZBLOR6a0lE9Ih6ik/FjqG5i7v4OtiVQM1omg==
X-Google-Smtp-Source: APBJJlF7EFTGTJbEOK1PwoeTVQC5y/SE9Efg3XHPxMps/gLqbm+lQqwqIQPn/cgPYi22aqsjtoyMYw==
X-Received: by 2002:a05:6a20:7d9a:b0:137:40ba:d91f with SMTP id v26-20020a056a207d9a00b0013740bad91fmr2606402pzj.10.1689778322497;
        Wed, 19 Jul 2023 07:52:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78757000000b0067a1f4f4f7dsm3389623pfo.169.2023.07.19.07.52.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:52:01 -0700 (PDT)
Message-ID: <64b7f891.a70a0220.41e59.76cd@mx.google.com>
Date: Wed, 19 Jul 2023 07:52:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-2-gfcd111609480
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 6 runs,
 1 regressions (v5.10.186-cip37-2-gfcd111609480)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 14:52:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12438

cip-gitlab/ci/pavel/linux-test ltp-pty: 6 runs, 1 regressions (v5.10.186-ci=
p37-2-gfcd111609480)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-2-gfcd111609480/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-2-gfcd111609480
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fcd111609480c664a9d1e68c5ec8c352c2312db5

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


  Details:     https://kernelci.org/test/plan/id/64b7f696c7fbde79b88ace24

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/ltp-pty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/ltp-pty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64b7f697c7fbde79b88ace=
25
        failing since 34 days (last pass: v5.10.180-cip34-26-gc198172c84b6a=
, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =20

