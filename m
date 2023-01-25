Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7FFC27C76
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 04:24:04 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.37974.1674620637439141587
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 20:23:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=NKq3DCvC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so801918pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 20:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dBOZ4nJbgR5zhJPJuJi3SfO7qnY333hGyANFZcnnXyA=;
        b=NKq3DCvCJ808B7nETfotd2kBf2wj2WW7ZmBz3KMivp6HfXmkGHsCMkWyavmonQ0xIY
         VvtujFNdmKlCECflYU9ZWXSRCanyRw6uDehtLBb/yPRtW+T13wibesefwSWs9Rxc7oAo
         0hrja3QaPXma2AG83pz4jb5zhbnxvHfbYl1Sx/HtfxjgqiEqrym3XCNcRGgvbkYX2d3G
         t3VdpKJE9oNTc5P11PDnxBP1NAc6gF3tBnD/z9PBVMciNVU+0bIN5A94sjS+6/qxvlQ4
         HSafBUpJF+9r87XDZF6TDp5N2EutMENnaM5pKRUd0CG3xKvw5oo3BTm04DR4t1QbcMW7
         Is7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBOZ4nJbgR5zhJPJuJi3SfO7qnY333hGyANFZcnnXyA=;
        b=L3VvY9yt7XdoKdvCFOphYOk7WJjoLN3BIgP7D9UccER4MjzpCA4yHAeVcLNeSloH4s
         5DWgONIoYxXGyk9N7Q/VRJUvMaqk/ahOXjYbcDoS2+F1BWWhH++59LQFEgKcMFsq0AW0
         T9Qmm98njGpygYIz7qdjCkQvwsgsIO/YQ52j2QmhretI5hbH0pALqBQj4DCGvQwWcNUN
         t2aDSjQ8zY3+/iIB7DPsr9D/gqvACnt35OC8LkmEC2O6NqnbiY7EkKSKWBW7eF71lDVV
         UPVRmlVDU7kjfj1D4YM6W8HBDj7cT2+WEskFmGDriTKYKTTFeJtzxCNflZ4Z7bNmzyAt
         moQA==
X-Gm-Message-State: AFqh2krIBRqsVG8GUpexazxTKmCZAz5/Puiymmqag0PgVe8vxUWBFYJR
	FJg5w6hQoDKY4FGQP3efTbdf7fLqPeCHA4cVVQo=
X-Google-Smtp-Source: AMrXdXs+D2x6LLMIHt5xGphPTbSrZRuWGUZbfGpH07u8kr6hVbJoFyjls5iSQ+b51FvaU6mXqrcmUw==
X-Received: by 2002:a17:902:e5c9:b0:194:d0ad:53f0 with SMTP id u9-20020a170902e5c900b00194d0ad53f0mr28208291plf.9.1674620636278;
        Tue, 24 Jan 2023 20:23:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001769e6d4fafsm2509358plf.57.2023.01.24.20.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:23:55 -0800 (PST)
Message-ID: <63d0aedb.170a0220.ee0d2.50f7@mx.google.com>
Date: Tue, 24 Jan 2023 20:23:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71-590-g22fc523bf881
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip71-590-g22fc523bf881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jan 2023 04:24:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10479

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip71-590-g22f=
c523bf881)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71-590-g22fc523bf881/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71-590-g22fc523bf881
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      22fc523bf88173aa7805c4360b6581696228b140

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  d042c168dd037bb0128b86ee4ac4f5c526eddc7b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d098463456ff050b915ed0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63d098463456ff050b915e=
d1
        failing since 194 days (last pass: v4.4.302-cip69-296-g52de9431d314=
, first fail: v4.4.302-cip69-508-gd887d54a1be6) =

 =20

