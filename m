Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DD3C636D3
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 13:24:54 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.11505.1675171491692080295
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 05:24:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=LSFaMXjt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id j5so14175302pjn.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 05:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QZK7Hqg5hzbIswiPqfWVs4bPWkHkpJcjL/1MS/zzDaQ=;
        b=LSFaMXjtBA8BVT9QqWtPvlrXGwm53Sz4LdHasxc1PsvzQK6vdSQLv62E+xZndDq3hr
         ENO8pZKqSNZH2p19K5sWdhNVDu5pVJane6ezT0Uo+EYG6+PLkxDGW+XHaMpfNCm5clC+
         FFAc9ZU2XPl1SzfmBjAn+QvhoMMRL8qAFzMAxo7JnwXgGib4Sm33EkxjbgesVpZcoMKH
         /i2a5VYg+rfvXWv3IvSTd0xInxPj/G5uzZHRIluM5dNWSiZ+fDjJtg33wcwq5wQf5Uks
         P58/ptMsKj2vHeK23MBAilcxBLLHt+GRnCDpI2XgZc/q9pt5d5Oey+Pf/AeAfEchf2B/
         tsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZK7Hqg5hzbIswiPqfWVs4bPWkHkpJcjL/1MS/zzDaQ=;
        b=ExCi+OX2bE/2XWe1KOvheQcBJSorcfQ1D0N53Mm4VELSLTwJi6nMimCe5gBNliccv/
         94jadjkxH3FluTphatGujjNlxqNIAwpacl1xAUDwKRToB26BHhvrPHub7tTQCVeyDvuK
         RDR9i947hlsp8+ffIr8FqYGps+e3YaPX+5xTWD1yzimxbZfarrHDPIfNx89WEMksIoND
         A34JxGy0npRioAFeezDiGyESVJI6MpuFvpLcKQdLbUW9ojqvH9/rsOJOCaD8Cb8CqKWY
         zLcArPKzto0hjno+3XIzyNfWqlVBIRgFNOHavNZ2uHrqRuzvxeOfiXCXD9vypcGHS5Zi
         jdzA==
X-Gm-Message-State: AO0yUKUVI5pGNWMqBlFfMWY6YfxtlpqTH6ruIIpIAZVuVZ7HsDm/5r5t
	N0pXJsCYJxOziHDmNiJXpqKnnDYXuaZOJ37yBnKwkA==
X-Google-Smtp-Source: AK7set9eJFA+s15k6Gdvc7jwkONXkwC+JmFQ2RgxsH+bWLZdMJbGNIQz7rr0gXWWWyb28SIk9SVSvw==
X-Received: by 2002:a17:90b:4b45:b0:22c:216e:16df with SMTP id mi5-20020a17090b4b4500b0022c216e16dfmr21254531pjb.49.1675171491074;
        Tue, 31 Jan 2023 05:24:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm3944069pgd.76.2023.01.31.05.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:24:50 -0800 (PST)
Message-ID: <63d916a2.630a0220.a85d5.6d21@mx.google.com>
Date: Tue, 31 Jan 2023 05:24:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip72
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip ltp-pty: 2 runs, 1 regressions (v4.4.302-cip72)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 13:24:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10532

cip/linux-4.4.y-cip ltp-pty: 2 runs, 1 regressions (v4.4.302-cip72)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0af99ca381ce97af181eab7f6fc808b1e039ac3d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d909ddcde19bde66915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-as=
us-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-as=
us-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63d909ddcde19bde66915e=
bb
        failing since 200 days (last pass: v4.4.302-cip69-296-g52de9431d314=
, first fail: v4.4.302-cip69-508-gd887d54a1be6) =

 =20

