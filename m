Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2662.1794441430489553115
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 15:57:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20260707.gappssmtp.com header.s=20260707 header.b=m5x0EfOy;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.169, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b349d21fd1so27993367b3.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 15:57:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794441429; cv=none;
        d=google.com; s=arc-20260327;
        b=qnd7+iWLmBVdc3iRwNj+ufMx/ALC3BwRRHyihzq3gpgDn2uo1T61Pi1bSPThc9YGQd
         7QRbcAL0Jal8V14OARD0GzXhTt8+x3AVPbRxXLP4XPw9TThUt8LNyTgm08Afy8XhiAqN
         RDLhqld6atthzqFVRGIZu1GOLX6a4bJaRKyE56vBzMTGW3/z9oRZqeV4G2v2mWcX+PzN
         eWNyPsXNWJ5TXPR2O+RWam87eMLEnFgqFihhs56xWZ7iKDzlV3zMpsD8fu+T+AHpLzu1
         itg/qqPs/lX1sjsq3ywgOeZ+twZZtaDhmwRWHGAg3m8Q52dQgc1R5nBUnd3ju7rpUZad
         lkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Qrr/eCBE1jF78l/NZzcWbyeyHIhPsW3sNgfE8fzfNv0=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=I+aibg3ZujCZsVWasE9/AtJm7Y0L2rJ+MuEiOrumndcl4jECyWBITPWZEQArRugeVL
         DfKS6NBFLWF9MhKxSkF/AsAvBeDroHm1VQ49iXP3cljw8GIbXL8yujeF2dnteYOAnEmt
         o+2JQZquB/r20xGtxzZfPLdEtgiFNSgt3ogprXbgOvTkvGnxNE48hWMG/+T21ucpX3NZ
         p5LmJR4HFmEP1Gkdji6pQvh6QT3JNFDeW86CQXfOn757qsEzD7QYzffD/pYBimC8jTiu
         vAiVcHO7kJ3hxQ1vhxx1ykxxEuy/GfKVl3NDBVoTq2iolS5MS15wYbCWjg0Y6iDioWUr
         4vww==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20260707.gappssmtp.com; s=20260707; t=1794441429; x=1795046229; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Qrr/eCBE1jF78l/NZzcWbyeyHIhPsW3sNgfE8fzfNv0=;
        b=m5x0EfOy1z02ZzEKyyKHPq49AD2ExPxX49itK6e4zf4gVEaJD9wkHC1HPFM2v/Z49T
         qiX76sENWEO2Z5QqcRKqUUlZvfkFiw5IW7UMt9LkXzgemWDTvo6LQZssn04djonSjN/6
         h7cDUH9QBMZCMi/soefJ5FSEV3JCDWOgt2B01UoEy53ni5aijfc5saWQ8fVdgM30Wtmp
         xBIHeN/OmuREryfgU9/W1zsE596JbQS5jpQ3NvBGV9zC9CXb2zfdzO140WAgn6uVEnop
         Wat2dfg68X3R2E8DifHvoaGGj8MMKi0kdnXCMXErmpVoi6k0ePpSJQ2X+ylKJEtX2mcw
         blhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794441429; x=1795046229;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qrr/eCBE1jF78l/NZzcWbyeyHIhPsW3sNgfE8fzfNv0=;
        b=iGHDBHcycPetyBH6S4FQ0/dm6yHGlbgNB1sNU4bGyq1U111hlFHhUtdTcfo8gS0Aai
         GD8iSRKhW36aHs7Dn6OoTpj+7EdWZxa3t/sDVhZ0Y5BVFLMZwmq5Ingl07BYuHWkRy59
         FQQ5WVBPgQvicZFdVvVDJ1hFK+HFiqSZT5xDkObpgKDNSMswnzDgkgPIyIEEFFhxBOP4
         5LZ4bR0YTKlSWpPc5teeI6a+3YBSPOR/+VCQypDEICAF9FGrxZTe243ozNAoFhb/IcH1
         TCWLg36l7RsnZ5DOYJcmL+arrEAQmPZcAp4lfvhST0sWZhzlAKVwd/vgKvLuIJ513O9e
         Izwg==
