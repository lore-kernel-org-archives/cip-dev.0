Return-Path: <SRS0=SWFu=OA=lists.cip-project.org=bounce+64572+6723+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B57DC4167D
	for <cip-dev@archiver.kernel.org>; Fri, 10 Sep 2021 00:41:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5BD611AD
	for <cip-dev@archiver.kernel.org>; Fri, 10 Sep 2021 00:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C5BD611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RTcHYY4521723xl9QgfgIYu6; Thu, 09 Sep 2021 17:41:17 -0700
X-Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web11.2836.1631234474642095013
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Sep 2021 17:41:16 -0700
X-Received: by mail-ot1-f47.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so56321otf.2
        for <cip-dev@lists.cip-project.org>; Thu, 09 Sep 2021 17:41:14 -0700 (PDT)
X-Gm-Message-State: 95viYtWlldu0LSkcuheACtAOx4520388AA=
X-Google-Smtp-Source: ABdhPJyYdp7wusE0ZpcN4N3Nu4cIfniGvcY1ayaBN4qEY5wij4qNr4c3aaorNBi/Y/LFdN643OyhJLhxQrSC59tA380=
X-Received: by 2002:a9d:664d:: with SMTP id q13mr2248208otm.67.1631234473742;
 Thu, 09 Sep 2021 17:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9oqUztiFZjcd0=dSBJ-bDjfdZ4eW8R69=m0fuZmKOb0qg@mail.gmail.com>
 <CAMLqsBZCbrdOaxhuc81kvZsinS+_bFPp2tpmuVnczC1EXCA3Zg@mail.gmail.com>
In-Reply-To: <CAMLqsBZCbrdOaxhuc81kvZsinS+_bFPp2tpmuVnczC1EXCA3Zg@mail.gmail.com>
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Fri, 10 Sep 2021 09:40:38 +0900
Message-ID: <CAODzB9q99XOQh8NZNxTi7bpHM4fJOyXvGrUFu8RcpVnt8KBkaA@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entry this week
To: Derek Weeks <dweeks@linuxfoundation.org>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="kbWC6fNMEzFTXjw30otl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631234477;
 bh=BCeP0tq4XJLLHkxn85Aou3iUUSJ7yp7nPQsDmkvDL2g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wvWRwZ6qlVSY3v543L4F7R3FfTQNedVS6QXo+pJ0Ud98sDrCwF4I3DcLaARQxVgOGPv
 AwQ5hPVCoWHMBxg44oI65ARnxSu4ggvYXt4I2JQTOw8LIH1oeDpE8Ro/90AoZliuXxSeB
 RnO6H6KV6jnUjLgkjLSM2i8yme/pRbQTyoY=

--kbWC6fNMEzFTXjw30otl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi !

(added cip-dev list)

On Thu, Sep 9, 2021 at 10:43 PM Derek Weeks <dweeks@linuxfoundation.org> wr=
ote:
>
> Thanks for sharing this insight.  Do you know if any of these CVE's have =
CVSS ratings?  If so, what were the ratings?
>
>
>

Following list is CVSS scores. Unfortunately some CVEs haven't been
assigned score yet.

CVE Number : CVSS v3 Base Score
CVE-2021-3715: not provided
CVE-2021-3759: not provided
CVE-2021-40490: not provided
CVE-2021-3542: not provided
CVE-2021-3640: not provided
CVE-2021-3739: not provided
CVE-2021-3753: not provided
CVE-2021-3743: not provided
CVE-2021-38198: 5.5(Medium)
CVE-2021-3444: 7.8(High)
CVE-2021-3600: not provided
CVE-2021-3655: 3.3(Low)
CVE-2021-31615: 5.3(Medium)
CVE-2021-3640: not provided
CVE-2020-26555: 5.4(Medium)
CVE-2020-26556: 7.5(High)
CVE-2020-26557: 7.5(High)
CVE-2020-26559: 8.8(High)
CVE-2020-26560: 8.1(High)

