X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.31357.1650901720020261367
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 08:48:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=tyW/X6oK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso6297830pjj.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=kh2KceaPDoNyysntZRqYtPWVuwxjZ0NNQXGmBdNFZsk=;
        b=tyW/X6oKf4quUiU2bcRzfjUC+mw+NTxLpmANHefPC9OvCs7QXcORSJ+NXz6IRh/NpW
         aWtZ+t5kLBtLTez3jjvCUmoulBMj+zX4xprtYBjGbaheVE9jLGHJhdH78iJzt37vl6Kj
         mvKaiYq4VkwTuZuRhv6lC2a3TAmZxUxcRZBNfwxzWbTGE76vkeGw3QKTlktyDSxvjfpk
         4ouFuv09gCx2NM4t8x+LRuvRUwcNFqjCcnm0i999+O75w9NYs6Z/w+vMWRVxSuArr5s6
         r8loi/ulzgb5eYziUorCRC+q+i6iIwAwVVemOs6aHpUdR7o/ScYK0D52JoPJA46at4Tj
         BKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=kh2KceaPDoNyysntZRqYtPWVuwxjZ0NNQXGmBdNFZsk=;
        b=J0kn9b664x4YDp75u6ZroEhj1A4wPibS+07YGqsOBRixQX7TkGWMrzD4n52M2DQACu
         yAlDKQNKZP0y+9lAuaZxywplBgO3Z9Cu6XPZCiMMQl88fV0/vXpKEwIhlfOFoOvPITir
         D1lX1oWkMWLdotDLmZYLThrXbh+bNxMRwe+3KjHDeQvXNFkDLYTPvcsJpl4ja7cQl7fZ
         ASmzalVzBgE6oqmX/AuIyfQ9/MP3IuZyXxUkFclC8zR4dJWA+/LFNvCExxXtaYOj21gb
         hHHZpvqMxKNgBWRD2TNjIIMvFF/i3PYYScOQhZKPas1LQjiQjKdEAscLhkSbcJbWER39
         ldUg==
X-Gm-Message-State: AOAM533CKvt8iX9fgj/IJr6uVt9/T8QdfC3tc1ayp1gBZZ473LKjp4zS
	Kw4Uf2X21QJVV1WaoaTxMYslLRIgyUNqvfk/51g=
X-Google-Smtp-Source: ABdhPJy3iH9Vgv5AzE/4Ktd62Dz/ugHKdUlKutj2GR/uMW587q1kKGPJnCBOdXI6uN0qE3u6sBSqyA==
X-Received: by 2002:a17:90b:3847:b0:1d1:16bb:83ba with SMTP id nl7-20020a17090b384700b001d116bb83bamr32581859pjb.216.1650901719505;
        Mon, 25 Apr 2022 08:48:39 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b00505f75651e7sm11690586pfm.158.2022.04.25.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:48:39 -0700 (PDT)
Message-ID: <6266c2d7.1c69fb81.6a419.c4ff@mx.google.com>
Date: Mon, 25 Apr 2022 08:48:39 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.112-cip6
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-timers: 9 runs, 1 regressions (v5.10.112-cip6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-timers: 9 runs, 1 regressions (v5.10.112-cip6)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.112-cip6/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.112-cip6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8f6747dcd02a8f87731c324f4bc37bd120a8982

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  4e132c1f9e14f9eaeb4f9875eee3f97a4a1ac987 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266b5b7fe104f7279ff9463

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-timer=
s-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-timer=
s-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6266b5b7fe104f7279f=
f9464
        failing since 11 days (last pass: v5.10.106-cip4-66-gc8c4cc5cdb54c,=
 first fail: v5.10.109-cip5) =

 =20

