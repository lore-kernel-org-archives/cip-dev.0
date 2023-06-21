Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5E6EB64D8
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 20:03:39 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.88.1687377812402528809
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 13:03:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=zuhN00HQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso3106475b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687377811; x=1689969811;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2oQ6Gi2fGbVi5cZFDvAfzcx4gZPLYSSOdTLM9FHIpKM=;
        b=zuhN00HQkA/VZmwtOxkgnAA3SBoLeYo6HVJTAu/G6B7Ry4xV/wrBjMfZy1+I0tolX3
         bPZQ6zVBZNDg+tTq4xkFhhzDmJqFWosTcMb/HrmnHhFMErA3B5kBjOJK+3M7MGUMDju5
         Cq9OutGYqA9TRGQ8XeUKzK/DipT94ezSw0WvKxq90Qt8hcfKggflFOP/SzkUy0B6FQpk
         1qxCG01itGbmQSnN/YD70kO00tYlR00ZMcQUnKG8n8U8p2hRXLFWydhb0OM8A5AoM8/T
         FAkC7WuyMFMx/hABFczbO3hrhwuEMgXaZxcIuhyOLDFPeTtuWMuUHByN8WqeiLBd7Uuw
         GneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377811; x=1689969811;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oQ6Gi2fGbVi5cZFDvAfzcx4gZPLYSSOdTLM9FHIpKM=;
        b=Z0oueGU4OqBAvvkbzhh+wD289wKMy6DdPJHolbSgVJNszNkpzdMW+JSt1yYhzZBKR0
         mLin5zp98wZnPdkACL3t769Em8ilFbkRlSpaUbh8lfhIQzL0+cxgReDQGIYr3U5LeDNu
         6ojglc9wUc0dJrV471aezmlXkqNjJM0f4FZ+n8z5cHAQ0ZGoFBMlpkdkxh02x/ml+lNp
         U2UYVhq0MtNthakuOAbgdmCQwEdKv7itQQCvV9Dk54SQydog5bIjDcMjq45r46O/bmqU
         MS+T4EezoB7hKD/CdwuSAm5YWTbpcYtbQ7uQga7k/lT6Ci8ejQVF+X3LeUyBv80f78Dl
         sdlw==
X-Gm-Message-State: AC+VfDyl8Aw2psI/xfRgtzeS2MawV7DMzAAKc9VSvKC7qwe5Dzdppwlv
	PA+vP/PrbdCeszijz6TteKJhBPeTIylopSc4euDhrQ==
X-Google-Smtp-Source: ACHHUZ6q/aEfN7MMtdAKZ+CyS2+TvI1KNEUWyQoRViWHIkVLkZMsvQL80m/6E0dodr7xvt8Vj/vPyQ==
X-Received: by 2002:a05:6a20:840f:b0:112:5404:88cd with SMTP id c15-20020a056a20840f00b00112540488cdmr14078361pzd.60.1687377811349;
        Wed, 21 Jun 2023 13:03:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902740900b001b54a88e6adsm3832438pll.309.2023.06.21.13.03.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Message-ID: <6493578f.170a0220.b064f.907d@mx.google.com>
Date: Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-289-g3c0549540706
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs,
 1 regressions (v5.10.182-cip35-289-g3c0549540706)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 20:03:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12102

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 1 regre=
ssions (v5.10.182-cip35-289-g3c0549540706)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-289-g3c0549540706/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-289-g3c0549540706
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c0549540706be602c1cc58f7ebdcae39509baa7 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649341b43ce7bcbe6e30616b

  Results:     37 PASS, 17 FAIL, 17 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_HEAP_SIZE_FROM_sh: https://kernelci.org/=
test/case/id/649341b43ce7bcbe6e306175
        failing since 7 days (last pass: v5.10.182-cip35-8-gc3d08808cfa7, f=
irst fail: v5.10.182-cip35-191-gf4efde512959) =

 =20

