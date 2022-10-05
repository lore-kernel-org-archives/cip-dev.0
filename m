Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516F9C43217
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 13:19:15 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web09.23534.1664975946994828816
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Oct 2022 06:19:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=V6uHTXcI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id c7so15229810pgt.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Oct 2022 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=bi72GRKCG/6olMYb+9g1yfQFY4WFZPSSP3hB0SsDTmY=;
        b=V6uHTXcIbNjWLU0d8Ha9TPrM8pIJeSuIpHDM+UpT7zDomahVB3crq54fa+4OFm8mYg
         vyCfjqN4FFvhYIrVfdpwm1+PeNBFAyhSWCZTjcReHhT8UnIKCC9g0Bh9efMVFTsWd+5S
         kj2KRx76AGHWgnGoZOSpPk/AZNNCmTjfHW717e50s3HoONcCdNlT+gpFNGCc1WoNlyLL
         ZCUfCX2xQ7CRZ+naMdxc38SCr2J03tc4jd4rvGgedXhBG2R0TlIDgJCbSD99jfy6HloZ
         JPPdSW7n8PH6LU6E2L95DqtMAUlXKWjF0nrO22Y7F5BlJMP6w3WsAXlD5jHX0lIBUNVP
         j9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=bi72GRKCG/6olMYb+9g1yfQFY4WFZPSSP3hB0SsDTmY=;
        b=YeuMSPO4uToClhwrAmFFsr1EBO/jU2p+oGKaJI5q/Mk0m3KWWwVrPDrkDwVlzYw8Wm
         HEh+9mdNy0J1bh85ZTk7N8ruBpQRNm83uy0jI1XUKx8KcPrPmKiKN56da+iJeHM5Hd+s
         RJ6C925UNB0NOgUTEV9mPF6dn8RU3coHy60IIu/ZCJEsYCNrDpBqYbNxKyMeiWQCZZOM
         B9XU+68WCjNQjxz5SGAyGR75sHJGozGE1OrvjD7AzHtUytmCT+iq0I21j2jsVkmfTVkJ
         D2mLPKTUP8Es8f6vLh+5M37DfhVkFxwUyp9Pm+BWBd65+kjgNzV+29aZe6kLs+YRVSk1
         Fu/Q==
X-Gm-Message-State: ACrzQf0+p1zwlNYN9m+zVT6g7WIhJBKwnUwKH91S6dm8EP9GsGeqYkph
	uvzq8NMzj0G0DYF8Jt68Byk3x719khnKAKl6dM4=
X-Google-Smtp-Source: 
 AMsMyM4W7XjmdxsECArrS8hXMciWmJ8WpVELHslQN8rDO5NW0bRMnZeEXaL1eEnjhKj/Tcv87D61Kw==
X-Received: by 2002:a05:6a00:1496:b0:546:2856:6cf5 with SMTP id
 v22-20020a056a00149600b0054628566cf5mr31841704pfu.31.1664975946238;
        Wed, 05 Oct 2022 06:19:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q4-20020a17090311c400b001750361f430sm10520630plh.155.2022.10.05.06.19.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:19:05 -0700 (PDT)
Message-ID: <633d8449.170a0220.49c28.2e28@mx.google.com>
Date: Wed, 05 Oct 2022 06:19:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-192-gbe875d9d93504
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 7 runs,
 1 regressions (v5.10.145-cip17-192-gbe875d9d93504)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 13:19:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9646

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 7 runs, 1 regre=
ssions (v5.10.145-cip17-192-gbe875d9d93504)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-192-gbe875d9d93504/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-192-gbe875d9d93504
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      be875d9d93504a4ac9c5dfc8d0bed7cc4197ab75 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633d788a5fb0af02ebcab611

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/633d788a5fb0af=
02ebcab612
        new failure (last pass: v5.10.140-cip16-261-g8fa62effa305f) =

 =20