X-Gm-Message-State: APuU4Z+Hf1fZPS97zoiUJ1lFlTx7d7aLpbRLeL/EbwWqkHLecVSaVPcm
	sU93YkKYZPILpWbV6hg+H/DKNGihUcc6G9W1YbDGiGqlWWSwZtLxmOsNMxAe+SdXnxmbe6yKQEQ
	iwxj+fLuKLlSUrH989izxBdT1HfZbG5I4HlWyxmLTu5S1ElOf/32zWnkGKg==
X-Gm-Gg: AYBFou0KB+OmvbixrXJtxInXHa38GEYlY3DaV1kmR2jxzwT5vH9nwHHszNc2B2ZCXOL
	o1O3NCCc/vHHk2gGuKJL70uPMzZ4jbXh887lR6XXMhqOn+EdK8MNFiSG2SjaoYVbT0piZcFcQmX
	D9WeADuEp05SFnVl0Xl+CWMCbyWpX9Pcl5+EOFdJxBU9+yDllVM0OLX8LGMgn1gY8pnI2wyOQPW
	0OU3UNb+OjgASR0s2hwUOGWLSb0mMF8XVg1/rv2pvkbXDKtqDMnDdlmwzLDDXNcvwL2Cov+1UaV
	mAtkYNWcJzJ8G3KgbkgwCzR49jeqFEPZM7JJYcrDwVqQF8GeGA3H6tH9iW0MVV6ydtyF1TNMe0e
	DljCdF5uugk2GlAQrXagmBfCRPVAx9BdgIzBOo8whfchWZ3RFMFjaR1kvvqYeTB+796b3z4bc/b
	cBP6WOUpO0
X-Received: by 2002:a05:690c:9316:b0:8b3:2c71:b338 with SMTP id
 00721157ae682-8b3a81b192fmr19462437b3.82.1794441428714; Wed, 11 Nov 2026
 15:57:08 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Nov 2026 08:56:30 +0900
X-Gm-Features: AclHuK_hVMgPxWcUVzpWh7gs3lWWAvb61WJ1mf69ep-KkjKbHAqNXQV6ukYdku8
Message-ID: <CAODzB9rb+qvRFhe8UcFY2Pt-j82sqgpS=mfc4NbCrbdwww2Tpw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 23:57:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24768

Hi!

It's this week's CVE report.

This week reported 21 new CVEs and 50 updated CVEs.

* New CVEs
CVE-2026-100080: xen-netback: Fix UAF when reading statistics data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100080

Introduced commit is not determined.


Fixed status
mainline: [5fb756f1bbec7a3862dda5d79028bf656271804c]
stable/5.10: [4223b33be49ee09acb6f1d26beb4a36dd3b8d63a]
stable/5.15: [ab9cdf1291be551da999510b30216a2886074d7a]
stable/6.1: [36f858f228e3f955b9336af7f94634747c221518]
stable/6.12: [6cd611d2abdd8623a554e14145f82c1cb4e4467a]
stable/6.18: [37d5a73170579b30e67cc8b19ec69715eea3a6b6]
stable/6.6: [89e534265b62c94749639350200b10370564bb3a]
stable/7.3: [4867687b6ad28ab84bc0811d8f8f9972e769da02]

CVE-2026-100081: xen-netback: defer xenvif_mcast_addr_list_free()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100081

Introduced commit is not determined.


Fixed status
mainline: [bfddc420afe827d9f06458cdf8087cd602f8c9cb]
stable/5.10: [96e05a8ce243e2207704e2e7a6e7d1172730f515]
stable/5.15: [0e786123e46d08d2247ce93a5435e45ed9f4c5d1]
stable/6.1: [990d123d9eaa3ac6c979eed245658676d65ce0db]
stable/6.12: [a6bb2f1fa62c56279bdcdadce28d1310c5e12b62]
stable/6.18: [34f0f63dc6dc11895a17bb5672451b6b11622c99]
stable/6.6: [0d515c409033c8e2a645a781be3ca76ab825fc8c]
stable/7.3: [fb38fc58acb26d74fe8f7b19621fafaae3c040ff]

CVE-2026-100082: xen-blkback: Avoid UAF when reading I/O statistics

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100082

Introduced commit is not determined.