> On Wed, Sep 8, 2021 at 10:40 PM Masami Ichikawa <masami.ichikawa@miraclel=
inux.com> wrote:
>>
>> Hi !
>>
>> It's this week's CVE report.
>>
>> This week reported 3 new CVEs. These CVEs have been fixed in mainline
>> and some stable kernels.
>>
>> * New CVEs
>>
>> CVE-2021-3715: kernel: use-after-free in route4_change() in
>> net/sched/cls_route.c
>>
>> This vulnerability was introduced in 3.18-rc1 and fixed in 5.6.
>> Therefore 5.6 or later kernels aren't affect this vulnerability.
>>
>> Fixed status
>>
>> cip/4.19: [ea3d6652c240978736a91b9e85fde9fee9359be4]
>> cip/4.19-rt: [ea3d6652c240978736a91b9e85fde9fee9359be4]
>> cip/4.4: [7518af6464b47a0d775173570c3d25f699da2a5e]
>> cip/4.4-rt: [7518af6464b47a0d775173570c3d25f699da2a5e]
>> mainline: [ef299cc3fa1a9e1288665a9fdc8bff55629fd359]
>> stable/4.14: [f0c92f59cf528bc1b872f2ca91b01e128a2af3e6]
>> stable/4.19: [ea3d6652c240978736a91b9e85fde9fee9359be4]
>> stable/4.4: [7518af6464b47a0d775173570c3d25f699da2a5e]
>> stable/4.9: [97a8e7afaee8fc4f08662cf8e4f495b87874aa91]
>> stable/5.4: [ff28c6195814bdbd4038b08d39e40f8d65d2025e]
>>
>> CVE-2021-3759: memcg: charge semaphores and sem_undo objects
>>
>> This causes DoS attack. Patch was merged into mainline this week.
>>
>> for 4.19, it needs modify or apply following patches to apply commit
>> 18319498fdd4.
>>
>> 4a2ae92993be24ba727faa733e99d7980d389ec0: ipc/sem.c: replace
>> kvmalloc/memset with kvzalloc and use struct_size
>> bc8136a543aa839a848b49af5e101ac6de5f6b27: ipc: use kmalloc for
>> msg_queue and shmid_kernel
>> fc37a3b8b4388e73e8e3525556d9f1feeb232bb9: ipc sem: use kvmalloc for
>> sem_undo allocation
>>
>> for 4.4, need to modify the patch.
>>
>> Fixed status
>>
>> mainline: [18319498fdd4cdf8c1c2c48cd432863b1f915d6f]
>>
>> CVE-2021-40490: A race condition was discovered in
>> ext4_write_inline_data_end in fs/ext4/inline.c in the ext4 subsystem
>> in the Linux kernel through 5.13.13.
>>
>> Commit a54c4613dac1 fixes f19d5870cbf72d4cb2a8e1f749dff97af99b071e
>> which has been merged into 3.8-rc1.
>>
>> Fixed status
>>
>> mainline: [a54c4613dac1500b40e4ab55199f7c51f028e848]
>> stable/5.10: [09a379549620f122de3aa4e65df9329976e4cdf5]
>> stable/5.13: [c764e8fa4491da66780fcb30a0d43bfd3fccd12c]
>> stable/5.14: [f8ea208b3fbbc0546d71b47e8abaf98b0961dec1]
>>
>> * Updated CVEs
>>
>> CVE-2021-3542: media: firewire: firedtv-avc: fix a buffer overflow in
>> avc_ca_pmt()
>>
>> Patch has been sent to linux-media list
>> (https://lore.kernel.org/linux-media/20210816072721.GA10534@kili/).
>> btw, no cip member enables DVB_FIREDTV.
>>
>> Fixed status
>>
>> Not fixed in mainline yet.
>>
>> CVE-2021-3640: UAF in sco_send_frame function
>>
>> According to the SUSE
>> bugzilla(https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth-next.git/commit/?id=3D99c23da0eed4fd20cae8243f2b51e10e66aa0951
>> ), patch has been merged into bluetooth-next tree as of 2021/09/03.
>>
>> Fixed status
>>
>> Not fixed in mainline yet.
>>
>>
>> CVE-2021-3739: btrfs: fix NULL pointer dereference when deleting
>> device by invalid id
>>
>> This vulnerability is not affected before 4.20-rc1.
>>
>> Fixed status
>>
>> mainline: [e4571b8c5e9ffa1e85c0c671995bd4dcc5c75091]
>> stable/5.10: [c43add24dffdbac269d5610465ced70cfc1bad9e]
>> stable/5.13: [301aabe0239f227818622096be7e180fcdbedf80]
>> stable/5.14: [734dabfb6918d399024063c9db9093a83f804ce5]
>> stable/5.4: [d7f7eca72ecc08f0bb6897fda2290293fca63068]
>>
>>
>> CVE-2021-3753: vt_kdsetmode: extend console locking
>>
>> A out-of-bounds caused by the race of KDSETMODE in VT.
>>
>> Fixed status
>>
>> mainline: [2287a51ba822384834dafc1c798453375d1107c7]
>> stable/4.14: [3f488313d96fc6512a4a0fe3ed56cce92cbeec94]
>> stable/4.19: [0776c1a20babb4ad0b7ce7f2f4e0806a97663187]
>> stable/4.4: [01da584f08cbb1e04f22796cc49b10d570cd5ec1]
>> stable/4.9: [755a2f40dda2d6b2e3b8624cb052e68947ee4d1f]
>> stable/5.10: [60d69cb4e60de0067e5d8aecacd86dfe92a5384a]
>> stable/5.13: [a5dfcf3d8ecc549f8dc324ab6caf9dd14de87986]
>> stable/5.14: [acf3c7b4fae092e7f5c170bc8a0fe2ead9b2a320]
>> stable/5.4: [f4418015201bdca0cd4e28b363d88096206e4ad0]
>>
>>
>> CVE-2021-3743: out-of-bound Read in qrtr_endpoint_post in net/qrtr/qrtr.=
c
>>
>> The Qualcomm's IPC router protocol(qrtr) has been introduced since
>> 4.15-rc1 so before 4.15 kernels aren't affected.
>>
>> Fixed status
>>
>> mainline: [7e78c597c3ebfd0cb329aa09a838734147e4f117]
>> stable/4.19: [ce7d8be2eaa4cab3032e256d154d1c33843d2367]
>> stable/5.10: [ad41706c771a038e9a334fa55216abd69b32bfdf]
>> stable/5.13: [d6060df9b53ab8098c954aac9acbacef6915e42a]
>> stable/5.4: [a6b049aeefa880a8bd7b1ae3a8804bda1e8b077e]
>>
>> CVE-2021-38198: KVM: X86: MMU: Use the correct inherited permissions
>> to get shadow page
>>
>> 4.14 has been fixed this week.
>>
>> mainline: [b1bd5cba3306691c771d558e94baa73e8b0b96b7]
>> stable/4.14: [cea9e8ee3b8059bd2b36d68f1f428d165e5d13ce]
>> stable/4.19: [4c07e70141eebd3db64297515a427deea4822957]
>> stable/5.10: [6b6ff4d1f349cb35a7c7d2057819af1b14f80437]
>> stable/5.4: [d28adaabbbf4a6949d0f6f71daca6744979174e2]
>>
>> CVE-2021-3444: bpf: Fix truncation handling for mod32 dst reg wrt zero
>>
>> The vulnerability has been introduced since 4.15-rc9. 4.4 is not affecte=
d.
>> 4.19 has been fixed in this week.
>>
>> Fixed status
>>
>> mainline: [9b00f1b78809309163dda2d044d9e94a3c0248a3]
>> stable/4.19: [39f74b7c81cca139c05757d9c8f9d1e35fbbf56b]
>> stable/5.10: [3320bae8c115863b6f17993c2b7970f7f419da57]
>> stable/5.11: [55c262ea5d0f754648cd25aa73de081adaab07d9]
>> stable/5.4: [185c2266c1df80bec001c987d64cae2d9cd13816]
>>
>> CVE-2021-3600: eBPF 32-bit source register truncation on div/mod
>>
>> The vulnerability has been introduced since 4.15-rc9. 4.4 is not affecte=
d.
>> 4.19 has been fixed in this week.We have been tracking this
>> vulnerability since Aug to watch 4.19 to be fixed, and now it is
>> finally fixed.
>>
>> Fixed status
>>
>> mainline: [e88b2c6e5a4d9ce30d75391e4d950da74bb2bd90]
>> stable/4.19: [1d16cc210fabd0a7ebf52d3025f81c2bde054a90]
>> stable/5.10: [1d16cc210fabd0a7ebf52d3025f81c2bde054a90]
>> stable/5.4: [78e2f71b89b22222583f74803d14f3d90cdf9d12]
>>
>> CVE-2021-3655: missing size validations on inbound SCTP packets
>>
>> cip/4.4, cip/4.19, cip/4.4-rt, cip/4.19-rt, stable/4.14, and
>> stable/5.4 have been fixed this week.
>>
>> Fixed status
>>
>>   mainline: [0c5dc070ff3d6246d22ddd931f23a6266249e3db,
>> 50619dbf8db77e98d821d615af4f634d08e22698,
>>     b6ffe7671b24689c09faa5675dd58f93758a97ae,
>> ef6c8d6ccf0c1dccdda092ebe8782777cd7803c9]
>>   stable/4.19: [c7a03ebace4f9cd40d9cd9dd5fb2af558025583c,
>> dd16e38e1531258d332b0fc7c247367f60c6c381]
>>   cip/4.19: [c7a03ebace4f9cd40d9cd9dd5fb2af558025583c,
>> dd16e38e1531258d332b0fc7c247367f60c6c381]
>>   cip/4.19-rt: [c7a03ebace4f9cd40d9cd9dd5fb2af558025583c,
>> dd16e38e1531258d332b0fc7c247367f60c6c381]
>>   stable/4.4: [48cd035cad5b5fad0648aa8294c4223bedb166dd]
>>   cip/4.4: [48cd035cad5b5fad0648aa8294c4223bedb166dd]
>>   cip/4.4-rt: [48cd035cad5b5fad0648aa8294c4223bedb166dd]
>>   stable/4.9: [c7da1d1ed43a6c2bece0d287e2415adf2868697e]
>>   stable/5.10: [d4dbef7046e24669278eba4455e9e8053ead6ba0,
>> 6ef81a5c0e22233e13c748e813c54d3bf0145782]
>>   stable/4.14: [f01bfaea62d14938ff2fbeaf67f0afec2ec64ab9,
>> d890768c1ed6688ca5cd54ee37a69d90ea8c422f]
>>   stable/5.4: [03a5e454614dc095a70d88c85ac45ba799c79971,
>> a01745edc1c95ff53e261c493f15bb43b1338003]
>>
>> Currently tracking CVEs
>>
>> CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
>> Bluetooth Core Specifications 4.0 through 5.2
>>
>> There is no fix information.
>>
>> CVE-2021-3640: UAF in sco_send_frame function
>>
>> There is no fix information.
>>
>> CVE-2020-26555: BR/EDR pin code pairing broken
>>
>> There is no fix information
>>
>> CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning
>>
>> No fix information.
>>
>> CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
>> Provisioning Leads to MITM
>>
>> No fix information.
>>
>> CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning
>>
>> No fix information.
>>
>> CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provision=
ing
>>
>> No fix information.
>>
>> Other topics.
>>
>> About cve.mitre.org
>>
>> CVE Website Transitioning to New Web Address =E2=80=93 =E2=80=9CCVE.ORG=
=E2=80=9D
>> https://cve.mitre.org/news/archives/2021/news.html#September022021_CVE_W=
ebsite_Transitioning_to_New_Web_Address_-_CVE.ORG
>>
>> Regards,
>>
>> --
>> Masami Ichikawa
>> Cybertrust Japan Co., Ltd.
>>
>> Email :masami.ichikawa@cybertrust.co.jp
>>           :masami.ichikawa@miraclelinux.com
>>
>>=20
>>

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--kbWC6fNMEzFTXjw30otl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6723): https://lists.cip-project.org/g/cip-dev/message/=
6723
Mute This Topic: https://lists.cip-project.org/mt/85476557/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kbWC6fNMEzFTXjw30otl--
