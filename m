Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD7FC46CCD
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 01:29:55 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.42393.1703122194697391720
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Dec 2023 17:29:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=BwnjYNRk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d7f1109abcso203737b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Dec 2023 17:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703122193; x=1703726993; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y1CdeIFabb6nvZMhTSPzQI5BTG+0a1If86W/iNhIHds=;
        b=BwnjYNRkSqVe4lni/6EbnIgaLEN7w8eESrbtQ4jKMu20/B4HsSfgpl+ek8KaoByda6
         F3IjnDIWPUhy+a6e3URW/ZkOdlKju2dU/C5jxNgx2Dx+IS9Y+M+dxp0ZvFLEe5O7YqRo
         NPJpCfLG2tbVG4wcxP3NFQKZ06/UX5If8yfi8JFd1rexMaKDSFqx5tFMF0CAhZo8lbou
         BfWZ5BmdIoQFiLgtJoMmly9Zdhrb2kd+oqBHT6eEORqp8b+kMzPeWoYvqKLhTDyJD26y
         NCiOreek+PEehWyHbuHjxaCa3g0NhudBWhbbyFy4IdLuGf5oQU0vrvlmDiy+0jTY/Kew
         iT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122193; x=1703726993;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1CdeIFabb6nvZMhTSPzQI5BTG+0a1If86W/iNhIHds=;
        b=oAGh3R78odfZ2ummpnOezM9nBJQeg1fFM2rNv3SoZCpsYgw2uCaQxJselSPc7EFxDT
         Hys12WmAGyshpHGqS/vL1DVQDfQ2Areymsxow6RFQCsb6pcErP5bxZ/lYisMIpBp8cwF
         CcvFPpNBmFx+qDUHf+PJ2LxuXpHdg5vt+tqP2SyrXO9xAkM403ciQmkYQlxyfI4sAgML
         h+rH3or4lcx3nmIhCR8W0rp1PzAGr51HhdH4TNwHagXTlLvZWO6swtftKqHM6BOjJTWO
         ZAHRkwsZ+otx31PFlEVV+O7rs9trpbsWLYgIKZcEinMXUMZw61DMLc2KIYYmmqBkFq4G
         yIJA==
X-Gm-Message-State: AOJu0YxPxInsl8HnPIMyc9Zj69HvhgVdlU5uOZTAV3erjp/XcHld8ahl
	EN7IAvp4cJh7cL+CsEvNbEwBPCk2NUlwKgGnVQ0=
X-Google-Smtp-Source: AGHT+IE5sNi81jFBhfrZkA6U054+XbE2w1Ly0rKsO7Exho7YVBfoFWcPxFqk5YTVRxIqtokyWRRQgw==
X-Received: by 2002:a17:902:820f:b0:1d0:c20b:a0a with SMTP id x15-20020a170902820f00b001d0c20b0a0amr9360639pln.61.1703122193357;
        Wed, 20 Dec 2023 17:29:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001ca86a9caccsm355762pls.228.2023.12.20.17.29.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:29:52 -0800 (PST)
Message-ID: <65839510.170a0220.f9da6.1b78@mx.google.com>
Date: Wed, 20 Dec 2023 17:29:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-540-g3640150b3b169
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs,
 2 regressions (v5.10.201-cip41-540-g3640150b3b169)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 01:29:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14173

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs, 2 regres=
sions (v5.10.201-cip41-540-g3640150b3b169)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-540-g3640150b3b169/plan/kselfte=
st-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-540-g3640150b3b169
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3640150b3b169fcd03031a9e8aab166a9730a1f9 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/658385c72031d3e4b2e1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/658385c72031d3e4=
b2e1347d
        failing since 48 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/65838603c32a27443ce13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65838603c32a2744=
3ce13476
        new failure (last pass: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =20