Fixed status
mainline: [a02926f7c89bfc798ee9514e09694ff4279928a1]
stable/5.10: [253cff0526781e28b1b0f9fdacd74ecdc23d3ab7]
stable/5.15: [2c9ccbe0ffcff3615c7ad917c49b67571a41f21c]
stable/6.1: [58ba056991dbcec8a75e6861cb4479ac947b69e6]
stable/6.12: [b764e17313534794aeb99c901869f213e36a16ef]
stable/6.18: [c49934da934cf495faf782aa5d84f413221c9be6]
stable/6.6: [fe9ead8c5bdb752e329cecfecbdb5dfca5e9996b]
stable/7.3: [b0378161c28e77e4d0e2eda3c9433ab4394d2a2f]

CVE-2026-99271: ALSA: line6: Clear prev_fbuf on capture buffer release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99271

Introduced by commit 63e20df ("ALSA: line6: Reorganize PCM stream
handling") in v4.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa118c8f61d59387961d58ffae831c5259a9f222]
stable/6.12: [d063975ed22cdc2cb609a9828e5f658448193606]
stable/6.18: [862d9268f40a6e10cef24eb226e738fb69ce8aa7]
stable/7.3: [22c82f33ff0b68d37041adf1dea5533a5863cd31]

CVE-2026-99272: smb: client: validate the data area in SMB2_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99272

Introduced by commit d8e0503 ("CIFS: Add readpage support for SMB2")
in v3.7-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ec9cdf469dd32bcf33073aeb30c08e9356e0ca1]
stable/7.3: [1ba1937de005e261a8858f45bfef5da7458df94c]

CVE-2026-99273: ksmbd: reserve space for the UTF-16 terminator in stream info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99273

Introduced commit is not determined.Fixed in v7.4-rc1.
Affected code was added by 34061d6b76a ("ksmbd: validate
OutputBufferLength of QUERY_DIR, QUERY_INFO, IOCTL requests") in
v5.15-rc7.

Fixed status
mainline: [a025c4991a7d83edc4dd339e3ea86d8ff6226eca]
stable/6.12: [583ede545a14f275a959772b5e1e50fe3e14b861]
stable/6.18: [06a751809ebd33e95b05bf733697318a17a4872b]
stable/7.3: [0e64f89563164719ceb1aa33f2a8bfd6391fa340]

CVE-2026-99274: smb: client: fix fiemap wild read on empty truncated response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99274

Introduced by commit 2f3ebab ("cifs: add fiemap support") in v5.2-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5baa17a0f316c235d61623ac8e8fb32c2b3c0cc]
stable/6.12: [8e0d425b808c367f5033eb72aa4528ae18473627]
stable/6.18: [4a426ca5be7e3dedbe76575b967db04fbf01136f]
stable/7.3: [31f6dbb29fe17fa9595c7e8b19fd92915b03a4ca]

CVE-2026-99275: smb: client: reject short SESSION_SETUP responses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99275

