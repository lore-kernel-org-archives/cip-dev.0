Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28495C38147
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 01:41:54 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web11.12282.1702518106682818556
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 17:41:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mWrRF17f;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.45, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d9f7af8918so4503086a34.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 17:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702518105; x=1703122905; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XYMjtHZ7mt2FkgB6m6M3WyNOpC9OGa/p5nRGcx4J/U4=;
        b=mWrRF17fzmAViO6DBuIjU4quyd8SNDTdAPgyrl6TfIEx5n4nut5u5n4SB4D7dGdGad
         /38uiRpRcS7UvRSuGzLi0Lhn4x/KKtJBfmivy2iBregWwCJBLjYOHKKRjxJPjiUAj6o6
         7jKE3SRAqLeaeLyVYx+O9GaEM268QmIQm0K0JDFZDM1eDC5OUEqt0E3BNsNKD2+MreV7
         l1+7j/q4uzkwfodfltI3Syg4/4AMFzYpdoSf+MmhvUikeIpMRqjDyF3yIVPELaqRda/f
         P1F7Tf6Zh8XL+GCK9WuSgc1f0iVsMT6SwLotbgpa3ukt43muvsY0gKSiOvysoipTnKkL
         oPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702518105; x=1703122905;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYMjtHZ7mt2FkgB6m6M3WyNOpC9OGa/p5nRGcx4J/U4=;
        b=pzSH5XwwCxvq6sMdAYSTLs7cgIqEV4hDpB+b2VidBPLV8UmqElZFCiy1/8Agf8cTtq
         ZpNcML/SWNH9sAvxB2XTcegGQJDzrdpUL0xoHX/XkgCUvuE9uv0j9IwmOism/Em+iSdL
         gCHMl2QK1UlT2CfOe4WOH2phHuWPTLzCnK9hbD/iuUDbzfY3uKgYeMZ4i2kKevD0XNIk
         xSRimcpnlWTz+qeiMAUzsbslRZ8cVi9MB/xCt/tLc7meJxyRX4AyxucrOclF6D4l88WF
         dquXg7ysTfXPGzWiR+35CtiwJh4pMskKjxkwLOZtlfhZWltonQGREfS+ra84K/3AYmJI
         bwAw==
X-Gm-Message-State: AOJu0Ywe9hE3jiFV1wPY94R5aKwFbTa5VTv/YS9sIl+SnfQyANFW0n92
	xvVQN/CiZ/Y7tx2P+ujplYjZE7ZITUgLfIJ5Q6OWHA==
X-Google-Smtp-Source: AGHT+IGSKmw0StZLOuPmT9X/TfsqX5wi3yo5sKYoCXEV0LTRfQ9YZHGNZkWaP8hk7U1GZSxrXfmynA==
X-Received: by 2002:a05:6830:616:b0:6d9:ebe3:a86 with SMTP id w22-20020a056830061600b006d9ebe30a86mr8485972oti.14.1702518105321;
        Wed, 13 Dec 2023 17:41:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n19-20020a056a0007d300b006cedd0bd099sm10231442pfu.36.2023.12.13.17.41.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:41:42 -0800 (PST)
Message-ID: <657a5d56.050a0220.48495.0897@mx.google.com>
Date: Wed, 13 Dec 2023 17:41:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-473-gc43d7b7bbe83a
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 16 runs,
 1 regressions (v5.10.201-cip41-473-gc43d7b7bbe83a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 01:41:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14082

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 16 runs, 1 regressions =
(v5.10.201-cip41-473-gc43d7b7bbe83a)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-473-gc43d7b7bbe83a/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-473-gc43d7b7bbe83a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c43d7b7bbe83ae0f7e001ac115b838d7cd1afe79

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
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/657a500acb35bf150de134b7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/657a500acb35bf150de134=
b8
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

