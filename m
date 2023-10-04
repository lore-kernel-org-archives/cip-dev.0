Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5719EE7B608
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 12:23:11 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.16893.1696422184351761171
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 05:23:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=SGYBZUhg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso1625879b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 05:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696422183; x=1697026983; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ClnYsYfcorG8Se3nHWnSEvtbP3b/RQwqObUKy8Fj9fI=;
        b=SGYBZUhg/VIE3sHOO8dCsw/jwugwMGpngjIrUS0yhLPZYw8EE9zIrEY9UD6K3z6FoE
         bih5ycXcsU/m5rXqZR7pwIZqJij0B1jdYnEWAFjKNImnWuCADV8nqne7KBwHl2tPvcs6
         hIsI2BtTmWCMcn1uE3A8TNVM99xjTre8LJW1p1Q/n9MYCrYoTMZCAe2lr+EdC52YWdlc
         JcA3T3kbSBOTuVWOXqCYho1uiE2dltq5PwcKbPZv122iHmN16lHposnas5467gcLjdWr
         gqAwwGuCrfctiyEgJdYzK84kIQDGs13oyGfJQDW0/y0rFFe3xpySRCoGEmuR4i3vf8Gz
         D1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422183; x=1697026983;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClnYsYfcorG8Se3nHWnSEvtbP3b/RQwqObUKy8Fj9fI=;
        b=jEUV4rd5OLfR/Be+1KCexklVvDdDRY0ABiRjlwBQTmkRai4nc1Dd63DqBR+Wq1l7bS
         Mw0LffC2MpMWExBU5otaC3PLhSxIBGDryvvM0/s0PBiw5RPMVrII1vlt9aM5293oAgOI
         KoE0qPvvkkiH1Zc+rnZOB48uQMKpUC4NEFUJF12MdGhZ5aHp4ChqKL/35xb6z27Bm4df
         Kc5H0M0I+TmN5UXq5UDEHeJw7m+Sxi9H94C2TpoIYjDeSMRR//BlE7sLiV/mLIv9RWYZ
         4+FiBqhODTkammvA6c+L5VdW/BEG/lOaWoKeokZmrnI1E4FCYiZaiwRjy2kIEbvX7dSG
         yWqg==
X-Gm-Message-State: AOJu0YywZn0HdcGypAt1P3nRgWn/wJZOLEo/nBvmmaGQbch89bYO2jfq
	5HMYAgl92NnA3V3Fpn3EtcRI9NFyPjQkfNfDlfiOsA==
X-Google-Smtp-Source: AGHT+IGVbD22QsLviiYxc2NqbU/KGIJXUsGsERuHX7kod77IrjRfJOUzPesQDb6q9bZ+oA5bQChgEQ==
X-Received: by 2002:a05:6a21:3398:b0:169:3eee:624b with SMTP id yy24-20020a056a21339800b001693eee624bmr41460pzb.27.1696422183499;
        Wed, 04 Oct 2023 05:23:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001c5f7e06256sm3572609plw.152.2023.10.04.05.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Message-ID: <651d5923.170a0220.4f55c.943a@mx.google.com>
Date: Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 17 runs,
 2 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 12:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13285

cip/linux-5.10.y-cip ltp-ipc: 17 runs, 2 regressions (v5.10.194-cip39-1-g53=
e59f50ca3ff)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4ccbc460fd877c8a0a4a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/651d4ccbc460fd877c8a0a=
4b
        new failure (last pass: v5.10.184-cip36) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d545f2e44a617de8a0a45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/651d545f2e44a617de8a0a=
46
        new failure (last pass: v5.10.184-cip36) =

 =20