Introduced by commit 5478f9b ("CIFS: Add session setup/logoff
capability for SMB2") in v3.6-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d8930afa3446041358a7db33e7b23a0bb9459b5]
stable/7.3: [df63e01933886153e40706483b9635b2456ad91f]

CVE-2026-99276: ksmbd: defer connection scavenging while session locks are busy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99276

Introduced by commit d7fd1f9 ("ksmbd: follow SMB2 session expiration
semantics") in v7.3-rc4.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4bae7af1154089be87c7475218264fcbfd16d10]
stable/7.3: [4e4e8b38994a0b0fc23f00ca6698b469a41abe70]

CVE-2026-99277: ksmbd: hold a connection reference for each session channel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99277

Introduced by commit d7fd1f9 ("ksmbd: follow SMB2 session expiration
semantics") in v7.3-rc4.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [add8d7fb04efe564193df73581889c62fc0016f1]
stable/7.3: [4b333aed69cfc2c8687b86b6a4364a0dffc16dd8]

CVE-2026-99278: ksmbd: limit sessions on each connection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99278

Introduced by commit d7fd1f9 ("ksmbd: follow SMB2 session expiration
semantics") in v7.3-rc4.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc6aa1ba8b7fff8800ad9bf143f17d308e02ec68]
stable/7.3: [94f8462fc9d5332bc54e91605003c17381e9171a]

CVE-2026-99279: ksmbd: reclaim ended sessions on logoff and expiration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99279

Introduced by commit d7fd1f9 ("ksmbd: follow SMB2 session expiration
semantics") in v7.3-rc4.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26534ef335e92b028eb58e44d98d46a0e26af0ec]
stable/7.3: [1767a5e45dbf6a3b12105196dda4fb0ef80b9698]

CVE-2026-99280: ksmbd: drain session procfs readers before dropping
table references

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99280

Introduced by commit d7fd1f9 ("ksmbd: follow SMB2 session expiration
semantics") in v7.3-rc4.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c087cf7d5386c708d8984b263280b42b3daada0]
stable/7.3: [6789f0983f8e85ce3a5ed8c50fc05d613ead9c2c]

CVE-2026-99281: tun: Require CAP_NET_ADMIN to attach to an ownerless device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99281

Introduced by commit ca6bb5d ("[NET]: Require CAP_NET_ADMIN to create
tuntap devices.") in v2.6.20.16.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffdf678dd16610e3f006dac904bd37c09684673c]
stable/6.12: [e0d98aab41b79b88609f33fb4d8e7a80ab8f648d]
stable/6.18: [2f92c0286cfd58bff9d6d54c01a771073d5eb775]
stable/7.3: [e53d1cf05da8ea58a5743b7ce5894fb51b0b9700]

CVE-2026-99282: net/sched: sch_teql: fix use-after-free on lower qdisc drop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99282

Introduced by commit 572a9d7 ("net: allow to propagate errors through
->ndo_hard_start_xmit()") in v2.6.33-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [782d6bb8f9b8e9d8591181662222bf74cd3ecf79]
stable/6.12: [8d5f768780e26cb82c389219ae7fdb1cd7255421]
stable/6.18: [fc55d92ae6a4b2e7d062cad6d4c67f6b061d9cde]
stable/7.3: [2702ae318630787c640ec0d0403ffd9d95c43e9e]

CVE-2026-99283: netfilter: conntrack: tcp: use UNACK timeout for
non-closing RST packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99283

Introduced commit is not determined.Fixed in v7.3-rc1.


Fixed status
mainline: [bf80e6802273a900311b44e47c9b1a59c6d2473c]
stable/6.12: [4d39a039d0b7737f8475c2431f18572b3b186a3b]
stable/6.18: [0c6d33329960b2d884a399196c8403643d8a9de6]

CVE-2026-99284: net: skbuff: propagate shared-frag marker in skb_zerocopy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99284

Introduced by commit af2806f ("net: Export skb_zerocopy() to zerocopy
from one skb to another") in v3.14-rc1.
Introduced by commit f4c50a4 ("xfrm: esp: avoid in-place decrypt on
shared skb frags") in v7.1-rc3.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [79dc34beb1fdb3da79753e51e15c68591a2561fe]
stable/6.12: [fe8477e23dd2ee6bce231d65f2586a333b211dc0]
stable/6.18: [1c623e3cbf43f12dd4a72712079bfa247a9b8ba3]
stable/7.3: [1a9c180cd8435917b7516edfb1c9148032c28773]

CVE-2026-99285: netfilter: nft_byteorder: remove multi-register support

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99285

Introduced by commit c301f09 ("netfilter: nf_tables: fix pointer math
issue in nft_byteorder_eval()") in v6.7-rc2.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [bb061d3de41707415269be75ebf700efb03ec212]
stable/6.12: [3c5fb3a6c8118d15e60295e76fb5b879021eef43]
stable/6.18: [dc29c0478b8564feb9371e715b5a0016eb8903fd]

CVE-2026-99286: xen-netback: Fix XenBus connection failure cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99286

Introduced commit is not determined.
Introduced by 5fb756f ("xen-netback: Fix UAF when reading statistics
data") in v7.4-rc2.
Bug introduced commit was backported to following branches.
stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6 stable/7.3

Fixed status
mainline: [dc6d814562b65813556933dbda1015cef61dabf8]
stable/6.12: [ade3082dcdee17c5767069883936d64ff83f6c9f]
stable/6.18: [a97aa838903d15f865d80809f5198ff459c6634a]
stable/7.3: [07aca7d25ce8578fedde49855983a01c537a782b]

CVE-2026-99287: xen-netback: Zero out sring pointers on unmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99287

Introduced commit is not determined.
Introduced by 2ac061c ("xen/netback: cleanup init and deinit code") in v5.5-rc1.

Fixed status
mainline: [f96f16592a32430a0582309d73a873b6d3ee2bdb]
stable/6.12: [87fd475dc4e354088f6534285388e7b061f54b35]
stable/6.18: [c5f54af611ff6fe1d53fa05d8e87b469dc56122b]
stable/7.3: [e7ba61734d6ad6adfd5bf617052e590743211669]

CVE-2026-99288: inet: reject unhashed sockets during established lookups

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99288

Introduced commit is not determined.
Introduced by 079096f ("tcp/dccp: install syn_recv requests into ehash
table") in v4.4-rc1.

Fixed status
mainline: [4e2b3ef19e0e04adca38442f07dd6bc93c712bf1]
stable/6.12: [d69100340b4cae08d40f898f1b601032403f6be6]
stable/6.18: [8e5172cbd227fae32f3313cba1f3e1b9edb5c4fd]
stable/7.3: [eb8a2d156f2c1d862fffdfd1b3432bfbcd939879]


* Updated CVEs
CVE-2026-80668: netfilter: nf_conntrack_expect: use conntrack GC to
reap expectations

stable/6.18 was fixed.

Fixed status
stable/6.18: [bc6b1da681abe631ed21b7fdced48546189d64a4]

CVE-2026-89755: mm/migrate_device: clear stale mapping after freeing swapcache

stable/6.18 was fixed.

Fixed status
stable/6.18: [c9c29481d5d4a985a57ece2090a324ba48e362a7]

CVE-2026-97538: hwmon: (asus_rog_ryujin) Validate HID report lengths

stable/6.18 was fixed.

Fixed status
stable/6.18: [49cc6d5c00a7f75540d1a4324e01be4067ee652c]

CVE-2026-98176: drm/amdkfd: Avoid integer underflow with ffs in EOP
ring size calc

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [1ab281c7ce2dc5195d337f2c16e22eba356b47f9]
stable/6.18: [9e8f43579f849fba0dd1059160f50bd44a767366]

CVE-2026-98177: drm/amdkfd: Avoid integer underflow in EOP ring size
calculation.

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [85f2d80a260f2ee90647da094b80a2d5ce719750]
stable/6.18: [3c97f7cb6c48826663648b6081b614c2befc8ac7]

CVE-2026-98228: mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from CONFIG_EYEQ

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [8a9a8dfab8f6fb3b85859fb021e4275fadd59ad1]
stable/6.18: [5802a9fda4cede6af31a3e3b171480c0e446703c]

CVE-2026-98439: smb/server: cancel async requests when closing connection

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [2a6ad0d06934628f10fb53513921efbb42e44745]
stable/6.18: [bbcfc51648fbf32f8c899163b0851fa812628080]

CVE-2026-98449: smb: client: delete compound mids on send failure before unlock

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [36a2ba21d38a86bae84441e4c8d5b10653ef341a]
stable/6.18: [59d30bdc3dd6fd3a8990f59bc7a137b1cbb3ed4e]

CVE-2026-98682: smb: client: drain and invalidate before server-side copy/clone

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [6e7a06704457594f06e4ea58a17a5d162ccc735c]
stable/6.18: [e97dac26ed2cce04f9d159cc99e1eca828c5d49e]

CVE-2026-98685: smb: client: discard post-EOF pagecache when extending
a file via clone range

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [eba974d6c850e77db87f6f9ae343164227dffefc]
stable/6.18: [7beb2f2a58023b2ff28fd52bdb72bed74257ee04]

CVE-2026-98692: thunderbolt: Make the DP tunnel activation callback mandatory

stable/6.18 was fixed.

Fixed status
stable/6.18: [39a2c4e5e606cf49b83595971b449b3fb80743c6]

CVE-2026-98714: KVM: SVM: Update control fields on #VMEXIT if and only
if VMRUN succeeded

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [2e9b8c79ae6c1dcf650ea288cf8fc69ee5241dd9]
stable/6.18: [5d06e2f861d61a03481348378fdf9cc3e68bff47]

CVE-2026-98715: KVM: SVM: Preserve TLB control (i.e. pending TLB
flush) on failed VMRUN

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [bfe48e689ba011d3d6cf8adcca03072aa0430133]
stable/6.18: [f2bd7cf6a83e49c710e2b93d3064fa0ebb7e0006]

CVE-2026-98786: drm/amd/display: guard dc_sink dereferences in MST
mode validation

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [0189f725242087679bc9f1bbf77ad086f56a72c8]
stable/6.18: [5684a6c24c0d7c40ef2c4ccb3e4a64cffe76a791]

CVE-2026-99076: ipv6: udp: Create exceptions before socket matching

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [9b88f0fcbd4b746de0478b4fd99fa495eb26b857]
stable/6.18: [fc1fc874ceed4db566a5efbff39313d3d91d424a]

CVE-2026-99109: smb: client: reject SetEA requests that do not fit the
request buffer

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [bc737f5f5cc3fcd10bd919527cacc0efd703c30b]
stable/6.18: [79345a5d14b851e9ed28d3a9fe53301661dbcf11]

CVE-2026-99172: ipc: drop the mqueue mount with kern_unmount() on setup failure

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [4dd36cf72d2c6c090958c0d7b542fa8211635d2d]
stable/6.18: [4aef6ceb4d6acacd53bc047ac4849677c3edbec1]

CVE-2026-99183: accel/rocket: search every core slot when looking up a scheduler

stable/6.18 was fixed.

Fixed status
stable/6.18: [16c95870c95f2a3d78c81b9fbc0645f4b7178c11]

CVE-2026-99228: io_uring/io-wq: don't lose the signal that ends work

stable/7.3 was fixed.

Fixed status
stable/7.3: [7df9a3b5eda51c512d3dd138e3b7daa525071757]

CVE-2026-99229: io_uring/wait: don't spin on a stuck overflow list

stable/7.3 was fixed.

Fixed status
stable/7.3: [340944e27b4bb218ed0ee66d0947ac70faefa05a]

CVE-2026-99230: io_uring/cmd: don't leave list poison in ->hash_node

stable/7.3 was fixed.

Fixed status
stable/7.3: [c4fe1024b2f3f40f8010591a0c0ad541e2883eda]

CVE-2026-99231: io_uring/waitid: own the request before clearing ->head

stable/7.3 was fixed.

Fixed status
stable/7.3: [6e11ce129b34fb9a43b2bbe838df49ea52878d5c]

CVE-2026-99253: io_uring/cancel: rearm local work wake up before sleep

stable/7.3 was fixed.

Fixed status
stable/7.3: [58ddf0ec707093206a5fe814581ec5aefac8b08a]

CVE-2026-99254: io_uring: don't flood a cancelling task with task_work

stable/7.3 was fixed.

Fixed status
stable/7.3: [f334e79a11e084713e82402b1a7a0e321526992a]

CVE-2026-99255: io_uring/io-wq: don't hide a link from cancellations

stable/7.3 was fixed.

Fixed status
stable/7.3: [59e45f44c3cea9f4b2d099171c3cec1d25c5b638]

CVE-2026-99270: tcp: Fix potential UAF in reqsk_timer_handler().

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [f7fba81b00699360f96ed7d9a47b8c801e74c6f9]
stable/6.18: [b3b56e95f6fad7fa7281450b443e861d82616fdb]

CVE-2026-89556: module: validate string table section types

stable/6.12 was fixed.

Fixed status
stable/6.12: [db07e9b0320e480f05f5c12e8e4d6699f0d3acb7]

CVE-2026-89866: media: chips-media: wave5: Resume device before setting EOS flag

stable/6.12 was fixed.

Fixed status
stable/6.12: [9c757d77a6eb58ca4a47cada5ab60451e6c2d247]

CVE-2026-92499: ext4: validate readdir offset before accessing dirent

stable/6.12 was fixed.

Fixed status
stable/6.12: [094e8139cf5a5e37b363ac984f628359558415e6]

CVE-2026-93241: memcg: bypass the reclaim and oom killer for dying
tasks once oom_reaper is done

stable/6.12 was fixed.

Fixed status
stable/6.12: [76d36aa4d2eaf74896711abfb4563b0c8b85292d]

CVE-2026-98180: drm/msm: RCU-free the scheduler-containing ring and VM objects

stable/6.12 was fixed.

Fixed status
stable/6.12: [0ba7c696eea3af41ac4712197566a7b94eedc637]

CVE-2026-98389: drm/amdgpu: skip gfx switch_power_profile during GPU reset

stable/6.12 was fixed.

Fixed status
stable/6.12: [9e3ea03feed2b58bd09c85ed37ba1943b2a0bac3]

CVE-2026-98408: watchdog: rzv2h: Avoid division by zero

stable/6.12 was fixed.

Fixed status
stable/6.12: [96ad5311ff75d374430ec82a1843bcb193145c93]

CVE-2026-98466: KVM: arm64: Transfer the hyp stack pages out of the host stage-2

stable/6.12 was fixed.

Fixed status
stable/6.12: [6c7b5eb6f7f424f5b82d0f9469a5f5adcdf4d973]

CVE-2026-98674: iio: adc: adi-axi-adc: Initialize state mutex

stable/6.12 was fixed.

Fixed status
stable/6.12: [e5e28b0cd56249d1a45155ee6b656c1bbd8a2b3e]

CVE-2026-98683: smb: client: flush dirty data before zeroing a range

stable/6.12 was fixed.

Fixed status
stable/6.12: [1506390a788c45af11008adc91a38dfb5beaf03c]

CVE-2026-98684: smb: client: flush and commit data before querying
allocated ranges

stable/6.12 was fixed.

Fixed status
stable/6.12: [6787575545cd8af1da3778d7c1ae43a4398a6b26]

CVE-2026-98853: net: gso: limit recursive IP-in-IP segmentation

stable/6.12 was fixed.

Fixed status
stable/6.12: [cadffc83ee1a560d5cd18e6d607c1d76f6fd4bd4]

CVE-2026-98863: KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting
said pages fails

stable/6.12 was fixed.

Fixed status
stable/6.12: [1e231eedb0c5aafdc8d96a816ec75554aa69004d]

CVE-2026-98920: netfs: Fix missing alloc tagging of direct mempool allocations

stable/6.12 was fixed.

Fixed status
stable/6.12: [6ba3d758cd40888908f96d68d69322dad65a871e]

CVE-2026-98978: namespace: never expire a locked mount

stable/6.12 was fixed.

Fixed status
stable/6.12: [6c8013ea84fcc51cf26aa870b61b5388c7196ed5]

CVE-2026-98989: namespace: check a recursive bind mount for mount
namespace loops

stable/6.12 was fixed.

Fixed status
stable/6.12: [b82f3c1131456537a514595c3991b62652507c9d]

CVE-2026-98996: fs: don't silently unmount busy mounts

stable/6.12 was fixed.

Fixed status
stable/6.12: [97c9ca40b67eafbe61a253e28cd51dddb7c6bec4]

CVE-2026-99021: regulator: of: fill in supply names in
of_regulator_bulk_get_all()

stable/6.12 was fixed.

Fixed status
stable/6.12: [a5f43540e14589b53f80306d25c043c0abdcbca0]

CVE-2026-99026: net: team: free skb when broadcast has no txable port

stable/6.12 was fixed.

Fixed status
stable/6.12: [aec1d35d76ad883bae83c24707010115f38d02ac]

CVE-2026-99086: dm-integrity: validate the superblock on resume

stable/6.12 was fixed.

Fixed status
stable/6.12: [0499b6d1c9d4477d6538b88c30f9d0c1a28b3e75]

CVE-2026-99087: dm-integrity: fix NULL pointer dereference when the
'R' flag is used

stable/6.12 was fixed.

Fixed status
stable/6.12: [73e5b7b14df0430ef2135e9bd9fa3f5b253ef789]

CVE-2026-99122: vsock/vmci: validate packet source for connected sockets

stable/6.12 was fixed.

Fixed status
stable/6.12: [cdd1f99eaa4d4db82d506eb50e724460671c7cac]

CVE-2026-99146: drm/i915/dmc: Add sanity check for DMC load address

stable/6.12 was fixed.

Fixed status
stable/6.12: [fe48b4c48d4131192a10bc6ea526a8a36b345501]

CVE-2026-99240: mm/damon/core: error damos_commit_quota_goal() for
zero target_value

stable/6.12 was fixed.

Fixed status
stable/6.12: [7ccd2e123e16f6e92bff0a8f797d938eb4ee388f]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com
