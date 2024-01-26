Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD4FC48260
	for <webhook@archiver.kernel.org>; Fri, 26 Jan 2024 06:48:40 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
 by mx.groups.io with SMTP id smtpd.web11.10192.1706251711844170169
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 25 Jan 2024 22:48:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=p2mpU28Q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.41, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-210c535a19bso50976fac.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 25 Jan 2024 22:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706251710; x=1706856510; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R64UFH75RcOZTFJWKxkabr5wJa7miDv5V0y8VOnOEak=;
        b=p2mpU28QIIZbC2tNAhuzpVXvAyma4FrIvGMchlHYBx3wf60GpnnpSqadOYUUXzx0nZ
         2U+2mrBSZ/GQbt+RMT8i1qUjWnnDZgu8XKe3GHIT+KmK0rDxc1BCqLPZ5ZtKfa/RTyfG
         jGCZKRmuMCc4rTdk1TufF5vt/UsXj9s6jiSyqBWA80mQSVhVkgA6xkLsz+Bm3WoH2lDs
         e3gwFo+TVa2P/b3/J8ifrIFFZph7ZW/vjMbf7bwlZcPtr/ejBkcFDrYRkclCSPhqroxK
         sNtMojIupDHYHhhrWjUVZyTe9GrlAkLL9PIEkIeYRJygot4HjTHEpatgk1vGvXgFx/hp
         3mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706251710; x=1706856510;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R64UFH75RcOZTFJWKxkabr5wJa7miDv5V0y8VOnOEak=;
        b=jkZdDhYRnLvcr1lxD8YDYjAN8cBaLogn0cJLs1Bp4M9T7hl0XiX/8bHj3oVZM8HUP2
         MEHglt3gD2czioEVaueYzI9w9e/mWB12hL28oOiVEhn9RB/qgNdEOkF2ftoECvvRIkLe
         A+B+ASKlTezC3mCsSWBvH9t108I/skpmmPT9SKAkOxEfhyJKhlGJpA91FVgt+D4Al17c
         UCxyRtO8/p5WGKPH903eRcD4C6mPX3aMldjvfwZRQ3MTvHJdDfHo2bFX+Gq+UIzUnfEe
         HvSUsIv13Jf08D7G240u7FYFGucTq69KYd2PH+SHe+eKbnG3HO8hbJszF9US/abTyv33
         JScw==
X-Gm-Message-State: AOJu0YxehMoHKII7NWzPa2HzuDT4mbV/CCJ72cDDAN+iHFp+hHKLeZDR
	Ydg4nOkW7CtN+VlGrfyPqxl5Am8dcDrLyjvNTJGoQgyLwKuN4sj3HD3AYsaxsOgP1GHwvNWBH3n
	DlME=
X-Google-Smtp-Source: AGHT+IGsycDEmoANQ6KZg+JmYRIf7pHXGciNqs1lyNuNfovt29C+K6gXZy5pJopjwFNVh/9pVUfVaQ==
X-Received: by 2002:a05:6870:d60b:b0:210:cdfd:f5f6 with SMTP id a11-20020a056870d60b00b00210cdfdf5f6mr931566oaq.100.1706251710503;
        Thu, 25 Jan 2024 22:48:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a2-20020a654182000000b005d748902a01sm449597pgq.43.2024.01.25.22.48.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 22:48:29 -0800 (PST)
Message-ID: <65b355bd.650a0220.98756.1139@mx.google.com>
Date: Thu, 25 Jan 2024 22:48:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.304-cip106-176-g770d0422c72e9
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-mm: 6 runs,
 1 regressions (v4.19.304-cip106-176-g770d0422c72e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jan 2024 06:48:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14467

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-mm: 6 runs, 1 regressions (v=
4.19.304-cip106-176-g770d0422c72e9)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.304-cip106-176-g770d0422c72e9/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.304-cip106-176-g770d0422c72e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      770d0422c72e9acab17684ec2bbff7bc9a09b1a4

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65b347f316b03ef9fb52a450

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/x86_64/x86_64_defconfig+x8=
6-board/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/x86_64/x86_64_defconfig+x8=
6-board/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65b347f316b03ef9fb52a451
        failing since 10 days (last pass: v4.19.299-cip105-289-gad0914f265a=
f, first fail: v4.19.304-cip106-27-gf3e967c370d44) =

 =20

