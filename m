Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70379C4829E
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 04:58:29 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web11.13753.1707281900785179257
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 20:58:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=0R2AMMi3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.51, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2193ccbb885so130334fac.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 20:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707281899; x=1707886699; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sr2WIUZmtI/JVc8f2G4TjOvWKx6Nv1c44XezHzmQHck=;
        b=0R2AMMi3r32EPY75dBwYVV9ZMLP4Z+THphnFDGwsxeGd8HYxN/bE6AGeILuGD/gLGO
         GykxJQX5ae2MVGzpDnAJQRExU9b1mejpXEgt/FEcar6BTC8KbdBp1Nds+llb9rmI2Cpm
         BVmI/oEuJzKaWxfGeDdshaGmLc6Xy8FMZDuvyy2RjZ5Rk3Gu3wmJU0uAzfNHAytFjBaH
         zK75Mi1oOjnXzIHikpk13sU4AIab5VKe3voQRnzoXUBvKcR72q7Et/5RO4v8292zeHp6
         IRuFBVQxrDIbPagFVTIK4f6dnvxfpgyjke5ebMAfvMoEHEl+57jRJyYHqVdH3hpmedc8
         KbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707281899; x=1707886699;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sr2WIUZmtI/JVc8f2G4TjOvWKx6Nv1c44XezHzmQHck=;
        b=HWcyEguHAo71XoA9db8V+nmAnjDOY517YHlFPazDittMxBlnHo87PK0xVnY1CV8gWl
         egwaK7FiYpK8aGggUq8y5dMUIXREHkfGDhkDj17lddWmDBQqt5RGFz+pLVm+PqnXFgAH
         FCj9FQ9Ov2QsG+ZoY00h78YsgTZLXiJlMXwfIfBscGSQq4HdFDTmvwuau2sKiko/9c3G
         GjMIJ9A9OkDHClqgtMdxvlG/8DORbYCLgjuLgiy/Q/XTwhq2aB13PEtPASfAjRlan7i6
         7WIbnWDuc53Hja2nSHk3Cjk06nc2phb9aPrO7SgQqhWszEZtjuRGV6PCdIjmgWzBuXaK
         f3zw==
X-Gm-Message-State: AOJu0YwQod5PlUyWlE0J1I3eHzNXBfKMeBb4YRiz7VHkQaitvHHv29FN
	k8GOJSaQLvl/N0KVpLzJ60XzhweG4nXPxjhB4LFzyWjHigFprtcu2iMgidKVzyPEWcc6kgCVk03
	e
X-Google-Smtp-Source: AGHT+IGTJcXJT24oID1aM3lxmQoW55SFVgpQYwGHsAz1QORqHJqTPcq4dokrW9qOmct09o0XKaDxnw==
X-Received: by 2002:a05:6358:7e4a:b0:176:4b1a:8364 with SMTP id p10-20020a0563587e4a00b001764b1a8364mr1689903rwm.21.1707281899446;
        Tue, 06 Feb 2024 20:58:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c22-20020a637256000000b005d8b59f1b29sm400954pgn.92.2024.02.06.20.58.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:58:18 -0800 (PST)
Message-ID: <65c30dea.630a0220.d6ff4.10fb@mx.google.com>
Date: Tue, 06 Feb 2024 20:58:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-g39ff255b75f5
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs,
 3 regressions (v4.4.302-cip72-1250-g39ff255b75f5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 04:58:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14862

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip=
72-1250-g39ff255b75f5)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1250-g39ff255b75f5/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1250-g39ff255b75f5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      39ff255b75f5caee714b345c0c47b1c44b88dbe0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa6ea5ba8b72d08e1e92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c2fa6ea5ba8b72d08e1e=
93
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb2cfc538e240c8e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c2fb2cfc538e240c8e1e=
7a
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb6037abb73bc18e1ea4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c2fb6037abb73bc18e1e=
a5
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =20

