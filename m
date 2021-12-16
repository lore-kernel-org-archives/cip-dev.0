Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFF0C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 05:59:15 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web08.6635.1639634352960369565
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 21:59:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=HCMPDUN0;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.45,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f45.google.com with SMTP id
 47-20020a9d0332000000b005798ac20d72so27715847otv.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 21:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5KS01B7YqRM1Fa9soPkae6JWTUUTMARKOsS8HLKmY7U=;
        b=HCMPDUN0YQInlH1RAyicWCxanxezfgTa4FLa02rtAEoyFF2FgrrSDk/+STg0Du21hJ
         luFWtNMndIF2qQAFpVAmeDw7U8jYyufOXH0/NkTLH9h8yqG7/4ni4u1wpXyYEKSqCz1l
         MeYEsjBxehnaIwx+FL3A0R6GyP3LaCos4ZIWo7KIiDXJi4FgW6RwuJ87Yv3Du7FH/M1E
         0la2MpXejhMxrycRoxNTFu64KsnbdsY4+Ei9hVu3NwPRwtnSb6OZsjgRPZEt5h5BLc2h
         NFnraRQmK3VQtvrUM4TQDNrSoebLkNG5GMIktcdRS8xwhHmjKPthGU6Qj106c4oUJh86
         Igew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=5KS01B7YqRM1Fa9soPkae6JWTUUTMARKOsS8HLKmY7U=;
        b=otH32I9yzwvyfPLxakj1JoNovYys0Gkv2DVUZRQKKChgNnforxD6brQ7qqndAj1jDG
         vhMJzfJZY5F7d7UqMXq9+ak/4Kajl5U7A7rm+twiE1gmzwVDcn+PAkwdZNKifCG8ps2m
         PmFvMdiSfKoQphZFgxeHTXvb4U4sXSMrPz+g/BmjE+psQOS42rGUS8Wo5XprIpW3SjTh
         nTEOxE6U/t4d9/Qk1Qy958FfWozbKnxAwTgzzQ8H9SKHgGj8v+lOws3lS51vcqS+Q+cV
         TvFOoAzxzIQvxFUojEWgFvWwcdRFB0eWn8wfp5m7aVQKEjub4TRlGgltVvBujtmyH9Hy
         dg9w==
X-Gm-Message-State: AOAM531SUhzTjn/Pa5XmRdGGqfgkQ2Lzzj1ytvQrKat9n3S7oOTF0Qz0
	kQG6lEFsrFN2fXQBb7YYBRpPkSFhh/CpQGIU1i35WPDn/wY=
X-Google-Smtp-Source: 
 ABdhPJzhiTM84Z8KMuYpNPKS1T35qnHjbfl5e2PeKCgmHBGre09u/lFUTWgu11ALzkwbkBMPS0toA16qwzh3reO2MdI=
X-Received: by 2002:a9d:5ccc:: with SMTP id r12mr11389168oti.67.1639634351770;
 Wed, 15 Dec 2021 21:59:11 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAODzB9rdc7X0n9nEi9JKzQmjuVbreaosKpHcn7YYpyGPSWkPQg@mail.gmail.com>
 <TYAPR01MB62525566919A2925279299FD92779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB62525566919A2925279299FD92779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Dec 2021 14:58:36 +0900
Message-ID: 
 <CAODzB9pFnCDhGy0tLpAhP+AVW28_9FiES2_UvX4nxPCapN4ESw@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 05:59:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7115

Hi !

On Thu, Dec 16, 2021 at 2:27 PM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> Hi,
>
> > CVE-2021-39648: usb: gadget: configfs: Fix use-after-free issue with ud=
c_name
> >
> > CVSS v3 score is not provided
> >
> > 4.4 kernel gadget_dev_desc_UDC_show() is bit different from later
> > kernel versions. However, it looks 4.4 also has same issue.
> >
> > Fixed status
> >
> > mainline: [64e6bbfff52db4bf6785fab9cffab850b2de6870]
> > stable/4.14: [6766064c794afeacc29b21fc09ea4dbe3cae1af3]
> > stable/4.19: [83b74059fdf1c4fa6ed261725e6f301552ad23f7]
> > stable/4.9: [225330e682fa9aaa152287b49dea1ce50fbe0a92]
> > stable/5.10: [a4b202cba3ab1a7a8b1ca92603931fba5e2032c3]
> > stable/5.4: [bcffe2de9dde74174805d5f56a990353e33b8072]
>
> I created a patch which revise this issue. I attached this mail.
>

Thank you. LGTM !

