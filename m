Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6766AC46CA2
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:50:48 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.22459.1702561840818028927
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:50:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=SOfPfMRZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d04c097e34so5139705ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 05:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702561840; x=1703166640; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WQFb/Q2GQDBLNgIJUSGaa1ShZVSIDonW0QszEqGlq9g=;
        b=SOfPfMRZLnybXHH7Gi3o50lqUxNFGNCgj74ccu3wte+PnnAygM0eX96zBMnWFVr9bW
         p9o5VxQwhju74GPpST1zv6vztvH/tq93qqIdPBuVi0ABhVAs32Hd8DdMzZaxO+xkaFb4
         OV3zZDqTXUY9O8g0/LbRsqp6p4N+f1ndhPFRTmJtF7QRZ6WAexmAZS12LfmL2NBEy+1w
         iBuGsh/7qsJMHVkQbuTOcC6O/wXrY5QzJQCfKMqf5VZdJUUHaAlLM7dTiLt/DlOYQzb6
         KROiVfAr/bvjPqLtSOX3iV41gp0Lvej9+HHXRGco0mhdROHjbYLuxjpGbFDV/HeKh2TM
         O6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561840; x=1703166640;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQFb/Q2GQDBLNgIJUSGaa1ShZVSIDonW0QszEqGlq9g=;
        b=sSTpBdZvYdZguqA39lYTFVwvz145Y7gn7qQd6I5xyWHprLTZh/fdXuNxkzU0DH2FQJ
         fwUdFNIXHa/bzfA2b7RCJ2hwRHxjVYjY97FNuN9Cl+3HFOk3VLF9DfhyySp10pbsduZI
         4V8YOV/E9f3g6oAq9vLlakXa00OBLT6Qp0M/bq6yQRFvJaS8ZpnbYHnZVHVx6mwX39lv
         YbNddFOTHzkpdasMAE+bMdw96zuUA7OWDNW0jTkNazReNglatUfFkNPyW9CONeSu12lW
         DkdoZKYALKkJwVXL08umroW1UhOKu7MFnU+AREqtEI7+0QNXmd0tuv2sN1eoFHY3UvL3
         bm4A==
X-Gm-Message-State: AOJu0YwW4N6Kz98wm4T8JAyaRyM+XACXe/Hw8niNYW+iX3VEvZH0k7vE
	zFVRP6/psliKCsPCXTpETByADkeyMq4Dsq745A80tw==
X-Google-Smtp-Source: AGHT+IFw92uGBofYf/bBm2/sJadhd5EfnTUKRJdzi8qS6Npxf+HBjZpfTy4d9m+nd6/8qvi9NMoJxg==
X-Received: by 2002:a17:902:e54f:b0:1d3:45b7:bc1c with SMTP id n15-20020a170902e54f00b001d345b7bc1cmr4980457plf.64.1702561839740;
        Thu, 14 Dec 2023 05:50:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y8-20020a170902b48800b001bf11cf2e21sm12391370plr.210.2023.12.14.05.50.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:36 -0800 (PST)
Message-ID: <657b082c.170a0220.db9ab.6042@mx.google.com>
Date: Thu, 14 Dec 2023 05:50:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs,
 1 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:50:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14106

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs, 1 reg=
ressions (v5.10.201-cip41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-69-g8f7b450fc28ed/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657af344c037e04611e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/657af344c037=
e04611e13476
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

