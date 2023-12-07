Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C1EC10F07
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:02:07 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.84312.1701957719590493087
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:01:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=2JjqLLg/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so291219b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 06:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701957718; x=1702562518; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZFFkRNBWgvJRZhV04r3vpflXjFqOpMlm1lxwAXUy/8=;
        b=2JjqLLg/Qs5Ssip5lj31gIbtxeAG3W/DaZoVAnmvxcakNW3qjb/M1KB6svGTEoQfHB
         iXeJdKhPJjSLhm6q0GSfMXB8+6cn5owXtQ8ZMP6Jo8AHexTAHkIkgYvXjxYRW6+YJMdj
         vnq9rP453DPZOmP1jMrOX8xvSTdN/jOwt0JtyP0QpnhU1sQnkMK7nTK0GEtipL4VkSV4
         8bUD5yt1MvSNkEr4cnJYdajsY8KgKa77xV2LA0tlBNpGc6829kmXNnzdleprslED0+g9
         AQhqYbg8lvU6hgusAw7YllZZwwugqNBozJzz/n2UYdMiSeebHlktx7QHCITa+bqgbAxX
         iI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957718; x=1702562518;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZFFkRNBWgvJRZhV04r3vpflXjFqOpMlm1lxwAXUy/8=;
        b=u+0xkK9Y0W672xMWkVwycSOAIlB2s9xfhULW0U30rUG7wM4gJyF/7LgTEfCLVckEnc
         07VnFaJOntXjQXTZvgBusAKEf4HGYGEkXtyJUiSCE9MLDcXcEjDglyEODK7abhMv7lOI
         EPBtD/OTyI/RCecuLpq6IVTBGcfcoaza/cdnJE/9GYPC/1oKocKU6dS7S5NMw6rkaOtk
         MboKDTdz+lKEjsxBRcK/MnujYPMQZhtn2jPkoTWqmvSHbk9AmTEi6nybFSF0gTUWvNxi
         DzvD7XN7d0KTmfoIVbaDvjsMWCgS3U77dVbYtQzPUiCmi5vujJNRLj9vOBF0L66XWB1n
         b98A==
X-Gm-Message-State: AOJu0YzhSn04Dtl57pGUmxiY8ZdhqfdqST6W64o0bpNJb1RCDKtKqe6n
	hSHybJeoNxxQ2HB0KHvFnBA+vnfvG2RhIJ41gm0Ayg==
X-Google-Smtp-Source: AGHT+IHuOe8qs01LL644gMVIJeivLyYxdljchT5Yx/gIQbh71Sahko72sudJ7yy8QTR0oSxKR5P0nw==
X-Received: by 2002:a05:6a00:181b:b0:6ce:6ac3:91e8 with SMTP id y27-20020a056a00181b00b006ce6ac391e8mr5911105pfa.20.1701957718449;
        Thu, 07 Dec 2023 06:01:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gu19-20020a056a004e5300b006ce6e431292sm1334375pfb.38.2023.12.07.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Message-ID: <6571d053.050a0220.74088.3332@mx.google.com>
Date: Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13866

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.201-cip4=
1-16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bf7faa9ba167e6e134d0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6571bf7faa9ba1=
67e6e134d1
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

