Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9A6C43219
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 13:19:15 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web08.23373.1664975947213242235
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Oct 2022 06:19:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=syfusUwv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id i6so15823070pfb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Oct 2022 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Tan6KZWOQBPsGixbDlCjcILxKBNpinNm1CbJJA4Yiwk=;
        b=syfusUwviorwqcjJVylkYtXmNYotCTBx4WhWgzTkfK9jFFa8gEtS6dd8nuuXIQ7GAN
         nP5A64//b+NcXve328ZhStFRvC0ZRZaNBM6c0GHAJd6Gv2XJpX+OFK6/EnEHZIQBWF69
         YdGw5lGnvv1UlEyaAbnDnwA/d6PDMvhSEhbRfcATdxzm0Gr+YvenfkrdmlYy/Pcsu4ZW
         0nyU1mHqc3loZDfUhKBFq7++SNi486U4JYk9xl06BEiLfV/uHyw1yTPrMQWwqJyremod
         gOgnDwkIGparpWKQnvOzzHTTotKbXmJE5naBKDJBorTVCluuUbFcM0EzB+uqdGXvi4PT
         KyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Tan6KZWOQBPsGixbDlCjcILxKBNpinNm1CbJJA4Yiwk=;
        b=RgFVJPuiSxKqrzJKVvM+3NzgJCUk+SV3RA+tlAp5LMNpDYCAbagyT7nMgcWLhN7R5C
         UEfKQ4PA+F2e3udOWvx9OAAd6DZWxHmZCmmDfmOts6Ev6feCw+6FQprDGE1FzjvFIG7y
         x6wPo7Ap3wUu6FyIwakl9MJI6PLGh8LhU/Hl53nh7BihSd6DluVQOAgJ0uK5o4GPFgYX
         mJAtUtF10X4jONpKwsCv50WpTvgc+ohD8UtjSVEbg226N1PqbR5Rmjl3UhrzEmgZSJq6
         wgKNcVhGtshX7Ed/FVOwQZEqDj5q7mwlGYgF1mJwKVOZOmmgj78E68gbcko0NZzFs4Fx
         sAcw==
X-Gm-Message-State: ACrzQf0Xh4VO64yQtecJKUNA3FZHtzVCnF+v4m1GMZ16bVHJBLUQ5NG9
	lMhQ5GQluugUpwFVs5uQ/zY69tv6YsqP9c21grs=
X-Google-Smtp-Source: 
 AMsMyM7My/f6EcY8P+UmNsuZmp+t6SO5ojwr8Pxjs7DQweZ/3b1ine6HFWw5dq19izIiUa7YrSNdgA==
X-Received: by 2002:a05:6a00:234d:b0:561:f0c3:cde1 with SMTP id
 j13-20020a056a00234d00b00561f0c3cde1mr5773295pfj.34.1664975946531;
        Wed, 05 Oct 2022 06:19:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 21-20020a170902c11500b0017eea4a3979sm6133613pli.154.2022.10.05.06.19.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:19:05 -0700 (PDT)
Message-ID: <633d8449.170a0220.d7a35.adf4@mx.google.com>
Date: Wed, 05 Oct 2022 06:19:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-192-gbe875d9d93504
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9
 runs, 1 regressions (v5.10.145-cip17-192-gbe875d9d93504)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 13:19:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9647

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9 runs, 1=
 regressions (v5.10.145-cip17-192-gbe875d9d93504)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-192-gbe875d9d93504/plan/kselfte=
st-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-192-gbe875d9d93504
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      be875d9d93504a4ac9c5dfc8d0bed7cc4197ab75 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/633d72eeafde2f9d07cab5ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/arm64/defconfig/gcc-10/lab-=
cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/arm64/defconfig/gcc-10/lab-=
cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/633d72ee=
afde2f9d07cab5ed
        new failure (last pass: v5.10.145-cip17-140-g62223aebb3a92) =

 =20