> Best regards,
>   Nobuhiro
> ________________________________________
> =E5=B7=AE=E5=87=BA=E4=BA=BA: cip-dev@lists.cip-project.org <cip-dev@lists=
.cip-project.org> =E3=81=8C Masami Ichikawa <masami.ichikawa@miraclelinux.c=
om> =E3=81=AE=E4=BB=A3=E7=90=86=E3=81=A7=E9=80=81=E4=BF=A1
> =E9=80=81=E4=BF=A1=E6=97=A5=E6=99=82: 2021=E5=B9=B412=E6=9C=8816=E6=97=A5=
 8:49
> =E5=AE=9B=E5=85=88: cip-dev
> =E4=BB=B6=E5=90=8D: [cip-dev] New CVE entries in this week
>
> Hi !
>
> It's this week's CVE report.
>
> This week reported ten new CVEs and two of them aren't fixed in the
> mainline yet.
>
> * New CVEs
>
> CVE-2021-0961: In quota_proc_write of xt_quota2.c, there is a possible
> way to read kernel memory due to uninitialized data
>
> CVSS v3 score is not provided
>
> This bug is fixed in Android kernel. There is three commits to fix this b=
ug.
>
> https://android.googlesource.com/kernel/common/+/e113eb454e92
> https://android.googlesource.com/kernel/common/+/60a4c35570d9
> https://android.googlesource.com/kernel/common/+/4b05a506bda0
>
> These commit modified net/netfilter/xt_quota2.c which is Android
> specific source. So this CVE is Android specific bug. The mainline and
> stable kernels aren't affected.
>
> Fixed status
>
> The mainline and stable kernels aren't affected.
>
> CVE-2021-39648: usb: gadget: configfs: Fix use-after-free issue with udc_=
name
>
> CVSS v3 score is not provided
>
> 4.4 kernel gadget_dev_desc_UDC_show() is bit different from later
> kernel versions. However, it looks 4.4 also has same issue.
>
> Fixed status
>
> mainline: [64e6bbfff52db4bf6785fab9cffab850b2de6870]
> stable/4.14: [6766064c794afeacc29b21fc09ea4dbe3cae1af3]
> stable/4.19: [83b74059fdf1c4fa6ed261725e6f301552ad23f7]
> stable/4.9: [225330e682fa9aaa152287b49dea1ce50fbe0a92]
> stable/5.10: [a4b202cba3ab1a7a8b1ca92603931fba5e2032c3]
> stable/5.4: [bcffe2de9dde74174805d5f56a990353e33b8072]
>
> CVE-2021-39656: configfs: fix a use-after-free in __configfs_open_file
>
> Bug introduced commit b0841ee was merged in 5.3-rc8. This commit isn't
> backported to 4.4 so 4.4 isn't affected.
>
> Fixed status
>
> mainline: [14fbbc8297728e880070f7b077b3301a8c698ef9]
> stable/4.14: [4769013f841ed35bdce3b11b64349d0c166ee0a2]
> stable/4.19: [9123463620132ada85caf5dc664b168f480b0cc4]
> stable/4.9: [6f5c47f0faed69f2e78e733fb18261854979e79f]
> stable/5.10: [109720342efd6ace3d2e8f34a25ea65036bb1d3b]
> stable/5.4: [73aa6f93e1e980f392b3da4fee830b0e0a4a40ff]
>
> CVE-2021-39657: scsi: ufs: Correct the LUN used in
> eh_device_reset_handler() callback
>
> CVSS v3 score is not provided
>
> Bug was fixed in 5.11-rc4. so mainline and stable kernels are already fix=
ed.
>
> Fixed status
>
> mainline: [35fc4cd34426c242ab015ef280853b7bff101f48]
> stable/4.14: [30f2a89f9481f851bc68e51a1e7114392b052231]
> stable/4.19: [b397fcae2207963747c6f947ef4d06575553eaef]
> stable/4.4: [a4cdbf4805bfed8f39e6b25f113588064d9a6ac5]
> stable/4.9: [7bbac19e604b2443c93f01c3259734d53f776dbf]
> stable/5.10: [2536194bb3b099cc9a9037009b86e7ccfb81461c]
> stable/5.4: [97853a7eae80a695a18ce432524eaa7432199a41]
>
> CVE-2021-4090: kernel: Overflow of bmval[bmlen-1] in
> nfsd4_decode_bitmap function
>
> CVSS v3 score is not provided
>
> OOB write bug in nsfd. This bug was introduced by commit d1c263a
> ("NFSD: Replace READ* macros in nfsd4_decode_fattr()
> ") since 5.11-rc1 and fixed in 5.16-rc2. Before 5.11 kernels aren't
> affected this issue.
>
> Fixed status
>
> mainline: [c0019b7db1d7ac62c711cda6b357a659d46428fe]
> stable/5.15: [10c22d9519f3f5939de61a1500aa3a926b778d3a]
>
> CVE-2021-4093: KVM: SVM: out-of-bounds read/write in sev_es_string_io
>
> CVSS v3 score is not provided
>
> OOB read/write bug in AMD SVM mode. This bug was introduced by commit
> 7ed9abf ("KVM: SVM: Support string IO operations for an SEV-ES guest")
> which is merged since 5.11-rc1. Before 5.11 kernels aren't affected
> this issue.
>
> Fixed status
>
> mainline: [95e16b4792b0429f1933872f743410f00e590c55]
>
> CVE-2021-4095: KVM: NULL pointer dereference in kvm_dirty_ring_get()
> in virt/kvm/dirty_ring.c
>
> CVSS v3 score is not provided
>
> This issues was introduced by commit 629b534 ("KVM: x86/xen: update
> wallclock region") which is merged in 5.12-rc1-dontuse. Before
> 5.12-rc1-dontuse kernels aren't affectd this issue.
> Patch is being reviewed.
>
> Fixed status
>
> Not fixed yet.
>
> CVE-2021-3864: descendant's dumpable setting with certain SUID binaries
>
> CVSS v3 score is not provided
>
> This bug is able to write coredump file anyware. However, abusing this
> bug, such as arbitrary code execution is required some program. The
> PoC(https://www.openwall.com/lists/oss-security/2021/10/20/2).
> There is two mitigation techniques are suggested. So, users follow
> these mitigation technique is recommended.
>
> Fixed status
>
> Not fixed yet.
>
> CVE-2021-4083: fget: check that the fd still exists after getting a ref t=
o it
>
> CVSS v3 score is not provided
>
> UAF bug in fs/file.c it causes system crash, priviledge escalation.
> The mainline and all stable kernels are aready fixed.
>
> Fixed status
>
> mainline: [054aa8d439b9185d4f5eb9a90282d1ce74772969]
> stable/4.14: [98548c3a9882a1ea993a103be7c1b499f3b88202]
> stable/4.19: [8bf31f9d9395b71af3ed33166a057cd3ec0c59da]
> stable/4.4: [8afa4ef999191477506b396fae518338b8996fec]
> stable/4.9: [a043f5a600052dc93bc3d7a6a2c1592b6ee77482]
> stable/5.10: [4baba6ba56eb91a735a027f783cc4b9276b48d5b]
> stable/5.15: [6fe4eadd54da3040cf6f6579ae157ae1395dc0f8]
> stable/5.4: [03d4462ba3bc8f830d9807e3c3fde54fad06e2e2]
>
> CVE-2021-39685: Linux Kernel USB Gadget buffer overflow
>
> CVSS v3 score is not provided
>
> Buffer overflow bug in USB gadget devices. An attacker can read and/or
> write up to 65k of kernel memory.
> It already fixed in mainline and all stable kernels.
>
> Fixed status
>
> mainline: [153a2d7e3350cc89d406ba2d35be8793a64c2038,
> 86ebbc11bb3f60908a51f3e41a17e3f477c2eaa3]
> stable/4.14: [e7c8afee149134b438df153b09af7fd928a8bc24,
> d8cd524ae4ec788011a14be17503fc224f260fe3]
> stable/4.19: [13e45e7a262dd96e8161823314679543048709b9,
> 32de5efd483db68f12233fbf63743a2d92f20ae4]
> stable/4.4: [93cd7100fe471c5f76fb942358de4ed70dbcaf35,
> af21211c327c4703c7681fa7286c4d660682e413]
> stable/4.9: [d2ca6859ea96c6d4c6ad3d6873a308a004882419,
> e4de8ca013f06ad4a0bf40420a291c23990e4131]
> stable/5.10: [7193ad3e50e596ac2192531c58ba83b9e6d2444b,
> e4de8ca013f06ad4a0bf40420a291c23990e4131]
> stable/5.15: [36dfdf11af49d3c009c711fb16f5c6e7a274505d,
> 6eea4ace62fa6414432692ee44f0c0a3d541d97a]
> stable/5.4: [fd6de5a0cd42fc43810bd74ad129d98ab962ec6b,
> 9978777c5409d6c856cac1adf5930e3c84f057be]
>
> * Updated CVEs
>
> no updated CVEs.
>
> Currently tracking CVEs
>
> CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
> Bluetooth Core Specifications 4.0 through 5.2
>
> There is no fix information.
>
> CVE-2020-26555: BR/EDR pin code pairing broken
>
> No fix information
>
> CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning
>
> No fix information.
>
> CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
> Provisioning Leads to MITM
>
> No fix information.
>
> CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning
>
> No fix information.
>
> CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioni=
ng
>
> No fix information.
>
>
> Regards,
> --
> Masami Ichikawa
> Cybertrust Japan Co., Ltd.
>
> Email :masami.ichikawa@cybertrust.co.jp
>           :masami.ichikawa@miraclelinux.com
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7114): https://lists.cip-project.org/g/cip-dev/messag=
e/7114
> Mute This Topic: https://lists.cip-project.org/mt/87756776/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/452041=
6/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

