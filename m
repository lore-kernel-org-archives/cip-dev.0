Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04B3C4829A
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 21:14:41 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.1709.1707340477826017576
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 13:14:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=dB6DR9l6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da9c834646so905417b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 13:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707340476; x=1707945276; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LyYv6sSvril6WgxARyjHZkGdFt7RebeuabJJwl9Rr2o=;
        b=dB6DR9l6Z6utJqD5s2hLVrC+ACdOitabbTvo8zOWuWcJw0H3ZnLCS9R3NF7M7ProLy
         /YU7ySCfSrSeeTMPNmHXmyBHtEFs1pwFngN9v00Yy4ZkBSkSke5jLKKI4KK87ichG/WZ
         xGxU7Qrj08pc/bH8BcyV1/QDCUDEYO04ez8FSGxNNMy6brdqNFbmGZo6AbbqOS82RbTR
         HuMEyQiFEoAHfFQGMwF7kU0lAAUjNUGt6d2rUgNuJlyEoZQzltnpEI73dOszAfNBd8CH
         LWwtFQdhwkgtMExEzpuHrUwXWtL7kINMq7NxBeI8nXHMMO6HbbIOqNwBdkgdR8H8Eql/
         SScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340476; x=1707945276;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyYv6sSvril6WgxARyjHZkGdFt7RebeuabJJwl9Rr2o=;
        b=OfVBZf0TRUZfel2hiwf1y1rhXxuSmSUr6wFIAhyk/WYtUy0qJ/9zgPGksJ6NP9jGoU
         /xzYEt01dLXrABInWKjtsP2NPLMWIMToVm1gJtMMU+TLafrrsCwYnacHY23LuyWjnbOz
         IkjbGIbW2cA2KDEpzM9EaAnpWQcHVJKGrz1m2fZBe7i33aRmxaog5XhzWyXChbS2dMVJ
         nFL/16U7GY6Cr4RWLqxKh7EHRbJ+PlHZnkvYTV7Tkku+7O0Osc3JJB7w9bb3dgd4UrPA
         XCENwSIz68mtQGXb7f9gI1UTnst0sTqWoiLLlflkIkHv+h4XQ53Y0UjOn5je34l08ocx
         +J+Q==
X-Gm-Message-State: AOJu0YyYgRoTJSR4eB9j1fGxvkScT9P78juP7hvemLKztMqYSvDvcIzo
	BHXH5/I7xlnHR5E54nUIsNKkOdRll+bAN8SlsgiZZ/l58enDkOxP+qAfvXCoEXSuvVLf60UAf3W
	o9sc=
X-Google-Smtp-Source: AGHT+IFV/MEgTh+o0NYT1RvPEwJERQ5+0ddWa03CGk4EekPUx221oNcyGUbapUQhcCSkW37FtquPLA==
X-Received: by 2002:a05:6a20:e607:b0:19e:8af3:8894 with SMTP id my7-20020a056a20e60700b0019e8af38894mr6328642pzb.0.1707340476678;
        Wed, 07 Feb 2024 13:14:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSoUo9iVS6IDxO2FWdu1f80r+pEvmLw9SEAbQlFqi1ASUQwgJ7jQj648rX3Ll7r1I02QNnDuaOjTQ7QRQQ6MDcvbbMb+tMf3fIvn+W7+aszZB3KtUm9XQhknJ+DlGVhcpyym90anoymIm3e8wuTaKV2A==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u22-20020a056a00125600b006e046a325a4sm2097337pfi.7.2024.02.07.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:14:36 -0800 (PST)
Message-ID: <65c3f2bc.050a0220.ea4c0.70b4@mx.google.com>
Date: Wed, 07 Feb 2024 13:14:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g681701bd9bc1f
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4.302-cip72-1251-g681701bd9bc1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 21:14:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14908

cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4.302-ci=
p72-1251-g681701bd9bc1f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1251-g681701bd9bc1f/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1251-g681701bd9bc1f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      681701bd9bc1f65237982eebce24afcffab64f4f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3de59c11ed27c138e1e8e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c3de59c1=
1ed27c138e1e8f
        failing since 35 days (last pass: v4.4.302-cip72-1187-g657481329b53=
c, first fail: v4.4.302-cip72-1224-ga0ac575eeff8) =

 =20

