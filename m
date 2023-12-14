Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A85C19774
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 01:41:54 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
 by mx.groups.io with SMTP id smtpd.web10.12290.1702518104653425879
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 17:41:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=as0y0ztW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.43, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6da16eab6fcso2993090a34.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 17:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702518103; x=1703122903; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yEtV3HDB3ExJZ71ApwnjSaIMjAzXUugxc8Pasmg005o=;
        b=as0y0ztW7HRmTZUfqvwiVxlxzV33IXUHdmD8C/fp2CHuzP9zOA7mNnnbl6cY7p64nl
         ifFqVtpmNnbGGAyzmWucASoEANpH9See/0dnyzNUYm1tSaWeSiMtpVCJ53JlvyujfY9t
         WT2JYNmtdd2/5D1yiLbiV9zygKj3AQCGesGLkM5xnh7/fiYci0plF91eegyrEygVe+E2
         mCkmo204zcVGqZBsMGE/XAPG651m/VWUxNjpOS3wQtq7gKrPuHwQQ5jkMUEZe5lINIop
         A8FXFYkJ9Ce6kZZ6YQTKed48Dx++Y4ipA9FK1WhChRQPeyV/x1V/NAtW/710pLKe7kUG
         9nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702518103; x=1703122903;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEtV3HDB3ExJZ71ApwnjSaIMjAzXUugxc8Pasmg005o=;
        b=Y22Tepu12m0QZmPDouErejgACCGda8ONXBIJvnnAK6zW0kdHVlg5G93Ui94n28IghC
         VXkCMha3+74ZpFQS6nav68e4iOk1SjcNROTCbNxCoViAAWxZUTtpsi6utp9yKme5ksne
         y9NqT7Bo5klwOI6+8QwqjtN9bvlZVqW0Sq1Lmi9LQbBKPPZ4XOcwFxGYda7oEeL0eMsk
         dO/yRLEMkWfmss6Zs0xCOuaW3bUpzeIlIW8gdq6Yev7cVUr1iIjAbC86K358GHx5WvlM
         m+uvK+MY+aPg2mFn2MbSNee3yl7oOzZUE5xXdmjXJC9veklUONFf/J20b+mPL+FJE/5P
         Z3qg==
X-Gm-Message-State: AOJu0Yz7yGCY/74zw4LvA7s4ZaXbItMnac4j9GcMSp9ttwt17j6iwEGE
	wPQ6w3vSybOiFwv6H0IR/p0YksjBMLW97QpOVC9bwg==
X-Google-Smtp-Source: AGHT+IHlGxCSXZ3K0ZgeXrKQVug9NCP7NWA7hGL5YQ5uibsBeIfjwehsKYkVMNPiX5pHivrLbNQZNQ==
X-Received: by 2002:a9d:4d17:0:b0:6d9:f653:c164 with SMTP id n23-20020a9d4d17000000b006d9f653c164mr8931950otf.13.1702518103398;
        Wed, 13 Dec 2023 17:41:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t18-20020aa79392000000b006ce2e163776sm10620652pfe.106.2023.12.13.17.41.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:41:42 -0800 (PST)
Message-ID: <657a5d56.a70a0220.2923d.1f8e@mx.google.com>
Date: Wed, 13 Dec 2023 17:41:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-473-gc43d7b7bbe83a
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11
 runs, 1 regressions (v5.10.201-cip41-473-gc43d7b7bbe83a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 01:41:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14080

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11 runs, 1 =
regressions (v5.10.201-cip41-473-gc43d7b7bbe83a)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-473-gc43d7b7bbe83a/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
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


  Details:     https://kernelci.org/test/plan/id/657a50fa2b438c4ad7e1348a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/657a50fa2b=
438c4ad7e1348b
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

